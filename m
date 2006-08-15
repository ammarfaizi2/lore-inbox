Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWHOSFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWHOSFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWHOSFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:05:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30123 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030420AbWHOSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:05:46 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/7] proc: Give the root directory a task.
Date: Tue, 15 Aug 2006 12:05:26 -0600
Message-Id: <11556651322965-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helper functions in base.c like proc_pident_readdir and proc_pident_lookup
assume the directories have an associated task, and cannot currently be used on
the /proc root directory because it does not have such a task.

This small changes allows for base.c to be simplified and later when multiple
pid spaces are introduced it makes getting the needed context information trivial.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/root.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 8901c65..ffe66c3 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -16,6 +16,7 @@ #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/smp_lock.h>
+#include <linux/mount.h>
 
 #include "internal.h"
 
@@ -28,6 +29,17 @@ #endif
 static int proc_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
+	if (proc_mnt) {
+		/* Seed the root directory with a pid so it doesn't need
+		 * to be special in base.c.  I would do this earlier but
+		 * the only task alive when /proc is mounted the first time
+		 * is the init_task and it doesn't have any pids.
+		 */
+		struct proc_inode *ei;
+		ei = PROC_I(proc_mnt->mnt_sb->s_root->d_inode);
+		if (!ei->pid)
+			ei->pid = find_get_pid(1);
+	}
 	return get_sb_single(fs_type, flags, data, proc_fill_super, mnt);
 }
 
-- 
1.4.2.rc3.g7e18e-dirty

