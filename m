Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbUJYOsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUJYOsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUJYOsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:48:23 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:47016 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261818AbUJYOmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:42:15 -0400
Cc: raven@themaw.net
Subject: [PATCH 7/28] AFS: Update AFS to use new expiry interface
In-Reply-To: <1098715291724@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:42:01 -0400
Message-Id: <10987153211852@sun.com>
References: <1098715291724@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update kAFS to use the new mountpoint expire infrastructure.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 cmservice.c |    5 -----
 mntpt.c     |   34 +++++++---------------------------
 super.c     |    2 --
 3 files changed, 7 insertions(+), 34 deletions(-)

Index: linux-2.6.9-quilt/fs/afs/mntpt.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/afs/mntpt.c	2004-08-14 01:36:17.000000000 -0400
+++ linux-2.6.9-quilt/fs/afs/mntpt.c	2004-10-22 17:17:36.477918656 -0400
@@ -43,16 +43,6 @@ struct inode_operations afs_mntpt_inode_
 	.getattr	= afs_inode_getattr,
 };
 
-static LIST_HEAD(afs_vfsmounts);
-
-static void afs_mntpt_expiry_timed_out(struct afs_timer *timer);
-
-struct afs_timer_ops afs_mntpt_expiry_timer_ops = {
-	.timed_out	= afs_mntpt_expiry_timed_out,
-};
-
-struct afs_timer afs_mntpt_expiry_timer;
-
 unsigned long afs_mntpt_expiry_timeout = 20;
 
 /*****************************************************************************/
@@ -252,9 +242,15 @@ static int afs_mntpt_follow_link(struct 
 
 	newnd = *nd;
 	newnd.dentry = dentry;
-	err = do_add_mount(newmnt, &newnd, 0, &afs_vfsmounts);
+	err = do_graft_mount(newmnt, &newnd);
 
 	if (!err) {
+		/*
+		 * We currently don't test to see if we were able to set 
+		 * expiry.
+		 */
+		mnt_expire(newmnt, afs_mntpt_expiry_timeout);
+
 		path_release(nd);
 		mntget(newmnt);
 		nd->mnt = newmnt;
@@ -265,19 +261,3 @@ static int afs_mntpt_follow_link(struct 
 	kleave(" = %d", err);
 	return err;
 } /* end afs_mntpt_follow_link() */
-
-/*****************************************************************************/
-/*
- * handle mountpoint expiry timer going off
- */
-static void afs_mntpt_expiry_timed_out(struct afs_timer *timer)
-{
-	kenter("");
-
-	mark_mounts_for_expiry(&afs_vfsmounts);
-
-	afs_kafstimod_add_timer(&afs_mntpt_expiry_timer,
-				afs_mntpt_expiry_timeout * HZ);
-
-	kleave("");
-} /* end afs_mntpt_expiry_timed_out() */
Index: linux-2.6.9-quilt/fs/afs/cmservice.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/afs/cmservice.c	2004-08-14 01:36:57.000000000 -0400
+++ linux-2.6.9-quilt/fs/afs/cmservice.c	2004-10-22 17:17:36.478918504 -0400
@@ -306,9 +306,6 @@ int afscm_start(void)
 		ret = rxrpc_add_service(afs_transport, &AFSCM_service);
 		if (ret < 0)
 			goto kill;
-
-		afs_kafstimod_add_timer(&afs_mntpt_expiry_timer,
-					afs_mntpt_expiry_timeout * HZ);
 	}
 
 	afscm_usage++;
@@ -389,8 +386,6 @@ void afscm_stop(void)
 			spin_lock(&kafscmd_attention_lock);
 		}
 		spin_unlock(&kafscmd_attention_lock);
-
-		afs_kafstimod_del_timer(&afs_mntpt_expiry_timer);
 	}
 
 	up_write(&afscm_sem);
Index: linux-2.6.9-quilt/fs/afs/super.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/afs/super.c	2004-08-14 01:36:56.000000000 -0400
+++ linux-2.6.9-quilt/fs/afs/super.c	2004-10-22 17:17:36.478918504 -0400
@@ -78,8 +78,6 @@ int __init afs_fs_init(void)
 
 	_enter("");
 
-	afs_timer_init(&afs_mntpt_expiry_timer, &afs_mntpt_expiry_timer_ops);
-
 	/* create ourselves an inode cache */
 	atomic_set(&afs_count_active_inodes, 0);
 

