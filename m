Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWJVUHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWJVUHx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWJVUHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:07:53 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:19148 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751340AbWJVUHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:07:51 -0400
To: akpm@osdl.org
Cc: balagi@justmail.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.19-rc2-mm2 pktcdvd: add sysfs and debugfs interface
References: <op.tht1yvsaiudtyh@master> <m3vemcdz79.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 22 Oct 2006 22:07:37 +0200
In-Reply-To: <m3vemcdz79.fsf@telia.com>
Message-ID: <m3fydgdshi.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> "Thomas Maier" <balagi@justmail.de> writes:
> 
> > this patch adds a sysfs and debugfs interface
> > to the pktcdvd driver.
> > The procfs interface is not modified!
> 
> Calling the character device interface "procfs interface" is
> misleading, so I disagree with this part of the patch:
> 
> +  Note: pktsetup uses the pktcdvd procfs interface!

Other than that, and some trailing whitespace, the patch looks good.
Thanks a lot. Andrew, please apply:


This patch adds a sysfs and debugfs interface to the pktcdvd driver.

Look into the Documentation/ABI/testing/* files in the patch for more
info.

Signed-off-by: Thomas Maier <balagi@justmail.de>
Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 Documentation/ABI/testing/debugfs-pktcdvd     |   20 +
 Documentation/ABI/testing/sysfs-class-pktcdvd |   72 ++++
 Documentation/cdrom/packet-writing.txt        |   35 ++
 drivers/block/pktcdvd.c                       |  443 +++++++++++++++++++++++++
 include/linux/pktcdvd.h                       |   18 +
 5 files changed, 583 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-pktcdvd b/Documentation/ABI/testing/debugfs-pktcdvd
new file mode 100644
index 0000000..03dbd88
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-pktcdvd
@@ -0,0 +1,20 @@
+What:           /debug/pktcdvd/pktcdvd[0-7]
+Date:           Oct. 2006
+KernelVersion:  2.6.19
+Contact:        Thomas Maier <balagi@justmail.de>
+Description:
+
+debugfs interface
+-----------------
+
+The pktcdvd module (packet writing driver) creates
+these files in debugfs:
+
+/debug/pktcdvd/pktcdvd[0-7]/
+    info            (0444) Lots of human readable driver
+                           statistics and infos. Multiple lines!
+
+Example:
+-------
+
+cat /debug/pktcdvd/pktcdvd0/info
diff --git a/Documentation/ABI/testing/sysfs-class-pktcdvd b/Documentation/ABI/testing/sysfs-class-pktcdvd
new file mode 100644
index 0000000..c4c55ed
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-pktcdvd
@@ -0,0 +1,72 @@
+What:           /sys/class/pktcdvd/
+Date:           Oct. 2006
+KernelVersion:  2.6.19
+Contact:        Thomas Maier <balagi@justmail.de>
+Description:
+
+sysfs interface
+---------------
+
+The pktcdvd module (packet writing driver) creates
+these files in the sysfs:
+(<devid> is in format  major:minor )
+
+/sys/class/pktcdvd/
+    add            (0200)  Write a block device id (major:minor)
+                           to create a new pktcdvd device and map
+                           it to the block device.
+
+    remove         (0200)  Write the pktcdvd device id (major:minor)
+                           to it to remove the pktcdvd device.
+
+    device_map     (0444)  Shows the device mapping in format:
+                             pktcdvd[0-7] <pktdevid> <blkdevid>
+
+/sys/class/pktcdvd/pktcdvd[0-7]/
+    dev                   (0444) Device id
+    uevent                (0200) To send an uevent.
+
+/sys/class/pktcdvd/pktcdvd[0-7]/stat/
+    packets_started       (0444) Number of started packets.
+    packets_finished      (0444) Number of finished packets.
+
+    kb_written            (0444) kBytes written.
+    kb_read               (0444) kBytes read.
+    kb_read_gather        (0444) kBytes read to fill write packets.
+
+    reset                 (0200) Write any value to it to reset
+                                 pktcdvd device statistic values, like
+                                 bytes read/written.
+
+/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/
+    size                  (0444) Contains the size of the bio write
+                                 queue.
+
+    congestion_off        (0644) If bio write queue size is below
+                                 this mark, accept new bio requests
+                                 from the block layer.
+
+    congestion_on         (0644) If bio write queue size is higher
+                                 as this mark, do no longer accept
+                                 bio write requests from the block
+                                 layer and wait till the pktcdvd
+                                 device has processed enough bio's
+                                 so that bio write queue size is
+                                 below congestion off mark.
+                                 A value of <= 0 disables congestion
+                                 control.
+
+
+Example:
+--------
+To use the pktcdvd sysfs interface directly, you can do:
+
+# create a new pktcdvd device mapped to /dev/hdc
+echo "22:0" >/sys/class/pktcdvd/add
+cat /sys/class/pktcdvd/device_map
+# assuming device pktcdvd0 was created, look at stat's
+cat /sys/class/pktcdvd/pktcdvd0/stat/kb_written
+# print the device id of the mapped block device
+fgrep pktcdvd0 /sys/class/pktcdvd/device_map
+# remove device, using pktcdvd0 device id   253:0
+echo "253:0" >/sys/class/pktcdvd/remove
diff --git a/Documentation/cdrom/packet-writing.txt b/Documentation/cdrom/packet-writing.txt
index 3d44c56..7715d22 100644
--- a/Documentation/cdrom/packet-writing.txt
+++ b/Documentation/cdrom/packet-writing.txt
@@ -90,6 +90,41 @@ Notes
   to create an ext2 filesystem on the disc.
 
 
+Using the pktcdvd sysfs interface
+---------------------------------
+
+Since Linux 2.6.19, the pktcdvd module has a sysfs interface
+and can be controlled by it. For example the "pktcdvd" tool uses
+this interface. (see http://people.freenet.de/BalaGi#pktcdvd )
+
+"pktcdvd" works similar to "pktsetup", e.g.:
+
+	# pktcdvd -a dev_name /dev/hdc
+	# mkudffs /dev/pktcdvd/dev_name
+	# mount -t udf -o rw,noatime /dev/pktcdvd/dev_name /dvdram
+	# cp files /dvdram
+	# umount /dvdram
+	# pktcdvd -r dev_name
+
+
+For a description of the sysfs interface look into the file:
+
+  Documentation/ABI/testing/sysfs-block-pktcdvd
+
+
+Using the pktcdvd debugfs interface
+-----------------------------------
+
+To read pktcdvd device infos in human readable form, do:
+
+	# cat /debug/pktcdvd/pktcdvd[0-7]/info
+
+For a description of the debugfs interface look into the file:
+
+  Documentation/ABI/testing/debugfs-pktcdvd
+
+
+
 Links
 -----
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index b1bb25c..090e146 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -60,6 +60,8 @@ #include <linux/mutex.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_ioctl.h>
 #include <scsi/scsi.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 
@@ -89,6 +91,419 @@ static int write_congestion_off = PKT_WR
 static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
 static mempool_t *psd_pool;
 
+static struct class	*class_pktcdvd = NULL;    /* /sys/class/pktcdvd */
+static struct dentry	*pkt_debugfs_root = NULL; /* /debug/pktcdvd */
+
+/* forward declaration */
+static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
+static int pkt_remove_dev(dev_t pkt_dev);
+static int pkt_seq_show(struct seq_file *m, void *p);
+
+
+
+/*
+ * create and register a pktcdvd kernel object.
+ */
+static struct pktcdvd_kobj* pkt_kobj_create(struct pktcdvd_device *pd,
+					const char* name,
+					struct kobject* parent,
+					struct kobj_type* ktype)
+{
+	struct pktcdvd_kobj *p;
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return NULL;
+	kobject_set_name(&p->kobj, "%s", name);
+	p->kobj.parent = parent;
+	p->kobj.ktype = ktype;
+	p->pd = pd;
+	if (kobject_register(&p->kobj) != 0)
+		return NULL;
+	return p;
+}
+/*
+ * remove a pktcdvd kernel object.
+ */
+static void pkt_kobj_remove(struct pktcdvd_kobj *p)
+{
+	if (p)
+		kobject_unregister(&p->kobj);
+}
+/*
+ * default release function for pktcdvd kernel objects.
+ */
+static void pkt_kobj_release(struct kobject *kobj)
+{
+	kfree(to_pktcdvdkobj(kobj));
+}
+
+
+/**********************************************************
+ *
+ * sysfs interface for pktcdvd
+ * by (C) 2006  Thomas Maier <balagi@justmail.de>
+ *
+ **********************************************************/
+
+#define DEF_ATTR(_obj,_name,_mode) \
+	static struct attribute _obj = { \
+		.name = _name, .owner = THIS_MODULE, .mode = _mode }
+
+/**********************************************************
+  /sys/class/pktcdvd/pktcdvd[0-7]/
+                     stat/reset
+                     stat/packets_started
+                     stat/packets_finished
+                     stat/kb_written
+                     stat/kb_read
+                     stat/kb_read_gather
+                     write_queue/size
+                     write_queue/congestion_off
+                     write_queue/congestion_on
+ **********************************************************/
+
+DEF_ATTR(kobj_pkt_attr_st1, "reset", 0200);
+DEF_ATTR(kobj_pkt_attr_st2, "packets_started", 0444);
+DEF_ATTR(kobj_pkt_attr_st3, "packets_finished", 0444);
+DEF_ATTR(kobj_pkt_attr_st4, "kb_written", 0444);
+DEF_ATTR(kobj_pkt_attr_st5, "kb_read", 0444);
+DEF_ATTR(kobj_pkt_attr_st6, "kb_read_gather", 0444);
+
+static struct attribute *kobj_pkt_attrs_stat[] = {
+	&kobj_pkt_attr_st1,
+	&kobj_pkt_attr_st2,
+	&kobj_pkt_attr_st3,
+	&kobj_pkt_attr_st4,
+	&kobj_pkt_attr_st5,
+	&kobj_pkt_attr_st6,
+	NULL
+};
+
+DEF_ATTR(kobj_pkt_attr_wq1, "size", 0444);
+DEF_ATTR(kobj_pkt_attr_wq2, "congestion_off", 0644);
+DEF_ATTR(kobj_pkt_attr_wq3, "congestion_on",  0644);
+
+static struct attribute *kobj_pkt_attrs_wqueue[] = {
+	&kobj_pkt_attr_wq1,
+	&kobj_pkt_attr_wq2,
+	&kobj_pkt_attr_wq3,
+	NULL
+};
+
+/* declares a char buffer[64] _dbuf, copies data from
+ * _b with length _l into it and ensures that _dbuf ends
+ * with a \0 character.
+ */
+#define DECLARE_BUF_AS_STRING(_dbuf, _b, _l) \
+	char _dbuf[64]; int dlen = (_l) < 0 ? 0 : (_l); \
+	if (dlen >= sizeof(_dbuf)) dlen = sizeof(_dbuf)-1; \
+	memcpy(_dbuf, _b, dlen); _dbuf[dlen] = 0
+
+static ssize_t kobj_pkt_show(struct kobject *kobj,
+			struct attribute *attr, char *data)
+{
+	struct pktcdvd_device *pd = to_pktcdvdkobj(kobj)->pd;
+	int n = 0;
+	int v;
+	if (strcmp(attr->name, "packets_started") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.pkt_started);
+
+	} else if (strcmp(attr->name, "packets_finished") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.pkt_ended);
+
+	} else if (strcmp(attr->name, "kb_written") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.secs_w >> 1);
+
+	} else if (strcmp(attr->name, "kb_read") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.secs_r >> 1);
+
+	} else if (strcmp(attr->name, "kb_read_gather") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.secs_rg >> 1);
+
+	} else if (strcmp(attr->name, "size") == 0) {
+		spin_lock(&pd->lock);
+		v = pd->bio_queue_size;
+		spin_unlock(&pd->lock);
+		n = sprintf(data, "%d\n", v);
+
+	} else if (strcmp(attr->name, "congestion_off") == 0) {
+		spin_lock(&pd->lock);
+		v = pd->write_congestion_off;
+		spin_unlock(&pd->lock);
+		n = sprintf(data, "%d\n", v);
+
+	} else if (strcmp(attr->name, "congestion_on") == 0) {
+		spin_lock(&pd->lock);
+		v = pd->write_congestion_on;
+		spin_unlock(&pd->lock);
+		n = sprintf(data, "%d\n", v);
+	}
+	return n;
+}
+
+static void init_write_congestion_marks(int* lo, int* hi)
+{
+	if (*hi > 0) {
+		*hi = max(*hi, 500);
+		*hi = min(*hi, 1000000);
+		if (*lo <= 0)
+			*lo = *hi - 100;
+		else {
+			*lo = min(*lo, *hi - 100);
+			*lo = max(*lo, 100);
+		}
+	} else {
+		*hi = -1;
+		*lo = -1;
+	}
+}
+
+static ssize_t kobj_pkt_store(struct kobject *kobj,
+			struct attribute *attr,
+			const char *data, size_t len)
+{
+	struct pktcdvd_device *pd = to_pktcdvdkobj(kobj)->pd;
+	int val;
+	DECLARE_BUF_AS_STRING(dbuf, data, len); /* ensure sscanf scans a string */
+
+	if (strcmp(attr->name, "reset") == 0 && dlen > 0) {
+		pd->stats.pkt_started = 0;
+		pd->stats.pkt_ended = 0;
+		pd->stats.secs_w = 0;
+		pd->stats.secs_rg = 0;
+		pd->stats.secs_r = 0;
+
+	} else if (strcmp(attr->name, "congestion_off") == 0
+		   && sscanf(dbuf, "%d", &val) == 1) {
+		spin_lock(&pd->lock);
+		pd->write_congestion_off = val;
+		init_write_congestion_marks(&pd->write_congestion_off,
+					&pd->write_congestion_on);
+		spin_unlock(&pd->lock);
+
+	} else if (strcmp(attr->name, "congestion_on") == 0
+		   && sscanf(dbuf, "%d", &val) == 1) {
+		spin_lock(&pd->lock);
+		pd->write_congestion_on = val;
+		init_write_congestion_marks(&pd->write_congestion_off,
+					&pd->write_congestion_on);
+		spin_unlock(&pd->lock);
+	}
+	return len;
+}
+
+static struct sysfs_ops kobj_pkt_ops = {
+	.show = kobj_pkt_show,
+	.store = kobj_pkt_store
+};
+static struct kobj_type kobj_pkt_type_stat = {
+	.release = pkt_kobj_release,
+	.sysfs_ops = &kobj_pkt_ops,
+	.default_attrs = kobj_pkt_attrs_stat
+};
+static struct kobj_type kobj_pkt_type_wqueue = {
+	.release = pkt_kobj_release,
+	.sysfs_ops = &kobj_pkt_ops,
+	.default_attrs = kobj_pkt_attrs_wqueue
+};
+
+static void pkt_sysfs_dev_new(struct pktcdvd_device *pd)
+{
+	if (class_pktcdvd) {
+		pd->clsdev = class_device_create(class_pktcdvd,
+					NULL, pd->pkt_dev,
+					NULL, "%s", pd->name);
+		if (IS_ERR(pd->clsdev))
+			pd->clsdev = NULL;
+	}
+	if (pd->clsdev) {
+		pd->kobj_stat = pkt_kobj_create(pd, "stat",
+					&pd->clsdev->kobj,
+					&kobj_pkt_type_stat);
+		pd->kobj_wqueue = pkt_kobj_create(pd, "write_queue",
+					&pd->clsdev->kobj,
+					&kobj_pkt_type_wqueue);
+	}
+}
+
+static void pkt_sysfs_dev_remove(struct pktcdvd_device *pd)
+{
+	pkt_kobj_remove(pd->kobj_stat);
+	pkt_kobj_remove(pd->kobj_wqueue);
+	if (class_pktcdvd)
+		class_device_destroy(class_pktcdvd, pd->pkt_dev);
+}
+
+
+/********************************************************************
+  /sys/class/pktcdvd/
+                     add            map block device
+                     remove         unmap packet dev
+                     device_map     show mappings
+ *******************************************************************/
+
+static void class_pktcdvd_release(struct class *cls)
+{
+	kfree(cls);
+}
+static ssize_t class_pktcdvd_show_map(struct class *c, char *data)
+{
+	int n = 0;
+	int idx;
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	for (idx = 0; idx < MAX_WRITERS; idx++) {
+		struct pktcdvd_device *pd = pkt_devs[idx];
+		if (!pd)
+			continue;
+		n += sprintf(data+n, "%s %u:%u %u:%u\n",
+			pd->name,
+			MAJOR(pd->pkt_dev), MINOR(pd->pkt_dev),
+			MAJOR(pd->bdev->bd_dev),
+			MINOR(pd->bdev->bd_dev));
+	}
+	mutex_unlock(&ctl_mutex);
+	return n;
+}
+
+static ssize_t class_pktcdvd_store_add(struct class *c, const char *buf,
+					size_t count)
+{
+	unsigned int major, minor;
+	DECLARE_BUF_AS_STRING(dbuf, buf, count);
+	if (sscanf(dbuf, "%u:%u", &major, &minor) == 2) {
+		pkt_setup_dev(MKDEV(major, minor), NULL);
+		return count;
+	}
+	return -EINVAL;
+}
+
+static ssize_t class_pktcdvd_store_remove(struct class *c, const char *buf,
+					size_t count)
+{
+	unsigned int major, minor;
+	DECLARE_BUF_AS_STRING(dbuf, buf, count);
+	if (sscanf(dbuf, "%u:%u", &major, &minor) == 2) {
+		pkt_remove_dev(MKDEV(major, minor));
+		return count;
+	}
+	return -EINVAL;
+}
+
+static struct class_attribute class_pktcdvd_attrs[] = {
+ __ATTR(add,            0200, NULL, class_pktcdvd_store_add),
+ __ATTR(remove,         0200, NULL, class_pktcdvd_store_remove),
+ __ATTR(device_map,     0444, class_pktcdvd_show_map, NULL),
+ __ATTR_NULL
+};
+
+
+static int pkt_sysfs_init(void)
+{
+	int ret = 0;
+
+	/*
+	 * create control files in sysfs
+	 * /sys/class/pktcdvd/...
+	 */
+	class_pktcdvd = kzalloc(sizeof(*class_pktcdvd), GFP_KERNEL);
+	if (!class_pktcdvd)
+		return -ENOMEM;
+	class_pktcdvd->name = DRIVER_NAME;
+	class_pktcdvd->owner = THIS_MODULE;
+	class_pktcdvd->class_release = class_pktcdvd_release;
+	class_pktcdvd->class_attrs = class_pktcdvd_attrs;
+	ret = class_register(class_pktcdvd);
+	if (ret) {
+		kfree(class_pktcdvd);
+		class_pktcdvd = NULL;
+		printk(DRIVER_NAME": failed to create class pktcdvd\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void pkt_sysfs_cleanup(void)
+{
+	if (class_pktcdvd)
+		class_destroy(class_pktcdvd);
+	class_pktcdvd = NULL;
+}
+
+/********************************************************************
+  entries in debugfs
+
+  /debugfs/pktcdvd[0-7]/
+			info
+
+ *******************************************************************/
+
+static int pkt_debugfs_seq_show(struct seq_file *m, void *p)
+{
+	return pkt_seq_show(m, p);
+}
+
+static int pkt_debugfs_fops_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pkt_debugfs_seq_show, inode->i_private);
+}
+
+static struct file_operations debug_fops = {
+	.open		= pkt_debugfs_fops_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.owner		= THIS_MODULE,
+};
+
+static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
+{
+	if (!pkt_debugfs_root)
+		return;
+	pd->dfs_f_info = NULL;
+	pd->dfs_d_root = debugfs_create_dir(pd->name, pkt_debugfs_root);
+	if (IS_ERR(pd->dfs_d_root)) {
+		pd->dfs_d_root = NULL;
+		return;
+	}
+	pd->dfs_f_info = debugfs_create_file("info", S_IRUGO,
+				pd->dfs_d_root, pd, &debug_fops);
+	if (IS_ERR(pd->dfs_f_info)) {
+		pd->dfs_f_info = NULL;
+		return;
+	}
+}
+
+static void pkt_debugfs_dev_remove(struct pktcdvd_device *pd)
+{
+	if (!pkt_debugfs_root)
+		return;
+	if (pd->dfs_f_info)
+		debugfs_remove(pd->dfs_f_info);
+	pd->dfs_f_info = NULL;
+	if (pd->dfs_d_root)
+		debugfs_remove(pd->dfs_d_root);
+	pd->dfs_d_root = NULL;
+}
+
+static void pkt_debugfs_init(void)
+{
+	pkt_debugfs_root = debugfs_create_dir(DRIVER_NAME, NULL);
+	if (IS_ERR(pkt_debugfs_root)) {
+		pkt_debugfs_root = NULL;
+		return;
+	}
+}
+
+static void pkt_debugfs_cleanup(void)
+{
+	if (!pkt_debugfs_root)
+		return;
+	debugfs_remove(pkt_debugfs_root);
+	pkt_debugfs_root = NULL;
+}
+
+/* ----------------------------------------------------------*/
+
 
 static void pkt_bio_finished(struct pktcdvd_device *pd)
 {
@@ -2527,6 +2942,9 @@ static int pkt_setup_dev(dev_t dev, dev_
 
 	add_disk(disk);
 
+	pkt_sysfs_dev_new(pd);
+	pkt_debugfs_dev_new(pd);
+
 	pkt_devs[idx] = pd;
 	if (pkt_dev)
 		*pkt_dev = pd->pkt_dev;
@@ -2577,6 +2995,11 @@ static int pkt_remove_dev(dev_t pkt_dev)
 	if (!IS_ERR(pd->cdrw.thread))
 		kthread_stop(pd->cdrw.thread);
 
+	pkt_devs[idx] = NULL;
+
+	pkt_debugfs_dev_remove(pd);
+	pkt_sysfs_dev_remove(pd);
+
 	blkdev_put(pd->bdev);
 
 	remove_proc_entry(pd->name, pkt_proc);
@@ -2586,7 +3009,6 @@ static int pkt_remove_dev(dev_t pkt_dev)
 	blk_cleanup_queue(pd->disk->queue);
 	put_disk(pd->disk);
 
-	pkt_devs[idx] = NULL;
 	mempool_destroy(pd->rb_pool);
 	kfree(pd);
 
@@ -2670,6 +3092,8 @@ static int __init pkt_init(void)
 {
 	int ret;
 
+	mutex_init(&ctl_mutex);
+
 	psd_pool = mempool_create_kmalloc_pool(PSD_POOL_SIZE,
 					sizeof(struct packet_stacked_data));
 	if (!psd_pool)
@@ -2683,18 +3107,25 @@ static int __init pkt_init(void)
 	if (!pktdev_major)
 		pktdev_major = ret;
 
+	ret = pkt_sysfs_init();
+	if (ret)
+		goto out;
+
+	pkt_debugfs_init();
+
 	ret = misc_register(&pkt_misc);
 	if (ret) {
 		printk(DRIVER_NAME": Unable to register misc device\n");
-		goto out;
+		goto out_misc;
 	}
 
-	mutex_init(&ctl_mutex);
-
 	pkt_proc = proc_mkdir(DRIVER_NAME, proc_root_driver);
 
 	return 0;
 
+out_misc:
+	pkt_debugfs_cleanup();
+	pkt_sysfs_cleanup();
 out:
 	unregister_blkdev(pktdev_major, DRIVER_NAME);
 out2:
@@ -2706,6 +3137,10 @@ static void __exit pkt_exit(void)
 {
 	remove_proc_entry(DRIVER_NAME, proc_root_driver);
 	misc_deregister(&pkt_misc);
+
+	pkt_debugfs_cleanup();
+	pkt_sysfs_cleanup();
+
 	unregister_blkdev(pktdev_major, DRIVER_NAME);
 	mempool_destroy(psd_pool);
 }
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 9b1a185..5ea4f05 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -111,7 +111,8 @@ #ifdef __KERNEL__
 #include <linux/blkdev.h>
 #include <linux/completion.h>
 #include <linux/cdrom.h>
-
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 
 /* default bio write queue congestion marks */
 #define PKT_WRITE_CONGESTION_ON    10000
@@ -247,6 +248,14 @@ struct packet_stacked_data
 };
 #define PSD_POOL_SIZE		64
 
+struct pktcdvd_kobj
+{
+	struct kobject		kobj;
+	struct pktcdvd_device	*pd;
+};
+#define to_pktcdvdkobj(_k) \
+  ((struct pktcdvd_kobj*)container_of(_k,struct pktcdvd_kobj,kobj))
+
 struct pktcdvd_device
 {
 	struct block_device	*bdev;		/* dev attached */
@@ -280,6 +289,13 @@ struct pktcdvd_device
 
 	int			write_congestion_off;
 	int			write_congestion_on;
+
+	struct class_device	*clsdev;	/* sysfs pktcdvd[0-7] class dev */
+	struct pktcdvd_kobj	*kobj_stat;	/* sysfs pktcdvd[0-7]/stat/     */
+	struct pktcdvd_kobj	*kobj_wqueue;	/* sysfs pktcdvd[0-7]/write_queue/ */
+
+	struct dentry		*dfs_d_root;	/* debugfs: devname directory */
+	struct dentry		*dfs_f_info;	/* debugfs: info file */
 };
 
 #endif /* __KERNEL__ */

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
