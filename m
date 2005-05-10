Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVEJPNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVEJPNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVEJPNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:13:50 -0400
Received: from schlund.terranet.ro ([80.96.218.84]:9788 "EHLO
	dizzywork.schlund.ro") by vger.kernel.org with ESMTP
	id S261671AbVEJPM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:12:57 -0400
Message-ID: <4280CF77.4040102@schlund.ro>
Date: Tue, 10 May 2005 18:12:55 +0300
From: Mihai Rusu <dizzy@schlund.ro>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Robert Love <rml@novell.com>
Subject: [RFC][PATCH 2.4 1/4] inotify 0.22 2.4.x backport - find_next_bit
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050205010304050005080901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050205010304050005080901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

This is the find_next_bit implementation from 2.6.11 vanilla. Needed by
"idr.c".

-- 
Mihai Rusu
Linux System Development

Schlund + Partner AG   Tel         : +40-21-231-2544
Str Mircea Eliade 18   EMail       : dizzy@schlund.ro
Sect 1, Bucuresti
71295, Romania





--------------050205010304050005080901
Content-Type: text/x-patch;
 name="01_find_next_bit-2.4.30.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01_find_next_bit-2.4.30.patch"


 include/linux/bitops.h |    2 +
 lib/Makefile           |    2 -
 lib/find_next_bit.c    |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff -uNr linux-2.4.30.orig/include/linux/bitops.h linux-2.4.30/include/linux/bitops.h
--- linux-2.4.30.orig/include/linux/bitops.h	2001-11-22 21:46:18.000000000 +0200
+++ linux-2.4.30/include/linux/bitops.h	2005-05-09 13:13:18.000000000 +0300
@@ -66,6 +66,8 @@
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
 
+int find_next_bit(const unsigned long *addr, int size, int offset);
+
 #include <asm/bitops.h>
 
 
diff -uNr linux-2.4.30.orig/lib/Makefile linux-2.4.30/lib/Makefile
--- linux-2.4.30.orig/lib/Makefile	2004-04-14 16:05:40.000000000 +0300
+++ linux-2.4.30/lib/Makefile	2005-05-09 13:16:49.000000000 +0300
@@ -12,7 +12,7 @@
 	       rbtree.o crc32.o firmware_class.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
-	 bust_spinlocks.o rbtree.o dump_stack.o
+	 bust_spinlocks.o rbtree.o dump_stack.o find_next_bit.o
 
 obj-$(CONFIG_FW_LOADER) += firmware_class.o
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
diff -uNr linux-2.4.30.orig/lib/find_next_bit.c linux-2.4.30/lib/find_next_bit.c
--- linux-2.4.30.orig/lib/find_next_bit.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.4.30/lib/find_next_bit.c	2005-05-09 13:13:18.000000000 +0300
@@ -0,0 +1,55 @@
+/* find_next_bit.c: fallback find next bit implementation
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/bitops.h>
+
+int find_next_bit(const unsigned long *addr, int size, int offset)
+{
+	const unsigned long *base;
+	const int NBITS = sizeof(*addr) * 8;
+	unsigned long tmp;
+
+	base = addr;
+	if (offset) {
+		int suboffset;
+
+		addr += offset / NBITS;
+
+		suboffset = offset % NBITS;
+		if (suboffset) {
+			tmp = *addr;
+			tmp >>= suboffset;
+			if (tmp)
+				goto finish;
+		}
+
+		addr++;
+	}
+
+	while ((tmp = *addr) == 0)
+		addr++;
+
+	offset = (addr - base) * NBITS;
+
+ finish:
+	/* count the remaining bits without using __ffs() since that takes a 32-bit arg */
+	while (!(tmp & 0xff)) {
+		offset += 8;
+		tmp >>= 8;
+	}
+
+	while (!(tmp & 1)) {
+		offset++;
+		tmp >>= 1;
+	}
+
+	return offset;
+}




--------------050205010304050005080901--
