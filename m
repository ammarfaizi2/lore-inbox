Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319138AbSHMX1P>; Tue, 13 Aug 2002 19:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319097AbSHMX0R>; Tue, 13 Aug 2002 19:26:17 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:53500 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319138AbSHMXFD>; Tue, 13 Aug 2002 19:05:03 -0400
Date: Tue, 13 Aug 2002 19:08:52 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 29/38: SERVER: allow resfh==fhp in fh_compose()
Message-ID: <Pine.SOL.4.44.0208131908260.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change fh_compose() so that it will do the right thing if fhp==res_fh.
(This is convenient in the NFSv4 LOOKUP operation, which _replaces_
CURRENT_FH with the filehandle obtained by lookup.)

--- old/fs/nfsd/nfsfh.c	Fri Aug  9 09:38:11 2002
+++ new/fs/nfsd/nfsfh.c	Fri Aug  9 09:33:05 2002
@@ -316,7 +316,8 @@ fh_compose(struct svc_fh *fhp, struct sv
 	 * Then create a 32byte filehandle using nfs_fhbase_old
 	 *
 	 */
-
+	u8 ref_fh_version = 1;
+	u8 ref_fh_fsid_type = 1;
 	struct inode * inode = dentry->d_inode;
 	struct dentry *parent = dentry->d_parent;
 	__u32 *datap;
@@ -326,6 +327,13 @@ fh_compose(struct svc_fh *fhp, struct sv
 		parent->d_name.name, dentry->d_name.name,
 		(inode ? inode->i_ino : 0));

+	if (ref_fh) {
+		ref_fh_version = ref_fh->fh_handle.fh_version;
+		ref_fh_fsid_type = ref_fh->fh_handle.fh_fsid_type;
+		if (ref_fh == fhp)
+			fh_put(ref_fh);
+	}
+
 	if (fhp->fh_locked || fhp->fh_dentry) {
 		printk(KERN_ERR "fh_compose: fh %s/%s not initialized!\n",
 			parent->d_name.name, dentry->d_name.name);
@@ -337,8 +345,7 @@ fh_compose(struct svc_fh *fhp, struct sv
 	fhp->fh_dentry = dentry; /* our internal copy */
 	fhp->fh_export = exp;

-	if (ref_fh &&
-	    ref_fh->fh_handle.fh_version == 0xca) {
+	if (ref_fh_version == 0xca) {
 		/* old style filehandle please */
 		memset(&fhp->fh_handle.fh_base, 0, NFS_FHSIZE);
 		fhp->fh_handle.fh_size = NFS_FHSIZE;
@@ -354,7 +361,7 @@ fh_compose(struct svc_fh *fhp, struct sv
 		fhp->fh_handle.fh_auth_type = 0;
 		datap = fhp->fh_handle.fh_auth+0;
 		if ((exp->ex_flags & NFSEXP_FSID) &&
-		    (!ref_fh || ref_fh->fh_handle.fh_fsid_type == 1)) {
+		    (ref_fh_fsid_type == 1)) {
 			fhp->fh_handle.fh_fsid_type = 1;
 			/* fsid_type 1 == 4 bytes filesystem id */
 			*datap++ = exp->ex_fsid;

