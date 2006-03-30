Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWC3Fzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWC3Fzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWC3Fzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:55:33 -0500
Received: from ns2.suse.de ([195.135.220.15]:31392 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751086AbWC3Fz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:55:28 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 30 Mar 2006 16:53:50 +1100
Message-Id: <1060330055350.25337@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] knfsd: Correct reserved reply space for read requests.
References: <20060330165307.25307.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Single patch for nfsd in 2.6.16.  As the comment say, it is sensible
for this to sit in -mm for a while just in case.

### Comments for Changeset

NFSd makes sure there is enough space to hold the maximum possible
reply before accepting a request.  The units for this maximum is
(4byte) words.  However in three places, particularly for read
request, the number given is a number of bytes.

This means too much space is reserved which is slightly wasteful.

This is the sort of patch that could uncover a deeper bug, and it is
not critical, so it would be best for it to spend a while in -mm before going in to mainline.

Discovered-by: "Eivind  Sarto" <ivan@kasenna.com>

Cc: "Eivind  Sarto" <ivan@kasenna.com>

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs3proc.c |    2 +-
 ./fs/nfsd/nfs4proc.c |    2 +-
 ./fs/nfsd/nfsproc.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff ./fs/nfsd/nfs3proc.c~current~ ./fs/nfsd/nfs3proc.c
--- ./fs/nfsd/nfs3proc.c~current~	2006-03-30 16:48:30.000000000 +1100
+++ ./fs/nfsd/nfs3proc.c	2006-03-30 16:48:58.000000000 +1100
@@ -682,7 +682,7 @@ static struct svc_procedure		nfsd_proced
   PROC(lookup,	 dirop,		dirop,		fhandle2, RC_NOCACHE, ST+FH+pAT+pAT),
   PROC(access,	 access,	access,		fhandle,  RC_NOCACHE, ST+pAT+1),
   PROC(readlink, readlink,	readlink,	fhandle,  RC_NOCACHE, ST+pAT+1+NFS3_MAXPATHLEN/4),
-  PROC(read,	 read,		read,		fhandle,  RC_NOCACHE, ST+pAT+4+NFSSVC_MAXBLKSIZE),
+  PROC(read,	 read,		read,		fhandle,  RC_NOCACHE, ST+pAT+4+NFSSVC_MAXBLKSIZE/4),
   PROC(write,	 write,		write,		fhandle,  RC_REPLBUFF, ST+WC+4),
   PROC(create,	 create,	create,		fhandle2, RC_REPLBUFF, ST+(1+FH+pAT)+WC),
   PROC(mkdir,	 mkdir,		create,		fhandle2, RC_REPLBUFF, ST+(1+FH+pAT)+WC),

diff ./fs/nfsd/nfs4proc.c~current~ ./fs/nfsd/nfs4proc.c
--- ./fs/nfsd/nfs4proc.c~current~	2006-03-30 16:48:30.000000000 +1100
+++ ./fs/nfsd/nfs4proc.c	2006-03-30 16:48:58.000000000 +1100
@@ -973,7 +973,7 @@ struct nfsd4_voidargs { int dummy; };
  */
 static struct svc_procedure		nfsd_procedures4[2] = {
   PROC(null,	 void,		void,		void,	  RC_NOCACHE, 1),
-  PROC(compound, compound,	compound,	compound, RC_NOCACHE, NFSD_BUFSIZE)
+  PROC(compound, compound,	compound,	compound, RC_NOCACHE, NFSD_BUFSIZE/4)
 };
 
 struct svc_version	nfsd_version4 = {

diff ./fs/nfsd/nfsproc.c~current~ ./fs/nfsd/nfsproc.c
--- ./fs/nfsd/nfsproc.c~current~	2006-03-30 16:48:30.000000000 +1100
+++ ./fs/nfsd/nfsproc.c	2006-03-30 16:48:58.000000000 +1100
@@ -553,7 +553,7 @@ static struct svc_procedure		nfsd_proced
   PROC(none,	 void,		void,		none,		RC_NOCACHE, ST),
   PROC(lookup,	 diropargs,	diropres,	fhandle,	RC_NOCACHE, ST+FH+AT),
   PROC(readlink, readlinkargs,	readlinkres,	none,		RC_NOCACHE, ST+1+NFS_MAXPATHLEN/4),
-  PROC(read,	 readargs,	readres,	fhandle,	RC_NOCACHE, ST+AT+1+NFSSVC_MAXBLKSIZE),
+  PROC(read,	 readargs,	readres,	fhandle,	RC_NOCACHE, ST+AT+1+NFSSVC_MAXBLKSIZE/4),
   PROC(none,	 void,		void,		none,		RC_NOCACHE, ST),
   PROC(write,	 writeargs,	attrstat,	fhandle,	RC_REPLBUFF, ST+AT),
   PROC(create,	 createargs,	diropres,	fhandle,	RC_REPLBUFF, ST+FH+AT),
