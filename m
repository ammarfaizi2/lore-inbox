Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTDMWd5 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTDMWd5 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:33:57 -0400
Received: from hera.cwi.nl ([192.16.191.8]:26830 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262627AbTDMWdv (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 18:33:51 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 14 Apr 2003 00:45:36 +0200 (MEST)
Message-Id: <UTC200304132245.h3DMjaT25518.aeb@smtp.cwi.nl>
To: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] kdevt-diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below a kdev_t.h diff. I suppose it can be applied.
(For myself I prefer a complete check of all code involved
but I can see that people are somewhat impatient.)
This is the part that changes MAJOR/MINOR/MKDEV,
that is, the structure of dev_t.

The structure here is 8+8, except when more bits are
present, in which case it is 16+16, except when more bits
are present, in which case it is 32+32.
Since dev_t is 64-bit the structure of the middle part is not
very important, but in some contexts we naturally get 16+16
(e.g. from CDROM) and 16+16 avoids messy conversion.

The macros here are written with the casts and typechecking
that is otherwise implicit in the use of inline functions.
Because of name clashes they cannot be inline functions.
The MKDEV as given is not accepted by gcc in an enum,
that is why I changed root_dev.h.

Since MINORBITS disappears I gave md_k.h and dasd_int.h
local definitions.

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/kdev_t.h b/include/linux/kdev_t.h
--- a/include/linux/kdev_t.h	Tue Apr  8 09:36:46 2003
+++ b/include/linux/kdev_t.h	Sat Apr 12 19:46:18 2003
@@ -1,74 +1,9 @@
 #ifndef _LINUX_KDEV_T_H
 #define _LINUX_KDEV_T_H
 #ifdef __KERNEL__
-/*
-As a preparation for the introduction of larger device numbers,
-we introduce a type kdev_t to hold them. No information about
-this type is known outside of this include file.
-
-Objects of type kdev_t designate a device. Outside of the kernel
-the corresponding things are objects of type dev_t - usually an
-integral type with the device major and minor in the high and low
-bits, respectively. Conversion is done by
-
-extern kdev_t to_kdev_t(int);
-
-It is up to the various file systems to decide how objects of type
-dev_t are stored on disk.
-The only other point of contact between kernel and outside world
-are the system calls stat and mknod, new versions of which will
-eventually have to be used in libc.
-
-[Unfortunately, the floppy control ioctls fail to hide the internal
-kernel structures, and the fd_device field of a struct floppy_drive_struct
-is user-visible. So, it remains a dev_t for the moment, with some ugly
-conversions in floppy.c.]
-
-Inside the kernel, we aim for a kdev_t type that is a pointer
-to a structure with information about the device (like major,
-minor, size, blocksize, sectorsize, name, read-only flag,
-struct file_operations etc.).
-
-However, for the time being we let kdev_t be almost the same as dev_t:
-
-typedef struct { unsigned short major, minor; } kdev_t;
-
-Admissible operations on an object of type kdev_t:
-- passing it along
-- comparing it for equality with another such object
-- storing it in inode->i_rdev or tty->device
-- using its bit pattern as argument in a hash function
-- finding its major and minor
-- complaining about it
-
-An object of type kdev_t is created only by the function MKDEV(),
-with the single exception of the constant 0 (no device).
-
-Right now the other information mentioned above is usually found
-in static arrays indexed by major or major,minor.
-
-An obstacle to immediately using
-    typedef struct { ... (* lots of information *) } *kdev_t
-is the case of mknod used to create a block device that the
-kernel doesn't know about at present (but first learns about
-when some module is inserted).
-
-aeb - 950811
-*/
 
+#include <linux/types.h>	/* for dev_t */
 
-/*
- * NOTE NOTE NOTE!
- *
- * The kernel-internal "kdev_t" will eventually have
- * 20 bits for minor numbers, and 12 bits for majors.
- *
- * HOWEVER, the external representation is still 8+8
- * bits, and there is no way to generate the extended
- * "kdev_t" format yet. Which is just as well, since
- * we still use "minor" as an index into various
- * static arrays, and they are sized for a 8-bit index.
- */
 typedef struct {
 	unsigned short value;
 } kdev_t;
@@ -113,12 +48,47 @@
 #define major(dev)	(((dev).value >> KDEV_MINOR_BITS) & 0xff)
 
 /* These are for user-level "dev_t" */
-#define MINORBITS	8
-#define MINORMASK	((1U << MINORBITS) - 1)
+/* Going back and forth between dev and (ma,mi) is one-to-one
+   provided ma is nonzero or ma is zero and mi is 8-bit only.
+   Never use major 0 together with a minor larger than 255. */
+#if 0
+/* readable versions */
+static inline unsigned int
+MAJOR(dev_t dev) {
+	return (dev & ~0xffffffff) ? (dev >> 32) :
+		(dev & ~0xffff) ? (dev >> 16) : (dev >> 8);
+}
+
+static inline unsigned int
+MINOR(dev_t dev) {
+	return (dev & ~0xffffffff) ? (dev & 0xffffffff) :
+		(dev & ~0xffff) ? (dev & 0xffff) : (dev & 0xff);
+}
 
-#define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
-#define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
-#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
+static inline dev_t
+MKDEV(unsigned int major, unsigned int minor) {
+	unsigned int both = (major | minor);
+	return ((both & ~0xffff) ? (((dev_t) major) << 32) :
+		(both & ~0xff) ? (((dev_t) major) << 16) :
+		(((dev_t) major) << 8) ) | minor;
+}
+#else
+/* ugly macro versions */
+#define MAJOR(dev) ((unsigned int)({ dev_t __dev = dev; \
+   (__dev & ~0xffffffff) ? (__dev >> 32) : \
+   (__dev & ~0xffff) ? (__dev >> 16) : (__dev >> 8); }))
+#define MINOR(dev) ((unsigned int)({ dev_t __dev = dev; \
+   (__dev & ~0xffffffff) ? (__dev & 0xffffffff) : \
+   (__dev & ~0xffff) ? (__dev & 0xffff) : (__dev & 0xff); }))
+#define constant_MKDEV(ma, mi) \
+   ((((ma)|(mi)) & ~0xffff) ? ((ma) << 32) | (mi) : \
+    (((ma)|(mi)) & ~0xff) ? ((ma) << 16) | (mi) : ((ma) << 8) | (mi))
+#define MKDEV(major, minor) ({ \
+   unsigned int __ma = major, __mi = minor, __both = (__ma | __mi); \
+   ((sizeof(dev_t) > 4 && (__both & ~0xffff)) ? (((dev_t) __ma) << 32) : \
+    (__both & ~0xff) ? (((dev_t) __ma) << 16) : (((dev_t) __ma) << 8) \
+   ) | __mi; })
+#endif
 
 /*
  * Conversion functions
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/root_dev.h b/include/linux/root_dev.h
--- a/include/linux/root_dev.h	Fri Nov 22 22:40:24 2002
+++ b/include/linux/root_dev.h	Sat Apr 12 19:49:53 2003
@@ -1,18 +1,16 @@
 #ifndef _ROOT_DEV_H_
 #define _ROOT_DEV_H_
 
-enum {
-	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
-	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
-	Root_RAM1 = MKDEV(RAMDISK_MAJOR, 1),
-	Root_FD0 = MKDEV(FLOPPY_MAJOR, 0),
-	Root_HDA1 = MKDEV(IDE0_MAJOR, 1),
-	Root_HDA2 = MKDEV(IDE0_MAJOR, 2),
-	Root_SDA1 = MKDEV(SCSI_DISK0_MAJOR, 1),
-	Root_SDA2 = MKDEV(SCSI_DISK0_MAJOR, 2),
-	Root_HDC1 = MKDEV(IDE1_MAJOR, 1),
-	Root_SR0 = MKDEV(SCSI_CDROM_MAJOR, 0),
-};
+#define	Root_NFS	MKDEV(UNNAMED_MAJOR, 255)
+#define	Root_RAM0	MKDEV(RAMDISK_MAJOR, 0)
+#define	Root_RAM1	MKDEV(RAMDISK_MAJOR, 1)
+#define	Root_FD0	MKDEV(FLOPPY_MAJOR, 0)
+#define	Root_HDA1	MKDEV(IDE0_MAJOR, 1)
+#define	Root_HDA2	MKDEV(IDE0_MAJOR, 2)
+#define	Root_SDA1	MKDEV(SCSI_DISK0_MAJOR, 1)
+#define	Root_SDA2	MKDEV(SCSI_DISK0_MAJOR, 2)
+#define	Root_HDC1	MKDEV(IDE1_MAJOR, 1)
+#define	Root_SR0	MKDEV(SCSI_CDROM_MAJOR, 0)
 
 extern dev_t ROOT_DEV;
 
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/raid/md_k.h b/include/linux/raid/md_k.h
--- a/include/linux/raid/md_k.h	Tue Apr  8 09:36:47 2003
+++ b/include/linux/raid/md_k.h	Sat Apr 12 13:42:52 2003
@@ -64,11 +64,7 @@
 typedef struct mddev_s mddev_t;
 typedef struct mdk_rdev_s mdk_rdev_t;
 
-#if (MINORBITS != 8)
-#error MD does not handle bigger kdev yet
-#endif
-
-#define MAX_MD_DEVS  (1<<MINORBITS)	/* Max number of md dev */
+#define MAX_MD_DEVS  256	/* Max number of md dev */
 
 /*
  * options passed in raidrun:
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
--- a/drivers/s390/block/dasd_int.h	Tue Dec 10 18:42:33 2002
+++ b/drivers/s390/block/dasd_int.h	Sat Apr 12 13:44:41 2003
@@ -19,7 +19,8 @@
 
 #ifdef __KERNEL__
 
-#define DASD_PER_MAJOR ( 1U<<(MINORBITS-DASD_PARTN_BITS))
+#define DASD_MINORBITS 8
+#define DASD_PER_MAJOR ( 1U<<(DASD_MINORBITS-DASD_PARTN_BITS))
 #define DASD_PARTN_MASK ((1 << DASD_PARTN_BITS) - 1)
 
 /*
