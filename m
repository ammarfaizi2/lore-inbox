Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUEaWEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUEaWEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbUEaWEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:04:31 -0400
Received: from av9-2-sn1.fre.skanova.net ([81.228.11.116]:29647 "EHLO
	av9-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S264808AbUEaWER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:04:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no
Subject: Re: Linux 2.6.7-rc2
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
	<m3y8n93qak.fsf@telia.com>
	<Pine.LNX.4.58.0405310955420.4573@ppc970.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Jun 2004 00:04:14 +0200
In-Reply-To: <Pine.LNX.4.58.0405310955420.4573@ppc970.osdl.org>
Message-ID: <m34qpw5k4h.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 31 May 2004, Peter Osterlund wrote:
> > 
> > If I put "#if 0" around the *wdata assignment in nfs_writepage_sync,
> > the stack usage goes down to 36, so it looks like gcc is building a
> > temporary structure on the stack and then copies the whole thing to
> > *wdata.
> 
> Yeah, that's silly. But understandable. A lot of problems go away by doing 
> a temporary private node..
> 
> > Does this construct save stack space for any version of gcc? Maybe the
> > code should be changed to do a memset() followed by explicit
> > initialization of the non-zero member variables instead.
> 
> In this case, I'd agree.
> 
> In some other cases, it's better to create a initialized static variable, 
> and just use that as an initial initializer. In this case that doesn't 
> much help, since none of the fields are constant.

Here is a patch that does this. I've verified that it compiles and
that it fixes the excessive stack problem, but I failed to come up
with a test case that exercises these code paths.


--- linux/fs/nfs/read.c.orig	2004-05-31 23:34:15.890307512 +0200
+++ linux/fs/nfs/read.c	2004-05-31 23:29:26.077365776 +0200
@@ -103,22 +103,16 @@
 	if (!rdata)
 		return -ENOMEM;
 
-	*rdata = (struct nfs_read_data) {
-		.flags		= (IS_SWAPFILE(inode)? NFS_RPC_SWAPFLAGS : 0),
-		.cred		= NULL,
-		.inode		= inode,
-		.pages		= LIST_HEAD_INIT(rdata->pages),
-		.args		= {
-			.fh		= NFS_FH(inode),
-			.lockowner	= current->files,
-			.pages		= &page,
-			.pgbase		= 0UL,
-			.count		= rsize,
-		},
-		.res		= {
-			.fattr		= &rdata->fattr,
-		}
-	};
+	memset(rdata, 0, sizeof(*rdata));
+	rdata->flags = (IS_SWAPFILE(inode)? NFS_RPC_SWAPFLAGS : 0);
+	rdata->inode = inode;
+	INIT_LIST_HEAD(&rdata->pages);
+	rdata->args.fh = NFS_FH(inode);
+	rdata->args.lockowner = current->files;
+	rdata->args.pages = &page;
+	rdata->args.pgbase = 0UL;
+	rdata->args.count = rsize;
+	rdata->res.fattr = &rdata->fattr;
 
 	dprintk("NFS: nfs_readpage_sync(%p)\n", page);
 
--- linux/fs/nfs/write.c.orig	2004-05-31 23:34:20.529602232 +0200
+++ linux/fs/nfs/write.c	2004-05-31 23:29:33.165288248 +0200
@@ -185,23 +185,17 @@
 	if (!wdata)
 		return -ENOMEM;
 
-	*wdata = (struct nfs_write_data) {
-		.flags		= how,
-		.cred		= NULL,
-		.inode		= inode,
-		.args		= {
-			.fh		= NFS_FH(inode),
-			.lockowner	= current->files,
-			.pages		= &page,
-			.stable		= NFS_FILE_SYNC,
-			.pgbase		= offset,
-			.count		= wsize,
-		},
-		.res		= {
-			.fattr		= &wdata->fattr,
-			.verf		= &wdata->verf,
-		},
-	};
+	memset(wdata, 0, sizeof(*wdata));
+	wdata->flags = how;
+	wdata->inode = inode;
+	wdata->args.fh = NFS_FH(inode);
+	wdata->args.lockowner = current->files;
+	wdata->args.pages = &page;
+	wdata->args.stable = NFS_FILE_SYNC;
+	wdata->args.pgbase = offset;
+	wdata->args.count = wsize;
+	wdata->res.fattr = &wdata->fattr;
+	wdata->res.verf = &wdata->verf;
 
 	dprintk("NFS:      nfs_writepage_sync(%s/%Ld %d@%Ld)\n",
 		inode->i_sb->s_id,

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
