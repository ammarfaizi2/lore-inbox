Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbSJPX0x>; Wed, 16 Oct 2002 19:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbSJPX0x>; Wed, 16 Oct 2002 19:26:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:39105 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261526AbSJPX0a>; Wed, 16 Oct 2002 19:26:30 -0400
Date: Thu, 17 Oct 2002 00:33:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Rasmus Andersen <rasmus@jaquet.dk>, Dave Hansen <haveblue@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: (2.5.43mm1) Unable to handle kernel paging request
In-Reply-To: <3DADCEFC.7C17B1CC@digeo.com>
Message-ID: <Pine.LNX.4.44.0210170028360.1466-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Andrew Morton wrote:
> Rasmus Andersen wrote:
> > 
> > Booting 2.5.43mm1, I get the following oops:
> > 
> > Unable to handle kernel paging request at virtual address 00002004
> >  printing eip:
> > c01a1ddd
> > *pde = 00000000
> > Oops: 0002
> > 3c59x ide-scsi ide-cd rtc
> > CPU:    0
> > EIP:    0060:[<c01a1ddd>]    Not tainted
> > EFLAGS: 00010246
> > EIP is at nfs_proc_fsinfo+0x6d/0x110
> 
> Does it happen on 2.5.43?

Isn't this covered by Trond's patch below:

> Date: Wed, 16 Oct 2002 15:18:32 +0200
> From: Trond Myklebust <trond.myklebust@fys.uio.no>
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
>      NFS maillist <nfs@lists.sourceforge.net>
> Subject: [PATCH] Fix NFS typos in 2.5.43...
> 
> The following patch fixes 2 obvious typos. Thanks to davem and George
> Anzinger for pointing them out.
> 
> Cheers,
>   Trond

diff -u --recursive --new-file linux-2.5.43/fs/nfs/inode.c linux-2.5.43-fixes/fs/nfs/inode.c
--- linux-2.5.43/fs/nfs/inode.c	2002-10-14 12:43:11.000000000 -0400
+++ linux-2.5.43-fixes/fs/nfs/inode.c	2002-10-16 08:44:04.000000000 -0400
@@ -1355,7 +1355,7 @@
 	if (data->auth_flavourlen != 0) {
 		if (data->auth_flavourlen > 1)
 			printk(KERN_INFO "NFS: cannot yet deal with multiple auth flavours.\n");
-		if (copy_from_user(authflavour, data->auth_flavours, sizeof(authflavour))) {
+		if (copy_from_user(&authflavour, data->auth_flavours, sizeof(authflavour))) {
 			err = -EFAULT;
 			goto out_fail;
 		}
diff -u --recursive --new-file linux-2.5.43/fs/nfs/proc.c linux-2.5.43-fixes/fs/nfs/proc.c
--- linux-2.5.43/fs/nfs/proc.c	2002-10-12 19:33:34.000000000 -0400
+++ linux-2.5.43-fixes/fs/nfs/proc.c	2002-10-16 08:44:29.000000000 -0400
@@ -490,7 +490,7 @@
 
 	dprintk("NFS call  fsinfo\n");
 	info->fattr->valid = 0;
-	status = rpc_call(server->client, NFSPROC_STATFS, fhandle, &info, 0);
+	status = rpc_call(server->client, NFSPROC_STATFS, fhandle, &fsinfo, 0);
 	dprintk("NFS reply fsinfo: %d\n", status);
 	if (status)
 		goto out;

