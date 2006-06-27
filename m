Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030714AbWF0HUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030714AbWF0HUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWF0HU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:18309 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030732AbWF0HUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:23 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:17 +1000
Message-Id: <1060627072017.26685@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 14] knfsd: nfsd: fix misplaced fh_unlock() in nfsd_link()
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: David M. Richter <richterd@citi.umich.edu>

In the event that lookup_one_len() fails in nfsd_link(), fh_unlock() is
skipped and locks are held overlong.

Patch was tested on 2.6.17-rc2 by causing lookup_one_len() to fail and
verifying that fh_unlock() gets called appropriately.

Signed-off-by: David M. Richter <richterd@citi.umich.edu>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./fs/nfsd/vfs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff .prev/fs/nfsd/vfs.c ./fs/nfsd/vfs.c
--- .prev/fs/nfsd/vfs.c	2006-06-27 12:15:21.000000000 +1000
+++ ./fs/nfsd/vfs.c	2006-06-27 14:44:27.000000000 +1000
@@ -1520,14 +1520,15 @@ nfsd_link(struct svc_rqst *rqstp, struct
 			err = nfserrno(err);
 	}
 
-	fh_unlock(ffhp);
 	dput(dnew);
+out_unlock:
+	fh_unlock(ffhp);
 out:
 	return err;
 
 out_nfserr:
 	err = nfserrno(err);
-	goto out;
+	goto out_unlock;
 }
 
 /*
