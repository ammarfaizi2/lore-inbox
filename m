Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWDYIYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWDYIYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWDYIYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:24:03 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:59931 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750981AbWDYIYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:24:02 -0400
Message-Id: <20060425082359.767915000@localhost.localdomain>
References: <20060425082137.028875000@localhost.localdomain>
Date: Tue, 25 Apr 2006 16:21:38 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 1/2] kref: detect kref_put() with unreferenced object
Content-Disposition: inline; filename=kref-more-warn.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds warning to detect kref_put() with unreferenced object.

The idea of detection kref_put() with unreferenced object was stolen
from BUG_ON()es in blocks/ll_rw_blk.c and fs/bio.c

ll_rw_blk.c:    BUG_ON(atomic_read(&ioc->refcount) == 0);

bio.c:          BIO_BUG_ON(!atomic_read(&bio->bi_cnt));

But the kref counter usually does not fall to zero. Because kref is
trying to reduce the number of atomic_dec_and_test()

So this patch also set kref counter to zero here:

+	if (atomic_read(&kref->refcount) == 1)
+		atomic_set(&kref->refcount, 0);

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
CC: Greg KH <greg@kroah.com>
CC: Patrick Mochel <mochel@osdl.org>

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
