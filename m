Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWJRQfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWJRQfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWJRQfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:35:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:28049 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161200AbWJRQfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:35:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=Zmk53SlXM4XL5CwUma0bQOSjBGsHKhyrQw6afQakCmQZp2mlRHJ86JwlXiYKJRMVclt3MGn0k/WLnmtFRdkPskaAws2vm000TS+RXiTMow+kl3IRzSFN1Rf0qN3RlGwG/fw+olp5uhR8PkSYb4lJalQKge3iCPnn9fGWlAXRl2A=
Date: Thu, 19 Oct 2006 01:36:33 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/6] bit revese library
Message-ID: <20061018163633.GA21820@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides two bit reverse functions and bit reverse table.

- reverse the order of bits in a u32 value

	u8 bitrev8(u8 x);

- reverse the order of bits in a u32 value

	u32 bitrev32(u32 x);

- byte reverse table

	const u8 byte_rev_table[256];

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 include/linux/bitrev.h |   15 +++++++++++++
 lib/Kconfig            |    3 ++
 lib/Makefile           |    1 
 lib/bitrev.c           |   54 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)

Index: work-fault-inject/include/linux/bitrev.h
===================================================================
--- /dev/null
+++ work-fault-inject/include/linux/bitrev.h
@@ -0,0 +1,15 @@
+#ifndef _LINUX_BITREV_H
+#define _LINUX_BITREV_H
+
+#include <linux/types.h>
+
+extern u8 const byte_rev_table[256];
+
+static inline u8 bitrev8(u8 byte)
+{
+	return byte_rev_table[byte];
+}
+
+extern u32 bitrev32(u32 in);
+
+#endif /* _LINUX_BITREV_H */
Index: work-fault-inject/lib/Kconfig
===================================================================
--- work-fault-inject.orig/lib/Kconfig
+++ work-fault-inject/lib/Kconfig
@@ -4,6 +4,9 @@
 
 menu "Library routines"
 
+config BITREVERSE
+	tristate
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
Index: work-fault-inject/lib/Makefile
===================================================================
--- work-fault-inject.orig/lib/Makefile
+++ work-fault-inject/lib/Makefile
@@ -35,6 +35,7 @@ ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
   lib-y += dec_and_lock.o
 endif
 
+obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
Index: work-fault-inject/lib/bitrev.c
===================================================================
--- /dev/null
+++ work-fault-inject/lib/bitrev.c
@@ -0,0 +1,54 @@
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/bitrev.h>
+
+const u8 byte_rev_table[256] = {
+	0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,
+	0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
+	0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8,
+	0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,
+	0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4,
+	0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,
+	0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec,
+	0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,
+	0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2,
+	0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,
+	0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea,
+	0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,
+	0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6,
+	0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,
+	0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee,
+	0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,
+	0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1,
+	0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,
+	0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9,
+	0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,
+	0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5,
+	0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,
+	0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed,
+	0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,
+	0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3,
+	0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,
+	0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb,
+	0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,
+	0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7,
+	0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,
+	0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef,
+	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff,
+};
+EXPORT_SYMBOL_GPL(byte_rev_table);
+
+static __always_inline u16 bitrev16(u16 x)
+{
+	return (bitrev8(x & 0xff) << 8) | bitrev8(x >> 8);
+}
+
+/**
+ * bitrev32 - reverse the order of bits in a u32 value
+ * @x: value to be bit-reversed
+ */
+u32 bitrev32(u32 x)
+{
+	return (bitrev16(x & 0xffff) << 16) | bitrev16(x >> 16);
+}
+EXPORT_SYMBOL(bitrev32);
