Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWJIJBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWJIJBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWJIJBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:01:07 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:63442 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S932417AbWJIJBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:01:06 -0400
Date: Mon, 9 Oct 2006 18:01:22 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2/2] crypto: delete duplicated code
Message-ID: <20061009090122.GA6129@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
References: <20061009085812.GA6020@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009085812.GA6020@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

crypto_alloc_tfm() and crypto_alloc_base() are almost same.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 crypto/api.c |   40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

Index: work-fault-inject/crypto/api.c
===================================================================
--- work-fault-inject.orig/crypto/api.c	2006-10-09 15:09:00.000000000 +0900
+++ work-fault-inject/crypto/api.c	2006-10-09 15:09:04.000000000 +0900
@@ -362,7 +362,8 @@ out:
 }
 EXPORT_SYMBOL_GPL(__crypto_alloc_tfm);
 
-struct crypto_tfm *crypto_alloc_tfm(const char *name, u32 flags)
+static struct crypto_tfm *crypto_alloc_tfm_base(const char *name, u32 flags,
+						u32 type, u32 mask)
 {
 	struct crypto_tfm *tfm;
 	int err;
@@ -370,7 +371,7 @@ struct crypto_tfm *crypto_alloc_tfm(cons
 	for (;;) {
 		struct crypto_alg *alg;
 
-		alg = crypto_alg_mod_lookup(name, 0, CRYPTO_ALG_ASYNC);
+		alg = crypto_alg_mod_lookup(name, type, mask);
 		if (IS_ERR(alg)) {
 			err = PTR_ERR(alg);
 			goto err;
@@ -395,6 +396,11 @@ err:
 	return ERR_PTR(err);
 }
 
+struct crypto_tfm *crypto_alloc_tfm(const char *name, u32 flags)
+{
+	return crypto_alloc_tfm_base(name, flags, 0, CRYPTO_ALG_ASYNC);
+}
+
 /*
  *	crypto_alloc_base - Locate algorithm and allocate transform
  *	@alg_name: Name of algorithm
@@ -416,35 +422,7 @@ err:
  */
 struct crypto_tfm *crypto_alloc_base(const char *alg_name, u32 type, u32 mask)
 {
-	struct crypto_tfm *tfm;
-	int err;
-
-	for (;;) {
-		struct crypto_alg *alg;
-
-		alg = crypto_alg_mod_lookup(alg_name, type, mask);
-		if (IS_ERR(alg)) {
-			err = PTR_ERR(alg);
-			goto err;
-		}
-
-		tfm = __crypto_alloc_tfm(alg, 0);
-		if (!IS_ERR(tfm))
-			return tfm;
-
-		crypto_mod_put(alg);
-		err = PTR_ERR(tfm);
-
-err:
-		if (err != -EAGAIN)
-			break;
-		if (signal_pending(current)) {
-			err = -EINTR;
-			break;
-		}
-	}
-
-	return ERR_PTR(err);
+	return crypto_alloc_tfm_base(alg_name, 0, type, mask);
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_base);
  
