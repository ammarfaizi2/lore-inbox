Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWJII55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWJII55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWJII55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:57:57 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:21442 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S932416AbWJII54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:57:56 -0400
Date: Mon, 9 Oct 2006 17:58:12 +0900
To: linux-kernel@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 1/2] crypto: fix crypto_alloc_{tfm,base}() return value
Message-ID: <20061009085812.GA6020@localhost>
Mail-Followup-To: akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: akinobu.mita@gmail.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

crypto_alloc_tfm() and crypto_alloc_base() are suppose to return error code
as pointer on failures. But there are some cases where they return NULL
(for example, crypto_alloc_tfm() returns NULL on kzalloc() failure)

This patch fixes that wrong return value, and also fixes tcrypt so that it can
detect error code correctly.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 crypto/api.c    |   47 ++++++++++++++++++++++++++++-------------------
 crypto/tcrypt.c |    5 +++--
 2 files changed, 31 insertions(+), 21 deletions(-)

Index: work-fault-inject/crypto/tcrypt.c
===================================================================
--- work-fault-inject.orig/crypto/tcrypt.c	2006-10-09 15:06:37.000000000 +0900
+++ work-fault-inject/crypto/tcrypt.c	2006-10-09 15:09:00.000000000 +0900
@@ -766,8 +766,9 @@ static void test_deflate(void)
 	tv = (void *)tvmem;
 
 	tfm = crypto_alloc_tfm("deflate", 0);
-	if (tfm == NULL) {
-		printk("failed to load transform for deflate\n");
+	if (IS_ERR(tfm)) {
+		printk("failed to load transform for deflate: %ld\n",
+				PTR_ERR(tfm));
 		return;
 	}
 
Index: work-fault-inject/crypto/api.c
===================================================================
--- work-fault-inject.orig/crypto/api.c	2006-10-09 15:06:37.000000000 +0900
+++ work-fault-inject/crypto/api.c	2006-10-09 15:09:00.000000000 +0900
@@ -331,7 +331,7 @@ struct crypto_tfm *__crypto_alloc_tfm(st
 	tfm_size = sizeof(*tfm) + crypto_ctxsize(alg, flags);
 	tfm = kzalloc(tfm_size, GFP_KERNEL);
 	if (tfm == NULL)
-		goto out;
+		goto out_err;
 
 	tfm->__crt_alg = alg;
 
@@ -355,6 +355,7 @@ cra_init_failed:
 	crypto_exit_ops(tfm);
 out_free_tfm:
 	kfree(tfm);
+out_err:
 	tfm = ERR_PTR(err);
 out:
 	return tfm;
@@ -363,27 +364,35 @@ EXPORT_SYMBOL_GPL(__crypto_alloc_tfm);
 
 struct crypto_tfm *crypto_alloc_tfm(const char *name, u32 flags)
 {
-	struct crypto_tfm *tfm = NULL;
+	struct crypto_tfm *tfm;
 	int err;
 
-	do {
+	for (;;) {
 		struct crypto_alg *alg;
 
 		alg = crypto_alg_mod_lookup(name, 0, CRYPTO_ALG_ASYNC);
-		err = PTR_ERR(alg);
-		if (IS_ERR(alg))
-			continue;
+		if (IS_ERR(alg)) {
+			err = PTR_ERR(alg);
+			goto err;
+		}
 
 		tfm = __crypto_alloc_tfm(alg, flags);
-		err = 0;
-		if (IS_ERR(tfm)) {
-			crypto_mod_put(alg);
-			err = PTR_ERR(tfm);
-			tfm = NULL;
+		if (!IS_ERR(tfm))
+			return tfm;
+
+		crypto_mod_put(alg);
+		err = PTR_ERR(tfm);
+
+err:
+		if (err != -EAGAIN)
+			break;
+		if (signal_pending(current)) {
+			err = -EINTR;
+			break;
 		}
-	} while (err == -EAGAIN && !signal_pending(current));
+	}
 
-	return tfm;
+	return ERR_PTR(err);
 }
 
 /*
@@ -414,14 +423,14 @@ struct crypto_tfm *crypto_alloc_base(con
 		struct crypto_alg *alg;
 
 		alg = crypto_alg_mod_lookup(alg_name, type, mask);
-		err = PTR_ERR(alg);
-		tfm = ERR_PTR(err);
-		if (IS_ERR(alg))
+		if (IS_ERR(alg)) {
+			err = PTR_ERR(alg);
 			goto err;
+		}
 
 		tfm = __crypto_alloc_tfm(alg, 0);
 		if (!IS_ERR(tfm))
-			break;
+			return tfm;
 
 		crypto_mod_put(alg);
 		err = PTR_ERR(tfm);
@@ -433,9 +442,9 @@ err:
 			err = -EINTR;
 			break;
 		}
-	};
+	}
 
-	return tfm;
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_base);
  
