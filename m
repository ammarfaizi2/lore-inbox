Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVEFLrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVEFLrp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 07:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVEFLro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 07:47:44 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:5897 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261163AbVEFLrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 07:47:37 -0400
To: akpm@osdl.org
CC: dwmw2@infradead.org, dedekind@infradead.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] __wait_on_freeing_inode fix
Message-Id: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 06 May 2005 13:46:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch fixes queer behavior in __wait_on_freeing_inode().

If I_LOCK was not set it called yield(), effectively busy waiting for
the removal of the inode from the hash.  This change was introduced
within "[PATCH] eliminate inode waitqueue hashtable" Changeset
1.1938.166.16 last october by wli.

The solution is to restore the old behavior, of unconditionally
waiting on the waitqueue.  It doesn't matter if I_LOCK is not set
initally, the task will go to sleep, and wake up when wake_up_inode()
is called from generic_delete_inode() after removing the inode from
the hash chain.

Comment is also updated to better reflect current behavior.

Compile tested only.  This condition is very hard to trigger normally
(simultaneous clear_inode() with iget()) so probably only heavy stress
testing can reveal any change of behavior.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

--- inode.c~	2005-05-02 11:24:49.000000000 +0200
+++ inode.c	2005-05-06 13:25:12.000000000 +0200
@@ -1253,29 +1253,21 @@
 }
 
 /*
- * If we try to find an inode in the inode hash while it is being deleted, we
- * have to wait until the filesystem completes its deletion before reporting
- * that it isn't found.  This is because iget will immediately call
- * ->read_inode, and we want to be sure that evidence of the deletion is found
- * by ->read_inode.
+ * If we try to find an inode in the inode hash while it is being
+ * deleted, we have to wait until the filesystem completes its
+ * deletion before reporting that it isn't found.  This function waits
+ * until the deletion _might_ have completed.  Callers are responsible
+ * to recheck inode state.
+ * 
+ * It doesn't matter if I_LOCK is not set initially, a call to
+ * wake_up_inode() after removing from the hash list will DTRT.
+ *
  * This is called with inode_lock held.
  */
 static void __wait_on_freeing_inode(struct inode *inode)
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_LOCK);
-
-	/*
-	 * I_FREEING and I_CLEAR are cleared in process context under
-	 * inode_lock, so we have to give the tasks who would clear them
-	 * a chance to run and acquire inode_lock.
-	 */
-	if (!(inode->i_state & I_LOCK)) {
-		spin_unlock(&inode_lock);
-		yield();
-		spin_lock(&inode_lock);
-		return;
-	}
 	wq = bit_waitqueue(&inode->i_state, __I_LOCK);
 	prepare_to_wait(wq, &wait.wait, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode_lock);



