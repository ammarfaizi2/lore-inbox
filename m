Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVCUJyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVCUJyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVCUJya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:54:30 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:5390 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261723AbVCUJxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:53:51 -0500
Date: Mon, 21 Mar 2005 20:53:22 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz
Subject: [5/5] [CRYPTO] Optimise kmap calls in crypt()
Message-ID: <20050321095322.GE23235@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au> <20050321094807.GA23235@gondor.apana.org.au> <20050321094939.GB23235@gondor.apana.org.au> <20050321095057.GC23235@gondor.apana.org.au> <20050321095208.GD23235@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <20050321095208.GD23235@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:
 
Perform kmap once (or twice if the buffer is not aligned correctly)
per page in crypt() instead of the current code which does it once
per block.  Consequently it will yield once per page instead of once
per block.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-5

diff -Nru a/crypto/cipher.c b/crypto/cipher.c
--- a/crypto/cipher.c	2005-03-21 18:44:41 +11:00
+++ b/crypto/cipher.c	2005-03-21 18:44:41 +11:00
@@ -117,17 +117,21 @@
 
 		in_place = scatterwalk_samebuf(&walk_in, &walk_out);
 
-		src_p = prepare_src(&walk_in, bsize, tmp_src, in_place);
-		dst_p = prepare_dst(&walk_out, bsize, tmp_dst, in_place);
+		do {
+			src_p = prepare_src(&walk_in, bsize, tmp_src,
+					    in_place);
+			dst_p = prepare_dst(&walk_out, bsize, tmp_dst,
+					    in_place);
 
-		nbytes -= bsize;
+			prfn(tfm, dst_p, src_p, crfn, enc, info);
 
-		prfn(tfm, dst_p, src_p, crfn, enc, info);
+			complete_src(&walk_in, bsize, src_p, in_place);
+			complete_dst(&walk_out, bsize, dst_p, in_place);
 
-		complete_src(&walk_in, bsize, src_p, in_place);
-		scatterwalk_done(&walk_in, 0, nbytes);
+			nbytes -= bsize;
+		} while (nbytes && !scatterwalk_across_pages(&walk_in, bsize));
 
-		complete_dst(&walk_out, bsize, dst_p, in_place);
+		scatterwalk_done(&walk_in, 0, nbytes);
 		scatterwalk_done(&walk_out, 1, nbytes);
 
 		if (!nbytes)

--MIdTMoZhcV1D07fI--
