Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWAZDuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWAZDuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWAZDtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:46 -0500
Received: from [202.53.187.9] ([202.53.187.9]:19435 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932236AbWAZDtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:20 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 10/23] [Suspend2] Add support for freezing filesystem bdevs.
Date: Thu, 26 Jan 2006 13:45:48 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034547.3178.57751.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add support for freezing and thawing bdevs of filesystems. Filesystems
are frozen in reverse order so that nested filesystems don't cause
deadlocks.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 09fc9ca..0e377ed 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -48,6 +48,56 @@
 DECLARE_COMPLETION(thaw);
 static atomic_t nr_frozen;
 
+struct frozen_fs
+{
+	struct list_head fsb_list;
+	struct super_block *sb;
+};
+
+LIST_HEAD(frozen_fs_list);
+
+void freezer_make_fses_rw(void)
+{
+	struct frozen_fs *fs, *next_fs;
+
+	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
+		thaw_bdev(fs->sb->s_bdev, fs->sb);
+
+		list_del(&fs->fsb_list);
+		kfree(fs);
+	}
+}
+
+/* 
+ * Done after userspace is frozen, so there should be no danger of
+ * fses being unmounted while we're in here.
+ */
+int freezer_make_fses_ro(void)
+{
+	struct frozen_fs *fs;
+	struct super_block *sb;
+
+	/* Generate the list */
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (!sb->s_root || !sb->s_bdev ||
+		    (sb->s_frozen == SB_FREEZE_TRANS) ||
+		    (sb->s_flags & MS_RDONLY))
+			continue;
+
+		fs = kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
+		fs->sb = sb;
+		list_add_tail(&fs->fsb_list, &frozen_fs_list);
+	};
+
+	/* Do the freezing in reverse order so filesystems dependant
+	 * upon others are frozen in the right order. (Eg loopback
+	 * on ext3). */
+	list_for_each_entry_reverse(fs, &frozen_fs_list, fsb_list)
+		freeze_bdev(fs->sb->s_bdev);
+
+	return 0;
+}
+
 static inline int freezeable(struct task_struct * p)
 {
 	if ((p == current) || 

--
Nigel Cunningham		nigel at suspend2 dot net
