Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130071AbRBZAkF>; Sun, 25 Feb 2001 19:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130078AbRBZAjr>; Sun, 25 Feb 2001 19:39:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21006 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130076AbRBZAji>;
	Sun, 25 Feb 2001 19:39:38 -0500
Date: Mon, 26 Feb 2001 01:39:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Nate Eldredge <neldredge@hmc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
Message-ID: <20010226013925.Y7830@suse.de>
In-Reply-To: <20010226013326.X7830@suse.de> <Pine.GSO.4.21.0102251935120.26808-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0102251935120.26808-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Feb 25, 2001 at 07:36:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 25 2001, Alexander Viro wrote:
> > > 	if (atomic_dec_and_test(...))
> > > 		up(...);
> > > not just
> > > 	atomic_dec(...);
> > > 	up(...);
> > > 
> > > Otherwise you can end up with too early exit of loop_thread. Normally
> > > it would not matter, but in pathological cases...
> > 
> > How so? We dec it and up the semaphore, loop_thread runs until it's
> > done and ups lo_sem.
> 
> You are risking an extra up() here. Think what happens if you already had a
> pending request.

Ah ok, I see what you mean. Updated patch attached.

-- 
Jens Axboe


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=loop-ac4-2

diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.2-ac4/drivers/block/loop.c linux/drivers/block/loop.c
--- /opt/kernel/linux-2.4.2-ac4/drivers/block/loop.c	Mon Feb 26 01:19:38 2001
+++ linux/drivers/block/loop.c	Mon Feb 26 01:38:36 2001
@@ -79,7 +79,6 @@
 static int *loop_sizes;
 static int *loop_blksizes;
 static devfs_handle_t devfs_handle;      /*  For the directory */
-static kmem_cache_t *loop_bhp;
 
 /*
  * Transfer functions
@@ -289,7 +288,7 @@
 	if (bh) {
 		kunmap(bh->b_page);
 		__free_page(bh->b_page);
-		kmem_cache_free(loop_bhp, bh);
+		kmem_cache_free(bh_cachep, bh);
 	}
 }
 
@@ -358,7 +357,7 @@
 	struct buffer_head *bh;
 
 	do {
-		bh = kmem_cache_alloc(loop_bhp, SLAB_BUFFER);
+		bh = kmem_cache_alloc(bh_cachep, SLAB_BUFFER);
 		if (bh)
 			break;
 
@@ -508,7 +507,7 @@
 	sprintf(current->comm, "loop%d", lo->lo_number);
 
 	spin_lock_irq(&current->sigmask_lock);
-	siginitsetinv(&current->blocked, sigmask(SIGKILL));
+	sigfillset(&current->blocked);
 	flush_signals(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
@@ -526,7 +525,7 @@
 	up(&lo->lo_sem);
 
 	for (;;) {
-		down(&lo->lo_bh_mutex);
+		down_interruptible(&lo->lo_bh_mutex);
 		if (!atomic_read(&lo->lo_pending))
 			break;
 
@@ -671,9 +670,12 @@
 	if (lo->lo_refcnt > 1)	/* we needed one fd for the ioctl */
 		return -EBUSY;
 
+	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
-	atomic_dec(&lo->lo_pending);
-	up(&lo->lo_bh_mutex);
+	if (atomic_dec_and_test(&lo->lo_pending))
+		up(&lo->lo_bh_mutex);
+	spin_unlock_irq(&lo->lo_lock);
+
 	down(&lo->lo_sem);
 
 	lo->lo_backing_file = NULL;
@@ -927,13 +929,6 @@
 		return -EIO;
 	}
 
-	loop_bhp = kmem_cache_create("loop_buffers", sizeof(struct buffer_head),
-				     0, SLAB_HWCACHE_ALIGN, NULL, NULL);
-	if (!loop_bhp) {
-		printk(KERN_WARNING "loop: unable to create slab cache\n");
-		return -ENOMEM;
-	}
-				
 	devfs_handle = devfs_mk_dir(NULL, "loop", NULL);
 	devfs_register_series(devfs_handle, "%u", max_loop, DEVFS_FL_DEFAULT,
 			      MAJOR_NR, 0,
@@ -942,7 +937,7 @@
 
 	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
 	if (!loop_dev)
-		goto out_dev;
+		return -ENOMEM;
 
 	loop_sizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
 	if (!loop_sizes)
@@ -974,8 +969,6 @@
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;
 
-out_dev:
-	kmem_cache_destroy(loop_bhp);
 out_sizes:
 	kfree(loop_dev);
 out_blksizes:
@@ -990,7 +983,6 @@
 	if (devfs_unregister_blkdev(MAJOR_NR, "loop"))
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
 
-	kmem_cache_destroy(loop_bhp);
 	kfree(loop_dev);
 	kfree(loop_sizes);
 	kfree(loop_blksizes);
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.2-ac4/fs/Makefile linux/fs/Makefile
--- /opt/kernel/linux-2.4.2-ac4/fs/Makefile	Mon Feb 26 01:19:40 2001
+++ linux/fs/Makefile	Mon Feb 26 01:14:44 2001
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o
+export-objs :=	filesystems.o open.o dcache.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.2-ac4/fs/dcache.c linux/fs/dcache.c
--- /opt/kernel/linux-2.4.2-ac4/fs/dcache.c	Sat Feb 17 01:06:17 2001
+++ linux/fs/dcache.c	Mon Feb 26 01:14:54 2001
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/cache.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 
@@ -1250,6 +1251,7 @@
 
 /* SLAB cache for buffer_head structures */
 kmem_cache_t *bh_cachep;
+EXPORT_SYMBOL(bh_cachep);
 
 void __init vfs_caches_init(unsigned long mempages)
 {

--eheScQNz3K90DVRs--
