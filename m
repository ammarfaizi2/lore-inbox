Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUFNSOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUFNSOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUFNSOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:14:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54224 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263709AbUFNSO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:14:27 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 2/5: Use structure assignments instead of memcpy
Date: Mon, 14 Jun 2004 13:17:36 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200406141309.31127.kevcorry@us.ibm.com>
In-Reply-To: <200406141309.31127.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406141317.36117.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use structure assignments instead of memcpy's.
[Suggested by akpm during kcopyd review.]

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm-raid1.c	2004-06-14 09:23:21.259282960 +0000
+++ source/drivers/md/dm-raid1.c	2004-06-14 09:29:56.946129416 +0000
@@ -850,9 +850,9 @@
 	struct bio_list reads, writes;
 
 	spin_lock(&ms->lock);
-	memcpy(&reads, &ms->reads, sizeof(reads));
+	reads = ms->reads;
+	writes = ms->writes;
 	bio_list_init(&ms->reads);
-	memcpy(&writes, &ms->writes, sizeof(writes));
 	bio_list_init(&ms->writes);
 	spin_unlock(&ms->lock);
 
--- diff/drivers/md/dm-snap.c	2004-06-14 09:23:21.261282656 +0000
+++ source/drivers/md/dm-snap.c	2004-06-14 09:29:56.947129264 +0000
@@ -612,7 +612,7 @@
 			error_bios(bio_list_get(&pe->snapshot_bios));
 			goto out;
 		}
-		memcpy(e, &pe->e, sizeof(*e));
+		*e = pe->e;
 
 		/*
 		 * Add a proper exception, and remove the
--- diff/drivers/md/dm-table.c	2004-06-14 09:23:21.265282048 +0000
+++ source/drivers/md/dm-table.c	2004-06-14 09:29:56.948129112 +0000
@@ -400,7 +400,7 @@
 	struct dm_dev dd_copy;
 	dev_t dev = dd->bdev->bd_dev;
 
-	memcpy(&dd_copy, dd, sizeof(dd_copy));
+	dd_copy = *dd;
 
 	dd->mode |= new_mode;
 	dd->bdev = NULL;
@@ -408,7 +408,7 @@
 	if (!r)
 		close_dev(&dd_copy);
 	else
-		memcpy(dd, &dd_copy, sizeof(dd_copy));
+		*dd = dd_copy;
 
 	return r;
 }
--- diff/drivers/md/dm.c	2004-06-14 09:29:23.019287080 +0000
+++ source/drivers/md/dm.c	2004-06-14 09:29:56.949128960 +0000
@@ -394,7 +394,7 @@
 	struct bio_vec *bv = bio->bi_io_vec + idx;
 
 	clone = bio_alloc(GFP_NOIO, 1);
-	memcpy(clone->bi_io_vec, bv, sizeof(*bv));
+	*clone->bi_io_vec = *bv;
 
 	clone->bi_sector = sector;
 	clone->bi_bdev = bio->bi_bdev;
--- diff/drivers/md/kcopyd.c	2004-06-14 09:29:23.020286928 +0000
+++ source/drivers/md/kcopyd.c	2004-06-14 09:29:56.950128808 +0000
@@ -476,7 +476,7 @@
 		int i;
 		struct kcopyd_job *sub_job = mempool_alloc(_job_pool, GFP_NOIO);
 
-		memcpy(sub_job, job, sizeof(*job));
+		*sub_job = *job;
 		sub_job->source.sector += progress;
 		sub_job->source.count = count;
 
@@ -536,7 +536,7 @@
 	job->write_err = 0;
 	job->rw = READ;
 
-	memcpy(&job->source, from, sizeof(*from));
+	job->source = *from;
 
 	job->num_dests = num_dests;
 	memcpy(&job->dests, dests, sizeof(*dests) * num_dests);
