Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752232AbWKAVvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbWKAVvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbWKAVvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:51:03 -0500
Received: from palrel12.hp.com ([156.153.255.237]:44268 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1752232AbWKAVvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:51:00 -0500
Date: Wed, 1 Nov 2006 15:51:00 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/8] cciss: reference driver support
Message-ID: <20061101215100.GB29928@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PATCH 2/8

This patch adds the support to fire up on any HP RAID class device that
has a valid cciss signature.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)
--------------------------------------------------------------------------------
diff -urNp linux-2.6-p00001/drivers/block/cciss.c linux-2.6/drivers/block/cciss.c
--- linux-2.6-p00001/drivers/block/cciss.c	2006-10-31 14:45:20.000000000 -0600
+++ linux-2.6/drivers/block/cciss.c	2006-10-31 14:52:09.000000000 -0600
@@ -83,6 +83,8 @@ static const struct pci_device_id cciss_
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3214},
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3215},
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSC,     0x103C, 0x3233},
+	{PCI_VENDOR_ID_HP,     PCI_ANY_ID,	PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_STORAGE_RAID << 8, 0xffff << 8, 0},
 	{0,}
 };
 
@@ -112,6 +114,7 @@ static struct board_type products[] = {
 	{0x3214103C, "Smart Array E200i", &SA5_access},
 	{0x3215103C, "Smart Array E200i", &SA5_access},
 	{0x3233103C, "Smart Array E500", &SA5_access},
+	{0xFFFF103C, "Unknown Smart Array", &SA5_access},
 };
 
 /* How long to wait (in milliseconds) for board to go into simple mode */
@@ -2954,13 +2957,6 @@ static int cciss_pci_init(ctlr_info_t *c
 			break;
 		}
 	}
-	if (i == ARRAY_SIZE(products)) {
-		printk(KERN_WARNING "cciss: Sorry, I don't know how"
-		       " to access the Smart Array controller %08lx\n",
-		       (unsigned long)board_id);
-		err = -ENODEV;
-		goto err_out_free_res;
-	}
 	if ((readb(&c->cfgtable->Signature[0]) != 'C') ||
 	    (readb(&c->cfgtable->Signature[1]) != 'I') ||
 	    (readb(&c->cfgtable->Signature[2]) != 'S') ||
@@ -2969,6 +2965,26 @@ static int cciss_pci_init(ctlr_info_t *c
 		err = -ENODEV;
 		goto err_out_free_res;
 	}
+	/* We didn't find the controller in our list. We know the
+	 * signature is valid. If it's an HP device let's try to
+	 * bind to the device and fire it up. Otherwise we bail.
+	 */
+	if (i == ARRAY_SIZE(products)) {
+		if (subsystem_vendor_id == PCI_VENDOR_ID_HP) {
+			c->product_name = products[i-1].product_name;
+			c->access = *(products[i-1].access);
+			printk(KERN_WARNING "cciss: This is an unknown "
+				"Smart Array controller.\n"
+				"cciss: Please update to the latest driver "
+				"available from www.hp.com.\n");
+		} else {
+			printk(KERN_WARNING "cciss: Sorry, I don't know how"
+				" to access the Smart Array controller %08lx\n"
+					, (unsigned long)board_id);
+			err = -ENODEV;
+			goto err_out_free_res;
+		}
+	}
 #ifdef CONFIG_X86
 	{
 		/* Need to enable prefetch in the SCSI core for 6400 in x86 */
