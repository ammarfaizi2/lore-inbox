Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWIFXAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWIFXAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWIFXAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:00:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:57035 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751799AbWIFXAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:00:51 -0400
Date: Wed, 6 Sep 2006 15:55:48 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jeffm@suse.com, agk@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/37] dm: change minor_lock to spinlock
Message-ID: <20060906225548.GL15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-change-minor_lock-to-spinlock.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

While removing a device, another another thread might attempt to resurrect it.

This patch replaces the _minor_lock mutex with a spinlock and uses
atomic_dec_and_lock() to serialize reference counting in dm_put().

[akpm: too late for 2.6.17 - suitable for 2.6.17.x after it has settled]

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/md/dm.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--- linux-2.6.17.11.orig/drivers/md/dm.c
+++ linux-2.6.17.11/drivers/md/dm.c
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

--
