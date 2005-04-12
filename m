Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVDLUBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVDLUBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVDLT7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:59:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:37320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262150AbVDLKbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:45 -0400
Message-Id: <200504121030.j3CAUjHN005139@shell0.pdx.osdl.net>
Subject: [patch 007/198] crypto: call zlib end functions on deflate exit path
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dedekind@infradead.org,
       davem@davemloft.net, herbert@gondor.apana.org.au
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Artem B. Bityuckiy <dedekind@infradead.org>

In the deflate_[compress|uncompress|pcompress] functions we call the
zlib_[in|de]flateReset function at the beginning.  This is OK.  But when we
unload the deflate module we don't call zlib_[in|de]flateEnd to free all
the zlib internal data.  It looks like a bug for me.  Please, consider the
attached patch.

Signed-off-by: Artem B. Bityuckiy <dedekind@infradead.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/crypto/deflate.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN crypto/deflate.c~crypto-call-zlib-end-functions-on-deflate-exit-path crypto/deflate.c
--- 25/crypto/deflate.c~crypto-call-zlib-end-functions-on-deflate-exit-path	2005-04-12 03:21:05.178349672 -0700
+++ 25-akpm/crypto/deflate.c	2005-04-12 03:21:05.181349216 -0700
@@ -93,11 +93,13 @@ out_free:
 
 static void deflate_comp_exit(struct deflate_ctx *ctx)
 {
+	zlib_deflateEnd(&ctx->comp_stream);
 	vfree(ctx->comp_stream.workspace);
 }
 
 static void deflate_decomp_exit(struct deflate_ctx *ctx)
 {
+	zlib_inflateEnd(&ctx->decomp_stream);
 	kfree(ctx->decomp_stream.workspace);
 }
 
_
