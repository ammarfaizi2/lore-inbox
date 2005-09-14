Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbVINNYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbVINNYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbVINNYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:24:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965202AbVINNYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:24:08 -0400
Date: Wed, 14 Sep 2005 09:23:57 -0400
From: Neil Horman <nhorman@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH]: proc: convert /proc/device file to use seq_file interface
Message-ID: <20050914132357.GB15795@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost/correction to my previous patch to convert the /proc/devices
fiel to use the seq_file api.  Previous patch was found to deadlock under some
circumstances, and this patch corrects those cases.

Signed-off-by: Neil Horman <nhorman@redhat.com>


 drivers/block/genhd.c |  108 ++++++++++++++++++++++++++------
 fs/char_dev.c         |   94 +++++++++++++++++++++------
 fs/proc/proc_misc.c   |  168 +++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 319 insertions(+), 51 deletions(-)


--- linux-2.6/drivers/block/genhd.c.orig	2005-09-13 10:31:05.000000000 -0400
+++ linux-2.6/drivers/block/genhd.c	2005-09-13 20:44:51.000000000 -0400
@@ -39,34 +39,102 @@ static inline int major_to_index(int maj
 	return major % MAX_PROBE_HASH;
 }
 
-#ifdef CONFIG_PROC_FS
-/* get block device names in somewhat random order */
-int get_blkdev_list(char *p, int used)
+struct blkdev_info {
+        int index;
+        struct blk_major_name *bd;
+};
+
+/*
+ * iterate over a list of blkdev_info structures.  allows
+ * the major_names array to be iterated over from outside this file
+ * must be called with the block_subsys_sem held
+ */
+void *get_next_blkdev(void *dev)
+{
+        struct blkdev_info *info;
+
+        if (dev == NULL) {
+                info = kmalloc(sizeof(*info), GFP_KERNEL);
+                if (!info)
+                        goto out;
+                info->index=0;
+                info->bd = major_names[info->index];
+                if(info->bd)
+                        goto out;
+        } else {
+                info = dev;
+        }
+
+        while (info->index < ARRAY_SIZE(major_names)) {
+                if (info->bd)
+                        info->bd = info->bd->next;
+                if (info->bd)
+                        goto out;
+                /*
+                 *no devices on this chain, move to the next
+                 */
+                info->index++;
+                info->bd = (info->index < ARRAY_SIZE(major_names)) ? 
+			major_names[info->index] : NULL;
+                if (info->bd)
+                        goto out;
+        }
+
+out:
+        return info;
+}
+
+void *acquire_blkdev_list(void)
+{
+        down(&block_subsys_sem);
+
+
+        return get_next_blkdev(NULL);
+}
+
+void release_blkdev_list(void *dev)
+{
+        up(&block_subsys_sem);
+        kfree(dev);
+}
+
+
+/*
+ * Count the number of records in the blkdev_list.
+ * must be called with the block_subsys_sem held
+ */
+int count_blkdev_list(void)
 {
 	struct blk_major_name *n;
-	int i, len;
+	int i, count;
 
-	len = snprintf(p, (PAGE_SIZE-used), "\nBlock devices:\n");
+	count = 0;
 
-	down(&block_subsys_sem);
 	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
-		for (n = major_names[i]; n; n = n->next) {
-			/*
-			 * If the curent string plus the 5 extra characters
-			 * in the line would run us off the page, then we're done
-			 */
-			if ((len + used + strlen(n->name) + 5) >= PAGE_SIZE)
-				goto page_full;
-			len += sprintf(p+len, "%3d %s\n",
-				       n->major, n->name);
-		}
+		for (n = major_names[i]; n; n = n->next)
+				count++;
 	}
-page_full:
-	up(&block_subsys_sem);
+	
+	return count;
+}
+
+/*
+ * extract the major and name values from a blkdev_info struct
+ * passed in as a void to *dev.  Must be called with 
+ * block_subsys_sem held
+ */
+int get_blkdev_info(void *dev, int *major, char **name)
+{
+        struct blkdev_info *info = dev;
+
+        if (info->bd == NULL)
+                return 1;
 
-	return len;
+        *major = info->bd->major;
+        *name = info->bd->name;
+        return 0;
 }
-#endif
+
 
 int register_blkdev(unsigned int major, const char *name)
 {
--- linux-2.6/fs/proc/proc_misc.c.orig	2005-09-13 10:31:08.000000000 -0400
+++ linux-2.6/fs/proc/proc_misc.c	2005-09-13 20:41:55.000000000 -0400
@@ -63,6 +63,16 @@
 extern int get_hardware_list(char *);
 extern int get_stram_list(char *);
 extern int get_chrdev_list(char *);
+extern void *acquire_chrdev_list(void);
+extern int count_chrdev_list(void);
+extern void *get_next_chrdev(void *);
+extern void *acquire_blkdev_list(void);
+extern int count_blkdev_list(void);
+extern void *get_next_blkdev(void *);
+extern int get_chrdev_info(void *, int *, char **);
+extern int get_blkdev_info(void *, int *, char **);
+extern void release_chrdev_list(void *);
+extern void release_blkdev_list(void *);
 extern int get_filesystem_list(char *);
 extern int get_exec_domain_list(char *);
 extern int get_dma_list(char *);
@@ -248,6 +258,154 @@ static int cpuinfo_open(struct inode *in
 {
 	return seq_open(file, &cpuinfo_op);
 }
+
+enum devinfo_states {
+	CHR_HDR,
+	CHR_LIST,
+	BLK_HDR,
+	BLK_LIST,
+	DEVINFO_DONE
+};
+
+struct devinfo_state {
+	void *chrdev;
+	void *blkdev;
+	unsigned int num_records;
+	unsigned int cur_record;
+	enum devinfo_states state;
+};
+
+static void *devinfo_start(struct seq_file *f, loff_t *pos)
+{
+	struct devinfo_state *info = f->private;
+
+	if (*pos) {
+		if ((info) && (*pos <= info->num_records)) 
+			return info;
+		return NULL;
+	}
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	f->private = info;
+	info->chrdev = acquire_chrdev_list(); 
+	info->blkdev = acquire_blkdev_list();
+	info->state = CHR_HDR;
+	info->num_records = count_chrdev_list();
+	info->num_records += count_blkdev_list();
+	info->num_records += 2; /* Character and Block headers */
+	*pos = 1;
+	info->cur_record = *pos;
+	return info;
+}
+
+static void *devinfo_next(struct seq_file *f, void *v, loff_t *pos)
+{
+	int idummy;
+	char *ndummy;
+	struct devinfo_state *info = f->private;
+
+	switch (info->state) {
+		case CHR_HDR:
+			info->state = CHR_LIST;
+			(*pos)++;
+			/*fallthrough*/
+		case CHR_LIST:
+			if (get_chrdev_info(info->chrdev,&idummy,&ndummy)) {
+				/*
+				 * The character dev list is complete
+				 */
+				info->state = BLK_HDR;	
+			} else {
+				info->chrdev = get_next_chrdev(info->chrdev);
+			}
+			(*pos)++;
+			break;
+		case BLK_HDR:	
+			info->state = BLK_LIST;
+			(*pos)++;
+			break;
+		case BLK_LIST:
+			if (get_blkdev_info(info->blkdev,&idummy,&ndummy)) {
+				/*
+				 * The block dev list is complete
+				 */
+				info->state = DEVINFO_DONE;	
+			} else {
+				info->blkdev = get_next_blkdev(info->blkdev);
+			}	
+			(*pos)++;
+			break;
+		case DEVINFO_DONE:
+			(*pos)++;
+			info->cur_record = *pos;
+			info = NULL;
+			break;
+		default:
+			break;
+	}
+	if (info)
+		info->cur_record = *pos;
+	return info;
+}
+
+static void devinfo_stop(struct seq_file *f, void *v)
+{
+	struct devinfo_state *info = f->private;
+
+	if (info) {
+		release_chrdev_list(info->chrdev);
+		release_blkdev_list(info->blkdev);
+		f->private = NULL;
+		kfree(info);	
+	}
+}
+
+static int devinfo_show(struct seq_file *f, void *arg)
+{
+	int major;
+	char *name;
+	struct devinfo_state *info = f->private;
+
+	switch(info->state) {
+		case CHR_HDR:
+			seq_printf(f,"Character devices:\n");
+			/* fallthrough */
+		case CHR_LIST:
+			if (!get_chrdev_info(info->chrdev,&major,&name))
+				seq_printf(f,"%3d %s\n",major,name);
+			break;
+		case BLK_HDR:
+			seq_printf(f,"\nBlock devices:\n");
+			/* fallthrough */
+		case BLK_LIST:
+			if (!get_blkdev_info(info->blkdev,&major,&name))
+				seq_printf(f,"%3d %s\n",major,name);
+			break;
+		default:
+			break;
+	}
+
+	return 0;
+}
+
+static  struct seq_operations devinfo_op = {
+	.start  = devinfo_start,
+	.next   = devinfo_next,
+	.stop   = devinfo_stop,
+	.show   = devinfo_show,
+};
+
+static int devinfo_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &devinfo_op);
+}
+
+static struct file_operations proc_devinfo_operations = {
+	.open		= devinfo_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static struct file_operations proc_cpuinfo_operations = {
 	.open		= cpuinfo_open,
 	.read		= seq_read,
@@ -448,14 +606,6 @@ static struct file_operations proc_stat_
 	.release	= single_release,
 };
 
-static int devices_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_chrdev_list(page);
-	len += get_blkdev_list(page+len, len);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
 /*
  * /proc/interrupts
  */
@@ -640,7 +790,6 @@ void __init proc_misc_init(void)
 #ifdef CONFIG_STRAM_PROC
 		{"stram",	stram_read_proc},
 #endif
-		{"devices",	devices_read_proc},
 		{"filesystems",	filesystems_read_proc},
 		{"cmdline",	cmdline_read_proc},
 		{"locks",	locks_read_proc},
@@ -656,6 +805,7 @@ void __init proc_misc_init(void)
 	entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
+	create_seq_entry("devices", 0, &proc_devinfo_operations);
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("stat", 0, &proc_stat_operations);
--- linux-2.6/fs/char_dev.c.orig	2005-09-13 10:30:01.000000000 -0400
+++ linux-2.6/fs/char_dev.c	2005-09-14 09:00:43.000000000 -0400
@@ -35,7 +35,7 @@ static struct char_device_struct {
 	unsigned int major;
 	unsigned int baseminor;
 	int minorct;
-	const char *name;
+	char name[64];
 	struct file_operations *fops;
 	struct cdev *cdev;		/* will die */
 } *chrdevs[MAX_PROBE_HASH];
@@ -46,34 +46,84 @@ static inline int major_to_index(int maj
 	return major % MAX_PROBE_HASH;
 }
 
-/* get char device names in somewhat random order */
-int get_chrdev_list(char *page)
-{
+struct chrdev_info {
+	int index;
 	struct char_device_struct *cd;
-	int i, len;
+};
 
-	len = sprintf(page, "Character devices:\n");
+void *get_next_chrdev(void *dev)
+{
+	struct chrdev_info *info;
+	
+	if (dev == NULL) {
+		info = kmalloc(sizeof(*info), GFP_KERNEL);
+		if (!info)
+			goto out;
+		info->index=0;
+		info->cd = chrdevs[info->index];
+		if(info->cd)
+			goto out;
+	} else {
+		info = dev;
+	}
 
+	while (info->index < ARRAY_SIZE(chrdevs)) {
+		if (info->cd)
+			info->cd = info->cd->next;
+		if (info->cd)
+			goto out;
+		/*
+		 * No devices on this chain, move to the next
+		 */
+		info->index++;
+		info->cd = (info->index < ARRAY_SIZE(chrdevs)) ? 
+			chrdevs[info->index] : NULL;
+		if (info->cd)
+			goto out;
+	}
+
+out:
+	return info;
+}
+
+void *acquire_chrdev_list(void)
+{
 	down(&chrdevs_lock);
-	for (i = 0; i < ARRAY_SIZE(chrdevs) ; i++) {
-		for (cd = chrdevs[i]; cd; cd = cd->next) {
-			/*
-			 * if the current name, plus the 5 extra characters
-			 * in the device line for this entry
-			 * would run us off the page, we're done
-			 */
-			if ((len+strlen(cd->name) + 5) >= PAGE_SIZE)
-				goto page_full;
+	return get_next_chrdev(NULL);	
+}
 
+void release_chrdev_list(void *dev)
+{
+	up(&chrdevs_lock);
+	kfree(dev);
+}
 
-			len += sprintf(page+len, "%3d %s\n",
-				       cd->major, cd->name);
-		}
+
+int count_chrdev_list(void)
+{
+	struct char_device_struct *cd;
+	int i, count;
+
+	count = 0;
+
+	for (i = 0; i < ARRAY_SIZE(chrdevs) ; i++) {
+		for (cd = chrdevs[i]; cd; cd = cd->next)
+			count++;
 	}
-page_full:
-	up(&chrdevs_lock);
+	
+	return count;
+}
 
-	return len;
+int get_chrdev_info(void *dev, int *major, char **name)
+{
+	struct chrdev_info *info = dev;
+	
+	if (info->cd == NULL)
+		return 1;
+	
+	*major = info->cd->major;
+	*name = info->cd->name;
+	return 0;
 }
 
 /*
@@ -121,7 +171,7 @@ __register_chrdev_region(unsigned int ma
 	cd->major = major;
 	cd->baseminor = baseminor;
 	cd->minorct = minorct;
-	cd->name = name;
+	strncpy(cd->name,name,64);
 
 	i = major_to_index(major);
 
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
