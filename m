Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVBHLWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVBHLWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 06:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVBHLWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 06:22:47 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:53263 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261516AbVBHLWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 06:22:40 -0500
Date: Tue, 8 Feb 2005 12:22:38 +0100
From: Fruhwirth Clemens <clemens@endorphin.org>
To: akpm@osdl.org, jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2]: cipher mode context
Message-ID: <20050208112238.GA26750@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements context information for cipher modes. The context size
is selected with crypto_cmctx_size in api.c, the returned size is allocated 
in crypto_alloc_tfm additionally. crypto_tfm_cmctx is added to internal.h to
access the cipher mode context.

This patch's version is identical to all previously posted versions.

Signed-off-by: Fruhwirth Clemens <clemens@endorphin.org>

--- 0/crypto/api.c	2005-01-20 10:15:22.000000000 +0100
+++ 1/crypto/api.c	2005-01-20 10:15:40.000000000 +0100
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  * Copyright (c) 2002 David S. Miller (davem@redhat.com)
+ * Copyright (c) 2004 Clemens Fruhwirth <clemens@endorphin.org>
  *
  * Portions derived from Cryptoapi, by Alexander Kjeldaas <astor@fast.no>
  * and Nettle, by Niels M�ller.
@@ -23,6 +24,14 @@
 LIST_HEAD(crypto_alg_list);
 DECLARE_RWSEM(crypto_alg_sem);
 
+static inline int crypto_cmctx_size(u32 flags) 
+{
+	switch(flags & CRYPTO_TFM_MODE_MASK) {
+		default:
+			return 0;
+	}
+}
+
 static inline int crypto_alg_get(struct crypto_alg *alg)
 {
 	return try_module_get(alg->cra_module);
@@ -121,16 +130,18 @@
 {
 	struct crypto_tfm *tfm = NULL;
 	struct crypto_alg *alg;
+	int tfm_size;
 
 	alg = crypto_alg_mod_lookup(name);
 	if (alg == NULL)
 		goto out;
 	
-	tfm = kmalloc(sizeof(*tfm) + alg->cra_ctxsize, GFP_KERNEL);
+	tfm_size = sizeof(*tfm) + alg->cra_ctxsize + crypto_cmctx_size(flags);
+	tfm = kmalloc(tfm_size, GFP_KERNEL);
 	if (tfm == NULL)
 		goto out_put;
 
-	memset(tfm, 0, sizeof(*tfm) + alg->cra_ctxsize);
+	memset(tfm, 0, tfm_size);
 	
 	tfm->__crt_alg = alg;
 	
@@ -156,7 +167,7 @@
 void crypto_free_tfm(struct crypto_tfm *tfm)
 {
 	struct crypto_alg *alg = tfm->__crt_alg;
-	int size = sizeof(*tfm) + alg->cra_ctxsize;
+	int size = sizeof(*tfm) + alg->cra_ctxsize + crypto_cmctx_size(tfm->crt_cipher.cit_mode);
 
 	crypto_exit_ops(tfm);
 	crypto_alg_put(alg);
--- 0/crypto/internal.h	2005-01-20 10:15:22.000000000 +0100
+++ 1/crypto/internal.h	2005-01-20 10:15:40.000000000 +0100
@@ -47,6 +47,11 @@
 	return (void *)&tfm[1];
 }
 
+static inline void *crypto_tfm_cmctx(struct crypto_tfm *tfm)
+{
+	return ((char *)&tfm[1]) + tfm->__crt_alg->cra_ctxsize;
+}
+
 struct crypto_alg *crypto_alg_lookup(const char *name);
 
 /* A far more intelligent version of this is planned.  For now, just
