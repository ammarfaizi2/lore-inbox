Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUHJQRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUHJQRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267534AbUHJQQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:16:50 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:29956 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S267490AbUHJQL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:11:56 -0400
Date: Tue, 10 Aug 2004 11:11:16 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [6/8] pci_dev->irq fix
Message-ID: <20040810161116.GF19909@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch 6 of 8

This patch fixes our usage of pdev->intr. We were truncating it to an
unchar. We were also reading it before calling pci_enable_device. This
patch fixes both of those. Thanks to Bjorn Helgaas for the patch.
Patch applies to 2.6.8-rc4. Please apply in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3-p005/drivers/block/cciss.c lx268-rc3/drivers/block/cciss.c
--- lx268-rc3-p005/drivers/block/cciss.c	2004-08-05 11:21:05.069294000 -0500
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
diff -burpN lx268-rc3-p005/drivers/block/cciss.h lx268-rc3/drivers/block/cciss.h
--- lx268-rc3-p005/drivers/block/cciss.h	2004-06-16 00:18:37.000000000 -0500
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
