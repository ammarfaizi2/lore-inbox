Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSCYUYs>; Mon, 25 Mar 2002 15:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312547AbSCYUY2>; Mon, 25 Mar 2002 15:24:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:17924 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312543AbSCYUY0>; Mon, 25 Mar 2002 15:24:26 -0500
Message-ID: <3C9F870A.E1280D33@zip.com.au>
Date: Mon, 25 Mar 2002 12:22:34 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Paul Clements <kernel@steeleye.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 raid1 - fix SMP locking/interrupt
In-Reply-To: <001001c1d436$90abdf70$010411ac@local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> >
> > However a bare spin_unlock_irq() in a function means that
> > callers which wish to keep interrupts disabled are subtly
> > subverted.   We've had bugs from this before.
> >
> It is trivial to catch such bugs at runtime. I tried it a year ago, and
> immediately run into sleep_on() users that legitimately call
> spin_lock_irq() with disabled interrupts. Perhaps they are gone now,
> I'll retest my patch.

heh.  Yes, I tried that too a year or so ago.  Basically just
add

	if (!(eflags & 0x0200))
		whine();

to spin_lock_irq().  There was a *lot* of whining.

> > So the irqrestore functions are much more robust.  I believe
> > that they should be the default choice.  The non-restore
> > versions should be viewed as a micro-optimised version,
> > to be used with caution.  The additional expense of the save/restore
> > is quite tiny - 20-30 cycles, perhaps.
> 
> OTHO, if a function doesn't work correctly if it's called with disabled
> interrupts, then it should not use spin_lock_irqsave() - it's
> misleading.
> e.g. if it calls kmalloc(GFP_KERNEL), down(), schedule(), etc.

mm?  Those are legal (albeit unpleasant) inside local_irq_save(),
but illegal inside global_cli() in 2.5.  Aren't they?  If not,
then release_kernel_lock() needs talking to.

-
