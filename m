Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWJRQmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWJRQmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWJRQmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:42:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:61446 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422676AbWJRQmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:42:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=iBu1r/XIzEFmwRutgB9yn/c6ayzxKMEQXfkam0JZtiuDZqMyrWCOEHgsCd9n9lkdoP613/DmVSTjhdFGTWaaAbnBk6/d0NmJtEKCQKgri454njltJ0R2JC8Qb2cHEju2aqEwagEp0BXa1EVV0GCvW2kuzV5+LV1sny2ds88yxJ8=
Date: Thu, 19 Oct 2006 01:42:23 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Matt Domsch <Matt_Domsch@dell.com>
Subject: [PATCH 2/6] crc32: replace bitreverse by bitrev32
Message-ID: <20061018164223.GB21820@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Matt Domsch <Matt_Domsch@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces bitreverse() by bitrev32.
The only users of bitreverse() are crc32 itself and via-velocity.

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/net/via-velocity.c |    2 +-
 include/linux/crc32.h      |    4 ++--
 lib/Kconfig                |    1 +
 lib/crc32.c                |   28 +++++-----------------------
 4 files changed, 9 insertions(+), 26 deletions(-)

Index: work-fault-inject/drivers/net/via-velocity.c
===================================================================
--- work-fault-inject.orig/drivers/net/via-velocity.c
+++ work-fault-inject/drivers/net/via-velocity.c
@@ -3132,7 +3132,7 @@ static u16 wol_calc_crc(int size, u8 * p
 	}
 	/*	Finally, invert the result once to get the correct data */
 	crc = ~crc;
-	return bitreverse(crc) >> 16;
+	return bitrev32(crc) >> 16;
 }
 
 /**
Index: work-fault-inject/include/linux/crc32.h
===================================================================
--- work-fault-inject.orig/include/linux/crc32.h
+++ work-fault-inject/include/linux/crc32.h
@@ -6,10 +6,10 @@
 #define _LINUX_CRC32_H
 
 #include <linux/types.h>
+#include <linux/bitrev.h>
 
 extern u32  crc32_le(u32 crc, unsigned char const *p, size_t len);
 extern u32  crc32_be(u32 crc, unsigned char const *p, size_t len);
-extern u32  bitreverse(u32 in);
 
 #define crc32(seed, data, length)  crc32_le(seed, (unsigned char const *)data, length)
 
@@ -21,7 +21,7 @@ extern u32  bitreverse(u32 in);
  * is in bit nr 0], thus it must be reversed before use. Except for
  * nics that bit swap the result internally...
  */
-#define ether_crc(length, data)    bitreverse(crc32_le(~0, data, length))
+#define ether_crc(length, data)    bitrev32(crc32_le(~0, data, length))
 #define ether_crc_le(length, data) crc32_le(~0, data, length)
 
 #endif /* _LINUX_CRC32_H */
Index: work-fault-inject/lib/Kconfig
===================================================================
--- work-fault-inject.orig/lib/Kconfig
+++ work-fault-inject/lib/Kconfig
@@ -26,6 +26,7 @@ config CRC16
 config CRC32
 	tristate "CRC32 functions"
 	default y
+	select BITREVERSE
 	help
 	  This option is provided for the case where no in-kernel-tree
 	  modules require CRC32 functions, but a module built outside the
Index: work-fault-inject/lib/crc32.c
===================================================================
--- work-fault-inject.orig/lib/crc32.c
+++ work-fault-inject/lib/crc32.c
@@ -235,23 +235,8 @@ u32 __attribute_pure__ crc32_be(u32 crc,
 }
 #endif
 
-/**
- * bitreverse - reverse the order of bits in a u32 value
- * @x: value to be bit-reversed
- */
-u32 bitreverse(u32 x)
-{
-	x = (x >> 16) | (x << 16);
-	x = (x >> 8 & 0x00ff00ff) | (x << 8 & 0xff00ff00);
-	x = (x >> 4 & 0x0f0f0f0f) | (x << 4 & 0xf0f0f0f0);
-	x = (x >> 2 & 0x33333333) | (x << 2 & 0xcccccccc);
-	x = (x >> 1 & 0x55555555) | (x << 1 & 0xaaaaaaaa);
-	return x;
-}
-
 EXPORT_SYMBOL(crc32_le);
 EXPORT_SYMBOL(crc32_be);
-EXPORT_SYMBOL(bitreverse);
 
 /*
  * A brief CRC tutorial.
@@ -400,10 +385,7 @@ buf_dump(char const *prefix, unsigned ch
 static void bytereverse(unsigned char *buf, size_t len)
 {
 	while (len--) {
-		unsigned char x = *buf;
-		x = (x >> 4) | (x << 4);
-		x = (x >> 2 & 0x33) | (x << 2 & 0xcc);
-		x = (x >> 1 & 0x55) | (x << 1 & 0xaa);
+		unsigned char x = bitrev8(*buf);
 		*buf++ = x;
 	}
 }
@@ -460,11 +442,11 @@ static u32 test_step(u32 init, unsigned 
 	/* Now swap it around for the other test */
 
 	bytereverse(buf, len + 4);
-	init = bitreverse(init);
-	crc2 = bitreverse(crc1);
-	if (crc1 != bitreverse(crc2))
+	init = bitrev32(init);
+	crc2 = bitrev32(crc1);
+	if (crc1 != bitrev32(crc2))
 		printf("\nBit reversal fail: 0x%08x -> 0x%08x -> 0x%08x\n",
-		       crc1, crc2, bitreverse(crc2));
+		       crc1, crc2, bitrev32(crc2));
 	crc1 = crc32_le(init, buf, len);
 	if (crc1 != crc2)
 		printf("\nCRC endianness fail: 0x%08x != 0x%08x\n", crc1,
