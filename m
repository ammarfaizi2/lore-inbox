Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWJWPxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWJWPxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWJWPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:53:41 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:35542 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964857AbWJWPxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:53:40 -0400
Date: Mon, 23 Oct 2006 19:53:20 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Janak Desai <janak@us.ibm.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sys_unshare: remove a broken CLONE_SIGHAND code
Message-ID: <20061023155320.GA4208@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_unshare(CLONE_SIGHAND) is broken, the code under 'if (new_sigh)' is
never executed but very wrong. Just remove it to avoid a confusion,
task_lock() has nothing to do with ->sighand changing.

Also, change the comment in unshare_sighand(). Yes, CLONE_THREAD implies
CLONE_SIGHAND, but still it looks confusing. Also, we don't need to check
current->sighand != NULL.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc2-mm2/kernel/fork.c~	2006-10-22 19:28:17.000000000 +0400
+++ rc2-mm2/kernel/fork.c	2006-10-23 19:23:19.000000000 +0400
@@ -1523,15 +1523,13 @@ static int unshare_mnt_namespace(unsigne
 }
 
 /*
- * Unsharing of sighand for tasks created with CLONE_SIGHAND is not
- * supported yet
+ * Unsharing of sighand is not supported yet
  */
 static int unshare_sighand(unsigned long unshare_flags, struct sighand_struct **new_sighp)
 {
 	struct sighand_struct *sigh = current->sighand;
 
-	if ((unshare_flags & CLONE_SIGHAND) &&
-	    (sigh && atomic_read(&sigh->count) > 1))
+	if ((unshare_flags & CLONE_SIGHAND) && atomic_read(&sigh->count) > 1)
 		return -EINVAL;
 	else
 		return 0;
@@ -1605,7 +1603,7 @@ asmlinkage long sys_unshare(unsigned lon
 	int err = 0;
 	struct fs_struct *fs, *new_fs = NULL;
 	struct mnt_namespace *ns, *new_ns = NULL;
-	struct sighand_struct *sigh, *new_sigh = NULL;
+	struct sighand_struct *new_sigh = NULL;
 	struct mm_struct *mm, *new_mm = NULL, *active_mm = NULL;
 	struct files_struct *fd, *new_fd = NULL;
 	struct sem_undo_list *new_ulist = NULL;
@@ -1650,7 +1648,7 @@ asmlinkage long sys_unshare(unsigned lon
 		}
 	}
 
-	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
+	if (new_fs || new_ns || new_mm || new_fd || new_ulist ||
 				new_uts || new_ipc) {
 
 		task_lock(current);
@@ -1672,12 +1670,6 @@ asmlinkage long sys_unshare(unsigned lon
 			new_ns = ns;
 		}
 
-		if (new_sigh) {
-			sigh = current->sighand;
-			rcu_assign_pointer(current->sighand, new_sigh);
-			new_sigh = sigh;
-		}
-
 		if (new_mm) {
 			mm = current->mm;
 			active_mm = current->active_mm;

