Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030745AbWF0HU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030745AbWF0HU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030734AbWF0HUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:15749 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030731AbWF0HUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:07 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:02 +1000
Message-Id: <1060627072002.26648@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 14] knfsd: nfsd4: fix open_confirm locking
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@citi.umich.edu>

Fix an improper unlock in an error path.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./fs/nfsd/nfs4state.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff .prev/fs/nfsd/nfs4state.c ./fs/nfsd/nfs4state.c
--- .prev/fs/nfsd/nfs4state.c	2006-06-27 14:36:03.000000000 +1000
+++ ./fs/nfsd/nfs4state.c	2006-06-27 14:36:03.000000000 +1000
@@ -2252,8 +2252,9 @@ nfsd4_open_confirm(struct svc_rqst *rqst
 			(int)current_fh->fh_dentry->d_name.len,
 			current_fh->fh_dentry->d_name.name);
 
-	if ((status = fh_verify(rqstp, current_fh, S_IFREG, 0)))
-		goto out;
+	status = fh_verify(rqstp, current_fh, S_IFREG, 0);
+	if (status)
+		return status;
 
 	nfs4_lock_state();
 
