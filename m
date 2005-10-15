Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVJOH7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVJOH7y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVJOH7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:59:54 -0400
Received: from mail.renesas.com ([202.234.163.13]:23707 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751130AbVJOH7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:59:53 -0400
Date: Sat, 15 Oct 2005 16:59:50 +0900 (JST)
Message-Id: <20051015.165950.41638130.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org,
       fujiwara@linux-m32r.org
Subject: [PATCH 2.6.14-rc4] m32r: SMC91x driver update
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update SMC91x driver for m32r.

- Remove needless NONCACHE_OFFSET adjustment.
  > [PATCH 2.6.14-rc4] m32r: NONCACHE_OFFSET in _port2addr
  > Change _port2addr() not to add NONCACHE_OFFSET.
  > Adding NONCACHE_OFFSET requires needless address adjusting by a driver
  > using ioremap() like a SMC91x driver.

- Fix lots of warnings as following:
/usr/src/ctest/git/kernel/drivers/net/smc91x.c: In function `smc_reset':
/usr/src/ctest/git/kernel/drivers/net/smc91x.c:324: warning: passing arg 2 of `_outw' makes integer from pointer without a cast
/usr/src/ctest/git/kernel/drivers/net/smc91x.c:325: warning: passing arg 2 of `_outw' makes integer from pointer without a cast
/usr/src/ctest/git/kernel/drivers/net/smc91x.c:341: warning: passing arg 2 of `_outw' makes integer from pointer without a cast
/usr/src/ctest/git/kernel/drivers/net/smc91x.c:342: warning: passing arg 2 of `_outw' makes integer from pointer without a cast
  :
/usr/src/ctest/git/kernel/drivers/net/smc91x.c:1915: warning: passing arg 1 of `_inw' makes integer from pointer without a cast
/usr/src/ctest/git/kernel/drivers/net/smc91x.c:1915: warning: passing arg 1 of `_inw' makes integer from pointer without a cast

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/io_m32700ut.c |    6 +++---
 arch/m32r/kernel/io_mappi2.c   |    9 ++++-----
 arch/m32r/kernel/io_mappi3.c   |    7 +++----
 arch/m32r/kernel/io_opsput.c   |    6 +++---
 drivers/net/smc91x.h           |   12 ++++++------
 5 files changed, 19 insertions(+), 21 deletions(-)

Index: arch/m32r/kernel/io_m32700ut.c
===================================================================
--- arch/m32r/kernel/io_m32700ut.c.orig	2005-10-11 10:19:19.000000000 +0900
+++ arch/m32r/kernel/io_m32700ut.c	2005-10-12 12:55:24.547482352 +0900
@@ -64,11 +64,11 @@ static inline void *__port2addr_ata(unsi
  * from 0x10000000 to 0x13ffffff on physical address.
  * The base address of LAN controller(LAN91C111) is 0x300.
  */
-#define LAN_IOSTART	0x300
-#define LAN_IOEND	0x320
+#define LAN_IOSTART	0xa0000300
+#define LAN_IOEND	0xa0000320
 static inline void *_port2addr_ne(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET + 0x10000000);
+	return (void *)(port + 0x10000000);
 }
 static inline void *_port2addr_usb(unsigned long port)
 {
Index: arch/m32r/kernel/io_mappi2.c
===================================================================
--- arch/m32r/kernel/io_mappi2.c.orig	2005-10-12 12:24:17.544309976 +0900
+++ arch/m32r/kernel/io_mappi2.c	2005-10-12 12:55:24.555481136 +0900
@@ -36,9 +36,6 @@ static inline void *_port2addr(unsigned 
 	return (void *)(port | (NONCACHE_OFFSET));
 }
 
-#define LAN_IOSTART	0x300
-#define LAN_IOEND	0x320
-
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 static inline void *__port2addr_ata(unsigned long port)
 {
@@ -59,15 +56,17 @@ static inline void *__port2addr_ata(unsi
 }
 #endif
 
+#define LAN_IOSTART	0xa0000300
+#define LAN_IOEND	0xa0000320
 #ifdef CONFIG_CHIP_OPSP
 static inline void *_port2addr_ne(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET + 0x10000000);
+	return (void *)(port + 0x10000000);
 }
 #else
 static inline void *_port2addr_ne(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET + 0x04000000);
+	return (void *)(port + 0x04000000);
 }
 #endif
 static inline void *_port2addr_usb(unsigned long port)
Index: arch/m32r/kernel/io_mappi3.c
===================================================================
--- arch/m32r/kernel/io_mappi3.c.orig	2005-10-11 10:19:19.000000000 +0900
+++ arch/m32r/kernel/io_mappi3.c	2005-10-12 12:55:24.563479920 +0900
@@ -36,9 +36,6 @@ static inline void *_port2addr(unsigned 
 	return (void *)(port + NONCACHE_OFFSET);
 }
 
-#define LAN_IOSTART	0x300
-#define LAN_IOEND	0x320
-
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 static inline void *__port2addr_ata(unsigned long port)
 {
@@ -59,9 +56,11 @@ static inline void *__port2addr_ata(unsi
 }
 #endif
 
+#define LAN_IOSTART	0xa0000300
+#define LAN_IOEND	0xa0000320
 static inline void *_port2addr_ne(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET + 0x10000000);
+	return (void *)(port + 0x10000000);
 }
 
 static inline void *_port2addr_usb(unsigned long port)
Index: arch/m32r/kernel/io_opsput.c
===================================================================
--- arch/m32r/kernel/io_opsput.c.orig	2005-10-12 12:24:17.552308760 +0900
+++ arch/m32r/kernel/io_opsput.c	2005-10-12 12:55:24.570478856 +0900
@@ -44,11 +44,11 @@ static inline void *_port2addr(unsigned 
  * from 0x10000000 to 0x13ffffff on physical address.
  * The base address of LAN controller(LAN91C111) is 0x300.
  */
-#define LAN_IOSTART	0x300
-#define LAN_IOEND	0x320
+#define LAN_IOSTART	0xa0000300
+#define LAN_IOEND	0xa0000320
 static inline void *_port2addr_ne(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET + 0x10000000);
+	return (void *)(port + 0x10000000);
 }
 static inline void *_port2addr_usb(unsigned long port)
 {
Index: drivers/net/smc91x.h
===================================================================
--- drivers/net/smc91x.h.orig	2005-10-11 10:19:19.000000000 +0900
+++ drivers/net/smc91x.h	2005-10-12 12:55:24.583476880 +0900
@@ -230,12 +230,12 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 #define SMC_CAN_USE_16BIT	1
 #define SMC_CAN_USE_32BIT	0
 
-#define SMC_inb(a, r)		inb((a) + (r) - 0xa0000000)
-#define SMC_inw(a, r)		inw((a) + (r) - 0xa0000000)
-#define SMC_outb(v, a, r)	outb(v, (a) + (r) - 0xa0000000)
-#define SMC_outw(v, a, r)	outw(v, (a) + (r) - 0xa0000000)
-#define SMC_insw(a, r, p, l)	insw((a) + (r) - 0xa0000000, p, l)
-#define SMC_outsw(a, r, p, l)	outsw((a) + (r) - 0xa0000000, p, l)
+#define SMC_inb(a, r)		inb((u32)a) + (r))
+#define SMC_inw(a, r)		inw(((u32)a) + (r))
+#define SMC_outb(v, a, r)	outb(v, ((u32)a) + (r))
+#define SMC_outw(v, a, r)	outw(v, ((u32)a) + (r))
+#define SMC_insw(a, r, p, l)	insw(((u32)a) + (r), p, l)
+#define SMC_outsw(a, r, p, l)	outsw(((u32)a) + (r), p, l)
 
 #define set_irq_type(irq, type)	do {} while(0)

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
 
