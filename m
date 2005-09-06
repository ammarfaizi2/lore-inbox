Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVIFMUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVIFMUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVIFMUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:20:42 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:1443 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S964817AbVIFMUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:20:41 -0400
Date: Tue, 6 Sep 2005 22:20:29 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@vger.kernel.org, olel@ans.pl,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@kernel-bugs.osdl.org>,
       Matt LaPlante <laplam@rpi.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Fw: [Bugme-new] [Bug 5194] New: IPSec related OOps in 2.6.13
Message-ID: <20050906122029.GB4594@gondor.apana.org.au>
References: <20050906040856.4e38419f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20050906040856.4e38419f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 06, 2005 at 04:08:56AM -0700, Andrew Morton wrote:
> 
> Problem Description:
> 
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c01f562c>]    Not tainted VLI
> EFLAGS: 00010216   (2.6.13)
> EIP is at sha1_update+0x7c/0x160

Thanks for the report.  Matt LaPlante had exactly the same problem
a couple of days ago.  I've tracked down now to my broken crypto
cipher wrapper functions which will step over a page boundary if
it's not aligned correctly.


[CRYPTO] Fix boundary check in standard multi-block cipher processors

The boundary check in the standard multi-block cipher processors are
broken when nbytes is not a multiple of bsize.  In those cases it will
always process an extra block.

This patch corrects the check so that it processes at most nbytes of data.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/crypto/cipher.c b/crypto/cipher.c
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -191,6 +191,8 @@ static unsigned int cbc_process_encrypt(
 	u8 *iv = desc->info;
 	unsigned int done = 0;
 
+	nbytes -= bsize;
+
 	do {
 		xor(iv, src);
 		fn(crypto_tfm_ctx(tfm), dst, iv);
@@ -198,7 +200,7 @@ static unsigned int cbc_process_encrypt(
 
 		src += bsize;
 		dst += bsize;
-	} while ((done += bsize) < nbytes);
+	} while ((done += bsize) <= nbytes);
 
 	return done;
 }
@@ -219,6 +221,8 @@ static unsigned int cbc_process_decrypt(
 	u8 *iv = desc->info;
 	unsigned int done = 0;
 
+	nbytes -= bsize;
+
 	do {
 		u8 *tmp_dst = *dst_p;
 
@@ -230,7 +234,7 @@ static unsigned int cbc_process_decrypt(
 
 		src += bsize;
 		dst += bsize;
-	} while ((done += bsize) < nbytes);
+	} while ((done += bsize) <= nbytes);
 
 	return done;
 }
@@ -243,12 +247,14 @@ static unsigned int ecb_process(const st
 	void (*fn)(void *, u8 *, const u8 *) = desc->crfn;
 	unsigned int done = 0;
 
+	nbytes -= bsize;
+
 	do {
 		fn(crypto_tfm_ctx(tfm), dst, src);
 
 		src += bsize;
 		dst += bsize;
-	} while ((done += bsize) < nbytes);
+	} while ((done += bsize) <= nbytes);
 
 	return done;
 }

--9amGYk9869ThD9tj--
