Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbUBICvY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 21:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbUBICvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 21:51:24 -0500
Received: from alt.aurema.com ([203.217.18.57]:5547 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S264565AbUBICvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 21:51:20 -0500
Date: Mon, 9 Feb 2004 13:51:10 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [Trivial Patch] Bad tgid and tid lookup for /proc
Message-ID: <20040209135110.H17768@aurema.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

On 2.6.2, one can do the following, which is clearly wrong:

gen2 02:49:45 ~: cat /proc/1/task/$$/stat
1669 (bash) S 1668 1669 1669 34816 1730 256 1480 6479 12 4 8 5 5 17 15 0 1 0 8065 3252224 451 4294967295 134512640 134955932 3221225104 3221222840 4294960144 0 65536 3686404 1266761467 3222442959 0 0 17 0 0 0
gen2 02:50:44 ~: ls /proc/1/task
1
gen2 02:50:47 ~: cat /proc/$$/task/1/stat
1 (init) S 0 0 0 0 -1 256 109 190731 7 116 0 548 706 715 16 0 1 0 785 638976 61 4294967295 134512640 134982008 3221225168 3221222224 134598471 0 0 1467013372 680207875 3222467003 0 0 0 0 0 0
gen2 02:50:54 ~: ls /proc/$$/task
1669

The following trivial patch against 2.6.2 (applies also to 2.6.3-rc1)
fixes it:

--- Linux-2.6.1/fs/proc/base.old.c      Mon Feb  9 12:53:44 2004
+++ Linux-2.6.1/fs/proc/base.c  Mon Feb  9 13:02:52 2004
@@ -1739,14 +1739,13 @@
        read_unlock(&tasklist_lock);
        if (!task)
                goto out;
+       if (!thread_group_leader(task))
+               goto out_drop_task;
 
        inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO);
 
-
-       if (!inode) {
-               put_task_struct(task);
-               goto out;
-       }
+       if (!inode)
+               goto out_drop_task;
        inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
        inode->i_op = &proc_tgid_base_inode_operations;
        inode->i_fop = &proc_tgid_base_operations;
@@ -1771,6 +1770,8 @@
                goto out;
        }
        return NULL;
+out_drop_task:
+       put_task_struct(task);
 out:
        return ERR_PTR(-ENOENT);
 }
@@ -1779,6 +1780,7 @@
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentr
y, struct nameidata *nd)
 {
        struct task_struct *task;
+       struct task_struct *leader = proc_task(dir);
        struct inode *inode;
        unsigned tid;
 
@@ -1793,14 +1795,14 @@
        read_unlock(&tasklist_lock);
        if (!task)
                goto out;
+       if (leader->tgid != task->tgid)
+               goto out_drop_task;
 
        inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_INO);
 
 
-       if (!inode) {
-               put_task_struct(task);
-               goto out;
-       }
+       if (!inode)
+               goto out_drop_task;
        inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
        inode->i_op = &proc_tid_base_inode_operations;
        inode->i_fop = &proc_tid_base_operations;
@@ -1813,6 +1815,8 @@
 
        put_task_struct(task);
        return NULL;
+out_drop_task:
+       put_task_struct(task);
 out:
        return ERR_PTR(-ENOENT);
 }


-- 
		Kingsley
