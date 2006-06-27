Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030739AbWF0HUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030739AbWF0HUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030714AbWF0HUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:09 -0400
Received: from cantor2.suse.de ([195.135.220.15]:57766 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030732AbWF0HUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:02 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:19:56 +1000
Message-Id: <1060627071956.26636@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 14] knfsd: Ignore ref_fh when crossing a mountpoint.
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nfsd tries to return to a client the same sort of filehandle as was
used by the client.  This removes some filehandle aliasing issues and
means that a server upgrade followed by a downgrade will not confused
clients not restarted during that time.

However when crossing a mountpoint, the filehandle used for one
filesystem doesn't provide any useful information on what sort of
filehandle should be used on the other, and can provide misleading
information.  So if the reference filehandle is on a different
filesystem to the one being generated, ignore it.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsfh.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff .prev/fs/nfsd/nfsfh.c ./fs/nfsd/nfsfh.c
--- .prev/fs/nfsd/nfsfh.c	2006-06-27 12:16:05.000000000 +1000
+++ ./fs/nfsd/nfsfh.c	2006-06-27 12:16:27.000000000 +1000
@@ -312,8 +312,8 @@ int
 fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry, struct svc_fh *ref_fh)
 {
 	/* ref_fh is a reference file handle.
-	 * if it is non-null, then we should compose a filehandle which is
-	 * of the same version, where possible.
+	 * if it is non-null and for the same filesystem, then we should compose
+	 * a filehandle which is of the same version, where possible.
 	 * Currently, that means that if ref_fh->fh_handle.fh_version == 0xca
 	 * Then create a 32byte filehandle using nfs_fhbase_old
 	 *
@@ -332,7 +332,7 @@ fh_compose(struct svc_fh *fhp, struct sv
 		parent->d_name.name, dentry->d_name.name,
 		(inode ? inode->i_ino : 0));
 
-	if (ref_fh) {
+	if (ref_fh && ref_fh->fh_export == exp) {
 		ref_fh_version = ref_fh->fh_handle.fh_version;
 		if (ref_fh_version == 0xca)
 			ref_fh_fsid_type = 0;
