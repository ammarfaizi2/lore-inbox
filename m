Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWF3MeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWF3MeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWF3MeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:34:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19117 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932543AbWF3MeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:34:15 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/2] AUTOFS: Make sure all dentries refs are released before calling kill_anon_super()
Date: Fri, 30 Jun 2006 13:33:28 +0100
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com, neilb@suse.de,
       raven@themaw.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       autofs@linux.kernel.org, dhowells@redhat.com
Message-Id: <20060630123328.26938.19324.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060630123326.26938.278.stgit@warthog.cambridge.redhat.com>
References: <20060630123326.26938.278.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make sure all dentries refs are released before calling kill_anon_super() so
that the assumption that generic_shutdown_super() can completely destroy the
dentry tree for there will be no external references holds true.

What was being done in the put_super() superblock op, is now done in the
kill_sb() filesystem op instead, prior to calling kill_anon_super().

This makes the struct autofs_sb_info::root member variable redundant (since
sb->s_root is still available), and so that is removed.  The calls to
shrink_dcache_sb() are also removed since they're also redundant as
shrink_dcache_for_umount() will now be called after the cleanup routine.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/autofs4/autofs_i.h |    3 +--
 fs/autofs4/init.c     |    2 +-
 fs/autofs4/inode.c    |   22 ++++------------------
 fs/autofs4/waitq.c    |    1 -
 4 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index d6603d0..47e38f3 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -96,7 +96,6 @@ #define AUTOFS_TYPE_OFFSET       0x0004
 
 struct autofs_sb_info {
 	u32 magic;
-	struct dentry *root;
 	int pipefd;
 	struct file *pipe;
 	pid_t oz_pgrp;
@@ -231,4 +230,4 @@ out:
 }
 
 void autofs4_dentry_release(struct dentry *);
-
+extern void autofs4_kill_sb(struct super_block *);
diff --git a/fs/autofs4/init.c b/fs/autofs4/init.c
index 5d91933..723a1c5 100644
--- a/fs/autofs4/init.c
+++ b/fs/autofs4/init.c
@@ -24,7 +24,7 @@ static struct file_system_type autofs_fs
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
 	.get_sb		= autofs_get_sb,
-	.kill_sb	= kill_anon_super,
+	.kill_sb	= autofs4_kill_sb,
 };
 
 static int __init init_autofs4_fs(void)
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index fde78b1..1bf68c5 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -95,7 +95,7 @@ void autofs4_free_ino(struct autofs_info
  */
 static void autofs4_force_release(struct autofs_sb_info *sbi)
 {
-	struct dentry *this_parent = sbi->root;
+	struct dentry *this_parent = sbi->sb->s_root;
 	struct list_head *next;
 
 	spin_lock(&dcache_lock);
@@ -126,7 +126,7 @@ resume:
 		spin_lock(&dcache_lock);
 	}
 
-	if (this_parent != sbi->root) {
+	if (this_parent != sbi->sb->s_root) {
 		struct dentry *dentry = this_parent;
 
 		next = this_parent->d_u.d_child.next;
@@ -139,15 +139,9 @@ resume:
 		goto resume;
 	}
 	spin_unlock(&dcache_lock);
-
-	dput(sbi->root);
-	sbi->root = NULL;
-	shrink_dcache_sb(sbi->sb);
-
-	return;
 }
 
-static void autofs4_put_super(struct super_block *sb)
+void autofs4_kill_sb(struct super_block *sb)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(sb);
 
@@ -162,6 +156,7 @@ static void autofs4_put_super(struct sup
 	kfree(sbi);
 
 	DPRINTK("shutting down");
+	kill_anon_super(sb);
 }
 
 static int autofs4_show_options(struct seq_file *m, struct vfsmount *mnt)
@@ -188,7 +183,6 @@ static int autofs4_show_options(struct s
 }
 
 static struct super_operations autofs4_sops = {
-	.put_super	= autofs4_put_super,
 	.statfs		= simple_statfs,
 	.show_options	= autofs4_show_options,
 };
@@ -314,7 +308,6 @@ int autofs4_fill_super(struct super_bloc
 
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
-	sbi->root = NULL;
 	sbi->pipefd = -1;
 	sbi->catatonic = 0;
 	sbi->exp_timeout = 0;
@@ -396,13 +389,6 @@ int autofs4_fill_super(struct super_bloc
 	sbi->pipefd = pipefd;
 
 	/*
-	 * Take a reference to the root dentry so we get a chance to
-	 * clean up the dentry tree on umount.
-	 * See autofs4_force_release.
-	 */
-	sbi->root = dget(root);
-
-	/*
 	 * Success! Install the root dentry now to indicate completion.
 	 */
 	s->s_root = root;
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index ce103e7..c0a6c8d 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -45,7 +45,6 @@ void autofs4_catatonic_mode(struct autof
 		fput(sbi->pipe);	/* Close the pipe */
 		sbi->pipe = NULL;
 	}
-	shrink_dcache_sb(sbi->sb);
 }
 
 static int autofs4_write(struct file *file, const void *addr, int bytes)
