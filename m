Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWBWQ3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWBWQ3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWBWQ3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:29:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30871 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751721AbWBWQ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:29:51 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 20/23] proc: Make the generation of the self symlink table
 driven.
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
	<m1irr6f3h3.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ek1uf3eq.fsf_-_@ebiederm.dsl.xmission.com>
	<m1accif3bx.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:28:42 -0700
In-Reply-To: <m1accif3bx.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:27:14 -0700")
Message-ID: <m164n6f39h.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


By not rolling our own inode we get a little more code reuse,
and things get a little simpler and we don't have special
cases to contend with later.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |   40 +++++++++++++++++-----------------------
 1 files changed, 17 insertions(+), 23 deletions(-)

a0e7796422bcb45748f230194723ef1b4afe1228
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b27175a..a6bff2f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1666,6 +1666,12 @@ static struct inode_operations proc_tgid
 	.lookup		= proc_tgid_base_lookup,
 };
 
+static struct pid_entry proc_base_stuff[] = {
+	NOD(PROC_TGID_INO,     "self",	S_IFLNK|S_IRWXUGO,
+		&proc_self_inode_operations, NULL, {}),
+	{}
+};
+
 /**
  * proc_flush_task -  Remove dcache entries for @task from the /proc dcache.
  *
@@ -1747,24 +1753,12 @@ struct dentry *proc_pid_lookup(struct in
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
@@ -1887,14 +1881,13 @@ int proc_pid_readdir(struct file * filp,
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
+	nr -= (ARRAY_SIZE(proc_base_stuff) - 1);
 
 	/* f_version caches the tgid value that the last readdir call couldn't
 	 * return. lseek aka telldir automagically resets f_version to 0.
@@ -1917,6 +1910,7 @@ int proc_pid_readdir(struct file * filp,
 			break;
 		}
 	}
+out:
 	return 0;
 }
 
-- 
1.2.2.g709a

