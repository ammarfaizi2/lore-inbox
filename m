Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272684AbTHKOHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272627AbTHKOG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:06:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30984 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S272684AbTHKOEp (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 11 Aug 2003 10:04:45 -0400
Date: Mon, 11 Aug 2003 10:06:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>,
       mlist-linux-kernel@nntp-server.caltech.edu
Subject: Re: volatile variable
In-Reply-To: <1060608783.19194.13.camel@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.53.0308110944350.17240@chaos>
References: <20030801105706.30523.qmail@webmail28.rediffmail.com> 
 <Pine.LNX.4.53.0308010723060.3077@chaos> <1060608783.19194.13.camel@passion.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, David Woodhouse wrote:

> On Fri, 2003-08-01 at 12:38, Richard B. Johnson wrote:
> > First, there are already procedures available to do just
> > what you seem to want to do, interruptible_sleep_on() and
> > interruptible_sleep_on_timeout(). These take care of the
> > ugly details that can trip up compilers.
>
> Just in case there are people reading this who don't realise that
> Richard is trolling -- do not ever use sleep_on() and friends. They
> _will_ introduce bugs, and hence they _will_ be removed from the kernel
> some time in the (hopefully not-so-distant) future.
>

The linux-2.4.20 contains 516 references to "sleep_on" in the
`drivers` tree. This is hardly a function or macro that will
be removed. If there are bugs, they will be fixed, not removed.

Any driver that makes its own 'sleep until' function is fundamentally
broken. A driver should not 'know' about 'schedule()' or any
other such thing. This violates a fundamental rule about keeping
opaque operations and/or functions opaque. If course, older
drivers do 'know' about schedule(), but that doesn't make them
correct. If you intend to replace these 'sleep until' operations,
then that's wonderful. However, until you do, it would not be
wise to ask anybody to roll their own.

And, if you are actually making a replacement, it should be
a function, not a macro. This will save a lot of space. Anything
that is going to wait is not going to be hurt by the call/return
overhead.

> > In any event in your loop, variable 'a', has already been
> > read by the code the compiler generates. There is nothing
> > else in the loop that touches that variable. Therefore
> > the compiler is free to (correctly) assume that whatever
> > it was when it was first read is what it will continue to
> > be. The compiler will therefore optimise it to be a single
> > read and compare. So, the loop will continue forever if
> > 'a' started as zero because the compiler correctly knows
> > that it cannot possibly change in the only execution
> > path that it knows about.
>
> If 'a' is a local variable that's true. If 'a' is a global as the
> original poster explicitly declared, then the compiler must assume that
> function calls (such as the one to schedule()) may modify it, and hence
> may not optimise away the second and subsequent reads. Therefore, the
> 'volatile' is not required.
>

Again, this is incorrect. If you look at the declaration of schedule(),
you will note "asmlinkage void schedule(void);". Now look up
"asmlinkage"
#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))

The regparm(0) atttibute tells gcc that schedule() will get any/all
of its parameters in registers. Since schedule() receives no parameters,
that means that, as far as gcc is concerned, it cannot modify
anything. That said, this may be a bug or it may have been added
to work around some gcc bug. But, nevertheless, as the declaration
stands, schedule() will never modify anything because somebody told
gcc it won't.


> Richard, stop taunting the newbies :)
>
> --

Ditto:


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

