Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319158AbSHMXJZ>; Tue, 13 Aug 2002 19:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319150AbSHMXIQ>; Tue, 13 Aug 2002 19:08:16 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:12285 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319097AbSHMXHa>; Tue, 13 Aug 2002 19:07:30 -0400
Date: Tue, 13 Aug 2002 19:11:18 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 34/38: SERVER: tweak nfsd_readdir() for NFSv4
Message-ID: <Pine.SOL.4.44.0208131910550.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes three small changes to nfsd_readdir().

First, the 'filldir' routine for NFSv4 may return an arbitrary error,
which should become the return value for nfsd_readdir().  I implemented
this by adding an 'nfserr' field to the 'struct readdir_cd'.

Second, in NFSv4 the caller of nfsd_readdir() will specify an attribute
bitmap, which must be communicated to the 'filldir' routine.  I implemented
this by adding a @bitmap parameter to nfsd_readdir() and a corresponding
field in the 'struct readdir_cd'.  (The bitmap is not interpreted in any
way by nfsd_readdir().)

Finally, NFSv4 defines a new error nfserr_readdir_nospc, which indicates
that there was not enough buffer space to encode a single entry.

--- old/include/linux/nfsd/nfsd.h	Fri Aug  9 10:13:11 2002
+++ new/include/linux/nfsd/nfsd.h	Fri Aug  9 09:57:45 2002
@@ -55,6 +56,8 @@ struct readdir_cd {
 	char			plus;		/* readdirplus */
 	char			eob;		/* end of buffer */
 	char			dotonly;
+	int			nfserr;		/* v4 only */
+	u32			bmval[2];	/* v4 only */
 };
 typedef int		(*encode_dent_fn)(struct readdir_cd *, const char *,
 						int, loff_t, ino_t, unsigned int);
@@ -119,7 +125,8 @@ int		nfsd_truncate(struct svc_rqst *, st
 				unsigned long size);
 int		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 				loff_t, encode_dent_fn,
-				u32 *buffer, int *countp, u32 *verf);
+				u32 *buffer, int *countp, u32 *verf,
+				u32 *bmval);
 int		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct statfs *);

--- old/fs/nfsd/vfs.c	Fri Aug  9 10:13:11 2002
+++ new/fs/nfsd/vfs.c	Fri Aug  9 09:32:36 2002
@@ -1381,7 +1381,7 @@ out_nfserr:
  */
 int
 nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-             encode_dent_fn func, u32 *buffer, int *countp, u32 *verf)
+             encode_dent_fn func, u32 *buffer, int *countp, u32 *verf, u32 *bmval)
 {
 	u32		*p;
 	int		oldlen, eof, err;
@@ -1402,6 +1402,10 @@ nfsd_readdir(struct svc_rqst *rqstp, str
 	cd.buffer = buffer;
 	cd.buflen = *countp; /* count of words */
 	cd.dirfh  = fhp;
+	if (bmval) {
+		cd.bmval[0] = bmval[0];
+		cd.bmval[1] = bmval[1];
+	}

 	/*
 	 * Read the directory entries. This silly loop is necessary because
@@ -1417,8 +1421,15 @@ nfsd_readdir(struct svc_rqst *rqstp, str
 		if (err < 0)
 			goto out_nfserr;

+		err = cd.nfserr;
+		if (err)
+			goto out_close;
 	} while (oldlen != cd.buflen && !cd.eob);

+	err = nfserr_readdir_nospc;
+	if (rqstp->rq_vers == 4 && cd.eob && cd.buffer == buffer)
+		goto out_close;
+
 	/* If we didn't fill the buffer completely, we're at EOF */
 	eof = !cd.eob;

--- old/fs/nfsd/nfsproc.c	Wed Jul 24 16:03:24 2002
+++ new/fs/nfsd/nfsproc.c	Mon Jul 29 11:50:09 2002
@@ -492,7 +492,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp
 	/* Read directory and encode entries on the fly */
 	nfserr = nfsd_readdir(rqstp, &argp->fh, (loff_t) argp->cookie,
 			      nfssvc_encode_entry,
-			      buffer, &count, NULL);
+			      buffer, &count, NULL, NULL);
 	resp->count = count;

 	fh_put(&argp->fh);
--- old/fs/nfsd/nfs3proc.c	Fri Aug  9 10:13:11 2002
+++ new/fs/nfsd/nfs3proc.c	Wed Aug  7 11:58:49 2002
@@ -460,7 +460,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqst
 	fh_copy(&resp->fh, &argp->fh);
 	nfserr = nfsd_readdir(rqstp, &resp->fh, (loff_t) argp->cookie,
 					nfs3svc_encode_entry,
-					buffer, &count, argp->verf);
+					buffer, &count, argp->verf, NULL);
 	memcpy(resp->verf, argp->verf, 8);
 	resp->count = count;

@@ -495,7 +495,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *
 	fh_copy(&resp->fh, &argp->fh);
 	nfserr = nfsd_readdir(rqstp, &resp->fh, (loff_t) argp->cookie,
 					nfs3svc_encode_entry_plus,
-					buffer, &count, argp->verf);
+					buffer, &count, argp->verf, NULL);
 	memcpy(resp->verf, argp->verf, 8);
 	resp->count = count;


