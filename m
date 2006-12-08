Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164339AbWLHBSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164339AbWLHBSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164242AbWLHBNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:13:33 -0500
Received: from mx1.suse.de ([195.135.220.2]:58428 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164328AbWLHBNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:23 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:13:36 +1100
Message-Id: <1061208011336.30591@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 18] knfsd: nfsd4: clarify units of COMPOUND_SLACK_SPACE
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

A comment here incorrectly states that "slack_space" is measured in words,
not bytes.  Remove the comment, and adjust a variable name and a few
comments to clarify the situation.

This is pure cleanup; there should be no change in functionality.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c        |   10 +++++-----
 ./include/linux/nfsd/nfsd.h |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-12-08 12:07:28.000000000 +1100
+++ ./fs/nfsd/nfs4proc.c	2006-12-08 12:08:12.000000000 +1100
@@ -740,7 +740,7 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 	struct svc_fh	*current_fh = NULL;
 	struct svc_fh	*save_fh = NULL;
 	struct nfs4_stateowner *replay_owner = NULL;
-	int		slack_space;    /* in words, not bytes! */
+	int		slack_bytes;
 	__be32		status;
 
 	status = nfserr_resource;
@@ -790,10 +790,10 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 		 * failed response to the next operation.  If we don't
 		 * have enough room, fail with ERR_RESOURCE.
 		 */
-/* FIXME - is slack_space *really* words, or bytes??? - neilb */
-		slack_space = (char *)resp->end - (char *)resp->p;
-		if (slack_space < COMPOUND_SLACK_SPACE + COMPOUND_ERR_SLACK_SPACE) {
-			BUG_ON(slack_space < COMPOUND_ERR_SLACK_SPACE);
+		slack_bytes = (char *)resp->end - (char *)resp->p;
+		if (slack_bytes < COMPOUND_SLACK_SPACE
+				+ COMPOUND_ERR_SLACK_SPACE) {
+			BUG_ON(slack_bytes < COMPOUND_ERR_SLACK_SPACE);
 			op->status = nfserr_resource;
 			goto encode_op;
 		}

diff .prev/include/linux/nfsd/nfsd.h ./include/linux/nfsd/nfsd.h
--- .prev/include/linux/nfsd/nfsd.h	2006-12-08 12:07:28.000000000 +1100
+++ ./include/linux/nfsd/nfsd.h	2006-12-08 12:08:12.000000000 +1100
@@ -275,12 +275,12 @@ static inline int is_fsid(struct svc_fh 
  * we might process an operation with side effects, and be unable to
  * tell the client that the operation succeeded.
  *
- * COMPOUND_SLACK_SPACE - this is the minimum amount of buffer space
+ * COMPOUND_SLACK_SPACE - this is the minimum bytes of buffer space
  * needed to encode an "ordinary" _successful_ operation.  (GETATTR,
  * READ, READDIR, and READLINK have their own buffer checks.)  if we
  * fall below this level, we fail the next operation with NFS4ERR_RESOURCE.
  *
- * COMPOUND_ERR_SLACK_SPACE - this is the minimum amount of buffer space
+ * COMPOUND_ERR_SLACK_SPACE - this is the minimum bytes of buffer space
  * needed to encode an operation which has failed with NFS4ERR_RESOURCE.
  * care is taken to ensure that we never fall below this level for any
  * reason.
