Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVGROTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVGROTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVGROTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:19:08 -0400
Received: from Quebec-HSE-ppp231061.qc.sympatico.ca ([69.159.205.163]:7153
	"EHLO cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261771AbVGROSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:18:08 -0400
Subject: [PATCH] Fix cryptoapi deflate not handling PAGE_SIZE chunks.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121657195.13487.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 18 Jul 2005 13:26:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert.

Here's a resend of a patch I'm using in Suspend2's new cryptoapi
support, which is needed for us to successfully compress pages using
deflate. It's along the lines of the existing fix in the decompression
code.

Regards,

Nigel

diff -ruNp 190-cryptoapi-deflate.patch-old/crypto/deflate.c 190-cryptoapi-deflate.patch-new/crypto/deflate.c
--- 190-cryptoapi-deflate.patch-old/crypto/deflate.c	2005-06-20 11:46:49.000000000 +1000
+++ 190-cryptoapi-deflate.patch-new/crypto/deflate.c	2005-07-04 23:14:20.000000000 +1000
@@ -143,8 +143,15 @@ static int deflate_compress(void *ctx, c
 
 	ret = zlib_deflate(stream, Z_FINISH);
 	if (ret != Z_STREAM_END) {
-		ret = -EINVAL;
-		goto out;
+	    	if (!(ret == Z_OK && !stream->avail_in && !stream->avail_out)) {
+			ret = -EINVAL;
+			goto out;
+		} else {
+			u8 zerostuff = 0;
+			stream->next_out = &zerostuff;
+			stream->avail_out = 1; 
+			ret = zlib_deflate(stream, Z_FINISH);
+		}
 	}
 	ret = 0;
 	*dlen = stream->total_out;

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

