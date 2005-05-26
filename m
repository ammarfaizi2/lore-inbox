Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVEZQ51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVEZQ51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEZQ5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:57:01 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43994 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261606AbVEZQ42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:56:28 -0400
Message-ID: <4295FFB9.9080803@pobox.com>
Date: Thu, 26 May 2005 12:56:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patch] 2.6.x libata fix
Content-Type: multipart/mixed;
 boundary="------------030804090609030608070209"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030804090609030608070209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Please pull branch 'misc-fixes' of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the fix described in the attachment.



--------------030804090609030608070209
Content-Type: text/plain;
 name="libata-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.6.txt"



 drivers/scsi/libata-core.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)


commit 32529e0128923e42126b5d14e444c18295a452ba
tree d50736f63bd9692076d68c3f8748f1b6bf540a80
parent bef9c558841604116704e10b3d9ff3dbf4939423
author Albert Lee <albertcc@tw.ibm.com> Thu, 26 May 2005 11:49:42 -0400
committer Jeff Garzik <jgarzik@pobox.com> Thu, 26 May 2005 11:49:42 -0400

[PATCH] libata: Fix zero sg_dma_len() on 64-bit platform

When testing ATAPI PIO data transfer on the ppc64 platform,  __atapi_pio_bytes() got zero when
sg_dma_len() is used. I checked the <asm-ppc64/scatterlish.h>, the struct scatterlist is defined as:

struct scatterlist {
	struct page *page;
	unsigned int offset;
	unsigned int length;

	/* For TCE support */
	u32 dma_address;
	u32 dma_length;
};

#define sg_dma_address(sg)	((sg)->dma_address)
#define sg_dma_len(sg)		((sg)->dma_length)

So, if the scatterlist is not DMA mapped, sg_dma_len() will return zero on ppc64.
The same problem should occur on the x86-64 platform.
On the i386 platform, sg_dma_len() returns sg->length, that's why the problem does not occur on an i386.

Changes:
- Use sg->length if the scatterlist is not DMA mapped (yet).

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------------------


diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2071,7 +2071,7 @@ void ata_sg_init_one(struct ata_queued_c
 	sg = qc->sg;
 	sg->page = virt_to_page(buf);
 	sg->offset = (unsigned long) buf & ~PAGE_MASK;
-	sg_dma_len(sg) = buflen;
+	sg->length = buflen;
 }
 
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
@@ -2101,11 +2101,12 @@ static int ata_sg_setup_one(struct ata_q
 	dma_addr_t dma_address;
 
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
-				     sg_dma_len(sg), dir);
+				     sg->length, dir);
 	if (dma_mapping_error(dma_address))
 		return -1;
 
 	sg_dma_address(sg) = dma_address;
+	sg_dma_len(sg) = sg->length;
 
 	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
@@ -2310,7 +2311,7 @@ static void ata_pio_sector(struct ata_qu
 	qc->cursect++;
 	qc->cursg_ofs++;
 
-	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == (&sg[qc->cursg])->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2347,7 +2348,7 @@ next_page:
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
+	count = min(sg->length - qc->cursg_ofs, bytes);
 
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
@@ -2358,7 +2359,7 @@ next_page:
 	qc->curbytes += count;
 	qc->cursg_ofs += count;
 
-	if (qc->cursg_ofs == sg_dma_len(sg)) {
+	if (qc->cursg_ofs == sg->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2371,7 +2372,7 @@ next_page:
 	kunmap(page);
 
 	if (bytes) {
-		if (qc->cursg_ofs < sg_dma_len(sg))
+		if (qc->cursg_ofs < sg->length)
 			goto next_page;
 		goto next_sg;
 	}

--------------030804090609030608070209--
