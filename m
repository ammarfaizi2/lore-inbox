Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264165AbTCXL6X>; Mon, 24 Mar 2003 06:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264166AbTCXL6X>; Mon, 24 Mar 2003 06:58:23 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:60811 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP
	id <S264165AbTCXL6V>; Mon, 24 Mar 2003 06:58:21 -0500
Date: Mon, 24 Mar 2003 12:09:23 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: struct nfs_fattr alignment problem in nfs3proc.c
Message-ID: <20030324120923.GB17163@malvern.uk.w2k.superh.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030321175206.GA17163@malvern.uk.w2k.superh.com> <shs7karzmwv.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs7karzmwv.fsf@charged.uio.no>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19 i686
X-OriginalArrivalTime: 24 Mar 2003 12:09:29.0027 (UTC) FILETIME=[386A4130:01C2F1FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust <trond.myklebust@fys.uio.no> [2003-03-22]:
> Why not just define
> 
> struct {
>         struct nfs3_diropargs   arg;
>         struct nfs_fattr        res;
> } unlinkxdr;
> 
> and then kmalloc that?
> 

Yes, that's much better, since it also avoids bloating the allocation on
architectures that only need 4-byte alignment for later stores into the
result structures to work, plus it's more future-proof.  Here's the
revised patch.

--- ../linux-2.4/fs/nfs/nfs3proc.c	Fri Jan  3 15:01:17 2003
+++ fs/nfs/nfs3proc.c	Mon Mar 24 09:39:21 2003
@@ -294,25 +294,30 @@
 	nfs_refresh_inode(dir, &dir_attr);
 	dprintk("NFS reply remove: %d\n", status);
 	return status;
 }
 
 static int
 nfs3_proc_unlink_setup(struct rpc_message *msg, struct dentry *dir, struct qstr *name)
 {
 	struct nfs3_diropargs	*arg;
 	struct nfs_fattr	*res;
+	struct unlinkxdr {
+		struct nfs3_diropargs	*arg;
+		struct nfs_fattr	*res;
+	} *ptr;
 
-	arg = (struct nfs3_diropargs *)kmalloc(sizeof(*arg)+sizeof(*res), GFP_KERNEL);
-	if (!arg)
+	ptr = (struct unlinkxdr *) kmalloc(sizeof(struct unlinkxdr), GFP_KERNEL);
+	if (!ptr)
 		return -ENOMEM;
-	res = (struct nfs_fattr*)(arg + 1);
+	arg = &ptr->arg;
+	res = &ptr->res;
 	arg->fh = NFS_FH(dir->d_inode);
 	arg->name = name->name;
 	arg->len = name->len;
 	res->valid = 0;
 	msg->rpc_proc = NFS3PROC_REMOVE;
 	msg->rpc_argp = arg;
 	msg->rpc_resp = res;
 	return 0;
 }
 

Cheers
Richard

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
Speaking for myself, not on behalf of SuperH
