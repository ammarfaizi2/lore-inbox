Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030737AbWF0HXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030737AbWF0HXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030732AbWF0HXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:23:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:20613 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030737AbWF0HUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:33 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:27 +1000
Message-Id: <1060627072027.26709@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 010 of 14] knfsd: nfsd4: fix some open argument tests
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@citi.umich.edu>


These tests always returned true; clearly that wasn't what was intended.

In keeping with kernel style, make them functions instead of macros while
we're at it.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./fs/nfsd/nfs4state.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff .prev/fs/nfsd/nfs4state.c ./fs/nfsd/nfs4state.c
--- .prev/fs/nfsd/nfs4state.c	2006-06-27 14:44:03.000000000 +1000
+++ ./fs/nfsd/nfs4state.c	2006-06-27 15:00:26.000000000 +1000
@@ -1237,8 +1237,15 @@ find_file(struct inode *ino)
 	return NULL;
 }
 
-#define TEST_ACCESS(x) ((x > 0 || x < 4)?1:0)
-#define TEST_DENY(x) ((x >= 0 || x < 5)?1:0)
+static int access_valid(u32 x)
+{
+	return (x > 0 && x < 4);
+}
+
+static int deny_valid(u32 x)
+{
+	return (x >= 0 && x < 5);
+}
 
 static void
 set_access(unsigned int *access, unsigned long bmap) {
@@ -1745,7 +1752,8 @@ nfsd4_process_open2(struct svc_rqst *rqs
 	int status;
 
 	status = nfserr_inval;
-	if (!TEST_ACCESS(open->op_share_access) || !TEST_DENY(open->op_share_deny))
+	if (!access_valid(open->op_share_access)
+			|| !deny_valid(open->op_share_deny))
 		goto out;
 	/*
 	 * Lookup file; if found, lookup stateid and check open request,
@@ -2317,7 +2325,8 @@ nfsd4_open_downgrade(struct svc_rqst *rq
 			(int)current_fh->fh_dentry->d_name.len,
 			current_fh->fh_dentry->d_name.name);
 
-	if (!TEST_ACCESS(od->od_share_access) || !TEST_DENY(od->od_share_deny))
+	if (!access_valid(od->od_share_access)
+			|| !deny_valid(od->od_share_deny))
 		return nfserr_inval;
 
 	nfs4_lock_state();
