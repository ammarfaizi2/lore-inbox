Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263100AbTCLIvX>; Wed, 12 Mar 2003 03:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263101AbTCLIvW>; Wed, 12 Mar 2003 03:51:22 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:22538 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S263100AbTCLIvQ>;
	Wed, 12 Mar 2003 03:51:16 -0500
Date: Wed, 12 Mar 2003 12:01:59 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] consolidate crc16 calculations (common part)
Message-ID: <20030312090159.GA1393@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liqSWPDvh3eyfZ9k"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

yet another resend of crc16 patched is started :)

Attached patch (2.5.64) creates crc16.c module. It will be
used by async ppp, irda and isdn subsystems.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-crc16

diff -urN -X /usr/share/dontdiff linux-2.5.64.vanilla/lib/Kconfig linux-2.5.64/lib/Kconfig
--- linux-2.5.64.vanilla/lib/Kconfig	Thu Nov 28 01:36:05 2002
+++ linux-2.5.64/lib/Kconfig	Sun Mar  9 23:40:35 2003
@@ -4,6 +4,14 @@
 
 menu "Library routines"
 
+config CRC16
+	tristate "CRC16 functions"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require CRC16 functions, but a module built outside the
+	  kernel tree does. Such modules that use library CRC16 functions
+	  require M here.
+
 config CRC32
 	tristate "CRC32 functions"
 	help
diff -urN -X /usr/share/dontdiff linux-2.5.64.vanilla/lib/Makefile linux-2.5.64/lib/Makefile
--- linux-2.5.64.vanilla/lib/Makefile	Mon Mar 10 00:52:21 2003
+++ linux-2.5.64/lib/Makefile	Sun Mar  9 23:40:35 2003
@@ -19,6 +19,7 @@
   obj-y += dec_and_lock.o
 endif
 
+obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff -urN -X /usr/share/dontdiff linux-2.5.64.vanilla/lib/crc16.c linux-2.5.64/lib/crc16.c
--- linux-2.5.64.vanilla/lib/crc16.c	Thu Jan  1 03:00:00 1970
+++ linux-2.5.64/lib/crc16.c	Sun Mar  9 23:44:22 2003
@@ -0,0 +1,72 @@
+/*
+ *	linux/lib/crc16.c
+ *
+ *	This source code is licensed under the GNU General Public License,
+ *	Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/crc16.h>
+
+/*
+ * This mysterious table is just the CRC of each possible byte. It can be
+ * computed using the standard bit-at-a-time methods. The polynomial can
+ * be seen in entry 128, 0x8408. This corresponds to x^0 + x^5 + x^12.
+ * Add the implicit x^16, and you have the standard CRC-CCITT.
+ */
+u16 const crc16_table[256] = {
+	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
+	0x8c48, 0x9dc1, 0xaf5a, 0xbed3, 0xca6c, 0xdbe5, 0xe97e, 0xf8f7,
+	0x1081, 0x0108, 0x3393, 0x221a, 0x56a5, 0x472c, 0x75b7, 0x643e,
+	0x9cc9, 0x8d40, 0xbfdb, 0xae52, 0xdaed, 0xcb64, 0xf9ff, 0xe876,
+	0x2102, 0x308b, 0x0210, 0x1399, 0x6726, 0x76af, 0x4434, 0x55bd,
+	0xad4a, 0xbcc3, 0x8e58, 0x9fd1, 0xeb6e, 0xfae7, 0xc87c, 0xd9f5,
+	0x3183, 0x200a, 0x1291, 0x0318, 0x77a7, 0x662e, 0x54b5, 0x453c,
+	0xbdcb, 0xac42, 0x9ed9, 0x8f50, 0xfbef, 0xea66, 0xd8fd, 0xc974,
+	0x4204, 0x538d, 0x6116, 0x709f, 0x0420, 0x15a9, 0x2732, 0x36bb,
+	0xce4c, 0xdfc5, 0xed5e, 0xfcd7, 0x8868, 0x99e1, 0xab7a, 0xbaf3,
+	0x5285, 0x430c, 0x7197, 0x601e, 0x14a1, 0x0528, 0x37b3, 0x263a,
+	0xdecd, 0xcf44, 0xfddf, 0xec56, 0x98e9, 0x8960, 0xbbfb, 0xaa72,
+	0x6306, 0x728f, 0x4014, 0x519d, 0x2522, 0x34ab, 0x0630, 0x17b9,
+	0xef4e, 0xfec7, 0xcc5c, 0xddd5, 0xa96a, 0xb8e3, 0x8a78, 0x9bf1,
+	0x7387, 0x620e, 0x5095, 0x411c, 0x35a3, 0x242a, 0x16b1, 0x0738,
+	0xffcf, 0xee46, 0xdcdd, 0xcd54, 0xb9eb, 0xa862, 0x9af9, 0x8b70,
+	0x8408, 0x9581, 0xa71a, 0xb693, 0xc22c, 0xd3a5, 0xe13e, 0xf0b7,
+	0x0840, 0x19c9, 0x2b52, 0x3adb, 0x4e64, 0x5fed, 0x6d76, 0x7cff,
+	0x9489, 0x8500, 0xb79b, 0xa612, 0xd2ad, 0xc324, 0xf1bf, 0xe036,
+	0x18c1, 0x0948, 0x3bd3, 0x2a5a, 0x5ee5, 0x4f6c, 0x7df7, 0x6c7e,
+	0xa50a, 0xb483, 0x8618, 0x9791, 0xe32e, 0xf2a7, 0xc03c, 0xd1b5,
+	0x2942, 0x38cb, 0x0a50, 0x1bd9, 0x6f66, 0x7eef, 0x4c74, 0x5dfd,
+	0xb58b, 0xa402, 0x9699, 0x8710, 0xf3af, 0xe226, 0xd0bd, 0xc134,
+	0x39c3, 0x284a, 0x1ad1, 0x0b58, 0x7fe7, 0x6e6e, 0x5cf5, 0x4d7c,
+	0xc60c, 0xd785, 0xe51e, 0xf497, 0x8028, 0x91a1, 0xa33a, 0xb2b3,
+	0x4a44, 0x5bcd, 0x6956, 0x78df, 0x0c60, 0x1de9, 0x2f72, 0x3efb,
+	0xd68d, 0xc704, 0xf59f, 0xe416, 0x90a9, 0x8120, 0xb3bb, 0xa232,
+	0x5ac5, 0x4b4c, 0x79d7, 0x685e, 0x1ce1, 0x0d68, 0x3ff3, 0x2e7a,
+	0xe70e, 0xf687, 0xc41c, 0xd595, 0xa12a, 0xb0a3, 0x8238, 0x93b1,
+	0x6b46, 0x7acf, 0x4854, 0x59dd, 0x2d62, 0x3ceb, 0x0e70, 0x1ff9,
+	0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
+	0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
+};
+EXPORT_SYMBOL(crc16_table);
+
+/**
+ *	crc16 - recompute the CRC for the data buffer
+ *	@crc - previous CRC value
+ *	@buffer - data pointer
+ *	@len - number of bytes in the buffer
+ */
+u16 crc16(u16 crc, u8 const *buffer, size_t len)
+{
+	if (len) {
+		do {
+			crc = crc16_byte(crc, *buffer++);
+		} while (--len);
+	}
+	return crc;
+}
+EXPORT_SYMBOL(crc16);
+
+MODULE_DESCRIPTION("CRC16 calculations");
+MODULE_LICENSE("GPL");
diff -urN -X /usr/share/dontdiff linux-2.5.64.vanilla/include/linux/crc16.h linux-2.5.64/include/linux/crc16.h
--- linux-2.5.64.vanilla/include/linux/crc16.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.64/include/linux/crc16.h	Sun Mar  9 23:40:35 2003
@@ -0,0 +1,15 @@
+#ifndef _LINUX_CRC16_H
+#define _LINUX_CRC16_H
+
+#include <linux/types.h>
+
+extern u16 const crc16_table[256];
+
+extern u16 crc16(u16 crc, const u8 *buffer, size_t len);
+
+static inline u16 crc16_byte(u16 crc, const u8 c)
+{
+	return (crc >> 8) ^ crc16_table[(crc ^ c) & 0xff];
+}
+
+#endif /* _LINUX_CRC16_H */

--liqSWPDvh3eyfZ9k--
