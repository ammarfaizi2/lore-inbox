Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUHNTfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUHNTfl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUHNTfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:35:41 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:51074 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264954AbUHNTas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:30:48 -0400
Subject: PATCH [3/7] Fix posix locking code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092511847.4109.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 15:30:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 NFSv4 server: fix locking code to use new posix locking callbacks.

 Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>

 nfs4state.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -u --recursive --new-file --show-c-function linux-2.6.8.1-02-fix_locks2/fs/nfsd/nfs4state.c linux-2.6.8.1-03-fix_nfsd/fs/nfsd/nfs4state.c
--- linux-2.6.8.1-02-fix_locks2/fs/nfsd/nfs4state.c	2004-08-14 14:27:08.000000000 -0400
+++ linux-2.6.8.1-03-fix_nfsd/fs/nfsd/nfs4state.c	2004-08-14 14:29:23.000000000 -0400
@@ -2179,6 +2179,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 		goto out;
 	}
 
+	locks_init_lock(&file_lock);
 	switch (lock->lk_type) {
 		case NFS4_READ_LT:
 		case NFS4_READW_LT:
@@ -2196,9 +2197,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	file_lock.fl_pid = lockownerid_hashval(lock->lk_stateowner->so_id);
 	file_lock.fl_file = filp;
 	file_lock.fl_flags = FL_POSIX;
-	file_lock.fl_notify = NULL;
-	file_lock.fl_insert = NULL;
-	file_lock.fl_remove = NULL;
 
 	file_lock.fl_start = lock->lk_offset;
 	if ((lock->lk_length == ~(u64)0) || 
@@ -2214,6 +2212,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	*/
 
 	status = posix_lock_file(filp, &file_lock);
+	if (file_lock.fl_ops && file_lock.fl_ops->fl_release_private)
+		file_lock.fl_ops->fl_release_private(&file_lock);
 	dprintk("NFSD: nfsd4_lock: posix_test_lock passed. posix_lock_file status %d\n",status);
 	switch (-status) {
 	case 0: /* success! */
@@ -2295,6 +2295,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, stru
 	}
 
 	inode = current_fh->fh_dentry->d_inode;
+	locks_init_lock(&file_lock);
 	switch (lockt->lt_type) {
 		case NFS4_READ_LT:
 		case NFS4_READW_LT:
@@ -2380,14 +2381,12 @@ nfsd4_locku(struct svc_rqst *rqstp, stru
 
 	filp = &stp->st_vfs_file;
 	BUG_ON(!filp);
+	locks_init_lock(&file_lock);
 	file_lock.fl_type = F_UNLCK;
 	file_lock.fl_owner = (fl_owner_t) locku->lu_stateowner;
 	file_lock.fl_pid = lockownerid_hashval(locku->lu_stateowner->so_id);
 	file_lock.fl_file = filp;
 	file_lock.fl_flags = FL_POSIX; 
-	file_lock.fl_notify = NULL;
-	file_lock.fl_insert = NULL;
-	file_lock.fl_remove = NULL;
 	file_lock.fl_start = locku->lu_offset;
 
 	if ((locku->lu_length == ~(u64)0) || LOFF_OVERFLOW(locku->lu_offset, locku->lu_length))
@@ -2400,6 +2399,8 @@ nfsd4_locku(struct svc_rqst *rqstp, stru
 	*  Try to unlock the file in the VFS.
 	*/
 	status = posix_lock_file(filp, &file_lock); 
+	if (file_lock.fl_ops && file_lock.fl_ops->fl_release_private)
+		file_lock.fl_ops->fl_release_private(&file_lock);
 	if (status) {
 		printk("NFSD: nfs4_locku: posix_lock_file failed!\n");
 		goto out_nfserr;

