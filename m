Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267817AbTAKSVT>; Sat, 11 Jan 2003 13:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTAKSVT>; Sat, 11 Jan 2003 13:21:19 -0500
Received: from verein.lst.de ([212.34.181.86]:16914 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267817AbTAKSVG>;
	Sat, 11 Jan 2003 13:21:06 -0500
Date: Sat, 11 Jan 2003 19:29:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com, adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] umode_t changes from Adam's mini-devfs
Message-ID: <20030111192945.A25454@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	adam@yggdrasil.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The use of umode_t instead of devfs-specific char vs block #defines
in Adam's mini-devfs patch makes sense independant of whether his patch
should get merged.  While reviewing his changes I also notices that
most of the number allocation functionality in devfs has no business
beeing exported.  In addition I cleaned up devfs_alloc_devnum/
devfs_dealloc_devnum a bit.


--- 1.68/fs/devfs/base.c	Wed Jan  1 15:24:48 2003
+++ edited/fs/devfs/base.c	Sat Jan 11 16:47:27 2003
@@ -685,6 +685,8 @@
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
+#include "internal.h"
+
 #define DEVFS_VERSION            "1.22 (20021013)"
 
 #define DEVFS_NAME "devfs"
@@ -935,9 +937,9 @@
 	     de->parent ? de->parent->name : "no parent");
     if ( S_ISLNK (de->mode) ) kfree (de->u.symlink.linkname);
     if ( S_ISCHR (de->mode) && de->u.cdev.autogen )
-	devfs_dealloc_devnum (DEVFS_SPECIAL_CHR, de->u.cdev.dev);
+	devfs_dealloc_devnum (de->mode, de->u.cdev.dev);
     if ( S_ISBLK (de->mode) && de->u.bdev.autogen )
-	devfs_dealloc_devnum(DEVFS_SPECIAL_BLK, de->u.bdev.dev);
+	devfs_dealloc_devnum (de->mode, de->u.bdev.dev);
     WRITE_ENTRY_MAGIC (de, 0);
 #ifdef CONFIG_DEVFS_DEBUG
     spin_lock (&stat_lock);
@@ -1102,13 +1104,13 @@
     /*  And create the entry for ".devfsd"  */
     if ( ( new = _devfs_alloc_entry (".devfsd", 0, S_IFCHR |S_IRUSR |S_IWUSR) )
 	 == NULL ) return NULL;
-    new->u.cdev.dev = devfs_alloc_devnum (DEVFS_SPECIAL_CHR);
+    new->u.cdev.dev = devfs_alloc_devnum (S_IFCHR |S_IRUSR |S_IWUSR);
     new->u.cdev.ops = &devfsd_fops;
     _devfs_append_entry (root_entry, new, FALSE, NULL);
 #ifdef CONFIG_DEVFS_DEBUG
     if ( ( new = _devfs_alloc_entry (".stat", 0, S_IFCHR | S_IRUGO | S_IWUGO) )
 	 == NULL ) return NULL;
-    new->u.cdev.dev = devfs_alloc_devnum (DEVFS_SPECIAL_CHR);
+    new->u.cdev.dev = devfs_alloc_devnum (S_IFCHR | S_IRUGO | S_IWUGO);
     new->u.cdev.ops = &stat_fops;
     _devfs_append_entry (root_entry, new, FALSE, NULL);
 #endif
@@ -1469,7 +1471,6 @@
 			       unsigned int major, unsigned int minor,
 			       umode_t mode, void *ops, void *info)
 {
-    char devtype = S_ISCHR (mode) ? DEVFS_SPECIAL_CHR : DEVFS_SPECIAL_BLK;
     int err;
     dev_t devnum = 0, dev = MKDEV(major, minor);
     struct devfs_entry *de;
@@ -1497,7 +1498,7 @@
     if ( ( S_ISCHR (mode) || S_ISBLK (mode) ) &&
 	 (flags & DEVFS_FL_AUTO_DEVNUM) )
     {
-	devnum = devfs_alloc_devnum (devtype);
+	devnum = devfs_alloc_devnum (mode);
 	if (!devnum) {
 	    PRINTK ("(%s): exhausted %s device numbers\n",
 		    name, S_ISCHR (mode) ? "char" : "block");
@@ -1508,7 +1509,7 @@
     if ( ( de = _devfs_prepare_leaf (&dir, name, mode) ) == NULL )
     {
 	PRINTK ("(%s): could not prepare leaf\n", name);
-	if (devnum) devfs_dealloc_devnum (devtype, devnum);
+	if (devnum) devfs_dealloc_devnum (mode, devnum);
 	return NULL;
     }
     if (S_ISCHR (mode)) {
@@ -1544,7 +1545,7 @@
     {
 	PRINTK ("(%s): could not append to parent, err: %d\n", name, err);
 	devfs_put (dir);
-	if (devnum) devfs_dealloc_devnum (devtype, devnum);
+	if (devnum) devfs_dealloc_devnum (mode, devnum);
 	return NULL;
     }
     DPRINTK (DEBUG_REGISTER, "(%s): de: %p dir: %p \"%s\"  pp: %p\n",
@@ -1953,7 +1954,6 @@
 EXPORT_SYMBOL(devfs_mk_dir);
 EXPORT_SYMBOL(devfs_remove);
 EXPORT_SYMBOL(devfs_generate_path);
-EXPORT_SYMBOL(devfs_only);
 
 
 /**
===== fs/devfs/util.c 1.16 vs edited =====
--- 1.16/fs/devfs/util.c	Tue Dec  3 13:26:32 2002
+++ edited/fs/devfs/util.c	Sat Jan 11 17:57:50 2003
@@ -60,14 +60,16 @@
                Copied and used macro for error messages from fs/devfs/base.c 
     20021013   Richard Gooch <rgooch@atnf.csiro.au>
                Documentation fix.
+    20030101   Adam J. Richter <adam@yggdrasil.com>
+               Eliminate DEVFS_SPECIAL_{CHR,BLK}.  Use umode_t instead.
 */
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-
 #include <asm/bitops.h>
+#include "internal.h"
 
 #define PRINTK(format, args...) \
    {printk (KERN_ERR "%s" format, __FUNCTION__ , ## args);}
@@ -145,49 +147,11 @@
 
 /**
  *	devfs_alloc_major - Allocate a major number.
- *	@type: The type of the major (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK)
-
+ *	@mode: The file mode (must be block device or character device).
  *	Returns the allocated major, else -1 if none are available.
  *	This routine is thread safe and does not block.
  */
 
-int devfs_alloc_major (char type)
-{
-    int major;
-    struct major_list *list;
-
-    list = (type == DEVFS_SPECIAL_CHR) ? &char_major_list : &block_major_list;
-    spin_lock (&list->lock);
-    major = find_first_zero_bit (list->bits, 256);
-    if (major < 256) __set_bit (major, list->bits);
-    else major = -1;
-    spin_unlock (&list->lock);
-    return major;
-}   /*  End Function devfs_alloc_major  */
-EXPORT_SYMBOL(devfs_alloc_major);
-
-
-/**
- *	devfs_dealloc_major - Deallocate a major number.
- *	@type: The type of the major (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK)
- *	@major: The major number.
- *	This routine is thread safe and does not block.
- */
-
-void devfs_dealloc_major (char type, int major)
-{
-    int was_set;
-    struct major_list *list;
-
-    if (major < 0) return;
-    list = (type == DEVFS_SPECIAL_CHR) ? &char_major_list : &block_major_list;
-    spin_lock (&list->lock);
-    was_set = __test_and_clear_bit (major, list->bits);
-    spin_unlock (&list->lock);
-    if (!was_set) PRINTK ("(): major %d was already free\n", major);
-}   /*  End Function devfs_dealloc_major  */
-EXPORT_SYMBOL(devfs_dealloc_major);
-
 
 struct minor_list
 {
@@ -196,130 +160,110 @@
     struct minor_list *next;
 };
 
-struct device_list
-{
-    struct minor_list *first, *last;
-    int none_free;
-};
-
-static DECLARE_MUTEX (block_semaphore);
-static struct device_list block_list;
+static struct device_list {
+	struct minor_list	*first;
+	struct minor_list	*last;
+	int			none_free;
+} block_list, char_list;
 
-static DECLARE_MUTEX (char_semaphore);
-static struct device_list char_list;
+static DECLARE_MUTEX(device_list_mutex);
 
 
 /**
  *	devfs_alloc_devnum - Allocate a device number.
- *	@type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK).
+ *	@mode: The file mode (must be block device or character device).
  *
  *	Returns the allocated device number, else NODEV if none are available.
  *	This routine is thread safe and may block.
  */
 
-dev_t devfs_alloc_devnum (char type)
+dev_t devfs_alloc_devnum(umode_t mode)
 {
-    int minor;
-    struct semaphore *semaphore;
-    struct device_list *list;
-    struct minor_list *entry;
-
-    if (type == DEVFS_SPECIAL_CHR)
-    {
-	semaphore = &char_semaphore;
-	list = &char_list;
-    }
-    else
-    {
-	semaphore = &block_semaphore;
-	list = &block_list;
-    }
-    if (list->none_free) return 0;  /*  Fast test  */
-    down (semaphore);
-    if (list->none_free)
-    {
-	up (semaphore);
-	return 0;
-    }
-    for (entry = list->first; entry != NULL; entry = entry->next)
-    {
-	minor = find_first_zero_bit (entry->bits, 256);
-	if (minor >= 256) continue;
-	__set_bit (minor, entry->bits);
-	up (semaphore);
+	struct device_list *list;
+	struct major_list *major_list;
+	struct minor_list *entry;
+	int minor;
+
+	if (S_ISCHR(mode)) {
+		major_list = &char_major_list;
+		list = &char_list;
+	} else {
+		major_list = &block_major_list;
+		list = &block_list;
+	}
+
+	down(&device_list_mutex);
+	if (list->none_free)
+		goto out_unlock;
+
+	for (entry = list->first; entry; entry = entry->next) {
+		minor = find_first_zero_bit (entry->bits, 256);
+		if (minor >= 256)
+			continue;
+		goto out_done;
+	}
+	
+	/*  Need to allocate a new major  */
+	entry = kmalloc (sizeof *entry, GFP_KERNEL);
+	if (!entry)
+		goto out_full;
+	memset(entry, 0, sizeof *entry);
+
+	spin_lock(&major_list->lock);
+	entry->major = find_first_zero_bit(major_list->bits, 256);
+	if (entry->major >= 256) {
+		spin_unlock(&major_list->lock);
+		kfree(entry);
+		goto out_full;
+	}
+	__set_bit(entry->major, major_list->bits);
+	spin_unlock(&major_list->lock);
+
+	if (!list->first)
+		list->first = entry;
+	else
+		list->last->next = entry;
+	list->last = entry;
+
+	minor = 0;
+ out_done:
+	__set_bit(minor, entry->bits);
+	up(&device_list_mutex);
 	return MKDEV(entry->major, minor);
-    }
-    /*  Need to allocate a new major  */
-    if ( ( entry = kmalloc (sizeof *entry, GFP_KERNEL) ) == NULL )
-    {
-	list->none_free = 1;
-	up (semaphore);
-	return 0;
-    }
-    memset (entry, 0, sizeof *entry);
-    if ( ( entry->major = devfs_alloc_major (type) ) < 0 )
-    {
+ out_full:
 	list->none_free = 1;
-	up (semaphore);
-	kfree (entry);
+ out_unlock:
+	up(&device_list_mutex);
 	return 0;
-    }
-    __set_bit (0, entry->bits);
-    if (list->first == NULL) list->first = entry;
-    else list->last->next = entry;
-    list->last = entry;
-    up (semaphore);
-    return MKDEV(entry->major, 0);
-}   /*  End Function devfs_alloc_devnum  */
-EXPORT_SYMBOL(devfs_alloc_devnum);
+}
 
 
 /**
  *	devfs_dealloc_devnum - Dellocate a device number.
- *	@type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK).
+ *	@mode: The file mode (must be block device or character device).
  *	@devnum: The device number.
  *
  *	This routine is thread safe and may block.
  */
 
-void devfs_dealloc_devnum (char type, dev_t devnum)
+void devfs_dealloc_devnum(umode_t mode, dev_t devnum)
 {
-    int major, minor;
-    struct semaphore *semaphore;
-    struct device_list *list;
-    struct minor_list *entry;
-
-    if (!devnum) return;
-    if (type == DEVFS_SPECIAL_CHR)
-    {
-	semaphore = &char_semaphore;
-	list = &char_list;
-    }
-    else
-    {
-	semaphore = &block_semaphore;
-	list = &block_list;
-    }
-    major = MAJOR (devnum);
-    minor = MINOR (devnum);
-    down (semaphore);
-    for (entry = list->first; entry != NULL; entry = entry->next)
-    {
-	int was_set;
-
-	if (entry->major != major) continue;
-	was_set = __test_and_clear_bit (minor, entry->bits);
-	if (was_set) list->none_free = 0;
-	up (semaphore);
-	if (!was_set)
-	    PRINTK ( "(): device %s was already free\n", kdevname (to_kdev_t(devnum)) );
-	return;
-    }
-    up (semaphore);
-    PRINTK ( "(): major for %s not previously allocated\n",
-	     kdevname (to_kdev_t(devnum)) );
-}   /*  End Function devfs_dealloc_devnum  */
-EXPORT_SYMBOL(devfs_dealloc_devnum);
+	struct device_list *list = S_ISCHR(mode) ? &char_list : &block_list;
+	struct minor_list *entry;
+
+	if (!devnum)
+		return;
+
+	down(&device_list_mutex);
+	for (entry = list->first; entry; entry = entry->next) {
+		if (entry->major == MAJOR(devnum)) {
+			if (__test_and_clear_bit(MINOR(devnum), entry->bits))
+				list->none_free = 0;
+			break;
+		}
+	}
+	up(&device_list_mutex);
+}
 
 
 /**
--- /dev/null	2002-08-30 19:31:37.000000000 -0400
+++ edited/fs/devfs/internal.h	2003-01-11 16:44:54.000000000 -0500
@@ -0,0 +1,3 @@
+
+extern dev_t devfs_alloc_devnum(umode_t mode);
+extern void devfs_dealloc_devnum(umode_t mode, dev_t devnum);
--- 1.27/include/linux/devfs_fs_kernel.h	Wed Jan  1 15:18:35 2003
+++ edited/include/linux/devfs_fs_kernel.h	Sat Jan 11 16:47:08 2003
@@ -21,9 +21,6 @@
 #define DEVFS_FL_DEFAULT        DEVFS_FL_NONE
 
 
-#define DEVFS_SPECIAL_CHR     0
-#define DEVFS_SPECIAL_BLK     1
-
 typedef struct devfs_entry * devfs_handle_t;
 
 #ifdef CONFIG_DEVFS_FS
@@ -58,10 +55,6 @@
 extern int devfs_only (void);
 extern int devfs_register_tape (devfs_handle_t de);
 extern void devfs_unregister_tape(int num);
-extern int devfs_alloc_major (char type);
-extern void devfs_dealloc_major (char type, int major);
-extern dev_t devfs_alloc_devnum (char type);
-extern void devfs_dealloc_devnum (char type, dev_t devnum);
 extern int devfs_alloc_unique_number (struct unique_numspace *space);
 extern void devfs_dealloc_unique_number (struct unique_numspace *space,
 					 int number);
@@ -129,41 +122,18 @@
 static inline void devfs_unregister_tape(int num)
 {
 }
-static inline int devfs_alloc_major (char type)
-{
-    return -1;
-}
-
-static inline void devfs_dealloc_major (char type, int major)
-{
-    return;
-}
-
-static inline dev_t devfs_alloc_devnum (char type)
-{
-    return 0;
-}
-
-static inline void devfs_dealloc_devnum (char type, dev_t devnum)
-{
-    return;
-}
-
 static inline int devfs_alloc_unique_number (struct unique_numspace *space)
 {
     return -1;
 }
-
 static inline void devfs_dealloc_unique_number (struct unique_numspace *space,
 						int number)
 {
     return;
 }
-
 static inline void mount_devfs_fs (void)
 {
     return;
 }
 #endif  /*  CONFIG_DEVFS_FS  */
-
 #endif  /*  _LINUX_DEVFS_FS_KERNEL_H  */
