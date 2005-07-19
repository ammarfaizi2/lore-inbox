Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVGSJc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVGSJc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 05:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVGSJc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 05:32:57 -0400
Received: from mailfe10.swip.net ([212.247.155.33]:26297 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261460AbVGSJce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 05:32:34 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: Kernel Bug Report
From: Alexander Nyberg <alexn@telia.com>
To: vandep01@student.ucr.edu
Cc: linux-kernel@vger.kernel.org, ruschein@infomine.ucr.edu
In-Reply-To: <1121362211.2043.3.camel@localhost.localdomain>
References: <30a258ac.1bd5021b.81be400@smh.ucr.edu>
	 <1121362211.2043.3.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-vniPjhLYGJxI1CvRPBr6"
Date: Tue, 19 Jul 2005 11:32:26 +0200
Message-Id: <1121765546.1121.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vniPjhLYGJxI1CvRPBr6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > It looks like it panics during a mem_cpy but I know its
> > difficult to tell just by the output.
> > 
> > I get a code: f3 a4 c3 66 66 66 90 66 66 66 90 66 66 66 90 66
> > 
> > The problem appears very reproducable so I can provide more
> > information upon request.
> 
> What does the rest of the panic say? There should be text above this
> that tells where the panic occured and why. Can you please send that
> here?

Ok, could you please try the this patch, I'll attach it aswell:

From:	Andreas Steinmetz <ast@domdv.de>

from include/linux/kernel.h:

#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))

from crypto/cipher.c:

unsigned int alignmask = ...
u8 *src = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
...
unsigned int alignmask = ...
u8 *tmp = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
...
unsigned int align;
addr = ALIGN(addr, align);
addr += ALIGN(tfm->__crt_alg->cra_ctxsize, align);

The compiler first does ~((a)-1)) and then expands the unsigned int to
unsigned long for the & operation. So we end up with only the lower 32
bits of the address. Who did smoke what to do this? Patch attached.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--- linux.orig/crypto/cipher.c	2005-07-17 13:35:15.000000000 +0200
+++ linux/crypto/cipher.c	2005-07-17 14:04:00.000000000 +0200
@@ -41,7 +41,7 @@
 			       struct scatter_walk *in,
 			       struct scatter_walk *out, unsigned int bsize)
 {
-	unsigned int alignmask = crypto_tfm_alg_alignmask(desc->tfm);
+	unsigned long alignmask = crypto_tfm_alg_alignmask(desc->tfm);
 	u8 buffer[bsize * 2 + alignmask];
 	u8 *src = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	u8 *dst = src + bsize;
@@ -160,7 +160,7 @@
 			      unsigned int nbytes)
 {
 	struct crypto_tfm *tfm = desc->tfm;
-	unsigned int alignmask = crypto_tfm_alg_alignmask(tfm);
+	unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
 	u8 *iv = desc->info;
 
 	if (unlikely(((unsigned long)iv & alignmask))) {
@@ -424,7 +424,7 @@
 	}
 	
 	if (ops->cit_mode == CRYPTO_TFM_MODE_CBC) {
-		unsigned int align;
+		unsigned long align;
 		unsigned long addr;
 	    	
 	    	switch (crypto_tfm_alg_blocksize(tfm)) {

--------------080406080505060706090703--
-


--=-vniPjhLYGJxI1CvRPBr6
Content-Disposition: attachment; filename=crypto_64bit_align_masks.patch
Content-Type: message/rfc822; name=crypto_64bit_align_masks.patch

From: Andreas Steinmetz <ast@domdv.de>
Date: Tue, 19 Jul 2005 11:32:26 +0200
Subject: No Subject
Message-Id: <1121765546.1121.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

from include/linux/kernel.h:

#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))

from crypto/cipher.c:

unsigned int alignmask = ...
u8 *src = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
...
unsigned int alignmask = ...
u8 *tmp = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
...
unsigned int align;
addr = ALIGN(addr, align);
addr += ALIGN(tfm->__crt_alg->cra_ctxsize, align);

The compiler first does ~((a)-1)) and then expands the unsigned int to
unsigned long for the & operation. So we end up with only the lower 32
bits of the address. Who did smoke what to do this? Patch attached.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--- linux.orig/crypto/cipher.c	2005-07-17 13:35:15.000000000 +0200
+++ linux/crypto/cipher.c	2005-07-17 14:04:00.000000000 +0200
@@ -41,7 +41,7 @@
 			       struct scatter_walk *in,
 			       struct scatter_walk *out, unsigned int bsize)
 {
-	unsigned int alignmask = crypto_tfm_alg_alignmask(desc->tfm);
+	unsigned long alignmask = crypto_tfm_alg_alignmask(desc->tfm);
 	u8 buffer[bsize * 2 + alignmask];
 	u8 *src = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	u8 *dst = src + bsize;
@@ -160,7 +160,7 @@
 			      unsigned int nbytes)
 {
 	struct crypto_tfm *tfm = desc->tfm;
-	unsigned int alignmask = crypto_tfm_alg_alignmask(tfm);
+	unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
 	u8 *iv = desc->info;
 
 	if (unlikely(((unsigned long)iv & alignmask))) {
@@ -424,7 +424,7 @@
 	}
 	
 	if (ops->cit_mode == CRYPTO_TFM_MODE_CBC) {
-		unsigned int align;
+		unsigned long align;
 		unsigned long addr;
 	    	
 	    	switch (crypto_tfm_alg_blocksize(tfm)) {

--------------080406080505060706090703--
-

--=-vniPjhLYGJxI1CvRPBr6--

