Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270845AbTG0QRO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270851AbTG0QRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:17:14 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:52936 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S270845AbTG0QRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:17:11 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CvhCMv4UCr"
Content-Transfer-Encoding: 7bit
Date: Sun, 27 Jul 2003 18:33:43 +0200
From: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Data corruption with cryptoloop, 2.6.0-test1
Message-Id: <20030727163223.B2BD44002C7@mwinf0501.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CvhCMv4UCr
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

linux-2.6.0-test1, util-linux-2.12, RedHat 9, i386.

The script below demonstrates data corruption when transfering
large files (larger than physical RAM) with cryptoloop and AES.
Individual bytes are altered on 512-byte boundaries.

The problem occurs:
- when the encrypted filesystem is ext2/ext3/jf, but not msdos/vfat.
- with swap disabled
- with crypto_yield() disabled
- with cipher_null instead of AES (after patching crypto_null.c).

This looks like a race condition between flushing and loops.
Could someone confirm this ?

Pascal


--CvhCMv4UCr
Content-Type: text/plain
Content-Disposition: inline;
	filename="cryptoloop-test.sh"
Content-Transfer-Encoding: 7bit

#!/bin/sh

echo "Data will be destroyed. Please edit this script first."
exit 1

SIZE=256                      # Set this to more than physical RAM (MB).
FS=/dev/hda10
# FS=/tmp/cryptoloop-test.fs  # No corruption with file-backed loops.
FSTYPE=ext2
LOOP=/dev/loop10
MOUNT=/tmp/cryptoloop-test
DATA=/dev/zero
CIPHER=aes
# CIPHER=cipher_null          #  Must fix crypto_null.c first.

modprobe cryptoloop
modprobe crypto_null
modprobe aes

[ -b $FS ]  ||  dd if=/dev/zero of=$FS bs=1M count=$((SIZE+10))
echo 0123456789ABCDEF  |  losetup -p 0 -e $CIPHER $LOOP $FS  ||  exit 1
mkfs -t $FSTYPE $LOOP  ||  exit 1
mkdir -p $MOUNT
mount -t $FSTYPE $LOOP $MOUNT  ||  exit 1

dd if=$DATA bs=1M count=$SIZE of=$MOUNT/x 
hexdump $MOUNT/x  |  head

# Result (should be all 0000):
#
# 0000000 0000 0000 0000 0000 0000 0000 0000 0000
# *
# 0010000 00e0 0000 0000 0000 0000 0000 0000 0000
# 0010010 0000 0000 0000 0000 0000 0000 0000 0000
# *
# 0010200 00e0 0000 0000 0000 0000 0000 0000 0000
# 0010210 0000 0000 0000 0000 0000 0000 0000 0000
# *
# 0010400 00e0 0000 0000 0000 0000 0000 0000 0000
# 0010410 0000 0000 0000 0000 0000 0000 0000 0000

umount $MOUNT
losetup -d $LOOP
[ -b $FS ]  ||  rm $FS


--CvhCMv4UCr
Content-Type: text/plain
Content-Disposition: inline;
	filename="crypto_null.c.patch"
Content-Transfer-Encoding: 7bit

diff -ru linux-2.6.0-test1.orig/crypto/crypto_null.c linux-2.6.0-test1/crypto/crypto_null.c
--- linux-2.6.0-test1.orig/crypto/crypto_null.c	2003-07-14 05:33:47.000000000 +0200
+++ linux-2.6.0-test1/crypto/crypto_null.c	2003-07-28 18:07:34.000000000 +0200
@@ -22,8 +22,9 @@
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
 
-#define NULL_KEY_SIZE		0
-#define NULL_BLOCK_SIZE		1
+#define NULL_MIN_KEY_SIZE	0
+#define NULL_MAX_KEY_SIZE	32   /* losetup always uses LO_KEY_SIZE */
+#define NULL_BLOCK_SIZE		8 /* Prevents oops in cryptoloop ? */
 #define NULL_DIGEST_SIZE	0
 
 static int null_compress(void *ctx, const u8 *src, unsigned int slen,
@@ -48,10 +49,10 @@
 { return 0; }
 
 static void null_encrypt(void *ctx, u8 *dst, const u8 *src)
-{ }
+{ memcpy(dst, src, NULL_BLOCK_SIZE); }
 
 static void null_decrypt(void *ctx, u8 *dst, const u8 *src)
-{ }
+{ memcpy(dst, src, NULL_BLOCK_SIZE); }
 
 static struct crypto_alg compress_null = {
 	.cra_name		=	"compress_null",
@@ -87,9 +88,9 @@
 	.cra_module		=	THIS_MODULE,
 	.cra_list		=	LIST_HEAD_INIT(cipher_null.cra_list),
 	.cra_u			=	{ .cipher = {
-	.cia_min_keysize	=	NULL_KEY_SIZE,
-	.cia_max_keysize	=	NULL_KEY_SIZE,
-	.cia_ivsize		=	0,
+	.cia_min_keysize	=	NULL_MIN_KEY_SIZE,
+	.cia_max_keysize	=	NULL_MAX_KEY_SIZE,
+	.cia_ivsize		=	8,  /* Prevents oops in cryptoloop ? */
 	.cia_setkey		= 	null_setkey,
 	.cia_encrypt		=	null_encrypt,
 	.cia_decrypt		=	null_decrypt } }



--CvhCMv4UCr--

