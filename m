Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291444AbSBSPlW>; Tue, 19 Feb 2002 10:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291446AbSBSPlM>; Tue, 19 Feb 2002 10:41:12 -0500
Received: from maild.telia.com ([194.22.190.101]:62699 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S291444AbSBSPlJ>;
	Tue, 19 Feb 2002 10:41:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] hex <-> int conversion routines.
Date: Tue, 19 Feb 2002 16:39:52 +0100
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02021915240900.00635@jakob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When grepping through the kernel I noticed that there exists at least 27 
(probably more with non-obvious names) different implementations of hex to
int conversion functions. 2/3 of them in arch and the rest in drivers and fs.
All implementations were variations of this function:

int hex_nibble (char x)
{
	if (x >= '0' && x <= '9') return x - '0';
	if (x >= 'a' && x <= 'f') return x - 'a' + 10;
	if (x >= 'A' && x <= 'F') return x - 'A' + 10;
	return -1;
}

My orignial plan was to replace some of them with this version, which (at
least on x86) compiles to roughly half the size and runs twice as fast.

int hex_nibble(char x)
{
	unsigned int y;		/* Unsigned for correct wrapping */

	if ((y = x - '0') <= '9'-'0') return y;
	if ((y = x - 'A') <= 'F'-'A') return y+10;
	if ((y = x - 'a') <= 'f'-'a') return y+10;
	return -1;
}

But due to the many duplicated implementations I think it would be good to
have it in a library function.

I also added three other hex-functions that can replace a lot of duplicated code.

int  hexint_nibble (char x);		// hex digit to int.
int  hexint_byte   (const char *src);	// hex digit-pair to int.
char inthex_nibble (int x);		// int to hex digit.
void inthex_byte   (int x, char* dest);	// int to hex digit pair.

I see no point in modifying any other code to use these functions until they
are approved. If it get approved, however I can feed patches to the relevant
maintainers.

Regards,
	Jakob Kemi

diff -urN -X dontdiff linux-2.5.5-pre1-vanilla/include/linux/hexint.h linux-2.5.5-pre1/include/linux/hexint.h
--- linux-2.5.5-pre1-vanilla/include/linux/hexint.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.5-pre1/include/linux/hexint.h	Tue Feb 19 16:24:26 2002
@@ -0,0 +1,85 @@
+/*
+ *  include/linux/hexint.h - hex<->int conversions.
+ *
+ *  Copyleft (C) 2002, Jakob Kemi <jakob.kemi@telia.com>
+ */
+
+#ifndef _LINUX_HEXINT_H
+#define _LINUX_HEXINT_H
+
+#ifdef __KERNEL__
+
+/**
+ * hexint_byte - Convert a hex digit pair to an int.
+ * @src: Pointer to source data.
+ *
+ * Return:
+ *     converted value (0-255) on success.
+ *     -1 on failure.
+ */
+extern int hexint_byte(const char *src);
+
+/**
+ * _hexint_byte - Same as hexint_byte but inlined.
+ */
+static __inline__ int _hexint_byte(const char *src)
+{
+	unsigned int y; /* unsigned for correct wrapping. */
+	int h;
+
+	/* high part. */
+	if      ((y = src[0] - '0') <= '9'-'0') h = y;
+	else if ((y = src[0] - 'a') <= 'f'-'a') h = y+10;
+	else if ((y = src[0] - 'A') <= 'F'-'A') h = y+10;
+	else return -1;
+	h = h << 4;
+
+	/* low part. */
+	if ((y = src[1] - '0') <= '9'-'0') return h | y;
+	if ((y = src[1] - 'a') <= 'f'-'a') return h | (y+10);
+	if ((y = src[1] - 'A') <= 'F'-'A') return h | (y+10);
+	return -1;
+}
+
+/**
+ * hexint_nibble - Convert a hex digit to an int.
+ * @x: digit to convert.
+ *
+ * Return:
+ *     converted value (0-15) on success.
+ *     -1 on failure.
+ */
+static __inline__ int hexint_nibble(char x)
+{
+	unsigned int y;		/* unsigned for correct wrapping */
+
+	if ((y = x - '0') <= '9'-'0') return y;
+	if ((y = x - 'a') <= 'f'-'a') return y+10;
+	if ((y = x - 'A') <= 'F'-'A') return y+10;
+	return -1;
+}
+
+/**
+ * inthex_nibble - Convert an int to a hex digit.
+ */
+static __inline__ char inthex_nibble(int x)
+{
+	const char* digits = "0123456789abcdef";
+
+	return digits[x & 0x0f];
+}
+
+/**
+ * inthex_byte - Convert an int to a hex digit pair.
+ */
+static __inline__ void inthex_byte(int x, char* dest)
+{
+	const char* digits = "0123456789abcdef";
+
+	dest[0] = digits[(x & 0xf0) >> 4];
+	dest[1] = digits[x & 0x0f];
+}
+
+#endif /* __KERNEL__ */
+
+#endif
diff -urN -X dontdiff linux-2.5.5-pre1-vanilla/lib/Makefile linux-2.5.5-pre1/lib/Makefile
--- linux-2.5.5-pre1-vanilla/lib/Makefile	Sun Feb  3 14:04:47 2002
+++ linux-2.5.5-pre1/lib/Makefile	Tue Feb 19 15:55:37 2002
@@ -10,7 +10,7 @@
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o crc32.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o hexint.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -urN -X dontdiff linux-2.5.5-pre1-vanilla/lib/hexint.c linux-2.5.5-pre1/lib/hexint.c
--- linux-2.5.5-pre1-vanilla/lib/hexint.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.5-pre1/lib/hexint.c	Tue Feb 19 16:26:00 2002
@@ -0,0 +1,33 @@
+/*
+ *  linux/lib/hexint.c - hex<->int conversions.
+ *
+ *  Copyleft (C) 2002, Jakob Kemi <jakob.kemi@telia.com>
+ */
+
+
+/**
+ * hexint_byte - Convert an hex digit pair to an int.
+ * @src: Pointer to source data.
+ *
+ * Return:
+ *     converted value (0-255) on success.
+ *     -1 on failure.
+ */
+int hexint_byte(const char *src)
+{
+	unsigned int y; /* unsigned for correct wrapping. */
+	int h;
+
+	/* high part. */
+	if      ((y = src[0] - '0') <= '9'-'0') h = y;
+	else if ((y = src[0] - 'a') <= 'f'-'a') h = y+10;
+	else if ((y = src[0] - 'A') <= 'F'-'A') h = y+10;
+	else return -1;
+	h = h << 4;
+
+	/* low part. */
+	if ((y = src[1] - '0') <= '9'-'0') return h | y;
+	if ((y = src[1] - 'a') <= 'f'-'a') return h | (y+10);
+	if ((y = src[1] - 'A') <= 'F'-'A') return h | (y+10);
+	return -1;
+}
