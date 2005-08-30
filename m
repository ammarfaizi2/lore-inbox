Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVH3X4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVH3X4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVH3X4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:56:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:928 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932289AbVH3X4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:56:44 -0400
Date: Wed, 31 Aug 2005 09:48:23 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050830234823.GF780@frodo>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824092838.GB28272@suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Wed, Aug 24, 2005 at 11:28:39AM +0200, Jens Axboe wrote:
> Ok, updated version.

One thing I found a bit awkward was the way its putting all inodes
in the root of the relayfs namespace, with the cpuid tacked on the
end of the bdevname - I was a bit confused at first when a trace of
sdd on my 4P box spontaneously created files for "partitions" sdd0,
sdd1, sdd2, and sdd3 ;).

I suppose if many more users of relayfs spring into existance, this
is going to get quite ugly.  Below is a patch that aligns the names
to the conventions used in sysfs; so, for example, when running two
traces simultaneously on /dev/sdd and /dev/sdb, instead of this:

# find /relay
/relay
/relay/sdd3
/relay/sdd2
/relay/sdd1
/relay/sdd0
/relay/sdb3
/relay/sdb2
/relay/sdb1
/relay/sdb0

it now uses this...

# find /relay
/relay
/relay/block
/relay/block/sdd
/relay/block/sdd/trace3
/relay/block/sdd/trace2
/relay/block/sdd/trace1
/relay/block/sdd/trace0
/relay/block/sdb
/relay/block/sdb/trace3
/relay/block/sdb/trace2
/relay/block/sdb/trace1
/relay/block/sdb/trace0

and does the correct dynamic setup and teardown of the hierarchy
as the userspace tool starts and stops tracing.  I had to modify
the relayfs rmdir code a bit to make this work properly, I'll
send a separate patch for that shortly.

> http://www.kernel.org/pub/linux/kernel/people/axboe/tools/blktrace.c
> 
> has been updated as well, the protocol version was increased to
> accomodate the trace structure changes.

I have the associated userspace change for this, as well as several
other fixes and tweaks for your tool - if you could slap a copyright
and license notice onto that source (pretty please? :) I'll send 'em
right along.

cheers.

-- 
Nathan

Index: 2.6.x-xfs/drivers/block/blktrace.c
===================================================================
--- 2.6.x-xfs.orig/drivers/block/blktrace.c
+++ 2.6.x-xfs/drivers/block/blktrace.c
@@ -40,6 +40,50 @@ void __blk_add_trace(struct blk_trace *b
 	local_irq_restore(flags);
 }
 
+static struct dentry * blk_tree_root;
+static DEFINE_SPINLOCK(blk_tree_lock);
+
+static inline void blk_remove_root(void)
+{
+	if (relayfs_remove_dir(blk_tree_root) != -ENOTEMPTY)
+		blk_tree_root = NULL;
+}
+
+static void blk_remove_tree(struct dentry *dir)
+{
+	spin_lock(&blk_tree_lock);
+	relayfs_remove_dir(dir);
+	blk_remove_root();
+	spin_unlock(&blk_tree_lock);
+}
+
+static struct dentry *blk_create_tree(const char *blk_name)
+{
+	struct dentry *dir;
+
+	spin_lock(&blk_tree_lock);
+	if (!blk_tree_root) {
+		blk_tree_root = relayfs_create_dir("block", NULL);
+		if (!blk_tree_root) {
+			spin_unlock(&blk_tree_lock);
+			return NULL;
+		}
+	}
+	dir = relayfs_create_dir(blk_name, blk_tree_root);
+	if (!dir)
+		blk_remove_root();
+	spin_unlock(&blk_tree_lock);
+
+	return dir;
+}
+
+void blk_cleanup_trace(struct blk_trace *bt)
+{
+	relay_close(bt->rchan);
+	blk_remove_tree(bt->dir);
+	kfree(bt);
+}
+
 int blk_stop_trace(struct block_device *bdev)
 {
 	request_queue_t *q = bdev_get_queue(bdev);
@@ -61,10 +105,8 @@ int blk_stop_trace(struct block_device *
 
 	up(&bdev->bd_sem);
 
-	if (bt) {
-		relay_close(bt->rchan);
-		kfree(bt);
-	}
+	if (bt)
+		blk_cleanup_trace(bt);
 
 	return ret;
 }
@@ -74,6 +116,7 @@ int blk_start_trace(struct block_device 
 	request_queue_t *q = bdev_get_queue(bdev);
 	struct blk_user_trace_setup buts;
 	struct blk_trace *bt = NULL;
+	struct dentry *dir = NULL;
 	char b[BDEVNAME_SIZE];
 	int ret;
 
@@ -101,11 +144,16 @@ int blk_start_trace(struct block_device 
 	if (!bt)
 		goto err;
 
+	ret = -ENOENT;
+	dir = blk_create_tree(bdevname(bdev, b));
+	if (!dir)
+		goto err;
+
+	bt->dir = dir;
 	atomic_set(&bt->sequence, 0);
 
-	bt->rchan = relay_open(bdevname(bdev, b), NULL, buts.buf_size,
-				buts.buf_nr, NULL);
 	ret = -EIO;
+	bt->rchan = relay_open("trace", dir, buts.buf_size, buts.buf_nr, NULL);
 	if (!bt->rchan)
 		goto err;
 
@@ -122,6 +170,8 @@ int blk_start_trace(struct block_device 
 
 err:
 	up(&bdev->bd_sem);
+	if (dir)
+		blk_remove_tree(dir);
 	if (bt)
 		kfree(bt);
 	return ret;
Index: 2.6.x-xfs/include/linux/blktrace.h
===================================================================
--- 2.6.x-xfs.orig/include/linux/blktrace.h
+++ 2.6.x-xfs/include/linux/blktrace.h
@@ -71,6 +71,7 @@ struct blk_io_trace {
 };
 
 struct blk_trace {
+	struct dentry *dir;
 	struct rchan *rchan;
 	atomic_t sequence;
 	u16 act_mask;
@@ -89,6 +90,7 @@ struct blk_user_trace_setup {
 #if defined(CONFIG_BLK_DEV_IO_TRACE)
 extern int blk_start_trace(struct block_device *, char __user *);
 extern int blk_stop_trace(struct block_device *);
+extern void blk_cleanup_trace(struct blk_trace *);
 extern void __blk_add_trace(struct blk_trace *, sector_t, int, int, u32, int, int, char *);
 
 static inline void blk_add_trace_rq(struct request_queue *q, struct request *rq,
@@ -137,6 +139,7 @@ static inline void blk_add_trace_generic
 #else /* !CONFIG_BLK_DEV_IO_TRACE */
 #define blk_start_trace(bdev, arg)		(-EINVAL)
 #define blk_stop_trace(bdev)			(-EINVAL)
+#define blk_cleanup_trace(bt)			do { } while (0)
 #define blk_add_trace_rq(q, rq, what)		do { } while (0)
 #define blk_add_trace_bio(q, rq, what)		do { } while (0)
 #define blk_add_trace_generic(q, rq, rw, what)	do { } while (0)
Index: 2.6.x-xfs/drivers/block/ll_rw_blk.c
===================================================================
--- 2.6.x-xfs.orig/drivers/block/ll_rw_blk.c
+++ 2.6.x-xfs/drivers/block/ll_rw_blk.c
@@ -1625,8 +1625,7 @@ void blk_cleanup_queue(request_queue_t *
 		__blk_queue_free_tags(q);
 
 	if (q->blk_trace) {
-		relay_close(q->blk_trace->rchan);
-		kfree(q->blk_trace);
+		blk_cleanup_trace(q->blk_trace);
 		q->blk_trace = NULL;
 	}
 
