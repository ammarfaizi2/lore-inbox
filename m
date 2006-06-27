Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030730AbWF0HUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030730AbWF0HUE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030731AbWF0HUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:01 -0400
Received: from ns.suse.de ([195.135.220.2]:13445 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030730AbWF0HT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:19:56 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:19:50 +1000
Message-Id: <1060627071950.26624@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 14] knfsd: Remove noise about filehandle being uptodate.
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a perfectly valid situation where fh_update gets called on an
already uptodate filehandle - in nfsd_create_v3 where a
CREATE_UNCHECKED finds an existing file and wants to just set the
size.

We could possible optimise out the call in that case, but the only
harm involved is that fh_update prints a warning, so it is easier to
remove the warning.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsfh.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff .prev/fs/nfsd/nfsfh.c ./fs/nfsd/nfsfh.c
--- .prev/fs/nfsd/nfsfh.c	2006-06-27 12:15:18.000000000 +1000
+++ ./fs/nfsd/nfsfh.c	2006-06-27 12:16:05.000000000 +1000
@@ -461,7 +461,7 @@ fh_update(struct svc_fh *fhp)
 	} else {
 		int size;
 		if (fhp->fh_handle.fh_fileid_type != 0)
-			goto out_uptodate;
+			goto out;
 		datap = fhp->fh_handle.fh_auth+
 			fhp->fh_handle.fh_size/4 -1;
 		size = (fhp->fh_maxsize - fhp->fh_handle.fh_size)/4;
@@ -481,10 +481,6 @@ out_negative:
 	printk(KERN_ERR "fh_update: %s/%s still negative!\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
 	goto out;
-out_uptodate:
-	printk(KERN_ERR "fh_update: %s/%s already up-to-date!\n",
-		dentry->d_parent->d_name.name, dentry->d_name.name);
-	goto out;
 }
 
 /*
