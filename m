Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUBYXB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbUBYW76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:59:58 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:61398 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261556AbUBYWz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:55:57 -0500
Date: Wed, 25 Feb 2004 23:55:46 +0100
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, jlcooke@certainkey.com,
       linux-kernel@vger.kernel.org, adam@yggdrasil.com
Subject: [PATCH 1/2] move scatterwalk functions to own file
Message-ID: <20040225225545.GA6536@leto.cs.pocnet.net>
References: <20040224220030.13160197.akpm@osdl.org> <Xine.LNX.4.44.0402250825110.28907-100000@thoron.boston.redhat.com> <20040225115027.580cc2ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225115027.580cc2ed.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've cleaned up the latest patches and adjusted the header files.

This patch moves the scatterwalk functions from cipher.c to
scatterwalk.c and adds a header file.

diff -Nur linux.orig/crypto/cipher.c linux/crypto/cipher.c
--- linux.orig/crypto/cipher.c	2004-02-25 23:40:51.976030000 +0100
+++ linux/crypto/cipher.c	2004-02-25 23:43:39.125619688 +0100
@@ -4,7 +4,6 @@
  * Cipher operations.
  *
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
- * Generic scatterwalk code by Adam J. Richter <adam@yggdrasil.com>.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -17,31 +16,14 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/pagemap.h>
-#include <linux/highmem.h>
 #include <asm/scatterlist.h>
 #include "internal.h"
+#include "scatterwalk.h"
 
 typedef void (cryptfn_t)(void *, u8 *, const u8 *);
 typedef void (procfn_t)(struct crypto_tfm *, u8 *,
                         u8*, cryptfn_t, int enc, void *);
 
-struct scatter_walk {
-	struct scatterlist	*sg;
-	struct page		*page;
-	void			*data;
-	unsigned int		len_this_page;
-	unsigned int		len_this_segment;
-	unsigned int		offset;
-};
-
-enum km_type crypto_km_types[] = {
-	KM_USER0,
-	KM_USER1,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-};
-
 static inline void xor_64(u8 *a, const u8 *b)
 {
 	((u32 *)a)[0] ^= ((u32 *)b)[0];
@@ -57,108 +39,6 @@
 }
 
 
-/* Define sg_next is an inline routine now in case we want to change
-   scatterlist to a linked list later. */
-static inline struct scatterlist *sg_next(struct scatterlist *sg)
-{
-	return sg + 1;
-}
-
-void *which_buf(struct scatter_walk *walk, unsigned int nbytes, void *scratch)
-{
-	if (nbytes <= walk->len_this_page &&
-	    (((unsigned long)walk->data) & (PAGE_CACHE_SIZE - 1)) + nbytes <=
-	    PAGE_CACHE_SIZE)
-		return walk->data;
-	else
-		return scratch;
-}
-
-static void memcpy_dir(void *buf, void *sgdata, size_t nbytes, int out)
-{
-	if (out)
-		memcpy(sgdata, buf, nbytes);
-	else
-		memcpy(buf, sgdata, nbytes);
-}
-
-static void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg)
-{
-	unsigned int rest_of_page;
-
-	walk->sg = sg;
-
-	walk->page = sg->page;
-	walk->len_this_segment = sg->length;
-
-	rest_of_page = PAGE_CACHE_SIZE - (sg->offset & (PAGE_CACHE_SIZE - 1));
-	walk->len_this_page = min(sg->length, rest_of_page);
-	walk->offset = sg->offset;
-}
-
-static void scatterwalk_map(struct scatter_walk *walk, int out)
-{
-	walk->data = crypto_kmap(walk->page, out) + walk->offset;
-}
-
-static void scatter_page_done(struct scatter_walk *walk, int out,
-			      unsigned int more)
-{
-	/* walk->data may be pointing the first byte of the next page;
-	   however, we know we transfered at least one byte.  So,
-	   walk->data - 1 will be a virutual address in the mapped page. */
-
-	if (out)
-		flush_dcache_page(walk->page);
-
-	if (more) {
-		walk->len_this_segment -= walk->len_this_page;
-
-		if (walk->len_this_segment) {
-			walk->page++;
-			walk->len_this_page = min(walk->len_this_segment,
-						  (unsigned)PAGE_CACHE_SIZE);
-			walk->offset = 0;
-		}
-		else
-			scatterwalk_start(walk, sg_next(walk->sg));
-	}
-}
-
-static void scatter_done(struct scatter_walk *walk, int out, int more)
-{
-	crypto_kunmap(walk->data, out);
-	if (walk->len_this_page == 0 || !more)
-		scatter_page_done(walk, out, more);
-}
-
-/*
- * Do not call this unless the total length of all of the fragments 
- * has been verified as multiple of the block size.
- */
-static int copy_chunks(void *buf, struct scatter_walk *walk,
-			size_t nbytes, int out)
-{
-	if (buf != walk->data) {
-		while (nbytes > walk->len_this_page) {
-			memcpy_dir(buf, walk->data, walk->len_this_page, out);
-			buf += walk->len_this_page;
-			nbytes -= walk->len_this_page;
-
-			crypto_kunmap(walk->data, out);
-			scatter_page_done(walk, out, 1);
-			scatterwalk_map(walk, out);
-		}
-
-		memcpy_dir(buf, walk->data, nbytes, out);
-	}
-
-	walk->offset += nbytes;
-	walk->len_this_page -= nbytes;
-	walk->len_this_segment -= nbytes;
-	return 0;
-}
-
 /* 
  * Generic encrypt/decrypt wrapper for ciphers, handles operations across
  * multiple page boundaries by using temporary blocks.  In user context,
@@ -191,19 +71,19 @@
 
 		scatterwalk_map(&walk_in, 0);
 		scatterwalk_map(&walk_out, 1);
-		src_p = which_buf(&walk_in, bsize, tmp_src);
-		dst_p = which_buf(&walk_out, bsize, tmp_dst);
+		src_p = scatterwalk_whichbuf(&walk_in, bsize, tmp_src);
+		dst_p = scatterwalk_whichbuf(&walk_out, bsize, tmp_dst);
 
 		nbytes -= bsize;
 
-		copy_chunks(src_p, &walk_in, bsize, 0);
+		scatterwalk_copychunks(src_p, &walk_in, bsize, 0);
 
 		prfn(tfm, dst_p, src_p, crfn, enc, info);
 
-		scatter_done(&walk_in, 0, nbytes);
+		scatterwalk_done(&walk_in, 0, nbytes);
 
-		copy_chunks(dst_p, &walk_out, bsize, 1);
-		scatter_done(&walk_out, 1, nbytes);
+		scatterwalk_copychunks(dst_p, &walk_out, bsize, 1);
+		scatterwalk_done(&walk_out, 1, nbytes);
 
 		if (!nbytes)
 			return 0;
@@ -229,7 +109,7 @@
 		const int need_stack = (src == dst);
 		u8 stack[need_stack ? crypto_tfm_alg_blocksize(tfm) : 0];
 		u8 *buf = need_stack ? stack : dst;
-		
+
 		fn(crypto_tfm_ctx(tfm), buf, src);
 		tfm->crt_u.cipher.cit_xor_block(buf, iv);
 		memcpy(iv, src, crypto_tfm_alg_blocksize(tfm));
diff -Nur linux.orig/crypto/internal.h linux/crypto/internal.h
--- linux.orig/crypto/internal.h	2004-02-25 23:40:51.978029000 +0100
+++ linux/crypto/internal.h	2004-02-25 23:44:24.367741840 +0100
@@ -11,6 +11,7 @@
  */
 #ifndef _CRYPTO_INTERNAL_H
 #define _CRYPTO_INTERNAL_H
+#include <linux/crypto.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
diff -Nur linux.orig/crypto/Makefile linux/crypto/Makefile
--- linux.orig/crypto/Makefile	2004-02-25 23:41:19.026917000 +0100
+++ linux/crypto/Makefile	2004-02-25 23:43:39.132618624 +0100
@@ -4,7 +4,7 @@
 
 proc-crypto-$(CONFIG_PROC_FS) = proc.o
 
-obj-$(CONFIG_CRYPTO) += api.o cipher.o digest.o compress.o \
+obj-$(CONFIG_CRYPTO) += api.o scatterwalk.o cipher.o digest.o compress.o \
 			$(proc-crypto-y)
 
 obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
diff -Nur linux.orig/crypto/scatterwalk.c linux/crypto/scatterwalk.c
--- linux.orig/crypto/scatterwalk.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/crypto/scatterwalk.c	2004-02-25 23:43:39.133618472 +0100
@@ -0,0 +1,124 @@
+/*
+ * Cryptographic API.
+ *
+ * Cipher operations.
+ *
+ * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ *               2002 Adam J. Richter <adam@yggdrasil.com>
+ *               2004 Jean-Luc Cooke <jlcooke@certainkey.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <asm/scatterlist.h>
+#include "internal.h"
+#include "scatterwalk.h"
+
+enum km_type crypto_km_types[] = {
+	KM_USER0,
+	KM_USER1,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+};
+
+void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch)
+{
+	if (nbytes <= walk->len_this_page &&
+	    (((unsigned long)walk->data) & (PAGE_CACHE_SIZE - 1)) + nbytes <=
+	    PAGE_CACHE_SIZE)
+		return walk->data;
+	else
+		return scratch;
+}
+
+static void memcpy_dir(void *buf, void *sgdata, size_t nbytes, int out)
+{
+	if (out)
+		memcpy(sgdata, buf, nbytes);
+	else
+		memcpy(buf, sgdata, nbytes);
+}
+
+void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg)
+{
+	unsigned int rest_of_page;
+
+	walk->sg = sg;
+
+	walk->page = sg->page;
+	walk->len_this_segment = sg->length;
+
+	rest_of_page = PAGE_CACHE_SIZE - (sg->offset & (PAGE_CACHE_SIZE - 1));
+	walk->len_this_page = min(sg->length, rest_of_page);
+	walk->offset = sg->offset;
+}
+
+void scatterwalk_map(struct scatter_walk *walk, int out)
+{
+	walk->data = crypto_kmap(walk->page, out) + walk->offset;
+}
+
+static void scatterwalk_pagedone(struct scatter_walk *walk, int out,
+				 unsigned int more)
+{
+	/* walk->data may be pointing the first byte of the next page;
+	   however, we know we transfered at least one byte.  So,
+	   walk->data - 1 will be a virutual address in the mapped page. */
+
+	if (out)
+		flush_dcache_page(walk->page);
+
+	if (more) {
+		walk->len_this_segment -= walk->len_this_page;
+
+		if (walk->len_this_segment) {
+			walk->page++;
+			walk->len_this_page = min(walk->len_this_segment,
+						  (unsigned)PAGE_CACHE_SIZE);
+			walk->offset = 0;
+		}
+		else
+			scatterwalk_start(walk, sg_next(walk->sg));
+	}
+}
+
+void scatterwalk_done(struct scatter_walk *walk, int out, int more)
+{
+	crypto_kunmap(walk->data, out);
+	if (walk->len_this_page == 0 || !more)
+		scatterwalk_pagedone(walk, out, more);
+}
+
+/*
+ * Do not call this unless the total length of all of the fragments 
+ * has been verified as multiple of the block size.
+ */
+int scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
+			   size_t nbytes, int out)
+{
+	if (buf != walk->data) {
+		while (nbytes > walk->len_this_page) {
+			memcpy_dir(buf, walk->data, walk->len_this_page, out);
+			buf += walk->len_this_page;
+			nbytes -= walk->len_this_page;
+
+			crypto_kunmap(walk->data, out);
+			scatterwalk_pagedone(walk, out, 1);
+			scatterwalk_map(walk, out);
+		}
+
+		memcpy_dir(buf, walk->data, nbytes, out);
+	}
+
+	walk->offset += nbytes;
+	walk->len_this_page -= nbytes;
+	walk->len_this_segment -= nbytes;
+	return 0;
+}
diff -Nur linux.orig/crypto/scatterwalk.h linux/crypto/scatterwalk.h
--- linux.orig/crypto/scatterwalk.h	1970-01-01 01:00:00.000000000 +0100
+++ linux/crypto/scatterwalk.h	2004-02-25 23:43:39.133618472 +0100
@@ -0,0 +1,42 @@
+/*
+ * Cryptographic API.
+ *
+ * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ * Copyright (c) 2002 Adam J. Richter <adam@yggdrasil.com>
+ * Copyright (c) 2004 Jean-Luc Cooke <jlcooke@certainkey.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+
+#ifndef _CRYPTO_SCATTERWALK_H
+#define _CRYPTO_SCATTERWALK_H
+#include <linux/mm.h>
+#include <asm/scatterlist.h>
+
+struct scatter_walk {
+	struct scatterlist	*sg;
+	struct page		*page;
+	void			*data;
+	unsigned int		len_this_page;
+	unsigned int		len_this_segment;
+	unsigned int		offset;
+};
+
+/* Define sg_next is an inline routine now in case we want to change
+   scatterlist to a linked list later. */
+static inline struct scatterlist *sg_next(struct scatterlist *sg)
+{
+	return sg + 1;
+}
+
+void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch);
+void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg);
+int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, size_t nbytes, int out);
+void scatterwalk_map(struct scatter_walk *walk, int out);
+void scatterwalk_done(struct scatter_walk *walk, int out, int more);
+
+#endif  /* _CRYPTO_SCATTERWALK_H */
