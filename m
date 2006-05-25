Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWEYTMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWEYTMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWEYTMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:12:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030347AbWEYTML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:12:11 -0400
Date: Thu, 25 May 2006 20:12:02 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/10] dm: fix idr minor allocation
Message-ID: <20060525191202.GU4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

One part of the system can attempt to use a mapped device before
another has finished initialising it or while it is being freed.

This patch introduces a place holder value, MINOR_ALLOCED, to mark the
minor as allocated but in a state where it can't be used, such as
mid-allocation or mid-free.  At the end of the initialization, it
replaces the place holder with the pointer to the mapped_device,
making it available to the rest of the dm subsystem.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm.c	2006-05-23 18:16:30.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm.c	2006-05-23 18:16:42.000000000 +0100
@@ -54,6 +54,8 @@ union map_info *dm_get_mapinfo(struct bi
         return NULL;
 }
 
+#define MINOR_ALLOCED ((void *)-1)
+
 /*
  * Bits for the md->flags field.
  */
@@ -777,7 +779,7 @@ static int specific_minor(struct mapped_
 		goto out;
 	}
 
-	r = idr_get_new_above(&_minor_idr, md, minor, &m);
+	r = idr_get_new_above(&_minor_idr, MINOR_ALLOCED, minor, &m);
 	if (r) {
 		goto out;
 	}
@@ -806,7 +808,7 @@ static int next_free_minor(struct mapped
 		goto out;
 	}
 
-	r = idr_get_new(&_minor_idr, md, &m);
+	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m);
 	if (r) {
 		goto out;
 	}
@@ -833,6 +835,7 @@ static struct mapped_device *alloc_dev(u
 {
 	int r;
 	struct mapped_device *md = kmalloc(sizeof(*md), GFP_KERNEL);
+	void *old_md;
 
 	if (!md) {
 		DMWARN("unable to allocate device, out of memory.");
@@ -888,6 +891,13 @@ static struct mapped_device *alloc_dev(u
 	init_waitqueue_head(&md->wait);
 	init_waitqueue_head(&md->eventq);
 
+	/* Populate the mapping, nobody knows we exist yet */
+	mutex_lock(&_minor_lock);
+	old_md = idr_replace(&_minor_idr, md, minor);
+	mutex_unlock(&_minor_lock);
+
+	BUG_ON(old_md != MINOR_ALLOCED);
+
 	return md;
 
  bad4:
@@ -1018,7 +1028,7 @@ static struct mapped_device *dm_find_md(
 	mutex_lock(&_minor_lock);
 
 	md = idr_find(&_minor_idr, minor);
-	if (!md || (dm_disk(md)->first_minor != minor))
+	if (md && (md == MINOR_ALLOCED || (dm_disk(md)->first_minor != minor)))
 		md = NULL;
 
 	mutex_unlock(&_minor_lock);
@@ -1057,6 +1067,9 @@ void dm_put(struct mapped_device *md)
 
 	if (atomic_dec_and_test(&md->holders)) {
 		map = dm_get_table(md);
+		mutex_lock(&_minor_lock);
+		idr_replace(&_minor_idr, MINOR_ALLOCED, dm_disk(md)->first_minor);
+		mutex_unlock(&_minor_lock);
 		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);
 			dm_table_postsuspend_targets(map);
