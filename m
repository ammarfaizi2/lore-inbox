Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261999AbTCLWDX>; Wed, 12 Mar 2003 17:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTCLWDX>; Wed, 12 Mar 2003 17:03:23 -0500
Received: from users.ccur.com ([208.248.32.211]:55303 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S261999AbTCLWDV>;
	Wed, 12 Mar 2003 17:03:21 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200303122213.WAA17415@rudolph.ccur.com>
Subject: [PATCH] bug in 2.4 bh_kmap_irq() breaks IDE under preempt patch
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 12 Mar 2003 17:13:47 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Everyone,
The bh_map_irq/bh_unmap_irq functions are broken in 2.4.21-pre5.
However no symptoms occur unless the preemption patch is applied.

The bug is that bh_map_irq *conditionally* calls kmap_atomic (which
disables preemption as one of its functions), while bh_unmap_irq
*unconditionally* calls kunmap_atomic (which enables it).  This
imbalance results in a occasional off-by-one preempt_count, which in
turn causes IDE PIO mode interrupt code (specifically, read_intr) to
erronously invoke preempt_schedule while at interrupt level.

The below patch compiles and boots ide=nodma on my preempt 2.4 kernel
on the one motherboard that had the problem.  Before this patch, the
kernel would not even boot for that motherboard.  I also applied and
test booted a pure 2.4.21-pre5 kernel with this patch.

The patch implements my preference for simplicity, so you may want to
take some other approach if maximal performance is what you want.

Joe




--- include/linux/highmem.h.orig	2003-03-12 05:01:56.000000000 -0500
+++ include/linux/highmem.h	2003-03-12 16:07:04.000000000 -0500
@@ -33,22 +33,10 @@
 {
 	unsigned long addr;
 
-	__save_flags(*flags);
-
-	/*
-	 * could be low
-	 */
-	if (!PageHighMem(bh->b_page))
-		return bh->b_data;
-
-	/*
-	 * it's a highmem page
-	 */
-	__cli();
+	local_irq_save(*flags);
 	addr = (unsigned long) kmap_atomic(bh->b_page, KM_BH_IRQ);
 
-	if (addr & ~PAGE_MASK)
-		BUG();
+	BUG_ON (addr & ~PAGE_MASK);
 
 	return (char *) addr + bh_offset(bh);
 }
@@ -58,7 +46,7 @@
 	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
 
 	kunmap_atomic((void *) ptr, KM_BH_IRQ);
-	__restore_flags(*flags);
+	local_irq_restore(*flags);
 }
 
 #else /* CONFIG_HIGHMEM */
