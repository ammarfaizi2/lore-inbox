Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVCJAsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVCJAsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVCJAsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:48:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:56991 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262631AbVCJAmd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:33 -0500
Cc: gregkh@suse.de
Subject: [PATCH] kref: make kref_put return if this was the last put call.
In-Reply-To: <11104148853742@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:45 -0800
Message-Id: <11104148851950@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2050, 2005/03/09 10:00:20-08:00, gregkh@suse.de

[PATCH] kref: make kref_put return if this was the last put call.

This is needed for the upcoming klist code from Pat.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/kref.h |    2 +-
 lib/kref.c           |   11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)


diff -Nru a/include/linux/kref.h b/include/linux/kref.h
--- a/include/linux/kref.h	2005-03-09 16:28:38 -08:00
+++ b/include/linux/kref.h	2005-03-09 16:28:38 -08:00
@@ -26,7 +26,7 @@
 
 void kref_init(struct kref *kref);
 void kref_get(struct kref *kref);
-void kref_put(struct kref *kref, void (*release) (struct kref *kref));
+int kref_put(struct kref *kref, void (*release) (struct kref *kref));
 
 #endif /* __KERNEL__ */
 #endif /* _KREF_H_ */
diff -Nru a/lib/kref.c b/lib/kref.c
--- a/lib/kref.c	2005-03-09 16:28:38 -08:00
+++ b/lib/kref.c	2005-03-09 16:28:38 -08:00
@@ -42,14 +42,21 @@
  *	     in as this function.
  *
  * Decrement the refcount, and if 0, call release().
+ * Return 1 if the object was removed, otherwise return 0.  Beware, if this
+ * function returns 0, you still can not count on the kref from remaining in
+ * memory.  Only use the return value if you want to see if the kref is now
+ * gone, not present.
  */
-void kref_put(struct kref *kref, void (*release) (struct kref *kref))
+int kref_put(struct kref *kref, void (*release)(struct kref *kref))
 {
 	WARN_ON(release == NULL);
 	WARN_ON(release == (void (*)(struct kref *))kfree);
 
-	if (atomic_dec_and_test(&kref->refcount))
+	if (atomic_dec_and_test(&kref->refcount)) {
 		release(kref);
+		return 1;
+	}
+	return 0;
 }
 
 EXPORT_SYMBOL(kref_init);

