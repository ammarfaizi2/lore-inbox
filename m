Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVCHBuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVCHBuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVCGVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:15:00 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:13234 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261815AbVCGUNh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:37 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [1/5] bd: Asynchronous block device
In-Reply-To: <1110227858283@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:38 +0300
Message-Id: <11102278582250@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It can be used as loopdev replacement, since it fully supports 
file binding.

Original idea was just to create acrypto test module, but since 
then it was greatly reformatted.

Each bd device has a list of so called filters each of which is 
processed with appropriate transfer buffer.
Each filter must provide 3 methods:
->init() - it is called when filter is being bound to the bd device. 
For example it can map appropriate file, prepare network connection
 or allocate crypto buffers.
->fini() - it is called when filter is being unbound from bd device.
->transfer() - main transfer routing. It is called with bd_transfer 
structure which has source page with it's size and offset, and also 
destination position. When transfer is completed(data written/read, 
data encypted/decrypted) filter driver must call ->complete() callback 
which is provided by bd core.

Filters are processed one after another asynchronously but also there 
is an ability to wait untill all previous filters(and appropriate injected 
transfers) are finished. It is required for block encryption. It is simple 
but not implemented yet.
bd can be used as loopdev replacement and network block device replacement 
at the same time, nbd filter is not implemented yet.

With such flexibility one can read data from the file or the real block device, 
encrypt it and transfer it to the remote block devices. It can be used for 
high availabilty systems, distributed backup and others.

Transfer structure is actully a bvec structure from BIO, it has a pointer 
to the global private area which contains BIO reference counter, which is 
used for BIO processing finishing.

bd outperforms vanilla loopdev on about 5% on 2-way SMP(1+1HT) machine.

Since bvecs processing is asynchronous on big SMP machines with 
big number of combined bvecs results will be better.
With asynchronous BIO processing difference is more than 20%, 
but it is very dangerous and now dropped mode.

bd also allows _much_ easier filter creation than device mapper.


diff -Nru /tmp/empty/Kconfig ./drivers/block/bd/Kconfig
--- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/Kconfig	2005-03-07 23:07:51.000000000 +0300
@@ -0,0 +1,24 @@
+menu "Asynchronous block device"
+
+config BD
+	tristate "Asynchronous block device"
+	--- help ---
+	Asynchronous block device is similar to device mapping, 
+	but allows asynchronous operations.
+	Any number of filter can be connected to each device
+	in linear order. Each filter must have transfer() method.
+
+config BD_FD
+	tristate "File backend for bd"
+	--- help ---
+	File backend for asynchronous block device - it allows
+	similar to loopdev file mapping.
+
+config BD_ACRYPTO
+	tristate "Asynchronous crypto filter for bd"
+	depends on ACRYPTO
+	--- help ---
+	Asynchronous crypto filter which uses provided from userspace
+	IV and key for the full disk encryption.
+
+endmenu
diff -Nru /tmp/empty/Makefile ./drivers/block/bd/Makefile
--- /tmp/empty/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/Makefile	2005-03-07 23:03:18.000000000 +0300
@@ -0,0 +1,4 @@
+obj-$(CONFIG_BD)		+= ubd.o 
+obj-$(CONFIG_BD_FD)		+= bd_fd.o 
+obj-$(CONFIG_BD_ACRYPTO)	+= bd_acrypto.o 
+ubd-y				+= bd.o bd_bio.o bd_filter.o
diff -Nru /tmp/empty/bd.c ./drivers/block/bd/bd.c
--- /tmp/empty/bd.c	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd.c	2005-03-07 23:01:04.000000000 +0300
@@ -0,0 +1,550 @@
+/*
+ * 	bd.c
+ *
+ * Copyright (c) 2004-2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/bio.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+
+#include "bd.h"
+#include "bd_filter.h"
+
+static char bd_name[] = "bd";
+
+static unsigned int bd_major = 123;
+module_param(bd_major, uint, 0);
+
+static unsigned int bd_max_num = 8;
+module_param(bd_max_num, uint, 0);
+
+static struct bd_device **bd_devs;
+
+static int bd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+static int bd_open_device(struct inode *, struct file *);
+static int bd_release_device(struct inode *, struct file *);
+
+static int bd_request_thread(void *data);
+
+static struct block_device_operations bd_fops =
+{
+	.owner		THIS_MODULE,
+	.ioctl		bd_ioctl,
+	.open		bd_open_device,
+	.release	bd_release_device,
+};
+
+static void bd_setup(struct bd_device *dev)
+{
+	struct gendisk *d = dev->disk;
+
+	d->major 		= dev->major;
+	d->first_minor		= dev->minor;
+	d->fops			= &bd_fops;
+	d->private_data		= dev;
+	d->flags		= GENHD_FL_SUPPRESS_PARTITION_INFO;
+
+	sprintf(d->disk_name, "%s", dev->name);
+
+	add_disk(d);
+}
+
+static struct bd_device *bd_alloc_dev(int minor)
+{
+	struct bd_device *dev;
+	int err;
+
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+	{
+		dprintk(KERN_ERR "Failed to allocate new bd_device structure.\n");
+		return NULL;
+	}
+
+	memset(dev, 0, sizeof(*dev));
+
+	dev->minor = minor;
+	dev->major = bd_major;
+	snprintf(dev->name, sizeof(dev->name), "bd%d", dev->minor);
+
+	init_MUTEX(&dev->usem);
+	spin_lock_init(&dev->bio_lock);
+	spin_lock_init(&dev->state_lock);
+	bd_unbind_dev(dev);
+
+	init_waitqueue_head(&dev->bio_wait);
+	
+	dev->disk = alloc_disk(1);
+	if (!dev->disk)
+	{
+		dprintk("Failed to allocate a disk.\n");
+		goto err_out_free_dev;
+	}
+	
+	dev->disk->queue = blk_alloc_queue(GFP_KERNEL);
+	if (!dev->disk->queue)
+	{
+		dprintk("Failed to initialize blk queue.\n");
+		goto err_out_free_disk;
+	}
+
+	err = bd_process_bio_init(dev);
+	if (err)
+		goto err_out_free_queue;
+
+	bd_setup(dev);
+
+	init_completion(&dev->thread_exited);
+	dev->pid = kernel_thread(bd_request_thread, dev, CLONE_FS | CLONE_FILES);
+	if (IS_ERR((void *)dev->pid)) {
+		dprintk(KERN_ERR "Failed to create kernel load balancing thread.\n");
+		goto err_out_bio_fini;
+	}
+
+	dprintk("Device %s has been allocated.\n", dev->name);
+	
+	return dev;
+
+err_out_bio_fini:
+	bd_process_bio_fini(dev);
+err_out_free_queue:
+	blk_cleanup_queue(dev->disk->queue);
+	
+err_out_free_disk:
+	put_disk(dev->disk);
+
+err_out_free_dev:
+	kfree(dev);
+
+	return NULL;
+}
+
+static void bd_free_dev(struct bd_device *dev)
+{
+	
+	bd_process_bio_fini(dev);
+	dev->need_exit = 1;
+	kill_proc(dev->pid, SIGTERM, 1);
+	wait_for_completion(&dev->thread_exited);
+
+	bd_clean_filter_list(dev);
+
+	del_gendisk(dev->disk);
+
+	blk_cleanup_queue(dev->disk->queue);
+	
+	put_disk(dev->disk);
+	
+	dprintk("Device %s has been freed.\n", dev->name);
+	
+	kfree(dev);
+}
+
+void bd_get_dev(struct bd_device *dev)
+{
+	down(&dev->usem);
+	dev->refcnt++;
+	up(&dev->usem);
+}
+
+void bd_put_dev(struct bd_device *dev)
+{
+	down(&dev->usem);
+	dev->refcnt--;
+	up(&dev->usem);
+}
+
+struct bd_device *bd_get_dev_minor(int minor)
+{
+	struct bd_device *dev;
+	
+	if (minor < 0 || minor >= bd_max_num)
+	{
+		dprintk("Wrong device number %d.\n", minor);
+		return NULL;
+	}
+
+	dev = bd_devs[minor];
+
+	bd_get_dev(dev);
+
+	return dev;
+}
+
+
+static void bd_unplug(request_queue_t *q)
+{
+	struct bd_device *dev;
+
+	if (!q || !q->queuedata)
+	{
+		dprintk("%s: BUG: q=%p.\n", __func__, q);
+		if (q)
+			dprintk("%s: BUG: q->queuedata=%p.\n", __func__, q->queuedata);
+		return;
+	}
+       	
+	dev = q->queuedata;
+
+	clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags);
+}
+
+void bd_bind_dev(struct bd_device *dev)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&dev->state_lock, flags);
+	dev->state = bd_bound;
+	spin_unlock_irqrestore(&dev->state_lock, flags);
+}
+
+void bd_unbind_dev(struct bd_device *dev)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&dev->state_lock, flags);
+	dev->state = bd_not_bound;
+	spin_unlock_irqrestore(&dev->state_lock, flags);
+}
+
+int bd_is_bound(struct bd_device *dev)
+{
+	return (dev->state == bd_bound);
+}
+
+static void bd_add_bio(struct bd_device *dev, struct bio *bio)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->bio_lock, flags);
+	if (dev->biotail) {
+		dev->biotail->bi_next = bio;
+		dev->biotail = bio;
+	} else
+		dev->bio = dev->biotail = bio;
+
+	atomic_inc(&dev->bio_refcnt);
+	spin_unlock_irqrestore(&dev->bio_lock, flags);
+
+	wake_up(&dev->bio_wait);
+	
+	dprintk("%s: bio has been added, refcnt=%d.\n", __func__, atomic_read(&dev->bio_refcnt));
+}
+
+static struct bio *bd_get_bio(struct bd_device *dev)
+{
+	unsigned long flags;
+	struct bio *bio;
+
+	spin_lock_irqsave(&dev->bio_lock, flags);
+	bio = dev->bio;
+	if (bio) 
+	{
+		if (bio == dev->biotail)
+			dev->biotail = NULL;
+		dev->bio = bio->bi_next;
+		bio->bi_next = NULL;
+		
+		atomic_dec(&dev->bio_refcnt);
+		
+		dprintk("%s: bio has been gotten, refcnt=%d.\n", __func__, atomic_read(&dev->bio_refcnt));
+	}
+	spin_unlock_irqrestore(&dev->bio_lock, flags);
+
+	return bio;
+}
+
+static int bd_make_request(request_queue_t *q, struct bio *bio)
+{
+	struct bd_device *dev = q->queuedata;
+	unsigned long flags;
+	int cmd = bio_rw(bio);
+
+	if (!dev || !bd_is_bound(dev))
+		goto err_out_bad_bio;
+
+	spin_lock_irqsave(&dev->state_lock, flags);
+	if (!bd_is_bound(dev))
+	{
+		spin_unlock_irqrestore(&dev->state_lock, flags);
+		goto err_out_not_bound;
+	}
+	spin_unlock_irqrestore(&dev->state_lock, flags);
+
+	if (cmd != READ && cmd != READA && cmd != WRITE)
+		goto err_out_wrong_command;
+
+	bd_add_bio(dev, bio);
+	
+	return 0;
+	
+err_out_wrong_command:
+err_out_not_bound:
+err_out_bad_bio:
+	bio_io_error(bio, bio->bi_size);
+
+	return -EINVAL;
+}
+
+static int bd_request_thread(void *data)
+{
+	struct bd_device *dev = data;
+	struct bio *bio;
+	int err;
+
+	daemonize("%s", dev->name);
+	allow_signal(SIGTERM);
+
+	while (!dev->need_exit)
+	{
+		interruptible_sleep_on_timeout(&dev->bio_wait, 10);
+
+		if (signal_pending(current))
+			flush_signals(current);
+
+		if (dev->need_exit)
+			break;
+
+		while ((bio = bd_get_bio(dev)) != NULL)
+		{
+			err = bd_process_bio(dev, bio);
+		}
+	}
+
+	complete_and_exit(&dev->thread_exited, 0);
+}
+
+int bd_fill_dev(struct bd_device *dev, loff_t size)
+{
+	if (!dev->bdev || IS_ERR(dev->bdev))
+	{
+		dprintk("Device %s does not have appropriate block device.\n", dev->name);
+		return -EINVAL;
+	}
+
+	if (!dev->bd_block_size)
+	{
+		dprintk("Device %s have block_size=0.\n", dev->name);
+		return -EINVAL;
+	}
+
+	blk_queue_make_request(dev->disk->queue, bd_make_request);
+	dev->disk->queue->queuedata = dev;
+	dev->disk->queue->unplug_fn = bd_unplug;
+
+	set_capacity(dev->disk, size);
+	bd_set_size(dev->bdev, size << (ffs(dev->bd_block_size) - 1));
+
+	set_blocksize(dev->bdev, dev->bd_block_size);
+
+	return 0;
+}
+
+static int bd_open_device(struct inode *inode, struct file *fp)
+{
+	struct bd_device *dev = inode->i_bdev->bd_disk->private_data;
+
+	bd_get_dev(dev);
+
+	dev->bdev = inode->i_bdev;
+
+	return 0;
+}
+
+static int bd_release_device(struct inode *inode, struct file *fp)
+{
+	struct bd_device *dev = inode->i_bdev->bd_disk->private_data;
+
+	bd_put_dev(dev);
+	
+	return 0;
+}
+
+static int bd_ioctl(struct inode *inode, struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct bd_device *dev = inode->i_bdev->bd_disk->private_data;
+	int err;
+	unsigned long n;
+	struct bd_main_filter *f;
+	struct bd_user u;
+	void *priv;
+	
+	dprintk("%s: dev=%s, cmd=%x, arg=%lx.\n", __func__, dev->name, cmd, arg);
+
+	if (_IOC_TYPE(cmd) != BD_ID)
+	{
+		dprintk("Wrong ioctl cmd type %x, must be %x.\n", _IOC_TYPE(cmd), BD_ID);
+		return -EINVAL;
+	}
+
+	if (down_interruptible(&dev->usem))
+		return -ERESTARTSYS;
+
+	err = 0;
+	switch (cmd)
+	{
+		case BD_BIND_FILTER:
+		case BD_UNBIND_FILTER:
+			n = copy_from_user(&u, (long *)arg, sizeof(u));
+			if (n) {
+				err = EINVAL;
+				break;
+			}
+
+			if (u.size > PAGE_SIZE)	{
+				dprintk("dev=%s, filter=%s: private size %u is too big, max=%lu.\n",
+						dev->name, u.name, u.size, PAGE_SIZE);
+				err = -E2BIG;
+				break;
+			}
+
+			dprintk("IOCTL: dev=%s, filter=%s, size=%u.\n", dev->name, u.name, u.size);
+
+			f = bd_find_main_filter_by_name(u.name);
+			if (!f) {
+				err = -ENODEV;
+				break;
+			}
+
+			if (cmd == BD_BIND_FILTER) {
+				/*
+				 * f->priv will be freed in bd_del_filter()/bd_add_filter() -> bd_filter_free() 
+				 * if ->priv and ->priv_size are non-NULL.
+				 */
+				priv = kmalloc(u.size, GFP_KERNEL);
+				if (!priv) {
+					err = -ENOMEM;
+					break;
+				}
+				
+				n = copy_from_user(priv, (long *)(arg+sizeof(u)), u.size);
+				if (n) {
+					err = EINVAL;
+					break;
+				}
+
+				down(&dev->filter_sem);
+				err = bd_add_filter(dev, f, priv, u.size);
+				up(&dev->filter_sem);
+			}
+			else
+			{
+				down(&dev->filter_sem);
+				bd_del_filter(dev, f);
+				up(&dev->filter_sem);
+			}
+
+			atomic_dec(&f->refcnt);
+			break;
+		default:
+			dprintk("Unsupported ioctl %x for device %s.\n", cmd, dev->name);
+			err = -ENOTSUPP;
+			break;
+	}
+	
+	up(&dev->usem);
+
+	return err;
+}
+
+int __devinit bd_init(void)
+{
+	int err, i;
+	struct bd_device *dev;
+
+	err = register_blkdev(bd_major, bd_name);
+	if (err)
+	{
+		dprintk("Failed to register blkdev with major %u: err=%d.\n",
+				bd_major, err);
+		return err;
+	}
+
+	bd_devs = kmalloc(bd_max_num * sizeof(void *), GFP_KERNEL);
+	if (!bd_devs)
+	{
+		dprintk("Failed to allocate %d bd devices.\n", bd_max_num);
+		goto err_out_unregister_blkdev;
+	}
+
+	memset(bd_devs, 0, bd_max_num * sizeof(void *));
+
+	for (i=0; i<bd_max_num; ++i)
+	{
+		dev = bd_alloc_dev(i);
+		if (!dev)
+			goto err_out_free_all_devs;
+		
+		bd_devs[i] = dev;
+
+		dprintk("Device %s [%d] - %p.\n", dev->name, i, bd_devs[i]);
+	}
+
+
+	dprintk("%s has been successfully created.\n", bd_name);
+
+	return 0;
+
+err_out_free_all_devs:
+	--i;
+	while(i >= 0)
+	{
+		bd_free_dev(bd_devs[i]);
+	}
+	kfree(bd_devs);
+err_out_unregister_blkdev:
+	unregister_blkdev(bd_major, "bd");
+
+	return -EINVAL;
+}
+
+void __devexit bd_fini(void)
+{
+	int i;
+
+	for (i=0; i<bd_max_num; ++i)
+		bd_free_dev(bd_devs[i]);
+
+	unregister_blkdev(bd_major, bd_name);
+
+	kfree(bd_devs);
+
+	dprintk("%s has beed successfully removed.\n", bd_name);
+}
+
+module_init(bd_init);
+module_exit(bd_fini);
+
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(bd_get_dev);
+EXPORT_SYMBOL(bd_get_dev_minor);
+EXPORT_SYMBOL(bd_put_dev);
+EXPORT_SYMBOL(bd_fill_dev);
+EXPORT_SYMBOL(bd_bind_dev);
+EXPORT_SYMBOL(bd_unbind_dev);
+EXPORT_SYMBOL(bd_is_bound);
diff -Nru /tmp/empty/bd.h ./drivers/block/bd/bd.h
--- /tmp/empty/bd.h	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd.h	2005-03-07 23:01:05.000000000 +0300
@@ -0,0 +1,120 @@
+/*
+ * 	bd.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __BD_H
+#define __BD_H
+
+#include <linux/ioctl.h>
+
+#define	BD_ID			'B'
+#define BD_BIND_FILTER		_IOW(BD_ID, 1, void *)
+#define BD_UNBIND_FILTER	_IOW(BD_ID, 2, void *)
+
+#define BD_MAX_NAMESIZ		32
+
+struct bd_user
+{
+	char			name[BD_MAX_NAMESIZ];
+	__u32			size;
+};
+
+#ifdef __KERNEL__
+
+#include <linux/fs.h>
+#include <linux/completion.h>
+
+#define BD_DEBUG
+
+#ifdef BD_DEBUG
+#define dprintk(f, a...) printk(f, ##a)
+#else
+#define dprintk(f, a...) do {} while(0)
+#endif
+
+enum {
+	bd_not_bound,
+	bd_bound,
+};
+
+struct bd_private
+{
+	int			req_cnt;
+};
+
+struct bd_device 
+{
+	char			name[BD_MAX_NAMESIZ];
+
+	int			major;
+	int			minor;
+
+	struct semaphore	usem;
+	int			refcnt;
+
+	unsigned int		bd_sector_size;
+	unsigned long		bd_block_size;
+	unsigned int		bd_max_request_size;
+
+	struct gendisk		*disk;
+
+	struct block_device	*bdev;
+
+	int			old_gfp_mask;
+
+	loff_t			offset;
+	
+	spinlock_t		bio_lock;
+	struct bio 		*bio;
+	struct bio		*biotail;
+	atomic_t		bio_refcnt;
+
+	int			state;
+	spinlock_t		state_lock;
+
+	wait_queue_head_t	bio_wait;
+
+	struct completion	thread_exited;
+	int 			pid;
+	int			need_exit;
+
+	struct workqueue_struct *transfer_queue;
+
+	struct semaphore 	filter_sem;
+	struct list_head	filter_list;
+	int			filter_num;
+};
+
+int bd_fill_dev(struct bd_device *dev, loff_t size);
+
+void bd_bind_dev(struct bd_device *dev);
+void bd_unbind_dev(struct bd_device *dev);
+int bd_is_bound(struct bd_device *dev);
+
+int bd_process_bio(struct bd_device *dev, struct bio *bio);
+int bd_process_bio_init(struct bd_device *dev);
+void bd_process_bio_fini(struct bd_device *dev);
+
+void bd_get_dev(struct bd_device *dev);
+void bd_put_dev(struct bd_device *dev);
+struct bd_device *bd_get_dev_minor(int minor);
+
+#endif /* __KERNEL__ */
+#endif /* __BD_H */
diff -Nru /tmp/empty/bd_acrypto.c ./drivers/block/bd/bd_acrypto.c
--- /tmp/empty/bd_acrypto.c	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd_acrypto.c	2005-03-07 23:10:45.000000000 +0300
@@ -0,0 +1,159 @@
+/*
+ * 	bd_acrypto.c
+ *
+ * Copyright (c) 2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/bio.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+
+#include "../../../acrypto/acrypto.h"
+#include "../../../acrypto/crypto_user.h"
+#include "../../../acrypto/crypto_def.h"
+
+#undef dprintk
+
+#include "bd.h"
+#include "bd_filter.h"
+#include "bd_acrypto.h"
+
+static int bd_acrypto_transfer(struct bd_transfer *);
+static int bd_acrypto_init(struct bd_device *, struct bd_filter *);
+static void bd_acrypto_fini(struct bd_device *, struct bd_filter *);
+
+static struct bd_main_filter bd_acrypto_main_filter =
+{
+	.name			= "acrypto",
+	.transfer		= bd_acrypto_transfer,
+	.init			= bd_acrypto_init,
+	.fini			= bd_acrypto_fini,
+	.flags			= BD_MAIN_FILTER_FLAG_WAIT,
+};
+
+static int bd_acrypto_prepare(struct crypto_data *data, void *src, void *dst, unsigned long size, 
+		void *key, int key_size, void *iv, int iv_size, void *priv)
+{		
+	int err;
+
+	err = crypto_user_alloc_crypto_data(data, size, size, key_size, iv_size);
+	if (err)
+		return err;
+	
+	crypto_user_fill_sg(src, size, data->sg_src);
+	crypto_user_fill_sg(dst, size, data->sg_dst);
+	crypto_user_fill_sg(key, key_size, data->sg_key);
+	crypto_user_fill_sg(iv, iv_size, data->sg_iv);
+	
+	data->priv		= priv;
+	data->priv_size		= 0;
+
+	return 0;
+}
+
+static int bd_acrypto_init(struct bd_device *dev, struct bd_filter *f)
+{
+	struct bd_acrypto_private *p = f->priv;
+	
+	if (!p)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void bd_acrypto_fini(struct bd_device *dev, struct bd_filter *f)
+{
+}
+
+void bd_acrypto_callback(struct crypto_session_initializer *ci, struct crypto_data *data)
+{
+	struct bd_transfer *t = data->priv;
+	
+	t->f->complete(t);
+}
+
+static int bd_acrypto_transfer(struct bd_transfer *t)
+{
+	struct crypto_data data;
+	struct bd_acrypto_private *p = t->f->priv;
+	int err;
+	void *src, *dst;
+	struct crypto_session *s;
+	struct crypto_session_initializer ci;
+
+	if (!p)
+		return -EINVAL;
+	
+	memset(&ci, 0, sizeof(ci));
+
+	ci.operation 	= (t->cmd == WRITE)?CRYPTO_OP_ENCRYPT:CRYPTO_OP_DECRYPT;
+	ci.type		= p->type;
+	ci.mode		= p->mode;
+	ci.priority	= p->priority;
+	ci.callback	= bd_acrypto_callback;
+
+	/*
+	 * This is an acrypto filter feature - it is used exactly as filter - it changes data in-place.
+	 */
+	src = kmap_atomic(t->src.page, KM_USER0) + t->src.off;
+	dst = kmap_atomic(t->dst.page, KM_USER1) + t->dst.off;
+	
+	err = bd_acrypto_prepare(&data, src, dst, t->src.size, p->key, p->key_size, p->iv, p->iv_size, t);
+	if (err)
+		goto err_out_unmap;
+
+	s = crypto_session_alloc(&ci, &data);
+	if (!s)
+		goto err_out_free;
+	
+	kunmap_atomic(dst, KM_USER1);
+	kunmap_atomic(src, KM_USER0);
+
+	return 0;
+
+err_out_free:
+	crypto_user_free_crypto_data(&data);
+err_out_unmap:
+	kunmap_atomic(src, KM_USER0);
+
+	return err;
+}
+
+int __devinit bd_acrypto_init_dev(void)
+{
+	return bd_register_main_filter(&bd_acrypto_main_filter);
+}
+
+void __devexit bd_acrypto_fini_dev(void)
+{
+	bd_unregister_main_filter(&bd_acrypto_main_filter);
+}
+
+module_init(bd_acrypto_init_dev);
+module_exit(bd_acrypto_fini_dev);
+
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Asynchronous crypto filter.");
diff -Nru /tmp/empty/bd_acrypto.c~ ./drivers/block/bd/bd_acrypto.c~
--- /tmp/empty/bd_acrypto.c~	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd_acrypto.c~	2005-03-07 23:01:05.000000000 +0300
@@ -0,0 +1,159 @@
+/*
+ * 	bd_acrypto.c
+ *
+ * Copyright (c) 2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/bio.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+
+#include "../crypto/acrypto.h"
+#include "../crypto/crypto_user.h"
+#include "../crypto/crypto_def.h"
+
+#undef dprintk
+
+#include "bd.h"
+#include "bd_filter.h"
+#include "bd_acrypto.h"
+
+static int bd_acrypto_transfer(struct bd_transfer *);
+static int bd_acrypto_init(struct bd_device *, struct bd_filter *);
+static void bd_acrypto_fini(struct bd_device *, struct bd_filter *);
+
+static struct bd_main_filter bd_acrypto_main_filter =
+{
+	.name			= "acrypto",
+	.transfer		= bd_acrypto_transfer,
+	.init			= bd_acrypto_init,
+	.fini			= bd_acrypto_fini,
+	.flags			= BD_MAIN_FILTER_FLAG_WAIT,
+};
+
+static int bd_acrypto_prepare(struct crypto_data *data, void *src, void *dst, unsigned long size, 
+		void *key, int key_size, void *iv, int iv_size, void *priv)
+{		
+	int err;
+
+	err = crypto_user_alloc_crypto_data(data, size, size, key_size, iv_size);
+	if (err)
+		return err;
+	
+	crypto_user_fill_sg(src, size, data->sg_src);
+	crypto_user_fill_sg(dst, size, data->sg_dst);
+	crypto_user_fill_sg(key, key_size, data->sg_key);
+	crypto_user_fill_sg(iv, iv_size, data->sg_iv);
+	
+	data->priv		= priv;
+	data->priv_size		= 0;
+
+	return 0;
+}
+
+static int bd_acrypto_init(struct bd_device *dev, struct bd_filter *f)
+{
+	struct bd_acrypto_private *p = f->priv;
+	
+	if (!p)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void bd_acrypto_fini(struct bd_device *dev, struct bd_filter *f)
+{
+}
+
+void bd_acrypto_callback(struct crypto_session_initializer *ci, struct crypto_data *data)
+{
+	struct bd_transfer *t = data->priv;
+	
+	t->f->complete(t);
+}
+
+static int bd_acrypto_transfer(struct bd_transfer *t)
+{
+	struct crypto_data data;
+	struct bd_acrypto_private *p = t->f->priv;
+	int err;
+	void *src, *dst;
+	struct crypto_session *s;
+	struct crypto_session_initializer ci;
+
+	if (!p)
+		return -EINVAL;
+	
+	memset(&ci, 0, sizeof(ci));
+
+	ci.operation 	= (t->cmd == WRITE)?CRYPTO_OP_ENCRYPT:CRYPTO_OP_DECRYPT;
+	ci.type		= p->type;
+	ci.mode		= p->mode;
+	ci.priority	= p->priority;
+	ci.callback	= bd_acrypto_callback;
+
+	/*
+	 * This is an acrypto filter feature - it is used exactly as filter - it changes data in-place.
+	 */
+	src = kmap_atomic(t->src.page, KM_USER0) + t->src.off;
+	dst = kmap_atomic(t->dst.page, KM_USER1) + t->dst.off;
+	
+	err = bd_acrypto_prepare(&data, src, dst, t->src.size, p->key, p->key_size, p->iv, p->iv_size, t);
+	if (err)
+		goto err_out_unmap;
+
+	s = crypto_session_alloc(&ci, &data);
+	if (!s)
+		goto err_out_free;
+	
+	kunmap_atomic(dst, KM_USER1);
+	kunmap_atomic(src, KM_USER0);
+
+	return 0;
+
+err_out_free:
+	crypto_user_free_crypto_data(&data);
+err_out_unmap:
+	kunmap_atomic(src, KM_USER0);
+
+	return err;
+}
+
+int __devinit bd_acrypto_init_dev(void)
+{
+	return bd_register_main_filter(&bd_acrypto_main_filter);
+}
+
+void __devexit bd_acrypto_fini_dev(void)
+{
+	bd_unregister_main_filter(&bd_acrypto_main_filter);
+}
+
+module_init(bd_acrypto_init_dev);
+module_exit(bd_acrypto_fini_dev);
+
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Asynchronous crypto filter.");
diff -Nru /tmp/empty/bd_acrypto.h ./drivers/block/bd/bd_acrypto.h
--- /tmp/empty/bd_acrypto.h	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd_acrypto.h	2005-03-07 23:01:05.000000000 +0300
@@ -0,0 +1,37 @@
+/*
+ * 	bd_acrypto.h
+ *
+ * Copyright (c) 2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __BD_ACRYPTO_H
+#define __BD_ACRYPTO_H
+
+struct bd_acrypto_private
+{
+	__u16			type;
+	__u16			mode;
+	__u16			priority;
+
+	__u8			key[32];
+	__u8			iv[16];
+	__u16			key_size;
+	__u16			iv_size;
+};
+
+#endif /* __BD_ACRYPTO_H */
diff -Nru /tmp/empty/bd_bio.c ./drivers/block/bd/bd_bio.c
--- /tmp/empty/bd_bio.c	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd_bio.c	2005-03-07 23:01:05.000000000 +0300
@@ -0,0 +1,280 @@
+/*
+ * 	bd_bio.c
+ *
+ * Copyright (c) 2004-2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/types.h>
+#include <linux/bio.h>
+#include <linux/delay.h>
+
+#include "bd.h"
+#include "bd_filter.h"
+
+extern struct semaphore filter_sem;
+extern struct list_head filter_list;
+
+static void bd_free_bvecs(struct bd_filter_transfer *transfers, struct bio *bio)
+{
+	int i;
+
+	for (i=0; i<bio->bi_vcnt; ++i)
+		if (transfers[i].page)
+			__free_pages(transfers[i].page, get_order(transfers[i].size));
+
+	kfree(transfers);
+}
+
+static struct bd_filter_transfer *bd_clone_bvecs(struct bio *bio)
+{
+	struct bd_filter_transfer *t;
+	struct bio_vec *bvec;
+	int i, good_num = 0;
+
+	dprintk("%s: cloning %d bvecs in bio %p.\n", __func__, bio->bi_vcnt, bio);
+
+	t = kmalloc(bio->bi_vcnt*sizeof(struct bd_filter_transfer), GFP_KERNEL);
+	if (!t) {
+		dprintk("Failed to allocate %d bytes array for %d bd_filter_transfer structures.\n",
+				bio->bi_vcnt*sizeof(struct bd_filter_transfer), bio->bi_vcnt);
+		return NULL;
+	}
+
+	memset(t, 0, bio->bi_vcnt*sizeof(struct bd_filter_transfer));
+
+	bio_for_each_segment(bvec, bio, i) {
+		t[i].page = alloc_pages(GFP_KERNEL, get_order(bvec->bv_len));
+		if (!t[i].page)
+			continue;
+
+		t[i].size = bvec->bv_len;
+		t[i].off = bvec->bv_offset;
+
+		good_num++;
+	}
+
+	dprintk("%s: %d [need %d] bd_filter_transfer structures have been successfully allocated.\n", 
+			__func__, good_num, bio->bi_vcnt);
+	
+	if (good_num != bio->bi_vcnt)
+	{
+		dprintk("Failed to clone %d bvecs [%d succeeded].\n", bio->bi_vcnt, good_num);
+
+		bio_for_each_segment(bvec, bio, i)
+			if (t[i].page)
+				__free_pages(t[i].page, get_order(bvec->bv_len));
+	}
+
+	return (good_num == bio->bi_vcnt)?t:NULL;
+}
+
+static int bd_process_bio_cmd_filter(struct bd_device *dev, struct bd_filter *f, struct bio *bio, 
+		struct bd_transfer_private *priv, unsigned int cmd, 
+		struct bd_filter_transfer *src, struct bd_filter_transfer *dst)
+{
+	struct bd_transfer *t;
+	struct bio_vec *bvec;
+	int i, err = 0;
+	loff_t pos = bio->bi_sector << (ffs(dev->bd_block_size)-1);
+	
+	dprintk("%s: TRANSFER: filter=%s, flags=%08x, pos=%llu.\n", dev->name, f->mf->name, f->mf->flags, pos);
+
+	init_completion(&f->completed);
+
+	t = NULL;
+	bio_for_each_segment(bvec, bio, i) {
+		t = bd_transfer_alloc(GFP_KERNEL);
+		if (!t) {
+			err = -ENOMEM;
+			atomic_dec(&f->refcnt);
+			atomic_dec(&t->priv->bio_refcnt);
+			continue;
+		}
+
+		t->cmd 		= cmd;
+		t->pos		= pos;
+		t->dev		= dev;
+		t->priv		= priv;
+		t->f 		= f;
+		t->f->complete 	= bd_filter_complete;
+
+		if (src) {
+			t->src.page 	= src[i].page;
+			t->src.off	= src[i].off;
+			t->src.size	= src[i].size;
+		} else {
+			t->src.page 	= bvec->bv_page;
+			t->src.off	= bvec->bv_offset;
+			t->src.size	= bvec->bv_len;
+		}
+
+		if (dst) {
+			t->dst.page 	= dst[i].page;
+			t->dst.off	= dst[i].off;
+			t->dst.size	= dst[i].size;
+		} else {
+			t->dst.page 	= t->src.page;
+			t->dst.off	= t->src.off;
+			t->dst.size	= t->src.size;
+		}
+
+		pos += bvec->bv_len;
+		
+		dprintk("bvec in bio=%p, t=%p, f->refcnt=%d, pos=%llu: SRC=[%p.%u.%u], DST=[%p.%u.%u].\n", 
+				bio, t, atomic_read(&t->f->refcnt), pos,
+				t->src.page, t->src.size, t->src.off,
+				t->dst.page, t->dst.size, t->dst.off);
+
+		INIT_WORK(&t->work, &bd_filter_queue_wrapper, t);
+
+		if (i+1 < bio->bi_vcnt)
+			queue_work(dev->transfer_queue, &t->work);
+	}
+
+	if (i == bio->bi_vcnt && t)
+		queue_work(dev->transfer_queue, &t->work);
+
+	return err;
+}
+
+static int bd_process_bio_cmd(struct bd_device *dev, unsigned int cmd, struct bio *bio)
+{
+	int err = 0, bio_err = 0;
+	struct bd_transfer_private *priv;
+	struct bd_filter *f;
+	struct bd_filter_transfer *transfers = NULL;
+
+	dprintk("%s: TRANSFER: cmd=%s [%d], [bs=%lu, bios=%d, bvecs=%d].\n", 
+			dev->name, (cmd == READ)?"READ":"WRITE", cmd, 
+			dev->bd_block_size, atomic_read(&dev->bio_refcnt), bio->bi_vcnt);
+
+	down(&dev->filter_sem);
+
+	priv = kmalloc(sizeof(struct bd_transfer_private), GFP_KERNEL);
+	if (!priv)
+	{
+		err = -ENOMEM;
+		goto out_up;
+	}
+
+	priv->bio_status = 0;
+	priv->bio = bio;
+	atomic_set(&priv->bio_refcnt, bio->bi_vcnt*dev->filter_num);
+	init_completion(&priv->bio_completed);
+
+	dprintk("BIO: bio=%p, bio_refcnt=%d.\n", bio, atomic_read(&priv->bio_refcnt));
+		
+	list_for_each_entry(f, &dev->filter_list, filter_entry)
+		atomic_set(&f->refcnt, bio->bi_vcnt);
+	
+	if (cmd == WRITE) {
+		int first = 1;
+		
+		transfers = bd_clone_bvecs(bio);
+		if (!transfers) {
+			bio_err = -ENOMEM;
+			atomic_set(&priv->bio_refcnt, 0);
+			goto out_up;
+		}
+
+		list_for_each_entry(f, &dev->filter_list, filter_entry) {
+			if (first) {
+				err = bd_process_bio_cmd_filter(dev, f, bio, priv, cmd, NULL, transfers);
+				first = 0;
+			} else {
+				err = bd_process_bio_cmd_filter(dev, f, bio, priv, cmd, transfers, NULL);
+			}
+
+			if (err && (atomic_read(&f->refcnt) == 0)) {
+				complete(&f->completed);
+			}
+			
+			if (need_wait(f->mf->flags)) {
+				wait_for_completion(&f->completed);
+			}
+
+			if (err)
+				bio_err = err;
+		}
+	} else {
+		list_for_each_entry_reverse(f, &dev->filter_list, filter_entry) {
+			err = bd_process_bio_cmd_filter(dev, f, bio, priv, cmd, NULL, NULL);
+			if (err && (atomic_read(&f->refcnt) == 0)) {
+				complete(&f->completed);
+			}
+			
+			if (need_wait(f->mf->flags)) {
+				wait_for_completion(&f->completed);
+			}
+
+			if (err)
+				bio_err = err;
+		}
+	}
+
+out_up:
+	up(&dev->filter_sem);
+
+	if (!bio_err || (atomic_read(&priv->bio_refcnt) != 0))
+		wait_for_completion(&priv->bio_completed);
+	
+	if (transfers)
+		bd_free_bvecs(transfers, bio);
+	bio_endio(bio, bio->bi_size, (bio_err)?-ENOMEM:0);
+	kfree(priv);
+
+	if (bio_err)
+		dprintk("BIO has been completed with errors.\n");
+
+	return err;
+}
+
+int bd_process_bio(struct bd_device *dev, struct bio *bio)
+{
+	int err;
+
+	dprintk("%s: %lu: dev=%s, bio=%p, cmd=%lu.\n", __func__, jiffies, dev->name, bio, bio_rw(bio));
+	err = bd_process_bio_cmd(dev, (bio_rw(bio) == WRITE)?WRITE:READ, bio);
+
+	return err;
+}
+
+int bd_process_bio_init(struct bd_device *dev)
+{
+	char name[10];
+
+	snprintf(name, sizeof(name), "%s.trans", dev->name);
+	
+	dev->transfer_queue = create_workqueue(name);
+	if (!dev->transfer_queue)
+	{
+		dprintk("Failed to create work queue %s for bd device %s.\n", 
+				name, dev->name);
+		return -EINVAL;
+	}
+
+	init_MUTEX(&dev->filter_sem);
+	INIT_LIST_HEAD(&dev->filter_list);
+
+	return 0;
+}
+
+void bd_process_bio_fini(struct bd_device *dev)
+{
+	destroy_workqueue(dev->transfer_queue);
+}
diff -Nru /tmp/empty/bd_fd.c ./drivers/block/bd/bd_fd.c
--- /tmp/empty/bd_fd.c	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd_fd.c	2005-03-07 23:01:05.000000000 +0300
@@ -0,0 +1,329 @@
+/*
+ * 	bd_fd.c
+ *
+ * Copyright (c) 2004-2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/bio.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+
+#include "bd.h"
+#include "bd_filter.h"
+#include "bd_fd.h"
+
+static int bd_fd_transfer(struct bd_transfer *);
+static int bd_fd_init(struct bd_device *, struct bd_filter *);
+static void bd_fd_fini(struct bd_device *, struct bd_filter *);
+
+static struct bd_main_filter fd_filter = 
+{
+	.name			= "fd",
+	.transfer		= bd_fd_transfer,
+	.init			= bd_fd_init,
+	.fini			= bd_fd_fini,
+	.flags			= BD_MAIN_FILTER_FLAG_WAIT | BD_MAIN_FILTER_BACKEND,
+};
+
+static loff_t bd_get_size(struct bd_device *dev, struct bd_fd_private *p)
+{
+	loff_t size;
+
+	size = i_size_read(p->file->f_mapping->host) - dev->offset;
+
+	dprintk("dev=%s, size=%llu [%llu].\n", dev->name, size, size >> (ffs(dev->bd_block_size) - 1));
+
+	return size >> (ffs(dev->bd_block_size) - 1);
+}
+
+static void bd_clear_fd(struct bd_device *dev, struct bd_fd_private *p)
+{
+	if (p->file)
+		fput(p->file);
+	p->file = NULL;
+	p->u.fd = 0;
+}
+
+static int bd_set_fd(struct bd_device *dev, struct bd_fd_private *p)
+{
+	int err;
+	struct inode *inode;
+	struct address_space *mapping;
+	
+	p->file = fget(p->u.fd);
+	if (!p->file)
+	{
+		dprintk("File does not exist for fd %d.\n", p->u.fd);
+		err = -EBADF;
+		goto err_out_clear_fd;
+	}
+
+	dprintk("%s: Found file: fd=%d, dentry=%s.\n",
+			dev->name, p->u.fd, p->file->f_dentry->d_iname);
+	
+	mapping = p->file->f_mapping;
+	inode = mapping->host;
+	
+	err = -EBADF;
+	if (S_ISREG(inode->i_mode) || S_ISBLK(inode->i_mode)) {
+		struct address_space_operations *aops = mapping->a_ops;
+		
+		if (!p->file->f_op->sendfile)
+			goto err_out_putf;
+
+		if (!aops->prepare_write || !aops->commit_write)
+			goto err_out_putf;
+
+		dev->bd_block_size = inode->i_blksize;
+	} else {
+		goto err_out_putf;
+	}
+
+	dev->bd_sector_size = 512;
+	dev->bd_block_size = 512;
+	dev->bd_max_request_size = PAGE_SIZE;
+
+	dev->old_gfp_mask = mapping_gfp_mask(mapping);
+	mapping_set_gfp_mask(mapping, dev->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
+
+	bd_fill_dev(dev, bd_get_size(dev, p));
+
+	return 0;
+
+err_out_putf:
+	fput(p->file);
+	p->file = NULL;
+
+err_out_clear_fd:
+	p->u.fd = 0;
+
+	return err;
+}
+
+static int bd_fd_init(struct bd_device *dev, struct bd_filter *f)
+{
+	struct bd_fd_private *p;
+       	struct bd_fd_user *u = f->priv;
+	int err;
+
+	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		dprintk("Failed to allocate new bd_fd priavte structure in dev=%s, filter=%s.\n", 
+				dev->name, f->mf->name);
+		return -ENOMEM;
+	}
+
+	memset(p, 0, sizeof(*p));
+
+	memcpy(&p->u, u, sizeof(p->u));
+
+	dprintk("%s: filter=%s, flags=%08x.\n", __func__, f->mf->name, f->mf->flags);
+	
+	/*
+	 * f->priv will be freed in bd_del_filter()/bd_add_filter() -> bd_filter_free();
+	 */
+	kfree(f->priv);
+	f->priv = p;
+	
+	dprintk("%s: filter=%s, flags=%08x.\n", __func__, f->mf->name, f->mf->flags);
+
+	err = bd_set_fd(dev, p);
+	if (err)
+		return err;
+	
+	return 0;
+}
+
+static void bd_fd_fini(struct bd_device *dev, struct bd_filter *f)
+{
+       	struct bd_fd_private *p = f->priv;
+
+	if (p)
+		bd_clear_fd(dev, p);
+}
+
+static int file_bd_transfer(struct bd_transfer *t,
+	       struct page *rpage, unsigned roffs,
+	       struct page *lpage, unsigned loffs,
+	       int size)
+{
+	char *rbuf = kmap_atomic(rpage, KM_USER0) + roffs;
+	char *lbuf = kmap_atomic(lpage, KM_USER1) + loffs;
+
+	dprintk("%s: cmd=%d, rpage=%p, roff=%u, lpage=%p, loff=%u, size=%d.\n",
+			__func__, t->cmd, rpage, roffs, lpage, loffs, size);
+
+	if (t->cmd == READ)
+		memcpy(lbuf, rbuf, size);
+	else
+		memcpy(rbuf, lbuf, size);
+
+	kunmap_atomic(rbuf, KM_USER0);
+	kunmap_atomic(lbuf, KM_USER1);
+
+	return 0;
+}
+
+static int file_bd_write(struct bd_transfer *t)
+{
+	struct bd_device *dev = t->dev;
+	struct bd_filter *f = t->f;
+	struct page *bv_page = t->src.page;
+	unsigned bv_offs = t->src.off;
+	int bv_len = t->src.size;
+	loff_t pos = t->pos;
+	struct bd_fd_private *p = f->priv;
+	struct address_space *mapping = p->file->f_mapping;
+	struct address_space_operations *aops = mapping->a_ops;
+	struct page *page;
+	pgoff_t index;
+	unsigned size, offset;
+
+	down(&mapping->host->i_sem);
+	index = pos >> PAGE_CACHE_SHIFT;
+	offset = pos & ((pgoff_t)PAGE_CACHE_SIZE - 1);
+	while (bv_len > 0) {
+		int transfer_result;
+
+		size = PAGE_CACHE_SIZE - offset;
+		if (size > bv_len)
+			size = bv_len;
+
+		page = grab_cache_page(mapping, index);
+		if (!page)
+			goto err_out_exit;
+		if (aops->prepare_write(p->file, page, offset, offset+size))
+			goto err_out_page_unlock;
+		transfer_result = file_bd_transfer(t, page, offset, bv_page, bv_offs, size);
+		if (transfer_result) {
+			char *kaddr;
+
+			printk(KERN_ERR "%s: transfer error block %llu\n", dev->name, (unsigned long long)index);
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr + offset, 0, size);
+			kunmap_atomic(kaddr, KM_USER0);
+		}
+		flush_dcache_page(page);
+		if (aops->commit_write(p->file, page, offset, offset+size))
+			goto err_out_page_unlock;
+		if (transfer_result)
+			goto err_out_page_unlock;
+		bv_offs += size;
+		bv_len -= size;
+		offset = 0;
+		index++;
+		pos += size;
+		unlock_page(page);
+		page_cache_release(page);
+	}
+	up(&mapping->host->i_sem);
+	
+	return 0;
+
+err_out_page_unlock:
+	unlock_page(page);
+	page_cache_release(page);
+err_out_exit:
+	up(&mapping->host->i_sem);
+
+	return -EINVAL;
+}
+
+static int bd_actor(read_descriptor_t *desc, struct page *page, unsigned long offset, unsigned long size)
+{
+	unsigned long count = desc->count;
+	struct bd_transfer *t = desc->arg.data;
+
+	dprintk("%s: dev=%s, page=%p, off=%lu, size=%lu.\n", __func__, t->dev->name, page, offset, size);
+
+	if (size > count)
+		size = count;
+
+	if (file_bd_transfer(t, page, offset, t->src.page, t->src.off, size)) {
+		size = 0;
+		printk(KERN_ERR "Failed to transfer block %ld\n", page->index);
+		desc->error = -EINVAL;
+	}
+
+	desc->count = count - size;
+	desc->written += size;
+	
+	return size;
+}
+
+static int file_bd_read(struct bd_transfer *t)
+{
+	struct bd_fd_private *p = t->f->priv;
+	int err;
+	loff_t pos = t->pos;
+
+	err = p->file->f_op->sendfile(p->file, &pos, t->src.size, bd_actor, t);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int bd_fd_transfer(struct bd_transfer *t)
+{
+	int err;
+
+	dprintk("%s: TRANSFER: t=%p, dev=%s, filter=%s.\n", __func__, t, t->dev->name, t->f->mf->name);
+	
+	if (t->cmd == WRITE)
+		err = file_bd_write(t);
+	else
+		err = file_bd_read(t);
+
+	if (err)
+		t->status = BD_TRANSFER_FAILED;
+
+	t->f->complete(t);
+
+	return err;
+}
+
+int __devinit bd_fd_init_dev(void)
+{
+	int err;
+
+	err = bd_register_main_filter(&fd_filter);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+void __devexit bd_fd_fini_dev(void)
+{
+	bd_unregister_main_filter(&fd_filter);
+}
+
+module_init(bd_fd_init_dev);
+module_exit(bd_fd_fini_dev);
+
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("File backend filter.");
diff -Nru /tmp/empty/bd_fd.h ./drivers/block/bd/bd_fd.h
--- /tmp/empty/bd_fd.h	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd_fd.h	2005-03-07 23:01:05.000000000 +0300
@@ -0,0 +1,40 @@
+/*
+ * 	bd_fd.h
+ *
+ * Copyright (c) 2004-2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __BD_FD_H
+#define __BD_FD_H
+
+struct bd_fd_user
+{
+	int			fd;
+};
+
+#ifdef __KERNEL__
+
+struct bd_fd_private
+{
+	struct bd_fd_user	u;
+
+	struct file		*file;
+};
+
+#endif /* __KERNEL__ */
+#endif /* __BD_FD_H */
diff -Nru /tmp/empty/bd_filter.c ./drivers/block/bd/bd_filter.c
--- /tmp/empty/bd_filter.c	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd_filter.c	2005-03-07 23:01:05.000000000 +0300
@@ -0,0 +1,322 @@
+/*
+ * 	bd_filter.c
+ *
+ * Copyright (c) 2004-2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/bio.h>
+
+#include "bd.h"
+#include "bd_filter.h"
+
+static LIST_HEAD(main_filter_list);
+static spinlock_t main_filter_lock = SPIN_LOCK_UNLOCKED;
+//static DECLARE_SPINLOCK(main_filter_lock);
+
+void bd_filter_complete(struct bd_transfer *t)
+{
+	dprintk("%s: t=%p, dev=%s, filter=%s, bio_refcnt=%d [%08x].\n",
+			__func__, t, t->dev->name, t->f->mf->name,
+			atomic_read(&t->priv->bio_refcnt), t->priv->bio_status);
+
+	if (atomic_dec_and_test(&t->f->refcnt))
+		complete(&t->f->completed);
+	
+	if (atomic_dec_and_test(&t->priv->bio_refcnt))
+	{
+		dprintk("Completing BIO request.\n");
+		complete(&t->priv->bio_completed);
+	}
+
+	bd_transfer_free(t);
+}
+
+void bd_filter_queue_wrapper(void *data)
+{
+	struct bd_transfer *t = data;
+	struct bd_filter *f = t->f;
+	int err;
+
+	dprintk("%s: dev=%s, transfer=%p, filter=%s, status=%08x.\n", __func__, t->dev->name, t, f->mf->name, t->status);
+
+	err = f->mf->transfer(t);
+}
+
+struct bd_transfer *bd_transfer_alloc(int flags)
+{
+	struct bd_transfer *t;
+
+	t = kmalloc(sizeof(*t), flags);
+	if (!t)
+	{
+		dprintk("Failed to allocate new bd_transfer structure.\n");
+		return NULL;
+	}
+
+	memset(t, 0, sizeof(*t));
+
+	return t;
+}
+
+void bd_transfer_free(struct bd_transfer *t)
+{
+	dprintk("%s: transfer=%p, dev=%s, filter=%s.\n", __func__, t, t->dev->name, t->f->mf->name);
+
+	kfree(t);
+}
+
+static struct bd_filter *bd_filter_alloc(struct bd_main_filter *mf, int flags)
+{
+	struct bd_filter *f;
+	
+	f = kmalloc(sizeof(struct bd_filter), flags);
+	if (!f)
+		return NULL;
+
+	memset(f, 0, sizeof(*f));
+
+	atomic_set(&f->refcnt, 0);
+	f->complete = bd_filter_complete;
+	f->mf = mf;
+
+	return f;
+}
+
+static void bd_filter_free(struct bd_filter *f)
+{
+	if (atomic_read(&f->refcnt) == 0)
+	{
+		if (f->priv_size && f->priv)
+			kfree(f->priv);
+		kfree(f);
+	}
+}
+
+int bd_add_filter(struct bd_device *dev, struct bd_main_filter *f, void *priv, u32 priv_size)
+{
+	struct bd_filter *ft;
+	int err = -EINVAL;
+
+	if (is_backend(f->flags) && bd_is_bound(dev))
+	{
+		dprintk("Backend filter already registered in block device %s.\n", dev->name);
+		return -ENODEV;
+	}
+
+	atomic_inc(&f->refcnt);
+
+	ft = bd_filter_alloc(f, GFP_KERNEL);
+	if (!ft) {
+		goto err_out_exit;
+	}
+
+	ft->priv = priv;
+	ft->priv_size = priv_size;
+	
+
+	err = f->init(dev, ft);
+	if (err)
+		goto err_out_free_filter;
+
+	if (is_backend(f->flags))
+		bd_bind_dev(dev);
+
+	list_add_tail(&ft->filter_entry, &dev->filter_list);
+	dev->filter_num++;
+
+	return 0;
+
+err_out_free_filter:
+	bd_filter_free(ft);
+err_out_exit:
+	
+	atomic_dec(&f->refcnt);
+		
+	bd_unbind_dev(dev);
+
+	return err;
+}
+
+void bd_del_filter(struct bd_device *dev, struct bd_main_filter *f)
+{
+	struct bd_filter *ft, *n;
+	
+	if (is_backend(f->flags))
+		bd_unbind_dev(dev);
+
+	list_for_each_entry_safe(ft, n, &dev->filter_list, filter_entry)
+	{
+		if (!strncmp(f->name, ft->mf->name, sizeof(f->name)))
+		{
+			list_del(&ft->filter_entry);
+			dev->filter_num--;
+	
+			f->fini(dev, ft);	
+
+			smp_mb__before_atomic_dec();
+			atomic_dec(&f->refcnt);
+			smp_mb__after_atomic_dec();
+
+			bd_filter_free(ft);
+		}
+	}
+}
+
+struct bd_main_filter *bd_find_main_filter_by_name(char *name)
+{
+	struct bd_main_filter *f;
+	int found = 0;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&main_filter_lock, flags);
+	list_for_each_entry(f, &main_filter_list, main_filter_entry)
+	{
+		if (!strncmp(f->name, name, sizeof(f->name)))
+		{
+			found = 1;
+			atomic_inc(&f->refcnt);
+			break;
+		}
+	}
+	
+	spin_unlock_irqrestore(&main_filter_lock, flags);
+	
+	if (found)
+		return f;
+	else
+		return NULL;
+}
+
+static int bd_main_filter_ok(struct bd_main_filter *f)
+{
+	if (!f->transfer)
+	{
+		dprintk("Filter %s does not have ->transfer() method.\n", f->name);
+		return 0;
+	}
+	
+	if (!f->init)
+	{
+		dprintk("Filter %s does not have ->init() method.\n", f->name);
+		return 0;
+	}
+	
+	if (!f->fini)
+	{
+		dprintk("Filter %s does not have ->fini() method.\n", f->name);
+		return 0;
+	}
+
+	return 1;
+}
+
+int bd_register_main_filter(struct bd_main_filter *f)
+{
+	unsigned long flags;
+	struct bd_main_filter *ft;
+	int err = 0;
+
+	if (!bd_main_filter_ok(f))
+		return -EINVAL;
+	
+	spin_lock_irqsave(&main_filter_lock, flags);
+
+	list_for_each_entry(ft, &main_filter_list, main_filter_entry)
+	{
+		if (!strncmp(f->name, ft->name, sizeof(f->name)))
+		{
+			dprintk("Filter %s was already registered.\n", f->name);
+			err = -EINVAL;
+			break;
+		}
+	}
+
+	if (!err)
+	{
+		list_add(&f->main_filter_entry, &main_filter_list);
+		atomic_set(&f->refcnt, 0);
+	}
+	
+	spin_unlock_irqrestore(&main_filter_lock, flags);
+
+	return err;
+}
+
+void bd_unregister_main_filter(struct bd_main_filter *f)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&main_filter_lock, flags);
+	list_del(&f->main_filter_entry);
+	spin_unlock_irqrestore(&main_filter_lock, flags);
+
+	while (atomic_read(&f->refcnt))
+	{
+		dprintk("Waiting for filter %s to become free: refcnt=%d.\n", f->name, atomic_read(&f->refcnt));
+		msleep(1000);
+	}
+}
+
+void bd_clean_filter_list(struct bd_device *dev)
+{
+	struct bd_main_filter *f;
+	unsigned long flags;
+
+	spin_lock_irqsave(&main_filter_lock, flags);
+	list_for_each_entry(f, &main_filter_list, main_filter_entry)
+	{
+		bd_del_filter(dev, f);
+		
+		if (dev->filter_num < 0)
+			dprintk("Something wrong with filter processing in device %s: filter_num=%d.\n",
+					dev->name, dev->filter_num);
+	}
+	spin_unlock_irqrestore(&main_filter_lock, flags);
+}
+#if 0
+static struct bd_transfer *bd_transfer_clone(struct bd_transfer *t, int flags)
+{
+	struct bd_transfer *clone;
+
+	clone = bd_transfer_alloc(flags);
+	if (!clone)
+		return NULL;
+
+	clone->cmd 	= t->cmd;
+	clone->src	= t->src;
+	clone->dst	= t->dst;
+	clone->pos	= t->pos;
+	clone->dev	= t->dev;
+	clone->priv	= t->priv;
+		
+	INIT_WORK(&clone->work, &bd_filter_queue_wrapper, clone);
+
+	dprintk("Transer has been cloned: filter=%s, dev=%s.\n",
+			t->f->mf->name, t->dev->name);
+
+	return clone;
+}
+#endif
+
+EXPORT_SYMBOL_GPL(bd_register_main_filter);
+EXPORT_SYMBOL_GPL(bd_unregister_main_filter);
diff -Nru /tmp/empty/bd_filter.h ./drivers/block/bd/bd_filter.h
--- /tmp/empty/bd_filter.h	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd_filter.h	2005-03-07 23:01:05.000000000 +0300
@@ -0,0 +1,153 @@
+/*
+ * 	bd_filter.h
+ *
+ * Copyright (c) 2004-2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __BD_FILTER_H
+#define __BD_FILTER_H
+
+#include <linux/workqueue.h>
+#include <linux/list.h>
+#include <linux/completion.h>
+
+#define BD_MAIN_FILTER_FLAG_WAIT	(1<<0) 	/* bd core must wait until every callback is completed 
+						 * and do not send data to another filters 
+						 */
+#define BD_MAIN_FILTER_BACKEND		(1<<1)	/* This is a backend filter, i.e. one which contacts with the storage itself */
+
+#define need_wait(flags)		!!(flags & BD_MAIN_FILTER_FLAG_WAIT)
+#define is_backend(flags)		!!(flags & BD_MAIN_FILTER_BACKEND)
+
+
+#define BD_FILTER_COMPLETED		0
+
+#define BD_FILTER_DIR_DIRECT		0
+#define BD_FILTER_DIR_REVERSE		1
+
+struct bd_transfer;
+struct bd_filter;
+
+struct bd_main_filter
+{
+	char				name[BD_MAX_NAMESIZ];
+
+	struct list_head		main_filter_entry;
+
+	int				(* transfer)(struct bd_transfer *);
+	int				(* init)(struct bd_device *, struct bd_filter *);
+	void				(* fini)(struct bd_device *, struct bd_filter *);
+
+	atomic_t			refcnt;
+	u32				flags;
+};
+
+struct bd_filter
+{
+	struct list_head		filter_entry;
+
+	void				(* complete)(struct bd_transfer *);
+
+	atomic_t			refcnt;
+
+	struct bd_main_filter		*mf;
+
+	void				*priv;
+	u32				priv_size;
+
+	struct completion		completed;
+};
+
+#define BD_TRANSFER_OK			0
+#define BD_TRANSFER_FAILED		1
+
+#define BD_BIO_BROKEN			0
+
+struct bd_transfer_private
+{
+	struct bio			*bio;
+	atomic_t			bio_refcnt;
+	u32				bio_status;
+	struct completion		bio_completed;
+};
+
+struct bd_filter_transfer
+{
+	struct page			*page;
+	unsigned int			off;
+	unsigned int			size;
+};
+
+struct bd_transfer
+{
+	unsigned int			cmd;
+	struct bd_filter_transfer	src;
+	struct bd_filter_transfer	dst;
+
+	loff_t				pos;
+
+	u32				status;
+	
+	struct bd_device		*dev;
+	struct bd_filter		*f;
+	struct work_struct 		work;
+
+	struct bd_transfer_private	*priv;
+};
+
+void bd_filter_queue_wrapper(void *);
+void bd_transfer_wait(struct bd_transfer *);
+
+struct bd_transfer *bd_transfer_alloc(int flags);
+void bd_transfer_free(struct bd_transfer *);
+int bd_transfer_through_filters(struct bd_transfer *t);
+
+int bd_add_filter(struct bd_device *dev, struct bd_main_filter *f, void *priv, u32 priv_size);
+void bd_del_filter(struct bd_device *dev, struct bd_main_filter *f);
+int bd_register_main_filter(struct bd_main_filter *f);
+void bd_unregister_main_filter(struct bd_main_filter *f);
+struct bd_main_filter *bd_find_main_filter_by_name(char *);
+void bd_clean_filter_list(struct bd_device *dev);
+
+void bd_filter_complete(struct bd_transfer *t);
+void bd_backend_filter_complete(struct bd_transfer *t);
+
+static __inline__ struct bd_filter *next_filter(struct bd_filter *cur, struct bd_device *dev, int dir)
+{
+	struct bd_filter *n;
+	n = list_entry((dir == BD_FILTER_DIR_DIRECT)?cur->filter_entry.next:cur->filter_entry.prev, 
+			struct bd_filter, filter_entry);
+
+	dprintk("%s: cur=%s, dir=%d, ptr=[%p.%p], devp=%p.\n",
+			__func__, cur->mf->name, dir, 
+			cur->filter_entry.next, cur->filter_entry.prev,
+			&dev->filter_list);
+
+	if (!n)
+		return NULL;
+
+	if (&n->filter_entry == &dev->filter_list)
+		return NULL;
+
+	dprintk("%s: n=%s.\n", __func__, n->mf->name);
+
+	return n;
+}
+
+
+#endif /* __BD_FILTER_H */
diff -Nru /tmp/empty/bd_xor.c ./drivers/block/bd/bd_xor.c
--- /tmp/empty/bd_xor.c	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/block/bd/bd_xor.c	2005-03-07 23:01:05.000000000 +0300
@@ -0,0 +1,110 @@
+/*
+ * 	bd_xor.c
+ *
+ * Copyright (c) 2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/bio.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+
+#include "bd.h"
+#include "bd_filter.h"
+
+static int bd_xor_transfer(struct bd_transfer *);
+static int bd_xor_init(struct bd_device *, struct bd_filter *);
+static void bd_xor_fini(struct bd_device *, struct bd_filter *);
+
+static struct bd_main_filter bd_xor_main_filter =
+{
+	.name			= "xor",
+	.transfer		= bd_xor_transfer,
+	.init			= bd_xor_init,
+	.fini			= bd_xor_fini,
+	.flags			= BD_MAIN_FILTER_FLAG_WAIT,
+};
+
+static int bd_xor_init(struct bd_device *dev, struct bd_filter *f)
+{
+	return 0;
+}
+
+static void bd_xor_fini(struct bd_device *dev, struct bd_filter *f)
+{
+}
+
+static void dump_data(char *prefix, u8 *ptr, int size)
+{
+	int i;
+
+	printk("%lu: %s: ", jiffies, prefix);
+	for (i=0; i<size; ++i)
+		printk("%02x ", ptr[i]);
+	printk("\n");
+}
+
+static int bd_xor_transfer(struct bd_transfer *t)
+{
+	int i;
+	u8 *src, *dst;
+
+	src = kmap_atomic(t->src.page, KM_USER0) + t->src.off;
+	dst = kmap_atomic(t->dst.page, KM_USER1) + t->dst.off;
+
+	dump_data("bd_xor_transfer before", src, 32);
+	for (i=0; i<t->src.size; ++i)
+	{
+		dst[i] = src[i] ^ 0xff;
+	}
+	dump_data("bd_xor_transfer after ", dst, 32);
+
+	kunmap_atomic(dst, KM_USER1);
+	kunmap_atomic(src, KM_USER0);
+
+	t->src.page 	= t->dst.page;
+	t->src.size 	= t->dst.size;
+	t->src.off 	= t->dst.off;
+	
+	t->f->complete(t);
+
+	return 0;
+}
+
+int __devinit bd_xor_init_dev(void)
+{
+	return bd_register_main_filter(&bd_xor_main_filter);
+}
+
+void __devexit bd_xor_fini_dev(void)
+{
+	bd_unregister_main_filter(&bd_xor_main_filter);
+}
+
+module_init(bd_xor_init_dev);
+module_exit(bd_xor_fini_dev);
+
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Simple XOR filter.");
--- ./drivers/block/Makefile~	2005-03-02 10:38:38.000000000 +0300
+++ ./drivers/block/Makefile	2005-03-07 23:09:16.000000000 +0300
@@ -44,4 +44,4 @@
 obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
 obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
-
+obj-$(CONFIG_BD)		+= bd/
--- ./drivers/block/Kconfig~	2005-03-02 10:37:50.000000000 +0300
+++ ./drivers/block/Kconfig	2005-03-07 23:08:34.000000000 +0300
@@ -506,4 +506,6 @@
 	This driver provides Support for ATA over Ethernet block
 	devices like the Coraid EtherDrive (R) Storage Blade.
 
+source "drivers/block/bd/Kconfig"
+
 endmenu

