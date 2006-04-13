Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWDMUgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWDMUgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWDMUfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:35:52 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:33046 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964956AbWDMUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:35:49 -0400
Date: Thu, 13 Apr 2006 16:35:46 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 01/08] idr: add idr_replace method for replacing pointers
Message-ID: <20060413203546.GA3170@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 This patch adds an idr_replace() method to the IDR library for replacing
 a pointer already present in the IDR. Rather than do a remove/add pair, this
 function simply updates the pointer for an ID.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
--
 include/linux/idr.h |    1 +
 lib/idr.c           |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff -ruNpX ../dontdiff linux-2.6.16-staging1/include/linux/idr.h linux-2.6.16-staging2/include/linux/idr.h
--- linux-2.6.16-staging1/include/linux/idr.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.16-staging2/include/linux/idr.h	2006-04-13 16:18:14.000000000 -0400
@@ -78,6 +78,7 @@ void *idr_find(struct idr *idp, int id);
 int idr_pre_get(struct idr *idp, gfp_t gfp_mask);
 int idr_get_new(struct idr *idp, void *ptr, int *id);
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
+int idr_replace(struct idr *idp, void *ptr, int id);
 void idr_remove(struct idr *idp, int id);
 void idr_destroy(struct idr *idp);
 void idr_init(struct idr *idp);
diff -ruNpX ../dontdiff linux-2.6.16-staging1/lib/idr.c linux-2.6.16-staging2/lib/idr.c
--- linux-2.6.16-staging1/lib/idr.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.16-staging2/lib/idr.c	2006-04-13 16:18:14.000000000 -0400
@@ -390,6 +390,43 @@ void *idr_find(struct idr *idp, int id)
 }
 EXPORT_SYMBOL(idr_find);
 
+/**
+ * idr_replace - replace pointer for given id
+ * @idp: idr handle
+ * @ptr: pointer you want associated with the ide
+ * @id: lookup key
+ *
+ * Replace the pointer registered with the id.  A -ENOENT
+ * return indicates that @id was not found.
+ *
+ * The caller must serialize vs idr_find(), idr_get_new(), and idr_remove().
+ */
+int idr_replace(struct idr *idp, void *ptr, int id)
+{
+	int n;
+	struct idr_layer *p;
+	int shift = (idp->layers - 1) * IDR_BITS;
+
+	n = idp->layers * IDR_BITS;
+	p = idp->top;
+
+	id &= MAX_ID_MASK;
+
+	while ((shift > 0) && p) {
+		n = (id >> shift) & IDR_MASK;
+		p = p->ary[n];
+		shift -= IDR_BITS;
+	}
+
+	n = id & IDR_MASK;
+	if (unlikely(p == NULL || !test_bit(n, &p->bitmap)))
+		return -ENOENT;
+
+	p->ary[n] = ptr;
+	return 0;
+}
+EXPORT_SYMBOL(idr_replace);
+
 static void idr_cache_ctor(void * idr_layer, kmem_cache_t *idr_layer_cache,
 		unsigned long flags)
 {
