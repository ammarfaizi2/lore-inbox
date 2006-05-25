Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWEYTPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWEYTPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWEYTPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:15:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48011 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030355AbWEYTPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:15:32 -0400
Date: Thu, 25 May 2006 20:15:29 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/10] dm: change minor_lock to spinlock
Message-ID: <20060525191529.GW4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

While removing a device, another another thread might attempt to
resurrect it.

This patch replaces the _minor_lock mutex with a spinlock and uses
atomic_dec_and_lock() to serialize reference counting in dm_put().

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm.c	2006-05-23 18:16:44.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm.c	2006-05-23 18:16:46.000000000 +0100
@@ -26,6 +26,7 @@ static const char *_name = DM_NAME;
 static unsigned int major = 0;
 static unsigned int _major = 0;
 
+static DEFINE_SPINLOCK(_minor_lock);
 /*
  * One of these is allocated per bio.
  */
@@ -746,14 +747,13 @@ static int dm_any_congested(void *conges
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
-static DEFINE_MUTEX(_minor_lock);
 static DEFINE_IDR(_minor_idr);
 
 static void free_minor(unsigned int minor)
 {
-	mutex_lock(&_minor_lock);
+	spin_lock(&_minor_lock);
 	idr_remove(&_minor_idr, minor);
-	mutex_unlock(&_minor_lock);
+	spin_unlock(&_minor_lock);
 }
 
 /*
@@ -770,7 +770,7 @@ static int specific_minor(struct mapped_
 	if (!r)
 		return -ENOMEM;
 
-	mutex_lock(&_minor_lock);
+	spin_lock(&_minor_lock);
 
 	if (idr_find(&_minor_idr, minor)) {
 		r = -EBUSY;
@@ -788,7 +788,7 @@ static int specific_minor(struct mapped_
 	}
 
 out:
-	mutex_unlock(&_minor_lock);
+	spin_unlock(&_minor_lock);
 	return r;
 }
 
@@ -801,7 +801,7 @@ static int next_free_minor(struct mapped
 	if (!r)
 		return -ENOMEM;
 
-	mutex_lock(&_minor_lock);
+	spin_lock(&_minor_lock);
 
 	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m);
 	if (r) {
@@ -817,7 +817,7 @@ static int next_free_minor(struct mapped
 	*minor = m;
 
 out:
-	mutex_unlock(&_minor_lock);
+	spin_unlock(&_minor_lock);
 	return r;
 }
 
@@ -887,9 +887,9 @@ static struct mapped_device *alloc_dev(u
 	init_waitqueue_head(&md->eventq);
 
 	/* Populate the mapping, nobody knows we exist yet */
-	mutex_lock(&_minor_lock);
+	spin_lock(&_minor_lock);
 	old_md = idr_replace(&_minor_idr, md, minor);
-	mutex_unlock(&_minor_lock);
+	spin_unlock(&_minor_lock);
 
 	BUG_ON(old_md != MINOR_ALLOCED);
 
@@ -1020,13 +1020,13 @@ static struct mapped_device *dm_find_md(
 	if (MAJOR(dev) != _major || minor >= (1 << MINORBITS))
 		return NULL;
 
-	mutex_lock(&_minor_lock);
+	spin_lock(&_minor_lock);
 
 	md = idr_find(&_minor_idr, minor);
 	if (md && (md == MINOR_ALLOCED || (dm_disk(md)->first_minor != minor)))
 		md = NULL;
 
-	mutex_unlock(&_minor_lock);
+	spin_unlock(&_minor_lock);
 
 	return md;
 }
@@ -1060,11 +1060,10 @@ void dm_put(struct mapped_device *md)
 {
 	struct dm_table *map;
 
-	if (atomic_dec_and_test(&md->holders)) {
+	if (atomic_dec_and_lock(&md->holders, &_minor_lock)) {
 		map = dm_get_table(md);
-		mutex_lock(&_minor_lock);
 		idr_replace(&_minor_idr, MINOR_ALLOCED, dm_disk(md)->first_minor);
-		mutex_unlock(&_minor_lock);
+		spin_unlock(&_minor_lock);
 		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);
 			dm_table_postsuspend_targets(map);
