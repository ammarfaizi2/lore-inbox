Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267444AbUHDVd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267444AbUHDVd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUHDVbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:31:18 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:23563 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267443AbUHDVaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:30:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: cciss update [6 of 6]
Date: Wed, 4 Aug 2004 16:29:57 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107436097@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: cciss update [6 of 6]
Thread-index: AcR6ajDWiN8bN9UPT6OaUQUC8Kw8FA==
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <akpm@osdl.org>, <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 21:29:58.0621 (UTC) FILETIME=[315850D0:01C47A6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 6 of 6
Name: p006_intr_fix_for_268rc2.patch

This patch fixes our usage of pdev->intr. We were truncating it to an
unchar. We were also reading it before calling pci_enable_device. This
patch fixes both of those. Thanks to Bjorn Helgaas for the patch.
Please apply in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc2-p005/drivers/block/cciss.c lx268-rc2/drivers/block/cciss.c
--- lx268-rc2-p005/drivers/block/cciss.c        2004-08-03 14:19:26.195069000 -0500
+++ lx268-rc2/drivers/block/cciss.c     2004-08-03 15:04:23.730981696 -0500
@@ -2301,7 +2301,6 @@ static int find_PCI_BAR_index(struct pci
 static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
        ushort subsystem_vendor_id, subsystem_device_id, command;
-       unchar irq = pdev->irq;
        __u32 board_id, scratchpad = 0;
        __u64 cfg_offset;
        __u32 cfg_base_addr;
@@ -2360,11 +2359,11 @@ static int cciss_pci_init(ctlr_info_t *c

 #ifdef CCISS_DEBUG
        printk("command = %x\n", command);
-       printk("irq = %x\n", irq);
+       printk("irq = %x\n", pdev->irq);
        printk("board_id = %x\n", board_id);
 #endif /* CCISS_DEBUG */

-       c->intr = irq;
+       c->intr = pdev->irq;

        /*
         * Memory base addr is first addr , the second points to the config
diff -burpN lx268-rc2-p005/drivers/block/cciss.h lx268-rc2/drivers/block/cciss.h
--- lx268-rc2-p005/drivers/block/cciss.h        2004-06-16 00:18:37.000000000 -0500
+++ lx268-rc2/drivers/block/cciss.h     2004-08-03 15:14:41.089128992 -0500
@@ -48,7 +48,7 @@ struct ctlr_info
        unsigned long io_mem_addr;
        unsigned long io_mem_length;
        CfgTable_struct *cfgtable;
-       int     intr;
+       unsigned int intr;
        int     interrupts_enabled;
        int     max_commands;
        int     commands_outstanding;

