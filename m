Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263822AbTCVRdQ>; Sat, 22 Mar 2003 12:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263799AbTCVRbR>; Sat, 22 Mar 2003 12:31:17 -0500
Received: from verein.lst.de ([212.34.181.86]:22022 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S263380AbTCVR3U>;
	Sat, 22 Mar 2003 12:29:20 -0500
Date: Sat, 22 Mar 2003 18:40:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make devfs_alloc_unique_number private to devfs
Message-ID: <20030322184022.D21623@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.. by moving a bunch of devfs-related code from fs/partition/check.c
to fs/devfs/base.c.  Also has the nice sideffect of getting rid of
a bunch of ugly ifdefs.


diff -Nru a/fs/devfs/util.c b/fs/devfs/util.c
--- a/fs/devfs/util.c	Sat Mar 22 15:40:42 2003
+++ b/fs/devfs/util.c	Sat Mar 22 15:40:42 2003
@@ -70,6 +70,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/genhd.h>
 #include <asm/bitops.h>
 #include "internal.h"
 
@@ -266,6 +267,18 @@
 	up(&device_list_mutex);
 }
 
+struct unique_numspace
+{
+    spinlock_t init_lock;
+    unsigned char sem_initialised;
+    unsigned int num_free;          /*  Num free in bits       */
+    unsigned int length;            /*  Array length in bytes  */
+    unsigned long *bits;
+    struct semaphore semaphore;
+};
+
+#define UNIQUE_NUMBERSPACE_INITIALISER {SPIN_LOCK_UNLOCKED, 0, 0, 0, NULL}
+
 
 /**
  *	devfs_alloc_unique_number - Allocate a unique (positive) number.
@@ -339,3 +352,82 @@
     if (!was_set) PRINTK ("(): number %d was already free\n", number);
 }   /*  End Function devfs_dealloc_unique_number  */
 EXPORT_SYMBOL(devfs_dealloc_unique_number);
+
+static struct unique_numspace disc_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
+static struct unique_numspace cdrom_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
+
+void devfs_create_partitions(struct gendisk *dev)
+{
+	int pos = 0;
+	devfs_handle_t dir;
+	char dirname[64], symlink[16];
+
+	if (dev->flags & GENHD_FL_DEVFS) {
+		dir = dev->de;
+		if (!dir)  /*  Aware driver wants to block disc management  */
+			return;
+		pos = devfs_generate_path(dir, dirname + 3, sizeof dirname-3);
+		if (pos < 0)
+			return;
+		strncpy(dirname + pos, "../", 3);
+	} else {
+		/*  Unaware driver: construct "real" directory  */
+		sprintf(dirname, "../%s/disc%d", dev->disk_name,
+			dev->first_minor >> dev->minor_shift);
+		dir = devfs_mk_dir(dirname + 3);
+		dev->de = dir;
+	}
+	dev->number = devfs_alloc_unique_number (&disc_numspace);
+	sprintf(symlink, "discs/disc%d", dev->number);
+	devfs_mk_symlink(symlink, dirname + pos);
+	dev->disk_de = devfs_register(dir, "disc", 0,
+			    dev->major, dev->first_minor,
+			    S_IFBLK | S_IRUSR | S_IWUSR, dev->fops, NULL);
+}
+
+void devfs_create_cdrom(struct gendisk *dev)
+{
+	char vname[23];
+
+	dev->number = devfs_alloc_unique_number(&cdrom_numspace);
+	sprintf(vname, "cdroms/cdrom%d", dev->number);
+	if (dev->de) {
+		int pos;
+		char rname[64];
+
+		dev->disk_de = devfs_register(dev->de, "cd", DEVFS_FL_DEFAULT,
+				     dev->major, dev->first_minor,
+				     S_IFBLK | S_IRUGO | S_IWUGO,
+				     dev->fops, NULL);
+
+		pos = devfs_generate_path(dev->disk_de, rname+3, sizeof(rname)-3);
+		if (pos >= 0) {
+			strncpy(rname + pos, "../", 3);
+			devfs_mk_symlink(vname, rname + pos);
+		}
+	} else {
+		dev->disk_de = devfs_register (NULL, vname, DEVFS_FL_DEFAULT,
+				    dev->major, dev->first_minor,
+				    S_IFBLK | S_IRUGO | S_IWUGO,
+				    dev->fops, NULL);
+	}
+}
+
+void devfs_remove_partitions(struct gendisk *dev)
+{
+	devfs_unregister(dev->disk_de);
+	dev->disk_de = NULL;
+
+	if (dev->flags & GENHD_FL_CD) {
+		if (dev->de)
+			devfs_remove("cdroms/cdrom%d", dev->number);
+		devfs_dealloc_unique_number(&cdrom_numspace, dev->number);
+	} else {
+		devfs_remove("discs/disc%d", dev->number);
+		if (!(dev->flags & GENHD_FL_DEVFS)) {
+			devfs_unregister(dev->de);
+			dev->de = NULL;
+		}
+		devfs_dealloc_unique_number(&disc_numspace, dev->number);
+	}
+}
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Sat Mar 22 15:40:42 2003
+++ b/fs/partitions/check.c	Sat Mar 22 15:40:42 2003
@@ -176,93 +176,6 @@
 #endif
 }
 
-#ifdef CONFIG_DEVFS_FS
-static struct unique_numspace disc_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
-static struct unique_numspace cdrom_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
-#endif
-
-static void devfs_create_partitions(struct gendisk *dev)
-{
-#ifdef CONFIG_DEVFS_FS
-	int pos = 0;
-	devfs_handle_t dir;
-	char dirname[64], symlink[16];
-
-	if (dev->flags & GENHD_FL_DEVFS) {
-		dir = dev->de;
-		if (!dir)  /*  Aware driver wants to block disc management  */
-			return;
-		pos = devfs_generate_path(dir, dirname + 3, sizeof dirname-3);
-		if (pos < 0)
-			return;
-		strncpy(dirname + pos, "../", 3);
-	} else {
-		/*  Unaware driver: construct "real" directory  */
-		sprintf(dirname, "../%s/disc%d", dev->disk_name,
-			dev->first_minor >> dev->minor_shift);
-		dir = devfs_mk_dir(dirname + 3);
-		dev->de = dir;
-	}
-	dev->number = devfs_alloc_unique_number (&disc_numspace);
-	sprintf(symlink, "discs/disc%d", dev->number);
-	devfs_mk_symlink(symlink, dirname + pos);
-	dev->disk_de = devfs_register(dir, "disc", 0,
-			    dev->major, dev->first_minor,
-			    S_IFBLK | S_IRUSR | S_IWUSR, dev->fops, NULL);
-#endif
-}
-
-static void devfs_create_cdrom(struct gendisk *dev)
-{
-#ifdef CONFIG_DEVFS_FS
-	char vname[23];
-
-	dev->number = devfs_alloc_unique_number(&cdrom_numspace);
-	sprintf(vname, "cdroms/cdrom%d", dev->number);
-	if (dev->de) {
-		int pos;
-		char rname[64];
-
-		dev->disk_de = devfs_register(dev->de, "cd", DEVFS_FL_DEFAULT,
-				     dev->major, dev->first_minor,
-				     S_IFBLK | S_IRUGO | S_IWUGO,
-				     dev->fops, NULL);
-
-		pos = devfs_generate_path(dev->disk_de, rname+3, sizeof(rname)-3);
-		if (pos >= 0) {
-			strncpy(rname + pos, "../", 3);
-			devfs_mk_symlink(vname, rname + pos);
-		}
-	} else {
-		dev->disk_de = devfs_register (NULL, vname, DEVFS_FL_DEFAULT,
-				    dev->major, dev->first_minor,
-				    S_IFBLK | S_IRUGO | S_IWUGO,
-				    dev->fops, NULL);
-	}
-#endif
-}
-
-static void devfs_remove_partitions(struct gendisk *dev)
-{
-#ifdef CONFIG_DEVFS_FS
-	devfs_unregister(dev->disk_de);
-	dev->disk_de = NULL;
-	if (dev->flags & GENHD_FL_CD) {
-		if (dev->de)
-			devfs_remove("cdroms/cdrom%d", dev->number);
-		devfs_dealloc_unique_number(&cdrom_numspace, dev->number);
-	} else {
-		devfs_remove("discs/disc%d", dev->number);
-		if (!(dev->flags & GENHD_FL_DEVFS)) {
-			devfs_unregister(dev->de);
-			dev->de = NULL;
-		}
-		devfs_dealloc_unique_number(&disc_numspace, dev->number);
-	}
-#endif
-}
-
-
 /*
  * sysfs bindings for partitions
  */
@@ -547,7 +460,7 @@
 		put_disk(hd);
 	}
 	if (!dname->name) {
-		sprintf(dname->namebuf, "[dev %s]", kdevname(to_kdev_t(dev)));
+		sprintf(dname->namebuf, "[dev %s]", __bdevname(dev));
 		dname->name = dname->namebuf;
 	}
 
diff -Nru a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h	Sat Mar 22 15:40:42 2003
+++ b/include/linux/devfs_fs_kernel.h	Sat Mar 22 15:40:42 2003
@@ -20,20 +20,9 @@
 
 typedef struct devfs_entry * devfs_handle_t;
 
-#ifdef CONFIG_DEVFS_FS
-
-struct unique_numspace
-{
-    spinlock_t init_lock;
-    unsigned char sem_initialised;
-    unsigned int num_free;          /*  Num free in bits       */
-    unsigned int length;            /*  Array length in bytes  */
-    unsigned long *bits;
-    struct semaphore semaphore;
-};
-
-#define UNIQUE_NUMBERSPACE_INITIALISER {SPIN_LOCK_UNLOCKED, 0, 0, 0, NULL}
+struct gendisk;
 
+#ifdef CONFIG_DEVFS_FS
 extern devfs_handle_t devfs_register (devfs_handle_t dir, const char *name,
 				      unsigned int flags,
 				      unsigned int major, unsigned int minor,
@@ -47,21 +36,11 @@
 extern int devfs_generate_path (devfs_handle_t de, char *path, int buflen);
 extern int devfs_register_tape (devfs_handle_t de);
 extern void devfs_unregister_tape(int num);
-extern int devfs_alloc_unique_number (struct unique_numspace *space);
-extern void devfs_dealloc_unique_number (struct unique_numspace *space,
-					 int number);
-
+extern void devfs_create_partitions(struct gendisk *dev);
+extern void devfs_create_cdrom(struct gendisk *dev);
+extern void devfs_remove_partitions(struct gendisk *dev);
 extern void mount_devfs_fs (void);
-
 #else  /*  CONFIG_DEVFS_FS  */
-
-struct unique_numspace
-{
-    char dummy;
-};
-
-#define UNIQUE_NUMBERSPACE_INITIALISER {0}
-
 static inline devfs_handle_t devfs_register (devfs_handle_t dir,
 					     const char *name,
 					     unsigned int flags,
@@ -99,14 +78,14 @@
 static inline void devfs_unregister_tape(int num)
 {
 }
-static inline int devfs_alloc_unique_number (struct unique_numspace *space)
+static inline void devfs_create_partitions(struct gendisk *dev)
 {
-    return -1;
 }
-static inline void devfs_dealloc_unique_number (struct unique_numspace *space,
-						int number)
+extern void devfs_create_cdrom(struct gendisk *dev)
+{
+}
+extern void devfs_remove_partitions(struct gendisk *dev)
 {
-    return;
 }
 static inline void mount_devfs_fs (void)
 {
