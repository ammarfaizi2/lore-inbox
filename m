Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUBYVvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUBYVsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:48:12 -0500
Received: from waste.org ([209.173.204.2]:17893 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261634AbUBYVnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:43:52 -0500
Date: Wed, 25 Feb 2004 15:43:08 -0600
From: Matt Mackall <mpm@selenic.com>
To: Christophe Saout <christophe@saout.de>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040225214308.GD3883@waste.org>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040219111835.192d2741.akpm@osdl.org> <20040220171427.GD9266@certainkey.com> <20040221021724.GA8841@leto.cs.pocnet.net> <20040224191142.GT3883@waste.org> <1077651839.11170.4.camel@leto.cs.pocnet.net> <20040224203825.GV3883@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224203825.GV3883@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 02:38:25PM -0600, Matt Mackall wrote:
> On Tue, Feb 24, 2004 at 08:43:59PM +0100, Christophe Saout wrote:
> > Yes, I thought of something like this.
> 
> Ok, I might get to this by this afternoon. 
> 

Ok, here's my proposed API extension (currently untested). Christophe,
care to give it a spin?

 tiny-mpm/crypto/api.c           |   21 +++++++++++++++++++++
 tiny-mpm/include/linux/crypto.h |   17 +++++++++++++++++
 2 files changed, 38 insertions(+)

diff -puN crypto/api.c~crypto-copy crypto/api.c
--- tiny/crypto/api.c~crypto-copy	2004-02-25 15:12:43.000000000 -0600
+++ tiny-mpm/crypto/api.c	2004-02-25 15:37:39.000000000 -0600
@@ -161,6 +161,27 @@ void crypto_free_tfm(struct crypto_tfm *
 	kfree(tfm);
 }
 
+int crypto_copy_tfm(char *dst, const struct crypto_tfm *src, unsigned size)
+{
+	int s = crypto_tfm_size(src);
+
+	if (size < s)
+		return 0;
+
+	crypto_alg_get(tfm->__crt_alg);
+
+	/* currently assumes shallow copy is sufficient */
+	memcpy(tfm, cc->digest, s);
+
+	return s;
+}
+
+void crypto_cleanup_copy_tfm(char *user_tfm)
+{
+	crypto_exit_ops((struct crypto_tfm *)user_tfm);
+	crypto_alg_put((struct crypto_tfm *)user_tfm->__crt_alg);
+}
+
 int crypto_register_alg(struct crypto_alg *alg)
 {
 	int ret = 0;
diff -puN include/linux/crypto.h~crypto-copy include/linux/crypto.h
--- tiny/include/linux/crypto.h~crypto-copy	2004-02-25 15:12:43.000000000 -0600
+++ tiny-mpm/include/linux/crypto.h	2004-02-25 15:26:23.000000000 -0600
@@ -208,6 +208,23 @@ struct crypto_tfm {
 struct crypto_tfm *crypto_alloc_tfm(const char *alg_name, u32 tfm_flags);
 void crypto_free_tfm(struct crypto_tfm *tfm);
 
+
+/*
+ * These functions support user-managed crypto transforms, possibly on
+ * the stack. These can be useful in situations where preemption or the like
+ * would force serializing with preallocated transforms.
+ *
+ * This interface is intended to be safe from all contexts.
+ */
+
+static inline int crypto_tfm_size(struct crypto_tfm *tfm)
+{
+	return sizeof(*tfm->digest) + cc->digest->__crt_alg->cra_ctxsize
+}
+
+int crypto_copy_tfm(char *dst, const struct crypto_tfm *src, unsigned size);
+void crypto_cleanup_copy_tfm(char *user_tfm);
+
 /*
  * Transform helpers which query the underlying algorithm.
  */

_


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
