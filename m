Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUGUUSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUGUUSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUGUUSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:18:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55007 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266615AbUGUURP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:17:15 -0400
Date: Wed, 21 Jul 2004 16:16:34 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Delete cryptoloop
Message-ID: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch deletes cryptoloop, which is buggy, unmaintained, and
reportedly has mutliple security weaknesses. Dropping cryptoloop should
also help dm-crypt receive more testing and review.

I haven't updated the defconfigs, is this something for arch maintainers 
to manage?

 drivers/block/Kconfig      |   22 ---
 drivers/block/Makefile     |    1 
 drivers/block/cryptoloop.c |  268 
---------------------------------------------
 3 files changed, 2 insertions(+), 289 deletions(-)


diff -urN a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
--- a/drivers/block/cryptoloop.c	2004-07-21 15:40:46.000000000 -0400
+++ b/drivers/block/cryptoloop.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,268 +0,0 @@
-/*
-   Linux loop encryption enabling module
-
-   Copyright (C)  2002 Herbert Valerio Riedel <hvr@gnu.org>
-   Copyright (C)  2003 Fruhwirth Clemens <clemens@endorphin.org>
-
-   This module is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-
-   This module is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this module; if not, write to the Free Software
-   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/module.h>
-
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/crypto.h>
-#include <linux/blkdev.h>
-#include <linux/loop.h>
-#include <asm/semaphore.h>
-#include <asm/uaccess.h>
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("loop blockdevice transferfunction adaptor / CryptoAPI");
-MODULE_AUTHOR("Herbert Valerio Riedel <hvr@gnu.org>");
-
-#define LOOP_IV_SECTOR_BITS 9
-#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
-
-static int
-cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
-{
-	int err = -EINVAL;
-	char cms[LO_NAME_SIZE];			/* cipher-mode string */
-	char *cipher;
-	char *mode;
-	char *cmsp = cms;			/* c-m string pointer */
-	struct crypto_tfm *tfm = NULL;
-
-	/* encryption breaks for non sector aligned offsets */
-
-	if (info->lo_offset % LOOP_IV_SECTOR_SIZE)
-		goto out;
-
-	strncpy(cms, info->lo_crypt_name, LO_NAME_SIZE);
-	cms[LO_NAME_SIZE - 1] = 0;
-	cipher = strsep(&cmsp, "-");
-	mode = strsep(&cmsp, "-");
-
-	if (mode == NULL || strcmp(mode, "cbc") == 0)
-		tfm = crypto_alloc_tfm(cipher, CRYPTO_TFM_MODE_CBC);
-	else if (strcmp(mode, "ecb") == 0)
-		tfm = crypto_alloc_tfm(cipher, CRYPTO_TFM_MODE_ECB);
-	if (tfm == NULL)
-		return -EINVAL;
-
-	err = tfm->crt_u.cipher.cit_setkey(tfm, info->lo_encrypt_key,
-					   info->lo_encrypt_key_size);
-	
-	if (err != 0)
-		goto out_free_tfm;
-
-	lo->key_data = tfm;
-	return 0;
-
- out_free_tfm:
-	crypto_free_tfm(tfm);
-
- out:
-	return err;
-}
-
-
-typedef int (*encdec_ecb_t)(struct crypto_tfm *tfm,
-			struct scatterlist *sg_out,
-			struct scatterlist *sg_in,
-			unsigned int nsg);
-
-
-static int
-cryptoloop_transfer_ecb(struct loop_device *lo, int cmd,
-			struct page *raw_page, unsigned raw_off,
-			struct page *loop_page, unsigned loop_off,
-			int size, sector_t IV)
-{
-	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
-	struct scatterlist sg_out = { NULL, };
-	struct scatterlist sg_in = { NULL, };
-
-	encdec_ecb_t encdecfunc;
-	struct page *in_page, *out_page;
-	unsigned in_offs, out_offs;
-
-	if (cmd == READ) {
-		in_page = raw_page;
-		in_offs = raw_off;
-		out_page = loop_page;
-		out_offs = loop_off;
-		encdecfunc = tfm->crt_u.cipher.cit_decrypt;
-	} else {
-		in_page = loop_page;
-		in_offs = loop_off;
-		out_page = raw_page;
-		out_offs = raw_off;
-		encdecfunc = tfm->crt_u.cipher.cit_encrypt;
-	}
-
-	while (size > 0) {
-		const int sz = min(size, LOOP_IV_SECTOR_SIZE);
-
-		sg_in.page = in_page;
-		sg_in.offset = in_offs;
-		sg_in.length = sz;
-
-		sg_out.page = out_page;
-		sg_out.offset = out_offs;
-		sg_out.length = sz;
-
-		encdecfunc(tfm, &sg_out, &sg_in, sz);
-
-		size -= sz;
-		in_offs += sz;
-		out_offs += sz;
-	}
-
-	return 0;
-}
-
-typedef int (*encdec_cbc_t)(struct crypto_tfm *tfm,
-			struct scatterlist *sg_out,
-			struct scatterlist *sg_in,
-			unsigned int nsg, u8 *iv);
-
-static int
-cryptoloop_transfer_cbc(struct loop_device *lo, int cmd,
-			struct page *raw_page, unsigned raw_off,
-			struct page *loop_page, unsigned loop_off,
-			int size, sector_t IV)
-{
-	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
-	struct scatterlist sg_out = { NULL, };
-	struct scatterlist sg_in = { NULL, };
-
-	encdec_cbc_t encdecfunc;
-	struct page *in_page, *out_page;
-	unsigned in_offs, out_offs;
-
-	if (cmd == READ) {
-		in_page = raw_page;
-		in_offs = raw_off;
-		out_page = loop_page;
-		out_offs = loop_off;
-		encdecfunc = tfm->crt_u.cipher.cit_decrypt_iv;
-	} else {
-		in_page = loop_page;
-		in_offs = loop_off;
-		out_page = raw_page;
-		out_offs = raw_off;
-		encdecfunc = tfm->crt_u.cipher.cit_encrypt_iv;
-	}
-
-	while (size > 0) {
-		const int sz = min(size, LOOP_IV_SECTOR_SIZE);
-		u32 iv[4] = { 0, };
-		iv[0] = cpu_to_le32(IV & 0xffffffff);
-
-		sg_in.page = in_page;
-		sg_in.offset = in_offs;
-		sg_in.length = sz;
-
-		sg_out.page = out_page;
-		sg_out.offset = out_offs;
-		sg_out.length = sz;
-
-		encdecfunc(tfm, &sg_out, &sg_in, sz, (u8 *)iv);
-
-		IV++;
-		size -= sz;
-		in_offs += sz;
-		out_offs += sz;
-	}
-
-	return 0;
-}
-
-static int
-cryptoloop_transfer(struct loop_device *lo, int cmd,
-		    struct page *raw_page, unsigned raw_off,
-		    struct page *loop_page, unsigned loop_off,
-		    int size, sector_t IV)
-{
-	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
-	if(tfm->crt_cipher.cit_mode == CRYPTO_TFM_MODE_ECB)
-	{
-		lo->transfer = cryptoloop_transfer_ecb;
-		return cryptoloop_transfer_ecb(lo, cmd, raw_page, raw_off,
-					       loop_page, loop_off, size, IV);
-	}	
-	if(tfm->crt_cipher.cit_mode == CRYPTO_TFM_MODE_CBC)
-	{	
-		lo->transfer = cryptoloop_transfer_cbc;
-		return cryptoloop_transfer_cbc(lo, cmd, raw_page, raw_off,
-					       loop_page, loop_off, size, IV);
-	}
-	
-	/*  This is not supposed to happen */
-
-	printk( KERN_ERR "cryptoloop: unsupported cipher mode in cryptoloop_transfer!\n");
-	return -EINVAL;
-}
-
-static int
-cryptoloop_ioctl(struct loop_device *lo, int cmd, unsigned long arg)
-{
-	return -EINVAL;
-}
-
-static int
-cryptoloop_release(struct loop_device *lo)
-{
-	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
-	if (tfm != NULL) {
-		crypto_free_tfm(tfm);
-		lo->key_data = NULL;
-		return 0;
-	}
-	printk(KERN_ERR "cryptoloop_release(): tfm == NULL?\n");
-	return -EINVAL;
-}
-
-static struct loop_func_table cryptoloop_funcs = {
-	.number = LO_CRYPT_CRYPTOAPI,
-	.init = cryptoloop_init,
-	.ioctl = cryptoloop_ioctl,
-	.transfer = cryptoloop_transfer,
-	.release = cryptoloop_release,
-	.owner = THIS_MODULE
-};
-
-static int __init
-init_cryptoloop(void)
-{
-	int rc = loop_register_transfer(&cryptoloop_funcs);
-
-	if (rc)
-		printk(KERN_ERR "cryptoloop: loop_register_transfer failed\n");
-	return rc;
-}
-
-static void __exit
-cleanup_cryptoloop(void)
-{
-	if (loop_unregister_transfer(LO_CRYPT_CRYPTOAPI))
-		printk(KERN_ERR
-			"cryptoloop: loop_unregister_transfer failed\n");
-}
-
-module_init(init_cryptoloop);
-module_exit(cleanup_cryptoloop);
diff -urN a/drivers/block/Kconfig b/drivers/block/Kconfig
--- a/drivers/block/Kconfig	2004-07-21 15:40:46.000000000 -0400
+++ b/drivers/block/Kconfig	2004-07-21 15:53:02.000000000 -0400
@@ -229,12 +229,8 @@
 	  on a remote file server.
 
 	  There are several ways of encrypting disks. Some of these require
-	  kernel patches. The vanilla kernel offers the cryptoloop option
-	  and a Device Mapper target (which is superior, as it supports all
-	  file systems). If you want to use the cryptoloop, say Y to both
-	  LOOP and CRYPTOLOOP, and make sure you have a recent (version 2.12
-	  or later) version of util-linux. Additionally, be aware that
-	  the cryptoloop is not safe for storing journaled filesystems.
+	  kernel patches. The vanilla kernel offers a Device Mapper target
+	  which supports all file systems.
 
 	  Note that this loop device has nothing to do with the loopback
 	  device used for network connections from the machine to itself.
@@ -244,20 +240,6 @@
 
 	  Most users will answer N here.
 
-config BLK_DEV_CRYPTOLOOP
-	tristate "Cryptoloop Support"
-	select CRYPTO
-	depends on BLK_DEV_LOOP
-	---help---
-	  Say Y here if you want to be able to use the ciphers that are 
-	  provided by the CryptoAPI as loop transformation. This might be
-	  used as hard disk encryption.
-
-	  WARNING: This device is not safe for journaled file systems like
-	  ext3 or Reiserfs. Please use the Device Mapper crypto module
-	  instead, which can be configured to be on-disk compatible with the
-	  cryptoloop device.
-
 config BLK_DEV_NBD
 	tristate "Network block device support"
 	depends on NET
diff -urN a/drivers/block/Makefile b/drivers/block/Makefile
--- a/drivers/block/Makefile	2004-07-21 15:40:46.000000000 -0400
+++ b/drivers/block/Makefile	2004-07-21 15:53:41.000000000 -0400
@@ -38,7 +38,6 @@
 
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
-obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
 
 obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
