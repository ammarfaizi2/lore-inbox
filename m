Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbUCKAHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbUCKAGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:06:45 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:36236 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S262896AbUCKAFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:05:13 -0500
Date: Thu, 11 Mar 2004 01:05:07 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Joe Thornber <thornber@redhat.com>
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040311000507.GE18222@drinkel.cistron.nl>
References: <20040310124507.GU4949@suse.de> <20040310130046.2df24f0e.akpm@osdl.org> <20040310210207.GL15087@suse.de> <c2o212$4h0$1@news.cistron.nl> <20040310150542.13d71a39.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040310150542.13d71a39.akpm@osdl.org> (from akpm@osdl.org on Thu, Mar 11, 2004 at 00:05:42 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004 00:05:42, Andrew Morton wrote:
> "Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
> >
> > 
> > With the latest patches from Joe it would be more like
> > 
> > 	map = dm_get_table(md);
> > 	if (map) {
> > 		dm_table_unplug_all(map);
> > 		dm_table_put(map);
> > 	}
> > 
> > No lock ranking issues, you just get a refcounted map (table, really).
> 
> Ah, OK.  Jens, you'll be needing this (on rc2-mm1):
> 
> dm.c: protect md->map with a rw spin lock rather than the md->lock
> semaphore.  Also ensure that everyone accesses md->map through
> dm_get_table(), rather than directly.
> 
>  25-akpm/drivers/md/dm-table.c |    3 +
>  25-akpm/drivers/md/dm.c       |   88 +++++++++++++++++++++++++-----------------

.. and this final one on top of it, presumably.

See https://www.redhat.com/archives/dm-devel/2004-March/msg00036.html

dm.c: remove __dm_request (merge with previous patch).
--- diff/drivers/md/dm.c	2004-03-08 15:48:05.000000000 +0000
+++ source/drivers/md/dm.c	2004-03-09 09:40:37.000000000 +0000
@@ -506,8 +506,13 @@ static void __split_bio(struct mapped_de
 {
 	struct clone_info ci;
 
-	ci.md = md;
 	ci.map = dm_get_table(md);
+	if (!ci.map) {
+		bio_io_error(bio, bio->bi_size);
+		return;
+	}
+
+	ci.md = md;
 	ci.bio = bio;
 	ci.io = alloc_io(md);
 	ci.io->error = 0;
@@ -530,17 +535,6 @@ static void __split_bio(struct mapped_de
  * CRUD END
  *---------------------------------------------------------------*/
 
-
-static inline void __dm_request(struct mapped_device *md, struct bio *bio)
-{
-	if (!md->map) {
-		bio_io_error(bio, bio->bi_size);
-		return;
-	}
-
-	__split_bio(md, bio);
-}
-
 /*
  * The request function that just remaps the bio built up by
  * dm_merge_bvec.
@@ -579,7 +573,7 @@ static int dm_request(request_queue_t *q
 		down_read(&md->lock);
 	}
 
-	__dm_request(md, bio);
+	__split_bio(md, bio);
 	up_read(&md->lock);
 	return 0;
 }
@@ -591,7 +585,6 @@ static int dm_any_congested(void *conges
 	struct dm_table *map = dm_get_table(md);
 
 	if (!map || test_bit(DMF_BLOCK_IO, &md->flags))
-		/* FIXME: shouldn't suspended count a congested ? */
 		r = bdi_bits;
 	else
 		r = dm_table_any_congested(map, bdi_bits);
@@ -850,7 +843,7 @@ static void __flush_deferred_io(struct m
 	while (c) {
 		n = c->bi_next;
 		c->bi_next = NULL;
-		__dm_request(md, c);
+		__split_bio(md, c);
 		c = n;
 	}
 }


Mike.
