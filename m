Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287337AbSBSStW>; Tue, 19 Feb 2002 13:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSBSStM>; Tue, 19 Feb 2002 13:49:12 -0500
Received: from maila.telia.com ([194.22.194.231]:64743 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S286959AbSBSStC>;
	Tue, 19 Feb 2002 13:49:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] hex <-> int conve
Date: Tue, 19 Feb 2002 19:47:40 +0100
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02021919474003.00447@jakob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 February 2002 19.02, Linus Torvalds wrote:
> On Tue, 19 Feb 2002, Jakob Kemi wrote:
> > I also added three other hex-functions that can replace a lot of
> > duplicated code.
> >
> > int  hexint_nibble (char x);		// hex digit to int.
> > int  hexint_byte   (const char *src);	// hex digit-pair to int.
> > char inthex_nibble (int x);		// int to hex digit.
> > void inthex_byte   (int x, char* dest);	// int to hex digit pair.
>
> Is there any reason to do all of this?
>
> I suspect 99% of all users can (and probably should) be replaced with
> "sscanf()" instead. Which does a lot more, of course, and is not the
> fastest thing out there due to that, but anybody who does hex->int
> conversion inside some critical loop is just crazy.

We needed the code when parsing non-null terminated UUID strings in the LDM
partition database (Dynamic Disks). And sscanf wouldn't work for us. Consider:

char a[3] = {'a','b'};
char b[3] = {'a','-'};
int x;
sscanf(a, "%x", &x);  // undefined, could crash since a isn't null-terminated

is probably solved by specifying width, but then consider:

sscanf(b, "%2x", &x); // would happily return 1 and fill x with 10

hexint_byte() would detect the error however.

Due to the amount of UUID's we have to parse the speed difference when using
sscanf() would also be noticeable. I suspect others have different reasons for
implementing their own hex->int functions.

Regards,
	Jakob Kemi

(Included is a smaller patch with less inlining.)


diff -urN -X dontdiff linux-2.5.5-pre1-vanilla/include/linux/hexint.h linux-2.5.5-pre1/include/linux/hexint.h
--- linux-2.5.5-pre1-vanilla/include/linux/hexint.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.5-pre1/include/linux/hexint.h	Tue Feb 19 19:14:35 2002
@@ -0,0 +1,66 @@
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
+ * hexint_nibble - Convert a hex digit to an int.
+ * @x: digit to convert.
+ *
+ * Return:
+ *     converted value (0-15) on success.
+ *     -1 on failure.
+ */
+extern int hexint_nibble(char x);
+
+/**
+ * __hexint_nibble - Inlined version of hexint_nibble without error-checking.
+ */
+static __inline__ int __hexint_nibble(char x)
+{
+	const unsigned int y = x - '0';
+
+	if (y <= 9) return y;
+	return (y - 7) & 0x5f;
+}
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
+++ linux-2.5.5-pre1/lib/hexint.c	Tue Feb 19 19:12:37 2002
@@ -0,0 +1,50 @@
+/*
+ *  linux/lib/hexint.c - hex<->int conversions.
+ *
+ *  Copyleft (C) 2002, Jakob Kemi <jakob.kemi@telia.com>
+ */
+
+/**
+ * hexint_nibble - Convert a hex digit to an int.
+ * @x: digit to convert.
+ *
+ * Return:
+ *     converted value (0-15) on success.
+ *     -1 on failure.
+ */
+int hexint_nibble(char x)
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
+	h <<= 4;
+
+	/* low part. */
+	if ((y = src[1] - '0') <= '9'-'0') return h | y;
+	if ((y = src[1] - 'a') <= 'f'-'a') return h | (y+10);
+	if ((y = src[1] - 'A') <= 'F'-'A') return h | (y+10);
+	return -1;
+}

