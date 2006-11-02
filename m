Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752597AbWKBAJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbWKBAJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbWKBAJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:09:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752597AbWKBAJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:09:28 -0500
Date: Wed, 1 Nov 2006 16:09:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] UML - Fix I/O hang
Message-Id: <20061101160917.ebc40069.akpm@osdl.org>
In-Reply-To: <200611011732.kA1HWfZt005499@ccure.user-mode-linux.org>
References: <200611011732.kA1HWfZt005499@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006 12:32:41 -0500
Jeff Dike <jdike@addtoit.com> wrote:

> This patch fixes a UML hang in which everything would just stop until
> some I/O happened - a ping, someone whacking the keyboard - at which
> point everything would start up again as though nothing had happened.
> 
> The cause was gcc reordering some code which absolutely needed to be
> executed in the order in the source.  When unblock_signals switches
> signals from off to on, it needs to see if any interrupts had happened
> in the critical section.  The interrupt handlers check signals_enabled -
> if it is zero, then the handler adds a bit to the "pending" bitmask
> and returns.  unblock_signals checks this mask to see if any signals
> need to be delivered.
> 
> The crucial part is this:
> 	signals_enabled = 1;
> 	save_pending = pending;
> 	if(save_pending == 0)
> 		return;
> 	pending = 0;
> 
> In order to avoid an interrupt arriving between reading pending and
> setting it to zero, in which case, the record of the interrupt would
> be erased, signals are enabled.
> 
> What happened was that gcc reordered this so that 'save_pending = pending'
> came before 'signals_enabled = 1', creating a one-instruction window
> within which an interrupt could arrive, set its bit in pending, and
> have it be immediately erased.

So you need a compiler barrier, not a memory barrier.

> When the I/O workload is purely disk-based, the loss of a block device
> interrupt stops the entire I/O system because the next block request
> will wait for the current one to finish.  Thus the system hangs until
> something else causes some I/O to arrive, such as a network packet or
> console input.
> 
> The fix to this particular problem is a memory barrier between
> enabling signals and reading the pending signal mask.  An xchg would
> also probably work.
> 
> Looking over this code for similar problems led me to do a few more
> things -
> 	make signals_enabled and pending volatile so that they don't
> get cached in registers
> 	add an mb() to the return paths of block_signals and
> unblock_signals so that the modification of signals_enabled doesn't
> get shuffled into the caller in the event that these are inlined in
> the future.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.18-mm/arch/um/include/sysdep-i386/barrier.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.18-mm/arch/um/include/sysdep-i386/barrier.h	2006-10-31 14:41:52.000000000 -0500
> @@ -0,0 +1,9 @@
> +#ifndef __SYSDEP_I386_BARRIER_H
> +#define __SYSDEP_I386_BARRIER_H
> +
> +/* Copied from include/asm-i386 for use by userspace.  i386 has the option
> + * of using mfence, but I'm just using this, which works everywhere, for now.
> + */
> +#define mb() asm volatile("lock; addl $0,0(%esp)")

That's a memory barrier, which is more expensive.

This:

#define barrier() __asm__ __volatile__("": : :"memory")

should suffice?

