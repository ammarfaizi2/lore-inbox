Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTDIWqe (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTDIWqd (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:46:33 -0400
Received: from palrel13.hp.com ([156.153.255.238]:10733 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263859AbTDIWqY (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:46:24 -0400
Date: Wed, 9 Apr 2003 15:58:02 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304092258.h39Mw2Di011866@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] couple of megaraid fixes
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch has been in my tree for some time.  IIRC, Grant
Grundler sent it to me.  The old code is clearly broken: it still uses
virt_to_bus() and SCpnt->pid is declared as "unsigned long", so I'm
pretty sure this is an improvement. ;-)

	--david

diff -Nru a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
--- a/drivers/scsi/megaraid.c	Wed Apr  9 14:49:48 2003
+++ b/drivers/scsi/megaraid.c	Wed Apr  9 14:49:48 2003
@@ -2045,7 +2045,7 @@
 		return;
 
 	mbox = (mega_mailbox *) pScb->mboxData;
-	printk ("%u cmd:%x id:%x #scts:%x lba:%x addr:%x logdrv:%x #sg:%x\n",
+	printk ("%lu cmd:%x id:%x #scts:%x lba:%x addr:%x logdrv:%x #sg:%x\n",
 		pScb->SCpnt->pid,
 		mbox->cmd, mbox->cmdid, mbox->numsectors,
 		mbox->lba, mbox->xferaddr, mbox->logdrv, mbox->numsgelements);
@@ -3351,9 +3351,13 @@
 	mbox[0] = IS_BIOS_ENABLED;
 	mbox[2] = GET_BIOS;
 
-	mboxpnt->xferaddr = virt_to_bus ((void *) megacfg->mega_buffer);
+	mboxpnt->xferaddr = pci_map_single(megacfg->dev,
+				(void *) megacfg->mega_buffer, (2 * 1024L),
+				PCI_DMA_FROMDEVICE);
 
 	ret = megaIssueCmd (megacfg, mbox, NULL, 0);
+
+	pci_unmap_single(megacfg->dev, mboxpnt->xferaddr, 2 * 1024L, PCI_DMA_FROMDEVICE);
 
 	return (*(char *) megacfg->mega_buffer);
 }
