Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVGQMU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVGQMU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 08:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVGQMU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 08:20:27 -0400
Received: from hermes.domdv.de ([193.102.202.1]:46605 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261262AbVGQMUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 08:20:25 -0400
Message-ID: <42DA4D05.7000403@domdv.de>
Date: Sun, 17 Jul 2005 14:20:21 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@intercode.com.au, herbert@gondor.apana.org.au
Subject: 2.6.13rc3: crypto horribly broken on all 64bit archs
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080406080505060706090703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080406080505060706090703
Content-Type: text/plain; charset=ISO-8859-15
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


--------------080406080505060706090703
Content-Type: text/plain;
 name="crypto.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="crypto.patch"

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
