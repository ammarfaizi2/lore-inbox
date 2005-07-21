Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVGUEyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVGUEyH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 00:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGUEyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 00:54:07 -0400
Received: from [216.208.38.107] ([216.208.38.107]:60323 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261620AbVGUEyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 00:54:04 -0400
Subject: Re: LZF Cryptoapi support.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050719135441.GB2410@elf.ucw.cz>
References: <1121657429.13487.41.camel@localhost>
	 <20050719135441.GB2410@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121921767.2938.207.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 21 Jul 2005 14:56:07 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

New revision. Anything left to fix up?

Regards,

Nigel

 Kconfig  |    7 +
 Makefile |    1 
 lzf.c    |  377 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+)
diff -ruNp 260-crypto-api-lzf-support.patch-old/crypto/Kconfig 260-crypto-api-lzf-support.patch-new/crypto/Kconfig
--- 260-crypto-api-lzf-support.patch-old/crypto/Kconfig	2005-07-18 06:36:39.000000000 +1000
+++ 260-crypto-api-lzf-support.patch-new/crypto/Kconfig	2005-07-20 08:52:31.000000000 +1000
@@ -282,6 +282,13 @@ config CRYPTO_DEFLATE
 	  
 	  You will most probably want this if using IPSec.
 
+config CRYPTO_LZF
+	tristate "LZF compression algorithm"
+	depends on CRYPTO
+	help
+	  This is the LZF algorithm. It is especially useful for Suspend2,
+	  because it achieves good compression quickly.
+
 config CRYPTO_MICHAEL_MIC
 	tristate "Michael MIC keyed digest algorithm"
 	depends on CRYPTO
diff -ruNp 260-crypto-api-lzf-support.patch-old/crypto/lzf.c 260-crypto-api-lzf-support.patch-new/crypto/lzf.c
--- 260-crypto-api-lzf-support.patch-old/crypto/lzf.c	1970-01-01 10:00:00.000000000 +1000
+++ 260-crypto-api-lzf-support.patch-new/crypto/lzf.c	2005-07-21 05:10:49.000000000 +1000
@@ -0,0 +1,377 @@
+/* 
+ * Cryptoapi LZF compression module.
+ *
+ * Copyright (c) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * based on the deflate.c file:
+ * 
+ * Copyright (c) 2003 James Morris <jmorris@intercode.com.au>
+ * 
+ * and upon the LZF compression module donated to the Suspend2 project with
+ * the following copyright:
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/crypto.h>
+#include <linux/err.h>
+#include <linux/vmalloc.h>
+#include <asm/string.h>
+
+struct lzf_ctx {
+	void *hbuf;
+	char *local_buffer;
+	char *page_buffer;
+	unsigned int bufofs;
+	int first_call;
+};
+
+/*
+ * size of hashtable is (1 << hlog) * sizeof (char *)
+ * decompression is independent of the hash table size
+ * the difference between 15 and 14 is very small
+ * for small blocks (and 14 is also faster).
+ * For a low-memory configuration, use hlog == 13;
+ * For best compression, use 15 or 16.
+ */
+static const int hlog = 14;
+
+/*
+ * don't play with this unless you benchmark!
+ * decompression is not dependent on the hash function
+ * the hashing function might seem strange, just believe me
+ * it works ;)
+ */
+static inline u16 first(const u8 * p)
+{
+	return ((p[0]) << 8) + p[1];
+}
+
+static inline u16 next(u8 v, const u8 * p)
+{
+	return ((v) << 8) + p[2];
+}
+
+static inline u32 idx(unsigned int h)
+{
+	return (((h ^ (h << 5)) >> (3*8 - hlog)) + h*3) & ((1 << hlog) - 1);
+}
+
+/*
+ * IDX works because it is very similar to a multiplicative hash, e.g.
+ * (h * 57321 >> (3*8 - hlog))
+ * the next one is also quite good, albeit slow ;)
+ * (int)(cos(h & 0xffffff) * 1e6)
+ */
+
+static const int max_lit = (1 <<  5);
+static const int max_off = (1 << 13);
+static const int max_ref = ((1 <<  8) + (1 << 3));
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
+static void lzf_compress_exit(void *context)
+{
+	struct lzf_ctx *ctx = (struct lzf_ctx *)context;
+
+	if (ctx->local_buffer) {
+		free_page((unsigned long)ctx->local_buffer);
+		ctx->local_buffer = NULL;
+	}
+
+	if (ctx->page_buffer) {
+		free_page((unsigned long)ctx->page_buffer);
+		ctx->page_buffer = NULL;
+	}
+
+	if (ctx->hbuf) {
+		vfree(ctx->hbuf);
+		ctx->hbuf = NULL;
+	}
+
+	ctx->first_call = 0;
+}
+
+static int lzf_compress_init(void *context)
+{
+	struct lzf_ctx *ctx = (struct lzf_ctx *)context;
+
+	/* Get LZF ready to go */
+	ctx->hbuf = vmalloc_32((1 << hlog) * sizeof(char *));
+	if (!ctx->hbuf) {
+		printk(KERN_WARNING
+		       "Failed to allocate %d bytes for lzf workspace\n",
+		       (1 << hlog) * sizeof(char *));
+		return -ENOMEM;
+	}
+
+	/* Allocate local buffer */
+	ctx->local_buffer = (char *)get_zeroed_page(GFP_ATOMIC);
+
+	if (!ctx->local_buffer) {
+		lzf_compress_exit(ctx);
+		return -ENOMEM;
+	}
+
+	/* Allocate page buffer */
+	ctx->page_buffer = (char *)get_zeroed_page(GFP_ATOMIC);
+
+	if (!ctx->page_buffer) {
+		free_page((unsigned long)ctx->local_buffer);
+		lzf_compress_exit(ctx);
+		return -ENOMEM;
+	}
+
+	ctx->first_call = 1;
+
+	return 0;
+}
+
+static int lzf_compress(void *context, const u8 * in_data, unsigned int in_len,
+			u8 * out_data, unsigned int *out_len)
+{
+	struct lzf_ctx *ctx = (struct lzf_ctx *)context;
+	const u8 **htab = ctx->hbuf;
+	const u8 **hslot;
+	const u8 *ip = in_data;
+	u8 *op = out_data;
+	const u8 *in_end = ip + in_len;
+	u8 *out_end = op + *out_len - 3;
+	const u8 *ref;
+
+	unsigned int hval = first(ip);
+	unsigned long off;
+	int lit = 0;
+
+	if (ctx->first_call) {
+		ctx->first_call = 0;
+	}
+	memset(htab, 0, sizeof(htab));
+
+	for (;;) {
+		if (ip < in_end - 2) {
+			hval = next(hval, ip);
+			hslot = htab + idx(hval);
+			ref = *hslot;
+			*hslot = ip;
+
+			if ((off = ip - ref - 1) < max_off
+			    && ip + 4 < in_end && ref > in_data
+			    && *(u16 *) ref == *(u16 *) ip && ref[2] == ip[2]
+			    ) {
+				/* match found at *ref++ */
+				unsigned int len = 2;
+				unsigned int maxlen = in_end - ip - len;
+				maxlen = maxlen > max_ref ? max_ref : maxlen;
+
+				do
+					len++;
+				while (len < maxlen && ref[len] == ip[len]);
+
+				if (op + lit + 1 + 3 >= out_end) {
+					*out_len = PAGE_SIZE;
+					return 0;
+				}
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
+				ip += len;
+				hval = first(ip);
+				hval = next(hval, ip);
+				htab[idx(hval)] = ip;
+				ip++;
+				continue;
+			}
+		} else if (ip == in_end)
+			break;
+
+		/* one more literal byte we must copy */
+		lit++;
+		ip++;
+
+		if (lit == max_lit) {
+			if (op + 1 + max_lit >= out_end) {
+				*out_len = PAGE_SIZE;
+				return 0;
+			}
+
+			*op++ = max_lit - 1;
+			memcpy(op, ip - max_lit, max_lit);
+			op += max_lit;
+			lit = 0;
+		}
+	}
+
+	if (lit) {
+		if (op + lit + 1 >= out_end) {
+			*out_len = PAGE_SIZE;
+			return 0;
+		}
+
+		*op++ = lit - 1;
+		lit = -lit;
+		do
+			*op++ = ip[lit];
+		while (++lit);
+	}
+
+	*out_len = op - out_data;
+	return 0;
+}
+
+static int lzf_decompress(void *context, const u8 * src, unsigned int slen,
+			  u8 * dst, unsigned int *dlen)
+{
+	struct lzf_ctx *ctx = (struct lzf_ctx *)context;
+	u8 const *ip = src;
+	u8 *op = dst;
+	u8 const *const in_end = ip + slen;
+	u8 *const out_end = op + *dlen;
+
+	if (ctx->first_call) {
+		ctx->first_call = 0;
+	}
+	do {
+		unsigned int ctrl = *ip++;
+
+		if (ctrl < (1 << 5)) {	/* literal run */
+			ctrl++;
+
+			if (op + ctrl > out_end) {
+				*dlen = PAGE_SIZE;
+				return 0;
+			}
+			memcpy(op, ip, ctrl);
+			op += ctrl;
+			ip += ctrl;
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
+			if (op + len + 2 > out_end) {
+				*dlen = PAGE_SIZE;
+				return 0;
+			}
+
+			if (ref < (u8 *) dst) {
+				*dlen = PAGE_SIZE;
+				return 0;
+			}
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
+	*dlen = op - (u8 *) dst;
+	return 0;
+}
+
+static struct crypto_alg alg = {
+	.cra_name = "lzf",
+	.cra_flags = CRYPTO_ALG_TYPE_COMPRESS,
+	.cra_ctxsize = 0,
+	.cra_module = THIS_MODULE,
+	.cra_list = LIST_HEAD_INIT(alg.cra_list),
+	.cra_u = {.compress = {
+			       .coa_init = lzf_compress_init,
+			       .coa_exit = lzf_compress_exit,
+			       .coa_compress = lzf_compress,
+			       .coa_decompress = lzf_decompress}}
+};
+
+static int __init init(void)
+{
+	return crypto_register_alg(&alg);
+}
+
+static void __exit fini(void)
+{
+	crypto_unregister_alg(&alg);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LZF Compression Algorithm");
+MODULE_AUTHOR("Marc Alexander Lehmann & Nigel Cunningham");
diff -ruNp 260-crypto-api-lzf-support.patch-old/crypto/Makefile 260-crypto-api-lzf-support.patch-new/crypto/Makefile
--- 260-crypto-api-lzf-support.patch-old/crypto/Makefile	2005-06-20 11:46:49.000000000 +1000
+++ 260-crypto-api-lzf-support.patch-new/crypto/Makefile	2005-07-20 08:52:31.000000000 +1000
@@ -30,5 +30,6 @@ obj-$(CONFIG_CRYPTO_ANUBIS) += anubis.o
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
 obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
+obj-$(CONFIG_CRYPTO_LZF) += lzf.o
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

