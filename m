Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUGZPOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUGZPOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 11:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUGZPIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 11:08:40 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:29845 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265663AbUGZOuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 10:50:14 -0400
Date: Mon, 26 Jul 2004 20:18:56 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] Add kref_read and kref_put_last primitives
Message-ID: <20040726144856.GH1231@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,
Here is a patch to add kref_read and kref_put_last.
These primitives were needed to change files_struct.f_count
refcounter to use kref api.

kref_put_last is needed sometimes when a refcount might
have an unconventional release which needs more than
the refcounted object to process object release-- like in the
files_struct.f_count conversion patch at __aio_put_req().
The following patch depends on kref shrinkage patches.
(which you have already included).

Please include.

Thanks,
Kiran

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>

diff -ruN -X dontdiff2 linux-kref-2.6.7/include/linux/kref.h files_struct-kref-2.6.7/include/linux/kref.h
--- linux-kref-2.6.7/include/linux/kref.h	2004-07-26 18:53:24.000000000 +0530
+++ files_struct-kref-2.6.7/include/linux/kref.h	2004-07-26 18:48:43.543549752 +0530
@@ -26,6 +26,8 @@
 void kref_init(struct kref *kref);
 struct kref *kref_get(struct kref *kref);
 void kref_put(struct kref *kref, void (*release) (struct kref *kref));
+int kref_read(struct kref *kref);
+int kref_put_last(struct kref *kref);
 
 
 #endif /* _KREF_H_ */
diff -ruN -X dontdiff2 linux-kref-2.6.7/lib/kref.c files_struct-kref-2.6.7/lib/kref.c
--- linux-kref-2.6.7/lib/kref.c	2004-07-26 18:53:24.228879096 +0530
+++ files_struct-kref-2.6.7/lib/kref.c	2004-07-26 19:02:20.782310576 +0530
@@ -54,6 +54,33 @@
 	}
 }
 
+/**
+ * kref_read - Return the refcount value.
+ * @kref: object.
+ */
+int kref_read(struct kref *kref)
+{
+	return atomic_read(&kref->refcount);
+}
+
+/**
+ * kref_put_last - decrement refcount for object.
+ * @kref: object.
+ *
+ * Decrement the refcount, and if 0 return true.
+ * Returns false otherwise.  
+ * Use this only if you cannot use kref_put -- when the 
+ * release function of kref_put needs more than just the 
+ * refcounted object. Use of kref_put_last when kref_put
+ * can do will be frowned upon.
+ */
+int kref_put_last(struct kref *kref)
+{
+	return atomic_dec_and_test(&kref->refcount);
+}
+
 EXPORT_SYMBOL(kref_init);
 EXPORT_SYMBOL(kref_get);
 EXPORT_SYMBOL(kref_put);
+EXPORT_SYMBOL(kref_read);
+EXPORT_SYMBOL(kref_put_last);
