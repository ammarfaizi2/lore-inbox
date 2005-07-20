Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVGTElU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVGTElU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 00:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVGTElU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 00:41:20 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:2431 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S261714AbVGTElQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 00:41:16 -0400
Date: Tue, 19 Jul 2005 21:41:12 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@intercode.com.au, herbert@gondor.apana.org.au
Subject: Re: 2.6.13rc3: crypto horribly broken on all 64bit archs
Message-ID: <20050720044112.GA18957@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DA4D05.7000403@domdv.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 02:20:21PM +0200, Andreas Steinmetz wrote:
> from include/linux/kernel.h:
> 
> #define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
> 
> from crypto/cipher.c:
> 
> unsigned int alignmask = ...
> u8 *src = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);

The type foolery you suggested is un-obvious, especially at review time.
How about the following instead?

-andy

# HG changeset patch
# User adi@hexapodia.org
# Node ID ff4d8285dcb581b8340b133c22780c4fcc0dabb3
# Parent  2b0b2208676a22741fc3b1681ca9dd555ca40dfd
Add new PTR_ALIGN macro to encapsulate necessary casting, and use it in
the places where ALIGN was used on pointers.

Signed-Off-By: Andy Isaacson <adi@hexapodia.org>

diff -r 2b0b2208676a -r ff4d8285dcb5 crypto/cipher.c
--- a/crypto/cipher.c	Sun Jul 17 03:06:51 2005
+++ b/crypto/cipher.c	Tue Jul 19 18:51:11 2005
@@ -43,7 +43,7 @@
 {
 	unsigned int alignmask = crypto_tfm_alg_alignmask(desc->tfm);
 	u8 buffer[bsize * 2 + alignmask];
-	u8 *src = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
+	u8 *src = PTR_ALIGN(buffer, alignmask + 1);
 	u8 *dst = src + bsize;
 	unsigned int n;
 
@@ -166,7 +166,7 @@
 	if (unlikely(((unsigned long)iv & alignmask))) {
 		unsigned int ivsize = tfm->crt_cipher.cit_ivsize;
 		u8 buffer[ivsize + alignmask];
-		u8 *tmp = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
+		u8 *tmp = PTR_ALIGN(buffer, alignmask + 1);
 		int err;
 
 		desc->info = memcpy(tmp, iv, ivsize);
diff -r 2b0b2208676a -r ff4d8285dcb5 drivers/crypto/padlock-aes.c
--- a/drivers/crypto/padlock-aes.c	Sun Jul 17 03:06:51 2005
+++ b/drivers/crypto/padlock-aes.c	Tue Jul 19 18:51:11 2005
@@ -287,7 +287,7 @@
 
 static inline struct aes_ctx *aes_ctx(void *ctx)
 {
-	return (struct aes_ctx *)ALIGN((unsigned long)ctx, PADLOCK_ALIGNMENT);
+	return PTR_ALIGN(ctx, PADLOCK_ALIGNMENT);
 }
 
 static int
diff -r 2b0b2208676a -r ff4d8285dcb5 include/linux/kernel.h
--- a/include/linux/kernel.h	Sun Jul 17 03:06:51 2005
+++ b/include/linux/kernel.h	Tue Jul 19 18:51:11 2005
@@ -29,6 +29,8 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
+#define PTR_ALIGN(p,a) \
+	((void *)(((unsigned long)(p)+(a)-1)&~(((unsigned long)(a)-1))))
 
 #define	KERN_EMERG	"<0>"	/* system is unusable			*/
 #define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/
