Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVCVL20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVCVL20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbVCVL0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:26:41 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:56845 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262653AbVCVLZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:25:24 -0500
Date: Tue, 22 Mar 2005 22:25:04 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz, linux-crypto@vger.kernel.org
Subject: [9/*] [CRYPTO] Remap when walk_out crosses page in crypt()
Message-ID: <20050322112504.GC7224@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au> <20050322112231.GA7224@gondor.apana.org.au> <20050322112416.GB7224@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <20050322112416.GB7224@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This is needed so that we can keep the in_place assignment outside the
inner loop.  Without this in pathalogical situations we can start out
having walk_out being different from walk_in, but when walk_out crosses
a page it may converge with walk_in.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-9

===== cipher.c 1.26 vs edited =====
--- 1.26/crypto/cipher.c	2005-03-22 21:56:21 +11:00
+++ edited/cipher.c	2005-03-22 21:59:53 +11:00
@@ -129,7 +129,9 @@
 			complete_dst(&walk_out, bsize, dst_p, in_place);
 
 			nbytes -= bsize;
-		} while (nbytes && !scatterwalk_across_pages(&walk_in, bsize));
+		} while (nbytes &&
+			 !scatterwalk_across_pages(&walk_in, bsize) &&
+			 !scatterwalk_across_pages(&walk_out, bsize));
 
 		scatterwalk_done(&walk_in, 0, nbytes);
 		scatterwalk_done(&walk_out, 1, nbytes);

--s9fJI615cBHmzTOP--
