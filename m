Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319313AbSHNVPc>; Wed, 14 Aug 2002 17:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319309AbSHNUrZ>; Wed, 14 Aug 2002 16:47:25 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:26839 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319322AbSHNUq7>; Wed, 14 Aug 2002 16:46:59 -0400
Date: Wed, 14 Aug 2002 16:50:48 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 29/38: SERVER: overflow check in nfsd_commit()
Message-ID: <Pine.SOL.4.44.0208141650130.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sanity check COMMIT arguments by ensuring that (start)+(length) < 2^64.
The check is done in a way which is free of signedness pathologies in
all cases.

This change was inspired by pynfs, Peter Astrand's regression testsuite
for NFSv4 servers.  The change is necessary for all of the COMMIT tests
to pass.  However, it's a little open to debate whether the change is
really needed.  I'm curious to hear the opinions of other developers.


--- old/fs/nfsd/vfs.c	Sun Aug 11 22:53:39 2002
+++ new/fs/nfsd/vfs.c	Sun Aug 11 23:07:56 2002
@@ -756,6 +756,9 @@ nfsd_commit(struct svc_rqst *rqstp, stru
 	struct file	file;
 	int		err;

+	if ((u64)count > ~(u64)offset)
+		return nfserr_inval;
+
 	if ((err = nfsd_open(rqstp, fhp, S_IFREG, MAY_WRITE, &file)) != 0)
 		return err;
 	if (EX_ISSYNC(fhp->fh_export)) {

