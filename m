Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWE2VeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWE2VeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWE2V0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:26:07 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11731 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751359AbWE2VZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:56 -0400
Date: Mon, 29 May 2006 23:26:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 39/61] lock validator: special locking: s_lock
Message-ID: <20060529212617.GM3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (per-filesystem) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
---
 fs/super.c         |   13 +++++++++----
 include/linux/fs.h |    1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

Index: linux/fs/super.c
===================================================================
--- linux.orig/fs/super.c
+++ linux/fs/super.c
@@ -54,7 +54,7 @@ DEFINE_SPINLOCK(sb_lock);
  *	Allocates and initializes a new &struct super_block.  alloc_super()
  *	returns a pointer new superblock or %NULL if allocation had failed.
  */
-static struct super_block *alloc_super(void)
+static struct super_block *alloc_super(struct file_system_type *type)
 {
 	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
 	static struct super_operations default_op;
@@ -72,7 +72,12 @@ static struct super_block *alloc_super(v
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
 		init_rwsem(&s->s_umount);
-		mutex_init(&s->s_lock);
+		/*
+		 * The locking rules for s_lock are up to the
+		 * filesystem. For example ext3fs has different
+		 * lock ordering than usbfs:
+		 */
+		mutex_init_key(&s->s_lock, type->name, &type->s_lock_key);
 		down_write(&s->s_umount);
 		s->s_count = S_BIAS;
 		atomic_set(&s->s_active, 1);
@@ -297,7 +302,7 @@ retry:
 	}
 	if (!s) {
 		spin_unlock(&sb_lock);
-		s = alloc_super();
+		s = alloc_super(type);
 		if (!s)
 			return ERR_PTR(-ENOMEM);
 		goto retry;
@@ -696,7 +701,7 @@ struct super_block *get_sb_bdev(struct f
 	 */
 	mutex_lock(&bdev->bd_mount_mutex);
 	s = sget(fs_type, test_bdev_super, set_bdev_super, bdev);
-	mutex_unlock(&bdev->bd_mount_mutex);
+	mutex_unlock_non_nested(&bdev->bd_mount_mutex);
 	if (IS_ERR(s))
 		goto out;
 
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -1307,6 +1307,7 @@ struct file_system_type {
 	struct module *owner;
 	struct file_system_type * next;
 	struct list_head fs_supers;
+	struct lockdep_type_key s_lock_key;
 };
 
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
