Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbUKYHf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUKYHf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbUKYHf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:35:28 -0500
Received: from [220.248.27.114] ([220.248.27.114]:24514 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S263007AbUKYHep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 02:34:45 -0500
Date: Thu, 25 Nov 2004 15:07:06 +0800
From: hugang@soulinfo.com
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Nigel Cunningham <ncunningham@linuxmail.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Suspend 2 merge: 46/51: LZF support.
Message-ID: <20041125070706.GA4692@hugang.soulinfo.com>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101350324.25030.0.camel@desktop.cunninghams> <20041125063242.GA31753@hugang.soulinfo.com> <200411250152.33330.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411250152.33330.dtor_core@ameritech.net>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 01:52:33AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> On Thursday 25 November 2004 01:32 am, hugang@soulinfo.com wrote:
> ....
 
> Since this is a completely new file (as far as kernel tree is concerned)
> could you convert it to proper coding style (braces placement, identation)?

Lindent lib/lzf*.c include/linux/lzf*.h

=== include/linux/lzf.h
==================================================================
--- include/linux/lzf.h  (revision 24480)
+++ include/linux/lzf.h  (revision 24489)
@@ -0,0 +1,10 @@
+#ifndef _LZF_H_
+#define _LZF_H_
+
+unsigned int lzf_decompress (const void *const in_data,  unsigned int in_len, void *out_data, unsigned int out_len);
+unsigned int lzf_compress (const void *const in_data, unsigned int in_len, void *out_data, unsigned int out_len, void *hbuf);
+
+char *lzf_new(void);
+void lzf_free(char *);
+
+#endif
=== lib/lzf_d.c
==================================================================
--- lib/lzf_d.c  (revision 24480)
+++ lib/lzf_d.c  (revision 24489)
@@ -0,0 +1,94 @@
+/*
+ * Copyright (c) 2000-2002 Marc Alexander Lehmann <pcg@goof.com>
+ * 
+ * Redistribution and use in source and binary forms, with or without modifica-
+ * tion, are permitted provided that the following conditions are met:
+ * 
+ *   1.  Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ * 
+ *   2.  Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ * 
+ *   3.  The name of the author may not be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ * 
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MER-
+ * CHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
+ * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPE-
+ * CIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
+ * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTH-
+ * ERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * Alternatively, the contents of this file may be used under the terms of
+ * the GNU General Public License version 2 (the "GPL"), in which case the
+ * provisions of the GPL are applicable instead of the above. If you wish to
+ * allow the use of your version of this file only under the terms of the
+ * GPL and not to allow others to use your version of this file under the
+ * BSD license, indicate your decision by deleting the provisions above and
+ * replace them with the notice and other provisions required by the GPL. If
+ * you do not delete the provisions above, a recipient may use your version
+ * of this file under either the BSD or the GPL.
+ */
+
+unsigned int
+lzf_decompress(const void *const in_data, unsigned int in_len,
+	       void *out_data, unsigned int out_len)
+{
+	u8 const *ip = in_data;
+	u8 *op = out_data;
+	u8 const *const in_end = ip + in_len;
+	u8 *const out_end = op + out_len;
+
+	do {
+		unsigned int ctrl = *ip++;
+
+		if (ctrl < (1 << 5)) {	/* literal run */
+			ctrl++;
+
+			if (op + ctrl > out_end)
+				return 0;
+
+#if USE_MEMCPY
+			memcpy(op, ip, ctrl);
+			op += ctrl;
+			ip += ctrl;
+#else
+			do
+				*op++ = *ip++;
+			while (--ctrl);
+#endif
+		} else {	/* back reference */
+
+			unsigned int len = ctrl >> 5;
+
+			u8 *ref = op - ((ctrl & 0x1f) << 8) - 1;
+
+			if (len == 7)
+				len += *ip++;
+
+			ref -= *ip++;
+
+			if (op + len + 2 > out_end)
+				return 0;
+
+			if (ref < (u8 *) out_data)
+				return 0;
+
+			*op++ = *ref++;
+			*op++ = *ref++;
+
+			do
+				*op++ = *ref++;
+			while (--len);
+		}
+	}
+	while (op < out_end && ip < in_end);
+
+	return op - (u8 *) out_data;
+}
=== lib/Kconfig
==================================================================
--- lib/Kconfig  (revision 24480)
+++ lib/Kconfig  (revision 24489)
@@ -30,6 +30,9 @@
 	  require M here.  See Castagnoli93.
 	  Module will be libcrc32c.
 
+config LZF
+	tristate "LZF Compress/Decompress Support"
+
 #
 # compression support is select'ed if needed
 #
=== lib/lzf.c
==================================================================
--- lib/lzf.c  (revision 24480)
+++ lib/lzf.c  (revision 24489)
@@ -0,0 +1,61 @@
+/*
+ * lib/lzf.c
+ *
+ * Copyright (C) 2003 Marc Lehmann <pcg@goof.com>
+ * Copyright (C) 2003,2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains LZH data compression and decompress for kernel.
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/lzf.h>
+
+/*
+ * size of hashtable is (1 << HLOG) * sizeof (char *)
+ * decompression is independent of the hash table size
+ * the difference between 15 and 14 is very small
+ * for small blocks (and 14 is also faster).
+ * For a low-memory configuration, use HLOG == 13;
+ * For best compression, use 15 or 16.
+ */
+#ifndef HLOG
+# define HLOG 14
+#endif
+
+/*
+ * sacrifice some compression quality in favour of compression speed.
+ * (roughly 1-2% worse compression for large blocks and
+ * 9-10% for small, redundant, blocks and >>20% better speed in both cases)
+ * In short: enable this for binary data, disable this for text data.
+ */
+#ifndef ULTRA_FAST
+# define ULTRA_FAST 1
+#endif
+
+#define STRICT_ALIGN 0
+#define USE_MEMCPY 1
+#define INIT_HTAB 0
+
+#include "lzf_c.c"
+#include "lzf_d.c"
+
+EXPORT_SYMBOL_GPL(lzf_compress);
+EXPORT_SYMBOL_GPL(lzf_decompress);
+
+char *lzf_new(void)
+{
+	char *wk = vmalloc_32((1 << HLOG) * sizeof(char *));
+	return (wk);
+}
+
+void lzf_free(char *wk)
+{
+	vfree(wk);
+}
+
+EXPORT_SYMBOL_GPL(lzf_new);
+EXPORT_SYMBOL_GPL(lzf_free);
=== lib/Makefile
==================================================================
--- lib/Makefile  (revision 24480)
+++ lib/Makefile  (revision 24489)
@@ -15,6 +15,7 @@
   lib-y += dec_and_lock.o
 endif
 
+
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
@@ -23,6 +24,8 @@
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 
+obj-$(CONFIG_LZF) += lzf.o
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
=== lib/lzf_c.c
==================================================================
--- lib/lzf_c.c  (revision 24480)
+++ lib/lzf_c.c  (revision 24489)
@@ -0,0 +1,209 @@
+/*
+ * Copyright (c) 2000-2003 Marc Alexander Lehmann <pcg@goof.com>
+ * 
+ * Redistribution and use in source and binary forms, with or without modifica-
+ * tion, are permitted provided that the following conditions are met:
+ * 
+ *   1.  Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ * 
+ *   2.  Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ * 
+ *   3.  The name of the author may not be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ * 
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MER-
+ * CHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
+ * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPE-
+ * CIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
+ * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTH-
+ * ERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * Alternatively, the contents of this file may be used under the terms of
+ * the GNU General Public License version 2 (the "GPL"), in which case the
+ * provisions of the GPL are applicable instead of the above. If you wish to
+ * allow the use of your version of this file only under the terms of the
+ * GPL and not to allow others to use your version of this file under the
+ * BSD license, indicate your decision by deleting the provisions above and
+ * replace them with the notice and other provisions required by the GPL. If
+ * you do not delete the provisions above, a recipient may use your version
+ * of this file under either the BSD or the GPL.
+ */
+
+#define HSIZE (1 << (HLOG))
+
+/*
+ * don't play with this unless you benchmark!
+ * decompression is not dependent on the hash function
+ * the hashing function might seem strange, just believe me
+ * it works ;)
+ */
+#define FRST(p) (((p[0]) << 8) + p[1])
+#define NEXT(v,p) (((v) << 8) + p[2])
+#define IDX(h) ((((h ^ (h << 5)) >> (3*8 - HLOG)) + h*3) & (HSIZE - 1))
+/*
+ * IDX works because it is very similar to a multiplicative hash, e.g.
+ * (h * 57321 >> (3*8 - HLOG))
+ * the next one is also quite good, albeit slow ;)
+ * (int)(cos(h & 0xffffff) * 1e6)
+ */
+
+#if 0
+/* original lzv-like hash function */
+# define FRST(p) (p[0] << 5) ^ p[1]
+# define NEXT(v,p) ((v) << 5) ^ p[2]
+# define IDX(h) ((h) & (HSIZE - 1))
+#endif
+
+#define        MAX_LIT        (1 <<  5)
+#define        MAX_OFF        (1 << 13)
+#define        MAX_REF        ((1 <<  8) + (1 << 3))
+
+/*
+ * compressed format
+ *
+ * 000LLLLL <L+1>    ; literal
+ * LLLOOOOO oooooooo ; backref L
+ * 111OOOOO LLLLLLLL oooooooo ; backref L+7
+ *
+ */
+
+unsigned int
+lzf_compress(const void *const in_data, unsigned int in_len,
+	     void *out_data, unsigned int out_len, void *hbuf)
+{
+	const u8 **htab = hbuf;
+	const u8 **hslot;
+	const u8 *ip = (const u8 *)in_data;
+	u8 *op = (u8 *) out_data;
+	const u8 *in_end = ip + in_len;
+	u8 *out_end = op + out_len;
+	const u8 *ref;
+
+	unsigned int hval = FRST(ip);
+	unsigned long off;
+	int lit = 0;
+
+#if INIT_HTAB
+# if USE_MEMCPY
+	memset(htab, 0, sizeof(htab));
+# else
+	for (hslot = htab; hslot < htab + HSIZE; hslot++)
+		*hslot++ = ip;
+# endif
+#endif
+
+	for (;;) {
+		if (ip < in_end - 2) {
+			hval = NEXT(hval, ip);
+			hslot = htab + IDX(hval);
+			ref = *hslot;
+			*hslot = ip;
+
+			if (1
+#if INIT_HTAB && !USE_MEMCPY
+			    && ref < ip	/* the next test will actually take 
+							   care of this, but this is faster */
+#endif
+			    && (off = ip - ref - 1) < MAX_OFF
+			    && ip + 4 < in_end && ref > (u8 *) in_data
+#if STRICT_ALIGN
+			    && ref[0] == ip[0]
+			    && ref[1] == ip[1]
+			    && ref[2] == ip[2]
+#else
+			    && *(u16 *) ref == *(u16 *) ip && ref[2] == ip[2]
+#endif
+			    ) {
+				/* match found at *ref++ */
+				unsigned int len = 2;
+				unsigned int maxlen = in_end - ip - len;
+				maxlen = maxlen > MAX_REF ? MAX_REF : maxlen;
+
+				do
+					len++;
+				while (len < maxlen && ref[len] == ip[len]);
+
+				if (op + lit + 1 + 3 >= out_end)
+					return 0;
+
+				if (lit) {
+					*op++ = lit - 1;
+					lit = -lit;
+					do
+						*op++ = ip[lit];
+					while (++lit);
+				}
+
+				len -= 2;
+				ip++;
+
+				if (len < 7) {
+					*op++ = (off >> 8) + (len << 5);
+				} else {
+					*op++ = (off >> 8) + (7 << 5);
+					*op++ = len - 7;
+				}
+
+				*op++ = off;
+
+#if ULTRA_FAST
+				ip += len;
+				hval = FRST(ip);
+				hval = NEXT(hval, ip);
+				htab[IDX(hval)] = ip;
+				ip++;
+#else
+				do {
+					hval = NEXT(hval, ip);
+					htab[IDX(hval)] = ip;
+					ip++;
+				}
+				while (len--);
+#endif
+				continue;
+			}
+		} else if (ip == in_end)
+			break;
+
+		/* one more literal byte we must copy */
+		lit++;
+		ip++;
+
+		if (lit == MAX_LIT) {
+			if (op + 1 + MAX_LIT >= out_end)
+				return 0;
+
+			*op++ = MAX_LIT - 1;
+#if USE_MEMCPY
+			memcpy(op, ip - MAX_LIT, MAX_LIT);
+			op += MAX_LIT;
+			lit = 0;
+#else
+			lit = -lit;
+			do
+				*op++ = ip[lit];
+			while (++lit);
+#endif
+		}
+	}
+
+	if (lit) {
+		if (op + lit + 1 >= out_end)
+			return 0;
+
+		*op++ = lit - 1;
+		lit = -lit;
+		do
+			*op++ = ip[lit];
+		while (++lit);
+	}
+
+	return op - (u8 *) out_data;
+}
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
