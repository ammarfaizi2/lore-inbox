Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTCURlL>; Fri, 21 Mar 2003 12:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbTCURlL>; Fri, 21 Mar 2003 12:41:11 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:42123 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP
	id <S261857AbTCURlJ>; Fri, 21 Mar 2003 12:41:09 -0500
Date: Fri, 21 Mar 2003 17:52:06 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: struct nfs_fattr alignment problem in nfs3proc.c
Message-ID: <20030321175206.GA17163@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19 i686
X-OriginalArrivalTime: 21 Mar 2003 17:52:11.0320 (UTC) FILETIME=[9941EB80:01C2EFD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the nfs3_proc_unlink_setup function, there appears to be a bug with
the way kmalloc is used to allocate storage for two structs grouped
together.  The second struct ends up with a non 8-byte aligned pointer,
which can cause trouble later (in xdr_decode_fattr) when stores occur to
the u64 fields inside it.  The following patch (on 2.4.19) fixes this
problem, though I'm not sure if it's the cleanest fix.  (I hit this when
working on the port to SH-5, which is currently baselined on 2.4.19).

--- ../linux-2.4/fs/nfs/nfs3proc.c	Fri Jan  3 15:01:17 2003
+++ fs/nfs/nfs3proc.c	Fri Mar 21 17:42:38 2003
@@ -294,25 +294,28 @@
 	nfs_refresh_inode(dir, &dir_attr);
 	dprintk("NFS reply remove: %d\n", status);
 	return status;
 }
 
 static int
 nfs3_proc_unlink_setup(struct rpc_message *msg, struct dentry *dir, struct qstr *name)
 {
 	struct nfs3_diropargs	*arg;
 	struct nfs_fattr	*res;
+	int arg_size_8, res_size_8;
 
-	arg = (struct nfs3_diropargs *)kmalloc(sizeof(*arg)+sizeof(*res), GFP_KERNEL);
+	arg_size_8 = (sizeof(*arg) + 7) & ~7;
+	res_size_8 = (sizeof(*res) + 7) & ~7;
+	arg = (struct nfs3_diropargs *)kmalloc(arg_size_8 + res_size_8, GFP_KERNEL);
 	if (!arg)
 		return -ENOMEM;
-	res = (struct nfs_fattr*)(arg + 1);
+	res = (struct nfs_fattr*)((char *)arg + arg_size_8);
 	arg->fh = NFS_FH(dir->d_inode);
 	arg->name = name->name;
 	arg->len = name->len;
 	res->valid = 0;
 	msg->rpc_proc = NFS3PROC_REMOVE;
 	msg->rpc_argp = arg;
 	msg->rpc_resp = res;
 	return 0;
 }
 

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
