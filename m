Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWHOSGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWHOSGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWHOSGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:06:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32939 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030413AbWHOSGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:06:48 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/7] proc: Make the generation of the self symlink table driven.
Date: Tue, 15 Aug 2006 12:05:27 -0600
Message-Id: <1155665132774-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By not rolling our own inode we get a little more code reuse,
and things get a little simpler and we don't have special
cases to contend with later.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |   41 ++++++++++++++++++-----------------------
 1 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c46b42b..96e22d7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1745,6 +1745,13 @@ static struct inode_operations proc_tgid
 	.setattr	= proc_setattr,
 };
 
+static struct pid_entry proc_base_stuff[] = {
+	NOD(PROC_TGID_INO,     "self",	S_IFLNK|S_IRWXUGO,
+		&proc_self_inode_operations, NULL, {}),
+	{}
+};
+
+
 /**
  * proc_flush_task -  Remove dcache entries for @task from the /proc dcache.
  *
@@ -1818,24 +1825,12 @@ struct dentry *proc_pid_lookup(struct in
 	struct dentry *result = ERR_PTR(-ENOENT);
 	struct task_struct *task;
 	struct inode *inode;
-	struct proc_inode *ei;
 	unsigned tgid;
 
-	if (dentry->d_name.len == 4 && !memcmp(dentry->d_name.name,"self",4)) {
-		inode = new_inode(dir->i_sb);
-		if (!inode)
-			return ERR_PTR(-ENOMEM);
-		ei = PROC_I(inode);
-		inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-		inode->i_ino = fake_ino(0, PROC_TGID_INO);
-		ei->pde = NULL;
-		inode->i_mode = S_IFLNK|S_IRWXUGO;
-		inode->i_uid = inode->i_gid = 0;
-		inode->i_size = 64;
-		inode->i_op = &proc_self_inode_operations;
-		d_add(dentry, inode);
-		return NULL;
-	}
+	result = proc_pident_lookup(dir, dentry, proc_base_stuff);
+	if (!IS_ERR(result) || PTR_ERR(result) != -ENOENT)
+		goto out;
+
 	tgid = name_to_int(dentry);
 	if (tgid == ~0U)
 		goto out;
@@ -1950,14 +1945,13 @@ int proc_pid_readdir(struct file * filp,
 	struct task_struct *task;
 	int tgid;
 
-	if (!nr) {
-		ino_t ino = fake_ino(0,PROC_TGID_INO);
-		if (filldir(dirent, "self", 4, filp->f_pos, ino, DT_LNK) < 0)
-			return 0;
-		filp->f_pos++;
-		nr++;
+	for (;nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
+		struct pid_entry *p = &proc_base_stuff[nr];
+		if (filldir(dirent, p->name, p->len, filp->f_pos,
+			    fake_ino(0, p->type), p->mode >> 12) < 0)
+			goto out;
 	}
-	nr -= 1;
+	nr -= ARRAY_SIZE(proc_base_stuff) - 1;
 
 	/* f_version caches the tgid value that the last readdir call couldn't
 	 * return. lseek aka telldir automagically resets f_version to 0.
@@ -1980,6 +1974,7 @@ int proc_pid_readdir(struct file * filp,
 			break;
 		}
 	}
+out:
 	return 0;
 }
 
-- 
1.4.2.rc3.g7e18e-dirty

