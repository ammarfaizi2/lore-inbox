Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272299AbTHNHPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 03:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272305AbTHNHPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 03:15:47 -0400
Received: from waste.org ([209.173.204.2]:61919 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272299AbTHNHPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 03:15:39 -0400
Date: Thu, 14 Aug 2003 02:15:19 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, jmorris@intercode.com.au,
       davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cryptoapi: Fix sleeping
Message-ID: <20030814071519.GJ325@waste.org>
References: <20030813233957.GE325@waste.org> <3F3AD5F1.8000901@pobox.com> <20030813174436.3db7efb1.akpm@osdl.org> <20030814020323.GI325@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030814020323.GI325@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 09:03:23PM -0500, Matt Mackall wrote:
> On Wed, Aug 13, 2003 at 05:44:36PM -0700, Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > >
> > > Matt Mackall wrote:
> > > > We need in_atomic() so that we can call from regions where preempt is
> > > > disabled, for instance when using per_cpu crypto tfms.
> > > > 
> > > > diff -urN -X dontdiff orig/crypto/internal.h work/crypto/internal.h
> > > > +++ work/crypto/internal.h	2003-08-12 14:38:54.000000000 -0500
> > > > @@ -37,7 +37,7 @@
> > > >  
> > > >  static inline void crypto_yield(struct crypto_tfm *tfm)
> > > >  {
> > > > -	if (!in_softirq())
> > > > +	if (!in_atomic())
> > > >  		cond_resched();
> > > 
> > > 
> > > Do you really want to schedule inside preempt_disable() ?
> > > 
> > 
> > in_atomic() returns false inside spin_lock() on non-preemptive kernels.
> > 
> > Either this code needs to be removed altogether or it should be changed to
> > 
> > 	BUG_ON(in_atomic());
> > 	cond_resched();
> > 
> > and the callers should be fixed up.
> 
> Cryptoapi probably needs a flag for skipping the yield. I'll look into it.

Ok, for reference, the code calling yield is stuff like this buried in
cryptoapi:

static void update(struct crypto_tfm *tfm,
                   struct scatterlist *sg, unsigned int nsg)
{
        unsigned int i;
         
        for (i = 0; i < nsg; i++) {
                char *p = crypto_kmap(sg[i].page, 0) + sg[i].offset;
                tfm->__crt_alg->cra_digest.dia_update(crypto_tfm_ctx(tfm),
                                                      p,
						      sg[i].length);
                crypto_kunmap(p, 0);
                crypto_yield(tfm);
        }
}

It's basically trying to be friendly. Since we can't really detect
when it's safe to do such yields, we should be explicitly flag the
uses where its ok. Something like this:

diff -urN -X dontdiff orig/crypto/api.c work/crypto/api.c
--- orig/crypto/api.c	2003-07-13 22:38:38.000000000 -0500
+++ work/crypto/api.c	2003-08-14 01:53:07.000000000 -0500
@@ -53,7 +53,8 @@
 
 static int crypto_init_flags(struct crypto_tfm *tfm, u32 flags)
 {
-	tfm->crt_flags = 0;
+	tfm->crt_flags = flags & CRYPTO_TFM_API_MASK;
+	flags &= ~CRYPTO_TFM_API_MASK;
 	
 	switch (crypto_tfm_alg_type(tfm)) {
 	case CRYPTO_ALG_TYPE_CIPHER:
diff -urN -X dontdiff orig/crypto/internal.h work/crypto/internal.h
--- orig/crypto/internal.h	2003-07-13 22:29:11.000000000 -0500
+++ work/crypto/internal.h	2003-08-14 01:53:28.000000000 -0500
@@ -37,7 +37,7 @@
 
 static inline void crypto_yield(struct crypto_tfm *tfm)
 {
-	if (!in_softirq())
+	if (tfm->crt_flags & CRYPTO_TFM_API_YIELD)
 		cond_resched();
 }
 
diff -urN -X dontdiff orig/include/linux/crypto.h work/include/linux/crypto.h
--- orig/include/linux/crypto.h	2003-07-13 22:32:32.000000000 -0500
+++ work/include/linux/crypto.h	2003-08-14 01:53:07.000000000 -0500
@@ -36,7 +36,8 @@
  */
 #define CRYPTO_TFM_MODE_MASK		0x000000ff
 #define CRYPTO_TFM_REQ_MASK		0x000fff00
-#define CRYPTO_TFM_RES_MASK		0xfff00000
+#define CRYPTO_TFM_RES_MASK		0x7ff00000
+#define CRYPTO_TFM_API_MASK		0x80000000
 
 #define CRYPTO_TFM_MODE_ECB		0x00000001
 #define CRYPTO_TFM_MODE_CBC		0x00000002
@@ -50,6 +51,9 @@
 #define CRYPTO_TFM_RES_BAD_BLOCK_LEN 	0x00800000
 #define CRYPTO_TFM_RES_BAD_FLAGS 	0x01000000
 
+/* Allow for rescheduling after processing each sg element */
+#define CRYPTO_TFM_API_YIELD		0x80000000
+
 /*
  * Miscellaneous stuff.
  */
diff -urN -X dontdiff orig/include/linux/sched.h work/include/linux/sched.h
--- orig/include/linux/sched.h	2003-08-14 01:53:04.000000000 -0500
+++ work/include/linux/sched.h	2003-08-14 01:53:07.000000000 -0500
@@ -824,6 +824,7 @@
 extern void __cond_resched(void);
 static inline void cond_resched(void)
 {
+	might_sleep();
 	if (need_resched())
 		__cond_resched();
 }



-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
