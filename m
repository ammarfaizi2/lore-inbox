Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbSLRShz>; Wed, 18 Dec 2002 13:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267318AbSLRShz>; Wed, 18 Dec 2002 13:37:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11537 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267310AbSLRShr>;
	Wed, 18 Dec 2002 13:37:47 -0500
Date: Wed, 18 Dec 2002 10:43:07 -0800
From: Greg KH <greg@kroah.com>
To: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: [PATCH] add kobject to struct mapped_device
Message-ID: <20021218184307.GA32190@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a simple patch against 2.5.52 that adds the kobject structure to
struct mapped_device.  I did this for two reasons:
	- kobject provides proper reference counting for a structure
	  (not saying that struct mapped_device didn't get this correct,
	  but it's nice to use the core for these things).
	- This lets us tie into the block layer better to describe the
	  dm devices.

I originally hacked something together that added dm attributes to the
block devices themselves, but that wasn't proper, as it forced the dm
code to dig into the gendisk core too intrusively.  With this patch, it
is very easy to make a dm object be a child of the proper struct gendisk
object (which it already is logically, but that representation isn't
exported to userspace yet.)  Then, the dm specific attributes of the
gendisk object will show up in sysfs properly, under the associated
block device.

Anyway, Joe, please add this to your set of patches to send on to Linus.

Oh, and why isn't struct mapped_device declared in dm.h?  If it was,
dm_get and dm_put could be inlined, along with a few other potential
cleanups.

thanks,

greg k-h


# add kobj support to struct mapped_device

diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Wed Dec 18 10:39:48 2002
+++ b/drivers/block/genhd.c	Wed Dec 18 10:39:48 2002
@@ -475,3 +475,4 @@
 EXPORT_SYMBOL(bdev_read_only);
 EXPORT_SYMBOL(set_device_ro);
 EXPORT_SYMBOL(set_disk_ro);
+EXPORT_SYMBOL(block_subsys);
diff -Nru a/drivers/md/dm.c b/drivers/md/dm.c
--- a/drivers/md/dm.c	Wed Dec 18 10:39:48 2002
+++ b/drivers/md/dm.c	Wed Dec 18 10:39:48 2002
@@ -41,7 +41,7 @@
 
 struct mapped_device {
 	struct rw_semaphore lock;
-	atomic_t holders;
+	struct kobject kobj;
 
 	unsigned long flags;
 
@@ -60,11 +60,14 @@
 	 */
 	struct dm_table *map;
 };
+#define to_md(obj) container_of(obj, struct mapped_device, kobj)
 
 #define MIN_IOS 256
 static kmem_cache_t *_io_cache;
 static mempool_t *_io_pool;
 
+struct subsystem dm_subsys;
+
 static __init int local_init(void)
 {
 	int r;
@@ -94,6 +97,7 @@
 	if (!_major)
 		_major = r;
 
+	subsystem_register(&dm_subsys);
 	return 0;
 }
 
@@ -106,7 +110,8 @@
 		DMERR("devfs_unregister_blkdev failed");
 
 	_major = 0;
-
+	subsystem_unregister(&dm_subsys);
+	
 	DMINFO("cleaned up");
 }
 
@@ -553,7 +558,8 @@
 	DMWARN("allocating minor %d.", minor);
 	memset(md, 0, sizeof(*md));
 	init_rwsem(&md->lock);
-	atomic_set(&md->holders, 1);
+	md->kobj.subsys = &dm_subsys;
+	kobject_init(&md->kobj);
 
 	md->queue.queuedata = md;
 	blk_queue_make_request(&md->queue, dm_request);
@@ -637,17 +643,30 @@
 
 void dm_get(struct mapped_device *md)
 {
-	atomic_inc(&md->holders);
+	kobject_get(&md->kobj);
 }
 
 void dm_put(struct mapped_device *md)
 {
-	if (atomic_dec_and_test(&md->holders)) {
-		DMWARN("destroying md");
-		__unbind(md);
-		free_dev(md);
-	}
+	kobject_put(&md->kobj);
+}
+
+static void dm_release(struct kobject *kobj)
+{
+	struct mapped_device *md = to_md(kobj);
+
+	DMWARN("destroying md");
+	__unbind(md);
+	free_dev(md);
 }
+
+extern struct subsystem block_subsys;
+
+struct subsystem dm_subsys = {
+	.kobj		= { .name = "dm", .parent = &block_subsys.kobj },
+	.release	= dm_release,
+};
+
 
 /*
  * Requeue the deferred bios by calling generic_make_request.
