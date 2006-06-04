Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWFDDm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWFDDm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 23:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWFDDm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 23:42:27 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:27857 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932092AbWFDDlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 23:41:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=IRwXnrps7YZkT8NKhqq5e9tU0R9/FyjI3f2T1vxa4V+00Rt4a0nYSEWlvzw9233TM2d2z3eUHj3e4LGDPNXJ3Mbs1UGdJbbOZcfHRYKiz8MW6cK7c94XNhW09yOqd8eY7+Ml5Mi3iMw9eTR/EvsvVi6Jbvua4n74I+ulhosrSqc=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] md: add cpu cache flushes after kmapping and modifying a page
In-Reply-To: <1149392479501-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sun, 4 Jun 2006 12:41:20 +0900
Message-Id: <11493924803060-git-send-email-htejun@gmail.com>
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

 drivers/md/raid1.c     |    1 +
 drivers/md/raid5.c     |    6 ++++--
 drivers/md/raid6main.c |    6 ++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

716500bdf7de6acb87e36c8146d83dd3c429bc82
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4070eff..30ca7cf 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -720,6 +720,7 @@ static struct page **alloc_behind_pages(
 			goto do_sync_io;
 		memcpy(kmap(pages[i]) + bvec->bv_offset,
 			kmap(bvec->bv_page) + bvec->bv_offset, bvec->bv_len);
+		flush_kernel_dcache_page(pages[i]);
 		kunmap(pages[i]);
 		kunmap(bvec->bv_page);
 	}
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3184360..3adb64f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -813,10 +813,12 @@ static void copy_data(int frombio, struc
 			
 		if (clen > 0) {
 			char *ba = __bio_kmap_atomic(bio, i, KM_USER0);
-			if (frombio)
+			if (frombio) {
 				memcpy(pa+page_offset, ba+b_offset, clen);
-			else
+			} else {
 				memcpy(ba+b_offset, pa+page_offset, clen);
+				flush_kernel_dcache_page(kmap_atomic_to_page(ba));
+			}
 			__bio_kunmap_atomic(ba, KM_USER0);
 		}
 		if (clen < len) /* hit end of page */
diff --git a/drivers/md/raid6main.c b/drivers/md/raid6main.c
index bc69355..b9700bd 100644
--- a/drivers/md/raid6main.c
+++ b/drivers/md/raid6main.c
@@ -727,10 +727,12 @@ static void copy_data(int frombio, struc
 
 		if (clen > 0) {
 			char *ba = __bio_kmap_atomic(bio, i, KM_USER0);
-			if (frombio)
+			if (frombio) {
 				memcpy(pa+page_offset, ba+b_offset, clen);
-			else
+			} else {
 				memcpy(ba+b_offset, pa+page_offset, clen);
+				flush_kernel_dcache_page(kmap_atomic_to_page(ba));
+			}
 			__bio_kunmap_atomic(ba, KM_USER0);
 		}
 		if (clen < len) /* hit end of page */
-- 
1.3.2


