Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161641AbWAMDO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161641AbWAMDO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161640AbWAMDO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:14:58 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:31661 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1161642AbWAMDOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:14:37 -0500
From: NeilBrown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 13 Jan 2006 14:14:28 +1100
Message-Id: <1060113031428.4672@cse.unsw.edu.au>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH kNFSd 003 of 3] Provide missing NFSv2 part of patch for checking vfs_getattr.
References: <20060113141059.4573.patches@notabene>
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on 
	tone.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: David Shaw <dshaw@jabberwocky.com>

A recent patch which checked the return status of vfs_getattr in nfsd,
completely missed the nfsproc.c (NFSv2) part.  Here is it.

This patch moved the call to vfs_getattr from the xdr encoding (at
which point it is too late to return an error) to the call handling.
This means several calls to vfs_getattr are needed in nfsproc.c.  Many
are encapsulated in nfsd_return_attrs and nfsd_return_dirop.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsproc.c |   37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff ./fs/nfsd/nfsproc.c~current~ ./fs/nfsd/nfsproc.c
--- ./fs/nfsd/nfsproc.c~current~	2006-01-13 13:42:09.000000000 +1100
+++ ./fs/nfsd/nfsproc.c	2006-01-13 13:42:14.000000000 +1100
@@ -36,6 +36,22 @@ nfsd_proc_null(struct svc_rqst *rqstp, v
 	return nfs_ok;
 }
 
+static int
+nfsd_return_attrs(int err, struct nfsd_attrstat *resp)
+{
+	if (err) return err;
+	return nfserrno(vfs_getattr(resp->fh.fh_export->ex_mnt,
+				    resp->fh.fh_dentry,
+				    &resp->stat));
+}
+static int
+nfsd_return_dirop(int err, struct nfsd_diropres *resp)
+{
+	if (err) return err;
+	return nfserrno(vfs_getattr(resp->fh.fh_export->ex_mnt,
+				    resp->fh.fh_dentry,
+				    &resp->stat));
+}
 /*
  * Get a file's attributes
  * N.B. After this call resp->fh needs an fh_put
@@ -44,10 +60,12 @@ static int
 nfsd_proc_getattr(struct svc_rqst *rqstp, struct nfsd_fhandle  *argp,
 					  struct nfsd_attrstat *resp)
 {
+	int nfserr;
 	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	return fh_verify(rqstp, &resp->fh, 0, MAY_NOP);
+	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_NOP);
+	return nfsd_return_attrs(nfserr, resp);
 }
 
 /*
@@ -58,12 +76,14 @@ static int
 nfsd_proc_setattr(struct svc_rqst *rqstp, struct nfsd_sattrargs *argp,
 					  struct nfsd_attrstat  *resp)
 {
+	int nfserr;
 	dprintk("nfsd: SETATTR  %s, valid=%x, size=%ld\n",
 		SVCFH_fmt(&argp->fh),
 		argp->attrs.ia_valid, (long) argp->attrs.ia_size);
 
 	fh_copy(&resp->fh, &argp->fh);
-	return nfsd_setattr(rqstp, &resp->fh, &argp->attrs,0, (time_t)0);
+	nfserr = nfsd_setattr(rqstp, &resp->fh, &argp->attrs,0, (time_t)0);
+	return nfsd_return_attrs(nfserr, resp);
 }
 
 /*
@@ -86,7 +106,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp,
 				 &resp->fh);
 
 	fh_put(&argp->fh);
-	return nfserr;
+	return nfsd_return_dirop(nfserr, resp);
 }
 
 /*
@@ -142,7 +162,10 @@ nfsd_proc_read(struct svc_rqst *rqstp, s
 			   	  argp->vec, argp->vlen,
 				  &resp->count);
 
-	return nfserr;
+	if (nfserr) return nfserr;
+	return nfserrno(vfs_getattr(resp->fh.fh_export->ex_mnt,
+				    resp->fh.fh_dentry,
+				    &resp->stat));
 }
 
 /*
@@ -165,7 +188,7 @@ nfsd_proc_write(struct svc_rqst *rqstp, 
 				   argp->vec, argp->vlen,
 				   argp->len,
 				   &stable);
-	return nfserr;
+	return nfsd_return_attrs(nfserr, resp);
 }
 
 /*
@@ -322,7 +345,7 @@ out_unlock:
 
 done:
 	fh_put(dirfhp);
-	return nfserr;
+	return nfsd_return_dirop(nfserr, resp);
 }
 
 static int
@@ -425,7 +448,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp, 
 	nfserr = nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
 				    &argp->attrs, S_IFDIR, 0, &resp->fh);
 	fh_put(&argp->fh);
-	return nfserr;
+	return nfsd_return_dirop(nfserr, resp);
 }
 
 /*
