Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVCUJzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVCUJzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVCUJzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:55:46 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:60685 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261730AbVCUJwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:52:38 -0500
Date: Mon, 21 Mar 2005 20:52:08 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz
Subject: [4/5] [CRYPTO] Eliminate most calls to scatterwalk_copychunks from crypt()
Message-ID: <20050321095208.GD23235@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au> <20050321094807.GA23235@gondor.apana.org.au> <20050321094939.GB23235@gondor.apana.org.au> <20050321095057.GC23235@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <20050321095057.GC23235@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:
 
Only call scatterwalk_copychunks when the block straddles a page boundary.
This allows crypt() to skip the out-of-line call most of the time.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-4

diff -Nru a/crypto/cipher.c b/crypto/cipher.c
--- a/crypto/cipher.c	2005-03-21 18:44:25 +11:00
+++ b/crypto/cipher.c	2005-03-21 18:44:25 +11:00
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <asm/scatterlist.h>
 #include "internal.h"
 #include "scatterwalk.h"
@@ -43,10 +44,13 @@
 				void *tmp, int in_place)
 {
 	void *src = walk->data;
+	int n = bsize;
 
-	if (unlikely(scatterwalk_across_pages(walk, bsize)))
+	if (unlikely(scatterwalk_across_pages(walk, bsize))) {
 		src = tmp;
-	scatterwalk_copychunks(src, walk, bsize, 0);
+		n = scatterwalk_copychunks(src, walk, bsize, 0);
+	}
+	scatterwalk_advance(walk, n);
 	return src;
 }
 
@@ -68,7 +72,13 @@
 static inline void complete_dst(struct scatter_walk *walk, int bsize,
 				void *dst, int in_place)
 {
-	scatterwalk_copychunks(dst, walk, bsize, 1);
+	int n = bsize;
+
+	if (unlikely(scatterwalk_across_pages(walk, bsize)))
+		n = scatterwalk_copychunks(dst, walk, bsize, 1);
+	else if (in_place)
+		memcpy(walk->data, dst, bsize);
+	scatterwalk_advance(walk, n);
 }
 
 /* 
diff -Nru a/crypto/scatterwalk.c b/crypto/scatterwalk.c
--- a/crypto/scatterwalk.c	2005-03-21 18:44:25 +11:00
+++ b/crypto/scatterwalk.c	2005-03-21 18:44:25 +11:00
@@ -93,22 +93,16 @@
 int scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
 			   size_t nbytes, int out)
 {
-	if (buf != walk->data) {
-		while (nbytes > walk->len_this_page) {
-			memcpy_dir(buf, walk->data, walk->len_this_page, out);
-			buf += walk->len_this_page;
-			nbytes -= walk->len_this_page;
+	do {
+		memcpy_dir(buf, walk->data, walk->len_this_page, out);
+		buf += walk->len_this_page;
+		nbytes -= walk->len_this_page;
 
-			crypto_kunmap(walk->data, out);
-			scatterwalk_pagedone(walk, out, 1);
-			scatterwalk_map(walk, out);
-		}
+		crypto_kunmap(walk->data, out);
+		scatterwalk_pagedone(walk, out, 1);
+		scatterwalk_map(walk, out);
+	} while (nbytes > walk->len_this_page);
 
-		memcpy_dir(buf, walk->data, nbytes, out);
-	}
-
-	walk->offset += nbytes;
-	walk->len_this_page -= nbytes;
-	walk->len_this_segment -= nbytes;
-	return 0;
+	memcpy_dir(buf, walk->data, nbytes, out);
+	return nbytes;
 }
diff -Nru a/crypto/scatterwalk.h b/crypto/scatterwalk.h
--- a/crypto/scatterwalk.h	2005-03-21 18:44:25 +11:00
+++ b/crypto/scatterwalk.h	2005-03-21 18:44:25 +11:00
@@ -46,6 +46,14 @@
 	return nbytes > walk->len_this_page;
 }
 
+static inline void scatterwalk_advance(struct scatter_walk *walk,
+				       unsigned int nbytes)
+{
+	walk->offset += nbytes;
+	walk->len_this_page -= nbytes;
+	walk->len_this_segment -= nbytes;
+}
+
 void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg);
 int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, size_t nbytes, int out);
 void scatterwalk_map(struct scatter_walk *walk, int out);

--d9ADC0YsG2v16Js0--
