Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbVKRUEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbVKRUEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbVKRUEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:04:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37854 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161163AbVKRUEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:04:24 -0500
Date: Fri, 18 Nov 2005 20:04:11 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jonathan E Brassow <jbrassow@redhat.com>
Subject: [PATCH] device-mapper raid1: add default mirror
Message-ID: <20051118200411.GS11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jonathan E Brassow <jbrassow@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new field to the mirror_set (default_mirror)
to store the default mirror.

(A subsequent patch will allow us to change the default mirror
in the event of a failure.)

From: Jonathan E Brassow <jbrassow@redhat.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm-raid1.c	2005-11-18 20:01:05.000000000 +0000
+++ linux-2.6.14/drivers/md/dm-raid1.c	2005-11-18 20:01:26.000000000 +0000
@@ -562,6 +562,8 @@ struct mirror_set {
 	region_t nr_regions;
 	int in_sync;
 
+	struct mirror *default_mirror;	/* Default mirror */
+
 	unsigned int nr_mirrors;
 	struct mirror mirror[0];
 };
@@ -611,7 +613,7 @@ static int recover(struct mirror_set *ms
 	unsigned long flags = 0;
 
 	/* fill in the source */
-	m = ms->mirror + DEFAULT_MIRROR;
+	m = ms->default_mirror;
 	from.bdev = m->dev->bdev;
 	from.sector = m->offset + region_to_sector(reg->rh, reg->key);
 	if (reg->key == (ms->nr_regions - 1)) {
@@ -627,7 +629,7 @@ static int recover(struct mirror_set *ms
 
 	/* fill in the destinations */
 	for (i = 0, dest = to; i < ms->nr_mirrors; i++) {
-		if (i == DEFAULT_MIRROR)
+		if (&ms->mirror[i] == ms->default_mirror)
 			continue;
 
 		m = ms->mirror + i;
@@ -682,7 +684,7 @@ static void do_recovery(struct mirror_se
 static struct mirror *choose_mirror(struct mirror_set *ms, sector_t sector)
 {
 	/* FIXME: add read balancing */
-	return ms->mirror + DEFAULT_MIRROR;
+	return ms->default_mirror;
 }
 
 /*
@@ -709,7 +711,7 @@ static void do_reads(struct mirror_set *
 		if (rh_in_sync(&ms->rh, region, 0))
 			m = choose_mirror(ms, bio->bi_sector);
 		else
-			m = ms->mirror + DEFAULT_MIRROR;
+			m = ms->default_mirror;
 
 		map_bio(ms, m, bio);
 		generic_make_request(bio);
@@ -833,7 +835,7 @@ static void do_writes(struct mirror_set 
 		rh_delay(&ms->rh, bio);
 
 	while ((bio = bio_list_pop(&nosync))) {
-		map_bio(ms, ms->mirror + DEFAULT_MIRROR, bio);
+		map_bio(ms, ms->default_mirror, bio);
 		generic_make_request(bio);
 	}
 }
@@ -900,6 +902,7 @@ static struct mirror_set *alloc_context(
 	ms->nr_mirrors = nr_mirrors;
 	ms->nr_regions = dm_sector_div_up(ti->len, region_size);
 	ms->in_sync = 0;
+	ms->default_mirror = &ms->mirror[DEFAULT_MIRROR];
 
 	if (rh_init(&ms->rh, ms, dl, region_size, ms->nr_regions)) {
 		ti->error = "dm-mirror: Error creating dirty region hash";
