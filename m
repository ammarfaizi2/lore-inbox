Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932241AbWFDPjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWFDPjj (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWFDPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 11:39:39 -0400
Received: from mx1.mail.ru ([194.67.23.121]:29279 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S932238AbWFDPji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 11:39:38 -0400
Date: Sun, 4 Jun 2006 19:44:09 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] jfs: possible deadlocks - continue
Message-ID: <20060604154409.GA13899@rain.homenetwork>
Mail-Followup-To: Dave Kleikamp <shaggy@austin.ibm.com>,
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reasons my post about "possible deadlocks"
didn't appear in jfs-discussion@lists.sourceforge.net.

>====================================
>[ BUG: possible deadlock detected! ]
>------------------------------------
>mount/5587 is trying to acquire lock:
> (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
>
>but task is already holding lock:
> (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
>
>which could potentially lead to deadlocks!
>
>other info that might help us debug this:
>2 locks held by mount/5587:
> #0:  (&inode->i_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
> #1:  (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
>
>stack backtrace:
> [<c0103095>] show_trace+0x16/0x19
> [<c0103562>] dump_stack+0x1a/0x1f
> [<c012ddd7>] __lockdep_acquire+0x6c6/0x907
> [<c012e063>] lockdep_acquire+0x4b/0x63
> [<c02f6f0c>] __mutex_lock_slowpath+0xa4/0x21c
> [<c02f7096>] mutex_lock+0x12/0x15
> [<c01b99be>] jfs_create+0x90/0x2b8
> [<c0161016>] vfs_create+0x91/0xda
> [<c0163939>] open_namei+0x15a/0x5b0
> [<c015326c>] do_filp_open+0x22/0x39
> [<c01541a8>] do_sys_open+0x40/0xbc
> [<c015424d>] sys_open+0x13/0x15
> [<c02f875d>] sysenter_past_esp+0x56/0x8d

I should add that this happened during boot, when root jfs
file system become from ro->rw

I look at code, and see that
1)locks wasn't release in the opposite order in which
they were taken
2)in jfs_rename we lock new_ip, and in "error path" we didn't unlock it
3)I see strange expression: "! !"

May be this worth to fix?

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.16/fs/jfs/namei.c
===================================================================
--- linux-2.6.16.orig/fs/jfs/namei.c
+++ linux-2.6.16/fs/jfs/namei.c
@@ -165,8 +165,8 @@ static int jfs_create(struct inode *dip,
 
       out3:
 	txEnd(tid);
-	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 	mutex_unlock(&JFS_IP(ip)->commit_mutex);
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 	if (rc) {
 		free_ea_wmap(ip);
 		ip->i_nlink = 0;
@@ -300,8 +300,8 @@ static int jfs_mkdir(struct inode *dip, 
 
       out3:
 	txEnd(tid);
-	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 	mutex_unlock(&JFS_IP(ip)->commit_mutex);
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 	if (rc) {
 		free_ea_wmap(ip);
 		ip->i_nlink = 0;
@@ -384,8 +384,8 @@ static int jfs_rmdir(struct inode *dip, 
 		if (rc == -EIO)
 			txAbort(tid, 1);
 		txEnd(tid);
-		mutex_unlock(&JFS_IP(dip)->commit_mutex);
 		mutex_unlock(&JFS_IP(ip)->commit_mutex);
+		mutex_unlock(&JFS_IP(dip)->commit_mutex);
 
 		goto out2;
 	}
@@ -422,8 +422,8 @@ static int jfs_rmdir(struct inode *dip, 
 
 	txEnd(tid);
 
-	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 	mutex_unlock(&JFS_IP(ip)->commit_mutex);
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 
 	/*
 	 * Truncating the directory index table is not guaranteed.  It
@@ -503,8 +503,8 @@ static int jfs_unlink(struct inode *dip,
 		if (rc == -EIO)
 			txAbort(tid, 1);	/* Marks FS Dirty */
 		txEnd(tid);
-		mutex_unlock(&JFS_IP(dip)->commit_mutex);
 		mutex_unlock(&JFS_IP(ip)->commit_mutex);
+		mutex_unlock(&JFS_IP(dip)->commit_mutex);
 		IWRITE_UNLOCK(ip);
 		goto out1;
 	}
@@ -527,8 +527,8 @@ static int jfs_unlink(struct inode *dip,
 		if ((new_size = commitZeroLink(tid, ip)) < 0) {
 			txAbort(tid, 1);	/* Marks FS Dirty */
 			txEnd(tid);
-			mutex_unlock(&JFS_IP(dip)->commit_mutex);
 			mutex_unlock(&JFS_IP(ip)->commit_mutex);
+			mutex_unlock(&JFS_IP(dip)->commit_mutex);
 			IWRITE_UNLOCK(ip);
 			rc = new_size;
 			goto out1;
@@ -556,9 +556,8 @@ static int jfs_unlink(struct inode *dip,
 
 	txEnd(tid);
 
-	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 	mutex_unlock(&JFS_IP(ip)->commit_mutex);
-
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 
 	while (new_size && (rc == 0)) {
 		tid = txBegin(dip->i_sb, 0);
@@ -847,8 +846,8 @@ static int jfs_link(struct dentry *old_d
       out:
 	txEnd(tid);
 
-	mutex_unlock(&JFS_IP(dir)->commit_mutex);
 	mutex_unlock(&JFS_IP(ip)->commit_mutex);
+	mutex_unlock(&JFS_IP(dir)->commit_mutex);
 
 	jfs_info("jfs_link: rc:%d", rc);
 	return rc;
@@ -1037,8 +1036,8 @@ static int jfs_symlink(struct inode *dip
 
       out3:
 	txEnd(tid);
-	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 	mutex_unlock(&JFS_IP(ip)->commit_mutex);
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 	if (rc) {
 		free_ea_wmap(ip);
 		ip->i_nlink = 0;
@@ -1160,10 +1159,11 @@ static int jfs_rename(struct inode *old_
 		if (S_ISDIR(new_ip->i_mode)) {
 			new_ip->i_nlink--;
 			if (new_ip->i_nlink) {
-				mutex_unlock(&JFS_IP(new_dir)->commit_mutex);
-				mutex_unlock(&JFS_IP(old_ip)->commit_mutex);
+				mutex_unlock(&JFS_IP(new_ip)->commit_mutex);
 				if (old_dir != new_dir)
 					mutex_unlock(&JFS_IP(old_dir)->commit_mutex);
+				mutex_unlock(&JFS_IP(old_ip)->commit_mutex);
+				mutex_unlock(&JFS_IP(new_dir)->commit_mutex);
 				if (!S_ISDIR(old_ip->i_mode) && new_ip)
 					IWRITE_UNLOCK(new_ip);
 				jfs_error(new_ip->i_sb,
@@ -1281,13 +1281,12 @@ static int jfs_rename(struct inode *old_
 
       out4:
 	txEnd(tid);
-
-	mutex_unlock(&JFS_IP(new_dir)->commit_mutex);
-	mutex_unlock(&JFS_IP(old_ip)->commit_mutex);
-	if (old_dir != new_dir)
-		mutex_unlock(&JFS_IP(old_dir)->commit_mutex);
 	if (new_ip)
 		mutex_unlock(&JFS_IP(new_ip)->commit_mutex);
+	if (old_dir != new_dir)
+		mutex_unlock(&JFS_IP(old_dir)->commit_mutex);
+	mutex_unlock(&JFS_IP(old_ip)->commit_mutex);
+	mutex_unlock(&JFS_IP(new_dir)->commit_mutex);
 
 	while (new_size && (rc == 0)) {
 		tid = txBegin(new_ip->i_sb, 0);
Index: linux-2.6.16/fs/jfs/jfs_txnmgr.c
===================================================================
--- linux-2.6.16.orig/fs/jfs/jfs_txnmgr.c
+++ linux-2.6.16/fs/jfs/jfs_txnmgr.c
@@ -2944,7 +2944,7 @@ int jfs_sync(void *arg)
 				 * Inode is being freed
 				 */
 				list_del_init(&jfs_ip->anon_inode_list);
-			} else if (! !mutex_trylock(&jfs_ip->commit_mutex)) {
+			} else if (mutex_trylock(&jfs_ip->commit_mutex)) {
 				/*
 				 * inode will be removed from anonymous list
 				 * when it is committed

-- 
/Evgeniy

