Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263081AbSJTJN3>; Sun, 20 Oct 2002 05:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263106AbSJTJN3>; Sun, 20 Oct 2002 05:13:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54315 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263081AbSJTJN2>; Sun, 20 Oct 2002 05:13:28 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, eblade@blackmagik.dynup.net, mochel@osdl.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210200701.AAA02683@adam.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Oct 2002 03:17:44 -0600
In-Reply-To: <200210200701.AAA02683@adam.yggdrasil.com>
Message-ID: <m1of9pwjt3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> Eric W. Biederman wrote:
> >Hopefully I am not coming off harsh but I am a little cranky this
> >morning,  As before this change I thought things on the device side
> >were pretty much under control they just needed a little stabilization
> >and testing.  And now someone possibly me has to go through every
> >driver and write a shutdown method because someone figured calling
> >free was expensive.
> 
> 	I think I've essentially refuted this in parts of previous
> messages on this thread that Eric has basically ignored in his
> responses.

About free, and the interface I don't much care.  Except that I care
that it is clean, and that device_shutdown does not get neutered.  My
current complaint is now that the interface in 2.5.44 changed it is
ill specified, and setup in a way so that the code will rarely get
tested, and when it is tested it will be tested in a way that is
likely to not expose problems.

But judging from my experience with etherboot, and by the bug reports
I have coming in there is a lot of work where I need to get drivers to
shut themselves down.

There are two cases on reboot.
A) eventually the BIOS toggles the machine Reset line,
   common but not guaranteed to happen.
B) Whatever we call on reboot does not toggle the reset line.

> 	Interested readers should check the previous lkml messages
> with this subject line.  Of particular relevance to this issue, see my
> list of three advantages of the 2.4.x approach of not calling
> unnecessary device-specific shutdown sequences in my message at

Breaking it up is fine, but a real pain.

> http://marc.theaimsgroup.com/?l=linux-kernel&m=103481960911183&w=2,
> where I pasted in a response on the same issue that I originally
> wroted in this thread to Eric Blade (after the paragraph that begins
> "Changing the interface will reduce coplexity as only the code that
> needs to be executed will be called."). 

Not calling the same code in rmmod is wrong because then the is hard
to test.  Without that the code only gets tested when someone is
likely to toggle the reset line on the device anyway, trivially hiding
bugs.  running rmmod and insmod a bunch of times makes a good test for
this kind of thing, and is likely to happen during driver development.

With respect to the embedded case, embedded machines are more likely
to see this problem than desktop machines, on an ordinary reboot.  But
for code bloat I don't have a problem if there is a compile option
that totally removes device_shutdown, to save space.  So long as it
works when it is enabled.

And I do agree that running the bare minimum can increase reliability
in some cases as Eric Blade pointed.  But I don't want an interface
that is optimized for buggy drivers.  We have the source so we can fix
them.

>  Also of interest is Richard
> B. Johnson's example of BIOS reset code that shuts off the PCI bus
> before touching any RAM at
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103462697923792&w=2.

Yes the BIOS work around because some OS's don't shut down their
devices.

> 	I'm willing to get into this in detail again upon request.
> Otherwise, I think it would be a better use of everyone's time not to
> subject linux-kernel readers to an infinite loop.

Mostly I want a comment from Patrick Mochel why he made the change,
and roughly what he was thinking.  So I have a good idea about which
code I need to dig into and send patches to fix.  If he makes a good
case for an independent shutdown, method I am fine with that, just
every driver in the kernel needs to change, and that is a heck of a
lot of work before 2.6.  Otherwise we can go back to calling remove.

Eric
