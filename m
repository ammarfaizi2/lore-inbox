Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWHXGjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWHXGjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWHXGjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:39:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30898 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030343AbWHXGhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:37:05 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 16:37:05 +1000
Message-Id: <1060824063705.4996@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 11] knfsd: Avoid excess stack usage in svc_tcp_recvfrom
References: <20060824162917.3600.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


.. by allocating the array of 'kvec' in 'struct svc_rqst'.

As we plan to increase RPCSVC_MAXPAGES from 8 upto 256, we
can no longer allocate an array of this size on the stack.
So we allocate it in 'struct svc_rqst'.

However svc_rqst contains (indirectly) an array of the same
type and size (actually several, but they are in a union).
So rather than waste space, we move those arrays out of the
separately allocated union and into svc_rqst to share with
the kvec moved out of svc_tcp_recvfrom (various arrays are used
at different times, so there is no conflict).


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs3proc.c         |    4 ++--
 ./fs/nfsd/nfs3xdr.c          |   22 +++++++++++-----------
 ./fs/nfsd/nfs4proc.c         |    2 +-
 ./fs/nfsd/nfs4xdr.c          |   26 +++++++++++++-------------
 ./fs/nfsd/nfsproc.c          |    4 ++--
 ./fs/nfsd/nfsxdr.c           |   22 +++++++++++-----------
 ./include/linux/nfsd/xdr.h   |    2 --
 ./include/linux/nfsd/xdr3.h  |    2 --
 ./include/linux/nfsd/xdr4.h  |    2 --
 ./include/linux/sunrpc/svc.h |    2 ++
 ./net/sunrpc/svcsock.c       |    3 ++-
 11 files changed, 44 insertions(+), 47 deletions(-)

diff .prev/fs/nfsd/nfs3proc.c ./fs/nfsd/nfs3proc.c
--- .prev/fs/nfsd/nfs3proc.c	2006-08-24 16:25:41.000000000 +1000
+++ ./fs/nfsd/nfs3proc.c	2006-08-24 16:25:41.000000000 +1000
@@ -180,7 +180,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp, 
 	fh_copy(&resp->fh, &argp->fh);
 	nfserr = nfsd_read(rqstp, &resp->fh, NULL,
 				  argp->offset,
-			   	  argp->vec, argp->vlen,
+			   	  rqstp->rq_vec, argp->vlen,
 				  &resp->count);
 	if (nfserr == 0) {
 		struct inode	*inode = resp->fh.fh_dentry->d_inode;
@@ -210,7 +210,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp,
 	resp->committed = argp->stable;
 	nfserr = nfsd_write(rqstp, &resp->fh, NULL,
 				   argp->offset,
-				   argp->vec, argp->vlen,
+				   rqstp->rq_vec, argp->vlen,
 				   argp->len,
 				   &resp->committed);
 	resp->count = argp->count;

diff .prev/fs/nfsd/nfs3xdr.c ./fs/nfsd/nfs3xdr.c
--- .prev/fs/nfsd/nfs3xdr.c	2006-08-24 16:25:13.000000000 +1000
+++ ./fs/nfsd/nfs3xdr.c	2006-08-24 16:25:41.000000000 +1000
@@ -344,9 +344,9 @@ nfs3svc_decode_readargs(struct svc_rqst 
 	v=0;
 	while (len > 0) {
 		pn = rqstp->rq_resused++;
-		args->vec[v].iov_base = page_address(rqstp->rq_respages[pn]);
-		args->vec[v].iov_len = len < PAGE_SIZE? len : PAGE_SIZE;
-		len -= args->vec[v].iov_len;
+		rqstp->rq_vec[v].iov_base = page_address(rqstp->rq_respages[pn]);
+		rqstp->rq_vec[v].iov_len = len < PAGE_SIZE? len : PAGE_SIZE;
+		len -= rqstp->rq_vec[v].iov_len;
 		v++;
 	}
 	args->vlen = v;
@@ -372,22 +372,22 @@ nfs3svc_decode_writeargs(struct svc_rqst
 	    rqstp->rq_arg.len - hdr < len)
 		return 0;
 
-	args->vec[0].iov_base = (void*)p;
-	args->vec[0].iov_len = rqstp->rq_arg.head[0].iov_len - hdr;
+	rqstp->rq_vec[0].iov_base = (void*)p;
+	rqstp->rq_vec[0].iov_len = rqstp->rq_arg.head[0].iov_len - hdr;
 
 	if (len > NFSSVC_MAXBLKSIZE)
 		len = NFSSVC_MAXBLKSIZE;
 	v=  0;
-	while (len > args->vec[v].iov_len) {
-		len -= args->vec[v].iov_len;
+	while (len > rqstp->rq_vec[v].iov_len) {
+		len -= rqstp->rq_vec[v].iov_len;
 		v++;
-		args->vec[v].iov_base = page_address(rqstp->rq_pages[v]);
-		args->vec[v].iov_len = PAGE_SIZE;
+		rqstp->rq_vec[v].iov_base = page_address(rqstp->rq_pages[v]);
+		rqstp->rq_vec[v].iov_len = PAGE_SIZE;
 	}
-	args->vec[v].iov_len = len;
+	rqstp->rq_vec[v].iov_len = len;
 	args->vlen = v+1;
 
-	return args->count == args->len && args->vec[0].iov_len > 0;
+	return args->count == args->len && rqstp->rq_vec[0].iov_len > 0;
 }
 
 int

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-08-24 16:25:41.000000000 +1000
+++ ./fs/nfsd/nfs4proc.c	2006-08-24 16:25:41.000000000 +1000
@@ -646,7 +646,7 @@ nfsd4_write(struct svc_rqst *rqstp, stru
 	*p++ = nfssvc_boot.tv_usec;
 
 	status =  nfsd_write(rqstp, current_fh, filp, write->wr_offset,
-			write->wr_vec, write->wr_vlen, write->wr_buflen,
+			rqstp->rq_vec, write->wr_vlen, write->wr_buflen,
 			&write->wr_how_written);
 	if (filp)
 		fput(filp);

diff .prev/fs/nfsd/nfs4xdr.c ./fs/nfsd/nfs4xdr.c
--- .prev/fs/nfsd/nfs4xdr.c	2006-08-24 16:25:13.000000000 +1000
+++ ./fs/nfsd/nfs4xdr.c	2006-08-24 16:25:41.000000000 +1000
@@ -927,26 +927,26 @@ nfsd4_decode_write(struct nfsd4_compound
 		printk(KERN_NOTICE "xdr error! (%s:%d)\n", __FILE__, __LINE__); 
 		goto xdr_error;
 	}
-	write->wr_vec[0].iov_base = p;
-	write->wr_vec[0].iov_len = avail;
+	argp->rqstp->rq_vec[0].iov_base = p;
+	argp->rqstp->rq_vec[0].iov_len = avail;
 	v = 0;
 	len = write->wr_buflen;
-	while (len > write->wr_vec[v].iov_len) {
-		len -= write->wr_vec[v].iov_len;
+	while (len > argp->rqstp->rq_vec[v].iov_len) {
+		len -= argp->rqstp->rq_vec[v].iov_len;
 		v++;
-		write->wr_vec[v].iov_base = page_address(argp->pagelist[0]);
+		argp->rqstp->rq_vec[v].iov_base = page_address(argp->pagelist[0]);
 		argp->pagelist++;
 		if (argp->pagelen >= PAGE_SIZE) {
-			write->wr_vec[v].iov_len = PAGE_SIZE;
+			argp->rqstp->rq_vec[v].iov_len = PAGE_SIZE;
 			argp->pagelen -= PAGE_SIZE;
 		} else {
-			write->wr_vec[v].iov_len = argp->pagelen;
+			argp->rqstp->rq_vec[v].iov_len = argp->pagelen;
 			argp->pagelen -= len;
 		}
 	}
-	argp->end = (u32*) (write->wr_vec[v].iov_base + write->wr_vec[v].iov_len);
-	argp->p = (u32*)  (write->wr_vec[v].iov_base + (XDR_QUADLEN(len) << 2));
-	write->wr_vec[v].iov_len = len;
+	argp->end = (u32*) (argp->rqstp->rq_vec[v].iov_base + argp->rqstp->rq_vec[v].iov_len);
+	argp->p = (u32*)  (argp->rqstp->rq_vec[v].iov_base + (XDR_QUADLEN(len) << 2));
+	argp->rqstp->rq_vec[v].iov_len = len;
 	write->wr_vlen = v+1;
 
 	DECODE_TAIL;
@@ -2064,9 +2064,9 @@ nfsd4_encode_read(struct nfsd4_compoundr
 	v = 0;
 	while (len > 0) {
 		pn = resp->rqstp->rq_resused++;
-		read->rd_iov[v].iov_base =
+		resp->rqstp->rq_vec[v].iov_base =
 			page_address(resp->rqstp->rq_respages[pn]);
-		read->rd_iov[v].iov_len =
+		resp->rqstp->rq_vec[v].iov_len =
 			len < PAGE_SIZE ? len : PAGE_SIZE;
 		v++;
 		len -= PAGE_SIZE;
@@ -2074,7 +2074,7 @@ nfsd4_encode_read(struct nfsd4_compoundr
 	read->rd_vlen = v;
 
 	nfserr = nfsd_read(read->rd_rqstp, read->rd_fhp, read->rd_filp,
-			read->rd_offset, read->rd_iov, read->rd_vlen,
+			read->rd_offset, resp->rqstp->rq_vec, read->rd_vlen,
 			&maxcount);
 
 	if (nfserr == nfserr_symlink)

diff .prev/fs/nfsd/nfsproc.c ./fs/nfsd/nfsproc.c
--- .prev/fs/nfsd/nfsproc.c	2006-08-24 16:21:35.000000000 +1000
+++ ./fs/nfsd/nfsproc.c	2006-08-24 16:25:41.000000000 +1000
@@ -159,7 +159,7 @@ nfsd_proc_read(struct svc_rqst *rqstp, s
 	resp->count = argp->count;
 	nfserr = nfsd_read(rqstp, fh_copy(&resp->fh, &argp->fh), NULL,
 				  argp->offset,
-			   	  argp->vec, argp->vlen,
+			   	  rqstp->rq_vec, argp->vlen,
 				  &resp->count);
 
 	if (nfserr) return nfserr;
@@ -185,7 +185,7 @@ nfsd_proc_write(struct svc_rqst *rqstp, 
 
 	nfserr = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh), NULL,
 				   argp->offset,
-				   argp->vec, argp->vlen,
+				   rqstp->rq_vec, argp->vlen,
 				   argp->len,
 				   &stable);
 	return nfsd_return_attrs(nfserr, resp);

diff .prev/fs/nfsd/nfsxdr.c ./fs/nfsd/nfsxdr.c
--- .prev/fs/nfsd/nfsxdr.c	2006-08-24 16:25:13.000000000 +1000
+++ ./fs/nfsd/nfsxdr.c	2006-08-24 16:25:41.000000000 +1000
@@ -263,9 +263,9 @@ nfssvc_decode_readargs(struct svc_rqst *
 	v=0;
 	while (len > 0) {
 		pn = rqstp->rq_resused++;
-		args->vec[v].iov_base = page_address(rqstp->rq_respages[pn]);
-		args->vec[v].iov_len = len < PAGE_SIZE?len:PAGE_SIZE;
-		len -= args->vec[v].iov_len;
+		rqstp->rq_vec[v].iov_base = page_address(rqstp->rq_respages[pn]);
+		rqstp->rq_vec[v].iov_len = len < PAGE_SIZE?len:PAGE_SIZE;
+		len -= rqstp->rq_vec[v].iov_len;
 		v++;
 	}
 	args->vlen = v;
@@ -285,21 +285,21 @@ nfssvc_decode_writeargs(struct svc_rqst 
 	args->offset = ntohl(*p++);	/* offset */
 	p++;				/* totalcount */
 	len = args->len = ntohl(*p++);
-	args->vec[0].iov_base = (void*)p;
-	args->vec[0].iov_len = rqstp->rq_arg.head[0].iov_len -
+	rqstp->rq_vec[0].iov_base = (void*)p;
+	rqstp->rq_vec[0].iov_len = rqstp->rq_arg.head[0].iov_len -
 				(((void*)p) - rqstp->rq_arg.head[0].iov_base);
 	if (len > NFSSVC_MAXBLKSIZE)
 		len = NFSSVC_MAXBLKSIZE;
 	v = 0;
-	while (len > args->vec[v].iov_len) {
-		len -= args->vec[v].iov_len;
+	while (len > rqstp->rq_vec[v].iov_len) {
+		len -= rqstp->rq_vec[v].iov_len;
 		v++;
-		args->vec[v].iov_base = page_address(rqstp->rq_pages[v]);
-		args->vec[v].iov_len = PAGE_SIZE;
+		rqstp->rq_vec[v].iov_base = page_address(rqstp->rq_pages[v]);
+		rqstp->rq_vec[v].iov_len = PAGE_SIZE;
 	}
-	args->vec[v].iov_len = len;
+	rqstp->rq_vec[v].iov_len = len;
 	args->vlen = v+1;
-	return args->vec[0].iov_len > 0;
+	return rqstp->rq_vec[0].iov_len > 0;
 }
 
 int

diff .prev/include/linux/nfsd/xdr.h ./include/linux/nfsd/xdr.h
--- .prev/include/linux/nfsd/xdr.h	2006-08-24 16:25:41.000000000 +1000
+++ ./include/linux/nfsd/xdr.h	2006-08-24 16:25:41.000000000 +1000
@@ -30,7 +30,6 @@ struct nfsd_readargs {
 	struct svc_fh		fh;
 	__u32			offset;
 	__u32			count;
-	struct kvec		vec[RPCSVC_MAXPAGES];
 	int			vlen;
 };
 
@@ -38,7 +37,6 @@ struct nfsd_writeargs {
 	svc_fh			fh;
 	__u32			offset;
 	int			len;
-	struct kvec		vec[RPCSVC_MAXPAGES];
 	int			vlen;
 };
 

diff .prev/include/linux/nfsd/xdr3.h ./include/linux/nfsd/xdr3.h
--- .prev/include/linux/nfsd/xdr3.h	2006-08-24 16:25:41.000000000 +1000
+++ ./include/linux/nfsd/xdr3.h	2006-08-24 16:25:41.000000000 +1000
@@ -33,7 +33,6 @@ struct nfsd3_readargs {
 	struct svc_fh		fh;
 	__u64			offset;
 	__u32			count;
-	struct kvec		vec[RPCSVC_MAXPAGES];
 	int			vlen;
 };
 
@@ -43,7 +42,6 @@ struct nfsd3_writeargs {
 	__u32			count;
 	int			stable;
 	__u32			len;
-	struct kvec		vec[RPCSVC_MAXPAGES];
 	int			vlen;
 };
 

diff .prev/include/linux/nfsd/xdr4.h ./include/linux/nfsd/xdr4.h
--- .prev/include/linux/nfsd/xdr4.h	2006-08-24 16:25:41.000000000 +1000
+++ ./include/linux/nfsd/xdr4.h	2006-08-24 16:25:41.000000000 +1000
@@ -241,7 +241,6 @@ struct nfsd4_read {
 	stateid_t	rd_stateid;         /* request */
 	u64		rd_offset;          /* request */
 	u32		rd_length;          /* request */
-	struct kvec	rd_iov[RPCSVC_MAXPAGES];
 	int		rd_vlen;
 	struct file     *rd_filp;
 	
@@ -326,7 +325,6 @@ struct nfsd4_write {
 	u64		wr_offset;          /* request */
 	u32		wr_stable_how;      /* request */
 	u32		wr_buflen;          /* request */
-	struct kvec	wr_vec[RPCSVC_MAXPAGES]; /* request */
 	int		wr_vlen;
 
 	u32		wr_bytes_written;   /* response */

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-08-24 16:25:13.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-08-24 16:25:41.000000000 +1000
@@ -175,6 +175,8 @@ struct svc_rqst {
 	struct page *		*rq_respages;	/* points into rq_pages */
 	int			rq_resused;	/* number of pages used for result */
 
+	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
+
 	u32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
 	u32			rq_vers;	/* program version */

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-08-24 16:25:13.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-08-24 16:25:41.000000000 +1000
@@ -955,7 +955,7 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	struct svc_sock	*svsk = rqstp->rq_sock;
 	struct svc_serv	*serv = svsk->sk_server;
 	int		len;
-	struct kvec vec[RPCSVC_MAXPAGES];
+	struct kvec *vec;
 	int pnum, vlen;
 
 	dprintk("svc: tcp_recv %p data %d conn %d close %d\n",
@@ -1053,6 +1053,7 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	len = svsk->sk_reclen;
 	set_bit(SK_DATA, &svsk->sk_flags);
 
+	vec = rqstp->rq_vec;
 	vec[0] = rqstp->rq_arg.head[0];
 	vlen = PAGE_SIZE;
 	pnum = 1;
