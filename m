Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVAGWNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVAGWNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVAGWNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:13:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:40072 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261643AbVAGWJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:09:53 -0500
Subject: Re: [RFC] 2.4 and stack reduction patches
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050107141224.GF29176@logos.cnet>
References: <1105112886.4000.87.camel@dyn318077bld.beaverton.ibm.com>
	 <20050107141224.GF29176@logos.cnet>
Content-Type: multipart/mixed; boundary="=-MZwmiQNVI/SXjQBKlaKu"
Organization: 
Message-Id: <1105134173.4000.105.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2005 13:42:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MZwmiQNVI/SXjQBKlaKu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, 2005-01-07 at 06:12, Marcelo Tosatti wrote:
> On Fri, Jan 07, 2005 at 07:48:06AM -0800, Badari Pulavarty wrote:
> > Hi Marcelo,
> 
> Hi Badari,
> 
> > Few of the product groups are running into stack overflow problems
> > on latest 2.4 distribution releases, especially on z-Series.
> 
> Lets try to minimize the problems.
> 
> > While poking thro the 2.4 code, I realized the 2.6 stack reduction
> > work did not get merged into 2.4. 
> > 
> > Biggest offender seems to be "struct linux_binprm" in do_execve().
> > Converting structure on the stack to malloc() (like 2.6 does)
> > solved majority of problems. There are other places, but savings
> > are smaller. (But after bunch of changes, we were able to reduce
> > stack by 1K).
> 
> I think the bigger offenders should be fixed. I suppose most of these 
> changes are not very intrusive and are acceptable for v2.4.

No. Changes are to malloc() instead of stack structures and fail,
if malloc() fails.

> 
> What are the "other places" that you have fixed? And for how much of 
> "1K savings" they account for? 

Here are the changes and savings.

do_execve                    320
number                       100
nfs_lookup                   184
nfs_cached_lookup             88
__revalidate_inode           112
rpc_call_sync                144
xprt_sendmsg                 120


> 
> > I am wondering, if there is any interest in merging stack reduction
> > patches into 2.4 mainline ? If so, I will rework the patches on
> > latest 2.4 and submit them. 
> 
> Please submit them to LKML for peer view - thanks!

Here is the single crude patch for one of the distro releases.
(may not apply to latest 2.4 mainline). 

Please let me know, if you like these changes - I will make smaller
patches (one for each area) to current 2.4 mainline, test it and 
send it.

Thanks,
Badari





--=-MZwmiQNVI/SXjQBKlaKu
Content-Disposition: attachment; filename=24stack-reduce.patch
Content-Type: text/x-patch; name=24stack-reduce.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ur largestack/fs/exec.c smallstack/fs/exec.c
--- largestack/fs/exec.c	2003-10-03 17:28:49.000000000 -0400
+++ smallstack/fs/exec.c	2004-12-16 10:56:05.000000000 -0500
@@ -1051,7 +1051,7 @@
  */
 int do_execve(char * filename, char ** argv, char ** envp, struct pt_regs * regs)
 {
-	struct linux_binprm bprm;
+	struct linux_binprm *bprmp;
 	struct file *file;
 	int retval;
 	int i;
@@ -1062,61 +1062,70 @@
 	if (IS_ERR(file))
 		return retval;
 
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES*sizeof(bprm.page[0])); 
+	bprmp = kmalloc(sizeof(struct linux_binprm), GFP_KERNEL);
+	if (!bprmp) {
+		retval = -ENOMEM;
+		return retval;
+	}
+	bprmp->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+	memset(bprmp->page, 0, MAX_ARG_PAGES*sizeof(bprmp->page[0])); 
 
-	bprm.file = file;
-	bprm.filename = filename;
-	bprm.interp = filename;
-	bprm.sh_bang = 0;
-	bprm.loader = 0;
-	bprm.exec = 0;
-	if ((bprm.argc = count(argv, bprm.p / sizeof(void *))) < 0) {
+	bprmp->file = file;
+	bprmp->filename = filename;
+	bprmp->interp = filename;
+	bprmp->sh_bang = 0;
+	bprmp->loader = 0;
+	bprmp->exec = 0;
+	if ((bprmp->argc = count(argv, bprmp->p / sizeof(void *))) < 0) {
 		allow_write_access(file);
 		fput(file);
-		return bprm.argc;
+		retval = bprmp->argc;
+		goto free_bprm;
 	}
 
-	if ((bprm.envc = count(envp, bprm.p / sizeof(void *))) < 0) {
+	if ((bprmp->envc = count(envp, bprmp->p / sizeof(void *))) < 0) {
 		allow_write_access(file);
 		fput(file);
-		return bprm.envc;
+		retval = bprmp->envc;
+		goto free_bprm;
 	}
 
-	retval = prepare_binprm(&bprm);
+	retval = prepare_binprm(bprmp);
 	if (retval < 0) 
 		goto out; 
 
-	retval = copy_strings_kernel(1, &bprm.filename, &bprm);
+	retval = copy_strings_kernel(1, &bprmp->filename, bprmp);
 	if (retval < 0) 
 		goto out; 
 
-	bprm.exec = bprm.p;
-	retval = copy_strings(bprm.envc, envp, &bprm);
+	bprmp->exec = bprmp->p;
+	retval = copy_strings(bprmp->envc, envp, bprmp);
 	if (retval < 0) 
 		goto out; 
 
-	retval = copy_strings(bprm.argc, argv, &bprm);
+	retval = copy_strings(bprmp->argc, argv, bprmp);
 	if (retval < 0) 
 		goto out; 
 
-	retval = search_binary_handler(&bprm,regs);
+	retval = search_binary_handler(bprmp,regs);
 	if (retval >= 0)
 		/* execve success */
-		return retval;
+		goto free_bprm;
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	allow_write_access(bprm.file);
-	if (bprm.file)
-		fput(bprm.file);
+	allow_write_access(bprmp->file);
+	if (bprmp->file)
+		fput(bprmp->file);
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm.page[i];
+		struct page * page = bprmp->page[i];
 		if (page)
 			__free_page(page);
 	}
 
+free_bprm:
+	kfree(bprmp);
 	return retval;
 }
 
diff -ur largestack/fs/nfs/dir.c smallstack/fs/nfs/dir.c
--- largestack/fs/nfs/dir.c	2003-10-03 17:28:49.000000000 -0400
+++ smallstack/fs/nfs/dir.c	2004-12-16 13:54:47.000000000 -0500
@@ -637,8 +637,8 @@
 {
 	struct inode *inode;
 	int error;
-	struct nfs_fh fhandle;
-	struct nfs_fattr fattr;
+	struct nfs_fh *fhandle;
+	struct nfs_fattr *fattr;
 
 	dfprintk(VFS, "NFS: lookup(%s/%s)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
@@ -648,27 +648,34 @@
 		goto out;
 
 	error = -ENOMEM;
+	fhandle = kmalloc(sizeof(struct nfs_fh), GFP_KERNEL);
+	if (!fhandle)
+		goto out;
+	fattr = kmalloc(sizeof(struct nfs_fattr), GFP_KERNEL);
+	if (!fattr)
+		goto free_fhandle;
+
 	dentry->d_op = &nfs_dentry_operations;
 
-	error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);
+	error = nfs_cached_lookup(dir, dentry, fhandle, fattr);
 	if (!error) {
 		error = -EACCES;
-		inode = nfs_fhget(dentry, &fhandle, &fattr);
+		inode = nfs_fhget(dentry, fhandle, fattr);
 		if (inode) {
 			d_add(dentry, inode);
 			nfs_renew_times(dentry);
 			error = 0;
 		}
-		goto out;
+		goto free_fattr;
 	}
 
-	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
+	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, fhandle, fattr);
 	inode = NULL;
 	if (error == -ENOENT)
 		goto no_entry;
 	if (!error) {
 		error = -EACCES;
-		inode = nfs_fhget(dentry, &fhandle, &fattr);
+		inode = nfs_fhget(dentry, fhandle, fattr);
 		if (inode) {
 	    no_entry:
 			d_add(dentry, inode);
@@ -676,6 +683,10 @@
 		}
 		nfs_renew_times(dentry);
 	}
+free_fattr:
+	kfree(fattr);
+free_fhandle:
+	kfree(fhandle);
 out:
 	return ERR_PTR(error);
 }
@@ -710,9 +721,9 @@
 int nfs_cached_lookup(struct inode *dir, struct dentry *dentry,
 			struct nfs_fh *fh, struct nfs_fattr *fattr)
 {
-	nfs_readdir_descriptor_t desc;
+	nfs_readdir_descriptor_t *desc;
 	struct nfs_server *server;
-	struct nfs_entry entry;
+	struct nfs_entry *entry;
 	struct page *page;
 	unsigned long timestamp = NFS_MTIME_UPDATE(dir);
 	int res;
@@ -722,35 +733,47 @@
 	server = NFS_SERVER(dir);
 	if (server->flags & NFS_MOUNT_NOAC)
 		return -ENOENT;
+	desc = kmalloc(sizeof(nfs_readdir_descriptor_t), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+	entry = kmalloc(sizeof(struct nfs_entry), GFP_KERNEL);
+	if (!entry) {
+		res = -ENOMEM;
+		goto free_desc;
+	}
 	nfs_revalidate_inode(server, dir);
 
-	entry.fh = fh;
-	entry.fattr = fattr;
+	entry->fh = fh;
+	entry->fattr = fattr;
 
-	desc.decode = NFS_PROTO(dir)->decode_dirent;
-	desc.entry = &entry;
-	desc.page_index = 0;
-	desc.plus = 1;
+	desc->decode = NFS_PROTO(dir)->decode_dirent;
+	desc->entry = entry;
+	desc->page_index = 0;
+	desc->plus = 1;
 
-	for(;(page = find_get_page(dir->i_mapping, desc.page_index)); desc.page_index++) {
+	for(;(page = find_get_page(dir->i_mapping, desc->page_index)); desc->page_index++) {
 
 		res = -EIO;
 		if (Page_Uptodate(page)) {
-			desc.ptr = kmap(page);
-			res = find_dirent_name(&desc, page, dentry);
+			desc->ptr = kmap(page);
+			res = find_dirent_name(desc, page, dentry);
 			kunmap(page);
 		}
 		page_cache_release(page);
 
-		if (res == 0)
-			goto out_found;
+		if (res == 0) {
+			fattr->timestamp = timestamp;
+			goto free_entry;
+		}
 		if (res != -EAGAIN)
 			break;
 	}
-	return -ENOENT;
- out_found:
-	fattr->timestamp = timestamp;
-	return 0;
+	res = -ENOENT;
+ free_entry:
+ 	kfree(entry);
+ free_desc:
+	kfree(desc);
+	return res;
 }
 
 /*
diff -ur largestack/fs/nfs/inode.c smallstack/fs/nfs/inode.c
--- largestack/fs/nfs/inode.c	2003-10-03 17:28:49.000000000 -0400
+++ smallstack/fs/nfs/inode.c	2004-12-16 13:50:34.000000000 -0500
@@ -1026,11 +1026,14 @@
 __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 {
 	int		 status = -ESTALE;
-	struct nfs_fattr fattr;
+	struct nfs_fattr *fattr;
 
 	dfprintk(PAGECACHE, "NFS: revalidating (%x/%Ld)\n",
 		inode->i_dev, (long long)NFS_FILEID(inode));
 
+	fattr = kmalloc(sizeof(struct nfs_fattr), GFP_KERNEL);
+	if (!fattr) 
+		return -ENOMEM;
 	lock_kernel();
 	if (!inode || is_bad_inode(inode))
  		goto out_nowait;
@@ -1048,7 +1051,7 @@
 	}
 	NFS_FLAGS(inode) |= NFS_INO_REVALIDATING;
 
-	status = NFS_PROTO(inode)->getattr(inode, &fattr);
+	status = NFS_PROTO(inode)->getattr(inode, fattr);
 	if (status) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%x/%Ld) getattr failed, error=%d\n",
 			 inode->i_dev, (long long)NFS_FILEID(inode), status);
@@ -1060,7 +1063,7 @@
 		goto out;
 	}
 
-	status = nfs_refresh_inode(inode, &fattr);
+	status = nfs_refresh_inode(inode, fattr);
 	if (status) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%x/%Ld) refresh failed, error=%d\n",
 			 inode->i_dev, (long long)NFS_FILEID(inode), status);
@@ -1073,8 +1076,9 @@
 out:
 	NFS_FLAGS(inode) &= ~NFS_INO_REVALIDATING;
 	wake_up(&inode->i_wait);
- out_nowait:
+out_nowait:
 	unlock_kernel();
+	kfree(fattr);
 	return status;
 }
 
diff -ur largestack/lib/vsprintf.c smallstack/lib/vsprintf.c
--- largestack/lib/vsprintf.c	2003-10-03 17:28:36.000000000 -0400
+++ smallstack/lib/vsprintf.c	2004-12-16 13:55:32.000000000 -0500
@@ -127,12 +127,16 @@
 #define SPECIAL	32		/* 0x */
 #define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
 
+/* Move these off of the stack for number().  This way we reduce the 
+ * size of the stack and don't have to copy them every time we are called.
+ */
+const char small_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";
+const char large_digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
+
 static char * number(char * buf, char * end, long long num, int base, int size, int precision, int type)
 {
 	char c,sign,tmp[66];
 	const char *digits;
-	const char small_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";
-	const char large_digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
 	int i;
 
 	digits = (type & LARGE) ? large_digits : small_digits;
diff -ur largestack/net/sunrpc/clnt.c smallstack/net/sunrpc/clnt.c
--- largestack/net/sunrpc/clnt.c	2003-10-03 17:28:49.000000000 -0400
+++ smallstack/net/sunrpc/clnt.c	2004-12-10 11:27:30.000000000 -0500
@@ -240,7 +240,7 @@
  */
 int rpc_call_sync(struct rpc_clnt *clnt, struct rpc_message *msg, int flags)
 {
-	struct rpc_task	my_task, *task = &my_task;
+	struct rpc_task	*task;
 	sigset_t	oldset;
 	int		status;
 
@@ -253,6 +253,10 @@
 		flags &= ~RPC_TASK_ASYNC;
 	}
 
+        task = kmalloc(sizeof(struct rpc_task), GFP_KERNEL);
+	if (!task)
+		return -ENOMEM;
+
 	rpc_clnt_sigmask(clnt, &oldset);		
 
 	/* Create/initialize a new RPC task */
@@ -268,6 +272,7 @@
 	}
 
 	rpc_clnt_sigunmask(clnt, &oldset);		
+	kfree(task);
 
 	return status;
 }
diff -ur largestack/net/sunrpc/xprt.c smallstack/net/sunrpc/xprt.c
--- largestack/net/sunrpc/xprt.c	2004-12-14 15:58:06.000000000 -0500
+++ smallstack/net/sunrpc/xprt.c	2004-12-10 13:11:49.000000000 -0500
@@ -215,9 +215,9 @@
 xprt_sendmsg(struct rpc_xprt *xprt, struct rpc_rqst *req)
 {
 	struct socket	*sock = xprt->sock;
-	struct msghdr	msg;
+	struct msghdr	*msg;
 	struct xdr_buf	*xdr = &req->rq_snd_buf;
-	struct iovec	niv[MAX_IOVEC];
+	struct iovec	*niv;
 	unsigned int	niov, slen, skip;
 	mm_segment_t	oldfs;
 	int		result;
@@ -225,6 +225,14 @@
 	if (!sock)
 		return -ENOTCONN;
 
+	msg = kmalloc(sizeof(struct msghdr), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	niv = kmalloc(sizeof(struct iovec)*MAX_IOVEC, GFP_KERNEL);
+	if (!niv) {
+		kfree(msg);
+		return -ENOMEM;
+	}
 	xprt_pktdump("packet data:",
 				req->rq_svec->iov_base,
 				req->rq_svec->iov_len);
@@ -242,20 +250,20 @@
 			break;
 		}
 
-		msg.msg_flags   = MSG_DONTWAIT|MSG_NOSIGNAL;
-		msg.msg_iov	= niv;
-		msg.msg_iovlen	= niov;
-		msg.msg_name	= (struct sockaddr *) &xprt->addr;
-		msg.msg_namelen = sizeof(xprt->addr);
-		msg.msg_control = NULL;
-		msg.msg_controllen = 0;
+		msg->msg_flags   = MSG_DONTWAIT|MSG_NOSIGNAL;
+		msg->msg_iov	= niv;
+		msg->msg_iovlen	= niov;
+		msg->msg_name	= (struct sockaddr *) &xprt->addr;
+		msg->msg_namelen = sizeof(xprt->addr);
+		msg->msg_control = NULL;
+		msg->msg_controllen = 0;
 
 		slen_part = 0;
 		for (n = 0; n < niov; n++)
 			slen_part += niv[n].iov_len;
 
 		clear_bit(SOCK_ASYNC_NOSPACE, &sock->flags);
-		result = sock_sendmsg(sock, &msg, slen_part);
+		result = sock_sendmsg(sock, msg, slen_part);
 
 		xdr_kunmap(xdr, skip, niov);
 
@@ -266,26 +274,28 @@
 
 	dprintk("RPC:      xprt_sendmsg(%d) = %d\n", slen, result);
 
-	if (result >= 0)
-		return result;
-
-	switch (result) {
-	case -ECONNREFUSED:
-		/* When the server has died, an ICMP port unreachable message
-		 * prompts ECONNREFUSED.
-		 */
-	case -EAGAIN:
-		break;
-	case -ECONNRESET:
-	case -ENOTCONN:
-	case -EPIPE:
-		/* connection broken */
-		if (xprt->stream)
-			result = -ENOTCONN;
-		break;
-	default:
-		printk(KERN_NOTICE "RPC: sendmsg returned error %d\n", -result);
+	if (result < 0) {
+		switch (result) {
+		case -ECONNREFUSED:
+			/* When the server has died, an ICMP port unreachable
+			 *  message prompts ECONNREFUSED.
+			 */
+		case -EAGAIN:
+			break;
+		case -ECONNRESET:
+		case -ENOTCONN:
+		case -EPIPE:
+			/* connection broken */
+			if (xprt->stream)
+				result = -ENOTCONN;
+			break;
+		default:
+			printk(KERN_NOTICE "RPC: sendmsg returned error %d\n",
+			        -result);
+		}
 	}
+	kfree(msg);
+	kfree(niv);
 	return result;
 }
 

--=-MZwmiQNVI/SXjQBKlaKu--

