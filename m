Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135937AbREJUGQ>; Thu, 10 May 2001 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136114AbREJUGG>; Thu, 10 May 2001 16:06:06 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:48524 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135937AbREJUF4>; Thu, 10 May 2001 16:05:56 -0400
Date: Thu, 10 May 2001 16:05:50 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, zaitcev@redhat.com,
        rmk@arm.linux.org.uk
Subject: Re: pci_pool_free from IRQ
Message-ID: <20010510160550.A32083@devserv.devel.redhat.com>
In-Reply-To: <200105082108.f48L8X1154536@saturn.cs.uml.edu> <E14xFD5-0000hh-00@the-village.bc.nu> <15096.27479.707679.544048@pizda.ninka.net> <050701c0d80f$8f876ca0$6800000a@brownell.org> <15096.38109.228916.621891@pizda.ninka.net> <20010509143020.A22522@devserv.devel.redhat.com> <15097.39445.646189.834699@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15097.39445.646189.834699@pizda.ninka.net>; from davem@redhat.com on Wed, May 09, 2001 at 12:27:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about this (with documentation fixes by David-B):

diff -ur -X dontdiff linux-2.4.4/Documentation/DMA-mapping.txt linux-2.4.4-niph/Documentation/DMA-mapping.txt
--- linux-2.4.4/Documentation/DMA-mapping.txt	Thu Apr 19 08:38:48 2001
+++ linux-2.4.4-niph/Documentation/DMA-mapping.txt	Thu May 10 12:29:22 2001
@@ -240,6 +240,7 @@
 
 where dev, size are the same as in the above call and cpu_addr and
 dma_handle are the values pci_alloc_consistent returned to you.
+This function may not be called in interrupt context.
 
 If your driver needs lots of smaller memory regions, you can write
 custom code to subdivide pages returned by pci_alloc_consistent,
@@ -262,7 +263,8 @@
 sleeping context (f.e. in_interrupt is true or while holding SMP
 locks), pass SLAB_ATOMIC.  If your device has no boundary crossing
 restrictions, pass 0 for alloc; passing 4096 says memory allocated
-from this pool must not cross 4KByte boundaries.
+from this pool must not cross 4KByte boundaries (but at that time it
+may be better to go for pci_alloc_consistent directly instead).
 
 Allocate memory from a pci pool like this:
 
@@ -270,21 +272,23 @@
 
 flags are SLAB_KERNEL if blocking is permitted (not in_interrupt nor
 holding SMP locks), SLAB_ATOMIC otherwise.  Like pci_alloc_consistent,
-this returns two values, cpu_addr and dma_handle,
+this returns two values, cpu_addr and dma_handle.
 
 Free memory that was allocated from a pci_pool like this:
 
 	pci_pool_free(pool, cpu_addr, dma_handle);
 
 where pool is what you passed to pci_pool_alloc, and cpu_addr and
-dma_handle are the values pci_pool_alloc returned.
+dma_handle are the values pci_pool_alloc returned. This function
+may be called in interrupt context.
 
 Destroy a pci_pool by calling:
 
 	pci_pool_destroy(pool);
 
 Make sure you've called pci_pool_free for all memory allocated
-from a pool before you destroy the pool.
+from a pool before you destroy the pool. This function may not
+be called in interrupt context.
 
 			DMA Direction
 
diff -ur -X dontdiff linux-2.4.4/Documentation/pci.txt linux-2.4.4-niph/Documentation/pci.txt
--- linux-2.4.4/Documentation/pci.txt	Sun Sep 17 09:45:06 2000
+++ linux-2.4.4-niph/Documentation/pci.txt	Thu May 10 12:33:03 2001
@@ -60,8 +60,8 @@
 	remove		Pointer to a function which gets called whenever a device
 			being handled by this driver is removed (either during
 			deregistration of the driver or when it's manually pulled
-			out of a hot-pluggable slot). This function can be called
-			from interrupt context.
+			out of a hot-pluggable slot). This function always gets
+			called from process context, so it can sleep.
 	suspend,	Power management hooks -- called when the device goes to
 	resume		sleep or is resumed.
 
--- linux-2.4.4/drivers/pci/pci.c	Thu Apr 19 08:38:48 2001
+++ linux-2.4.4-niph/drivers/pci/pci.c	Thu May 10 12:36:28 2001
@@ -1701,8 +1701,11 @@
 	set_bit (block, &page->bitmap [map]);
 	if (waitqueue_active (&pool->waitq))
 		wake_up (&pool->waitq);
-	else if (!is_page_busy (pool->blocks_per_page, page->bitmap))
-		pool_free_page (pool, page);
+	/*
+	 * Resist a temptation to do
+	 *    if (!is_page_busy(bpp, page->bitmap)) pool_free_page(pool, page);
+	 * it is not interrupt safe. Better have empty pages hang around.
+	 */
 	spin_unlock_irqrestore (&pool->lock, flags);
 }
 
