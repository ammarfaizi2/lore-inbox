Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbUBYXCB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbUBYW6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:58:35 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:983 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261578AbUBYW4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:56:04 -0500
Date: Wed, 25 Feb 2004 23:55:53 +0100
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, jlcooke@certainkey.com,
       linux-kernel@vger.kernel.org, adam@yggdrasil.com
Subject: [PATCH 2/2] fix in-place de/encryption bug with highmem
Message-ID: <20040225225552.GB6536@leto.cs.pocnet.net>
References: <20040224220030.13160197.akpm@osdl.org> <Xine.LNX.4.44.0402250825110.28907-100000@thoron.boston.redhat.com> <20040225115027.580cc2ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225115027.580cc2ed.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the bug where in-place encryption was not detected
when the same highmem pages is mapped twice to different virtual
addresses.

This adds a parameter to xxx_process to indicate whether this is an
in-place encryption and moves the responsability to the caller using
a helper function scatterwalk.h.

diff -Nur linux.orig/crypto/cipher.c linux/crypto/cipher.c
--- linux.orig/crypto/cipher.c	2004-02-25 23:43:39.125619688 +0100
+++ linux/crypto/cipher.c	2004-02-25 23:44:51.335642096 +0100
@@ -22,7 +22,7 @@
 
 typedef void (cryptfn_t)(void *, u8 *, const u8 *);
 typedef void (procfn_t)(struct crypto_tfm *, u8 *,
-                        u8*, cryptfn_t, int enc, void *);
+                        u8*, cryptfn_t, int enc, void *, int);
 
 static inline void xor_64(u8 *a, const u8 *b)
 {
@@ -78,7 +78,9 @@
 
 		scatterwalk_copychunks(src_p, &walk_in, bsize, 0);
 
-		prfn(tfm, dst_p, src_p, crfn, enc, info);
+		prfn(tfm, dst_p, src_p, crfn, enc, info,
+		     scatterwalk_samebuf(&walk_in, &walk_out,
+					 src_p, dst_p));
 
 		scatterwalk_done(&walk_in, 0, nbytes);
 
@@ -92,8 +94,8 @@
 	}
 }
 
-static void cbc_process(struct crypto_tfm *tfm,
-                        u8 *dst, u8 *src, cryptfn_t fn, int enc, void *info)
+static void cbc_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
+			cryptfn_t fn, int enc, void *info, int in_place)
 {
 	u8 *iv = info;
 	
@@ -106,9 +108,8 @@
 		fn(crypto_tfm_ctx(tfm), dst, iv);
 		memcpy(iv, dst, crypto_tfm_alg_blocksize(tfm));
 	} else {
-		const int need_stack = (src == dst);
-		u8 stack[need_stack ? crypto_tfm_alg_blocksize(tfm) : 0];
-		u8 *buf = need_stack ? stack : dst;
+		u8 stack[in_place ? crypto_tfm_alg_blocksize(tfm) : 0];
+		u8 *buf = in_place ? stack : dst;
 
 		fn(crypto_tfm_ctx(tfm), buf, src);
 		tfm->crt_u.cipher.cit_xor_block(buf, iv);
@@ -119,7 +120,7 @@
 }
 
 static void ecb_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-                        cryptfn_t fn, int enc, void *info)
+			cryptfn_t fn, int enc, void *info, int in_place)
 {
 	fn(crypto_tfm_ctx(tfm), dst, src);
 }
diff -Nur linux.orig/crypto/scatterwalk.h linux/crypto/scatterwalk.h
--- linux.orig/crypto/scatterwalk.h	2004-02-25 23:43:39.133618472 +0100
+++ linux/crypto/scatterwalk.h	2004-02-25 23:44:51.342641032 +0100
@@ -33,6 +33,14 @@
 	return sg + 1;
 }
 
+static inline int scatterwalk_samebuf(struct scatter_walk *walk_in,
+				      struct scatter_walk *walk_out,
+				      void *src_p, void *dst_p)
+{
+	return walk_in->page == walk_out->page &&
+	       walk_in->data == src_p && walk_out->data == dst_p;
+}
+
 void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch);
 void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg);
 int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, size_t nbytes, int out);

