Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWEYTKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWEYTKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWEYTKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:10:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39816 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030343AbWEYTKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:10:16 -0400
Date: Thu, 25 May 2006 20:10:12 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/10] lib: add idr_replace
Message-ID: <20060525191012.GT4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

This patch adds idr_replace() to replace an existing pointer in a single
operation.

Device-mapper will use this to update the pointer it stored against
a given id.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/include/linux/idr.h
===================================================================
--- linux-2.6.17-rc4.orig/include/linux/idr.h	2006-05-23 18:16:31.000000000 +0100
+++ linux-2.6.17-rc4/include/linux/idr.h	2006-05-23 18:16:40.000000000 +0100
@@ -78,6 +78,7 @@ void *idr_find(struct idr *idp, int id);
 int idr_pre_get(struct idr *idp, gfp_t gfp_mask);
 int idr_get_new(struct idr *idp, void *ptr, int *id);
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
+void *idr_replace(struct idr *idp, void *ptr, int id);
 void idr_remove(struct idr *idp, int id);
 void idr_destroy(struct idr *idp);
 void idr_init(struct idr *idp);
Index: linux-2.6.17-rc4/lib/idr.c
===================================================================
--- linux-2.6.17-rc4.orig/lib/idr.c	2006-05-23 18:16:31.000000000 +0100
+++ linux-2.6.17-rc4/lib/idr.c	2006-05-23 18:16:40.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #endif
+#include <linux/err.h>
 #include <linux/string.h>
 #include <linux/idr.h>
 
@@ -390,6 +391,48 @@ void *idr_find(struct idr *idp, int id)
 }
 EXPORT_SYMBOL(idr_find);
 
+/**
+ * idr_replace - replace pointer for given id
+ * @idp: idr handle
+ * @ptr: pointer you want associated with the id
+ * @id: lookup key
+ *
+ * Replace the pointer registered with an id and return the old value.
+ * A -ENOENT return indicates that @id was not found.
+ * A -EINVAL return indicates that @id was not within valid constraints.
+ *
+ * The caller must serialize vs idr_find(), idr_get_new(), and idr_remove().
+ */
+void *idr_replace(struct idr *idp, void *ptr, int id)
+{
+	int n;
+	struct idr_layer *p, *old_p;
+
+	n = idp->layers * IDR_BITS;
+	p = idp->top;
+
+	id &= MAX_ID_MASK;
+
+	if (id >= (1 << n))
+		return ERR_PTR(-EINVAL);
+
+	n -= IDR_BITS;
+	while ((n > 0) && p) {
+		p = p->ary[(id >> n) & IDR_MASK];
+		n -= IDR_BITS;
+	}
+
+	n = id & IDR_MASK;
+	if (unlikely(p == NULL || !test_bit(n, &p->bitmap)))
+		return ERR_PTR(-ENOENT);
+
+	old_p = p->ary[n];
+	p->ary[n] = ptr;
+
+	return (void *)old_p;
+}
+EXPORT_SYMBOL(idr_replace);
+
 static void idr_cache_ctor(void * idr_layer, kmem_cache_t *idr_layer_cache,
 		unsigned long flags)
 {
