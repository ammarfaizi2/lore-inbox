Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWDZCLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWDZCLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWDZCL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:11:26 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:14988 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932347AbWDZCLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:11:23 -0400
Message-Id: <20060426021122.069267000@localhost.localdomain>
References: <20060426021059.235216000@localhost.localdomain>
Date: Wed, 26 Apr 2006 10:11:02 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Akinobu Mita <mita@miraclelinux.com>,
       Jens Axboe <axboe@suse.de>, Greg KH <greg@kroah.com>
Subject: [patch 3/3] use kref for bio
Content-Disposition: inline; filename=kref-bio.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use kref for reference counter of bio.
This patch also removes BUG_ON() for freeing unreferenced bio.
But kref can detect it if CONFIG_DEBUG_SLAB is enabled.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
CC: Jens Axboe <axboe@suse.de>
CC: Greg KH <greg@kroah.com>

 Documentation/block/biodoc.txt |    2 +-
 fs/bio.c                       |   17 ++++++++++-------
 fs/xfs/linux-2.6/xfs_aops.c    |    1 -
 include/linux/bio.h            |    4 ++--
 4 files changed, 13 insertions(+), 11 deletions(-)

Index: 2.6-git/Documentation/block/biodoc.txt
===================================================================
--- 2.6-git.orig/Documentation/block/biodoc.txt
+++ 2.6-git/Documentation/block/biodoc.txt
@@ -462,7 +462,7 @@ struct bio {
                                         used as index into pool */
        struct bio_vec   *bi_io_vec;  /* the actual vec list */
        bio_end_io_t	*bi_end_io;  /* bi_end_io (bio) */
-       atomic_t		bi_cnt;	     /* pin count: free when it hits zero */
+       struct kref	bi_kref;     /* pin count */
        void             *bi_private;
        bio_destructor_t *bi_destructor; /* bi_destructor (bio) */
 };
Index: 2.6-git/fs/bio.c
===================================================================
--- 2.6-git.orig/fs/bio.c
+++ 2.6-git/fs/bio.c
@@ -139,7 +139,7 @@ void bio_init(struct bio *bio)
 	bio->bi_size = 0;
 	bio->bi_max_vecs = 0;
 	bio->bi_end_io = NULL;
-	atomic_set(&bio->bi_cnt, 1);
+	kref_init(&bio->bi_kref);
 	bio->bi_private = NULL;
 }
 
@@ -208,6 +208,14 @@ void zero_fill_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(zero_fill_bio);
 
+static void release_bio(struct kref *kref)
+{
+	struct bio *bio = container_of(kref, struct bio, bi_kref);
+
+	bio->bi_next = NULL;
+	bio->bi_destructor(bio);
+}
+
 /**
  * bio_put - release a reference to a bio
  * @bio:   bio to release reference to
@@ -218,15 +226,10 @@ EXPORT_SYMBOL(zero_fill_bio);
  **/
 void bio_put(struct bio *bio)
 {
-	BIO_BUG_ON(!atomic_read(&bio->bi_cnt));
-
 	/*
 	 * last put frees it
 	 */
-	if (atomic_dec_and_test(&bio->bi_cnt)) {
-		bio->bi_next = NULL;
-		bio->bi_destructor(bio);
-	}
+	kref_put(&bio->bi_kref, release_bio);
 }
 
 inline int bio_phys_segments(request_queue_t *q, struct bio *bio)
Index: 2.6-git/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- 2.6-git.orig/fs/xfs/linux-2.6/xfs_aops.c
+++ 2.6-git/fs/xfs/linux-2.6/xfs_aops.c
@@ -272,7 +272,6 @@ xfs_end_bio(
 		return 1;
 
 	ASSERT(ioend);
-	ASSERT(atomic_read(&bio->bi_cnt) >= 1);
 
 	/* Toss bio and pass work off to an xfsdatad thread */
 	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
Index: 2.6-git/include/linux/bio.h
===================================================================
--- 2.6-git.orig/include/linux/bio.h
+++ 2.6-git/include/linux/bio.h
@@ -106,7 +106,7 @@ struct bio {
 	struct bio_vec		*bi_io_vec;	/* the actual vec list */
 
 	bio_end_io_t		*bi_end_io;
-	atomic_t		bi_cnt;		/* pin count */
+	struct kref		bi_kref;	/* pin count */
 
 	void			*bi_private;
 
@@ -249,7 +249,7 @@ struct bio {
  * returns. and then bio would be freed memory when if (bio->bi_flags ...)
  * runs
  */
-#define bio_get(bio)	atomic_inc(&(bio)->bi_cnt)
+#define bio_get(bio)	kref_get(&(bio)->bi_kref)
 
 
 /*

--
