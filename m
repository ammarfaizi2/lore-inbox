Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVCVLX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVCVLX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVCVLX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:23:28 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:49421 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262626AbVCVLXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:23:19 -0500
Date: Tue, 22 Mar 2005 22:22:31 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz, linux-crypto@vger.kernel.org
Subject: [7/*] [CRYPTO] Kill obsolete iv check in cbc_process()
Message-ID: <20050322112231.GA7224@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20050321094047.GA23084@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

Here's some more optimisations plus a bug fix for a pathological case
where in_place might not be set correctly which can't happen with any
of the current users.  Here is the first one:

We have long since stopped using a null cit_iv as a means of doing null
encryption.  In fact it doesn't work here anyway since we need to copy
src into dst to achieve null encryption.

No user of cbc_encrypt_iv/cbc_decrypt_iv does this either so let's just
get rid of this check which is sitting in the fast path.
 
Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-7

===== cipher.c 1.24 vs edited =====
--- 1.24/crypto/cipher.c	2005-03-21 18:41:41 +11:00
+++ edited/cipher.c	2005-03-22 21:28:00 +11:00
@@ -145,11 +145,7 @@
 			cryptfn_t fn, int enc, void *info)
 {
 	u8 *iv = info;
-	
-	/* Null encryption */
-	if (!iv)
-		return;
-		
+
 	if (enc) {
 		tfm->crt_u.cipher.cit_xor_block(iv, src);
 		fn(crypto_tfm_ctx(tfm), dst, iv);

--fdj2RfSjLxBAspz7--
