Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbUBYPvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbUBYPvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:51:16 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:4038 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261372AbUBYPvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:51:09 -0500
Date: Wed, 25 Feb 2004 16:51:22 +0100
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225155121.GA7148@leto.cs.pocnet.net>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net> <20040224223425.GA32286@certainkey.com> <1077663682.6493.1.camel@leto.cs.pocnet.net> <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org> <20040225153126.GA7395@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225153126.GA7395@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 04:31:26PM +0100, Christophe Saout wrote:

> It's just a proof of concept though, it would be less complicated if we
> would just pass the other walk struct to the functions that take one
> and let them do the checking (no need to disable preemption and use
> per cpu variables). Hmm.

Ok, this also works. It makes copy_chunks and crypt responsible for
tracking the walk struct which might contain a page to reuse:


--- linux-2.6.3/crypto/cipher.c	2004-02-25 13:49:53.000000000 +0100
+++ linux-2.6.3.test/crypto/cipher.c	2004-02-25 16:46:58.430294600 +0100
@@ -29,6 +29,7 @@
 struct scatter_walk {
 	struct scatterlist	*sg;
 	struct page		*page;
+	int			out;
 	void			*data;
 	unsigned int		len_this_page;
 	unsigned int		len_this_segment;
@@ -64,7 +65,7 @@
 	return sg + 1;
 }
 
-void *which_buf(struct scatter_walk *walk, unsigned int nbytes, void *scratch)
+static void *which_buf(struct scatter_walk *walk, unsigned int nbytes, void *scratch)
 {
 	if (nbytes <= walk->len_this_page &&
 	    (((unsigned long)walk->data) & (PAGE_CACHE_SIZE - 1)) + nbytes <=
@@ -96,9 +97,23 @@
 	walk->offset = sg->offset;
 }
 
-static void scatterwalk_map(struct scatter_walk *walk, int out)
+static void scatterwalk_map(struct scatter_walk *walk,
+			    struct scatter_walk *other, int out)
 {
-	walk->data = crypto_kmap(walk->page, out) + walk->offset;
+	if (other && other->page == walk->page) {
+		walk->data = (other->data - other->offset) + walk->offset;
+		walk->out = other->out;
+	} else {
+		walk->data = crypto_kmap(walk->page, out) + walk->offset;
+		walk->out = out;
+	}
+}
+
+static void scatterwalk_unmap(struct scatter_walk *walk,
+			      struct scatter_walk *other, int out)
+{
+	if (!other || other->page != walk->page)
+		crypto_kunmap(walk->data, walk->out);
 }
 
 static void scatter_page_done(struct scatter_walk *walk, int out,
@@ -125,9 +140,10 @@
 	}
 }
 
-static void scatter_done(struct scatter_walk *walk, int out, int more)
+static void scatter_done(struct scatter_walk *walk,
+			 struct scatter_walk *other, int out, int more)
 {
-	crypto_kunmap(walk->data, out);
+	scatterwalk_unmap(walk, other, out);
 	if (walk->len_this_page == 0 || !more)
 		scatter_page_done(walk, out, more);
 }
@@ -137,7 +153,7 @@
  * has been verified as multiple of the block size.
  */
 static int copy_chunks(void *buf, struct scatter_walk *walk,
-			size_t nbytes, int out)
+		       struct scatter_walk *other, size_t nbytes, int out)
 {
 	if (buf != walk->data) {
 		while (nbytes > walk->len_this_page) {
@@ -145,9 +161,9 @@
 			buf += walk->len_this_page;
 			nbytes -= walk->len_this_page;
 
-			crypto_kunmap(walk->data, out);
+			scatterwalk_unmap(walk, other, out);
 			scatter_page_done(walk, out, 1);
-			scatterwalk_map(walk, out);
+			scatterwalk_map(walk, other, out);
 		}
 
 		memcpy_dir(buf, walk->data, nbytes, out);
@@ -189,21 +205,21 @@
 	for(;;) {
 		u8 *src_p, *dst_p;
 
-		scatterwalk_map(&walk_in, 0);
-		scatterwalk_map(&walk_out, 1);
+		scatterwalk_map(&walk_in, NULL, 0);
+		scatterwalk_map(&walk_out, &walk_in, 1);
 		src_p = which_buf(&walk_in, bsize, tmp_src);
 		dst_p = which_buf(&walk_out, bsize, tmp_dst);
 
 		nbytes -= bsize;
 
-		copy_chunks(src_p, &walk_in, bsize, 0);
+		copy_chunks(src_p, &walk_in, &walk_out, bsize, 0);
 
 		prfn(tfm, dst_p, src_p, crfn, enc, info);
 
-		scatter_done(&walk_in, 0, nbytes);
+		scatter_done(&walk_in, &walk_out, 0, nbytes);
 
-		copy_chunks(dst_p, &walk_out, bsize, 1);
-		scatter_done(&walk_out, 1, nbytes);
+		copy_chunks(dst_p, &walk_out, NULL, bsize, 1);
+		scatter_done(&walk_out, NULL, 1, nbytes);
 
 		if (!nbytes)
 			return 0;
