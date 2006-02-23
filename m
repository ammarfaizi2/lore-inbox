Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWBWQZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWBWQZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWBWQZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:25:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25751 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751667AbWBWQZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:25:16 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 17/23] proc: Give the root directory a task.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkw2giue.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd6qgirv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5heginy.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xs2gikb.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q2qgigc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zmkif3t8.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vev6f3q3.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r75uf3mc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mzgif3ik.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:24:08 -0700
In-Reply-To: <m1mzgif3ik.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:23:15 -0700")
Message-ID: <m1irr6f3h3.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Helper functions in base.c like proc_pident_readdir and proc_pident_lookup
assume the directories have an associated task, and cannot currently be used on
the /proc root directory because it does not have such a task.

This small changes allows for base.c to be simplified and later when multiple
pid spaces are introduced it makes getting the needed context information trivial.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/root.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

516b38bf721663deded53591272bdfc8f032f885
diff --git a/fs/proc/root.c b/fs/proc/root.c
index c3fd361..a3ceff3 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/smp_lock.h>
+#include <linux/mount.h>
 
 #include "internal.h"
 
@@ -29,6 +30,18 @@ struct proc_dir_entry *proc_sys_root;
 static struct super_block *proc_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
+	if (proc_mnt) {
+		/* Seed the root directory with a task so it doesn't need
+		 * to be special in base.c.  I would do this earlier but
+		 * the only task alive when /proc is mounted the first time
+		 * is the init_task and it is never considered alive.
+		 */
+		struct proc_inode *ei;
+		ei = PROC_I(proc_mnt->mnt_sb->s_root->d_inode);
+		if (!ei->tref->task)
+			tref_set(&ei->tref,
+				tref_get_by_pid(1, PIDTYPE_PID));
+	}
 	return get_sb_single(fs_type, flags, data, proc_fill_super);
 }
 
-- 
1.2.2.g709a

