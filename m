Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUBWKFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 05:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUBWKFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 05:05:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:976 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261899AbUBWKFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 05:05:33 -0500
Date: Mon, 23 Feb 2004 10:05:12 +0000
From: Joe Thornber <thornber@redhat.com>
To: Mike Christie <mikenc@us.ibm.com>
Cc: Joe Thornber <thornber@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/6] dm: endio method
Message-ID: <20040223100512.GB943@reti>
References: <20040220153145.GN27549@reti> <20040220153403.GO27549@reti> <40372BCE.7090708@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40372BCE.7090708@us.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

On Sat, Feb 21, 2004 at 01:58:38AM -0800, Mike Christie wrote:
> Saving and restoring bi_bdev is going to break multipath.

Yes, we'll have to fall back to plan A and use the map_context pointer
to hold the path being used (attached patch for illustration only).  I
had been hoping we could keep the map_context unused so that we could
allow the path selectors to use it.  I should have spotted this.

I'll also move the failed bio remap back to mpath_end_io(), so that
the context can be reused there (it moved to the daemon when we were
trying to do path testing in the kernel).

- Joe


--- diff/drivers/md/dm-mpath.c	2004-02-18 15:51:06.000000000 +0000
+++ source/drivers/md/dm-mpath.c	2004-02-23 09:58:31.000000000 +0000
@@ -219,7 +219,7 @@ static struct path *get_current_path(str
 	return path;
 }
 
-static int map_io(struct multipath *m, struct bio *bio)
+static int map_io(struct multipath *m, struct bio *bio, union map_info *map_context)
 {
 	struct path *path;
 
@@ -228,6 +228,7 @@ static int map_io(struct multipath *m, s
 		return -EIO;
 
 	bio->bi_bdev = path->dev->bdev;
+	map_context->ptr = path;
 	return 0;
 }
 
@@ -517,29 +518,13 @@ static int multipath_map(struct dm_targe
 	struct multipath *m = (struct multipath *) ti->private;
 
 	bio->bi_rw |= (1 << BIO_RW_FAILFAST);
-	r = map_io(m, bio);
+	r = map_io(m, bio, map_context);
 	if (r)
 		return r;
 
 	return 1;
 }
 
-/*
- * Only called on the error path.
- */
-static struct path *find_path(struct multipath *m, struct block_device *bdev)
-{
-	struct path *p;
-	struct priority_group *pg;
-
-	list_for_each_entry (pg, &m->priority_groups, list)
-		list_for_each_entry (p, &pg->paths, list)
-			if (p->dev->bdev == bdev)
-				return p;
-
-	return NULL;
-}
-
 static void fail_path(struct path *path)
 {
 	unsigned long flags;
@@ -570,8 +555,8 @@ static void fail_path(struct path *path)
 static int multipath_end_io(struct dm_target *ti, struct bio *bio,
 			    int error, union map_info *map_context)
 {
-	struct path *path;
 	struct multipath *m = (struct multipath *) ti->private;
+	struct path *path = (struct path *) map_context->ptr;
 
 	if (error) {
 		spin_lock(&m->lock);
@@ -581,7 +566,6 @@ static int multipath_end_io(struct dm_ta
 		}
 		spin_unlock(&m->lock);
 
-		path = find_path(m, bio->bi_bdev);
 		fail_path(path);
 
 		/* queue for the daemon to resubmit */
