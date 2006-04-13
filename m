Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWDMUgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWDMUgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWDMUf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:35:59 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:37142 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964970AbWDMUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:35:49 -0400
Date: Thu, 13 Apr 2006 16:35:46 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 04/08] dm: use spinlock for _minor_lock
Message-ID: <20060413203546.GA3220@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 In order to truly serialize reference counting and properly handle the final
 dm_put, we need to use atomic_dec_and_lock, since another thread of execution
 can attempt to "resurrect" a potentially dead mapped_device.

 This patch replaces the _minor_lock mutex with a spinlock, and leverages
 atomic_dec_and_lock to properly serialize reference counting.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
--
 drivers/md/dm.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff -ruNpX ../dontdiff linux-2.6.16-staging1/drivers/md/dm.c linux-2.6.16-staging2/drivers/md/dm.c
--- linux-2.6.16-staging1/drivers/md/dm.c	2006-04-13 16:18:19.000000000 -0400
+++ linux-2.6.16-staging2/drivers/md/dm.c	2006-04-13 16:18:19.000000000 -0400
@@ -23,6 +23,7 @@ static const char *_name = DM_NAME;
 static unsigned int major = 0;
 static unsigned int _major = 0;
 
+static DEFINE_SPINLOCK(_minor_lock);
 /*
  * One of these is allocated per bio.
  */
@@ -697,14 +698,13 @@ static int dm_any_congested(void *conges
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
-static DECLARE_MUTEX(_minor_lock);
 static DEFINE_IDR(_minor_idr);
 
 static void free_minor(unsigned int minor)
 {
-	down(&_minor_lock);
+	spin_lock(&_minor_lock);
 	idr_remove(&_minor_idr, minor);
-	up(&_minor_lock);
+	spin_unlock(&_minor_lock);
 }
 
 /*
@@ -721,7 +721,7 @@ static int specific_minor(struct mapped_
 	if (!r)
 		return -ENOMEM;
 
-	down(&_minor_lock);
+	spin_lock(&_minor_lock);
 
 	if (idr_find(&_minor_idr, minor)) {
 		r = -EBUSY;
@@ -740,7 +740,7 @@ static int specific_minor(struct mapped_
 	}
 
 out:
-	up(&_minor_lock);
+	spin_unlock(&_minor_lock);
 	return r;
 }
 
@@ -753,7 +753,7 @@ static int next_free_minor(struct mapped
 	if (!r)
 		return -ENOMEM;
 
-	down(&_minor_lock);
+	spin_lock(&_minor_lock);
 
 	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m);
 	if (r) {
@@ -769,7 +769,7 @@ static int next_free_minor(struct mapped
 	*minor = m;
 
 out:
-	up(&_minor_lock);
+	spin_unlock(&_minor_lock);
 	return r;
 }
 
@@ -839,9 +839,9 @@ static struct mapped_device *alloc_dev(u
 	init_waitqueue_head(&md->eventq);
 
 	/* Populate the mapping, nobody knows we exist yet */
-	down(&_minor_lock);
+	spin_lock(&_minor_lock);
 	r = idr_replace(&_minor_idr, md, minor);
-	up(&_minor_lock);
+	spin_unlock(&_minor_lock);
 	BUG_ON(r < 0);
 
 	return md;
@@ -964,13 +964,13 @@ static struct mapped_device *dm_find_md(
 	if (MAJOR(dev) != _major || minor >= (1 << MINORBITS))
 		return NULL;
 
-	down(&_minor_lock);
+	spin_lock(&_minor_lock);
 
 	md = idr_find(&_minor_idr, minor);
 	if (md && (md == MINOR_ALLOCED || (dm_disk(md)->first_minor != minor)))
 		md = NULL;
 
-	up(&_minor_lock);
+	spin_unlock(&_minor_lock);
 
 	return md;
 }
@@ -1010,10 +1010,9 @@ void dm_put(struct mapped_device *md)
 {
 	struct dm_table *map = dm_get_table(md);
 
-	if (atomic_dec_and_test(&md->holders)) {
-		down(&_minor_lock);
+	if (atomic_dec_and_lock(&md->holders, &_minor_lock)) {
 		idr_replace(&_minor_idr, MINOR_ALLOCED, md->disk->first_minor);
-		up(&_minor_lock);
+		spin_unlock(&_minor_lock);
 		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);
 			dm_table_postsuspend_targets(map);
