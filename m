Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVC1RXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVC1RXe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVC1RXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:23:34 -0500
Received: from [213.170.72.194] ([213.170.72.194]:16600 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261957AbVC1RWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:22:43 -0500
Subject: Re: [RFC] CryptoAPI & Compression
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com
In-Reply-To: <20050326044421.GA24358@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru>
	 <20050326044421.GA24358@gondor.apana.org.au>
Content-Type: multipart/mixed; boundary="=-rfUVzs03Uf/MPhGFM5yl"
Organization: MTD
Date: Mon, 28 Mar 2005 21:22:36 +0400
Message-Id: <1112030556.17983.35.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rfUVzs03Uf/MPhGFM5yl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-03-26 at 15:44 +1100, Herbert Xu wrote: 
> I've whipped up something quick and called it crypto_comp_pcompress.
> How does this interface look to you?

Hello Herbert,

I've done some work. Here are 2 patches:
1. pcompress-deflate-1.diff
2. uncompress-1.diff
(should be applied in that order). And I also imply your patch is
applied as well.

The first patch is the implementation of the deflate_pcompress()
function. It was ported from JFFS2 with some changes.
The second patch is my implementation of the deflate_decompr() function
and I'd like to hear some comments on this.

I made the changes to deflate_decompr() because the old version doesn't
work properly for me. There are 2 changes.

1. I've added the following code:

------------------------------------------------------------------------
if (slen > 2 && !(src[1] & PRESET_DICT) /* No preset dictionary */
    && ((src[0] & 0x0f) == Z_DEFLATED)  /* Comp. method byte is OK */
    && !(((src[0] << 8) + src[1]) % 31)) {      /* CMF*256 + FLG */
    stream->next_in += 2;
    stream->avail_in -= 2;
}
------------------------------------------------------------------------

This peace of code checks if there are 2 header bytes (see RFC-1950)
present in the stream to be inflated. If they are present, we should
skip them because we use a negative windowBits parameter when we
initialize inflate. When this "undocumented" feature is used, zlib
ignores the stream header and doesn't check the adler32 checksum (I've
found this roughly exploring the inflate source code). If we don't skip
the first 2 bytes, inflate will treat them as the part of the input data
and will work incorrectly.

I don't know how deflate_decompr() worked before, it shouldn't have
worked AFAICS. So, I'm in doubt and would like to see your or James'
comments.

2. I've removed the "strange" (for me) uncompress sequence:

------------------------------------------------------------------------
ret = zlib_inflate(stream, Z_SYNC_FLUSH);
/*
 * Work around a bug in zlib, which sometimes wants to taste an extra
 * byte when being used in the (undocumented) raw deflate mode.
 * (From USAGI).
 */
if (ret == Z_OK && !stream->avail_in && stream->avail_out) {
    u8 zerostuff = 0;
    stream->next_in = &zerostuff;
    stream->avail_in = 1;
    ret = zlib_inflate(stream, Z_FINISH);
}
------------------------------------------------------------------------

and have changed it to the following:

------------------------------------------------------------------------
ret = zlib_inflate(stream, Z_FINISH);
if (ret != Z_STREAM_END)
   return -EINVAL;
------------------------------------------------------------------------

I made this because the old sequence didn't uncompress data compressed
by my deflate_pcompress(). Frankly, I just don't understand the meaning
of that replaced part and changed it to what seems correct and obvious
for me. My argument is the documentation of zlib_inflate() from
include/linux/zlib.h:

------------------------------------------------------------------------
inflate() should normally be called until it returns Z_STREAM_END or an
error. However if all decompression is to be performed in a single step
(a single call of inflate), the parameter flush should be set to
Z_FINISH. In this case all pending input is processed and all pending
output is flushed; avail_out must be large enough to hold all the
uncompressed data.
------------------------------------------------------------------------

I don't know anything about the declared bug "(From USAGI)".
So I'd like to hear some comment on this as well.

Also I've simplified error handling a bit.

The stuff I'm sending works for me. I also run the tcrypt.c test module,
and the deflate/inflate tests passed.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

--=-rfUVzs03Uf/MPhGFM5yl
Content-Disposition: attachment; filename=pcompress-deflate-1.diff
Content-Type: text/x-patch; name=pcompress-deflate-1.diff; charset=KOI8-R
Content-Transfer-Encoding: 7bit

diff -auNrp linux-2.6.11.5/crypto/deflate.c linux-2.6.11.5_changed/crypto/deflate.c
--- linux-2.6.11.5/crypto/deflate.c	2005-03-28 20:39:27.000000000 +0400
+++ linux-2.6.11.5_changed/crypto/deflate.c	2005-03-28 20:40:02.295158356 +0400
@@ -5,6 +5,7 @@
  * by IPCOMP (RFC 3173 & RFC 2394).
  *
  * Copyright (c) 2003 James Morris <jmorris@intercode.com.au>
+ * Copyright (c) 2005 David Woodhouse <dwmw2@infradead.org>
  * 
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -38,6 +39,8 @@
 #define DEFLATE_DEF_WINBITS		11
 #define DEFLATE_DEF_MEMLEVEL		MAX_MEM_LEVEL
 
+#define DEFLATE_PCOMPR_RESERVE		12
+
 struct deflate_ctx {
 	struct z_stream_s comp_stream;
 	struct z_stream_s decomp_stream;
@@ -150,6 +153,47 @@ out:
 	return ret;
 }
  
+static int deflate_pcompress(void *ctx, const u8 *src, unsigned int *slen,
+	                     u8 *dst, unsigned int *dlen)
+{
+	int ret;
+	struct deflate_ctx *dctx = ctx;
+	struct z_stream_s *stream = &dctx->comp_stream;
+
+	if (*dlen <= DEFLATE_PCOMPR_RESERVE)
+		return -EINVAL;
+
+	ret = zlib_deflateReset(stream);
+	if (ret != Z_OK)
+		return -EINVAL;
+
+	stream->next_in = (u8 *)src;
+	stream->next_out = dst;
+
+	while (stream->total_in < *slen
+	       && stream->total_out < *dlen - DEFLATE_PCOMPR_RESERVE) {
+
+		stream->avail_out = *dlen - DEFLATE_PCOMPR_RESERVE - stream->total_out;
+		stream->avail_in = min((unsigned int)(*slen - stream->total_in), stream->avail_out);
+
+		ret = zlib_deflate(stream, Z_SYNC_FLUSH);
+		if (ret != Z_OK)
+			return -EINVAL;
+	}
+
+	stream->avail_out += DEFLATE_PCOMPR_RESERVE;
+	stream->avail_in = 0;
+
+	ret = zlib_deflate(stream, Z_FINISH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
+	*dlen = stream->total_out;
+	*slen = stream->total_in;
+
+	return 0;
+}
+ 
 static int deflate_decompress(void *ctx, const u8 *src, unsigned int slen,
                               u8 *dst, unsigned int *dlen)
 {
@@ -201,6 +245,7 @@ static struct crypto_alg alg = {
 	.coa_init		= deflate_init,
 	.coa_exit		= deflate_exit,
 	.coa_compress 		= deflate_compress,
+	.coa_pcompress 		= deflate_pcompress,
 	.coa_decompress  	= deflate_decompress } }
 };
 

--=-rfUVzs03Uf/MPhGFM5yl
Content-Disposition: attachment; filename=uncompress-1.diff
Content-Type: text/x-patch; name=uncompress-1.diff; charset=KOI8-R
Content-Transfer-Encoding: 7bit

diff -auNrp linux-2.6.11.5/crypto/deflate.c linux-2.6.11.5_changed/crypto/deflate.c
--- linux-2.6.11.5/crypto/deflate.c	2005-03-28 21:04:53.279048342 +0400
+++ linux-2.6.11.5_changed/crypto/deflate.c	2005-03-28 21:02:38.000000000 +0400
@@ -6,6 +6,7 @@
  *
  * Copyright (c) 2003 James Morris <jmorris@intercode.com.au>
  * Copyright (c) 2005 David Woodhouse <dwmw2@infradead.org>
+ * Copyright (c) 2005 Artem B. Bityuckiy <dedekind@infradead.org>
  * 
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -29,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/crypto.h>
 #include <linux/zlib.h>
+#include <linux/zutil.h>
 #include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
@@ -197,42 +199,41 @@ static int deflate_pcompress(void *ctx, 
 static int deflate_decompress(void *ctx, const u8 *src, unsigned int slen,
                               u8 *dst, unsigned int *dlen)
 {
-	
-	int ret = 0;
+	int ret;
 	struct deflate_ctx *dctx = ctx;
 	struct z_stream_s *stream = &dctx->decomp_stream;
 
 	ret = zlib_inflateReset(stream);
-	if (ret != Z_OK) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (ret != Z_OK)
+		return -EINVAL;
 
 	stream->next_in = (u8 *)src;
 	stream->avail_in = slen;
 	stream->next_out = (u8 *)dst;
 	stream->avail_out = *dlen;
 
-	ret = zlib_inflate(stream, Z_SYNC_FLUSH);
-	/*
-	 * Work around a bug in zlib, which sometimes wants to taste an extra
-	 * byte when being used in the (undocumented) raw deflate mode.
-	 * (From USAGI).
-	 */
-	if (ret == Z_OK && !stream->avail_in && stream->avail_out) {
-		u8 zerostuff = 0;
-		stream->next_in = &zerostuff;
-		stream->avail_in = 1; 
-		ret = zlib_inflate(stream, Z_FINISH);
-	}
-	if (ret != Z_STREAM_END) {
-		ret = -EINVAL;
-		goto out;
+
+	/* Since we use the undocumented Inflate feature passing the
+	 * negative windowBits parameter to the zlib_inflateInit2()
+	 * function, we must not pass the first 2 stream bytes to
+	 * zlib_inflate() since it will treat them as data, not as
+	 * CFM/FLG bytes (see RFC-1950).
+	 * Thus, wi check if the first 2 bytes are the stream header and
+	 * skip them if they are.*/
+	if (slen > 2 && !(src[1] & PRESET_DICT)	/* No preset dictionary */
+	    && ((src[0] & 0x0f) == Z_DEFLATED)	/* Comp. method byte is OK */
+	    && !(((src[0] << 8) + src[1]) % 31)) {	/* CMF*256 + FLG */
+		stream->next_in += 2;
+		stream->avail_in -= 2;
 	}
-	ret = 0;
+
+	ret = zlib_inflate(stream, Z_FINISH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
 	*dlen = stream->total_out;
-out:
-	return ret;
+
+	return 0;
 }
 
 static struct crypto_alg alg = {

--=-rfUVzs03Uf/MPhGFM5yl--

