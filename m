Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWCTWCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWCTWCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbWCTWCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:02:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:50361 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030441AbWCTWBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:06 -0500
Cc: Eric Dumazet <dada1@cosmosbay.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/23] kref: avoid an atomic operation in kref_put()
In-Reply-To: <11428920383977-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920383213-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid an atomic operation in kref_put() when the last reference is
dropped. On most platforms, atomic_read() is a plan read of the counter
and involves no atomic at all.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 lib/kref.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

8b5536bbee53620f8d5f367987e5727ba36d886d
diff --git a/lib/kref.c b/lib/kref.c
index 0d07cc3..4a467fa 100644
--- a/lib/kref.c
+++ b/lib/kref.c
@@ -52,7 +52,12 @@ int kref_put(struct kref *kref, void (*r
 	WARN_ON(release == NULL);
 	WARN_ON(release == (void (*)(struct kref *))kfree);
 
-	if (atomic_dec_and_test(&kref->refcount)) {
+	/*
+	 * if current count is one, we are the last user and can release object
+	 * right now, avoiding an atomic operation on 'refcount'
+	 */
+	if ((atomic_read(&kref->refcount) == 1) ||
+	    (atomic_dec_and_test(&kref->refcount))) {
 		release(kref);
 		return 1;
 	}
-- 
1.2.4


