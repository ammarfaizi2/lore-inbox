Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbVJ1HBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVJ1HBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVJ1HAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:00:49 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:30636 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S965150AbVJ1HAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:00:47 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Deepak Saxena'" <dsaxena@plexity.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: [PATCH] 2.6.14-rc3 ixp4xx_copy_from little endian/alignment
Date: Thu, 27 Oct 2005 23:09:31 -0700
Message-ID: <000e01c5db86$29ba4120$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resubmitting this because originally we just submitted it to
linux-arm-kernel and I believe this means it hasn't been seen in
the right places to get it into the MM patch set.  This patch and
the ones I will be submitting immediately afterwards or that we have
submitted before are sufficient to allow a bootable, working,
kernel on the LinkSys NSLU2 in either little-endian or big-endian
mode.  The patches have been tested against both 2.6.14 and
2.6.14-rc5-mm1 with a variety of rootfs's (arm and thumb uclibc,
arm glibc).

John Bowler <jbowler@acm.org>

>From: Alessandro Zummo
  this short patch will modify the ixp4xx mtd code in order to fix
 a couple of problems we have verified while working
 with the NSLU2. 
 
 - word-wide accesses vs byte-wide
 - little endian support
 
 There's an insightful description in the first lines of the
 patch.
 
 The author, John Bowler, has put a lot of efforts in this patch,
 verifying that this is the cleanest and shortest patch that
 can fix those problem.
 
 John and others wroted at least three different solutions
 analyzing both the current code, our needs and the 
 philosophical aspects of this code.. and I'm not kidding!
 
 The patch has been tested to work on the NSLU2 in both
 LE and BE mode.
 
 Signed-off-by: John Bowler <jbowler@acm.org>
 Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

--- linux-2.6.13/drivers/mtd/maps/ixp4xx.c	2005-10-07 15:55:08.958509801 -0700
+++ linux-2.6.13/drivers/mtd/maps/ixp4xx.c	2005-10-07 19:06:22.352484966 -0700
@@ -22,6 +22,7 @@
 #include <linux/string.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
+#include <linux/mtd/cfi_endian.h>
 #include <linux/mtd/partitions.h>
 #include <linux/ioport.h>
 #include <linux/device.h>
@@ -30,18 +31,45 @@
 
 #include <linux/reboot.h>
 
+/* On a little-endian IXP4XX system (tested on NSLU2) contrary to the
+ * Intel documentation LDRH/STRH appears to XOR the address with 10b.
+ * This causes the cfi commands (sent to the command address, 0xAA for
+ * 16 bit flash) to fail.  This is fixed here by XOR'ing the address
+ * before use with 10b.  The cost of this is that the flash layout ends
+ * up with pdp-endiannes (on an LE syste), however this is not a problem
+ * as the access code consistently only accesses half words - so the
+ * endianness is not determinable on stuff which is written and read
+ * consistently in the little endian world.
+ *
+ * For flash data from the big-endian world, however, the results are
+ * weird - the pdp-endianness results in the data apparently being
+ * 2-byte swapped (as in dd conv=swab).  To work round this the 16
+ * bit values are written and read using cpu_to_cfi16 and cfi16_to_cpu,
+ * by default these are no-ops, but if the MTD driver is configed with
+ * CONFIG_MTD_CFI_BE_BYTE_SWAP the macros will byte swap the data,
+ * resulting in a consistently BE view of the flash on both BE (no
+ * op) and LE systems.  This config setting also causes the command
+ * data from the CFI implementation to get swapped - as is required
+ * so that this code will *unswap* it and give the correct command
+ * data to the flash.
+ */
 #ifndef __ARMEB__
 #define	BYTE0(h)	((h) & 0xFF)
 #define	BYTE1(h)	(((h) >> 8) & 0xFF)
+#define	FLASHWORD(a)	(*(__u16*)((u32)(a) ^ 2))
 #else
 #define	BYTE0(h)	(((h) >> 8) & 0xFF)
 #define	BYTE1(h)	((h) & 0xFF)
+#define	FLASHWORD(a)	(*(__u16*)(a))
 #endif
 
+#define FLASHW(a)	cfi16_to_cpu(FLASHWORD(a))
+#define FLASHSET(a,v)	(FLASHWORD(a) = cpu_to_cfi16(v))
+
 static map_word ixp4xx_read16(struct map_info *map, unsigned long ofs)
 {
 	map_word val;
-	val.x[0] = *(__u16 *) (map->map_priv_1 + ofs);
+	val.x[0] = FLASHW(map->map_priv_1 + ofs);
 	return val;
 }
 
@@ -53,19 +81,23 @@
 static void ixp4xx_copy_from(struct map_info *map, void *to,
 			     unsigned long from, ssize_t len)
 {
-	int i;
-	u8 *dest = (u8 *) to;
-	u16 *src = (u16 *) (map->map_priv_1 + from);
-	u16 data;
+	if (len <= 0)
+		return;
 
-	for (i = 0; i < (len / 2); i++) {
-		data = src[i];
-		dest[i * 2] = BYTE0(data);
-		dest[i * 2 + 1] = BYTE1(data);
+	u8 *dest = (u8 *) to;
+	u8 *src  = (u8 *) (map->map_priv_1 + from);
+	if (from & 1)
+		*dest++ = BYTE1(FLASHW(src-1)), ++src, --len;
+
+	while (len >= 2) {
+		u16 data = FLASHW(src); src += 2;
+		*dest++ = BYTE0(data);
+		*dest++ = BYTE1(data);
+		len -= 2;
 	}
 
-	if (len & 1)
-		dest[len - 1] = BYTE0(src[i]);
+	if (len > 0)
+		*dest++ = BYTE0(FLASHW(src));
 }
 
 /* 
@@ -75,7 +107,7 @@
 static void ixp4xx_probe_write16(struct map_info *map, map_word d, unsigned long adr)
 {
 	if (!(adr & 1))
-	       *(__u16 *) (map->map_priv_1 + adr) = d.x[0];
+	       FLASHSET(map->map_priv_1 + adr, d.x[0]);
 }
 
 /* 
@@ -83,7 +115,7 @@
  */
 static void ixp4xx_write16(struct map_info *map, map_word d, unsigned long adr)
 {
-       *(__u16 *) (map->map_priv_1 + adr) = d.x[0];
+       FLASHSET(map->map_priv_1 + adr, d.x[0]);
 }
 
 struct ixp4xx_flash_info {

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

