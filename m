Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbTDQXXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbTDQXXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:23:12 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22665 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262713AbTDQXWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:22:50 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 18 Apr 2003 01:34:42 +0200 (MEST)
Message-Id: <UTC200304172334.h3HNYgI06614.aeb@smtp.cwi.nl>
To: akpm@digeo.com, torvalds@transmeta.com
Subject: [PATCH] struct loop_info
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Until now as the source already says, we had a very unpleasant
situation with struct loop_info:

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
- *     This uses kdev_t because glibc currently has no appropiate
- *     conversion version for the loop ioctls. 
- *     The situation is very unpleasant        
- */

In the patch below I remove the definition for this struct from
<linux/loop.h> and put it in <asm/loopinfo.h>.
In this struct the occurrences of dev_t have been replaced by their
actual values (short int / int / long int).

This part of the patch ends the unpleasant situation: userspace
can use this definition without gymnastics like

#include <linux/posix_types.h>
#undef dev_t
#define dev_t __kernel_dev_t
#include <linux/loop.h>
#undef dev_t


The second part of this patch adds a new struct loop_info2
in <linux/loop.h> identical to the old struct but with
unsigned long long instead of dev_t.
Now kernel and userspace use the same struct, simplifying life.

Unfortunately for compatibility some translation between
loop_info and loop_info2 is required.

Andries

---------------------------------------------------------------
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Tue Mar 25 04:54:31 2003
+++ b/drivers/block/loop.c	Fri Apr 18 00:57:31 2003
@@ -120,13 +120,13 @@
 	return 0;
 }
 
-static int none_status(struct loop_device *lo, struct loop_info *info)
+static int none_status(struct loop_device *lo, const struct loop_info2 *info)
 {
 	lo->lo_flags |= LO_FLAGS_BH_REMAP;
 	return 0;
 }
 
-static int xor_status(struct loop_device *lo, struct loop_info *info)
+static int xor_status(struct loop_device *lo, const struct loop_info2 *info)
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
+loop_init_xfer(struct loop_device *lo, int type, const struct loop_info2 *i)
 {
 	int err = 0; 
 	if (type) {
@@ -822,9 +828,9 @@
 	return 0;
 }
 
-static int loop_set_status(struct loop_device *lo, struct loop_info *arg)
+static int
+loop_set_status(struct loop_device *lo, const struct loop_info2 *info)
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
@@ -860,51 +864,126 @@
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
+loop_set_status1(struct loop_device *lo, const struct loop_info *arg)
 {
-	struct file *file = lo->lo_backing_file;
 	struct loop_info info;
+	struct loop_info2 info2;
+
+	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
+		return -EFAULT;
+	info2.lo_number = info.lo_number;
+	info2.lo_device = info.lo_device;
+	info2.lo_inode = info.lo_inode;
+	info2.lo_rdevice = info.lo_rdevice;
+	info2.lo_offset = info.lo_offset;
+	info2.lo_encrypt_type = info.lo_encrypt_type;
+	info2.lo_encrypt_key_size = info.lo_encrypt_key_size;
+	info2.lo_flags = info.lo_flags;
+	info2.lo_init[0] = info.lo_init[0];
+	info2.lo_init[1] = info.lo_init[1];
+	memcpy(info2.lo_name, info.lo_name, LO_NAME_SIZE);
+	memcpy(info2.lo_encrypt_key, info.lo_encrypt_key, LO_KEY_SIZE);
+	return loop_set_status(lo, &info2);
+}
+
+static int
+loop_set_status2(struct loop_device *lo, const struct loop_info2 *arg)
+{
+	struct loop_info2 info2;
+
+	if (copy_from_user(&info2, arg, sizeof (struct loop_info2)))
+		return -EFAULT;
+	return loop_set_status(lo, &info2);
+}
+
+static int
+loop_get_status(struct loop_device *lo, struct loop_info2 *info)
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
+loop_get_status1(struct loop_device *lo, struct loop_info *arg) {
+	struct loop_info info;
+	struct loop_info2 info2;
+	int err;
+
+	err = loop_get_status(lo, &info2);
+	if (!err) {
+		info.lo_number = info2.lo_number;
+		info.lo_device = info2.lo_device;
+		info.lo_inode = info2.lo_inode;
+		info.lo_rdevice = info2.lo_rdevice;
+		info.lo_offset = info2.lo_offset;
+		info.lo_encrypt_type = info2.lo_encrypt_type;
+		info.lo_encrypt_key_size = info2.lo_encrypt_key_size;
+		info.lo_flags = info2.lo_flags;
+		info.lo_init[0] = info2.lo_init[0];
+		info.lo_init[1] = info2.lo_init[1];
+		memcpy(info.lo_name, info2.lo_name, LO_NAME_SIZE);
+		memcpy(info.lo_encrypt_key, info2.lo_encrypt_key, LO_KEY_SIZE);
+
+		if (info.lo_device != info2.lo_device ||
+		    info.lo_rdevice != info2.lo_rdevice)
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
+loop_get_status2(struct loop_device *lo, struct loop_info2 *arg) {
+	struct loop_info2 info2;
+	int err;
+
+	err = loop_get_status(lo, &info2);
+	if (!err)
+		err = (!arg ? -EINVAL :
+		       copy_to_user(arg, &info2, sizeof(info2)) ? -EFAULT : 0);
+	return err;
 }
 
 static int lo_ioctl(struct inode * inode, struct file * file,
@@ -922,10 +1001,16 @@
 		err = loop_clr_fd(lo, inode->i_bdev);
 		break;
 	case LOOP_SET_STATUS:
-		err = loop_set_status(lo, (struct loop_info *) arg);
+		err = loop_set_status1(lo, (struct loop_info *) arg);
 		break;
 	case LOOP_GET_STATUS:
-		err = loop_get_status(lo, (struct loop_info *) arg);
+		err = loop_get_status1(lo, (struct loop_info *) arg);
+		break;
+	case LOOP_SET_STATUS2:
+		err = loop_set_status2(lo, (struct loop_info2 *) arg);
+		break;
+	case LOOP_GET_STATUS2:
+		err = loop_get_status2(lo, (struct loop_info2 *) arg);
 		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-alpha/loopinfo.h b/include/asm-alpha/loopinfo.h
--- a/include/asm-alpha/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-alpha/loopinfo.h	Thu Apr 17 23:48:34 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_ALPHA_LOOP_H
+#define _ASM_ALPHA_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned int	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned int	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-arm/loopinfo.h b/include/asm-arm/loopinfo.h
--- a/include/asm-arm/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-arm/loopinfo.h	Thu Apr 17 23:48:54 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_ARM_LOOP_H
+#define _ASM_ARM_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned short	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned short	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-cris/loopinfo.h b/include/asm-cris/loopinfo.h
--- a/include/asm-cris/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-cris/loopinfo.h	Thu Apr 17 23:49:07 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_CRIS_LOOP_H
+#define _ASM_CRIS_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned short	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned short	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-i386/loopinfo.h b/include/asm-i386/loopinfo.h
--- a/include/asm-i386/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-i386/loopinfo.h	Thu Apr 17 23:06:15 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_I386_LOOP_H
+#define _ASM_I386_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned short	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned short	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ia64/loopinfo.h b/include/asm-ia64/loopinfo.h
--- a/include/asm-ia64/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-ia64/loopinfo.h	Thu Apr 17 23:49:39 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_IA64_LOOP_H
+#define _ASM_IA64_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned int	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned int	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-m68k/loopinfo.h b/include/asm-m68k/loopinfo.h
--- a/include/asm-m68k/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-m68k/loopinfo.h	Thu Apr 17 23:07:18 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_M68K_LOOP_H
+#define _ASM_M68K_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned short	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned short	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-m68knommu/loopinfo.h b/include/asm-m68knommu/loopinfo.h
--- a/include/asm-m68knommu/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-m68knommu/loopinfo.h	Thu Apr 17 23:56:34 2003
@@ -0,0 +1 @@
+#include <asm-m68k/loopinfo.h>
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-mips/loopinfo.h b/include/asm-mips/loopinfo.h
--- a/include/asm-mips/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-mips/loopinfo.h	Thu Apr 17 23:09:44 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_MIPS_LOOP_H
+#define _ASM_MIPS_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned int	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned int	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-mips64/loopinfo.h b/include/asm-mips64/loopinfo.h
--- a/include/asm-mips64/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-mips64/loopinfo.h	Thu Apr 17 23:10:17 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_MIPS64_LOOP_H
+#define _ASM_MIPS64_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned int	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned int	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-parisc/loopinfo.h b/include/asm-parisc/loopinfo.h
--- a/include/asm-parisc/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-parisc/loopinfo.h	Thu Apr 17 23:10:36 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_PARISC_LOOP_H
+#define _ASM_PARISC_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned int	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned int	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ppc/loopinfo.h b/include/asm-ppc/loopinfo.h
--- a/include/asm-ppc/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-ppc/loopinfo.h	Thu Apr 17 23:11:14 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_PPC_LOOP_H
+#define _ASM_PPC_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned int	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned int	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ppc64/loopinfo.h b/include/asm-ppc64/loopinfo.h
--- a/include/asm-ppc64/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-ppc64/loopinfo.h	Thu Apr 17 23:12:15 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_PPC64_LOOP_H
+#define _ASM_PPC64_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned long	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned long	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-s390/loopinfo.h b/include/asm-s390/loopinfo.h
--- a/include/asm-s390/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-s390/loopinfo.h	Thu Apr 17 23:12:58 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_S390_LOOP_H
+#define _ASM_S390_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned short	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned short	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-s390x/loopinfo.h b/include/asm-s390x/loopinfo.h
--- a/include/asm-s390x/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-s390x/loopinfo.h	Thu Apr 17 23:13:21 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_S390X_LOOP_H
+#define _ASM_S390X_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned int	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned int	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sh/loopinfo.h b/include/asm-sh/loopinfo.h
--- a/include/asm-sh/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-sh/loopinfo.h	Thu Apr 17 23:14:14 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_SH_LOOP_H
+#define _ASM_SH_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned short	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned short	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sparc/loopinfo.h b/include/asm-sparc/loopinfo.h
--- a/include/asm-sparc/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-sparc/loopinfo.h	Thu Apr 17 23:52:04 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_SPARC_LOOP_H
+#define _ASM_SPARC_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned short	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned short	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sparc64/loopinfo.h b/include/asm-sparc64/loopinfo.h
--- a/include/asm-sparc64/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-sparc64/loopinfo.h	Thu Apr 17 23:15:03 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_SPARC64_LOOP_H
+#define _ASM_SPARC64_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned int	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned int	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-um/loopinfo.h b/include/asm-um/loopinfo.h
--- a/include/asm-um/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-um/loopinfo.h	Thu Apr 17 23:46:33 2003
@@ -0,0 +1,6 @@
+#ifndef _UM_LOOP_H
+#define _UM_LOOP_H
+
+#include "asm/arch/loopinfo.h"
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-v850/loopinfo.h b/include/asm-v850/loopinfo.h
--- a/include/asm-v850/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-v850/loopinfo.h	Thu Apr 17 23:47:11 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_V850_LOOP_H
+#define _ASM_V850_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned int	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned int	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-x86_64/loopinfo.h b/include/asm-x86_64/loopinfo.h
--- a/include/asm-x86_64/loopinfo.h	Thu Jan  1 01:00:00 1970
+++ b/include/asm-x86_64/loopinfo.h	Thu Apr 17 23:47:49 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_X86_64_LOOP_H
+#define _ASM_X86_64_LOOP_H
+
+#define LO_NAME_SIZE	64
+#define LO_KEY_SIZE	32
+
+struct loop_info {
+	int		lo_number;	/* ioctl r/o */
+	unsigned long	lo_device; 	/* ioctl r/o */
+	unsigned long	lo_inode; 	/* ioctl r/o */
+	unsigned long	lo_rdevice; 	/* ioctl r/o */
+	int		lo_offset;
+	int		lo_encrypt_type;
+	int		lo_encrypt_key_size; 	/* ioctl w/o */
+	int		lo_flags;		/* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned long	lo_init[2];
+	char		reserved[4];
+};
+
+#endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/loop.h b/include/linux/loop.h
--- a/include/linux/loop.h	Fri Nov 22 22:41:13 2002
+++ b/include/linux/loop.h	Fri Apr 18 00:32:53 2003
@@ -1,8 +1,6 @@
 #ifndef _LINUX_LOOP_H
 #define _LINUX_LOOP_H
 
-#include <linux/kdev_t.h>
-
 /*
  * include/linux/loop.h
  *
@@ -74,34 +72,21 @@
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
+#include <asm/loopinfo.h>	/* for struct loop_info */
 
-struct loop_info {
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
+struct loop_info2 {
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
@@ -125,7 +110,7 @@
 	int number; 	/* filter type */ 
 	int (*transfer)(struct loop_device *lo, int cmd, char *raw_buf,
 			char *loop_buf, int size, sector_t real_block);
-	int (*init)(struct loop_device *, struct loop_info *); 
+	int (*init)(struct loop_device *, const struct loop_info2 *); 
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *); 
 	int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
@@ -134,7 +119,7 @@
 	void (*unlock)(struct loop_device *);
 }; 
 
-int  loop_register_transfer(struct loop_func_table *funcs);
+int loop_register_transfer(struct loop_func_table *funcs);
 int loop_unregister_transfer(int number); 
 
 #endif
@@ -142,9 +127,11 @@
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
+#define LOOP_SET_STATUS2	0x4C04
+#define LOOP_GET_STATUS2	0x4C05
 
 #endif
