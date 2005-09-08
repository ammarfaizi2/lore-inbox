Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVIHWZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVIHWZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVIHWY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:24:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:41406 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965053AbVIHWW5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:57 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] lib/crc16: added crc16 algorithm.
In-Reply-To: <11262181623559@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:42 -0700
Message-Id: <11262181623853@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] lib/crc16: added crc16 algorithm.

Add the crc16 routines, as used by w1 devices.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7657ec1fcb69e266ab876af56332d0c484ca6d00
tree 6118ceffa2f83f43c3086941d96011dc1abeb459
parent a3d65f254274567daa89d8b99ab3d481d60fcaef
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Wed, 17 Aug 2005 15:17:26 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:27 -0700

 include/linux/crc16.h |   44 ++++++++++++++++++++++++++++++++
 lib/Kconfig           |    8 ++++++
 lib/Makefile          |    3 +-
 lib/crc16.c           |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+), 1 deletions(-)

diff --git a/include/linux/crc16.h b/include/linux/crc16.h
new file mode 100644
--- /dev/null
+++ b/include/linux/crc16.h
@@ -0,0 +1,44 @@
+/*
+ *	crc16.h - CRC-16 routine
+ *
+ * Implements the standard CRC-16, as used with 1-wire devices:
+ *   Width 16
+ *   Poly  0x8005 (x^16 + x^15 + x^2 + 1)
+ *   Init  0
+ *
+ * For 1-wire devices, the CRC is stored inverted, LSB-first
+ *
+ * Example buffer with the CRC attached:
+ *   31 32 33 34 35 36 37 38 39 C2 44
+ *
+ * The CRC over a buffer with the CRC attached is 0xB001.
+ * So, if (crc16(0, buf, size) == 0xB001) then the buffer is valid.
+ *
+ * Refer to "Application Note 937: Book of iButton Standards" for details.
+ * http://www.maxim-ic.com/appnotes.cfm/appnote_number/937
+ *
+ * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2. See the file COPYING for more details.
+ */
+
+#ifndef __CRC16_H
+#define __CRC16_H
+
+#include <linux/types.h>
+
+#define CRC16_INIT		0
+#define CRC16_VALID		0xb001
+
+extern u16 const crc16_table[256];
+
+extern u16 crc16(u16 crc, const u8 *buffer, size_t len);
+
+static inline u16 crc16_byte(u16 crc, const u8 data)
+{
+	return (crc >> 8) ^ crc16_table[(crc ^ data) & 0xff];
+}
+
+#endif /* __CRC16_H */
+
diff --git a/lib/Kconfig b/lib/Kconfig
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -12,6 +12,14 @@ config CRC_CCITT
 	  the kernel tree does. Such modules that use library CRC-CCITT
 	  functions require M here.
 
+config CRC16
+	tristate "CRC16 functions"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require CRC16 functions, but a module built outside
+	  the kernel tree does. Such modules that use library CRC16
+	  functions require M here.
+
 config CRC32
 	tristate "CRC32 functions"
 	default y
diff --git a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -23,11 +23,12 @@ lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += f
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 
-ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
+ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
   lib-y += dec_and_lock.o
 endif
 
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
+obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
diff --git a/lib/crc16.c b/lib/crc16.c
new file mode 100644
--- /dev/null
+++ b/lib/crc16.c
@@ -0,0 +1,67 @@
+/*
+ *      crc16.c
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2. See the file COPYING for more details.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/crc16.h>
+
+/** CRC table for the CRC-16. The poly is 0x8005 (x^16 + x^15 + x^2 + 1) */
+u16 const crc16_table[256] = {
+	0x0000, 0xC0C1, 0xC181, 0x0140, 0xC301, 0x03C0, 0x0280, 0xC241,
+	0xC601, 0x06C0, 0x0780, 0xC741, 0x0500, 0xC5C1, 0xC481, 0x0440,
+	0xCC01, 0x0CC0, 0x0D80, 0xCD41, 0x0F00, 0xCFC1, 0xCE81, 0x0E40,
+	0x0A00, 0xCAC1, 0xCB81, 0x0B40, 0xC901, 0x09C0, 0x0880, 0xC841,
+	0xD801, 0x18C0, 0x1980, 0xD941, 0x1B00, 0xDBC1, 0xDA81, 0x1A40,
+	0x1E00, 0xDEC1, 0xDF81, 0x1F40, 0xDD01, 0x1DC0, 0x1C80, 0xDC41,
+	0x1400, 0xD4C1, 0xD581, 0x1540, 0xD701, 0x17C0, 0x1680, 0xD641,
+	0xD201, 0x12C0, 0x1380, 0xD341, 0x1100, 0xD1C1, 0xD081, 0x1040,
+	0xF001, 0x30C0, 0x3180, 0xF141, 0x3300, 0xF3C1, 0xF281, 0x3240,
+	0x3600, 0xF6C1, 0xF781, 0x3740, 0xF501, 0x35C0, 0x3480, 0xF441,
+	0x3C00, 0xFCC1, 0xFD81, 0x3D40, 0xFF01, 0x3FC0, 0x3E80, 0xFE41,
+	0xFA01, 0x3AC0, 0x3B80, 0xFB41, 0x3900, 0xF9C1, 0xF881, 0x3840,
+	0x2800, 0xE8C1, 0xE981, 0x2940, 0xEB01, 0x2BC0, 0x2A80, 0xEA41,
+	0xEE01, 0x2EC0, 0x2F80, 0xEF41, 0x2D00, 0xEDC1, 0xEC81, 0x2C40,
+	0xE401, 0x24C0, 0x2580, 0xE541, 0x2700, 0xE7C1, 0xE681, 0x2640,
+	0x2200, 0xE2C1, 0xE381, 0x2340, 0xE101, 0x21C0, 0x2080, 0xE041,
+	0xA001, 0x60C0, 0x6180, 0xA141, 0x6300, 0xA3C1, 0xA281, 0x6240,
+	0x6600, 0xA6C1, 0xA781, 0x6740, 0xA501, 0x65C0, 0x6480, 0xA441,
+	0x6C00, 0xACC1, 0xAD81, 0x6D40, 0xAF01, 0x6FC0, 0x6E80, 0xAE41,
+	0xAA01, 0x6AC0, 0x6B80, 0xAB41, 0x6900, 0xA9C1, 0xA881, 0x6840,
+	0x7800, 0xB8C1, 0xB981, 0x7940, 0xBB01, 0x7BC0, 0x7A80, 0xBA41,
+	0xBE01, 0x7EC0, 0x7F80, 0xBF41, 0x7D00, 0xBDC1, 0xBC81, 0x7C40,
+	0xB401, 0x74C0, 0x7580, 0xB541, 0x7700, 0xB7C1, 0xB681, 0x7640,
+	0x7200, 0xB2C1, 0xB381, 0x7340, 0xB101, 0x71C0, 0x7080, 0xB041,
+	0x5000, 0x90C1, 0x9181, 0x5140, 0x9301, 0x53C0, 0x5280, 0x9241,
+	0x9601, 0x56C0, 0x5780, 0x9741, 0x5500, 0x95C1, 0x9481, 0x5440,
+	0x9C01, 0x5CC0, 0x5D80, 0x9D41, 0x5F00, 0x9FC1, 0x9E81, 0x5E40,
+	0x5A00, 0x9AC1, 0x9B81, 0x5B40, 0x9901, 0x59C0, 0x5880, 0x9841,
+	0x8801, 0x48C0, 0x4980, 0x8941, 0x4B00, 0x8BC1, 0x8A81, 0x4A40,
+	0x4E00, 0x8EC1, 0x8F81, 0x4F40, 0x8D01, 0x4DC0, 0x4C80, 0x8C41,
+	0x4400, 0x84C1, 0x8581, 0x4540, 0x8701, 0x47C0, 0x4680, 0x8641,
+	0x8201, 0x42C0, 0x4380, 0x8341, 0x4100, 0x81C1, 0x8081, 0x4040
+};
+EXPORT_SYMBOL(crc16_table);
+
+/**
+ * Compute the CRC-16 for the data buffer
+ *
+ * @param crc     previous CRC value
+ * @param buffer  data pointer
+ * @param len     number of bytes in the buffer
+ * @return        the updated CRC value
+ */
+u16 crc16(u16 crc, u8 const *buffer, size_t len)
+{
+	while (len--)
+		crc = crc16_byte(crc, *buffer++);
+	return crc;
+}
+EXPORT_SYMBOL(crc16);
+
+MODULE_DESCRIPTION("CRC16 calculations");
+MODULE_LICENSE("GPL");
+

