Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbTBYRkS>; Tue, 25 Feb 2003 12:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268218AbTBYRkS>; Tue, 25 Feb 2003 12:40:18 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:16901 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S268217AbTBYRkC>; Tue, 25 Feb 2003 12:40:02 -0500
Date: Wed, 26 Feb 2003 02:47:50 +0900 (JST)
Message-Id: <20030226.024750.63517417.yoshfuji@linux-ipv6.org>
To: hch@infradead.org
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030225160634.A4525@infradead.org>
References: <20030223.225251.119557134.davem@redhat.com>
	<20030226.003625.90530451.yoshfuji@linux-ipv6.org>
	<20030225160634.A4525@infradead.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <20030225160634.A4525@infradead.org> (at Tue, 25 Feb 2003 16:06:34 +0000), Christoph Hellwig <hch@infradead.org> says:

> Config.in files use three-space indents.
:
> > +ifeq ($(CONFIG_MD5),y)
> > +  export-objs += md5.o
> > +endif
> 
> this is wrong, objects are added to export-objs unconditional.
> 
> > +
> > +#ifdef CONFIG_MD5
:
> > +EXPORT_SYMBOL(MD5Transform);
> > +#endif
> 
> Please remove the ifdef, it doesn't make any sense.

Thanks for comments. How about this? (only lib part)

Index: lib/Config.in
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/lib/Config.in,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.26.2
diff -u -r1.1.1.1 -r1.1.1.1.26.2
--- lib/Config.in	9 Oct 2002 01:35:37 -0000	1.1.1.1
+++ lib/Config.in	25 Feb 2003 17:18:27 -0000	1.1.1.1.26.2
@@ -5,6 +5,19 @@
 comment 'Library routines'
 
 #
+# MD5 digest
+#
+if [ "$CONFIG_IPV6_PRIVACY" = "y" ]; then
+   if [ "$CONFIG_IPV6" = "y" ]; then
+      define_tristate CONFIG_MD5 y
+   else
+      define_tristate CONFIG_MD5 m
+   fi
+else
+   tristate 'MD5 digest support' CONFIG_MD5
+fi
+
+#
 # Do we need the compression support?
 #
 if [ "$CONFIG_CRAMFS" = "y" -o \
Index: lib/Makefile
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/lib/Makefile,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.30.2
diff -u -r1.1.1.2 -r1.1.1.2.30.2
--- lib/Makefile	9 Oct 2002 01:35:37 -0000	1.1.1.2
+++ lib/Makefile	25 Feb 2003 17:18:27 -0000	1.1.1.2.30.2
@@ -8,7 +8,7 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o md5.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o dump_stack.o
@@ -19,6 +19,8 @@
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
 endif
+
+obj-$(CONFIG_MD5) += md5.o
 
 subdir-$(CONFIG_ZLIB_INFLATE) += zlib_inflate
 subdir-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate
Index: lib/md5.c
===================================================================
RCS file: lib/md5.c
diff -N lib/md5.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ lib/md5.c	25 Feb 2003 17:18:27 -0000	1.1.6.2
@@ -0,0 +1,250 @@
+/*
+ * This code implements the MD5 message-digest algorithm.
+ * The algorithm is due to Ron Rivest.  This code was
+ * written by Colin Plumb in 1993, no copyright is claimed.
+ * This code is in the public domain; do with it what you wish.
+ *
+ * Equivalent code is available from RSA Data Security, Inc.
+ * This code has been tested against that, and is equivalent,
+ * except that you don't need to include two pages of legalese
+ * with every copy.
+ *
+ * To compute the message digest of a chunk of bytes, declare an
+ * MD5Context structure, pass it to MD5Init, call MD5Update as
+ * needed on buffers full of bytes, and then call MD5Final, which
+ * will fill a supplied 16-byte array with the digest.
+ *
+ * Modified for Linux kernel by YOSHIFUJI Hideaki / USAGI Project.
+ * $USAGI: md5.c,v 1.1.6.2 2003/02/25 17:18:27 yoshfuji Exp $
+ */
+#include <asm/byteorder.h>
+#include <linux/module.h>
+#include <linux/string.h>		/* for memcpy() */
+#include <linux/md5.h>
+
+#ifndef __LITTLE_ENDIAN
+#define byteReverse(buf, len)	do { } while(0)
+#else
+static inline void byteReverse(u32 *p, int longs)
+{
+	do {
+		*p = cpu_to_le32p(p);
+		p++;
+	} while (--longs);
+}
+#endif
+
+/*
+ * Start MD5 accumulation.  Set bit count to 0 and buffer to mysterious
+ * initialization constants.
+ */
+void MD5Init(struct MD5Context *ctx)
+{
+	ctx->buf[0] = 0x67452301;
+	ctx->buf[1] = 0xefcdab89;
+	ctx->buf[2] = 0x98badcfe;
+	ctx->buf[3] = 0x10325476;
+
+	ctx->bits[0] = 0;
+	ctx->bits[1] = 0;
+}
+
+/*
+ * Update context to reflect the concatenation of another buffer full
+ * of bytes.
+ */
+void
+MD5Update(struct MD5Context *ctx, u8 const *buf, unsigned int len)
+{
+	unsigned int t;
+
+	/* Update bitcount */
+
+	t = ctx->bits[0];
+	if ((ctx->bits[0] = t + ((u32) len << 3)) < t)
+		ctx->bits[1]++;	/* Carry from low to high */
+	ctx->bits[1] += len >> 29;
+
+	t = (t >> 3) & 0x3f;	/* Bytes already in shsInfo->data */
+
+	/* Handle any leading odd-sized chunks */
+
+	if (t) {
+		u8 *p = (u8 *) ctx->in + t;
+
+		t = 64 - t;
+		if (len < t) {
+			memcpy(p, buf, len);
+			return;
+		}
+		memcpy(p, buf, t);
+		byteReverse((u32*)ctx->in, 16);
+		MD5Transform(ctx->buf, (u32 *) ctx->in);
+		buf += t;
+		len -= t;
+	}
+	/* Process data in 64-byte chunks */
+
+	while (len >= 64) {
+		memcpy(ctx->in, buf, 64);
+		byteReverse((u32*)ctx->in, 16);
+		MD5Transform(ctx->buf, (u32 *) ctx->in);
+		buf += 64;
+		len -= 64;
+	}
+
+	/* Handle any remaining bytes of data. */
+
+	memcpy(ctx->in, buf, len);
+}
+
+/*
+ * Final wrapup - pad to 64-byte boundary with the bit pattern
+ * 1 0* (64-bit count of bits processed, MSB-first)
+ */
+void MD5Final(u8 digest[16], struct MD5Context *ctx)
+{
+	u32 count;
+	u8 *p;
+
+	/* Compute number of bytes mod 64 */
+	count = (ctx->bits[0] >> 3) & 0x3F;
+
+	/* Set the first char of padding to 0x80.  This is safe since there is
+	 *         always at least one byte free */
+	p = ctx->in + count;
+	*p++ = 0x80;
+
+	/* Bytes of padding needed to make 64 bytes */
+	count = 64 - 1 - count;
+
+	/* Pad out to 56 mod 64 */
+	if (count < 8) {
+		/* Two lots of padding:  Pad the first block to 64 bytes */
+		memset(p, 0, count);
+		byteReverse((u32*)ctx->in, 16);
+		MD5Transform(ctx->buf, (u32 *) ctx->in);
+
+		/* Now fill the next block with 56 bytes */
+		memset(ctx->in, 0, 56);
+	} else {
+		/* Pad block to 56 bytes */
+		memset(p, 0, count - 8);
+	}
+	byteReverse((u32*)ctx->in, 14);
+
+	/* Append length in bits and transform */
+	((u32 *) ctx->in)[14] = ctx->bits[0];
+	((u32 *) ctx->in)[15] = ctx->bits[1];
+
+	MD5Transform(ctx->buf, (u32 *) ctx->in);
+	byteReverse(ctx->buf, 4);
+	memcpy(digest, ctx->buf, 16);
+	memset((char *) ctx, 0, sizeof(ctx));	/* In case it's sensitive */
+}
+
+/* The four core functions - F1 is optimized somewhat */
+
+/* #define F1(x, y, z) (x & y | ~x & z) */
+#define F1(x, y, z) (z ^ (x & (y ^ z)))
+#define F2(x, y, z) F1(z, x, y)
+#define F3(x, y, z) (x ^ y ^ z)
+#define F4(x, y, z) (y ^ (x | ~z))
+
+/* This is the central step in the MD5 algorithm. */
+#define MD5STEP(f, w, x, y, z, data, s) 	\
+	( w += f(x, y, z) + data, w = w<<s | w>>(32-s), w += x )
+
+/*
+ * The core of the MD5 algorithm, this alters an existing MD5 hash to
+ * reflect the addition of 16 longwords of new data.  MD5Update blocks
+ * the data and converts bytes into longwords for this routine.
+ */
+void MD5Transform(__u32 buf[4], __u32 const in[16])
+{
+	register u32 a, b, c, d;
+
+	a = buf[0];
+	b = buf[1];
+	c = buf[2];
+	d = buf[3];
+
+	MD5STEP(F1, a, b, c, d, in[0] + 0xd76aa478, 7);
+	MD5STEP(F1, d, a, b, c, in[1] + 0xe8c7b756, 12);
+	MD5STEP(F1, c, d, a, b, in[2] + 0x242070db, 17);
+	MD5STEP(F1, b, c, d, a, in[3] + 0xc1bdceee, 22);
+	MD5STEP(F1, a, b, c, d, in[4] + 0xf57c0faf, 7);
+	MD5STEP(F1, d, a, b, c, in[5] + 0x4787c62a, 12);
+	MD5STEP(F1, c, d, a, b, in[6] + 0xa8304613, 17);
+	MD5STEP(F1, b, c, d, a, in[7] + 0xfd469501, 22);
+	MD5STEP(F1, a, b, c, d, in[8] + 0x698098d8, 7);
+	MD5STEP(F1, d, a, b, c, in[9] + 0x8b44f7af, 12);
+	MD5STEP(F1, c, d, a, b, in[10] + 0xffff5bb1, 17);
+	MD5STEP(F1, b, c, d, a, in[11] + 0x895cd7be, 22);
+	MD5STEP(F1, a, b, c, d, in[12] + 0x6b901122, 7);
+	MD5STEP(F1, d, a, b, c, in[13] + 0xfd987193, 12);
+	MD5STEP(F1, c, d, a, b, in[14] + 0xa679438e, 17);
+	MD5STEP(F1, b, c, d, a, in[15] + 0x49b40821, 22);
+
+	MD5STEP(F2, a, b, c, d, in[1] + 0xf61e2562, 5);
+	MD5STEP(F2, d, a, b, c, in[6] + 0xc040b340, 9);
+	MD5STEP(F2, c, d, a, b, in[11] + 0x265e5a51, 14);
+	MD5STEP(F2, b, c, d, a, in[0] + 0xe9b6c7aa, 20);
+	MD5STEP(F2, a, b, c, d, in[5] + 0xd62f105d, 5);
+	MD5STEP(F2, d, a, b, c, in[10] + 0x02441453, 9);
+	MD5STEP(F2, c, d, a, b, in[15] + 0xd8a1e681, 14);
+	MD5STEP(F2, b, c, d, a, in[4] + 0xe7d3fbc8, 20);
+	MD5STEP(F2, a, b, c, d, in[9] + 0x21e1cde6, 5);
+	MD5STEP(F2, d, a, b, c, in[14] + 0xc33707d6, 9);
+	MD5STEP(F2, c, d, a, b, in[3] + 0xf4d50d87, 14);
+	MD5STEP(F2, b, c, d, a, in[8] + 0x455a14ed, 20);
+	MD5STEP(F2, a, b, c, d, in[13] + 0xa9e3e905, 5);
+	MD5STEP(F2, d, a, b, c, in[2] + 0xfcefa3f8, 9);
+	MD5STEP(F2, c, d, a, b, in[7] + 0x676f02d9, 14);
+	MD5STEP(F2, b, c, d, a, in[12] + 0x8d2a4c8a, 20);
+
+	MD5STEP(F3, a, b, c, d, in[5] + 0xfffa3942, 4);
+	MD5STEP(F3, d, a, b, c, in[8] + 0x8771f681, 11);
+	MD5STEP(F3, c, d, a, b, in[11] + 0x6d9d6122, 16);
+	MD5STEP(F3, b, c, d, a, in[14] + 0xfde5380c, 23);
+	MD5STEP(F3, a, b, c, d, in[1] + 0xa4beea44, 4);
+	MD5STEP(F3, d, a, b, c, in[4] + 0x4bdecfa9, 11);
+	MD5STEP(F3, c, d, a, b, in[7] + 0xf6bb4b60, 16);
+	MD5STEP(F3, b, c, d, a, in[10] + 0xbebfbc70, 23);
+	MD5STEP(F3, a, b, c, d, in[13] + 0x289b7ec6, 4);
+	MD5STEP(F3, d, a, b, c, in[0] + 0xeaa127fa, 11);
+	MD5STEP(F3, c, d, a, b, in[3] + 0xd4ef3085, 16);
+	MD5STEP(F3, b, c, d, a, in[6] + 0x04881d05, 23);
+	MD5STEP(F3, a, b, c, d, in[9] + 0xd9d4d039, 4);
+	MD5STEP(F3, d, a, b, c, in[12] + 0xe6db99e5, 11);
+	MD5STEP(F3, c, d, a, b, in[15] + 0x1fa27cf8, 16);
+	MD5STEP(F3, b, c, d, a, in[2] + 0xc4ac5665, 23);
+
+	MD5STEP(F4, a, b, c, d, in[0] + 0xf4292244, 6);
+	MD5STEP(F4, d, a, b, c, in[7] + 0x432aff97, 10);
+	MD5STEP(F4, c, d, a, b, in[14] + 0xab9423a7, 15);
+	MD5STEP(F4, b, c, d, a, in[5] + 0xfc93a039, 21);
+	MD5STEP(F4, a, b, c, d, in[12] + 0x655b59c3, 6);
+	MD5STEP(F4, d, a, b, c, in[3] + 0x8f0ccc92, 10);
+	MD5STEP(F4, c, d, a, b, in[10] + 0xffeff47d, 15);
+	MD5STEP(F4, b, c, d, a, in[1] + 0x85845dd1, 21);
+	MD5STEP(F4, a, b, c, d, in[8] + 0x6fa87e4f, 6);
+	MD5STEP(F4, d, a, b, c, in[15] + 0xfe2ce6e0, 10);
+	MD5STEP(F4, c, d, a, b, in[6] + 0xa3014314, 15);
+	MD5STEP(F4, b, c, d, a, in[13] + 0x4e0811a1, 21);
+	MD5STEP(F4, a, b, c, d, in[4] + 0xf7537e82, 6);
+	MD5STEP(F4, d, a, b, c, in[11] + 0xbd3af235, 10);
+	MD5STEP(F4, c, d, a, b, in[2] + 0x2ad7d2bb, 15);
+	MD5STEP(F4, b, c, d, a, in[9] + 0xeb86d391, 21);
+
+	buf[0] += a;
+	buf[1] += b;
+	buf[2] += c;
+	buf[3] += d;
+}
+
+EXPORT_SYMBOL(MD5Init);
+EXPORT_SYMBOL(MD5Update);
+EXPORT_SYMBOL(MD5Final);
+EXPORT_SYMBOL(MD5Transform);
+

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
