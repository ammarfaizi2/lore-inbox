Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265882AbTL3WbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265903AbTL3Wai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:30:38 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:53483 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S265872AbTL3W3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:29:40 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] Fix 2.4 megaraid virt_to_bus() usage
Date: Tue, 30 Dec 2003 15:29:30 -0700
User-Agent: KMail/1.5.4
Cc: atulm@lsil.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312301529.30065.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been in the ia64 patch for ages.  It
	- removes two unused variables,
	- fixes a printk format string, and
	- removes a virt_to_bus() that doesn't work on some
	  ia64 boxes

The virt_to_bus() usage was removed from 2.6 in the
upgrade to version 2.03 of the driver:
    http://linux.bkbits.net:8080/linux-2.5/cset@1.971.136.1?nav=index.html|src/.|src/drivers|src/drivers/scsi|related/drivers/scsi/megaraid.c

Please apply to 2.4.

Bjorn


diff -urN linux-2.4/drivers/scsi/megaraid.c linux-ia64-2.4/drivers/scsi/megaraid.c
--- linux-2.4/drivers/scsi/megaraid.c	2003-12-29 17:05:18.000000000 -0700
+++ linux-ia64-2.4/drivers/scsi/megaraid.c	2003-12-29 17:05:55.000000000 -0700
@@ -2234,9 +2234,6 @@
 
 
 #if DEBUG
-static unsigned int cum_time = 0;
-static unsigned int cum_time_cnt = 0;
-
 static void showMbox (mega_scb * pScb)
 {
 	mega_mailbox *mbox;
@@ -2245,7 +2242,7 @@
 		return;
 
 	mbox = (mega_mailbox *) pScb->mboxData;
-	printk ("%u cmd:%x id:%x #scts:%x lba:%x addr:%x logdrv:%x #sg:%x\n",
+	printk ("%lu cmd:%x id:%x #scts:%x lba:%x addr:%x logdrv:%x #sg:%x\n",
 		pScb->SCpnt->pid,
 		mbox->cmd, mbox->cmdid, mbox->numsectors,
 		mbox->lba, mbox->xferaddr, mbox->logdrv, mbox->numsgelements);
@@ -3569,10 +3566,14 @@
 	mbox[0] = IS_BIOS_ENABLED;
 	mbox[2] = GET_BIOS;
 
-	mboxpnt->xferaddr = virt_to_bus ((void *) megacfg->mega_buffer);
+	mboxpnt->xferaddr = pci_map_single(megacfg->dev,
+				(void *) megacfg->mega_buffer, (2 * 1024L),
+				PCI_DMA_FROMDEVICE);
 
 	ret = megaIssueCmd (megacfg, mbox, NULL, 0);
 
+	pci_unmap_single(megacfg->dev, mboxpnt->xferaddr, 2 * 1024L, PCI_DMA_FROMDEVICE);
+
 	return (*(char *) megacfg->mega_buffer);
 }
 

