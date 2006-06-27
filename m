Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030734AbWF0HU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030734AbWF0HU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030740AbWF0HUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60582 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030734AbWF0HUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:14 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:07 +1000
Message-Id: <1060627072007.26660@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 14] knfsd: nfsd: call nfsd_setuser() on fh_compose(), fix nfsd4 permissions problem
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@citi.umich.edu>


In the typical v2/v3 case the only new filehandles used as arguments to
operations are filehandles taken directly off the wire, which don't get
dentries until fh_verify() is called.

But in v4 the filehandles that are arguments to operations were often
created by previous operations (putrootfh, lookup, etc.) using
fh_compose, which sets the dentry in the filehandle without calling
nfsd_setuser().

This also means that, for example, if filesystem B is mounted on filesystem
A, and filesystem A is exported without root-squashing, then a client can
bypass the rootsquashing on B using a compound that starts at a filehandle
in A, crosses into B using lookups, and then does stuff in B.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./fs/nfsd/nfsfh.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff .prev/fs/nfsd/nfsfh.c ./fs/nfsd/nfsfh.c
--- .prev/fs/nfsd/nfsfh.c	2006-06-27 12:16:27.000000000 +1000
+++ ./fs/nfsd/nfsfh.c	2006-06-27 14:41:52.000000000 +1000
@@ -187,13 +187,6 @@ fh_verify(struct svc_rqst *rqstp, struct
 			goto out;
 		}
 
-		/* Set user creds for this exportpoint */
-		error = nfsd_setuser(rqstp, exp);
-		if (error) {
-			error = nfserrno(error);
-			goto out;
-		}
-
 		/*
 		 * Look up the dentry using the NFS file handle.
 		 */
@@ -251,6 +244,14 @@ fh_verify(struct svc_rqst *rqstp, struct
 	}
 	cache_get(&exp->h);
 
+	/* Set user creds for this exportpoint; necessary even in the "just
+	 * checking" case because this may be a filehandle that was created by
+	 * fh_compose, and that is about to be used in another nfsv4 compound
+	 * operation */
+	error = nfserrno(nfsd_setuser(rqstp, exp));
+	if (error)
+		goto out;
+
 	error = nfsd_mode_check(rqstp, dentry->d_inode->i_mode, type);
 	if (error)
 		goto out;
