Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWCURR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWCURR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWCURRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:17:55 -0500
Received: from pat.uio.no ([129.240.130.16]:8870 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932261AbWCURRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:17:54 -0500
Subject: NFSD4: return conflict lock without races
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Neil Brown <neilb@suse.de>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:17:47 -0500
Message-Id: <1142961468.7987.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.005, required 12,
	autolearn=disabled, AWL 0.99, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Adamson <andros@citi.umich.edu>

Update the NFSv4 server to use the new posix_lock_file_conf() interface. Remove
unnecessary (and race-prone) posix_test_file() calls.

Signed-off-by: Andy Adamson <andros@citi.umich.edu>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfsd/nfs4state.c |   38 ++++++++++++++++----------------------
 1 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f6ab762..b2f8b69 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2749,37 +2749,31 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	* Note: locks.c uses the BKL to protect the inode's lock list.
 	*/
 
-	status = posix_lock_file(filp, &file_lock);
-	dprintk("NFSD: nfsd4_lock: posix_lock_file status %d\n",status);
+	/* XXX?: Just to divert the locks_release_private at the start of
+	 * locks_copy_lock: */
+	conflock.fl_ops = NULL;
+	conflock.fl_lmops = NULL;
+	status = posix_lock_file_conf(filp, &file_lock, &conflock);
+	dprintk("NFSD: nfsd4_lock: posix_lock_file_conf status %d\n",status);
 	switch (-status) {
 	case 0: /* success! */
 		update_stateid(&lock_stp->st_stateid);
 		memcpy(&lock->lk_resp_stateid, &lock_stp->st_stateid, 
 				sizeof(stateid_t));
-		goto out;
-	case (EAGAIN):
-		goto conflicting_lock;
+		break;
+	case (EAGAIN):		/* conflock holds conflicting lock */
+		status = nfserr_denied;
+		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
+		nfs4_set_lock_denied(&conflock, &lock->lk_denied);
+		break;
 	case (EDEADLK):
 		status = nfserr_deadlock;
-		dprintk("NFSD: nfsd4_lock: posix_lock_file() failed! status %d\n",status);
-		goto out;
+		break;
 	default:        
-		status = nfserrno(status);
-		dprintk("NFSD: nfsd4_lock: posix_lock_file() failed! status %d\n",status);
-		goto out;
-	}
-
-conflicting_lock:
-	dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
-	status = nfserr_denied;
-	/* XXX There is a race here. Future patch needed to provide 
-	 * an atomic posix_lock_and_test_file
-	 */
-	if (!posix_test_lock(filp, &file_lock, &conflock)) {
-		status = nfserr_serverfault;
-		goto out;
+		dprintk("NFSD: nfsd4_lock: posix_lock_file_conf() failed! status %d\n",status);
+		status = nfserr_resource;
+		break;
 	}
-	nfs4_set_lock_denied(&conflock, &lock->lk_denied);
 out:
 	if (status && lock->lk_is_new && lock_sop)
 		release_stateowner(lock_sop);



