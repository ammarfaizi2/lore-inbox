Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265441AbRFVPIv>; Fri, 22 Jun 2001 11:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbRFVPIl>; Fri, 22 Jun 2001 11:08:41 -0400
Received: from lxmayr6.informatik.tu-muenchen.de ([131.159.44.50]:31929 "EHLO
	lxmayr6.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S265441AbRFVPIX>; Fri, 22 Jun 2001 11:08:23 -0400
Date: Fri, 22 Jun 2001 17:08:17 +0200
From: Ingo Rohloff <rohloff@in.tum.de>
To: Andi Kleen <ak@suse.de>
Cc: jari.ruusu@pp.inet.fi, linux-kernel@vger.kernel.org
Subject: Re: Loop encryption module locking bug (linux-2.4.5).
Message-ID: <20010622170817.A17038@lxmayr6.informatik.tu-muenchen.de>
In-Reply-To: <20010621135043.A13107@lxmayr6.informatik.tu-muenchen.de.suse.lists.linux.kernel> <ouppubyxb4l.fsf@pigdrop.muc.suse.de> <3B333180.A804582F@pp.inet.fi> <20010622135942.A1591@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010622135942.A1591@gruyere.muc.suse.de>; from ak@suse.de on Fri, Jun 22, 2001 at 01:59:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Locking twice? But what happens if some program calls loop_set_status more
> > than once? Losetup doesn't, but if such program exists, locking is still
> > screwed.
> 
> No, it calls loop_release_xfer always before init_xfer, which will release
> the "permanent" use count.
Calling lock twice in loop_set_status is not good, as long as you
don't call unlock twice too (in case that you change the transfer function):

losetup -e twofish /dev/loop0 file1 results in:

loop_open       // lock not called, because no cipher selected: lock 0
loop_set_fd     // has first to be bounded to file1
loop_set_status // lock called 2 times: lock 2
loop_release    // unlock called: lock 1

so far so good. Now write a program that uses the same
(already configured) loop device and changes the password
(without changing the underlying file):
loop_open        // lock called, because cipher selected: lock 2
loop_set_status  // unlock called once, lock called twice: lock 3
loop_release     // unlock called: lock 2

repeat this and the lock count will increase towards infinity.

or write a program which changes the transfer function
(without changing the underlying file):
loop_open       // lock called, because cipher selected: lock1 2
loop_set_status // change transfer func:
                // unlock called for transferfunc1 once
                // lock called for transferfunc2 twice
                // lock1 1, lock2 2
loop_release    // lock1 1, lock2 1

Result: completely unused cipher module is locked. 

> It's really only locking once; the issue is that it needs to keep the count
> increased while a loop device references a filter module. The other locking
> between open/release is just temporary.

A scheme in which loop_open and loop_release call lock and unlock
for the transfer function has the problem, that conceptually the
transfer function might change between a loop_open and loop_release call.
(It might even change more than once!).

If you call lock AND unlock twice in "set_status" you can resolve
this problem, but this is simply "double" locking for no clear 
benefit. It only means that the locking count of a transfer function
is calculated this way: 
Number of loop devices which use this function +
Number of open file descriptors of loop devices which use this function.

IMHO a transfer function doesn't belong to the application which opens 
a loop device, but to the loop device itself.

I probably didn't explain it that well in my first posting, but 
after applying the proposed patch, a transfer function stays locked, 
as long as a loop device has a reference to it; the locking count only
is not influenced any longer by "lo_open" and "lo_release".

Locking and unlocking is done via "set_status" and unlocking is also done
via "clr_fd". So the semantic is, that a loop device can only have a transfer
function as long as it is bound. ("set_status" checks this when you try
to configure the loop device for encryption.)

so long
  Ingo

PS: Lets see if I understand the SMP issue correctly:
    Imagine that two processor access two different loop devices
    which use the same transfer module (it has to be two different
    loop devices, because the loop devices are protected against
    multi processor use).
    Then it is possible that two processors call the same
    functions in the transfer module, which in turn access the same
    global module variable, without synchronizing this accesses.
    So we have lots of races right ?
