Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTKNXza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 18:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTKNXz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 18:55:29 -0500
Received: from aneto.able.es ([212.97.163.22]:19163 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261152AbTKNXzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 18:55:25 -0500
Date: Sat, 15 Nov 2003 00:55:23 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Greg Louis <glouis@dynamicro.on.ca>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre8-pac1 and -rc1-pac1 NFSv3 problem
Message-ID: <20031114235523.GC12679@werewolf.able.es>
References: <20031111182647.GA25026@athame.dynamicro.on.ca> <20031111190000.GA25290@athame.dynamicro.on.ca> <20031114234627.GA12679@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031114234627.GA12679@werewolf.able.es> (from jamagallon@able.es on Sat, Nov 15, 2003 at 00:46:27 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.15, J.A. Magallon wrote:
> 
> On 11.11, Greg Louis wrote:
> > On 20031111 (Tue) at 1326:47 -0500, Greg Louis wrote:
> > > Kernels 2.4.23-pre7-pac1 and 2.4.23-rc1 are ok but -pre8-pac1 and
> > > -rc1-pac1 behave as follows: mounting a remote directory via NFS with
> > > v3 enabled (client and server) seems to work ok, and running mount with
> > > no parameters shows the NFS mount, but any attempt at access fails with
> > > a message like
> > >   /bin/ls: reading directory /whatever/it/was: Input/output error
> > 
> > Reverting all changes to fs/nfs/* since 2.4.23-pre7-pac1, and only
> > those, corrects the problem.
> > 
> 
> /metoo
> 
> annwn:~> bpsh 0 mount   
> none on /proc type proc (rw)
> none on /dev/pts type devpts (rw,mode=0620)
> none on /dev/shm type tmpfs (rw)
> none on /tmp type tmpfs (rw)
> 192.168.0.1:/lib on /lib type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
> 192.168.0.1:/bin on /bin type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
> 192.168.0.1:/sbin on /sbin type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
> 192.168.0.1:/usr on /usr type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
> 192.168.0.1:/opt on /opt type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
> 192.168.0.1:/home on /home type nfs (rw,nfsvers=3,noac,addr=192.168.0.1)
> 192.168.0.1:/work on /work/shared type nfs (rw,nfsvers=3,noac,addr=192.168.0.1)
> 
> annwn:~> bpsh 0 pwd
> /home/magallon
> 
> annwn:~> bpsh 0 ls
> ls: reading directory .: Invalid argument
> 
> It works for some time, and then it breaks.
> Could you send me the patch you used to revert those changes ?
> I will try to make a diff from rc1 to pre7 and reverse.

Just this (pre7 -> pre8|rc1):

diff -ruN linux-2.4.23-pre7/fs/nfs/nfs3proc.c linux-2.4.23-rc1/fs/nfs/nfs3proc.c
--- linux-2.4.23-pre7/fs/nfs/nfs3proc.c	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.23-rc1/fs/nfs/nfs3proc.c	2003-11-12 11:07:48.000000000 +0100
@@ -433,8 +433,6 @@
  * The decode function itself doesn't perform any decoding, it just makes
  * sure the reply is syntactically correct.
  *
- * Also note that this implementation handles both plain readdir and
- * readdirplus.
  */
 static int
 nfs3_proc_readdir(struct inode *dir, struct rpc_cred *cred,
@@ -448,11 +446,7 @@
 	struct rpc_message	msg = { NFS3PROC_READDIR, &arg, &res, cred };
 	int			status;
 
-	if (plus)
-		msg.rpc_proc = NFS3PROC_READDIRPLUS;
-
-	dprintk("NFS call  readdir%s %d\n",
-			plus? "plus" : "", (unsigned int) cookie);
+	dprintk("NFS call  readdir %d\n", (unsigned int) cookie);
 
 	dir_attr.valid = 0;
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
diff -ruN linux-2.4.23-pre7/fs/nfs/nfs3xdr.c linux-2.4.23-rc1/fs/nfs/nfs3xdr.c
--- linux-2.4.23-pre7/fs/nfs/nfs3xdr.c	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.23-rc1/fs/nfs/nfs3xdr.c	2003-11-12 11:07:48.000000000 +0100
@@ -599,8 +599,6 @@
 u32 *
 nfs3_decode_dirent(u32 *p, struct nfs_entry *entry, int plus)
 {
-	struct nfs_entry old = *entry;
-
 	if (!*p++) {
 		if (!*p)
 			return ERR_PTR(-EAGAIN);
@@ -616,20 +614,12 @@
 	p = xdr_decode_hyper(p, &entry->cookie);
 
 	if (plus) {
-		p = xdr_decode_post_op_attr(p, &entry->fattr);
+		struct nfs_fattr fattr;
+		p = xdr_decode_post_op_attr(p, &fattr);
 		/* In fact, a post_op_fh3: */
 		if (*p++) {
-			p = xdr_decode_fhandle(p, &entry->fh);
-			/* Ugh -- server reply was truncated */
-			if (p == NULL) {
-				dprintk("NFS: FH truncated\n");
-				*entry = old;
-				return ERR_PTR(-EAGAIN);
-			}
-		} else {
-			/* If we don't get a file handle, the attrs
-			 * aren't worth a lot. */
-			entry->fattr.valid = 0;
+			struct nfs_fh fh;
+			p = xdr_decode_fhandle(p, &fh);
 		}
 	}
 
diff -ruN linux-2.4.23-pre7/fs/nfs/write.c linux-2.4.23-rc1/fs/nfs/write.c
--- linux-2.4.23-pre7/fs/nfs/write.c	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.23-rc1/fs/nfs/write.c	2003-11-12 11:07:48.000000000 +0100
@@ -225,8 +225,19 @@
 	struct inode *inode = page->mapping->host;
 	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
+	int inode_referenced = 0;
 	int err;
 
+	/*
+	 * Note: We need to ensure that we have a reference to the inode
+	 *       if we are to do asynchronous writes. If not, waiting
+	 *       in nfs_wait_on_request() may deadlock with clear_inode().
+	 *
+	 *       If igrab() fails here, then it is in any case safe to
+	 *       call nfs_wb_page(), since there will be no pending writes.
+	 */
+	if (igrab(inode) != 0)
+		inode_referenced = 1;
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 
 	/* Ensure we've flushed out any previous writes */
@@ -244,7 +255,8 @@
 		goto out;
 do_it:
 	lock_kernel();
-	if (NFS_SERVER(inode)->wsize >= PAGE_CACHE_SIZE && !IS_SYNC(inode)) {
+	if (NFS_SERVER(inode)->wsize >= PAGE_CACHE_SIZE && !IS_SYNC(inode) &&
+			inode_referenced) {
 		err = nfs_writepage_async(NULL, inode, page, 0, offset);
 		if (err >= 0)
 			err = 0;
@@ -256,7 +268,9 @@
 	unlock_kernel();
 out:
 	UnlockPage(page);
-	return err; 
+	if (inode_referenced)
+		iput(inode);
+	return err;
 }
 
 /*

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-rc1-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
