Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUHYWxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUHYWxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUHYWw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:52:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:30875 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266218AbUHYWg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:36:57 -0400
X-Donotread: and you are reading this why?
Subject: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <20040825223503.GA27072@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:26 -0700
Message-Id: <1093473386452@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1803.60.1, 2004/08/02 17:02:58-07:00, greg@kroah.com

KREF: shrink the size of struct kref down to just a single atomic_t

This was based on a patch from Kiran, but tweaked further by me.

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/kref.h |    7 ++-----
 lib/kref.c           |   26 ++++++++++++--------------
 2 files changed, 14 insertions(+), 19 deletions(-)


diff -Nru a/include/linux/kref.h b/include/linux/kref.h
--- a/include/linux/kref.h	2004-08-25 14:58:17 -07:00
+++ b/include/linux/kref.h	2004-08-25 14:58:17 -07:00
@@ -18,15 +18,12 @@
 #include <linux/types.h>
 #include <asm/atomic.h>
 
-
 struct kref {
 	atomic_t refcount;
-	void (*release)(struct kref *kref);
 };
 
-void kref_init(struct kref *kref, void (*release)(struct kref *));
+void kref_init(struct kref *kref);
 struct kref *kref_get(struct kref *kref);
-void kref_put(struct kref *kref);
-
+void kref_put(struct kref *kref, void (*release) (struct kref *kref));
 
 #endif /* _KREF_H_ */
diff -Nru a/lib/kref.c b/lib/kref.c
--- a/lib/kref.c	2004-08-25 14:58:17 -07:00
+++ b/lib/kref.c	2004-08-25 14:58:17 -07:00
@@ -11,23 +11,16 @@
  *
  */
 
-/* #define DEBUG */
-
 #include <linux/kref.h>
 #include <linux/module.h>
 
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
@@ -44,15 +37,20 @@
 /**
  * kref_put - decrement refcount for object.
  * @kref: object.
+ * @release: pointer to the function that will clean up the object when the
+ *	     last reference to the object is released.
+ *	     This pointer is required, and it is not acceptable to pass kfree
+ *	     in as this function.
  *
- * Decrement the refcount, and if 0, call kref->release().
+ * Decrement the refcount, and if 0, call release().
  */
-void kref_put(struct kref *kref)
+void kref_put(struct kref *kref, void (*release) (struct kref *kref))
 {
-	if (atomic_dec_and_test(&kref->refcount)) {
-		pr_debug("kref cleaning up\n");
-		kref->release(kref);
-	}
+	WARN_ON(release == NULL);
+	WARN_ON(release == (void (*)(struct kref *))kfree);
+
+	if (atomic_dec_and_test(&kref->refcount))
+		release(kref);
 }
 
 EXPORT_SYMBOL(kref_init);

