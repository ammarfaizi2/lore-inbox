Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268709AbUILLiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbUILLiu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUILLet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:34:49 -0400
Received: from aun.it.uu.se ([130.238.12.36]:23037 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268669AbUILLaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:30:15 -0400
Date: Sun, 12 Sep 2004 13:30:03 +0200 (MEST)
Message-Id: <200409121130.i8CBU3pq015236@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: dwmw2@redhat.com, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] MTD drivers gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's MTD drivers. The elan-104nc.c and sbc_gxx.c changes are
backports from the 2.6 kernel. The cfi_cmdset_0001.c and cfi_cmdset_0020.c
changes are new since the 2.6 code is different.

/Mikael

--- linux-2.4.28-pre3/drivers/mtd/chips/cfi_cmdset_0001.c.~1~	2003-06-14 13:30:22.000000000 +0200
+++ linux-2.4.28-pre3/drivers/mtd/chips/cfi_cmdset_0001.c	2004-09-12 01:56:20.000000000 +0200
@@ -1201,13 +1201,17 @@
 	/* Write data */
 	for (z = 0; z < len; z += CFIDEV_BUSWIDTH) {
 		if (cfi_buswidth_is_1()) {
-			map->write8 (map, *((__u8*)buf)++, adr+z);
+			map->write8 (map, *(__u8*)buf, adr+z);
+			buf += sizeof(__u8);
 		} else if (cfi_buswidth_is_2()) {
-			map->write16 (map, *((__u16*)buf)++, adr+z);
+			map->write16 (map, *(__u16*)buf, adr+z);
+			buf += sizeof(__u16);
 		} else if (cfi_buswidth_is_4()) {
-			map->write32 (map, *((__u32*)buf)++, adr+z);
+			map->write32 (map, *(__u32*)buf, adr+z);
+			buf += sizeof(__u32);
 		} else if (cfi_buswidth_is_8()) {
-			map->write64 (map, *((__u64*)buf)++, adr+z);
+			map->write64 (map, *(__u64*)buf, adr+z);
+			buf += sizeof(__u64);
 		} else {
 			DISABLE_VPP(map);
 			ret = -EINVAL;
--- linux-2.4.28-pre3/drivers/mtd/chips/cfi_cmdset_0020.c.~1~	2003-06-14 13:30:22.000000000 +0200
+++ linux-2.4.28-pre3/drivers/mtd/chips/cfi_cmdset_0020.c	2004-09-12 01:56:20.000000000 +0200
@@ -540,11 +540,14 @@
 	/* Write data */
 	for (z = 0; z < len; z += CFIDEV_BUSWIDTH) {
 		if (cfi_buswidth_is_1()) {
-			map->write8 (map, *((__u8*)buf)++, adr+z);
+			map->write8 (map, *(__u8*)buf, adr+z);
+			buf += sizeof(__u8);
 		} else if (cfi_buswidth_is_2()) {
-			map->write16 (map, *((__u16*)buf)++, adr+z);
+			map->write16 (map, *(__u16*)buf, adr+z);
+			buf += sizeof(__u16);
 		} else if (cfi_buswidth_is_4()) {
-			map->write32 (map, *((__u32*)buf)++, adr+z);
+			map->write32 (map, *(__u32*)buf, adr+z);
+			buf += sizeof(__u32);
 		} else {
 			DISABLE_VPP(map);
 			return -EINVAL;
--- linux-2.4.28-pre3/drivers/mtd/maps/elan-104nc.c.~1~	2002-08-07 00:52:20.000000000 +0200
+++ linux-2.4.28-pre3/drivers/mtd/maps/elan-104nc.c	2004-09-12 01:56:20.000000000 +0200
@@ -147,7 +147,7 @@
 		elan_104nc_page(map, from);
 		memcpy_fromio(to, iomapadr + (from & WINDOW_MASK), thislen);
 		spin_unlock(&elan_104nc_spin);
-		(__u8*)to += thislen;
+		to += thislen;
 		from += thislen;
 		len -= thislen;
 	}
--- linux-2.4.28-pre3/drivers/mtd/maps/sbc_gxx.c.~1~	2003-06-14 13:30:22.000000000 +0200
+++ linux-2.4.28-pre3/drivers/mtd/maps/sbc_gxx.c	2004-09-12 01:56:20.000000000 +0200
@@ -155,7 +155,7 @@
 		sbc_gxx_page(map, from);
 		memcpy_fromio(to, iomapadr + (from & WINDOW_MASK), thislen);
 		spin_unlock(&sbc_gxx_spin);
-		(__u8*)to += thislen;
+		to += thislen;
 		from += thislen;
 		len -= thislen;
 	}
