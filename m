Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWDXIej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWDXIej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWDXIeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:34:22 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:42084 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751194AbWDXIeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:34:16 -0400
Message-Id: <20060424083342.069630000@localhost.localdomain>
References: <20060424083333.217677000@localhost.localdomain>
Date: Mon, 24 Apr 2006 16:33:35 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 2/4] kref debugging config option
Content-Disposition: inline; filename=kref-debug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts all WARN_ON() in kref code to BUG_ON().
And split them into new DEBUG_KREF config option.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 lib/Kconfig.debug |    7 +++++++
 lib/kref.c        |   30 +++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

Index: 2.6-git/lib/Kconfig.debug
===================================================================
--- 2.6-git.orig/lib/Kconfig.debug
+++ 2.6-git/lib/Kconfig.debug
@@ -130,6 +130,13 @@ config DEBUG_KOBJECT
 	  If you say Y here, some extra kobject debugging messages will be sent
 	  to the syslog. 
 
+config DEBUG_KREF
+	bool "kref debugging"
+	depends on DEBUG_KERNEL
+	help
+	  This option enables addition error checking for kref,
+	  library routines for handling generic reference counted objects.
+
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
Index: 2.6-git/lib/kref.c
===================================================================
--- 2.6-git.orig/lib/kref.c
+++ 2.6-git/lib/kref.c
@@ -20,16 +20,38 @@
  */
 void kref_init(struct kref *kref)
 {
-	atomic_set(&kref->refcount,1);
+	atomic_set(&kref->refcount, 1);
 }
 
+#ifdef CONFIG_DEBUG_KREF
+static void kref_get_debug_check(struct kref *kref)
+{
+	BUG_ON(!atomic_read(&kref->refcount));
+}
+static void kref_put_debug_check(struct kref *kref,
+				void (*release)(struct kref *kref))
+{
+	BUG_ON(atomic_read(&kref->refcount) < 1);
+	BUG_ON(release == NULL);
+	BUG_ON(release == (void (*)(struct kref *))kfree);
+}
+#else
+static void kref_get_debug_check(struct kref *kref)
+{
+}
+static void kref_put_debug_check(struct kref *kref,
+				void (*release)(struct kref *kref))
+{
+}
+#endif
+
 /**
  * kref_get - increment refcount for object.
  * @kref: object.
  */
 void kref_get(struct kref *kref)
 {
-	WARN_ON(!atomic_read(&kref->refcount));
+	kref_get_debug_check(kref);
 	atomic_inc(&kref->refcount);
 }
 
@@ -49,9 +71,7 @@ void kref_get(struct kref *kref)
  */
 int kref_put(struct kref *kref, void (*release)(struct kref *kref))
 {
-	WARN_ON(atomic_read(&kref->refcount) < 1);
-	WARN_ON(release == NULL);
-	WARN_ON(release == (void (*)(struct kref *))kfree);
+	kref_put_debug_check(kref, release);
 
 	/*
 	 * if current count is one, we are the last user and can release object

--
