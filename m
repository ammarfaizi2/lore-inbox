Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319152AbSHMXFs>; Tue, 13 Aug 2002 19:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319106AbSHMXFM>; Tue, 13 Aug 2002 19:05:12 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:25084 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319167AbSHMXCe>; Tue, 13 Aug 2002 19:02:34 -0400
Date: Tue, 13 Aug 2002 19:06:15 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 24/38: SERVER: change ->rq_vers==3 to ->rq_vers>2
Message-ID: <Pine.SOL.4.44.0208131905510.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a few places on the server, I had to change code that looked like:

   if (rqstp->rq_vers == 3)
       /* NFSv3 behavior */
   else
       /* NFSv2 behavior */

to:

   if (rqstp->rq_vers > 2)
       /* NFSv3 behavior */
   else
       /* NFSv2 behavior */

so that we would get the NFSv3 behavior, not the NFSv2 behavior,
in NFSv4.  This patch collects all changes of this type.

--- old/fs/nfsd/nfsfh.c	Tue Jul 30 22:12:36 2002
+++ new/fs/nfsd/nfsfh.c	Mon Jul 29 12:39:43 2002
@@ -107,7 +107,7 @@ fh_verify(struct svc_rqst *rqstp, struct
 		int fsid = 0;

 		error = nfserr_stale;
-		if (rqstp->rq_vers == 3)
+		if (rqstp->rq_vers > 2)
 			error = nfserr_badhandle;

 		if (fh->fh_version == 1) {
@@ -171,7 +171,7 @@ fh_verify(struct svc_rqst *rqstp, struct
 		 * Look up the dentry using the NFS file handle.
 		 */
 		error = nfserr_stale;
-		if (rqstp->rq_vers == 3)
+		if (rqstp->rq_vers > 2)
 			error = nfserr_badhandle;

 		if (fh->fh_version != 1) {
--- old/fs/nfsd/vfs.c	Tue Jul 30 22:12:36 2002
+++ new/fs/nfsd/vfs.c	Mon Jul 29 12:39:43 2002
@@ -1401,7 +1401,7 @@ nfsd_readdir(struct svc_rqst *rqstp, str
 	eof = !cd.eob;

 	if (cd.offset) {
-		if (rqstp->rq_vers == 3)
+		if (rqstp->rq_vers > 2)
 			(void)xdr_encode_hyper(cd.offset, file.f_pos);
 		else
 			*cd.offset = htonl(file.f_pos);

