Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUGACzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUGACzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 22:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUGACzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 22:55:41 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:25736 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263736AbUGACzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 22:55:38 -0400
Subject: [PATCH] make use of on-chip coherent memory in NCR Q720 driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Ian Molton <spyro@f2s.com>, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com, david-b@pacbell.net,
       Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jun 2004 21:55:34 -0500
Message-Id: <1088650537.1888.16.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is actually a use for the implementation.  The Q720 card has 2MB
on-chip memory designed for scripts and cdb allocation.  declaring it
using the API allows the ncr53c8xx driver to make use of it
transparently.  This board is actually provides the root disc of one of
my voyagers, so I've verified that it actually all works.

James

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/30 21:44:24-05:00 jejb@mulgrave.(none) 
#   Convert NCR_Q720 to use dma_declare_coherent_memory
#   
#   This board makes an ideal example for using the API
#   since it consists of 4 SCSI I/O processors and a 
#   0.5-2MB block of memory on a single MCA card.
# 
# drivers/scsi/NCR_Q720.c
#   2004/06/30 21:44:03-05:00 jejb@mulgrave.(none) +18 -3
#   Convert NCR_Q720 to use dma_declare_coherent_memory
# 
diff -Nru a/drivers/scsi/NCR_Q720.c b/drivers/scsi/NCR_Q720.c
--- a/drivers/scsi/NCR_Q720.c	2004-06-30 21:54:45 -05:00
+++ b/drivers/scsi/NCR_Q720.c	2004-06-30 21:54:46 -05:00
@@ -216,7 +216,21 @@
 		goto out_free;
 	}
 	
-	mem_base = (__u32)ioremap(base_addr, mem_size);
+	if (dma_declare_coherent_memory(dev, base_addr, base_addr,
+					mem_size, DMA_MEMORY_MAP)
+	    != DMA_MEMORY_MAP) {
+		printk(KERN_ERR "NCR_Q720: DMA declare memory failed\n");
+		goto out_release_region;
+	}
+
+	/* The first 1k of the memory buffer is a memory map of the registers
+	 */
+	mem_base = (__u32)dma_mark_declared_memory_occupied(dev, base_addr,
+							    1024);
+	if (IS_ERR((void *)mem_base)) {
+		printk("NCR_Q720 failed to reserve memory mapped region\n");
+		goto out_release;
+	}
 
 	/* now also enable accesses in asr 2 */
 	asr2 = inb(io_base + 0x0a);
@@ -296,7 +310,8 @@
 	return 0;
 
  out_release:
-	iounmap((void *)mem_base);
+	dma_release_declared_memory(dev);
+ out_release_region:
 	release_mem_region(base_addr, mem_size);
  out_free:
 	kfree(p);
@@ -321,7 +336,7 @@
 		if(p->hosts[i])
 			NCR_Q720_remove_one(p->hosts[i]);
 
-	iounmap((void *)p->mem_base);
+	dma_release_declared_memory(dev);
 	release_mem_region(p->phys_mem_base, p->mem_size);
 	free_irq(p->irq, p);
 	kfree(p);

