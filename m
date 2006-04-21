Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWDUEKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWDUEKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWDUEKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:10:00 -0400
Received: from users.ccur.com ([66.10.65.2]:37859 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S932172AbWDUEJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:09:59 -0400
Date: Fri, 21 Apr 2006 00:09:45 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: Problems with read() on /proc/devices with x86_64 system
Message-ID: <20060421040945.GA20499@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1140635265.26079.16.camel@lycan.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140635265.26079.16.camel@lycan.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 09:07:45PM +0200, Martin Schlemmer wrote:

> Not sure when it started, but 2.6.16-rc[1234] at least have problems
> with unbuffered read() and /proc/devices on my x86_64 box.  I first
> picked it up with dmsetup that did not want to work properly built
> against klibc (glibc with fread() worked fine though, as it mmap()'d the
> file).
> 
> Following code (from HPA and klibc mailing lists), when compiled and run
> with /proc/devices only reads the first two lines and then exits
> normally, where with any other file works as expected.

Hi Martin,
I case you haven't found out yet, this is fixed in 2.6.17 by:

   [PATCH] Simplify proc/devices and fix early termination regression

Attached is the version for 2.6.16.

Regards,
Joe


Repair /proc/devices early-termination regression.

2.6.16 broke /proc/devices.  An application often gets an
EOF before the end of data is reached, if that application
uses a series of short read(2)s to access the data.  I have
used read buffers of varying sizes with varying degrees
of unsuccess (larger sizes get further into the data than
smaller sizes, following a simple pattern).  It appears
that the only safe way to get the data is to use a single
read buffer larger than all the data in /proc/devices.

The following example demonstates the problem:

    # dd if=/proc/devices bs=1
    Character devices:
      1 mem
    27+0 records in
    27+0 records out

This patch is a backport of the fix recently accepted to
Linus's tree:

    commit 68eef3b4791572ecb70249c7fb145bb3742dd899
    [PATCH] Simplify proc/devices and fix early termination regression

It replaces the complex, state-machine algorithm introduced
in 2.6.16 with a simple algorithm, modeled on the implementation
of /proc/interrupts.

[akpm@osdl.org: cleanups, simplifications]

Signed-off-by: Joe Korty <joe.korty@ccur.com>


 2.6.16.1-jak/block/genhd.c       |  103 ++----------------------
 2.6.16.1-jak/fs/char_dev.c       |   87 ++-------------------
 2.6.16.1-jak/fs/proc/proc_misc.c |  161 ++++++++-------------------------------
 2.6.16.1-jak/include/linux/fs.h  |   15 ---
 4 files changed, 61 insertions(+), 305 deletions(-)

diff -puNa block/genhd.c~patch block/genhd.c
--- 2.6.16.1/block/genhd.c~patch	2006-03-31 11:09:50.000000000 -0500
+++ 2.6.16.1-jak/block/genhd.c	2006-03-31 11:49:10.000000000 -0500
@@ -16,8 +16,6 @@
 #include <linux/kobj_map.h>
 #include <linux/buffer_head.h>
 
-#define MAX_PROBE_HASH 255	/* random */
-
 static struct subsystem block_subsys;
 
 static DECLARE_MUTEX(block_subsys_sem);
@@ -30,108 +28,29 @@ static struct blk_major_name {
 	struct blk_major_name *next;
 	int major;
 	char name[16];
-} *major_names[MAX_PROBE_HASH];
+} *major_names[BLKDEV_MAJOR_HASH_SIZE];
 
 /* index in the above - for now: assume no multimajor ranges */
 static inline int major_to_index(int major)
 {
-	return major % MAX_PROBE_HASH;
-}
-
-struct blkdev_info {
-        int index;
-        struct blk_major_name *bd;
-};
-
-/*
- * iterate over a list of blkdev_info structures.  allows
- * the major_names array to be iterated over from outside this file
- * must be called with the block_subsys_sem held
- */
-void *get_next_blkdev(void *dev)
-{
-        struct blkdev_info *info;
-
-        if (dev == NULL) {
-                info = kmalloc(sizeof(*info), GFP_KERNEL);
-                if (!info)
-                        goto out;
-                info->index=0;
-                info->bd = major_names[info->index];
-                if (info->bd)
-                        goto out;
-        } else {
-                info = dev;
-        }
-
-        while (info->index < ARRAY_SIZE(major_names)) {
-                if (info->bd)
-                        info->bd = info->bd->next;
-                if (info->bd)
-                        goto out;
-                /*
-                 * No devices on this chain, move to the next
-                 */
-                info->index++;
-                info->bd = (info->index < ARRAY_SIZE(major_names)) ?
-			major_names[info->index] : NULL;
-                if (info->bd)
-                        goto out;
-        }
-
-out:
-        return info;
-}
-
-void *acquire_blkdev_list(void)
-{
-        down(&block_subsys_sem);
-        return get_next_blkdev(NULL);
-}
-
-void release_blkdev_list(void *dev)
-{
-        up(&block_subsys_sem);
-        kfree(dev);
+	return major % BLKDEV_MAJOR_HASH_SIZE;
 }
 
+#ifdef CONFIG_PROC_FS
 
-/*
- * Count the number of records in the blkdev_list.
- * must be called with the block_subsys_sem held
- */
-int count_blkdev_list(void)
+void blkdev_show(struct seq_file *f, off_t offset)
 {
-	struct blk_major_name *n;
-	int i, count;
-
-	count = 0;
+	struct blk_major_name *dp;
 
-	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
-		for (n = major_names[i]; n; n = n->next)
-				count++;
+	if (offset < BLKDEV_MAJOR_HASH_SIZE) {
+		down(&block_subsys_sem);
+		for (dp = major_names[offset]; dp; dp = dp->next)
+			seq_printf(f, "%3d %s\n", dp->major, dp->name);
+		up(&block_subsys_sem);
 	}
-
-	return count;
-}
-
-/*
- * extract the major and name values from a blkdev_info struct
- * passed in as a void to *dev.  Must be called with
- * block_subsys_sem held
- */
-int get_blkdev_info(void *dev, int *major, char **name)
-{
-        struct blkdev_info *info = dev;
-
-        if (info->bd == NULL)
-                return 1;
-
-        *major = info->bd->major;
-        *name = info->bd->name;
-        return 0;
 }
 
+#endif /* CONFIG_PROC_FS */
 
 int register_blkdev(unsigned int major, const char *name)
 {
diff -puNa fs/char_dev.c~patch fs/char_dev.c
--- 2.6.16.1/fs/char_dev.c~patch	2006-03-31 11:09:50.000000000 -0500
+++ 2.6.16.1-jak/fs/char_dev.c	2006-03-31 11:49:10.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/seq_file.h>
 
 #include <linux/kobject.h>
 #include <linux/kobj_map.h>
@@ -26,8 +27,6 @@
 
 static struct kobj_map *cdev_map;
 
-#define MAX_PROBE_HASH 255	/* random */
-
 static DECLARE_MUTEX(chrdevs_lock);
 
 static struct char_device_struct {
@@ -38,93 +37,29 @@ static struct char_device_struct {
 	char name[64];
 	struct file_operations *fops;
 	struct cdev *cdev;		/* will die */
-} *chrdevs[MAX_PROBE_HASH];
+} *chrdevs[CHRDEV_MAJOR_HASH_SIZE];
 
 /* index in the above */
 static inline int major_to_index(int major)
 {
-	return major % MAX_PROBE_HASH;
-}
-
-struct chrdev_info {
-	int index;
-	struct char_device_struct *cd;
-};
-
-void *get_next_chrdev(void *dev)
-{
-	struct chrdev_info *info;
-
-	if (dev == NULL) {
-		info = kmalloc(sizeof(*info), GFP_KERNEL);
-		if (!info)
-			goto out;
-		info->index=0;
-		info->cd = chrdevs[info->index];
-		if (info->cd)
-			goto out;
-	} else {
-		info = dev;
-	}
-
-	while (info->index < ARRAY_SIZE(chrdevs)) {
-		if (info->cd)
-			info->cd = info->cd->next;
-		if (info->cd)
-			goto out;
-		/*
-		 * No devices on this chain, move to the next
-		 */
-		info->index++;
-		info->cd = (info->index < ARRAY_SIZE(chrdevs)) ?
-			chrdevs[info->index] : NULL;
-		if (info->cd)
-			goto out;
-	}
-
-out:
-	return info;
-}
-
-void *acquire_chrdev_list(void)
-{
-	down(&chrdevs_lock);
-	return get_next_chrdev(NULL);
-}
-
-void release_chrdev_list(void *dev)
-{
-	up(&chrdevs_lock);
-	kfree(dev);
+	return major % CHRDEV_MAJOR_HASH_SIZE;
 }
 
+#ifdef CONFIG_PROC_FS
 
-int count_chrdev_list(void)
+void chrdev_show(struct seq_file *f, off_t offset)
 {
 	struct char_device_struct *cd;
-	int i, count;
-
-	count = 0;
 
-	for (i = 0; i < ARRAY_SIZE(chrdevs) ; i++) {
-		for (cd = chrdevs[i]; cd; cd = cd->next)
-			count++;
+	if (offset < CHRDEV_MAJOR_HASH_SIZE) {
+		down(&chrdevs_lock);
+		for (cd = chrdevs[offset]; cd; cd = cd->next)
+			seq_printf(f, "%3d %s\n", cd->major, cd->name);
+		up(&chrdevs_lock);
 	}
-
-	return count;
 }
 
-int get_chrdev_info(void *dev, int *major, char **name)
-{
-	struct chrdev_info *info = dev;
-
-	if (info->cd == NULL)
-		return 1;
-
-	*major = info->cd->major;
-	*name = info->cd->name;
-	return 0;
-}
+#endif /* CONFIG_PROC_FS */
 
 /*
  * Register a single major with a specified minor range.
diff -puNa fs/proc/proc_misc.c~patch fs/proc/proc_misc.c
--- 2.6.16.1/fs/proc/proc_misc.c~patch	2006-03-31 11:09:50.000000000 -0500
+++ 2.6.16.1-jak/fs/proc/proc_misc.c	2006-03-31 11:49:10.000000000 -0500
@@ -249,144 +249,60 @@ static int cpuinfo_open(struct inode *in
 	return seq_open(file, &cpuinfo_op);
 }
 
-enum devinfo_states {
-	CHR_HDR,
-	CHR_LIST,
-	BLK_HDR,
-	BLK_LIST,
-	DEVINFO_DONE
-};
-
-struct devinfo_state {
-	void *chrdev;
-	void *blkdev;
-	unsigned int num_records;
-	unsigned int cur_record;
-	enum devinfo_states state;
+static struct file_operations proc_cpuinfo_operations = {
+	.open		= cpuinfo_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 
-static void *devinfo_start(struct seq_file *f, loff_t *pos)
+static int devinfo_show(struct seq_file *f, void *v)
 {
-	struct devinfo_state *info = f->private;
+	int i = *(loff_t *) v;
 
-	if (*pos) {
-		if ((info) && (*pos <= info->num_records))
-			return info;
-		return NULL;
+	if (i < CHRDEV_MAJOR_HASH_SIZE) {
+		if (i == 0)
+			seq_printf(f, "Character devices:\n");
+		chrdev_show(f, i);
+	} else {
+		i -= CHRDEV_MAJOR_HASH_SIZE;
+		if (i == 0)
+			seq_printf(f, "\nBlock devices:\n");
+		blkdev_show(f, i);
 	}
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	f->private = info;
-	info->chrdev = acquire_chrdev_list();
-	info->blkdev = acquire_blkdev_list();
-	info->state = CHR_HDR;
-	info->num_records = count_chrdev_list();
-	info->num_records += count_blkdev_list();
-	info->num_records += 2; /* Character and Block headers */
-	*pos = 1;
-	info->cur_record = *pos;
-	return info;
+	return 0;
 }
 
-static void *devinfo_next(struct seq_file *f, void *v, loff_t *pos)
+static void *devinfo_start(struct seq_file *f, loff_t *pos)
 {
-	int idummy;
-	char *ndummy;
-	struct devinfo_state *info = f->private;
-
-	switch (info->state) {
-		case CHR_HDR:
-			info->state = CHR_LIST;
-			(*pos)++;
-			/*fallthrough*/
-		case CHR_LIST:
-			if (get_chrdev_info(info->chrdev,&idummy,&ndummy)) {
-				/*
-				 * The character dev list is complete
-				 */
-				info->state = BLK_HDR;
-			} else {
-				info->chrdev = get_next_chrdev(info->chrdev);
-			}
-			(*pos)++;
-			break;
-		case BLK_HDR:
-			info->state = BLK_LIST;
-			(*pos)++;
-			/*fallthrough*/
-		case BLK_LIST:
-			if (get_blkdev_info(info->blkdev,&idummy,&ndummy)) {
-				/*
-				 * The block dev list is complete
-				 */
-				info->state = DEVINFO_DONE;
-			} else {
-				info->blkdev = get_next_blkdev(info->blkdev);
-			}
-			(*pos)++;
-			break;
-		case DEVINFO_DONE:
-			(*pos)++;
-			info->cur_record = *pos;
-			info = NULL;
-			break;
-		default:
-			break;
-	}
-	if (info)
-		info->cur_record = *pos;
-	return info;
+	if (*pos < (BLKDEV_MAJOR_HASH_SIZE + CHRDEV_MAJOR_HASH_SIZE))
+		return pos;
+	return NULL;
 }
 
-static void devinfo_stop(struct seq_file *f, void *v)
+static void *devinfo_next(struct seq_file *f, void *v, loff_t *pos)
 {
-	struct devinfo_state *info = f->private;
-
-	if (info) {
-		release_chrdev_list(info->chrdev);
-		release_blkdev_list(info->blkdev);
-		f->private = NULL;
-		kfree(info);
-	}
+	(*pos)++;
+	if (*pos >= (BLKDEV_MAJOR_HASH_SIZE + CHRDEV_MAJOR_HASH_SIZE))
+		return NULL;
+	return pos;
 }
 
-static int devinfo_show(struct seq_file *f, void *arg)
+static void devinfo_stop(struct seq_file *f, void *v)
 {
-	int major;
-	char *name;
-	struct devinfo_state *info = f->private;
-
-	switch(info->state) {
-		case CHR_HDR:
-			seq_printf(f,"Character devices:\n");
-			/* fallthrough */
-		case CHR_LIST:
-			if (!get_chrdev_info(info->chrdev,&major,&name))
-				seq_printf(f,"%3d %s\n",major,name);
-			break;
-		case BLK_HDR:
-			seq_printf(f,"\nBlock devices:\n");
-			/* fallthrough */
-		case BLK_LIST:
-			if (!get_blkdev_info(info->blkdev,&major,&name))
-				seq_printf(f,"%3d %s\n",major,name);
-			break;
-		default:
-			break;
-	}
-
-	return 0;
+	/* Nothing to do */
 }
 
-static  struct seq_operations devinfo_op = {
-	.start  = devinfo_start,
-	.next   = devinfo_next,
-	.stop   = devinfo_stop,
-	.show   = devinfo_show,
+static struct seq_operations devinfo_ops = {
+	.start = devinfo_start,
+	.next  = devinfo_next,
+	.stop  = devinfo_stop,
+	.show  = devinfo_show
 };
 
-static int devinfo_open(struct inode *inode, struct file *file)
+static int devinfo_open(struct inode *inode, struct file *filp)
 {
-	return seq_open(file, &devinfo_op);
+	return seq_open(filp, &devinfo_ops);
 }
 
 static struct file_operations proc_devinfo_operations = {
@@ -396,13 +312,6 @@ static struct file_operations proc_devin
 	.release	= seq_release,
 };
 
-static struct file_operations proc_cpuinfo_operations = {
-	.open		= cpuinfo_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 extern struct seq_operations vmstat_op;
 static int vmstat_open(struct inode *inode, struct file *file)
 {
diff -puNa include/linux/fs.h~patch include/linux/fs.h
--- 2.6.16.1/include/linux/fs.h~patch	2006-03-31 11:09:50.000000000 -0500
+++ 2.6.16.1-jak/include/linux/fs.h	2006-03-31 11:09:50.000000000 -0500
@@ -1383,6 +1383,7 @@ extern int bd_claim(struct block_device 
 extern void bd_release(struct block_device *);
 
 /* fs/char_dev.c */
+#define CHRDEV_MAJOR_HASH_SIZE	255
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
 extern int register_chrdev_region(dev_t, unsigned, const char *);
 extern int register_chrdev(unsigned int, const char *,
@@ -1390,25 +1391,17 @@ extern int register_chrdev(unsigned int,
 extern int unregister_chrdev(unsigned int, const char *);
 extern void unregister_chrdev_region(dev_t, unsigned);
 extern int chrdev_open(struct inode *, struct file *);
-extern int get_chrdev_list(char *);
-extern void *acquire_chrdev_list(void);
-extern int count_chrdev_list(void);
-extern void *get_next_chrdev(void *);
-extern int get_chrdev_info(void *, int *, char **);
-extern void release_chrdev_list(void *);
+extern void chrdev_show(struct seq_file *,off_t);
 
 /* fs/block_dev.c */
+#define BLKDEV_MAJOR_HASH_SIZE	255
 #define BDEVNAME_SIZE	32	/* Largest string for a blockdev identifier */
 extern const char *__bdevname(dev_t, char *buffer);
 extern const char *bdevname(struct block_device *bdev, char *buffer);
 extern struct block_device *lookup_bdev(const char *);
 extern struct block_device *open_bdev_excl(const char *, int, void *);
 extern void close_bdev_excl(struct block_device *);
-extern void *acquire_blkdev_list(void);
-extern int count_blkdev_list(void);
-extern void *get_next_blkdev(void *);
-extern int get_blkdev_info(void *, int *, char **);
-extern void release_blkdev_list(void *);
+extern void blkdev_show(struct seq_file *,off_t);
 
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 

_

