Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966465AbWKTTYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966465AbWKTTYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966484AbWKTTYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:24:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:16338 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S966470AbWKTTYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:24:00 -0500
Date: Mon, 20 Nov 2006 14:23:35 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>
Subject: Re: [RFC] [PATCH] Fix misrouted interrupts deadlocks
Message-ID: <20061120192335.GA11879@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <455484E4.1020100@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455484E4.1020100@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 04:55:48PM +0300, Pavel Emelianov wrote:
> As the second lock on booth CPUs is taken before checking that
> this irq is being handled in another processor this may cause
> a deadlock. This issue is only theoretical.
> 
> I propose the attached patch to fix booth problems: when trying
> to handle misrouted IRQ active desc->lock may be unlocked.
> 
> Please comment.

> --- ./kernel/irq/spurious.c.irqlockup	2006-11-09 11:19:10.000000000 +0300
> +++ ./kernel/irq/spurious.c	2006-11-10 16:53:38.000000000 +0300
> @@ -147,7 +147,11 @@ void note_interrupt(unsigned int irq, st
>  	if (unlikely(irqfixup)) {
>  		/* Don't punish working computers */
>  		if ((irqfixup == 2 && irq == 0) || action_ret == IRQ_NONE) {
> -			int ok = misrouted_irq(irq);
> +			int ok;
> +
> +			spin_unlock(&desc->lock);
> +			ok = misrouted_irq(irq);
> +			spin_lock(&desc->lock);

Hi Pavel,

Till -rc5, I was able to boot a kernel with irqpoll option and in -rc6 I 
can't. It simply hangs. I suspect it is realted to this change. I have yet
to confirm that. But before that one observation.

Not at every place note_interrupt() is called with desc->lock() held. For
example, handle_level_irq(). I enabled spin lock debugging and I run into
following BUG().


PID hash table entries: 256 (order: 8, 2048 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 3000.218 MHz processor.

=====================================
[ BUG: bad unlock balance detected! ]
-------------------------------------
swapper/0 is trying to release lock (&irq_desc_lock_class) at:
[<ffffffff8104c673>] note_interrupt+0x7a/0x22b
but there are no more locks to release!

other info that might help us debug this:
no locks held by swapper/0.

stack backtrace:

Call Trace:
  [<ffffffff8100a6f9>] show_trace+0x34/0x47
  [<ffffffff8100a71e>] dump_stack+0x12/0x17
  [<ffffffff8103caba>] print_unlock_inbalance_bug+0xfb/0x106
  [<ffffffff8103e6e5>] lock_release+0x89/0x128
  [<ffffffff81332d96>] _spin_unlock+0x17/0x20
  [<ffffffff8104c673>] note_interrupt+0x7a/0x22b
  [<ffffffff8104d131>] handle_level_irq+0xab/0xea
  [<ffffffff8100b776>] do_IRQ+0xf4/0x132
  [<ffffffff81009956>] ret_from_intr+0x0/0xf
DWARF2 unwinder stuck at ret_from_intr+0x0/0xf
Leftover inexact backtrace:

  <IRQ>  <EOI>  [<ffffffff8159f61d>] start_kernel+0x178/0x2f6
  [<ffffffff8159f625>] start_kernel+0x180/0x2f6
  [<ffffffff8159f61d>] start_kernel+0x178/0x2f6
  [<ffffffff8159f13e>] _sinittext+0x13e/0x142

BUG: spinlock lockup on CPU#0, swapper/0, ffffffff81586140

Call Trace:
  [<ffffffff8100a6f9>] show_trace+0x34/0x47
  [<ffffffff8100a71e>] dump_stack+0x12/0x17
  [<ffffffff811457c8>] _raw_spin_lock+0xca/0xe8
  [<ffffffff8104d139>] handle_level_irq+0xb3/0xea
  [<ffffffff8100b776>] do_IRQ+0xf4/0x132
  [<ffffffff81009956>] ret_from_intr+0x0/0xf
DWARF2 unwinder stuck at ret_from_intr+0x0/0xf

Leftover inexact backtrace:

  <IRQ>  <EOI>  [<ffffffff8159f61d>] start_kernel+0x178/0x2f6
  [<ffffffff8159f625>] start_kernel+0x180/0x2f6
  [<ffffffff8159f61d>] start_kernel+0x178/0x2f6
  [<ffffffff8159f13e>] _sinittext+0x13e/0x142

Thanks
Vivek
