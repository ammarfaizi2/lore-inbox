Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262293AbTCRK5W>; Tue, 18 Mar 2003 05:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbTCRK5W>; Tue, 18 Mar 2003 05:57:22 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:16900 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S262293AbTCRK5S>;
	Tue, 18 Mar 2003 05:57:18 -0500
Date: Tue, 18 Mar 2003 14:08:12 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] crc16 consolidation (common part)
Message-ID: <20030318110812.GA866@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

attached patch (2.5.65-bk) creates common crc16 module which whill be
used by async ppp, isdn and irda drivers.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1144, 2003-03-18 09:38:54+03:00, pazke@orbita1.ru
  Create common CRC16 calculation module.


 include/linux/crc16.h |   15 ++++++++++
 lib/Kconfig           |    8 +++++
 lib/Makefile          |    1 
 lib/crc16.c           |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)


diff -Nru a/include/linux/crc16.h b/include/linux/crc16.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/crc16.h	Tue Mar 18 09:54:46 2003
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
diff -Nru a/lib/Kconfig b/lib/Kconfig
--- a/lib/Kconfig	Tue Mar 18 09:54:46 2003
+++ b/lib/Kconfig	Tue Mar 18 09:54:46 2003
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
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Tue Mar 18 09:54:46 2003
+++ b/lib/Makefile	Tue Mar 18 09:54:46 2003
@@ -19,6 +19,7 @@
   obj-y += dec_and_lock.o
 endif
 
+obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff -Nru a/lib/crc16.c b/lib/crc16.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/crc16.c	Tue Mar 18 09:54:46 2003
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

===================================================================


This BitKeeper patch contains the following changesets:
1.1144
## Wrapped with gzip_uu ##


begin 664 bkpatch8013
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
&7<*!&P``
`
end
