Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751997AbWJJDKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbWJJDKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWJJDKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:10:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43680 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751997AbWJJDKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:10:41 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/25] bug: nfsd/nfs4xdr.c misuse of ERR_PTR()
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX80u-00049f-TT@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:10:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	a) ERR_PTR(nfserr_something) is a bad idea;
IS_ERR() will be false for it.
	b) mixing nfserr_.... with -EOPNOTSUPP is
even worse idea.

nfsd4_path() does both; caller expects to get NFS protocol error
out it if anything goes wrong, but if it does we either do not
notice (see (a)) or get host-endian negative (see (b)).

IOW, that's a case when we can't use ERR_PTR() to return
error, even though we return a pointer in case of success.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfs4xdr.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 41fc241..77be0c4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1292,16 +1292,15 @@ static int nfsd4_encode_fs_location4(str
  * Returned string is safe to use as long as the caller holds a reference
  * to @exp.
  */
-static char *nfsd4_path(struct svc_rqst *rqstp, struct svc_export *exp)
+static char *nfsd4_path(struct svc_rqst *rqstp, struct svc_export *exp, u32 *stat)
 {
 	struct svc_fh tmp_fh;
 	char *path, *rootpath;
-	int stat;
 
 	fh_init(&tmp_fh, NFS4_FHSIZE);
-	stat = exp_pseudoroot(rqstp->rq_client, &tmp_fh, &rqstp->rq_chandle);
-	if (stat)
-		return ERR_PTR(stat);
+	*stat = exp_pseudoroot(rqstp->rq_client, &tmp_fh, &rqstp->rq_chandle);
+	if (*stat)
+		return NULL;
 	rootpath = tmp_fh.fh_export->ex_path;
 
 	path = exp->ex_path;
@@ -1309,7 +1308,8 @@ static char *nfsd4_path(struct svc_rqst 
 	if (strncmp(path, rootpath, strlen(rootpath))) {
 		printk("nfsd: fs_locations failed;"
 			"%s is not contained in %s\n", path, rootpath);
-		return ERR_PTR(-EOPNOTSUPP);
+		*stat = nfserr_notsupp;
+		return NULL;
 	}
 
 	return path + strlen(rootpath);
@@ -1322,13 +1322,14 @@ static int nfsd4_encode_fs_locations(str
 				     struct svc_export *exp,
 				     u32 **pp, int *buflen)
 {
-	int status, i;
+	u32 status;
+	int i;
 	u32 *p = *pp;
 	struct nfsd4_fs_locations *fslocs = &exp->ex_fslocs;
-	char *root = nfsd4_path(rqstp, exp);
+	char *root = nfsd4_path(rqstp, exp, &status);
 
-	if (IS_ERR(root))
-		return PTR_ERR(root);
+	if (status)
+		return status;
 	status = nfsd4_encode_components('/', root, &p, buflen);
 	if (status)
 		return status;
-- 
1.4.2.GIT


