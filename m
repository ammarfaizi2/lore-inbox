Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQKPVbF>; Thu, 16 Nov 2000 16:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQKPVaz>; Thu, 16 Nov 2000 16:30:55 -0500
Received: from [213.8.185.152] ([213.8.185.152]:35599 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129524AbQKPVaq>;
	Thu, 16 Nov 2000 16:30:46 -0500
Date: Thu, 16 Nov 2000 23:00:11 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH (2.4)] atomic use count for proc_dir_entry
Message-ID: <Pine.LNX.4.21.0011162237040.16415-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(against test11-pre5)

Makes procfs use an atomic use count for dir entries, to avoid using 
the Big kernel lock. Axboe says it looks ok.

--- linux/fs/proc/inode.c	Wed Jun 21 17:25:17 2000
+++ linux/fs/proc/inode.c	Thu Nov 16 19:09:28 2000
@@ -25,7 +25,7 @@
 struct proc_dir_entry * de_get(struct proc_dir_entry *de)
 {
 	if (de)
-		de->count++;
+		atomic_inc(&de->count);
 	return de;
 }
 
@@ -35,20 +35,18 @@
 void de_put(struct proc_dir_entry *de)
 {
 	if (de) {
-		lock_kernel(); /* FIXME: count should be atomic_t */
-		if (!de->count) {
+		if (!atomic_read(&de->count)) {
 			printk("de_put: entry %s already free!\n", de->name);
 			return;
 		}
 
-		if (!--de->count) {
+		if (atomic_dec_and_test(&de->count)) {
 			if (de->deleted) {
 				printk("de_put: deferred delete of %s\n",
 					de->name);
 				free_proc_entry(de);
 			}
 		}
-		unlock_kernel();
 	}
 }
 
@@ -139,7 +137,7 @@
 #if 1
 /* shouldn't ever happen */
 if (de && de->deleted)
-printk("proc_iget: using deleted entry %s, count=%d\n", de->name, de->count);
+printk("proc_iget: using deleted entry %s, count=%d\n", de->name, atomic_read(&de->count));
 #endif
 
 	inode = iget(sb, ino);
--- linux/fs/proc/generic.c	Tue Nov 14 09:57:01 2000
+++ linux/fs/proc/generic.c	Thu Nov 16 20:47:48 2000
@@ -215,7 +215,7 @@
 
 static struct inode_operations proc_link_inode_operations = {
 	readlink:	proc_readlink,
-	follow_link:	proc_follow_link
+	follow_link:	proc_follow_link,
 };
 
 /*
@@ -574,11 +574,11 @@
 		proc_kill_inodes(de);
 		de->nlink = 0;
 		de->deleted = 1;
-		if (!de->count)
+		if (!atomic_read(&de->count))
 			free_proc_entry(de);
 		else {
 			printk("remove_proc_entry: %s/%s busy, count=%d\n",
-				parent->name, de->name, de->count);
+				parent->name, de->name, atomic_read(&de->count));
 		}
 		break;
 	}
--- linux/fs/proc/root.c	Mon May 22 06:34:37 2000
+++ linux/fs/proc/root.c	Thu Nov 16 19:22:43 2000
@@ -96,10 +96,12 @@
  * This is the root "inode" in the /proc tree..
  */
 struct proc_dir_entry proc_root = {
-	PROC_ROOT_INO, 5, "/proc",
-	S_IFDIR | S_IRUGO | S_IXUGO, 2, 0, 0,
-	0, &proc_root_inode_operations, &proc_root_operations,
-	NULL, NULL,
-	NULL,
-	&proc_root, NULL
+	low_ino:	PROC_ROOT_INO, 
+	namelen:	5, 
+	name:		"/proc",
+	mode:		S_IFDIR | S_IRUGO | S_IXUGO, 
+	nlink:		2, 
+	proc_iops:	&proc_root_inode_operations, 
+	proc_fops:	&proc_root_operations,
+	parent:		&proc_root,
 };
--- linux/kernel/sysctl.c	Tue Nov 14 09:57:49 2000
+++ linux/kernel/sysctl.c	Thu Nov 16 19:35:02 2000
@@ -571,7 +571,7 @@
 		}
 
 		/* Don't unregister proc entries that are still being used.. */
-		if (de->count)
+		if (atomic_read(&de->count))
 			continue;
 
 		table->de = NULL;
--- linux/include/linux/proc_fs.h	Thu Nov 16 18:40:47 2000
+++ linux/include/linux/proc_fs.h	Thu Nov 16 19:32:18 2000
@@ -67,7 +67,7 @@
 	void *data;
 	read_proc_t *read_proc;
 	write_proc_t *write_proc;
-	unsigned int count;	/* use count */
+	atomic_t count;	/* use count */
 	int deleted;		/* delete flag */
 	kdev_t	rdev;
 };
--- linux/drivers/pci/proc.c	Tue Nov 14 09:56:55 2000
+++ linux/drivers/pci/proc.c	Thu Nov 16 19:37:57 2000
@@ -279,7 +279,7 @@
 	struct proc_dir_entry *e;
 
 	if ((e = dev->procent)) {
-		if (e->count)
+		if (atomic_read(&e->count))
 			return -EBUSY;
 		remove_proc_entry(e->name, dev->bus->procdir);
 		dev->procent = NULL;
--- linux/drivers/nubus/proc.c	Sun Nov 28 01:27:48 1999
+++ linux/drivers/nubus/proc.c	Thu Nov 16 22:21:34 2000
@@ -148,7 +148,7 @@
 	struct proc_dir_entry *e;
 
 	if ((e = dev->procdir)) {
-		if (e->count)
+		if (atomic_read(&e->count))
 			return -EBUSY;
 		remove_proc_entry(e->name, proc_bus_nubus_dir);
 		dev->procdir = NULL;
--- linux/drivers/i2o/i2o_proc.c	Tue Nov 14 09:56:52 2000
+++ linux/drivers/i2o/i2o_proc.c	Thu Nov 16 22:44:44 2000
@@ -3237,7 +3237,7 @@
 	for(dev=pctrl->devices; dev; dev=dev->next)
 		i2o_proc_remove_device(dev);
 
-	if(!pctrl->proc_entry->count)
+	if(!atomic_read(&pctrl->proc_entry->count))
 	{
 		sprintf(buff, "iop%d", pctrl->unit);
 
@@ -3257,7 +3257,7 @@
 
 	i2o_device_notify_off(dev, &i2o_proc_handler);
 	/* Would it be safe to remove _files_ even if they are in use? */
-	if((de) && (!de->count))
+	if((de) && (!atomic_read(&de->count)))
 	{
 		i2o_proc_remove_entries(generic_dev_entries, de);
 		switch(dev->lct_data.class_id)
@@ -3334,7 +3334,7 @@
 		}
 	}
 
-	if(!i2o_proc_dir_root->count)
+	if(!atomic_read(&i2o_proc_dir_root->count))
 		remove_proc_entry("i2o", 0);
 	else
 		return -1;

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
