Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUBYSRm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUBYSQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:16:49 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:11982 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261522AbUBYSPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:15:49 -0500
Date: Wed, 25 Feb 2004 19:15:40 +0100
From: Christophe Saout <christophe@saout.de>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225181540.GB8983@leto.cs.pocnet.net>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net> <20040224223425.GA32286@certainkey.com> <1077663682.6493.1.camel@leto.cs.pocnet.net> <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org> <20040225153126.GA7395@leto.cs.pocnet.net> <20040225155121.GA7148@leto.cs.pocnet.net> <20040225154453.GB4218@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225154453.GB4218@certainkey.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 10:44:53AM -0500, Jean-Luc Cooke wrote:

> Not to be annoying...
> 
> Could you make this change against my patch at:
>   http://jlcooke.ca/lkml/crypto_28feb2004.patch

Ok, here it is. Still working (when not using omac or hmac) after
fixing the compile problems (see other mail).

If this is ok someone should split out the scatterwalk_* move from
your patch and submit it and this one to Andrew so that dm-crypt
doesn't go boom on highmem machines.


diff -Nur linux.orig/crypto/cipher.c linux/crypto/cipher.c
--- linux.orig/crypto/cipher.c	2004-02-25 18:59:30.970261968 +0100
+++ linux/crypto/cipher.c	2004-02-25 19:00:08.673530200 +0100
@@ -72,21 +72,21 @@
 	for(;;) {
 		u8 *src_p, *dst_p;
 
-		scatterwalk_map(&walk_in, 0);
-		scatterwalk_map(&walk_out, 1);
+		scatterwalk_map(&walk_in, NULL, 0);
+		scatterwalk_map(&walk_out, &walk_in, 1);
 		src_p = scatterwalk_whichbuf(&walk_in, bsize, tmp_src);
 		dst_p = scatterwalk_whichbuf(&walk_out, bsize, tmp_dst);
 
 		nbytes -= bsize;
 
-		scatterwalk_copychunks(src_p, &walk_in, bsize, 0);
+		scatterwalk_copychunks(src_p, &walk_in, &walk_out, bsize, 0);
 
 		prfn(tfm, dst_p, src_p, crfn, enc, info);
 
-		scatterwalk_done(&walk_in, 0, nbytes);
+		scatterwalk_done(&walk_in, &walk_out, 0, nbytes);
 
-		scatterwalk_copychunks(dst_p, &walk_out, bsize, 1);
-		scatterwalk_done(&walk_out, 1, nbytes);
+		scatterwalk_copychunks(dst_p, &walk_out, NULL, bsize, 1);
+		scatterwalk_done(&walk_out, NULL, 1, nbytes);
 
 		if (!nbytes)
 			return 0;
diff -Nur linux.orig/crypto/scatterwalk.c linux/crypto/scatterwalk.c
--- linux.orig/crypto/scatterwalk.c	2004-02-25 18:58:22.956601000 +0100
+++ linux/crypto/scatterwalk.c	2004-02-25 18:54:32.567626064 +0100
@@ -63,13 +63,27 @@
 	walk->offset = sg->offset;
 }
 
-void scatterwalk_map(struct scatter_walk *walk, int out)
+void scatterwalk_map(struct scatter_walk *walk, struct scatter_walk *other,
+		     int out)
 {
-	walk->data = crypto_kmap(walk->page, out) + walk->offset;
+	if (other && other->page == walk->page) {
+		walk->data = (other->data - other->offset) + walk->offset;
+		walk->slot = other->slot;
+	} else {
+		walk->data = crypto_kmap(walk->page, out) + walk->offset;
+		walk->slot = out;
+	}
+}
+
+static void scatterwalk_unmap(struct scatter_walk *walk,
+			      struct scatter_walk *other)
+{
+	if (!other || other->page != walk->page)
+		crypto_kunmap(walk->data, walk->slot);
 }
 
 static void scatterwalk_pagedone(struct scatter_walk *walk, int out,
-			      unsigned int more)
+				 unsigned int more)
 {
 	/* walk->data may be pointing the first byte of the next page;
 	   however, we know we transfered at least one byte.  So,
@@ -92,9 +106,10 @@
 	}
 }
 
-void scatterwalk_done(struct scatter_walk *walk, int out, int more)
+void scatterwalk_done(struct scatter_walk *walk, struct scatter_walk *reuse,
+		      int out, int more)
 {
-	crypto_kunmap(walk->data, out);
+	scatterwalk_unmap(walk, reuse);
 	if (walk->len_this_page == 0 || !more)
 		scatterwalk_pagedone(walk, out, more);
 }
@@ -104,7 +119,7 @@
  * has been verified as multiple of the block size.
  */
 int scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
-			size_t nbytes, int out)
+			   struct scatter_walk *reuse, size_t nbytes, int out)
 {
 	if (buf != walk->data) {
 		while (nbytes > walk->len_this_page) {
@@ -112,9 +127,9 @@
 			buf += walk->len_this_page;
 			nbytes -= walk->len_this_page;
 
-			crypto_kunmap(walk->data, out);
+			scatterwalk_unmap(walk, reuse);
 			scatterwalk_pagedone(walk, out, 1);
-			scatterwalk_map(walk, out);
+			scatterwalk_map(walk, reuse, out);
 		}
 
 		memcpy_dir(buf, walk->data, nbytes, out);
diff -Nur linux.orig/crypto/scatterwalk.h linux/crypto/scatterwalk.h
--- linux.orig/crypto/scatterwalk.h	2004-02-25 18:58:22.956601000 +0100
+++ linux/crypto/scatterwalk.h	2004-02-25 18:54:32.573625152 +0100
@@ -26,6 +26,7 @@
 	struct scatterlist	*sg;
 	struct page		*page;
 	void			*data;
+	int			slot;
 	unsigned int		len_this_page;
 	unsigned int		len_this_segment;
 	unsigned int		offset;
@@ -40,8 +41,8 @@
 
 void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch);
 void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg);
-int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, size_t nbytes, int out);
-void scatterwalk_map(struct scatter_walk *walk, int out);
-void scatterwalk_done(struct scatter_walk *walk, int out, int more);
+int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, struct scatter_walk *reuse, size_t nbytes, int out);
+void scatterwalk_map(struct scatter_walk *walk, struct scatter_walk *reuse, int out);
+void scatterwalk_done(struct scatter_walk *walk, struct scatter_walk *reuse, int out, int more);
 
 #endif  /* _CRYPTO_SCATTERWALK_H */
