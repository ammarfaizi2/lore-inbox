Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSLHJXk>; Sun, 8 Dec 2002 04:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSLHJXj>; Sun, 8 Dec 2002 04:23:39 -0500
Received: from h-64-105-35-2.SNVACAID.covad.net ([64.105.35.2]:23483 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265266AbSLHJXh>; Sun, 8 Dec 2002 04:23:37 -0500
Date: Sun, 8 Dec 2002 01:27:27 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: jmorris@intercode.com.au, davem@redhat.com, astor@fast.no
Cc: linux-kernel@vger.kernel.org
Subject: Patch(2.5.50): Simplify crypto memory allocation
Message-ID: <20021208012727.A24577@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch deletes the unused
crypto_tfm.crt_work_block field and combines the remaining
two kmallocs done by crypto_alloc_tfm into one, a net
deletion of 25 lines.

	I've only verified that the kernel and the crpypto modules
still build.  I don't currently use this code, although I'm
considering making a version of loop.c which would, which is why I
noticed this.

	Anyhow, if this patch turns out to work and looks OK, then
please integrate, queue it for Linus, etc., or let me know if you
would prefer that you or I follow some other course of action.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crypt.diff"

--- linux-2.5.50/include/linux/crypto.h	2002-11-27 14:35:54.000000000 -0800
+++ linux/include/linux/crypto.h	2002-12-08 01:06:24.000000000 -0800
@@ -161,7 +161,6 @@
 struct crypto_tfm {
 
 	void *crt_ctx;
-	void *crt_work_block;
 	u32 crt_flags;
 	
 	union {
--- linux-2.5.50/crypto/api.c	2002-11-27 14:36:21.000000000 -0800
+++ linux/crypto/api.c	2002-12-08 01:06:35.000000000 -0800
@@ -124,44 +124,26 @@
 	if (alg == NULL)
 		goto out;
 	
-	tfm = kmalloc(sizeof(*tfm), GFP_KERNEL);
+	tfm = kmalloc(sizeof(*tfm) + alg->cra_ctxsize, GFP_KERNEL);
 	if (tfm == NULL)
 		goto out_put;
 
 	memset(tfm, 0, sizeof(*tfm));
 	
-	if (alg->cra_ctxsize) {
-		tfm->crt_ctx = kmalloc(alg->cra_ctxsize, GFP_KERNEL);
-		if (tfm->crt_ctx == NULL)
-			goto out_free_tfm;
-	}
+	tfm->crt_ctx = (void*) &tfm[1];
 
 	tfm->__crt_alg = alg;
 	
-	if (alg->cra_blocksize) {
-		tfm->crt_work_block = kmalloc(alg->cra_blocksize + 1,
-					      GFP_KERNEL);
-		if (tfm->crt_work_block == NULL)
-			goto out_free_ctx;
-	}
-
 	if (crypto_init_flags(tfm, flags))
-		goto out_free_work_block;
+		goto out_free_tfm;
 		
 	if (crypto_init_ops(tfm)) {
 		crypto_exit_ops(tfm);
-		goto out_free_ctx;
+		goto out_free_tfm;
 	}
 
 	goto out;
 
-out_free_work_block:
-	if (tfm->__crt_alg->cra_blocksize)
-		kfree(tfm->crt_work_block);
-
-out_free_ctx:
-	if (tfm->__crt_alg->cra_ctxsize)
-		kfree(tfm->crt_ctx);
 out_free_tfm:
 	kfree(tfm);
 	tfm = NULL;
@@ -173,12 +155,6 @@
 
 void crypto_free_tfm(struct crypto_tfm *tfm)
 {
-	if (tfm->__crt_alg->cra_ctxsize)
-		kfree(tfm->crt_ctx);
-		
-	if (tfm->__crt_alg->cra_blocksize)
-		kfree(tfm->crt_work_block);
-		
 	if (crypto_tfm_alg_type(tfm) == CRYPTO_ALG_TYPE_CIPHER)
 		if (tfm->crt_cipher.cit_iv)
 			kfree(tfm->crt_cipher.cit_iv);

--FCuugMFkClbJLl1L--
