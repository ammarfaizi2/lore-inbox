Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbRGSLm6>; Thu, 19 Jul 2001 07:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbRGSLms>; Thu, 19 Jul 2001 07:42:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:36737 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267539AbRGSLmi>; Thu, 19 Jul 2001 07:42:38 -0400
Date: Thu, 19 Jul 2001 07:41:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alex Ivchenko <aivchenko@ueidaq.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM SOLVED: 2.4.x SPINLOCKS behave differently then 2.2.x
In-Reply-To: <3B5615E8.B838D6BD@ueidaq.com>
Message-ID: <Pine.LNX.3.95.1010719073742.3331A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 18 Jul 2001, Alex Ivchenko wrote:

> Richard,
> 
> Linus Torvalds <torvalds@transmeta.com> wrote:
> > 
> > Richard B. Johnson <root@chaos.analogic.com> wrote:
> > >    ticks = 1 * HZ;        /* For 1 second */
> > >    while((ticks = interruptible_sleep_on_timeout(&wqhead, ticks)) > 0)
> > >                  ;
> > Don't do this.
> >
> > Imagine what happens if a signal comes in and wakes you up? The signal
> > will continue to be pending, which will make your "sleep loop" be a busy
> > loop as you can never go to sleep interruptibly with a pending signal.
> 
> Well, the problem was quite different compare to what I thought.
> 
> Our hardware requires that once you start talking to firmware you cannot let
> anybody to interrupt you.
> Thus, I lazily put in all "magic" handlers (read, write, ioctl):
> 
> my_ioctl() {
> ... do entry stuff
> _fw_spinlock // = spin_lock_irqsave(...);
> 
> .. do my stuff (nobody could interrupt me)
> 
> _fw_spinunlock // = spin_lock_irqrestore(...);
> }
> 
> Everything worked fine under 2.2.x (I knew that this was a shortcut!!!)
> In 2.4.x I could not call wake_up_interruptible() while in spinlock 
> (and it's clearly understandable).
> 

Errm... You should be able to execute wake_up_interruptible() while
in a spin-lock! It's callable from within ISRs, etc., and is how you
tell poll() that some I/O condition as changed.

Just don't expect the wakeup to occur until after you release the
spin-lock unless you have more than one CPU.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


