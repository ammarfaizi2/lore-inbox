Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbTDRMxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 08:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbTDRMxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 08:53:13 -0400
Received: from hera.cwi.nl ([192.16.191.8]:40614 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263037AbTDRMxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 08:53:00 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 18 Apr 2003 15:04:55 +0200 (MEST)
Message-Id: <UTC200304181304.h3ID4tU00820.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Subject: [PATCH] struct loop_info64
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, upon general request, a shorter version.
It has struct loop_info64 and __kernel_old_dev_t.
Otherwise mostly as before.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/loop.h b/include/linux/loop.h
--- a/include/linux/loop.h	Fri Nov 22 22:41:13 2002
+++ b/include/linux/loop.h	Fri Apr 18 14:00:15 2003
@@ -1,8 +1,6 @@
 #ifndef _LINUX_LOOP_H
 #define _LINUX_LOOP_H
 
-#include <linux/kdev_t.h>
-
 /*
  * include/linux/loop.h
  *
@@ -74,34 +72,37 @@
 #define LO_FLAGS_READ_ONLY	2
 #define LO_FLAGS_BH_REMAP	4
 
-/* 
- * Note that this structure gets the wrong offsets when directly used
- * from a glibc program, because glibc has a 32bit dev_t.
- * Prevent people from shooting in their own foot.  
- */
-#if __GLIBC__ >= 2 && !defined(dev_t)
-#error "Wrong dev_t in loop.h"
-#endif 
-
-/*
- *	This uses kdev_t because glibc currently has no appropiate
- *	conversion version for the loop ioctls. 
- * 	The situation is very unpleasant	
- */
+#include <asm/posix_types.h>	/* for __kernel_old_dev_t */
 
+/* Backwards compatibility version */
 struct loop_info {
-	int		lo_number;	/* ioctl r/o */
-	dev_t		lo_device; 	/* ioctl r/o */
-	unsigned long	lo_inode; 	/* ioctl r/o */
-	dev_t		lo_rdevice; 	/* ioctl r/o */
-	int		lo_offset;
-	int		lo_encrypt_type;
-	int		lo_encrypt_key_size; 	/* ioctl w/o */
-	int		lo_flags;	/* ioctl r/o */
-	char		lo_name[LO_NAME_SIZE];
-	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
-	unsigned long	lo_init[2];
-	char		reserved[4];
+	int		   lo_number;		/* ioctl r/o */
+	__kernel_old_dev_t lo_device; 		/* ioctl r/o */
+	unsigned long	   lo_inode; 		/* ioctl r/o */
+	__kernel_old_dev_t lo_rdevice; 		/* ioctl r/o */
+	int		   lo_offset;
+	int		   lo_encrypt_type;
+	int		   lo_encrypt_key_size; 	/* ioctl w/o */
+	int		   lo_flags;			/* ioctl r/o */
+	char		   lo_name[LO_NAME_SIZE];
+	unsigned char	   lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	   lo_init[2];
+	char		   reserved[4];
+};
+
+struct loop_info64 {
+	int		   lo_number;		/* ioctl r/o */
+	unsigned long long lo_device; 		/* ioctl r/o */
+	unsigned long	   lo_inode; 		/* ioctl r/o */
+	unsigned long long lo_rdevice; 		/* ioctl r/o */
+	int		   lo_offset;
+	int		   lo_encrypt_type;
+	int		   lo_encrypt_key_size; 	/* ioctl w/o */
+	int		   lo_flags;			/* ioctl r/o */
+	char		   lo_name[LO_NAME_SIZE];
+	unsigned char	   lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	   lo_init[2];
+	char		   reserved[4];
 };
 
 /*
@@ -125,7 +126,7 @@
 	int number; 	/* filter type */ 
 	int (*transfer)(struct loop_device *lo, int cmd, char *raw_buf,
 			char *loop_buf, int size, sector_t real_block);
-	int (*init)(struct loop_device *, struct loop_info *); 
+	int (*init)(struct loop_device *, const struct loop_info64 *); 
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *); 
 	int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
@@ -134,7 +135,7 @@
 	void (*unlock)(struct loop_device *);
 }; 
 
-int  loop_register_transfer(struct loop_func_table *funcs);
+int loop_register_transfer(struct loop_func_table *funcs);
 int loop_unregister_transfer(int number); 
 
 #endif
@@ -142,9 +143,11 @@
  * IOCTL commands --- we will commandeer 0x4C ('L')
  */
 
-#define LOOP_SET_FD	0x4C00
-#define LOOP_CLR_FD	0x4C01
-#define LOOP_SET_STATUS	0x4C02
-#define LOOP_GET_STATUS	0x4C03
+#define LOOP_SET_FD		0x4C00
+#define LOOP_CLR_FD		0x4C01
+#define LOOP_SET_STATUS		0x4C02
+#define LOOP_GET_STATUS		0x4C03
+#define LOOP_SET_STATUS64	0x4C04
+#define LOOP_GET_STATUS64	0x4C05
 
 #endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-alpha/posix_types.h b/include/asm-alpha/posix_types.h
--- a/include/asm-alpha/posix_types.h	Mon Feb 24 23:02:56 2003
+++ b/include/asm-alpha/posix_types.h	Fri Apr 18 13:31:28 2003
@@ -40,6 +40,8 @@
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
 
+typedef unsigned int	__kernel_old_dev_t;
+
 #ifdef __KERNEL__
 
 #ifndef __GNUC__
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-arm/posix_types.h b/include/asm-arm/posix_types.h
--- a/include/asm-arm/posix_types.h	Tue Mar 18 11:48:22 2003
+++ b/include/asm-arm/posix_types.h	Fri Apr 18 13:28:02 2003
@@ -45,6 +45,7 @@
 
 typedef unsigned short		__kernel_old_uid_t;
 typedef unsigned short		__kernel_old_gid_t;
+typedef unsigned short		__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long		__kernel_loff_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-cris/posix_types.h b/include/asm-cris/posix_types.h
--- a/include/asm-cris/posix_types.h	Fri Nov 22 22:40:22 2002
+++ b/include/asm-cris/posix_types.h	Fri Apr 18 13:28:16 2003
@@ -38,6 +38,7 @@
 
 typedef unsigned short  __kernel_old_uid_t;
 typedef unsigned short  __kernel_old_gid_t;
+typedef unsigned short	__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long	__kernel_loff_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-i386/posix_types.h b/include/asm-i386/posix_types.h
--- a/include/asm-i386/posix_types.h	Mon Feb 24 23:02:56 2003
+++ b/include/asm-i386/posix_types.h	Fri Apr 18 13:28:29 2003
@@ -33,6 +33,7 @@
 
 typedef unsigned short	__kernel_old_uid_t;
 typedef unsigned short	__kernel_old_gid_t;
+typedef unsigned short	__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long	__kernel_loff_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ia64/posix_types.h b/include/asm-ia64/posix_types.h
--- a/include/asm-ia64/posix_types.h	Tue Mar 18 11:48:23 2003
+++ b/include/asm-ia64/posix_types.h	Fri Apr 18 13:28:38 2003
@@ -43,6 +43,8 @@
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
 
+typedef unsigned int	__kernel_old_dev_t;
+
 # ifdef __KERNEL__
 
 #  ifndef __GNUC__
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-m68k/posix_types.h b/include/asm-m68k/posix_types.h
--- a/include/asm-m68k/posix_types.h	Wed Mar  5 10:47:30 2003
+++ b/include/asm-m68k/posix_types.h	Fri Apr 18 13:28:53 2003
@@ -33,6 +33,7 @@
 
 typedef unsigned short	__kernel_old_uid_t;
 typedef unsigned short	__kernel_old_gid_t;
+typedef unsigned short	__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long	__kernel_loff_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-mips/posix_types.h b/include/asm-mips/posix_types.h
--- a/include/asm-mips/posix_types.h	Fri Nov 22 22:40:50 2002
+++ b/include/asm-mips/posix_types.h	Fri Apr 18 13:29:17 2003
@@ -39,6 +39,7 @@
 typedef int		__kernel_gid32_t;
 typedef __kernel_uid_t	__kernel_old_uid_t;
 typedef __kernel_gid_t	__kernel_old_gid_t;
+typedef unsigned int	__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long      __kernel_loff_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-mips64/posix_types.h b/include/asm-mips64/posix_types.h
--- a/include/asm-mips64/posix_types.h	Wed Dec 18 12:52:06 2002
+++ b/include/asm-mips64/posix_types.h	Fri Apr 18 13:29:38 2003
@@ -39,6 +39,7 @@
 typedef int		__kernel_gid32_t;
 typedef __kernel_uid_t	__kernel_old_uid_t;
 typedef __kernel_gid_t	__kernel_old_gid_t;
+typedef unsigned int	__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long      __kernel_loff_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-parisc/posix_types.h b/include/asm-parisc/posix_types.h
--- a/include/asm-parisc/posix_types.h	Tue Mar 25 04:54:42 2003
+++ b/include/asm-parisc/posix_types.h	Fri Apr 18 13:29:55 2003
@@ -45,6 +45,8 @@
 typedef unsigned long long	__kernel_ino64_t;
 #endif
 
+typedef unsigned int		__kernel_old_dev_t;
+
 typedef struct {
 #if defined(__KERNEL__) || defined(__USE_ALL)
 	int	val[2];
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ppc/posix_types.h b/include/asm-ppc/posix_types.h
--- a/include/asm-ppc/posix_types.h	Mon Feb 24 23:02:56 2003
+++ b/include/asm-ppc/posix_types.h	Fri Apr 18 13:30:11 2003
@@ -33,6 +33,7 @@
 
 typedef unsigned int	__kernel_old_uid_t;
 typedef unsigned int	__kernel_old_gid_t;
+typedef unsigned int	__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long	__kernel_loff_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ppc64/posix_types.h b/include/asm-ppc64/posix_types.h
--- a/include/asm-ppc64/posix_types.h	Mon Feb 24 23:02:56 2003
+++ b/include/asm-ppc64/posix_types.h	Fri Apr 18 13:30:23 2003
@@ -39,6 +39,7 @@
 
 typedef unsigned int	__kernel_old_uid_t;
 typedef unsigned int	__kernel_old_gid_t;
+typedef unsigned long	__kernel_old_dev_t;
 
 typedef struct {
 	int	val[2];
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-s390/posix_types.h b/include/asm-s390/posix_types.h
--- a/include/asm-s390/posix_types.h	Wed Dec 18 12:52:06 2002
+++ b/include/asm-s390/posix_types.h	Fri Apr 18 13:30:30 2003
@@ -39,6 +39,7 @@
 
 typedef unsigned short	__kernel_old_uid_t;
 typedef unsigned short	__kernel_old_gid_t;
+typedef unsigned short	__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long       __kernel_loff_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-s390x/posix_types.h b/include/asm-s390x/posix_types.h
--- a/include/asm-s390x/posix_types.h	Wed Dec 18 12:52:06 2002
+++ b/include/asm-s390x/posix_types.h	Fri Apr 18 13:30:44 2003
@@ -42,6 +42,8 @@
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
 
+typedef unsigned int	__kernel_old_dev_t;
+
 typedef struct {
 #if defined(__KERNEL__) || defined(__USE_ALL)
         int     val[2];
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sh/posix_types.h b/include/asm-sh/posix_types.h
--- a/include/asm-sh/posix_types.h	Fri Nov 22 22:40:41 2002
+++ b/include/asm-sh/posix_types.h	Fri Apr 18 13:23:53 2003
@@ -31,6 +31,7 @@
 
 typedef unsigned short	__kernel_old_uid_t;
 typedef unsigned short	__kernel_old_gid_t;
+typedef unsigned short	__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long	__kernel_loff_t;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sparc/posix_types.h b/include/asm-sparc/posix_types.h
--- a/include/asm-sparc/posix_types.h	Mon Feb 24 23:02:57 2003
+++ b/include/asm-sparc/posix_types.h	Fri Apr 18 13:41:36 2003
@@ -31,6 +31,7 @@
 typedef unsigned int	       __kernel_gid32_t;
 typedef unsigned short	       __kernel_old_uid_t;
 typedef unsigned short	       __kernel_old_gid_t;
+typedef unsigned short	       __kernel_old_dev_t;
 typedef int                    __kernel_clockid_t;
 typedef int                    __kernel_timer_t;
 
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sparc64/posix_types.h b/include/asm-sparc64/posix_types.h
--- a/include/asm-sparc64/posix_types.h	Mon Feb 24 23:02:57 2003
+++ b/include/asm-sparc64/posix_types.h	Fri Apr 18 13:25:24 2003
@@ -34,6 +34,8 @@
 typedef __kernel_uid_t	       __kernel_uid32_t;
 typedef __kernel_gid_t	       __kernel_gid32_t;
 
+typedef unsigned int	       __kernel_old_dev_t;
+
 /* Note this piece of asymmetry from the v9 ABI.  */
 typedef int		       __kernel_suseconds_t;
 
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-v850/posix_types.h b/include/asm-v850/posix_types.h
--- a/include/asm-v850/posix_types.h	Fri Nov 22 22:41:13 2002
+++ b/include/asm-v850/posix_types.h	Fri Apr 18 13:26:07 2003
@@ -40,7 +40,7 @@
 
 /* Some bogus code depends on this; we don't care.  */
 typedef __kernel_uid_t __kernel_old_uid_t;
-
+typedef unsigned int	__kernel_old_dev_t;
 
 typedef struct {
 #if defined(__KERNEL__) || defined(__USE_ALL)
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-x86_64/posix_types.h b/include/asm-x86_64/posix_types.h
--- a/include/asm-x86_64/posix_types.h	Mon Feb 24 23:02:57 2003
+++ b/include/asm-x86_64/posix_types.h	Fri Apr 18 13:27:15 2003
@@ -22,8 +22,8 @@
 typedef long		__kernel_time_t;
 typedef long		__kernel_suseconds_t;
 typedef long		__kernel_clock_t;
-typedef int            __kernel_timer_t;
-typedef int            __kernel_clockid_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int		__kernel_daddr_t;
 typedef char *		__kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
@@ -42,6 +42,8 @@
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
 
+typedef unsigned long	__kernel_old_dev_t;
+
 #ifdef __KERNEL__
 
 #undef __FD_SET
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Tue Mar 25 04:54:31 2003
+++ b/drivers/block/loop.c	Fri Apr 18 13:46:32 2003
@@ -120,13 +120,13 @@
 	return 0;
 }
 
-static int none_status(struct loop_device *lo, struct loop_info *info)
+static int none_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	lo->lo_flags |= LO_FLAGS_BH_REMAP;
 	return 0;
 }
 
-static int xor_status(struct loop_device *lo, struct loop_info *info)
+static int xor_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	if (info->lo_encrypt_key_size <= 0)
 		return -EINVAL;
@@ -215,7 +215,8 @@
 			 * The transfer failed, but we still write the data to
 			 * keep prepare/commit calls balanced.
 			 */
-			printk(KERN_ERR "loop: transfer error block %llu\n", (unsigned long long)index);
+			printk(KERN_ERR "loop: transfer error block %llu\n",
+			       (unsigned long long)index);
 			memset(kaddr + offset, 0, size);
 		}
 		flush_dcache_page(page);
@@ -270,7 +271,9 @@
 	int bsize;
 };
 
-static int lo_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+static int
+lo_read_actor(read_descriptor_t *desc, struct page *page,
+	      unsigned long offset, unsigned long size)
 {
 	char *kaddr;
 	unsigned long count = desc->count;
@@ -284,7 +287,8 @@
 	kaddr = kmap(page);
 	if (lo_do_transfer(lo, READ, kaddr + offset, p->data, size, IV)) {
 		size = 0;
-		printk(KERN_ERR "loop: transfer error block %ld\n",page->index);
+		printk(KERN_ERR "loop: transfer error block %ld\n",
+		       page->index);
 		desc->error = -EINVAL;
 	}
 	kunmap(page);
@@ -297,7 +301,7 @@
 
 static int
 do_lo_receive(struct loop_device *lo,
-		struct bio_vec *bvec, int bsize, loff_t pos)
+	      struct bio_vec *bvec, int bsize, loff_t pos)
 {
 	struct lo_read_data cookie;
 	struct file *file;
@@ -330,8 +334,8 @@
 	return ret;
 }
 
-static inline unsigned long loop_get_iv(struct loop_device *lo,
-					unsigned long sector)
+static inline unsigned long
+loop_get_iv(struct loop_device *lo, unsigned long sector)
 {
 	int bs = lo->lo_blocksize;
 	unsigned long offset, IV;
@@ -358,6 +362,7 @@
 }
 
 static int loop_end_io_transfer(struct bio *, unsigned int, int);
+
 static void loop_put_buffer(struct bio *bio)
 {
 	/*
@@ -764,7 +769,8 @@
 	return err;
 }
 
-static int loop_init_xfer(struct loop_device *lo, int type,struct loop_info *i)
+static int
+loop_init_xfer(struct loop_device *lo, int type, const struct loop_info64 *i)
 {
 	int err = 0; 
 	if (type) {
@@ -822,9 +828,9 @@
 	return 0;
 }
 
-static int loop_set_status(struct loop_device *lo, struct loop_info *arg)
+static int
+loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
-	struct loop_info info; 
 	int err;
 	unsigned int type;
 	loff_t offset;
@@ -834,23 +840,21 @@
 		return -EPERM;
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
-	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
-		return -EFAULT; 
-	if ((unsigned int) info.lo_encrypt_key_size > LO_KEY_SIZE)
+	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
-	type = info.lo_encrypt_type; 
+	type = info->lo_encrypt_type; 
 	if (type >= MAX_LO_CRYPT || xfer_funcs[type] == NULL)
 		return -EINVAL;
-	if (type == LO_CRYPT_XOR && info.lo_encrypt_key_size == 0)
+	if (type == LO_CRYPT_XOR && info->lo_encrypt_key_size == 0)
 		return -EINVAL;
 
 	err = loop_release_xfer(lo);
 	if (!err) 
-		err = loop_init_xfer(lo, type, &info);
+		err = loop_init_xfer(lo, type, info);
 
 	offset = lo->lo_offset;
-	if (offset != info.lo_offset) {
-		lo->lo_offset = info.lo_offset;
+	if (offset != info->lo_offset) {
+		lo->lo_offset = info->lo_offset;
 		if (figure_loop_size(lo)){
 			err = -EFBIG;
 			lo->lo_offset = offset;
@@ -860,51 +864,127 @@
 	if (err)
 		return err;	
 
-	strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);
+	strncpy(lo->lo_name, info->lo_name, LO_NAME_SIZE);
 
 	lo->transfer = xfer_funcs[type]->transfer;
 	lo->ioctl = xfer_funcs[type]->ioctl;
-	lo->lo_encrypt_key_size = info.lo_encrypt_key_size;
-	lo->lo_init[0] = info.lo_init[0];
-	lo->lo_init[1] = info.lo_init[1];
-	if (info.lo_encrypt_key_size) {
-		memcpy(lo->lo_encrypt_key, info.lo_encrypt_key, 
-		       info.lo_encrypt_key_size);
+	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
+	lo->lo_init[0] = info->lo_init[0];
+	lo->lo_init[1] = info->lo_init[1];
+	if (info->lo_encrypt_key_size) {
+		memcpy(lo->lo_encrypt_key, info->lo_encrypt_key, 
+		       info->lo_encrypt_key_size);
 		lo->lo_key_owner = current->uid; 
 	}	
 
 	return 0;
 }
 
-static int loop_get_status(struct loop_device *lo, struct loop_info *arg)
+static int
+loop_set_status_old(struct loop_device *lo, const struct loop_info *arg)
 {
-	struct file *file = lo->lo_backing_file;
 	struct loop_info info;
+	struct loop_info64 info64;
+
+	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
+		return -EFAULT;
+	info64.lo_number = info.lo_number;
+	info64.lo_device = info.lo_device;
+	info64.lo_inode = info.lo_inode;
+	info64.lo_rdevice = info.lo_rdevice;
+	info64.lo_offset = info.lo_offset;
+	info64.lo_encrypt_type = info.lo_encrypt_type;
+	info64.lo_encrypt_key_size = info.lo_encrypt_key_size;
+	info64.lo_flags = info.lo_flags;
+	info64.lo_init[0] = info.lo_init[0];
+	info64.lo_init[1] = info.lo_init[1];
+	memcpy(info64.lo_name, info.lo_name, LO_NAME_SIZE);
+	memcpy(info64.lo_encrypt_key, info.lo_encrypt_key, LO_KEY_SIZE);
+	return loop_set_status(lo, &info64);
+}
+
+static int
+loop_set_status64(struct loop_device *lo, const struct loop_info64 *arg)
+{
+	struct loop_info64 info64;
+
+	if (copy_from_user(&info64, arg, sizeof (struct loop_info64)))
+		return -EFAULT;
+	return loop_set_status(lo, &info64);
+}
+
+static int
+loop_get_status(struct loop_device *lo, struct loop_info64 *info)
+{
+	struct file *file = lo->lo_backing_file;
 	struct kstat stat;
 	int error;
 
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
-	if (!arg)
-		return -EINVAL;
 	error = vfs_getattr(file->f_vfsmnt, file->f_dentry, &stat);
 	if (error)
 		return error;
-	memset(&info, 0, sizeof(info));
-	info.lo_number = lo->lo_number;
-	info.lo_device = stat.dev;
-	info.lo_inode = stat.ino;
-	info.lo_rdevice = lo->lo_device ? stat.rdev : stat.dev;
-	info.lo_offset = lo->lo_offset;
-	info.lo_flags = lo->lo_flags;
-	strncpy(info.lo_name, lo->lo_name, LO_NAME_SIZE);
-	info.lo_encrypt_type = lo->lo_encrypt_type;
+	memset(info, 0, sizeof(*info));
+	info->lo_number = lo->lo_number;
+	info->lo_device = stat.dev;
+	info->lo_inode = stat.ino;
+	info->lo_rdevice = lo->lo_device ? stat.rdev : stat.dev;
+	info->lo_offset = lo->lo_offset;
+	info->lo_flags = lo->lo_flags;
+	strncpy(info->lo_name, lo->lo_name, LO_NAME_SIZE);
+	info->lo_encrypt_type = lo->lo_encrypt_type;
 	if (lo->lo_encrypt_key_size && capable(CAP_SYS_ADMIN)) {
-		info.lo_encrypt_key_size = lo->lo_encrypt_key_size;
-		memcpy(info.lo_encrypt_key, lo->lo_encrypt_key,
+		info->lo_encrypt_key_size = lo->lo_encrypt_key_size;
+		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
 		       lo->lo_encrypt_key_size);
 	}
-	return copy_to_user(arg, &info, sizeof(info)) ? -EFAULT : 0;
+	return 0;
+}
+
+static int
+loop_get_status_old(struct loop_device *lo, struct loop_info *arg) {
+	struct loop_info info;
+	struct loop_info64 info64;
+	int err;
+
+	err = loop_get_status(lo, &info64);
+	if (!err) {
+		info.lo_number = info64.lo_number;
+		info.lo_device = info64.lo_device;
+		info.lo_inode = info64.lo_inode;
+		info.lo_rdevice = info64.lo_rdevice;
+		info.lo_offset = info64.lo_offset;
+		info.lo_encrypt_type = info64.lo_encrypt_type;
+		info.lo_encrypt_key_size = info64.lo_encrypt_key_size;
+		info.lo_flags = info64.lo_flags;
+		info.lo_init[0] = info64.lo_init[0];
+		info.lo_init[1] = info64.lo_init[1];
+		memcpy(info.lo_name, info64.lo_name, LO_NAME_SIZE);
+		memcpy(info.lo_encrypt_key,info64.lo_encrypt_key,LO_KEY_SIZE);
+
+		if (info.lo_device != info64.lo_device ||
+		    info.lo_rdevice != info64.lo_rdevice)
+			err = -EOVERFLOW;
+	}
+
+	if (!err)
+		err = (!arg ? -EINVAL :
+		       copy_to_user(arg, &info, sizeof(info)) ? -EFAULT : 0);
+	return err;
+}
+
+static int
+loop_get_status64(struct loop_device *lo, struct loop_info64 *arg) {
+	struct loop_info64 info64;
+	int err;
+
+	err = loop_get_status(lo, &info64);
+	if (!err)
+		err = (!arg ? -EINVAL :
+		       copy_to_user(arg, &info64, sizeof(info64)) ? -EFAULT :
+		       0);
+	return err;
 }
 
 static int lo_ioctl(struct inode * inode, struct file * file,
@@ -922,10 +1002,16 @@
 		err = loop_clr_fd(lo, inode->i_bdev);
 		break;
 	case LOOP_SET_STATUS:
-		err = loop_set_status(lo, (struct loop_info *) arg);
+		err = loop_set_status_old(lo, (struct loop_info *) arg);
 		break;
 	case LOOP_GET_STATUS:
-		err = loop_get_status(lo, (struct loop_info *) arg);
+		err = loop_get_status_old(lo, (struct loop_info *) arg);
+		break;
+	case LOOP_SET_STATUS64:
+		err = loop_set_status64(lo, (struct loop_info64 *) arg);
+		break;
+	case LOOP_GET_STATUS64:
+		err = loop_get_status64(lo, (struct loop_info64 *) arg);
 		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
