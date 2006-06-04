Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWFDDmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWFDDmy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 23:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWFDDlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 23:41:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:38366 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751494AbWFDDlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 23:41:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=mBOdwkxW5a7tgWioDgUmWmYVnnJdRrM/NgKL1F82moO2dG/ki5blJ6THw6uGMW8cfJjgJL9Uw+RatlihHi0y+TvTDVZBrcBT7dDJVvDMnGoK3Rlqu0QnHtSSOZ8PqbIhn3JHHCN/syu/JldjFHHgMFEbCWvQKTEpH6QbZbmONqY=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] ide: add cpu cache flushes after kmapping and modifying a page
In-Reply-To: <1149392479501-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sun, 4 Jun 2006 12:41:20 +0900
Message-Id: <1149392480987-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       rmk@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add calls to flush_kernel_dcache_page() after CPU has kmapped and
modified a page.  This fixes PIO cache coherency bugs on architectures
with aliased caches.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/ide/ide-floppy.c   |    1 +
 drivers/ide/ide-taskfile.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

861367f65bbbbc5c9f5d3a27aab91c587a3a9049
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index a53e3ce..5be22c2 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -618,6 +618,7 @@ static void idefloppy_input_buffers (ide
 
 			data = bvec_kmap_irq(bvec, &flags);
 			drive->hwif->atapi_input_bytes(drive, data, count);
+			flush_kernel_dcache_page(kmap_atomic_to_page(data));
 			bvec_kunmap_irq(data, &flags);
 
 			bcount -= count;
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 9233b81..c183c07 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -294,6 +294,8 @@ #endif
 	else
 		taskfile_input_data(drive, buf, SECTOR_WORDS);
 
+	if (!write)
+		flush_kernel_dcache_page(kmap_atomic_to_page(buf));
 	kunmap_atomic(buf, KM_BIO_SRC_IRQ);
 #ifdef CONFIG_HIGHMEM
 	local_irq_restore(flags);
-- 
1.3.2


