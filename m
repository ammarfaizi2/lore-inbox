Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUBXUl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUBXUk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:40:28 -0500
Received: from waste.org ([209.173.204.2]:63679 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262449AbUBXUij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:38:39 -0500
Date: Tue, 24 Feb 2004 14:38:25 -0600
From: Matt Mackall <mpm@selenic.com>
To: Christophe Saout <christophe@saout.de>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040224203825.GV3883@waste.org>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040219111835.192d2741.akpm@osdl.org> <20040220171427.GD9266@certainkey.com> <20040221021724.GA8841@leto.cs.pocnet.net> <20040224191142.GT3883@waste.org> <1077651839.11170.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077651839.11170.4.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 08:43:59PM +0100, Christophe Saout wrote:
>
> BTW: I think there's a bug in the ipv6 code, it uses spin_lock to
> protect itself, this will cause a sleep-inside-spinlock warning. (found
> while grepping through the source for other cryptoapi users)

Yep, I sent this to James several months ago but it appears we've both
forgotten about it:

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

> > Something like:
> > 
> >  /* calculate the size of a tfm so that users can manage their own
> >  copies */
> > 
> >  int crypto_alg_size(const char *name);
> 
> crypto_tfm_size?

Sure.
 
> >  /* copy a TFM to a user-managed buffer, possibly on stack, with proper
> >  internal reference counting and any other necessary magic, size checks
> >  against boneheaded buffer sizing */
> > 
> >  crypto_copy_tfm(char *dst, const struct crypto_tfm *src, int size);
> > 
> >  /* do all the necessary bookkeeping to release a user-managed TFM, use
> >  char pointer to avoid alloc/free mismatch */
> > 
> >  crypto_copy_cleanup_tfm(char *usertfm);
> 
> Yes, I thought of something like this.

Ok, I might get to this by this afternoon. 

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
