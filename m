Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbTGBPHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTGBPHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:07:25 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16337 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265024AbTGBPHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:07:16 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 2 Jul 2003 17:21:37 +0200 (MEST)
Message-Id: <UTC200307021521.h62FLbw16702.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] cryptoloop
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 3 in the loop series.

It adds a module cryptoloop, with source file drivers/block/cryptoloop.c
and config option BLK_DEV_CRYPTOLOOP. It is the missing link between
the kernel crypto subdirectory and the loop device.
This means that one no longer needs kernel patches to use encryption
via the loop device. This goes together with mount and losetup from
util-linux 2.12 which will be released as soon as this goes in.

The configuration menu texts were shortened a bit. On the one hand
because the URLs were outdated. On the other hand, because such a
discussion is more appropriate for Documentation/loop.txt than for
a configuration menu.

There was an unfortunate clash between software that used lo_name
for the (possibly truncated) filename of the loop device -- of course
for informational purposes only --, and the software that used it
for the name of the crypto algorithm.  I separated both roles.

The cryptoloop code is basically that from hvr@gnu.org and
clemens@endorphin.org.

The unused char key_reserved[48] was removed.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/Kconfig b/drivers/block/Kconfig
--- a/drivers/block/Kconfig	Thu May 22 13:16:20 2003
+++ b/drivers/block/Kconfig	Wed Jul  2 16:45:41 2003
@@ -237,29 +237,20 @@
 	  root file system inside a DOS FAT file using this loop device
 	  driver.
 
-	  The loop device driver can also be used to "hide" a file system in a
-	  disk partition, floppy, or regular file, either using encryption
+	  To use the loop device, you need the losetup utility, found in the
+	  util-linux package, see
+	  <ftp://ftp.kernel.org/pub/linux/utils/util-linux/>.
+
+	  The loop device driver can also be used to "hide" a file system in
+	  a disk partition, floppy, or regular file, either using encryption
 	  (scrambling the data) or steganography (hiding the data in the low
 	  bits of, say, a sound file). This is also safe if the file resides
-	  on a remote file server. If you want to do this, you will first have
-	  to acquire and install a kernel patch from
-	  <ftp://ftp.kerneli.org/pub/kerneli/>, and then you need to
-	  say Y to this option.
-
-	  Note that alternative ways to use encrypted file systems are
-	  provided by the cfs package, which can be gotten from
-	  <ftp://ftp.kerneli.org/pub/kerneli/net-source/>, and the newer tcfs
-	  package, available at <http://tcfs.dia.unisa.it/>. You do not need
-	  to say Y here if you want to use one of these. However, using cfs
-	  requires saying Y to "NFS file system support" below while using
-	  tcfs requires applying a kernel patch. An alternative steganography
-	  solution is provided by StegFS, also available from
-	  <ftp://ftp.kerneli.org/pub/kerneli/net-source/>.
-
-	  To use the loop device, you need the losetup utility and a recent
-	  version of the mount program, both contained in the util-linux
-	  package. The location and current version number of util-linux is
-	  contained in the file <file:Documentation/Changes>.
+	  on a remote file server.
+
+	  There are several ways of doing this. Some of these require kernel
+	  patches. The vanilla kernel offers the cryptoloop option. If you
+	  want to use that, say Y to both LOOP and CRYPTOLOOP, and make sure
+	  you have a recent (version 2.12 or later) version of util-linux.
 
 	  Note that this loop device has nothing to do with the loopback
 	  device used for network connections from the machine to itself.
@@ -271,6 +262,14 @@
 
 	  Most users will answer N here.
 
+config BLK_DEV_CRYPTOLOOP
+	tristate "Cryptoloop Support"
+	depends on BLK_DEV_LOOP
+	---help---
+	  Say Y here if you want to be able to use the ciphers that are 
+	  provided by the CryptoAPI as loop transformation. This might be
+	  used as hard disk encryption.
+
 config BLK_DEV_NBD
 	tristate "Network block device support"
 	depends on NET
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/Makefile b/drivers/block/Makefile
--- a/drivers/block/Makefile	Thu May 22 13:16:20 2003
+++ b/drivers/block/Makefile	Wed Jul  2 17:38:52 2003
@@ -30,3 +30,4 @@
 
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
+obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
--- a/drivers/block/cryptoloop.c	Thu Jan  1 01:00:00 1970
+++ b/drivers/block/cryptoloop.c	Wed Jul  2 18:17:51 2003
@@ -0,0 +1,191 @@
+/*
+   Linux loop encryption enabling module
+
+   Copyright (C)  2002 Herbert Valerio Riedel <hvr@gnu.org>
+   Copyright (C)  2003 Fruhwirth Clemens <clemens@endorphin.org>
+
+   This module is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This module is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this module; if not, write to the Free Software
+   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/string.h>
+#include <linux/crypto.h>
+#include <linux/blkdev.h>
+#include <linux/loop.h>
+#include <linux/blk.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("loop blockdevice transferfunction adaptor / CryptoAPI");
+MODULE_AUTHOR("Herbert Valerio Riedel <hvr@gnu.org>");
+
+#define LOOP_IV_SECTOR_BITS 9
+#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
+
+static int
+cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
+{
+	int err = -EINVAL;
+	char cms[LO_NAME_SIZE];			/* cipher-mode string */
+	char *cipher;
+	char *mode;
+	char *cmsp = cms;			/* c-m string pointer */
+	struct crypto_tfm *tfm = NULL;
+
+	/* encryption breaks for non sector aligned offsets */
+
+	if (info->lo_offset % LOOP_IV_SECTOR_SIZE)
+		goto out;
+
+	strncpy(cms, info->lo_crypt_name, LO_NAME_SIZE);
+	cms[LO_NAME_SIZE - 1] = 0;
+	cipher = strsep(&cmsp, "-");
+	mode = strsep(&cmsp, "-");
+
+	if (mode == NULL || strcmp(mode, "cbc") == 0)
+		tfm = crypto_alloc_tfm(cipher, CRYPTO_TFM_MODE_CBC);
+	else if (strcmp(mode, "ecb") == 0)
+		tfm = crypto_alloc_tfm(cipher, CRYPTO_TFM_MODE_ECB);
+	if (tfm == NULL)
+		return -EINVAL;
+
+	err = tfm->crt_u.cipher.cit_setkey(tfm, info->lo_encrypt_key,
+					   info->lo_encrypt_key_size);
+	
+	if (err != 0)
+		goto out_free_tfm;
+
+	lo->key_data = tfm;
+	return 0;
+
+ out_free_tfm:
+	crypto_free_tfm(tfm);
+
+ out:
+	return err;
+}
+
+typedef int (*encdec_t)(struct crypto_tfm *tfm,
+			struct scatterlist *sg_out,
+			struct scatterlist *sg_in,
+			unsigned int nsg, u8 *iv);
+
+static int
+cryptoloop_transfer(struct loop_device *lo, int cmd, char *raw_buf,
+		     char *loop_buf, int size, sector_t IV)
+{
+	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
+	struct scatterlist sg_out = { 0, };
+	struct scatterlist sg_in = { 0, };
+
+	encdec_t encdecfunc;
+	char const *in;
+	char *out;
+
+	if (cmd == READ) {
+		in = raw_buf;
+		out = loop_buf;
+		encdecfunc = tfm->crt_u.cipher.cit_decrypt_iv;
+	} else {
+		in = loop_buf;
+		out = raw_buf;
+		encdecfunc = tfm->crt_u.cipher.cit_encrypt_iv;
+	}
+
+	while (size > 0) {
+		const int sz = min(size, LOOP_IV_SECTOR_SIZE);
+		u32 iv[4] = { 0, };
+		iv[0] = cpu_to_le32(IV & 0xffffffff);
+
+		sg_in.page = virt_to_page(in);
+		sg_in.offset = (unsigned long)in & ~PAGE_MASK;
+		sg_in.length = sz;
+
+		sg_out.page = virt_to_page(out);
+		sg_out.offset = (unsigned long)out & ~PAGE_MASK;
+		sg_out.length = sz;
+
+		encdecfunc(tfm, &sg_out, &sg_in, sz, (u8 *)iv);
+
+		IV++;
+		size -= sz;
+		in += sz;
+		out += sz;
+	}
+
+	return 0;
+}
+
+
+static int
+cryptoloop_ioctl(struct loop_device *lo, int cmd, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+static int
+cryptoloop_release(struct loop_device *lo)
+{
+	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
+	if (tfm != NULL) {
+		crypto_free_tfm(tfm);
+		lo->key_data = NULL;
+		return 0;
+	}
+	printk(KERN_ERR "cryptoloop_release(): tfm == NULL?\n");
+	return -EINVAL;
+}
+
+static struct loop_func_table cryptoloop_funcs = {
+	number:		LO_CRYPT_CRYPTOAPI,
+	init:		cryptoloop_init,
+	ioctl:		cryptoloop_ioctl,
+	transfer:	cryptoloop_transfer,
+	release:	cryptoloop_release,
+	owner:		THIS_MODULE
+};
+
+static int __init
+init_cryptoloop(void)
+{
+	int rc;
+
+	if ((rc = loop_register_transfer(&cryptoloop_funcs))) {
+		printk(KERN_ERR
+		       "cryptoloop: register loop transfer function failed\n");
+		return rc;
+	}
+
+	printk(KERN_INFO "cryptoloop: loaded\n");
+	return 0;
+}
+
+static void __exit
+cleanup_cryptoloop(void)
+{
+	if (loop_unregister_transfer(LO_CRYPT_CRYPTOAPI))
+		printk(KERN_ERR
+			"cryptoloop: unregistering transfer funcs failed\n");
+
+	printk(KERN_INFO "cryptoloop: unloaded\n");
+}
+
+module_init(init_cryptoloop);
+module_exit(cleanup_cryptoloop);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Wed Jul  2 16:22:55 2003
+++ b/drivers/block/loop.c	Wed Jul  2 16:45:41 2003
@@ -840,7 +840,8 @@
 	lo->lo_flags = 0;
 	lo->lo_queue.queuedata = NULL;
 	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
-	memset(lo->lo_name, 0, LO_NAME_SIZE);
+	memset(lo->lo_crypt_name, 0, LO_NAME_SIZE);
+	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
 	invalidate_bdev(bdev, 0);
 	set_capacity(disks[lo->lo_number], 0);
 	filp->f_dentry->d_inode->i_mapping->gfp_mask = gfp;
@@ -892,7 +893,10 @@
 			return -EFBIG;
 	}
 
-	strlcpy(lo->lo_name, info->lo_name, LO_NAME_SIZE);
+	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
+	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
+	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
+	lo->lo_crypt_name[LO_NAME_SIZE-1] = 0;
 
 	if (!xfer)
 		xfer = &none_funcs;
@@ -931,7 +935,8 @@
 	info->lo_offset = lo->lo_offset;
 	info->lo_sizelimit = lo->lo_sizelimit;
 	info->lo_flags = lo->lo_flags;
-	strlcpy(info->lo_name, lo->lo_name, LO_NAME_SIZE);
+	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
+	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
 	info->lo_encrypt_type =
 		lo->lo_encryption ? lo->lo_encryption->number : 0;
 	if (lo->lo_encrypt_key_size && capable(CAP_SYS_ADMIN)) {
@@ -957,7 +962,10 @@
 	info64->lo_flags = info->lo_flags;
 	info64->lo_init[0] = info->lo_init[0];
 	info64->lo_init[1] = info->lo_init[1];
-	memcpy(info64->lo_name, info->lo_name, LO_NAME_SIZE);
+	if (info->lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
+		memcpy(info64->lo_crypt_name, info->lo_name, LO_NAME_SIZE);
+	else
+		memcpy(info64->lo_file_name, info->lo_name, LO_NAME_SIZE);
 	memcpy(info64->lo_encrypt_key, info->lo_encrypt_key, LO_KEY_SIZE);
 }
 
@@ -975,8 +983,11 @@
 	info->lo_flags = info64->lo_flags;
 	info->lo_init[0] = info64->lo_init[0];
 	info->lo_init[1] = info64->lo_init[1];
-	memcpy(info->lo_name, info64->lo_name, LO_NAME_SIZE);
-	memcpy(info->lo_encrypt_key,info64->lo_encrypt_key,LO_KEY_SIZE);
+	if (info->lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
+		memcpy(info->lo_name, info64->lo_crypt_name, LO_NAME_SIZE);
+	else
+		memcpy(info->lo_name, info64->lo_file_name, LO_NAME_SIZE);
+	memcpy(info->lo_encrypt_key, info64->lo_encrypt_key, LO_KEY_SIZE);
 
 	/* error in case values were truncated */
 	if (info->lo_device != info64->lo_device ||
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/loop.h b/include/linux/loop.h
--- a/include/linux/loop.h	Wed Jul  2 16:23:00 2003
+++ b/include/linux/loop.h	Wed Jul  2 16:45:41 2003
@@ -36,7 +36,8 @@
 	int		(*transfer)(struct loop_device *, int cmd,
 				    char *raw_buf, char *loop_buf, int size,
 				    sector_t real_block);
-	char		lo_name[LO_NAME_SIZE];
+	char		lo_file_name[LO_NAME_SIZE];
+	char		lo_crypt_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	int		lo_encrypt_key_size;
 	struct loop_func_table *lo_encryption;
@@ -49,7 +50,6 @@
 	struct block_device *lo_device;
 	unsigned	lo_blocksize;
 	void		*key_data; 
-	char		key_reserved[48]; /* for use by the filter modules */
 
 	int		old_gfp_mask;
 
@@ -102,7 +102,8 @@
 	__u32		   lo_encrypt_type;
 	__u32		   lo_encrypt_key_size;		/* ioctl w/o */
 	__u32		   lo_flags;			/* ioctl r/o */
-	__u8		   lo_name[LO_NAME_SIZE];
+	__u8		   lo_file_name[LO_NAME_SIZE];
+	__u8		   lo_crypt_name[LO_NAME_SIZE];
 	__u8		   lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
 	__u64		   lo_init[2];
 };
