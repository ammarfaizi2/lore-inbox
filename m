Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVCHFUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVCHFUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVCHFUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:20:21 -0500
Received: from waste.org ([216.27.176.166]:31906 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261884AbVCHFS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:18:29 -0500
Date: Mon, 7 Mar 2005 21:18:18 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unified device list allocator
Message-ID: <20050308051818.GI3120@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This patch is against -mm1, which has different locking than mainline)

This patch introduces a simple allocator for tracking reservations of
block and character device ranges. After poking around, I came to the
conclusion that we can't avoid having a separate data structure for
reservations vs currently available devices so I tidied up the current
scheme. Note that everything below is about allocation/reservation of
namespace as opposed to lookup/open of existing devices and thus is
only invoked at init/exit and reading /proc/devices.

The new allocator is a simple linked list of dev_t range start and end
points. This lets us allocate regions of multiple majors (as is done
by SCSI) or just a portion of a major (as is done by several types of
character device). Dynamic allocation is handled by passing in a start
and end base address.

This unifies a lot of the code for registering block and character. It
also does away with the hash tables, which were complicating the code
and made allocating more devices than available hash table entries
difficult. As these tables are now only used at driver load, unload,
and for /proc/devices, and the number of entries is relatively
limited, the hash tables are no longer necessary.

If this is acceptable, the next steps are to add the helper functions
SCSI needs to allocate its spread of majors in > major chunks, add
fallback to the 1023-256 range for dynamic allocation of majors, add
change the proc bits to use seq_file. This will let us have dynamic
allocation of the entire address space of arbitrary numbers of
devices.

Tested on a laptop with a typical mix of static and dynamic block and
char devices, with identical allocations to the stock kernel. Save
about 3k in code and hash tables.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm1/drivers/block/genhd.c
===================================================================
--- mm1.orig/drivers/block/genhd.c	2005-03-01 16:09:21.000000000 -0800
+++ mm1/drivers/block/genhd.c	2005-03-01 16:10:32.000000000 -0800
@@ -14,100 +14,46 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/kobj_map.h>
-
-#define MAX_PROBE_HASH 255	/* random */
+#include <linux/list.h>
+#include <linux/devlist.h>
 
 static struct subsystem block_subsys;
-
 static DECLARE_MUTEX(block_subsys_sem);
-
-/*
- * Can be deleted altogether. Later.
- *
- */
-static struct blk_major_name {
-	struct blk_major_name *next;
-	int major;
-	char name[16];
-} *major_names[MAX_PROBE_HASH];
-
-/* index in the above - for now: assume no multimajor ranges */
-static inline int major_to_index(int major)
-{
-	return major % MAX_PROBE_HASH;
-}
+static LIST_HEAD(blkdev_names);
 
 #ifdef CONFIG_PROC_FS
-/* get block device names in somewhat random order */
 int get_blkdev_list(char *p)
 {
-	struct blk_major_name *n;
-	int i, len;
+	int len;
 
 	len = sprintf(p, "\nBlock devices:\n");
 
 	down(&block_subsys_sem);
-	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
-		for (n = major_names[i]; n; n = n->next)
-			len += sprintf(p+len, "%3d %s\n",
-				       n->major, n->name);
-	}
+	len += get_dev_list(p, &blkdev_names);
 	up(&block_subsys_sem);
-
 	return len;
 }
 #endif
 
 int register_blkdev(unsigned int major, const char *name)
 {
-	struct blk_major_name **n, *p;
-	int index, ret = 0;
+	dev_t r;
+	int ret;
 
 	down(&block_subsys_sem);
 
-	/* temporary */
-	if (major == 0) {
-		for (index = ARRAY_SIZE(major_names)-1; index > 0; index--) {
-			if (major_names[index] == NULL)
-				break;
-		}
-
-		if (index == 0) {
-			printk("register_blkdev: failed to get major for %s\n",
-			       name);
-			ret = -EBUSY;
-			goto out;
-		}
-		major = index;
-		ret = major;
-	}
-
-	p = kmalloc(sizeof(struct blk_major_name), GFP_KERNEL);
-	if (p == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	p->major = major;
-	strlcpy(p->name, name, sizeof(p->name));
-	p->next = NULL;
-	index = major_to_index(major);
-
-	for (n = &major_names[index]; *n; n = &(*n)->next) {
-		if ((*n)->major == major)
-			break;
-	}
-	if (!*n)
-		*n = p;
-	else
-		ret = -EBUSY;
+	if (!major) {
+		ret = register_dev(MKDEV(1, 0), MKDEV(254, 0),
+				   MKDEV(1, 0), name, &blkdev_names, &r);
+		ret = ret ? ret : MAJOR(r);
+	} else
+		ret = register_dev(MKDEV(major, 0), MKDEV(major, 0),
+				   MKDEV(1, 0), name, &blkdev_names, NULL);
 
-	if (ret < 0) {
+	if (ret == -EBUSY)
 		printk("register_blkdev: cannot get major %d for %s\n",
 		       major, name);
-		kfree(p);
-	}
-out:
+
 	up(&block_subsys_sem);
 	return ret;
 }
@@ -117,24 +63,11 @@ EXPORT_SYMBOL(register_blkdev);
 /* todo: make void - error printk here */
 int unregister_blkdev(unsigned int major, const char *name)
 {
-	struct blk_major_name **n;
-	struct blk_major_name *p = NULL;
-	int index = major_to_index(major);
-	int ret = 0;
+	int ret;
 
 	down(&block_subsys_sem);
-	for (n = &major_names[index]; *n; n = &(*n)->next)
-		if ((*n)->major == major)
-			break;
-	if (!*n || strcmp((*n)->name, name))
-		ret = -EINVAL;
-	else {
-		p = *n;
-		*n = p->next;
-	}
+	ret = unregister_dev(MKDEV(major, 0), &blkdev_names);
 	up(&block_subsys_sem);
-	kfree(p);
-
 	return ret;
 }
 
Index: mm1/fs/devlist.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mm1/fs/devlist.c	2005-03-01 16:46:34.000000000 -0800
@@ -0,0 +1,115 @@
+/*
+ * A simple device node space allocator for the Linux kernel
+ *
+ * This uses a simple linked list of dev_t ranges for reserving device
+ * areas. The io resource tree scheme would almost work here except we
+ * have backwards compatibility requirements for dynamically allocated
+ * ranges from the top of the legacy device space downwards.
+ *
+ * Feb 27 2005  Matt Mackall <mpm@selenic.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/kdev_t.h>
+#include <linux/errno.h>
+
+struct device_name {
+	struct list_head list;
+	dev_t begin, end;
+	char name[16];
+};
+
+/*
+ * register_dev - reserve a range of devices for a given device name
+ * @a: first allowed base address
+ * @b: last allowed base address
+ * @size: size of minor devices device range to reserve
+ * @name: name to associate with the range
+ * @list: device name list to add to
+ * @r: allocated base address
+ *
+ * This function reserves a range of %size minor devices starting
+ * somewhere between a and b of the given size. To allocate at a fixed
+ * base address, use a = b. For dynamic allocation in a range,
+ * allocation occurs from the top down for backward compatibility.
+ * There are no restrictions on the size of the range allocated, so
+ * multiple contiguous majors can be allocated with a single call.
+ *
+ * This function returns 0 on success, -EBUSY if the requested range
+ * could not be allocated, and -ENOMEM if the device name node could
+ * not be allocated.
+ */
+
+int register_dev(dev_t a, dev_t b, int size, const char * name,
+		 struct list_head *list, dev_t *r)
+{
+	struct device_name *d;
+	struct list_head *l;
+
+	/* search for insertion point in reverse for dynamic allocation */
+	list_for_each_prev(l, list) {
+		d = list_entry(l, struct device_name, list);
+		/* have we found an insertion point? */
+		if (b >= d->end)
+			break;
+		/* does the current entry force us to shrink the range? */
+		if (b + size > d->begin)
+			b = d->begin - size;
+		/* have we searched outside of or collapsed the range? */
+		if (a > d->begin || a > b)
+			return -EBUSY;
+	}
+
+	d = kmalloc(sizeof(struct device_name), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	strlcpy(d->name, name, sizeof(d->name));
+	d->begin = b;
+	d->end = b + size;
+	list_add(&d->list, l);
+
+	if (r)
+		*r = b;
+
+	return 0;
+}
+
+/*
+ * unregister_dev - drop a device reservation range
+ * @begin: beginning of allocated range
+ * @l: device name list
+ *
+ * This function removes the range starting with begin from the given
+ * list and returns 0, or returns -EINVAL if the range is not found.
+ */
+
+int unregister_dev(dev_t begin, struct list_head *l)
+{
+	struct device_name *n;
+
+	list_for_each_entry(n, l, list)
+		if (n->begin == begin) {
+			list_del(&n->list);
+			kfree(n);
+			return 0;
+		}
+
+	return -EINVAL;
+}
+
+#ifdef CONFIG_PROC_FS
+int get_dev_list(char *p, struct list_head *l)
+{
+	struct device_name *n;
+	int len = 0, m;
+
+	list_for_each_entry(n, l, list)
+		for (m = MAJOR(n->begin); m <= MAJOR(n->end); m++)
+			len += sprintf(p + len, "%3d %s\n", m, n->name);
+
+	return len;
+}
+#endif
Index: mm1/include/linux/devlist.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mm1/include/linux/devlist.h	2005-03-01 16:10:32.000000000 -0800
@@ -0,0 +1,11 @@
+#ifndef _LINUX_DEVLIST_H
+#define _LINUX_DEVLIST_H
+
+int register_dev(dev_t a, dev_t b, int size, const char * name,
+		 struct list_head *list, dev_t *r);
+
+int unregister_dev(dev_t begin, struct list_head *l);
+
+int get_dev_list(char *p, struct list_head *l);
+
+#endif
Index: mm1/fs/Makefile
===================================================================
--- mm1.orig/fs/Makefile	2005-03-01 16:09:29.000000000 -0800
+++ mm1/fs/Makefile	2005-03-01 16:10:32.000000000 -0800
@@ -10,6 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
+		devlist.o
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
Index: mm1/fs/char_dev.c
===================================================================
--- mm1.orig/fs/char_dev.c	2005-03-01 16:09:27.000000000 -0800
+++ mm1/fs/char_dev.c	2005-03-01 16:10:32.000000000 -0800
@@ -19,233 +19,114 @@
 #include <linux/kobject.h>
 #include <linux/kobj_map.h>
 #include <linux/cdev.h>
+#include <linux/list.h>
+#include <linux/devlist.h>
 
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
 
 static struct kobj_map *cdev_map;
-
-/* degrade to linked list for small systems */
-#define MAX_PROBE_HASH (CONFIG_BASE_SMALL ? 1 : 255)
-
 static DECLARE_MUTEX(chrdevs_lock);
+static LIST_HEAD(chrdev_names);
 
-static struct char_device_struct {
-	struct char_device_struct *next;
-	unsigned int major;
-	unsigned int baseminor;
-	int minorct;
-	const char *name;
-	struct file_operations *fops;
-	struct cdev *cdev;		/* will die */
-} *chrdevs[MAX_PROBE_HASH];
-
-/* index in the above */
-static inline int major_to_index(int major)
-{
-	return major % MAX_PROBE_HASH;
-}
-
-/* get char device names in somewhat random order */
+#ifdef CONFIG_PROC_FS
 int get_chrdev_list(char *page)
 {
-	struct char_device_struct *cd;
-	int i, len;
+	int len;
 
 	len = sprintf(page, "Character devices:\n");
 
 	down(&chrdevs_lock);
-	for (i = 0; i < ARRAY_SIZE(chrdevs) ; i++) {
-		for (cd = chrdevs[i]; cd; cd = cd->next)
-			len += sprintf(page+len, "%3d %s\n",
-				       cd->major, cd->name);
-	}
+	len += get_dev_list(page, &chrdev_names);
 	up(&chrdevs_lock);
-
 	return len;
 }
+#endif
 
-/*
- * Register a single major with a specified minor range.
- *
- * If major == 0 this functions will dynamically allocate a major and return
- * its number.
- *
- * If major > 0 this function will attempt to reserve the passed range of
- * minors and will return zero on success.
- *
- * Returns a -ve errno on failure.
- */
-static struct char_device_struct *
-__register_chrdev_region(unsigned int major, unsigned int baseminor,
-			   int minorct, const char *name)
+int register_chrdev_region(dev_t from, unsigned count, const char *name)
 {
-	struct char_device_struct *cd, **cp;
-	int ret = 0;
-	int i;
-
-	cd = kmalloc(sizeof(struct char_device_struct), GFP_KERNEL);
-	if (cd == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	memset(cd, 0, sizeof(struct char_device_struct));
+	int ret;
 
 	down(&chrdevs_lock);
-
-	/* temporary */
-	if (major == 0) {
-		for (i = ARRAY_SIZE(chrdevs)-1; i > 0; i--) {
-			if (chrdevs[i] == NULL)
-				break;
-		}
-
-		if (i == 0) {
-			ret = -EBUSY;
-			goto out;
-		}
-		major = i;
-		ret = major;
-	}
-
-	cd->major = major;
-	cd->baseminor = baseminor;
-	cd->minorct = minorct;
-	cd->name = name;
-
-	i = major_to_index(major);
-
-	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
-		if ((*cp)->major > major ||
-		    ((*cp)->major == major && (*cp)->baseminor >= baseminor))
-			break;
-	if (*cp && (*cp)->major == major &&
-	    (*cp)->baseminor < baseminor + minorct) {
-		ret = -EBUSY;
-		goto out;
-	}
-	cd->next = *cp;
-	*cp = cd;
-	up(&chrdevs_lock);
-	return cd;
-out:
-	up(&chrdevs_lock);
-	kfree(cd);
-	return ERR_PTR(ret);
-}
-
-static struct char_device_struct *
-__unregister_chrdev_region(unsigned major, unsigned baseminor, int minorct)
-{
-	struct char_device_struct *cd = NULL, **cp;
-	int i = major_to_index(major);
-
+	ret = register_dev(from, from, count, name, &chrdev_names, NULL);
 	up(&chrdevs_lock);
-	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
-		if ((*cp)->major == major &&
-		    (*cp)->baseminor == baseminor &&
-		    (*cp)->minorct == minorct)
-			break;
-	if (*cp) {
-		cd = *cp;
-		*cp = cd->next;
-	}
-	up(&chrdevs_lock);
-	return cd;
-}
 
-int register_chrdev_region(dev_t from, unsigned count, const char *name)
-{
-	struct char_device_struct *cd;
-	dev_t to = from + count;
-	dev_t n, next;
-
-	for (n = from; n < to; n = next) {
-		next = MKDEV(MAJOR(n)+1, 0);
-		if (next > to)
-			next = to;
-		cd = __register_chrdev_region(MAJOR(n), MINOR(n),
-			       next - n, name);
-		if (IS_ERR(cd))
-			goto fail;
-	}
-	return 0;
-fail:
-	to = n;
-	for (n = from; n < to; n = next) {
-		next = MKDEV(MAJOR(n)+1, 0);
-		kfree(__unregister_chrdev_region(MAJOR(n), MINOR(n), next - n));
-	}
-	return PTR_ERR(cd);
+	return ret;
 }
 
 int alloc_chrdev_region(dev_t *dev, unsigned baseminor, unsigned count,
 			const char *name)
 {
-	struct char_device_struct *cd;
-	cd = __register_chrdev_region(0, baseminor, count, name);
-	if (IS_ERR(cd))
-		return PTR_ERR(cd);
-	*dev = MKDEV(cd->major, cd->baseminor);
-	return 0;
+	int ret;
+
+	down(&chrdevs_lock);
+	ret = register_dev(MKDEV(1, 0), MKDEV(254, 0),
+			    MKDEV(1, 0), name, &chrdev_names, dev);
+	up(&chrdevs_lock);
+
+	return ret;
 }
 
 int register_chrdev(unsigned int major, const char *name,
 		    struct file_operations *fops)
 {
-	struct char_device_struct *cd;
+	dev_t r;
+	int ret = 0, err;
 	struct cdev *cdev;
 	char *s;
-	int err = -ENOMEM;
 
-	cd = __register_chrdev_region(major, 0, 256, name);
-	if (IS_ERR(cd))
-		return PTR_ERR(cd);
-	
+	down(&chrdevs_lock);
+	if (!major) {
+		err = register_dev(MKDEV(1, 0), MKDEV(254, 0),
+				   MKDEV(1, 0), name, &chrdev_names, &r);
+		ret = MAJOR(r);
+	} else
+		err = register_dev(MKDEV(major, 0), MKDEV(major, 0),
+				   MKDEV(1, 0), name, &chrdev_names, &r);
+	up(&chrdevs_lock);
+
+	if (err)
+		return err;
+
 	cdev = cdev_alloc();
 	if (!cdev)
-		goto out2;
+		goto unreg;
 
 	cdev->owner = fops->owner;
 	cdev->ops = fops;
 	kobject_set_name(&cdev->kobj, "%s", name);
 	for (s = strchr(kobject_name(&cdev->kobj),'/'); s; s = strchr(s, '/'))
 		*s = '!';
-		
-	err = cdev_add(cdev, MKDEV(cd->major, 0), 256);
-	if (err)
-		goto out;
 
-	cd->cdev = cdev;
+	err = cdev_add(cdev, r, 256);
+	if (!err)
+		return ret;
 
-	return major ? 0 : cd->major;
-out:
 	kobject_put(&cdev->kobj);
-out2:
-	kfree(__unregister_chrdev_region(cd->major, 0, 256));
+unreg:
+	unregister_dev(r, &chrdev_names);
 	return err;
 }
 
 void unregister_chrdev_region(dev_t from, unsigned count)
 {
-	dev_t to = from + count;
-	dev_t n, next;
-
-	for (n = from; n < to; n = next) {
-		next = MKDEV(MAJOR(n)+1, 0);
-		if (next > to)
-			next = to;
-		kfree(__unregister_chrdev_region(MAJOR(n), MINOR(n), next - n));
-	}
+	unregister_dev(from, &chrdev_names);
 }
 
 int unregister_chrdev(unsigned int major, const char *name)
 {
-	struct char_device_struct *cd;
-	cd = __unregister_chrdev_region(major, 0, 256);
-	if (cd && cd->cdev)
-		cdev_del(cd->cdev);
-	kfree(cd);
+	struct kobject *kobj;
+	int idx;
+
+	down(&chrdevs_lock);
+	unregister_dev(MKDEV(major, 0), &chrdev_names);
+	up(&chrdevs_lock);
+
+	kobj = kobj_lookup(cdev_map, MKDEV(major, 0), &idx);
+	if (kobj)
+		cdev_del(container_of(kobj, struct cdev, kobj));
+
 	return 0;
 }
 

-- 
Mathematics is the supreme nostalgia of our time.
