Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVCUJtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVCUJtF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVCUJtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:49:05 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:50957 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261715AbVCUJsd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:48:33 -0500
Date: Mon, 21 Mar 2005 20:48:07 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz
Subject: [1/5] [CRYPTO] Do scatterwalk_whichbuf inline
Message-ID: <20050321094807.GA23235@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20050321094047.GA23084@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

scatterwalk_whichbuf is called once for each block which could be as
small as 8/16 bytes.  So it makes sense to do that work inline.

It's also a bit inflexible since we may want to use the temporary buffer
even if the block doesn't cross page boundaries.  In particular, we want
to do that when the source and destination are the same.

So let's replace it with scatterwalk_across_pages.

I've also simplified the check in scatterwalk_across_pages.  It is
sufficient to only check len_this_page.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-1

diff -Nru a/crypto/cipher.c b/crypto/cipher.c
--- a/crypto/cipher.c	2005-03-21 18:43:36 +11:00
+++ b/crypto/cipher.c	2005-03-21 18:43:36 +11:00
@@ -11,6 +11,7 @@
  * any later version.
  *
  */
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/crypto.h>
 #include <linux/errno.h>
@@ -72,8 +73,15 @@
 
 		scatterwalk_map(&walk_in, 0);
 		scatterwalk_map(&walk_out, 1);
-		src_p = scatterwalk_whichbuf(&walk_in, bsize, tmp_src);
-		dst_p = scatterwalk_whichbuf(&walk_out, bsize, tmp_dst);
+
+		src_p = walk_in.data;
+		if (unlikely(scatterwalk_across_pages(&walk_in, bsize)))
+			src_p = tmp_src;
+
+		dst_p = walk_out.data;
+		if (unlikely(scatterwalk_across_pages(&walk_out, bsize)))
+			dst_p = tmp_dst;
+
 		in_place = scatterwalk_samebuf(&walk_in, &walk_out,
 					       src_p, dst_p);
 
diff -Nru a/crypto/scatterwalk.c b/crypto/scatterwalk.c
--- a/crypto/scatterwalk.c	2005-03-21 18:43:36 +11:00
+++ b/crypto/scatterwalk.c	2005-03-21 18:43:36 +11:00
@@ -28,16 +28,6 @@
 	KM_SOFTIRQ1,
 };
 
-void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch)
-{
-	if (nbytes <= walk->len_this_page &&
-	    (((unsigned long)walk->data) & (PAGE_CACHE_SIZE - 1)) + nbytes <=
-	    PAGE_CACHE_SIZE)
-		return walk->data;
-	else
-		return scratch;
-}
-
 static void memcpy_dir(void *buf, void *sgdata, size_t nbytes, int out)
 {
 	if (out)
diff -Nru a/crypto/scatterwalk.h b/crypto/scatterwalk.h
--- a/crypto/scatterwalk.h	2005-03-21 18:43:36 +11:00
+++ b/crypto/scatterwalk.h	2005-03-21 18:43:36 +11:00
@@ -42,7 +42,12 @@
 	       walk_in->data == src_p && walk_out->data == dst_p;
 }
 
-void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch);
+static inline int scatterwalk_across_pages(struct scatter_walk *walk,
+					   unsigned int nbytes)
+{
+	return nbytes > walk->len_this_page;
+}
+
 void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg);
 int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, size_t nbytes, int out);
 void scatterwalk_map(struct scatter_walk *walk, int out);

--wac7ysb48OaltWcw--
