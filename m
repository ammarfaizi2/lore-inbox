Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVIHBbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVIHBbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932862AbVIHB3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:29:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932851AbVIHB3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:29:38 -0400
Message-Id: <20050908012901.227702000@localhost.localdomain>
References: <20050908012842.299637000@localhost.localdomain>
Date: Wed, 07 Sep 2005 18:28:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Krzysztof Oledzki <olel@ans.pl>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 6/9] [CRYPTO] Fix boundary check in standard multi-block cipher processors
Content-Disposition: inline; filename=ipsec-oops-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

[CRYPTO] Fix boundary check in standard multi-block cipher processors

Fixes Bug 5194 (IPSec related Oops in 2.6.13).

The boundary check in the standard multi-block cipher processors are
broken when nbytes is not a multiple of bsize.  In those cases it will
always process an extra block.

This patch corrects the check so that it processes at most nbytes of data.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 crypto/cipher.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-2.6.13.y/crypto/cipher.c
===================================================================
--- linux-2.6.13.y.orig/crypto/cipher.c
+++ linux-2.6.13.y/crypto/cipher.c
@@ -191,6 +191,8 @@ static unsigned int cbc_process_encrypt(
 	u8 *iv = desc->info;
 	unsigned int done = 0;
 
+	nbytes -= bsize;
+
 	do {
 		xor(iv, src);
 		fn(crypto_tfm_ctx(tfm), dst, iv);
@@ -198,7 +200,7 @@ static unsigned int cbc_process_encrypt(
 
 		src += bsize;
 		dst += bsize;
-	} while ((done += bsize) < nbytes);
+	} while ((done += bsize) <= nbytes);
 
 	return done;
 }
@@ -219,6 +221,8 @@ static unsigned int cbc_process_decrypt(
 	u8 *iv = desc->info;
 	unsigned int done = 0;
 
+	nbytes -= bsize;
+
 	do {
 		u8 *tmp_dst = *dst_p;
 
@@ -230,7 +234,7 @@ static unsigned int cbc_process_decrypt(
 
 		src += bsize;
 		dst += bsize;
-	} while ((done += bsize) < nbytes);
+	} while ((done += bsize) <= nbytes);
 
 	return done;
 }
@@ -243,12 +247,14 @@ static unsigned int ecb_process(const st
 	void (*fn)(void *, u8 *, const u8 *) = desc->crfn;
 	unsigned int done = 0;
 
+	nbytes -= bsize;
+
 	do {
 		fn(crypto_tfm_ctx(tfm), dst, src);
 
 		src += bsize;
 		dst += bsize;
-	} while ((done += bsize) < nbytes);
+	} while ((done += bsize) <= nbytes);
 
 	return done;
 }

--
