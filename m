Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUBJRGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUBJRE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:04:58 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:777 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266001AbUBJRAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:00:31 -0500
Date: Tue, 10 Feb 2004 16:59:33 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 3/10] dm: Get rid of struct dm_deferred_io in dm.c
Message-ID: <20040210165933.GI27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of struct dm_deferred_io in dm.c.  [Chripstophe Saout]
--- diff/drivers/md/dm.c	2004-02-10 16:11:24.000000000 +0000
+++ source/drivers/md/dm.c	2004-02-10 16:11:30.000000000 +0000
@@ -27,11 +27,6 @@
 	atomic_t io_count;
 };
 
-struct deferred_io {
-	struct bio *bio;
-	struct deferred_io *next;
-};
-
 /*
  * Bits for the md->flags field.
  */
@@ -52,7 +47,7 @@
 	 */
 	atomic_t pending;
 	wait_queue_head_t wait;
-	struct deferred_io *deferred;
+	struct bio *deferred;
 
 	/*
 	 * The current mapping.
@@ -188,38 +183,20 @@
 	mempool_free(io, md->io_pool);
 }
 
-static inline struct deferred_io *alloc_deferred(void)
-{
-	return kmalloc(sizeof(struct deferred_io), GFP_NOIO);
-}
-
-static inline void free_deferred(struct deferred_io *di)
-{
-	kfree(di);
-}
-
 /*
  * Add the bio to the list of deferred io.
  */
 static int queue_io(struct mapped_device *md, struct bio *bio)
 {
-	struct deferred_io *di;
-
-	di = alloc_deferred();
-	if (!di)
-		return -ENOMEM;
-
 	down_write(&md->lock);
 
 	if (!test_bit(DMF_BLOCK_IO, &md->flags)) {
 		up_write(&md->lock);
-		free_deferred(di);
 		return 1;
 	}
 
-	di->bio = bio;
-	di->next = md->deferred;
-	md->deferred = di;
+	bio->bi_next = md->deferred;
+	md->deferred = bio;
 
 	up_write(&md->lock);
 	return 0;		/* deferred successfully */
@@ -743,14 +720,14 @@
 /*
  * Requeue the deferred bios by calling generic_make_request.
  */
-static void flush_deferred_io(struct deferred_io *c)
+static void flush_deferred_io(struct bio *c)
 {
-	struct deferred_io *n;
+	struct bio *n;
 
 	while (c) {
-		n = c->next;
-		generic_make_request(c->bio);
-		free_deferred(c);
+		n = c->bi_next;
+		c->bi_next = NULL;
+		generic_make_request(c);
 		c = n;
 	}
 }
@@ -832,7 +809,7 @@
 
 int dm_resume(struct mapped_device *md)
 {
-	struct deferred_io *def;
+	struct bio *def;
 
 	down_write(&md->lock);
 	if (!md->map ||
