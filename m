Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWJJDQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWJJDQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWJJDPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:15:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38317 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964921AbWJJDOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:14:42 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] nfsd: nfs_replay_me
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX84n-0004IO-ED@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:14:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are using NFS_REPLAY_ME as a special error value that is never leaked
to clients.  That works fine; the only problem is mixing host- and network-
endian values in the same objects.  Network-endian equivalent would work
just as fine; switch to it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfs4proc.c        |    6 +++---
 fs/nfsd/nfs4state.c       |    4 ++--
 include/linux/nfsd/nfsd.h |    1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9f403a6..2a2551b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -178,7 +178,7 @@ nfsd4_open(struct svc_rqst *rqstp, struc
 
 	/* check seqid for replay. set nfs4_owner */
 	status = nfsd4_process_open1(open);
-	if (status == NFSERR_REPLAY_ME) {
+	if (status == nfserr_replay_me) {
 		struct nfs4_replay *rp = &open->op_stateowner->so_replay;
 		fh_put(current_fh);
 		current_fh->fh_handle.fh_size = rp->rp_openfh_len;
@@ -189,7 +189,7 @@ nfsd4_open(struct svc_rqst *rqstp, struc
 			dprintk("nfsd4_open: replay failed"
 				" restoring previous filehandle\n");
 		else
-			status = NFSERR_REPLAY_ME;
+			status = nfserr_replay_me;
 	}
 	if (status)
 		goto out;
@@ -938,7 +938,7 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 		}
 
 encode_op:
-		if (op->status == NFSERR_REPLAY_ME) {
+		if (op->status == nfserr_replay_me) {
 			op->replay = &replay_owner->so_replay;
 			nfsd4_encode_replay(resp, op);
 			status = op->status = op->replay->rp_status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2e468c9..293b649 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1477,7 +1477,7 @@ nfsd4_process_open1(struct nfsd4_open *o
 	}
 	if (open->op_seqid == sop->so_seqid - 1) {
 		if (sop->so_replay.rp_buflen)
-			return NFSERR_REPLAY_ME;
+			return nfserr_replay_me;
 		/* The original OPEN failed so spectacularly
 		 * that we don't even have replay data saved!
 		 * Therefore, we have no choice but to continue
@@ -2233,7 +2233,7 @@ check_replay:
 	if (seqid == sop->so_seqid - 1) {
 		dprintk("NFSD: preprocess_seqid_op: retransmission?\n");
 		/* indicate replay to calling function */
-		return NFSERR_REPLAY_ME;
+		return nfserr_replay_me;
 	}
 	printk("NFSD: preprocess_seqid_op: bad seqid (expected %d, got %d)\n",
 			sop->so_seqid, seqid);
diff --git a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
index 68d29b6..eb23114 100644
--- a/include/linux/nfsd/nfsd.h
+++ b/include/linux/nfsd/nfsd.h
@@ -238,6 +238,7 @@ #define	nfserr_reclaim_bad	__constant_ht
 #define	nfserr_badname		__constant_htonl(NFSERR_BADNAME)
 #define	nfserr_cb_path_down	__constant_htonl(NFSERR_CB_PATH_DOWN)
 #define	nfserr_locked		__constant_htonl(NFSERR_LOCKED)
+#define	nfserr_replay_me	__constant_htonl(NFSERR_REPLAY_ME)
 
 /* error codes for internal use */
 /* if a request fails due to kmalloc failure, it gets dropped.
-- 
1.4.2.GIT

