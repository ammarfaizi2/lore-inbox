Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWE2VZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWE2VZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWE2VZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:25:52 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:55480 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751358AbWE2VZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:48 -0400
Date: Mon, 29 May 2006 23:26:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 37/61] lock validator: special locking: dcache
Message-ID: <20060529212608.GK3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 fs/dcache.c            |    6 +++---
 include/linux/dcache.h |   12 ++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

Index: linux/fs/dcache.c
===================================================================
--- linux.orig/fs/dcache.c
+++ linux/fs/dcache.c
@@ -1380,10 +1380,10 @@ void d_move(struct dentry * dentry, stru
 	 */
 	if (target < dentry) {
 		spin_lock(&target->d_lock);
-		spin_lock(&dentry->d_lock);
+		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 	} else {
 		spin_lock(&dentry->d_lock);
-		spin_lock(&target->d_lock);
+		spin_lock_nested(&target->d_lock, DENTRY_D_LOCK_NESTED);
 	}
 
 	/* Move the dentry to the target hash queue, if on different bucket */
@@ -1420,7 +1420,7 @@ already_unhashed:
 	}
 
 	list_add(&dentry->d_u.d_child, &dentry->d_parent->d_subdirs);
-	spin_unlock(&target->d_lock);
+	spin_unlock_non_nested(&target->d_lock);
 	fsnotify_d_move(dentry);
 	spin_unlock(&dentry->d_lock);
 	write_sequnlock(&rename_lock);
Index: linux/include/linux/dcache.h
===================================================================
--- linux.orig/include/linux/dcache.h
+++ linux/include/linux/dcache.h
@@ -114,6 +114,18 @@ struct dentry {
 	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
 };
 
+/*
+ * dentry->d_lock spinlock nesting types:
+ *
+ * 0: normal
+ * 1: nested
+ */
+enum dentry_d_lock_type
+{
+	DENTRY_D_LOCK_NORMAL,
+	DENTRY_D_LOCK_NESTED
+};
+
 struct dentry_operations {
 	int (*d_revalidate)(struct dentry *, struct nameidata *);
 	int (*d_hash) (struct dentry *, struct qstr *);
