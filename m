Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVFIII2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVFIII2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 04:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVFIII2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 04:08:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9941 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262328AbVFIIHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 04:07:49 -0400
Message-ID: <42A7F8D0.1040604@pobox.com>
Date: Thu, 09 Jun 2005 04:07:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x libata fixes
Content-Type: multipart/mixed;
 boundary="------------030901040206010209080004"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030901040206010209080004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Please pull from the 'misc-fixes' branches of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the two fixes described in the attached diffstat/shortlog/patch.

	Jeff




--------------030901040206010209080004
Content-Type: text/plain;
 name="libata-dev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev.txt"

 drivers/scsi/libata-core.c |    4 +---
 drivers/scsi/sata_sil.c    |    8 +++++++-
 2 files changed, 8 insertions(+), 4 deletions(-)


Albert Lee:
  sg traverse fix for __atapi_pio_bytes()

Jens Axboe:
  sata_sil: Fix FIFO PCI Bus Arbitration kernel oops



diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2577,7 +2577,6 @@ static void __atapi_pio_bytes(struct ata
 next_sg:
 	sg = &qc->sg[qc->cursg];
 
-next_page:
 	page = sg->page;
 	offset = sg->offset + qc->cursg_ofs;
 
@@ -2585,6 +2584,7 @@ next_page:
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
+	/* don't overrun current sg */
 	count = min(sg->length - qc->cursg_ofs, bytes);
 
 	/* don't cross page boundaries */
@@ -2609,8 +2609,6 @@ next_page:
 	kunmap(page);
 
 	if (bytes) {
-		if (qc->cursg_ofs < sg->length)
-			goto next_page;
 		goto next_sg;
 	}
 }
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -432,7 +432,13 @@ static int sil_init_one (struct pci_dev 
 		writeb(cls, mmio_base + SIL_FIFO_R0);
 		writeb(cls, mmio_base + SIL_FIFO_W0);
 		writeb(cls, mmio_base + SIL_FIFO_R1);
-		writeb(cls, mmio_base + SIL_FIFO_W2);
+		writeb(cls, mmio_base + SIL_FIFO_W1);
+		if (ent->driver_data == sil_3114) {
+			writeb(cls, mmio_base + SIL_FIFO_R2);
+			writeb(cls, mmio_base + SIL_FIFO_W2);
+			writeb(cls, mmio_base + SIL_FIFO_R3);
+			writeb(cls, mmio_base + SIL_FIFO_W3);
+		}
 	} else
 		printk(KERN_WARNING DRV_NAME "(%s): cache line size not set.  Driver may not function\n",
 			pci_name(pdev));

--------------030901040206010209080004--
