Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267920AbUHETsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267920AbUHETsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267915AbUHETsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:48:09 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:22034 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267930AbUHETrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:47:51 -0400
Subject: cciss updates [6/6] pdev->intr fix for 2.6.8-rc3
From: mikem <mike.miller@hp.com>
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091735220.4826.28.camel@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 14:47:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 6 of 6

This patch fixes our usage of pdev->intr. We were truncating it to an
unchar. We were also reading it before calling pci_enable_device. This
patch fixes both of those. Thanks to Bjorn Helgaas for the patch.
Please apply in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3-p005/drivers/block/cciss.c
lx268-rc3/drivers/block/cciss.c
--- lx268-rc3-p005/drivers/block/cciss.c	2004-08-05 11:21:05.069294000
-0500
+++ lx268-rc3/drivers/block/cciss.c	2004-08-05 11:30:40.761776344 -0500
@@ -2300,7 +2300,6 @@ static int find_PCI_BAR_index(struct pci
 static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
 	ushort subsystem_vendor_id, subsystem_device_id, command;
-	unchar irq = pdev->irq;
 	__u32 board_id, scratchpad = 0;
 	__u64 cfg_offset;
 	__u32 cfg_base_addr;
@@ -2359,11 +2358,11 @@ static int cciss_pci_init(ctlr_info_t *c
 
 #ifdef CCISS_DEBUG
 	printk("command = %x\n", command);
-	printk("irq = %x\n", irq);
+	printk("irq = %x\n", pdev->irq);
 	printk("board_id = %x\n", board_id);
 #endif /* CCISS_DEBUG */ 
 
-	c->intr = irq;
+	c->intr = pdev->irq;
 
 	/*
 	 * Memory base addr is first addr , the second points to the config
diff -burpN lx268-rc3-p005/drivers/block/cciss.h
lx268-rc3/drivers/block/cciss.h
--- lx268-rc3-p005/drivers/block/cciss.h	2004-06-16 00:18:37.000000000
-0500
+++ lx268-rc3/drivers/block/cciss.h	2004-08-05 11:30:40.762776192 -0500
@@ -48,7 +48,7 @@ struct ctlr_info 
 	unsigned long io_mem_addr;
 	unsigned long io_mem_length;
 	CfgTable_struct *cfgtable;
-	int	intr;
+	unsigned int intr;
 	int	interrupts_enabled;
 	int 	max_commands;
 	int	commands_outstanding;


