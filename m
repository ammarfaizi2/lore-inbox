Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWIFXNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWIFXNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWIFXBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:01:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:62667 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964891AbWIFXBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:01:01 -0400
Date: Wed, 6 Sep 2006 15:55:35 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jeffm@suse.com, agk@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/37] dm: fix idr minor allocation
Message-ID: <20060906225535.GJ15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-fix-idr-minor-allocation.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

One part of the system can attempt to use a mapped device before another has
finished initialising it or while it is being freed.

This patch introduces a place holder value, MINOR_ALLOCED, to mark the minor
as allocated but in a state where it can't be used, such as mid-allocation or
mid-free.  At the end of the initialization, it replaces the place holder with
the pointer to the mapped_device, making it available to the rest of the dm
subsystem.

[akpm: too late for 2.6.17 - suitable for 2.6.17.x after it has settled]

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/md/dm.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- linux-2.6.17.11.orig/drivers/md/dm.c
+++ linux-2.6.17.11/drivers/md/dm.c
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

--
