Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbULREkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbULREkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 23:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbULREkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 23:40:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34774 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262834AbULREkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 23:40:24 -0500
Date: Sat, 18 Dec 2004 04:40:22 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Jim Nelson <james4765@verizon.net>
Cc: Jan Dittmer <jdittmer@ppp0.net>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] Re: [PATCH] lcd: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
Message-ID: <20041218044022.GX7113@parcelfarce.linux.theplanet.co.uk>
References: <20041217235927.17998.75228.61750@localhost.localdomain> <41C380D0.9020001@ppp0.net> <41C39DB8.6050403@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C39DB8.6050403@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 10:02:16PM -0500, Jim Nelson wrote:
> Jan Dittmer wrote:
> >James Nelson wrote:
> >
> >>Remove the cli()/sti() calls in drivers/char/lcd.c
> >
> >
> >Why is this cli() there in the first place? ioctl is already
> >called under lock_kernel.
> 
> First - a warning.  Newbie on the loose, running around, asking for a whack 
> with the cluebat.

OK.  Quick lesson (for both of you actually; Jan's response wasn't accurate).

Once upon a time, we did not support SMP.  We still had to worry about
races.  Interrupts could arrive and touch hardware/variables that
we were in the middle of poking.  So if you disable interrupts (the
instructions are annoying named after the senseless x86 instructions)
around the critical section, you ensure that you can't be interrupted.

Then we introduced the Big Kernel Lock (aka lock_kernel).  As long as
all code that touched the same hardware/variables had the BKL, cli()
was still safe.  We were evil and redefined the cli() function to disable
interrupts on *all* processors, not just the local one.

Thankfully, the ability to disable interrupts globally has been
removed now.  Instead, you must disable _local_ interrupts and then
acquire a lock.  This is spin_lock_irq()/spin_lock_irqsave().  In order
to protect against an interrupt running on a *different* CPU, you have
to take the same lock in the interrupt handler.  This is safe because
a process running on a different CPU will eventually release its lock.

So you still need to disable interrupts, even if you're running under the
BKL -- interrupt routines can't acquire the BKL (because it's magic) and
acquiring the BKL doesn't disable interrupts.

There's some special tricks you can use so you don't have to grab a lock,
but these are advanced magic (eg RCU, seqlocks, atomics), but most drivers
won't use advanced techniques; they're mostly for specialised parts of
the kernel.  In particular drivers shouldn't try to invent their own
locking scheme, they invariably get it subtly wrong.

Hope that clears things up for you a bit; feel free to ask about the
bits that I didn't explain sufficiently.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
