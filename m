Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWDXIeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWDXIeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWDXIeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:34:16 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:40804 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751159AbWDXIeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:34:16 -0400
Message-Id: <20060424083341.613638000@localhost.localdomain>
References: <20060424083333.217677000@localhost.localdomain>
Date: Mon, 24 Apr 2006 16:33:34 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 1/4] kref: warn kref_put() with unreferenced kref
Content-Disposition: inline; filename=kref-more-warn.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds warning to detect kref_put() with unreferenced kref.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 lib/kref.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

Index: 2.6-git/lib/kref.c
===================================================================
--- 2.6-git.orig/lib/kref.c
+++ 2.6-git/lib/kref.c
@@ -49,6 +49,7 @@ void kref_get(struct kref *kref)
  */
 int kref_put(struct kref *kref, void (*release)(struct kref *kref))
 {
+	WARN_ON(atomic_read(&kref->refcount) < 1);
 	WARN_ON(release == NULL);
 	WARN_ON(release == (void (*)(struct kref *))kfree);
 
@@ -56,12 +57,13 @@ int kref_put(struct kref *kref, void (*r
 	 * if current count is one, we are the last user and can release object
 	 * right now, avoiding an atomic operation on 'refcount'
 	 */
-	if ((atomic_read(&kref->refcount) == 1) ||
-	    (atomic_dec_and_test(&kref->refcount))) {
-		release(kref);
-		return 1;
-	}
-	return 0;
+	if (atomic_read(&kref->refcount) == 1)
+		atomic_set(&kref->refcount, 0);
+	else if (!atomic_dec_and_test(&kref->refcount))
+		return 0;
+
+	release(kref);
+	return 1;
 }
 
 EXPORT_SYMBOL(kref_init);

--
