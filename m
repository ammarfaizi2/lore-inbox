Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVCYR2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVCYR2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCYR2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:28:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:35228 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261704AbVCYR0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:26:04 -0500
Date: Fri, 25 Mar 2005 18:27:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][4/5] cifs: cifsfs.c cleanup - reduce nesting
Message-ID: <Pine.LNX.4.62.0503251827040.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce deep nesting and get rid of the last few long lines beyond col 80.
The pstch reworks cifs_oplock_thread() and init_cifs() a bit to avoid the deep
nesitng of if statements - utilize continue in the loop to skip past parts
instead if nesting, and rewrite init_cifs with a few labels and goto's to
clean up resources in the proper order upon failure without nesting if's.

Btw, the reason for the excessive use of parenthesis in the new code in
init_cifs is to avoid gcc spitting out these warnings:
fs/cifs/cifsfs.c: In function `init_cifs':
fs/cifs/cifsfs.c:852: warning: suggest parentheses around assignment used as truth value
fs/cifs/cifsfs.c:854: warning: suggest parentheses around assignment used as truth value
fs/cifs/cifsfs.c:856: warning: suggest parentheses around assignment used as truth value
fs/cifs/cifsfs.c:858: warning: suggest parentheses around assignment used as truth value


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c.with_patch3	2005-03-25 17:38:11.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c	2005-03-25 18:03:34.000000000 +0100
@@ -768,50 +768,49 @@ static int cifs_oplock_thread(void *dumm
 			spin_unlock(&GlobalMid_Lock);
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(39 * HZ);
-		} else {
-			oplock_item = list_entry(GlobalOplock_Q.next,
-						 struct oplock_q_entry, qhead);
-			if (oplock_item) {
-				cFYI(1, ("found oplock item to write out"));
-				pTcon = oplock_item->tcon;
-				inode = oplock_item->pinode;
-				netfid = oplock_item->netfid;
-				spin_unlock(&GlobalMid_Lock);
-				DeleteOplockQEntry(oplock_item);
-				/* can not grab inode sem here since it would
-				   deadlock when oplock received on delete
-				   since vfs_unlink holds the i_sem across the
-				   call */
-				/* down(&inode->i_sem); */
-				if (S_ISREG(inode->i_mode)) {
-					rc = filemap_fdatawrite(inode->i_mapping);
-					if (CIFS_I(inode)->clientCanCacheRead == 0) {
-						filemap_fdatawait(inode->i_mapping);
-						invalidate_remote_inode(inode);
-					}
-				} else
-					rc = 0;
-				/* up(&inode->i_sem); */
-				if (rc)
-					CIFS_I(inode)->write_behind_rc = rc;
-				cFYI(1, ("Oplock flush inode %p rc %d", inode, rc));
-
-				/* releasing a stale oplock after recent
-				   reconnection of smb session using a now
-				   incorrect file handle is not a data
-				   integrity issue but do not bother sending an
-				   oplock release if session to server still is
-				   disconnected since oplock already released
-				   by the server in that case */
-				if (pTcon->tidStatus != CifsNeedReconnect) {
-				    rc = CIFSSMBLock(0, pTcon, netfid,
-					    0 /* len */ , 0 /* offset */, 0,
-					    0, LOCKING_ANDX_OPLOCK_RELEASE,
-					    0 /* wait flag */);
-					cFYI(1, ("Oplock release rc = %d ", rc));
-				}
-			} else
-				spin_unlock(&GlobalMid_Lock);
+			continue;
+		}
+		oplock_item = list_entry(GlobalOplock_Q.next,
+					 struct oplock_q_entry, qhead);
+		if (!oplock_item) {
+			spin_unlock(&GlobalMid_Lock);
+			continue;
+		}
+
+		cFYI(1, ("found oplock item to write out"));
+		pTcon = oplock_item->tcon;
+		inode = oplock_item->pinode;
+		netfid = oplock_item->netfid;
+		spin_unlock(&GlobalMid_Lock);
+		DeleteOplockQEntry(oplock_item);
+		/* can not grab inode sem here since it would deadlock when
+		   oplock received on delete since vfs_unlink holds the i_sem
+		   across the call */
+		/* down(&inode->i_sem); */
+		if (S_ISREG(inode->i_mode)) {
+			rc = filemap_fdatawrite(inode->i_mapping);
+			if (CIFS_I(inode)->clientCanCacheRead == 0) {
+				filemap_fdatawait(inode->i_mapping);
+				invalidate_remote_inode(inode);
+			}
+		} else
+			rc = 0;
+		/* up(&inode->i_sem); */
+		if (rc)
+			CIFS_I(inode)->write_behind_rc = rc;
+
+		cFYI(1, ("Oplock flush inode %p rc %d", inode, rc));
+
+		/* releasing a stale oplock after recent reconnection of smb
+		   session using a now incorrect file handle is not a data
+		   integrity issue but do not bother sending an oplock release
+		   if session to server still is disconnected since oplock
+		   already released by the server in that case */
+		if (pTcon->tidStatus != CifsNeedReconnect) {
+		    rc = CIFSSMBLock(0, pTcon, netfid, 0 /* len */ ,
+			    0 /* offset */, 0, 0, LOCKING_ANDX_OPLOCK_RELEASE,
+			    0 /* wait flag */);
+			cFYI(1, ("Oplock release rc = %d ", rc));
 		}
 	} while (!signal_pending(current));
 	complete_and_exit (&cifs_oplock_exited, 0);
@@ -852,27 +851,29 @@ static int __init init_cifs(void)
 		cFYI(1, ("cifs_max_pending set to max of 256"));
 	}
 
-	rc = cifs_init_inodecache();
-	if (!rc) {
-		rc = cifs_init_mids();
-		if (!rc) {
-			rc = cifs_init_request_bufs();
-			if (!rc) {
-				rc = register_filesystem(&cifs_fs_type);
-				if (!rc) {
-					rc = (int)kernel_thread(cifs_oplock_thread, NULL,
-						CLONE_FS | CLONE_FILES | CLONE_VM);
-					if (rc > 0)
-						return 0;
-					else
-						cERROR(1, ("error %d create oplock thread", rc));
-				}
-				cifs_destroy_request_bufs();
-			}
-			cifs_destroy_mids();
-		}
-		cifs_destroy_inodecache();
-	}
+	if ((rc = cifs_init_inodecache()))
+		goto out;
+	if ((rc = cifs_init_mids()))
+		goto out_destroy_inodecache;
+	if ((rc = cifs_init_request_bufs()))
+		goto out_destroy_mids;
+	if ((rc = register_filesystem(&cifs_fs_type)))
+		goto out_destroy_bufs;
+
+	rc = (int)kernel_thread(cifs_oplock_thread, NULL,
+				CLONE_FS | CLONE_FILES | CLONE_VM);
+	if (rc > 0)
+		return 0;
+	else
+		cERROR(1, ("error %d create oplock thread", rc));
+
+out_destroy_bufs:
+	cifs_destroy_request_bufs();
+out_destroy_mids:
+	cifs_destroy_mids();
+out_destroy_inodecache:
+	cifs_destroy_inodecache();
+out:
 #ifdef CONFIG_PROC_FS
 	cifs_proc_clean();
 #endif

