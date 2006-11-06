Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753334AbWKFUNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbWKFUNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbWKFUNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:13:00 -0500
Received: from palrel13.hp.com ([156.153.255.238]:26529 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1753224AbWKFUM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:12:59 -0500
Date: Mon, 6 Nov 2006 14:12:57 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/12] repost: cciss: reference driver support
Message-ID: <20061106201257.GB17847@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 2/12

This patch adds the support to fire up on any HP RAID class device that
has a valid cciss signature.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

--------------------------------------------------------------------------------
---

 drivers/block/cciss.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff -puN drivers/block/cciss.c~cciss_ref_driver_for_lx2619-rc2 drivers/block/cciss.c
--- linux-2.6/drivers/block/cciss.c~cciss_ref_driver_for_lx2619-rc2	2006-11-06 13:15:31.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:15:31.000000000 -0600
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
_
