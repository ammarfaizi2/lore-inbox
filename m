Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030731AbWF0HVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030731AbWF0HVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030743AbWF0HVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:21:05 -0400
Received: from mail.suse.de ([195.135.220.2]:29829 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030736AbWF0HUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:38 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:32 +1000
Message-Id: <1060627072032.26721@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 011 of 14] knfsd: nfsd4: fix open flag passing
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@citi.umich.edu>


Since nfsv4 actually keeps around the file descriptors it gets from open
(instead of just using them for a single read or write operation), we need
to make sure that we can do RDWR opens and not just RDONLY/WRONLY.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./fs/nfsd/nfs4state.c |    6 +++---
 ./fs/nfsd/vfs.c       |    5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff .prev/fs/nfsd/nfs4state.c ./fs/nfsd/nfs4state.c
--- .prev/fs/nfsd/nfs4state.c	2006-06-27 15:00:26.000000000 +1000
+++ ./fs/nfsd/nfs4state.c	2006-06-27 15:04:03.000000000 +1000
@@ -1790,10 +1790,10 @@ nfsd4_process_open2(struct svc_rqst *rqs
 	} else {
 		/* Stateid was not found, this is a new OPEN */
 		int flags = 0;
+		if (open->op_share_access & NFS4_SHARE_ACCESS_READ)
+			flags |= MAY_READ;
 		if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
-			flags = MAY_WRITE;
-		else
-			flags = MAY_READ;
+			flags |= MAY_WRITE;
 		status = nfs4_new_open(rqstp, &stp, dp, current_fh, flags);
 		if (status)
 			goto out;

diff .prev/fs/nfsd/vfs.c ./fs/nfsd/vfs.c
--- .prev/fs/nfsd/vfs.c	2006-06-27 14:59:40.000000000 +1000
+++ ./fs/nfsd/vfs.c	2006-06-27 15:04:03.000000000 +1000
@@ -673,7 +673,10 @@ nfsd_open(struct svc_rqst *rqstp, struct
 		goto out_nfserr;
 
 	if (access & MAY_WRITE) {
-		flags = O_WRONLY|O_LARGEFILE;
+		if (access & MAY_READ)
+			flags = O_RDWR|O_LARGEFILE;
+		else
+			flags = O_WRONLY|O_LARGEFILE;
 
 		DQUOT_INIT(inode);
 	}
