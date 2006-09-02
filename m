Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbWIBVgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWIBVgw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWIBVgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 17:36:52 -0400
Received: from sccrmhc15.comcast.net ([204.127.200.85]:48873 "EHLO
	sccrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751613AbWIBVgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 17:36:52 -0400
To: sfrench@us.ibm.com
Cc: linux-kernel@vger.kernel.org, jra@samba.org
Subject: [PATCH][CIFS] Convert new lock_sem to a mutex
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@love-shack.home.digitalvampire.org>
Date: Sat, 02 Sep 2006 14:36:46 -0700
Message-ID: <87zmdi54sx.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change to "allow Windows blocking locks to be cancelled via
a CANCEL_LOCK call" introduced a new semaphore in struct cifsFileInfo,
lock_sem.  However, semaphores used as mutexes are deprecated these
days, and there's no reason to add a new one to the kernel.
Therefore, convert lock_sem to a struct mutex (and also fix one
indentation glitch on one of the lines changed anyway).

Compile tested only, since I don't use CIFS.

Signed-off-by: Roland Dreier <roland@digitalvampire.org>

---

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index b24006c..5d7048a 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -306,7 +306,7 @@ struct cifsFileInfo {
 	/* lock scope id (0 if none) */
 	struct file * pfile; /* needed for writepage */
 	struct inode * pInode; /* needed for oplock break */
-	struct semaphore lock_sem;
+	struct mutex lock_mutex;
 	struct list_head llist; /* list of byte range locks we have. */
 	unsigned closePend:1;	/* file is marked to close */
 	unsigned invalidHandle:1;  /* file closed via session abend */
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 914239d..58042f5 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -267,7 +267,7 @@ cifs_create(struct inode *inode, struct 
 			pCifsFile->invalidHandle = FALSE;
 			pCifsFile->closePend     = FALSE;
 			init_MUTEX(&pCifsFile->fh_sem);
-			init_MUTEX(&pCifsFile->lock_sem);
+			mutex_init(&pCifsFile->lock_mutex);
 			INIT_LIST_HEAD(&pCifsFile->llist);
 			atomic_set(&pCifsFile->wrtPending,0);
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index e9c5ba9..e27f077 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -48,7 +48,7 @@ static inline struct cifsFileInfo *cifs_
 	private_data->netfid = netfid;
 	private_data->pid = current->tgid;	
 	init_MUTEX(&private_data->fh_sem);
-	init_MUTEX(&private_data->lock_sem);
+	mutex_init(&private_data->lock_mutex);
 	INIT_LIST_HEAD(&private_data->llist);
 	private_data->pfile = file; /* needed for writepage */
 	private_data->pInode = inode;
@@ -504,12 +504,12 @@ int cifs_close(struct inode *inode, stru
 
 		/* Delete any outstanding lock records.
 		   We'll lose them when the file is closed anyway. */
-		down(&pSMBFile->lock_sem);
+		mutex_lock(&pSMBFile->lock_mutex);
 		list_for_each_entry_safe(li, tmp, &pSMBFile->llist, llist) {
 			list_del(&li->llist);
 			kfree(li);
 		}
-		up(&pSMBFile->lock_sem);
+		mutex_unlock(&pSMBFile->lock_mutex);
 
 		write_lock(&GlobalSMBSeslock);
 		list_del(&pSMBFile->flist);
@@ -594,9 +594,9 @@ static int store_file_lock(struct cifsFi
 	li->offset = offset;
 	li->length = len;
 	li->type = lockType;
-	down(&fid->lock_sem);
+	mutex_lock(&fid->lock_mutex);
 	list_add(&li->llist, &fid->llist);
-	up(&fid->lock_sem);
+	mutex_unlock(&fid->lock_mutex);
 	return 0;
 }
 
@@ -752,7 +752,7 @@ int cifs_lock(struct file *file, int cmd
 			int stored_rc = 0;
 			struct cifsLockInfo *li, *tmp;
 
-			down(&fid->lock_sem);
+			mutex_lock(&fid->lock_mutex);
 			list_for_each_entry_safe(li, tmp, &fid->llist, llist) {
 				if (pfLock->fl_start <= li->offset &&
 						length >= li->length) {
@@ -766,7 +766,7 @@ int cifs_lock(struct file *file, int cmd
 					kfree(li);
 				}
 			}
-		up(&fid->lock_sem);
+			mutex_unlock(&fid->lock_mutex);
 		}
 	}
 

-- 
VGER BF report: H 2.74101e-05
