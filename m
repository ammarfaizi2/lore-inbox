Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269494AbRHCRRm>; Fri, 3 Aug 2001 13:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269491AbRHCRRc>; Fri, 3 Aug 2001 13:17:32 -0400
Received: from zeus.kernel.org ([209.10.41.242]:60098 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S269489AbRHCRRP>;
	Fri, 3 Aug 2001 13:17:15 -0400
Date: Fri, 3 Aug 2001 12:10:55 -0500
From: David Fries <dfries@mail.win.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.2.19] de4x5 driver, Alpha spinlock problem
Message-ID: <20010803121055.A6211@d-131-151-189-65.dynamic.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I understood things interrupt handelers don't need to be re-entrant
because even on a SMP system it won't be called again until the first
one completes executing.  Or is that not true on 2.2 series kernels?

Anyway on this Alpha system I'll get that the spinlock is stuck by cpu
0 when cpu 0 is spinning waiting on the lock (external interrupts are
only being delivered to cpu 0 according to /etc/interrupts).  After
looking into the problem more at least one case of the problem the cpu
just executed the ENABLE_IRQs; in de4x5_interrupt and was not able to
unlock the spinlock before de4x5_interrupt was called again.

Comments please.

cpu                     : Alpha
cpu model               : EV45
cpu variation           : 7
cpu revision            : 0
system type             : Sable
system variation        : 0
system revision         : 0
platform string         : AlphaServer 2000 4/233
cpus detected           : 2
CPUs probed 2 active 2 map 0x3 IPIs 34597
Linux oemlab38 2.2.19 #8 SMP Wed Aug 1 17:00:06 CDT 2001 alpha unknown

--- /usr/src/linux-2.2.19/drivers/net/de4x5.c	Sun Mar 25 10:31:16 2001
+++ de4x5.c	Thu Aug  2 13:08:56 2001
@@ -1604,22 +1604,19 @@
     struct de4x5_private *lp;
     s32 imr, omr, sts, limit;
     u_long iobase;
+    u_long flags = 0;
     
     if (dev == NULL) {
 	printk ("de4x5_interrupt(): irq %d for unknown device.\n", irq);
 	return;
     }
     lp = (struct de4x5_private *)dev->priv;
-    spin_lock(&lp->lock);
+    spin_lock_irqsave(&lp->lock,flags);
     iobase = dev->base_addr;
 	
-    DISABLE_IRQs;                        /* Ensure non re-entrancy */
-
     if (test_and_set_bit(MASK_INTERRUPTS, (void*) &lp->interrupt))
 	printk("%s: Re-entering the interrupt handler.\n", dev->name);
 
-    synchronize_irq();
-	
     for (limit=0; limit<8; limit++) {
 	sts = inl(DE4X5_STS);            /* Read IRQ status */
 	outl(sts, DE4X5_STS);            /* Reset the board interrupts */
@@ -1657,8 +1654,7 @@
     }
 
     lp->interrupt = UNMASK_INTERRUPTS;
-    ENABLE_IRQs;
-    spin_unlock(&lp->lock);
+    spin_unlock_irqrestore(&lp->lock,flags);
     
     return;
 }

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@mail.win.org        |
		+---------------------------------+
