Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264216AbTCXNi2>; Mon, 24 Mar 2003 08:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264220AbTCXNi2>; Mon, 24 Mar 2003 08:38:28 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:63371 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP
	id <S264216AbTCXNiZ>; Mon, 24 Mar 2003 08:38:25 -0500
Date: Mon, 24 Mar 2003 13:49:27 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: struct nfs_fattr alignment problem in nfs3proc.c
Message-ID: <20030324134927.GC17163@malvern.uk.w2k.superh.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030321175206.GA17163@malvern.uk.w2k.superh.com> <shs7karzmwv.fsf@charged.uio.no> <20030324120923.GB17163@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324120923.GB17163@malvern.uk.w2k.superh.com>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19 i686
X-OriginalArrivalTime: 24 Mar 2003 13:49:32.0754 (UTC) FILETIME=[32EA4B20:01C2F20C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Richard Curnow <Richard.Curnow@superh.com> [2003-03-24]:
> +	struct unlinkxdr {
> +		struct nfs3_diropargs	*arg;
> +		struct nfs_fattr	*res;
> +	} *ptr;

Sorry, those asterisks are not good.  Instead:

--- ../linux-2.4/fs/nfs/nfs3proc.c	Fri Jan  3 15:01:17 2003
+++ fs/nfs/nfs3proc.c	Mon Mar 24 13:06:36 2003
@@ -294,25 +294,36 @@
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
+		struct nfs3_diropargs	arg;
+		struct nfs_fattr	res;
+	} *ptr;
 
-	arg = (struct nfs3_diropargs *)kmalloc(sizeof(*arg)+sizeof(*res), GFP_KERNEL);
-	if (!arg)
+	ptr = (struct unlinkxdr *) kmalloc(sizeof(struct unlinkxdr), GFP_KERNEL);
+	if (!ptr)
 		return -ENOMEM;
-	res = (struct nfs_fattr*)(arg + 1);
+	arg = &ptr->arg;
+	res = &ptr->res;
+	if (((unsigned long) arg & 0x7) != 0) {
+		printk("nfs3_proc_unlink_setup : arg not 8-byte aligned!\n");
+	}
+	if (((unsigned long) res & 0x7) != 0) {
+		printk("nfs3_proc_unlink_setup : res not 8-byte aligned!\n");
+	}
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
Speaking for myself, not on behalf of SuperH
