Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266434AbUHBKQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266434AbUHBKQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUHBKPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:15:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:1409 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266450AbUHBKPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:15:06 -0400
Date: Mon, 2 Aug 2004 15:43:52 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       dipankar@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patchset] Lockfree fd lookup 1 of 5
Message-ID: <20040802101350.GC4385@vitalstatistix.in.ibm.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the first patch.  This patch 'shrinks' struct kref by removing
the release pointer in the struct kref.  GregKH has applied this to his tree

Thanks,
Kiran


D:
D: Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>
D:
D: kref-merged-2.6.7.patch:
D: This patch is the kref shrinkage patch which GregKH has agreed to include,
D: and has applied to his tree which he will push into mainline.
D:
diff -ruN -X dontdiff2 linux-2.6.7/include/linux/kref.h files_struct-kref-2.6.7/include/linux/kref.h
--- linux-2.6.7/include/linux/kref.h	2004-06-16 10:48:59.000000000 +0530
+++ files_struct-kref-2.6.7/include/linux/kref.h	2004-07-26 16:38:23.604361208 +0530
@@ -21,12 +21,11 @@
 
 struct kref {
 	atomic_t refcount;
-	void (*release)(struct kref *kref);
 };
 
-void kref_init(struct kref *kref, void (*release)(struct kref *));
+void kref_init(struct kref *kref);
 struct kref *kref_get(struct kref *kref);
-void kref_put(struct kref *kref);
+void kref_put(struct kref *kref, void (*release) (struct kref *kref));
 
 
 #endif /* _KREF_H_ */
diff -ruN -X dontdiff2 linux-2.6.7/lib/kref.c files_struct-kref-2.6.7/lib/kref.c
--- linux-2.6.7/lib/kref.c	2004-06-16 10:50:26.000000000 +0530
+++ files_struct-kref-2.6.7/lib/kref.c	2004-07-26 16:52:11.617484080 +0530
@@ -19,15 +19,10 @@
 /**
  * kref_init - initialize object.
  * @kref: object in question.
- * @release: pointer to a function that will clean up the object
- *	     when the last reference to the object is released.
- *	     This pointer is required.
  */
-void kref_init(struct kref *kref, void (*release)(struct kref *kref))
+void kref_init(struct kref *kref)
 {
-	WARN_ON(release == NULL);
 	atomic_set(&kref->refcount,1);
-	kref->release = release;
 }
 
 /**
@@ -44,14 +39,18 @@
 /**
  * kref_put - decrement refcount for object.
  * @kref: object.
+ * @release: pointer to the function that will clean up the object
+ *	     when the last reference to the object is released.
+ *	     This pointer is required.
  *
- * Decrement the refcount, and if 0, call kref->release().
+ * Decrement the refcount, and if 0, call release().
  */
-void kref_put(struct kref *kref)
+void kref_put(struct kref *kref, void (*release) (struct kref *kref))
 {
+	WARN_ON(release == NULL);
 	if (atomic_dec_and_test(&kref->refcount)) {
 		pr_debug("kref cleaning up\n");
-		kref->release(kref);
+		release(kref);
 	}
 }
 
