Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWCID0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWCID0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbWCID0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:26:43 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:6029 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751527AbWCID0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:26:42 -0500
Date: Thu, 09 Mar 2006 12:26:38 +0900 (JST)
Message-Id: <20060309.122638.07642914.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, akpm@osdl.org
Subject: [PATCH] crypto: fix unaligned access in khazad module
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit platform, reading directly from keys (which supposed to be
32-bit aligned) will result in unaligned access.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/crypto/khazad.c b/crypto/khazad.c
index 807f2bf..c7e1d25 100644
--- a/crypto/khazad.c
+++ b/crypto/khazad.c
@@ -26,6 +26,7 @@
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
 #include <linux/types.h>
+#include <asm/unaligned.h>
 
 #define KHAZAD_KEY_SIZE		16
 #define KHAZAD_BLOCK_SIZE	8
@@ -769,8 +770,8 @@ static int khazad_setkey(void *ctx_arg, 
 		return -EINVAL;
 	}
 
-	K2 = be64_to_cpu(key[0]);
-	K1 = be64_to_cpu(key[1]);
+	K2 = be64_to_cpu(get_unaligned(&key[0]));
+	K1 = be64_to_cpu(get_unaligned(&key[1]));
 
 	/* setup the encrypt key */
 	for (r = 0; r <= KHAZAD_ROUNDS; r++) {
