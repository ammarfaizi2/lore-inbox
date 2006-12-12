Return-Path: <linux-kernel-owner+w=401wt.eu-S932588AbWLMASY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWLMASY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWLMARv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:17:51 -0500
Received: from ns.suse.de ([195.135.220.2]:57792 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932586AbWLMARr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:17:47 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 13 Dec 2006 10:59:49 +1100
Message-Id: <1061212235949.21551@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 014 of 14] knfsd: Don't mess with the 'mode' when storing a exclusive-create cookie.
References: <20061213105528.21128.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Staubach <staubach@redhat.com>

NFS V3 (and V4) support exclusive create by passing a 'cookie' which
can get stored with the file.  If the file exists but has exactly the
right cookie stored, then we assume this is a retransmit and the
exclusive create was successful.

The cookie is 64bits and is traditionally stored in the mtime and
atime fields.  This causes a problem with Solaris7 as negative mtime
or atime confuse it.  So we moved two bits into the mode word instead.

But inherited ACLs sometimes overwrite the mode word on create, so
this is a problem.

So we give up and just store 62 of the 64 bits and assume that is
close enough.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/vfs.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff .prev/fs/nfsd/vfs.c ./fs/nfsd/vfs.c
--- .prev/fs/nfsd/vfs.c	2006-12-08 12:08:37.000000000 +1100
+++ ./fs/nfsd/vfs.c	2006-12-13 10:44:55.000000000 +1100
@@ -1248,7 +1248,6 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 	__be32		err;
 	int		host_err;
 	__u32		v_mtime=0, v_atime=0;
-	int		v_mode=0;
 
 	err = nfserr_perm;
 	if (!flen)
@@ -1285,16 +1284,11 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 		goto out;
 
 	if (createmode == NFS3_CREATE_EXCLUSIVE) {
-		/* while the verifier would fit in mtime+atime,
-		 * solaris7 gets confused (bugid 4218508) if these have
-		 * the high bit set, so we use the mode as well
+		/* solaris7 gets confused (bugid 4218508) if these have
+		 * the high bit set, so just clear the high bits.
 		 */
 		v_mtime = verifier[0]&0x7fffffff;
 		v_atime = verifier[1]&0x7fffffff;
-		v_mode  = S_IFREG
-			| ((verifier[0]&0x80000000) >> (32-7)) /* u+x */
-			| ((verifier[1]&0x80000000) >> (32-9)) /* u+r */
-			;
 	}
 	
 	if (dchild->d_inode) {
@@ -1322,7 +1316,6 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 		case NFS3_CREATE_EXCLUSIVE:
 			if (   dchild->d_inode->i_mtime.tv_sec == v_mtime
 			    && dchild->d_inode->i_atime.tv_sec == v_atime
-			    && dchild->d_inode->i_mode  == v_mode
 			    && dchild->d_inode->i_size  == 0 )
 				break;
 			 /* fallthru */
@@ -1344,26 +1337,22 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 	}
 
 	if (createmode == NFS3_CREATE_EXCLUSIVE) {
-		/* Cram the verifier into atime/mtime/mode */
+		/* Cram the verifier into atime/mtime */
 		iap->ia_valid = ATTR_MTIME|ATTR_ATIME
-			| ATTR_MTIME_SET|ATTR_ATIME_SET
-			| ATTR_MODE;
+			| ATTR_MTIME_SET|ATTR_ATIME_SET;
 		/* XXX someone who knows this better please fix it for nsec */ 
 		iap->ia_mtime.tv_sec = v_mtime;
 		iap->ia_atime.tv_sec = v_atime;
 		iap->ia_mtime.tv_nsec = 0;
 		iap->ia_atime.tv_nsec = 0;
-		iap->ia_mode  = v_mode;
 	}
 
 	/* Set file attributes.
-	 * Mode has already been set but we might need to reset it
-	 * for CREATE_EXCLUSIVE
 	 * Irix appears to send along the gid when it tries to
 	 * implement setgid directories via NFS. Clear out all that cruft.
 	 */
  set_attr:
-	if ((iap->ia_valid &= ~(ATTR_UID|ATTR_GID)) != 0) {
+	if ((iap->ia_valid &= ~(ATTR_UID|ATTR_GID|ATTR_MODE)) != 0) {
  		__be32 err2 = nfsd_setattr(rqstp, resfhp, iap, 0, (time_t)0);
 		if (err2)
 			err = err2;
