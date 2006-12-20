Return-Path: <linux-kernel-owner+w=401wt.eu-S965166AbWLTXqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWLTXqm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWLTXqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:46:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42379 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965166AbWLTXql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:46:41 -0500
Date: Thu, 21 Dec 2006 10:46:02 +1100
From: David Chinner <dgc@sgi.com>
To: "Mr. Berkley Shands" <bshands@exegy.com>
Cc: linux-kernel@vger.kernel.org, Dave Lloyd <dlloyd@exegy.com>,
       xfs@oss.sgi.com
Subject: Re: 2.6.19 xfs crash spawns tcp reclen errors off nfs
Message-ID: <20061220234602.GC44411608@melbourne.sgi.com>
References: <4589A32A.7030802@exegy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4589A32A.7030802@exegy.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 02:55:06PM -0600, Mr. Berkley Shands wrote:
> We have had several really strange NFS issues, reported out of
> net/sunrpc/svcsock.c in
> 
> static int
> svc_tcp_recvfrom(struct svc_rqst *rqstp)
> 
>        svsk->sk_reclen &= 0x7fffffff;
>        dprintk("svc: TCP record, %d bytes\n", svsk->sk_reclen);
>        if (svsk->sk_reclen > serv->sv_bufsz) {
>            printk(KERN_NOTICE "RPC: bad TCP reclen 0x%08lx (large)\n",
>                   (unsigned long) svsk->sk_reclen);
>            printk(KERN_NOTICE "sockaddr_in 0x%04x port 0x%04x max 
> 0x%08lx\n",
>               rqstp->rq_addr.sin_addr.s_addr,
>               rqstp->rq_addr.sin_port, (long) serv->sv_bufsz);
>            goto err_delete;
>        }
> 
> The size reported grows, and grows, and...
> 
> the server runs 2.6.19 when XFS has its issues (as follows)
> 2TB partition, NFS exported. All machines are x86_64 AMD 275's with 16GB
> and running redhat AS 4.4 (Centos 4.4)
> 
> a typical crash under 2.6.19 is
> 
> Dec 14 09:13:48 sanandreas kernel: Filesystem "sdb1": XFS internal error 
> xfs_trans_cancel at line 1138 of file fs/xfs/xfs_trans.c.  Caller 
> 0xffffffff881ceaa8

Hmmmm - that is showing up up a lot more frequently in 2.6.18 and 2.6.19
that we've ever seen before. Kind of strange given we haven't
changed anything the create transaction code for quite some time.

However, a machine named "sanandreas" is bound to go kaboom
at some point in time ;)

> this then causes the heavy write clients to write garbage NFS request that
> grow...

XFS will be returning an EUCLEAN or EIO to indicate the filesystem
has been shut down to all these write calls. Sounds like the clients
aren't handling the errors properly....

> Neil Brown indicated that this NFS packet growth should have been fixed in
> 2.6.18-rc5, but it still happens, easily triggered by the XFS shutdown.
> the packet sizes reported can grow to > 1GB.
> Dropping back to 2.6.18.1 stops the XFS crashing, and hence stops the 
> NFS mess.

Do you have any idea of the workload that is triggering the XFS shutdown?

We need more error reporting traps in the create transaction so we can
track this down. As a first pass to narrowing down which code path
is failing, can you run this quick patch - we should get an extra line
in the kernel output just before the shutdown indicating what the error
was and which branch returned it.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

---
 fs/xfs/xfs_vnodeops.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: 2.6.x-xfs-new/fs/xfs/xfs_vnodeops.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/xfs/xfs_vnodeops.c	2006-12-12 12:05:21.000000000 +1100
+++ 2.6.x-xfs-new/fs/xfs/xfs_vnodeops.c	2006-12-21 10:40:22.341657119 +1100
@@ -1932,6 +1932,7 @@ xfs_create(
 	error = xfs_trans_reserve(tp, resblks, XFS_CREATE_LOG_RES(mp), 0,
 			XFS_TRANS_PERM_LOG_RES, XFS_CREATE_LOG_COUNT);
 	if (error == ENOSPC) {
+		printk(KERN_WARNING "xfs_create: resv at enospc\n");
 		resblks = 0;
 		error = xfs_trans_reserve(tp, 0, XFS_CREATE_LOG_RES(mp), 0,
 				XFS_TRANS_PERM_LOG_RES, XFS_CREATE_LOG_COUNT);
@@ -1962,6 +1963,7 @@ xfs_create(
 			rdev, credp, prid, resblks > 0,
 			&ip, &committed);
 	if (error) {
+		printk(KERN_WARNING "xfs_create: dir_ialloc error %d\n", error);
 		if (error == ENOSPC)
 			goto error_return;
 		goto abort_return;
@@ -1991,6 +1993,7 @@ xfs_create(
 					resblks - XFS_IALLOC_SPACE_RES(mp) : 0);
 	if (error) {
 		ASSERT(error != ENOSPC);
+		printk(KERN_WARNING "xfs_create: dir_createname error %d\n", error);
 		goto abort_return;
 	}
 	xfs_ichgtime(dp, XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
@@ -2025,6 +2028,7 @@ xfs_create(
 	error = xfs_bmap_finish(&tp, &free_list, first_block, &committed);
 	if (error) {
 		xfs_bmap_cancel(&free_list);
+		printk(KERN_WARNING "xfs_create: xfs_bmap_finish error %d\n", error);
 		goto abort_rele;
 	}
 
