Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267279AbSLRSrl>; Wed, 18 Dec 2002 13:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267315AbSLRSrl>; Wed, 18 Dec 2002 13:47:41 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13073 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267279AbSLRSrk>;
	Wed, 18 Dec 2002 13:47:40 -0500
Date: Wed, 18 Dec 2002 10:53:01 -0800
From: Greg KH <greg@kroah.com>
To: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] [PATCH] add kobject to struct mapped_device
Message-ID: <20021218185301.GB32190@kroah.com>
References: <20021218184307.GA32190@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218184307.GA32190@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 10:43:07AM -0800, Greg KH wrote:
> 
> Here's a simple patch against 2.5.52 that adds the kobject structure to
> struct mapped_device.

Sorry, that patch didn't apply against the latest 2.5-bk tree.  Here's
an updated version.

thanks,

greg k-h


===== drivers/block/genhd.c 1.61 vs edited =====
--- 1.61/drivers/block/genhd.c	Wed Dec  4 16:07:17 2002
+++ edited/drivers/block/genhd.c	Wed Dec 18 10:53:26 2002
@@ -475,3 +475,4 @@
 EXPORT_SYMBOL(bdev_read_only);
 EXPORT_SYMBOL(set_device_ro);
 EXPORT_SYMBOL(set_disk_ro);
+EXPORT_SYMBOL(block_subsys);
===== drivers/md/dm.c 1.14 vs edited =====
--- 1.14/drivers/md/dm.c	Mon Dec 16 01:42:31 2002
+++ edited/drivers/md/dm.c	Wed Dec 18 10:54:10 2002
@@ -40,7 +40,7 @@
 
 struct mapped_device {
 	struct rw_semaphore lock;
-	atomic_t holders;
+	struct kobject kobj;
 
 	unsigned long flags;
 
@@ -65,9 +65,13 @@
 	mempool_t *io_pool;
 };
 
+#define to_md(obj) container_of(obj, struct mapped_device, kobj)
+
 #define MIN_IOS 256
 static kmem_cache_t *_io_cache;
 
+struct subsystem dm_subsys;
+
 static __init int local_init(void)
 {
 	int r;
@@ -89,6 +93,7 @@
 	if (!_major)
 		_major = r;
 
+	subsystem_register(&dm_subsys);
 	return 0;
 }
 
@@ -100,7 +105,8 @@
 		DMERR("devfs_unregister_blkdev failed");
 
 	_major = 0;
-
+	subsystem_unregister(&dm_subsys);
+	
 	DMINFO("cleaned up");
 }
 
@@ -603,7 +609,8 @@
 	DMWARN("allocating minor %d.", minor);
 	memset(md, 0, sizeof(*md));
 	init_rwsem(&md->lock);
-	atomic_set(&md->holders, 1);
+	md->kobj.subsys = &dm_subsys;
+	kobject_init(&md->kobj);
 
 	md->queue.queuedata = md;
 	blk_queue_make_request(&md->queue, dm_request);
@@ -696,17 +703,30 @@
 
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
 }
+
+static void dm_release(struct kobject *kobj)
+{
+	struct mapped_device *md = to_md(kobj);
+
+	DMWARN("destroying md");
+	__unbind(md);
+	free_dev(md);
+}
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
