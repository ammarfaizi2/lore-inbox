Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135829AbRD2QW6>; Sun, 29 Apr 2001 12:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135838AbRD2QWq>; Sun, 29 Apr 2001 12:22:46 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:10513 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S135824AbRD2QVd>; Sun, 29 Apr 2001 12:21:33 -0400
Date: Sun, 29 Apr 2001 09:21:31 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <3AEBF782.1911EDD2@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2001, Jeff Garzik wrote:

> "H. Peter Anvin" wrote:
> > We discussed this at the Summit, not a year or two ago.  x86-64 has
> > it, and it wouldn't be too bad to do in i386... just noone did.
>
> It came up long before that.  I refer to the technique in a post dated
> Nov 17, even though I can't find the original.
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg13584.html
>
> Initiated by a post from (iirc) Dean Gaudet, we found out that
> gettimeofday was one particular system call in the Apache fast path that
> couldn't be optimized well, or moved out of the fast path.  After a
> couple of suggestions for improving things, Linus chimed in with the
> magic page suggestion.

heheh.  i can't claim that i was the first ever to think of this.  but
here's the post i originally made on the topic.  iirc a few folks said
"security horror!"... then last year ingo and linus (and probably others)
came up with a scheme everyone was happy with.

i was kind of solving a different problem with the code page though -- the
ability to use rdtsc on SMP boxes with processors of varying speeds and
synchronizations.

-dean

>From dgaudet-list-linux-kernel@arctic.org Sun Apr 29 09:14:20 2001
Date: Mon, 11 May 1998 18:28:46 -0700 (PDT)
From: Dean Gaudet <dgaudet-list-linux-kernel@arctic.org>
To: linux-kernel@vger.rutgers.edu
Subject: Re: do_fast_gettimeoffset oops explained
X-Comment: Visit http://www.arctic.org/~dgaudet/legal for information
    regarding copyright and disclaimer.

On 12 May 1998, Linus Torvalds wrote:

> And if you wonder why we care, then the reason is simple: there are
> real-world cases where a large fraction of our CPU time is spent getting
> timestamps.  The reason gettimeofday() was optimized is that it actually
> showed up very clearly on system profiles.
>
> For example, X tends to timestamp each and every event it gets.  And
> getting accurate benchmark numbers implies having an accurate clock: the
> "fast" gettimeoffset is not only 5 times faster than the slow one, it
> also gives more precision because it doesn't have to go outside the
> (fast and accurate) CPU to the (slow and less accurate) timer chip.

apache w/NSPR threading is doing gettimeofday() left and right too (it's
used after poll() to figure out how much time elapsed)... so much that
I was talking to Ingo about ways to make it faster... and came up with
a user-space method of using RDTSC which can handle changes to the
system clock.  In a nutshell it requires a /dev/calibrate (or whatever
you want to call it) which is mmappable -- you need the "epoch" value (the
time that cycle 0 occured at), and the "cycles per microsecond" value.

I suppose that isn't too revolutionary... what had me stumped for a
while though, was how to do this on SMP boxes, I was assuming their
TSCs weren't synchronized (Ingo tells me they are on Intel).  In case it
happens elsewhere, here's my idea.  Use a separate v->p mapping for the
/dev/calibrate page on each processor.  It's marked read-only of course.
In order to handle atomicity (can't take a task switch while in the
middle of using the "epoch" and "cycles per microsecond" constants), put
the code which actually calculates the time of day on the /dev/calibrate
page itself.  The kernel notices EIP on this page when it's switching
away from a task, and completes the call in the kernel prior to switching.
(It only needs to futz the stack a bit -- unroll a stack frame and set
edx:eax... it can do it right in the saved registers.)

Note that this trick provides for more "user space system calls"... I
imagine a bunch of the signal routines such as sigprocmask and sigaction
could actually be done through routines on a special read-only page.
The kernel deals with atomicity only when it needs to.

Dean


