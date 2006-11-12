Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932863AbWKLJsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863AbWKLJsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 04:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbWKLJsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 04:48:25 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59605 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1754139AbWKLJsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 04:48:24 -0500
X-Sasl-enc: XSZk8bR+anS5Vxl1mu0fSLrYUqcibwtuKKinuCg8VazT 1163324903
Date: Sun, 12 Nov 2006 17:48:16 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: "bibo,mao" <bibo.mao@intel.com>, David Howells <dhowells@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] autofs4 - panic after mount fail
Message-ID: <Pine.LNX.4.64.0611121732010.2724@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Here is a patch to resolve the panic on failed mount of an autofs 
filesystem originally reported by Mao Bibo.

It addresses two issues that happen after the mount fail. The first a NULL 
pointer reference to a field (pipe) in the autofs superblock info 
structure and second the lack of super block cleanup by the autofs and 
autofs4 modules.

The work has been done against 2.6.19-rc4 but I have verified that the 
patch also applies against 2.6.19-rc5 and 2.6.19-rc5-mm1.

Signed-off-by: Ian Kent <raven@themaw.net>

---
--- linux-2.6.19-rc4/fs/autofs4/waitq.c.mount-fail-panic	2006-11-10 15:34:42.000000000 +0800
+++ linux-2.6.19-rc4/fs/autofs4/waitq.c	2006-11-10 19:49:57.000000000 +0800
@@ -41,10 +41,8 @@ void autofs4_catatonic_mode(struct autof
 		wake_up_interruptible(&wq->queue);
 		wq = nwq;
 	}
-	if (sbi->pipe) {
-		fput(sbi->pipe);	/* Close the pipe */
-		sbi->pipe = NULL;
-	}
+	fput(sbi->pipe);	/* Close the pipe */
+	sbi->pipe = NULL;
 }
 
 static int autofs4_write(struct file *file, const void *addr, int bytes)
--- linux-2.6.19-rc4/fs/autofs4/inode.c.mount-fail-panic	2006-11-10 15:34:42.000000000 +0800
+++ linux-2.6.19-rc4/fs/autofs4/inode.c	2006-11-12 17:07:26.000000000 +0800
@@ -99,6 +99,9 @@ static void autofs4_force_release(struct
 	struct dentry *this_parent = sbi->sb->s_root;
 	struct list_head *next;
 
+	if (!sbi->sb->s_root)
+		return;
+
 	spin_lock(&dcache_lock);
 repeat:
 	next = this_parent->d_subdirs.next;
@@ -146,6 +149,14 @@ void autofs4_kill_sb(struct super_block 
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(sb);
 
+	/*
+	 * In the event of a failure in get_sb_nodev the superblock
+	 * info is not present so nothing else has been setup, so
+	 * just exit when we are called from deactivate_super.
+	 */
+	if (!sbi)
+		return;
+
 	sb->s_fs_info = NULL;
 
 	if ( !sbi->catatonic )
@@ -310,7 +321,8 @@ int autofs4_fill_super(struct super_bloc
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->pipefd = -1;
-	sbi->catatonic = 0;
+	sbi->pipe = NULL;
+	sbi->catatonic = 1;
 	sbi->exp_timeout = 0;
 	sbi->oz_pgrp = process_group(current);
 	sbi->sb = s;
@@ -388,6 +400,7 @@ int autofs4_fill_super(struct super_bloc
 		goto fail_fput;
 	sbi->pipe = pipe;
 	sbi->pipefd = pipefd;
+	sbi->catatonic = 0;
 
 	/*
 	 * Success! Install the root dentry now to indicate completion.
@@ -412,6 +425,8 @@ fail_ino:
 	kfree(ino);
 fail_free:
 	kfree(sbi);
+	s->s_fs_info = NULL;
+	kill_anon_super(s);
 fail_unlock:
 	return -EINVAL;
 }
--- linux-2.6.19-rc4/fs/autofs/waitq.c.mount-fail-panic	2006-09-20 11:42:06.000000000 +0800
+++ linux-2.6.19-rc4/fs/autofs/waitq.c	2006-11-10 19:49:57.000000000 +0800
@@ -41,6 +41,7 @@ void autofs_catatonic_mode(struct autofs
 		wq = nwq;
 	}
 	fput(sbi->pipe);	/* Close the pipe */
+	sbi->pipe = NULL;
 	autofs_hash_dputall(&sbi->dirhash); /* Remove all dentry pointers */
 }
 
--- linux-2.6.19-rc4/fs/autofs/inode.c.mount-fail-panic	2006-11-10 15:34:42.000000000 +0800
+++ linux-2.6.19-rc4/fs/autofs/inode.c	2006-11-12 17:07:58.000000000 +0800
@@ -25,6 +25,14 @@ void autofs_kill_sb(struct super_block *
 	struct autofs_sb_info *sbi = autofs_sbi(sb);
 	unsigned int n;
 
+	/*
+	 * In the event of a failure in get_sb_nodev the superblock
+	 * info is not present so nothing else has been setup, so
+	 * just exit when we are called from deactivate_super.
+	 */
+	if (!sbi)
+		return;
+
 	if ( !sbi->catatonic )
 		autofs_catatonic_mode(sbi); /* Free wait queues, close pipe */
 
@@ -136,7 +144,8 @@ int autofs_fill_super(struct super_block
 
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
-	sbi->catatonic = 0;
+	sbi->pipe = NULL;
+	sbi->catatonic = 1;
 	sbi->exp_timeout = 0;
 	sbi->oz_pgrp = process_group(current);
 	autofs_initialize_hash(&sbi->dirhash);
@@ -180,6 +189,7 @@ int autofs_fill_super(struct super_block
 	if ( !pipe->f_op || !pipe->f_op->write )
 		goto fail_fput;
 	sbi->pipe = pipe;
+	sbi->catatonic = 0;
 
 	/*
 	 * Success! Install the root dentry now to indicate completion.
@@ -198,6 +208,8 @@ fail_iput:
 	iput(root_inode);
 fail_free:
 	kfree(sbi);
+	s->s_fs_info = NULL;
+	kill_anon_super(s);
 fail_unlock:
 	return -EINVAL;
 }
