Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUFNSSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUFNSSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUFNSRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:17:52 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:29906 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263740AbUFNSP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:15:27 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 4/5: dm-raid1.c: Make delayed_bios a bio_list
Date: Mon, 14 Jun 2004 13:18:33 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200406141309.31127.kevcorry@us.ibm.com>
In-Reply-To: <200406141309.31127.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406141318.33193.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-raid1.c: Make struct region::delayed_bios a bio_list instead of a bio*.
This will ensure the queued bios are kept in the proper order.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm-raid1.c	2004-06-14 09:29:56.946129416 +0000
+++ source/drivers/md/dm-raid1.c	2004-06-14 09:30:12.916701520 +0000
@@ -103,7 +103,7 @@
 	struct list_head list;
 
 	atomic_t pending;
-	struct bio *delayed_bios;
+	struct bio_list delayed_bios;
 };
 
 /*
@@ -244,7 +244,7 @@
 	INIT_LIST_HEAD(&nreg->list);
 
 	atomic_set(&nreg->pending, 0);
-	nreg->delayed_bios = NULL;
+	bio_list_init(&nreg->delayed_bios);
 	write_lock_irq(&rh->hash_lock);
 
 	reg = __rh_lookup(rh, region);
@@ -310,14 +310,12 @@
 	return state == RH_CLEAN || state == RH_DIRTY;
 }
 
-static void dispatch_bios(struct mirror_set *ms, struct bio *bio)
+static void dispatch_bios(struct mirror_set *ms, struct bio_list *bio_list)
 {
-	struct bio *nbio;
+	struct bio *bio;
 
-	while (bio) {
-		nbio = bio->bi_next;
+	while ((bio = bio_list_pop(bio_list))) {
 		queue_bio(ms, bio, WRITE);
-		bio = nbio;
 	}
 }
 
@@ -361,7 +359,7 @@
 	list_for_each_entry_safe (reg, next, &recovered, list) {
 		rh->log->type->clear_region(rh->log, reg->key);
 		rh->log->type->complete_resync_work(rh->log, reg->key, 1);
-		dispatch_bios(rh->ms, reg->delayed_bios);
+		dispatch_bios(rh->ms, &reg->delayed_bios);
 		up(&rh->recovery_count);
 		mempool_free(reg, rh->region_pool);
 	}
@@ -516,8 +514,7 @@
 
 	read_lock(&rh->hash_lock);
 	reg = __rh_find(rh, bio_to_region(rh, bio));
-	bio->bi_next = reg->delayed_bios;
-	reg->delayed_bios = bio;
+	bio_list_add(&reg->delayed_bios, bio);
 	read_unlock(&rh->hash_lock);
 }
 
