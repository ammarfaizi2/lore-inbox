Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161548AbWAMP0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161548AbWAMP0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWAMPYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:50 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:52135 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161478AbWAMPY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=gKkG7hVp5l7WokW+DR1HOYm/MxHaE3+XK/tVnou+kvNeJWXMDArbPJovijO3sTFWI56M1egCE2kBbd7es2TQ9kzBDqnYUYeOQCzRwtKsZ1B2JcdKejK0HEGMHuZXUKJ3nW0k6Gx3ArUYeMQHlMB4IXIKZ1erhnAolOM6CmAw58k=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/8] block: convert IDE to use blk_kmap helpers
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 14 Jan 2006 00:24:16 +0900
Message-Id: <1137165856390-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert direct uses of kmap/unmap to blk_kmap/unmap in IDE.  This
combined with the previous bio helper change fixes PIO cache coherency
bugs on architectures with aliased caches.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/ide/ide-taskfile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

72ba1c82f766c7b42792499cc9156f89e76b176c
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 62ebefd..24d5e56 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -260,6 +260,7 @@ static void ide_pio_sector(ide_drive_t *
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct scatterlist *sg = hwif->sg_table;
+	enum dma_data_direction dir = write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	struct page *page;
 #ifdef CONFIG_HIGHMEM
 	unsigned long flags;
@@ -277,7 +278,7 @@ static void ide_pio_sector(ide_drive_t *
 #ifdef CONFIG_HIGHMEM
 	local_irq_save(flags);
 #endif
-	buf = kmap_atomic(page, KM_BIO_SRC_IRQ) + offset;
+	buf = blk_kmap_atomic(page, KM_BIO_SRC_IRQ, dir) + offset;
 
 	hwif->nleft--;
 	hwif->cursg_ofs++;
@@ -293,7 +294,7 @@ static void ide_pio_sector(ide_drive_t *
 	else
 		taskfile_input_data(drive, buf, SECTOR_WORDS);
 
-	kunmap_atomic(buf, KM_BIO_SRC_IRQ);
+	blk_kunmap_atomic(buf, KM_BIO_SRC_IRQ, dir);
 #ifdef CONFIG_HIGHMEM
 	local_irq_restore(flags);
 #endif
-- 
1.0.6


