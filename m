Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVCUJ7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVCUJ7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVCUJ45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:56:57 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:57613 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261724AbVCUJvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:51:19 -0500
Date: Mon, 21 Mar 2005 20:50:57 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz
Subject: [3/5] [CRYPTO] Split src/dst handling out from crypt()
Message-ID: <20050321095057.GC23235@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au> <20050321094807.GA23235@gondor.apana.org.au> <20050321094939.GB23235@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20050321094939.GB23235@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

Move src/dst handling from crypt() into the helpers prepare_src,
prepare_dst, complete_src and complete_dst.  complete_src doesn't
actually do anything at the moment but is included for completeness.

This sets the stage for further optimisations down the track without
polluting crypt() itself.

These helpers don't belong in scatterwalk.[ch] since they only help
the particular way that crypt() is walking the scatter lists.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-3

diff -Nru a/crypto/cipher.c b/crypto/cipher.c
--- a/crypto/cipher.c	2005-03-21 18:44:09 +11:00
+++ b/crypto/cipher.c	2005-03-21 18:44:09 +11:00
@@ -38,7 +38,38 @@
 	((u32 *)a)[2] ^= ((u32 *)b)[2];
 	((u32 *)a)[3] ^= ((u32 *)b)[3];
 }
+ 
+static inline void *prepare_src(struct scatter_walk *walk, int bsize,
+				void *tmp, int in_place)
+{
+	void *src = walk->data;
+
+	if (unlikely(scatterwalk_across_pages(walk, bsize)))
+		src = tmp;
+	scatterwalk_copychunks(src, walk, bsize, 0);
+	return src;
+}
 
+static inline void *prepare_dst(struct scatter_walk *walk, int bsize,
+				void *tmp, int in_place)
+{
+	void *dst = walk->data;
+
+	if (unlikely(scatterwalk_across_pages(walk, bsize)) || in_place)
+		dst = tmp;
+	return dst;
+}
+
+static inline void complete_src(struct scatter_walk *walk, int bsize,
+				void *src, int in_place)
+{
+}
+
+static inline void complete_dst(struct scatter_walk *walk, int bsize,
+				void *dst, int in_place)
+{
+	scatterwalk_copychunks(dst, walk, bsize, 1);
+}
 
 /* 
  * Generic encrypt/decrypt wrapper for ciphers, handles operations across
@@ -76,24 +107,17 @@
 
 		in_place = scatterwalk_samebuf(&walk_in, &walk_out);
 
-		src_p = walk_in.data;
-		if (unlikely(scatterwalk_across_pages(&walk_in, bsize)))
-			src_p = tmp_src;
-
-		dst_p = walk_out.data;
-		if (unlikely(scatterwalk_across_pages(&walk_out, bsize)) ||
-		    in_place)
-			dst_p = tmp_dst;
+		src_p = prepare_src(&walk_in, bsize, tmp_src, in_place);
+		dst_p = prepare_dst(&walk_out, bsize, tmp_dst, in_place);
 
 		nbytes -= bsize;
 
-		scatterwalk_copychunks(src_p, &walk_in, bsize, 0);
-
 		prfn(tfm, dst_p, src_p, crfn, enc, info);
 
+		complete_src(&walk_in, bsize, src_p, in_place);
 		scatterwalk_done(&walk_in, 0, nbytes);
 
-		scatterwalk_copychunks(dst_p, &walk_out, bsize, 1);
+		complete_dst(&walk_out, bsize, dst_p, in_place);
 		scatterwalk_done(&walk_out, 1, nbytes);
 
 		if (!nbytes)

--96YOpH+ONegL0A3E--
