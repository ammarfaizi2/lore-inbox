Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWCXWwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWCXWwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWCXWwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:52:00 -0500
Received: from users.ccur.com ([66.10.65.2]:54155 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S932147AbWCXWv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:51:59 -0500
Date: Fri, 24 Mar 2006 17:51:46 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Neil Horman <nhorman@tuxdriver.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Simplify proc/devices and fix early termination regression
Message-ID: <20060324225146.GA5260@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make baby-simple the code for /proc/devices.  Based on
the proven design for /proc/interrupts.

This also fixes the early-termination regression 2.6.16
introduced, as demonstrated by:

    # dd if=/proc/devices bs=1
    Character devices:
      1 mem
    27+0 records in
    27+0 records out

This should also work (but is untested) when /proc/devices
>4096 bytes, which I believe is what the original 2.6.16
rewrite fixed.

Signed-off-by: Joe Korty <joe.korty@ccur.com>


 2.6.16-git9-jak/block/genhd.c       |   98 ++--------------------
 2.6.16-git9-jak/fs/char_dev.c       |   82 ++----------------
 2.6.16-git9-jak/fs/proc/proc_misc.c |  159 +++++++-----------------------------
 2.6.16-git9-jak/include/linux/fs.h  |   15 ---
 4 files changed, 61 insertions(+), 293 deletions(-)

diff -puNa block/genhd.c~simplify.proc.devices.and.fix.early.termination.regression block/genhd.c
--- 2.6.16-git9/block/genhd.c~simplify.proc.devices.and.fix.early.termination.regression	2006-03-24 16:59:57.000000000 -0500
+++ 2.6.16-git9-jak/block/genhd.c	2006-03-24 17:09:22.000000000 -0500
@@ -39,100 +39,26 @@ static inline int major_to_index(int maj
 	return major % MAX_PROBE_HASH;
 }
 
-struct blkdev_info {
-        int index;
-        struct blk_major_name *bd;
-};
-
-/*
- * iterate over a list of blkdev_info structures.  allows
- * the major_names array to be iterated over from outside this file
- * must be called with the block_subsys_lock held
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
-        mutex_lock(&block_subsys_lock);
-        return get_next_blkdev(NULL);
-}
+#ifdef CONFIG_PROC_FS
 
-void release_blkdev_list(void *dev)
-{
-        mutex_unlock(&block_subsys_lock);
-        kfree(dev);
+fastcall int blkdev_size(void) {
+	return MAX_PROBE_HASH;
 }
 
-
-/*
- * Count the number of records in the blkdev_list.
- * must be called with the block_subsys_lock held
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
+	if (offset < MAX_PROBE_HASH) {
+		mutex_lock(&block_subsys_lock);
+		for (dp = major_names[offset] ;dp; dp=dp->next) {
+			seq_printf(f, "%3d %s\n", dp->major, dp->name);
+		}
+		mutex_unlock(&block_subsys_lock);
 	}
-
-	return count;
-}
-
-/*
- * extract the major and name values from a blkdev_info struct
- * passed in as a void to *dev.  Must be called with
- * block_subsys_lock held
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
diff -puNa fs/char_dev.c~simplify.proc.devices.and.fix.early.termination.regression fs/char_dev.c
--- 2.6.16-git9/fs/char_dev.c~simplify.proc.devices.and.fix.early.termination.regression	2006-03-24 16:59:57.000000000 -0500
+++ 2.6.16-git9-jak/fs/char_dev.c	2006-03-24 17:11:31.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/seq_file.h>
 
 #include <linux/kobject.h>
 #include <linux/kobj_map.h>
@@ -47,85 +48,26 @@ static inline int major_to_index(int maj
 	return major % MAX_PROBE_HASH;
 }
 
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
+#ifdef CONFIG_PROC_FS
 
-void *acquire_chrdev_list(void)
-{
-	mutex_lock(&chrdevs_lock);
-	return get_next_chrdev(NULL);
-}
-
-void release_chrdev_list(void *dev)
-{
-	mutex_unlock(&chrdevs_lock);
-	kfree(dev);
+fastcall int chrdev_size(void) {
+	return MAX_PROBE_HASH;
 }
 
-
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
+	if (offset < MAX_PROBE_HASH) {
+		mutex_lock(&chrdevs_lock);
+		for (cd = chrdevs[offset] ;cd; cd=cd->next) {
+			seq_printf(f, "%3d %s\n", cd->major, cd->name);
+		}
+		mutex_unlock(&chrdevs_lock);
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
diff -puNa fs/proc/proc_misc.c~simplify.proc.devices.and.fix.early.termination.regression fs/proc/proc_misc.c
--- 2.6.16-git9/fs/proc/proc_misc.c~simplify.proc.devices.and.fix.early.termination.regression	2006-03-24 16:59:57.000000000 -0500
+++ 2.6.16-git9-jak/fs/proc/proc_misc.c	2006-03-24 16:59:57.000000000 -0500
@@ -249,144 +249,58 @@ static int cpuinfo_open(struct inode *in
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
+	if (i < chrdev_size()) {
+		if (i == 0)
+			seq_printf(f, "Character devices:\n");
+		chrdev_show(f, i);
+	} else {
+		i -= chrdev_size();
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
+	return (*pos <= (blkdev_size() + chrdev_size())) ? pos : NULL;
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
+	if (*pos > (blkdev_size() + chrdev_size()))
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
@@ -396,13 +310,6 @@ static struct file_operations proc_devin
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
diff -puNa include/linux/fs.h~simplify.proc.devices.and.fix.early.termination.regression include/linux/fs.h
--- 2.6.16-git9/include/linux/fs.h~simplify.proc.devices.and.fix.early.termination.regression	2006-03-24 16:59:57.000000000 -0500
+++ 2.6.16-git9-jak/include/linux/fs.h	2006-03-24 16:59:57.000000000 -0500
@@ -1408,12 +1408,8 @@ extern int register_chrdev(unsigned int,
 extern int unregister_chrdev(unsigned int, const char *);
 extern void unregister_chrdev_region(dev_t, unsigned);
 extern int chrdev_open(struct inode *, struct file *);
-extern int get_chrdev_list(char *);
-extern void *acquire_chrdev_list(void);
-extern int count_chrdev_list(void);
-extern void *get_next_chrdev(void *);
-extern int get_chrdev_info(void *, int *, char **);
-extern void release_chrdev_list(void *);
+extern fastcall int chrdev_size(void);
+extern void chrdev_show(struct seq_file *,off_t);
 
 /* fs/block_dev.c */
 #define BDEVNAME_SIZE	32	/* Largest string for a blockdev identifier */
@@ -1422,11 +1418,8 @@ extern const char *bdevname(struct block
 extern struct block_device *lookup_bdev(const char *);
 extern struct block_device *open_bdev_excl(const char *, int, void *);
 extern void close_bdev_excl(struct block_device *);
-extern void *acquire_blkdev_list(void);
-extern int count_blkdev_list(void);
-extern void *get_next_blkdev(void *);
-extern int get_blkdev_info(void *, int *, char **);
-extern void release_blkdev_list(void *);
+extern fastcall int blkdev_size(void);
+extern void blkdev_show(struct seq_file *,off_t);
 
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 

_
