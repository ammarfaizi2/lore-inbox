Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbWIRBip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWIRBip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWIRBiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:38:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:23259 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965213AbWIRBiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:38:20 -0400
Message-Id: <20060918013216.534777000@klappe.arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Date: Mon, 18 Sep 2006 03:27:42 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 2/8] fix byteorder headers for make headers_check
Content-Disposition: inline; filename=check-byteorder.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the header files for byteorder includeable
on 32 bit systems with gcc -ansi, where no 64 bit
integers are available.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/include/linux/byteorder/big_endian.h
===================================================================
--- linux-cg.orig/include/linux/byteorder/big_endian.h	2006-09-18 02:20:36.000000000 +0200
+++ linux-cg/include/linux/byteorder/big_endian.h	2006-09-18 02:20:51.000000000 +0200
@@ -40,6 +40,7 @@
 #define __cpu_to_be16(x) ((__force __be16)(__u16)(x))
 #define __be16_to_cpu(x) ((__force __u16)(__be16)(x))
 
+#ifdef __BYTEORDER_HAS_U64__
 static inline __le64 __cpu_to_le64p(const __u64 *p)
 {
 	return (__force __le64)__swab64p(p);
@@ -48,6 +49,7 @@
 {
 	return __swab64p((__u64 *)p);
 }
+#endif
 static inline __le32 __cpu_to_le32p(const __u32 *p)
 {
 	return (__force __le32)__swab32p(p);
Index: linux-cg/include/linux/byteorder/little_endian.h
===================================================================
--- linux-cg.orig/include/linux/byteorder/little_endian.h	2006-09-18 02:20:36.000000000 +0200
+++ linux-cg/include/linux/byteorder/little_endian.h	2006-09-18 02:20:51.000000000 +0200
@@ -40,6 +40,7 @@
 #define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
 #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
 
+#ifdef __BYTEORDER_HAS_U64__
 static inline __le64 __cpu_to_le64p(const __u64 *p)
 {
 	return (__force __le64)*p;
@@ -48,6 +49,7 @@
 {
 	return (__force __u64)*p;
 }
+#endif
 static inline __le32 __cpu_to_le32p(const __u32 *p)
 {
 	return (__force __le32)*p;
@@ -64,6 +66,7 @@
 {
 	return (__force __u16)*p;
 }
+#ifdef __BYTEORDER_HAS_U64__
 static inline __be64 __cpu_to_be64p(const __u64 *p)
 {
 	return (__force __be64)__swab64p(p);
@@ -72,6 +75,7 @@
 {
 	return __swab64p((__u64 *)p);
 }
+#endif
 static inline __be32 __cpu_to_be32p(const __u32 *p)
 {
 	return (__force __be32)__swab32p(p);
Index: linux-cg/include/linux/byteorder/pdp_endian.h
===================================================================
--- linux-cg.orig/include/linux/byteorder/pdp_endian.h	2006-09-18 02:20:36.000000000 +0200
+++ linux-cg/include/linux/byteorder/pdp_endian.h	2006-09-18 02:20:51.000000000 +0200
@@ -27,6 +27,7 @@
 #define __PDP_ENDIAN_BITFIELD
 #endif
 
+#include <linux/types.h>
 #include <linux/byteorder/swab.h>
 #include <linux/byteorder/swabb.h>
 
Index: linux-cg/include/linux/byteorder/swab.h
===================================================================
--- linux-cg.orig/include/linux/byteorder/swab.h	2006-09-18 02:20:36.000000000 +0200
+++ linux-cg/include/linux/byteorder/swab.h	2006-09-18 02:20:51.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _LINUX_BYTEORDER_SWAB_H
 #define _LINUX_BYTEORDER_SWAB_H
 
+/* @headercheck:-include linux/types.h@ */
 /*
  * linux/byteorder/swab.h
  * Byte-swapping, independently from CPU endianness
Index: linux-cg/include/linux/byteorder/swabb.h
===================================================================
--- linux-cg.orig/include/linux/byteorder/swabb.h	2006-09-18 02:20:36.000000000 +0200
+++ linux-cg/include/linux/byteorder/swabb.h	2006-09-18 02:20:51.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _LINUX_BYTEORDER_SWABB_H
 #define _LINUX_BYTEORDER_SWABB_H
 
+/* @headercheck:-include linux/types.h@ */
 /*
  * linux/byteorder/swabb.h
  * SWAp Bytes Bizarrely

--

