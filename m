Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262866AbTCRWDD>; Tue, 18 Mar 2003 17:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbTCRWDD>; Tue, 18 Mar 2003 17:03:03 -0500
Received: from hera.cwi.nl ([192.16.191.8]:27382 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262866AbTCRWC7>;
	Tue, 18 Mar 2003 17:02:59 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 18 Mar 2003 23:13:54 +0100 (MET)
Message-Id: <UTC200303182213.h2IMDse09784.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH - for playing only] change type of dev_t
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below some random patch, not to be applied, so that
people can play with a 32-bit dev_t.

Nothing here is hewn in stone.
By some coincidence the division below is 16+16, but
a simple edit turns that into 12+20 or 32+32.
Elsewhere there are no (well, there still are a few,
but they will be eliminated), there are no assumptions
on the sizes involved.

A major and a minor are unsigned ints of unknown size.

Of course not all filesystems can handle all sizes.

Andries

[I still see a B_FREE here - had removed that earlier,
but perhaps the patch was not applied. There is another
occurrence in video/pm3fb.h that can be removed, and one
in video/pm3fb.c that should become NODEV. Will find this
patch again.]

----------------------- 19-devt-type -----------------------
diff -u --recursive --new-file -X /linux/dontdiff a/fs/libfs.c b/fs/libfs.c
--- a/fs/libfs.c	Thu Jan  2 14:32:11 2003
+++ b/fs/libfs.c	Tue Mar 18 22:14:48 2003
@@ -340,6 +340,6 @@
 const char * kdevname(kdev_t dev)
 {
 	static char buffer[32];
-	sprintf(buffer, "%02x:%02x", major(dev), minor(dev));
+	sprintf(buffer, "%04x:%04x", major(dev), minor(dev));
 	return buffer;
 }
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-i386/posix_types.h b/include/asm-i386/posix_types.h
--- a/include/asm-i386/posix_types.h	Mon Feb 24 23:02:56 2003
+++ b/include/asm-i386/posix_types.h	Tue Mar 18 22:14:48 2003
@@ -7,7 +7,7 @@
  * assume GCC is being used.
  */
 
-typedef unsigned short	__kernel_dev_t;
+typedef unsigned long	__kernel_dev_t;
 typedef unsigned long	__kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/kdev_t.h b/include/linux/kdev_t.h
--- a/include/linux/kdev_t.h	Fri Nov 22 22:40:57 2002
+++ b/include/linux/kdev_t.h	Tue Mar 18 22:14:48 2003
@@ -70,13 +70,13 @@
  * static arrays, and they are sized for a 8-bit index.
  */
 typedef struct {
-	unsigned short value;
+	unsigned int value;
 } kdev_t;
 
-#define KDEV_MINOR_BITS		8
-#define KDEV_MAJOR_BITS		8
+#define KDEV_MINOR_BITS		16
+#define KDEV_MAJOR_BITS		16
 
-#define __mkdev(major,minor)	(((major) << KDEV_MINOR_BITS) + (minor))
+#define __mkdev(major, minor)	(((major) << KDEV_MINOR_BITS) + (minor))
 
 #define mk_kdev(major, minor)	((kdev_t) { __mkdev(major,minor) } )
 
@@ -99,7 +99,6 @@
 
 #define HASHDEV(dev)	(kdev_val(dev))
 #define NODEV		(mk_kdev(0,0))
-#define B_FREE		(mk_kdev(0xff,0xff))
 
 extern const char * kdevname(kdev_t);	/* note: returns pointer to static data! */
 
@@ -110,17 +109,55 @@
 
 #define kdev_none(d1)	(!kdev_val(d1))
 
-/* Mask off the high bits for now.. */
-#define minor(dev)	((dev).value & 0xff)
-#define major(dev)	(((dev).value >> KDEV_MINOR_BITS) & 0xff)
+#define minor(dev)	((dev).value & 0xffff)
+#define major(dev)	(((dev).value >> KDEV_MINOR_BITS) & 0xffff)
 
 /* These are for user-level "dev_t" */
+/* Since glibc uses 8+8 in <include/sysmacros.h>, we'll get
+   incompatibilities with a simple scheme like 12+20.
+   Use 8+8 for 16-bit values, some other division, say 16+16,
+   for 32-bit values. */
 #define MINORBITS	8
 #define MINORMASK	((1U << MINORBITS) - 1)
 
-#define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
-#define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
-#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
+#include <linux/types.h>	/* dev_t */
+#if 1
+/* macro versions */
+
+#define MAJOR(dev)	((unsigned int)(((dev) & 0xffff0000) ? ((dev) >> 16) & 0xffff : ((dev) >> 8) & 0xff))
+#define MINOR(dev)	((unsigned int)(((dev) & 0xffff0000) ? ((dev) & 0xffff) : ((dev) & 0xff)))
+#define MKDEV(ma,mi)	((dev_t)((((ma) & ~0xff) == 0 && ((mi) & ~0xff) == 0) ? (((ma) << 8) | (mi)) : (((ma) << 16) | (mi))))
+
+#else
+/* inline function versions */
+
+static inline unsigned int
+MAJOR(dev_t dev) {
+	unsigned int ma;
+
+	ma = ((dev >> 16) & 0xffff);
+	if (ma == 0)
+		ma = ((dev >> 8) & 0xff);
+	return ma;
+}
+
+static inline unsigned int
+MINOR(dev_t dev) {
+	unsigned int mi;
+
+	mi = (dev & 0xffff);
+	if (mi == dev)
+		mi = (dev & 0xff);
+	return mi;
+}
+
+static inline dev_t
+MKDEV(unsigned int ma, unsigned int mi) {
+	if ((ma & ~0xff) == 0 && (mi & ~0xff) == 0)
+		return ((ma << 8) | mi);
+	return ((ma << 16) | mi);
+}
+#endif
 
 /*
  * Conversion functions
@@ -128,12 +165,16 @@
 
 static inline int kdev_t_to_nr(kdev_t dev)
 {
-	return MKDEV(major(dev), minor(dev));
+	unsigned int ma = major(dev);
+	unsigned int mi = minor(dev);
+	return MKDEV(ma, mi);
 }
 
-static inline kdev_t to_kdev_t(int dev)
+static inline kdev_t to_kdev_t(dev_t dev)
 {
-	return mk_kdev(MAJOR(dev),MINOR(dev));
+	unsigned int ma = MAJOR(dev);
+	unsigned int mi = MINOR(dev);
+	return mk_kdev(ma, mi);
 }
 
 #else /* __KERNEL__ */
