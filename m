Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVCVBTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVCVBTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVCVBRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:17:43 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:62737 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262256AbVCVBOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:14:08 -0500
Date: Tue, 22 Mar 2005 12:13:08 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz
Subject: Re: [5/5] [CRYPTO] Optimise kmap calls in crypt()
Message-ID: <20050322011308.GA15734@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au> <20050321094807.GA23235@gondor.apana.org.au> <20050321094939.GB23235@gondor.apana.org.au> <20050321095057.GC23235@gondor.apana.org.au> <20050321095208.GD23235@gondor.apana.org.au> <20050321095322.GE23235@gondor.apana.org.au> <1111404659.12532.9.camel@ghanima>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <1111404659.12532.9.camel@ghanima>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 21, 2005 at 12:30:59PM +0100, Fruhwirth Clemens wrote:
> 
> Applying all patches results in a "does not work for me". The decryption
> result is different from the original and my LUKS managed partition
> refuses to mount.

Thanks for testing this Fruhwirth.  The problem is that walk->data wasn't
being incremented anymore after my last change.  This patch should fix it
up.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-6

===== crypto/scatterwalk.c 1.4 vs edited =====
--- 1.4/crypto/scatterwalk.c	2005-03-20 22:18:58 +11:00
+++ edited/crypto/scatterwalk.c	2005-03-22 11:06:11 +11:00
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <asm/bug.h>
 #include <asm/scatterlist.h>
 #include "internal.h"
 #include "scatterwalk.h"
@@ -45,6 +46,8 @@
 	walk->page = sg->page;
 	walk->len_this_segment = sg->length;
 
+	BUG_ON(!sg->length);
+
 	rest_of_page = PAGE_CACHE_SIZE - (sg->offset & (PAGE_CACHE_SIZE - 1));
 	walk->len_this_page = min(sg->length, rest_of_page);
 	walk->offset = sg->offset;
@@ -55,13 +58,17 @@
 	walk->data = crypto_kmap(walk->page, out) + walk->offset;
 }
 
-static void scatterwalk_pagedone(struct scatter_walk *walk, int out,
-				 unsigned int more)
+static inline void scatterwalk_unmap(struct scatter_walk *walk, int out)
 {
 	/* walk->data may be pointing the first byte of the next page;
 	   however, we know we transfered at least one byte.  So,
 	   walk->data - 1 will be a virtual address in the mapped page. */
+	crypto_kunmap(walk->data - 1, out);
+}
 
+static void scatterwalk_pagedone(struct scatter_walk *walk, int out,
+				 unsigned int more)
+{
 	if (out)
 		flush_dcache_page(walk->page);
 
@@ -81,7 +88,7 @@
 
 void scatterwalk_done(struct scatter_walk *walk, int out, int more)
 {
-	crypto_kunmap(walk->data, out);
+	scatterwalk_unmap(walk, out);
 	if (walk->len_this_page == 0 || !more)
 		scatterwalk_pagedone(walk, out, more);
 }
@@ -98,7 +105,7 @@
 		buf += walk->len_this_page;
 		nbytes -= walk->len_this_page;
 
-		crypto_kunmap(walk->data, out);
+		scatterwalk_unmap(walk, out);
 		scatterwalk_pagedone(walk, out, 1);
 		scatterwalk_map(walk, out);
 	} while (nbytes > walk->len_this_page);
===== crypto/scatterwalk.h 1.6 vs edited =====
--- 1.6/crypto/scatterwalk.h	2005-03-20 22:18:58 +11:00
+++ edited/crypto/scatterwalk.h	2005-03-22 10:57:07 +11:00
@@ -49,6 +49,7 @@
 static inline void scatterwalk_advance(struct scatter_walk *walk,
 				       unsigned int nbytes)
 {
+	walk->data += nbytes;
 	walk->offset += nbytes;
 	walk->len_this_page -= nbytes;
 	walk->len_this_segment -= nbytes;

--ibTvN161/egqYuK8--
