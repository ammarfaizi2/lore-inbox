Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSGGWec>; Sun, 7 Jul 2002 18:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSGGWeb>; Sun, 7 Jul 2002 18:34:31 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:32781 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316595AbSGGWe0>; Sun, 7 Jul 2002 18:34:26 -0400
Date: Mon, 8 Jul 2002 00:36:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Keith Owens <kaos@ocs.com.au>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal 
In-Reply-To: <9171.1026053813@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0207072154080.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Jul 2002, Keith Owens wrote:

> With CONFIG_PREEMPT, a process running on another cpu without a lock
> when freeze_processes() is called should immediately end up in
> schedule.  I don't see anything in that code path that disables
> preemption on other cpus.  If I am right, then a second cpu could be in
> this window when freeze_processes is called
>
>   if (xxx->func)
>     xxx->func()
>
> where func is a module function.  There is still a window from loading
> the function address, through calling the function and up to the point
> where the function does MOD_INC_USE_COUNT.  Any reschedule in that
> window opens a race with rmmod.  Without preemption, freeze might be
> safe, with preemption the race is back again.

While I agree that the current module interface is broken, but the current
suggestions are IMHO not any better. They rely on specific knowledge about
the scheduler. Next time someone wants to change the scheduler or the
scheduling behaviour, he runs into the risk breaking modules (again).

All we have to do is to make sure that there is no reference to the module
left. In other words we have to make sure there is no data structure with
a reference to the module left. Managing data structures is something we
already have to do anyway, so why don't we just the existing interfaces?

As an example I have an alternative "fix" (that means it compiles) for the
bdev layer. First it makes (un)register_blkdev smp/preempt safe, but the
important change is in unregister_blkdev, which basically does:

	for_all_bdev(bdev) {
		if (bdev->bd_op == op)
			return -EBUSY;
	}

After that we know that noone can call into the module anymore, now we
only have to make use of -EBUSY information somehow.
That means that the module count is not strictly necessary anymore and
structures don't have to be polluted with module owner fields.
IMO that's the far cleaner solution and doesn't require messing with the
scheduler. The module interface has to be fixed anyway and I'd prefer it
wouldn't require some scheduling magic.

bye, Roman

Index: fs/block_dev.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/block_dev.c,v
retrieving revision 1.1.1.17
diff -u -p -r1.1.1.17 block_dev.c
--- fs/block_dev.c	6 Jul 2002 00:33:38 -0000	1.1.1.17
+++ fs/block_dev.c	7 Jul 2002 22:12:50 -0000
@@ -417,55 +417,98 @@ int get_blkdev_list(char * p)
 	Return the function table of a device.
 	Load the driver if needed.
 */
-const struct block_device_operations * get_blkfops(unsigned int major)
+const struct block_device_operations *__get_blkfops(unsigned int major)
 {
 	const struct block_device_operations *ret = NULL;

 	/* major 0 is used for non-device mounts */
 	if (major && major < MAX_BLKDEV) {
 #ifdef CONFIG_KMOD
+		spin_unlock(&bdev_lock);
 		if (!blkdevs[major].bdops) {
 			char name[20];
 			sprintf(name, "block-major-%d", major);
 			request_module(name);
 		}
+		spin_lock(&bdev_lock);
 #endif
 		ret = blkdevs[major].bdops;
 	}
 	return ret;
 }

+const struct block_device_operations *get_blkfops(unsigned int major)
+{
+	const struct block_device_operations *bd;
+	spin_lock(&bdev_lock);
+	bd = __get_blkfops(major);
+	spin_unlock(&bdev_lock);
+	return bd;
+}
+
 int register_blkdev(unsigned int major, const char * name, struct block_device_operations *bdops)
 {
+	int res = 0;
+
+	spin_lock(&bdev_lock);
 	if (major == 0) {
 		for (major = MAX_BLKDEV-1; major > 0; major--) {
 			if (blkdevs[major].bdops == NULL) {
 				blkdevs[major].name = name;
 				blkdevs[major].bdops = bdops;
-				return major;
+				res = major;
+				goto out;
 			}
 		}
-		return -EBUSY;
+		res = -EBUSY;
+		goto out;
+	}
+	if (major >= MAX_BLKDEV) {
+		res = -EINVAL;
+		goto out;
+	}
+	if (blkdevs[major].bdops && blkdevs[major].bdops != bdops) {
+		res = -EBUSY;
+		goto out;
 	}
-	if (major >= MAX_BLKDEV)
-		return -EINVAL;
-	if (blkdevs[major].bdops && blkdevs[major].bdops != bdops)
-		return -EBUSY;
 	blkdevs[major].name = name;
 	blkdevs[major].bdops = bdops;
-	return 0;
+out:
+	spin_unlock(&bdev_lock);
+	return res;
 }

 int unregister_blkdev(unsigned int major, const char * name)
 {
+	struct block_device *bdev;
+	struct list_head *p;
+	int i, res = 0;
+
 	if (major >= MAX_BLKDEV)
 		return -EINVAL;
-	if (!blkdevs[major].bdops)
-		return -EINVAL;
-	if (strcmp(blkdevs[major].name, name))
-		return -EINVAL;
+	spin_lock(&bdev_lock);
+	if (!blkdevs[major].bdops) {
+		res = -EINVAL;
+		goto out;
+	}
+	if (strcmp(blkdevs[major].name, name)) {
+		res = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < HASH_SIZE; i++) {
+		list_for_each(p, &bdev_hashtable[i]) {
+			bdev = list_entry(p, struct block_device, bd_hash);
+			if (bdev->bd_op == blkdevs[major].bdops) {
+				res = -EBUSY;
+				goto out;
+			}
+		}
+	}
+
 	blkdevs[major].name = NULL;
 	blkdevs[major].bdops = NULL;
+out:
+	spin_unlock(&bdev_lock);
 	return 0;
 }

@@ -481,11 +524,15 @@ int unregister_blkdev(unsigned int major
 int check_disk_change(kdev_t dev)
 {
 	int i;
+	struct block_device *bdev = bdget(kdev_t_to_nr(dev));
 	const struct block_device_operations * bdops = NULL;

 	i = major(dev);
-	if (i < MAX_BLKDEV)
-		bdops = blkdevs[i].bdops;
+	spin_lock(&bdev_lock);
+	if (!bdev->bd_op && i < MAX_BLKDEV)
+		bdev->bd_op = blkdevs[i].bdops;
+	bdops = bdev->bd_op;
+	spin_unlock(&bdev_lock);
 	if (bdops == NULL) {
 		devfs_handle_t de;

@@ -496,12 +543,12 @@ int check_disk_change(kdev_t dev)
 			devfs_put_ops (de); /* We're running in owner module */
 		}
 	}
-	if (bdops == NULL)
-		return 0;
-	if (bdops->check_media_change == NULL)
-		return 0;
-	if (!bdops->check_media_change(dev))
+	if (bdops == NULL ||
+	    bdops->check_media_change == NULL ||
+	    !bdops->check_media_change(dev)) {
+		bdput(bdev);
 		return 0;
+	}

 	printk(KERN_DEBUG "VFS: Disk change detected on device %s\n",
 		__bdevname(dev));
@@ -511,6 +558,7 @@ int check_disk_change(kdev_t dev)

 	if (bdops->revalidate)
 		bdops->revalidate(dev);
+	bdput(bdev);
 	return 1;
 }

@@ -536,7 +584,9 @@ static int do_open(struct block_device *
 	down(&bdev->bd_sem);
 	lock_kernel();
 	if (!bdev->bd_op) {
-		bdev->bd_op = get_blkfops(major(dev));
+		spin_lock(&bdev_lock);
+		bdev->bd_op = __get_blkfops(major(dev));
+		spin_unlock(&bdev_lock);
 		if (!bdev->bd_op)
 			goto out;
 		owner = bdev->bd_op->owner;

