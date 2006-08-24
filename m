Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWHXGhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWHXGhZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWHXGhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:37:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28850 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030340AbWHXGg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:36:59 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 16:36:59 +1000
Message-Id: <1060824063659.4983@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 11] knfsd: Replace two page lists in struct svc_rqst with one.
References: <20060824162917.3600.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are planning to increase RPCSVC_MAXPAGES from about
8 to about 256.  This means we need to be a bit careful
about arrays of size RPCSVC_MAXPAGES.

struct svc_rqst contains two such arrays.
However the there are never more that RPCSVC_MAXPAGES
pages in the two arrays together, so only one array is needed.

The two arrays are for the pages holding the request,
and the pages holding the reply.
Instead of two arrays, we can simply keep an index into
where the first reply page is.

This patch also removes a number of small inline functions that
probably server to obscure what is going on rather than clarify it,
and opencode the needed functionality.

Also remove the 'rq_restailpage' variable as it is *always* 0.
i.e. if the response 'xdr' structure has a non-empty tail it is
always in the same pages as the head.

 check counters are initilised and incr properly
 check for consistant usage of ++ etc
 maybe extra some inlines for common approach
 general review


Description...

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs2acl.c                 |    2 -
 ./fs/nfsd/nfs3acl.c                 |    2 -
 ./fs/nfsd/nfs3xdr.c                 |   23 ++++--------
 ./fs/nfsd/nfs4xdr.c                 |   27 ++++++--------
 ./fs/nfsd/nfsxdr.c                  |   13 ++----
 ./fs/nfsd/vfs.c                     |   16 +++++---
 ./include/linux/sunrpc/svc.h        |   69 +++++-------------------------------
 ./net/sunrpc/auth_gss/svcauth_gss.c |    4 --
 ./net/sunrpc/svc.c                  |   21 +++-------
 ./net/sunrpc/svcsock.c              |   40 ++++++++++----------
 10 files changed, 76 insertions(+), 141 deletions(-)

diff .prev/fs/nfsd/nfs2acl.c ./fs/nfsd/nfs2acl.c
--- .prev/fs/nfsd/nfs2acl.c	2006-08-24 16:25:13.000000000 +1000
+++ ./fs/nfsd/nfs2acl.c	2006-08-24 16:25:13.000000000 +1000
@@ -241,7 +241,7 @@ static int nfsaclsvc_encode_getaclres(st
 
 	rqstp->rq_res.page_len = w;
 	while (w > 0) {
-		if (!svc_take_res_page(rqstp))
+		if (!rqstp->rq_respages[rqstp->rq_resused++])
 			return 0;
 		w -= PAGE_SIZE;
 	}

diff .prev/fs/nfsd/nfs3acl.c ./fs/nfsd/nfs3acl.c
--- .prev/fs/nfsd/nfs3acl.c	2006-08-24 16:25:13.000000000 +1000
+++ ./fs/nfsd/nfs3acl.c	2006-08-24 16:25:13.000000000 +1000
@@ -185,7 +185,7 @@ static int nfs3svc_encode_getaclres(stru
 
 		rqstp->rq_res.page_len = w;
 		while (w > 0) {
-			if (!svc_take_res_page(rqstp))
+			if (!rqstp->rq_respages[rqstp->rq_resused++])
 				return 0;
 			w -= PAGE_SIZE;
 		}

diff .prev/fs/nfsd/nfs3xdr.c ./fs/nfsd/nfs3xdr.c
--- .prev/fs/nfsd/nfs3xdr.c	2006-08-24 16:25:13.000000000 +1000
+++ ./fs/nfsd/nfs3xdr.c	2006-08-24 16:25:13.000000000 +1000
@@ -343,8 +343,7 @@ nfs3svc_decode_readargs(struct svc_rqst 
 	/* set up the kvec */
 	v=0;
 	while (len > 0) {
-		pn = rqstp->rq_resused;
-		svc_take_page(rqstp);
+		pn = rqstp->rq_resused++;
 		args->vec[v].iov_base = page_address(rqstp->rq_respages[pn]);
 		args->vec[v].iov_len = len < PAGE_SIZE? len : PAGE_SIZE;
 		len -= args->vec[v].iov_len;
@@ -382,7 +381,7 @@ nfs3svc_decode_writeargs(struct svc_rqst
 	while (len > args->vec[v].iov_len) {
 		len -= args->vec[v].iov_len;
 		v++;
-		args->vec[v].iov_base = page_address(rqstp->rq_argpages[v]);
+		args->vec[v].iov_base = page_address(rqstp->rq_pages[v]);
 		args->vec[v].iov_len = PAGE_SIZE;
 	}
 	args->vec[v].iov_len = len;
@@ -446,11 +445,11 @@ nfs3svc_decode_symlinkargs(struct svc_rq
 	 * This page appears in the rq_res.pages list, but as pages_len is always
 	 * 0, it won't get in the way
 	 */
-	svc_take_page(rqstp);
 	len = ntohl(*p++);
 	if (len == 0 || len > NFS3_MAXPATHLEN || len >= PAGE_SIZE)
 		return 0;
-	args->tname = new = page_address(rqstp->rq_respages[rqstp->rq_resused-1]);
+	args->tname = new =
+		page_address(rqstp->rq_respages[rqstp->rq_resused++]);
 	args->tlen = len;
 	/* first copy and check from the first page */
 	old = (char*)p;
@@ -522,8 +521,8 @@ nfs3svc_decode_readlinkargs(struct svc_r
 {
 	if (!(p = decode_fh(p, &args->fh)))
 		return 0;
-	svc_take_page(rqstp);
-	args->buffer = page_address(rqstp->rq_respages[rqstp->rq_resused-1]);
+	args->buffer =
+		page_address(rqstp->rq_respages[rqstp->rq_resused++]);
 
 	return xdr_argsize_check(rqstp, p);
 }
@@ -554,8 +553,8 @@ nfs3svc_decode_readdirargs(struct svc_rq
 	if (args->count > PAGE_SIZE)
 		args->count = PAGE_SIZE;
 
-	svc_take_page(rqstp);
-	args->buffer = page_address(rqstp->rq_respages[rqstp->rq_resused-1]);
+	args->buffer =
+		page_address(rqstp->rq_respages[rqstp->rq_resused++]);
 
 	return xdr_argsize_check(rqstp, p);
 }
@@ -578,8 +577,7 @@ nfs3svc_decode_readdirplusargs(struct sv
 	args->count = len;
 
 	while (len > 0) {
-		pn = rqstp->rq_resused;
-		svc_take_page(rqstp);
+		pn = rqstp->rq_resused++;
 		if (!args->buffer)
 			args->buffer = page_address(rqstp->rq_respages[pn]);
 		len -= PAGE_SIZE;
@@ -668,7 +666,6 @@ nfs3svc_encode_readlinkres(struct svc_rq
 		rqstp->rq_res.page_len = resp->len;
 		if (resp->len & 3) {
 			/* need to pad the tail */
-			rqstp->rq_restailpage = 0;
 			rqstp->rq_res.tail[0].iov_base = p;
 			*p = 0;
 			rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
@@ -693,7 +690,6 @@ nfs3svc_encode_readres(struct svc_rqst *
 		rqstp->rq_res.page_len = resp->count;
 		if (resp->count & 3) {
 			/* need to pad the tail */
-			rqstp->rq_restailpage = 0;
 			rqstp->rq_res.tail[0].iov_base = p;
 			*p = 0;
 			rqstp->rq_res.tail[0].iov_len = 4 - (resp->count & 3);
@@ -768,7 +764,6 @@ nfs3svc_encode_readdirres(struct svc_rqs
 		rqstp->rq_res.page_len = (resp->count) << 2;
 
 		/* add the 'tail' to the end of the 'head' page - page 0. */
-		rqstp->rq_restailpage = 0;
 		rqstp->rq_res.tail[0].iov_base = p;
 		*p++ = 0;		/* no more entries */
 		*p++ = htonl(resp->common.err == nfserr_eof);

diff .prev/fs/nfsd/nfs4xdr.c ./fs/nfsd/nfs4xdr.c
--- .prev/fs/nfsd/nfs4xdr.c	2006-08-24 16:25:13.000000000 +1000
+++ ./fs/nfsd/nfs4xdr.c	2006-08-24 16:25:13.000000000 +1000
@@ -2040,7 +2040,8 @@ nfsd4_encode_open_downgrade(struct nfsd4
 }
 
 static int
-nfsd4_encode_read(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_read *read)
+nfsd4_encode_read(struct nfsd4_compoundres *resp, int nfserr,
+		  struct nfsd4_read *read)
 {
 	u32 eof;
 	int v, pn;
@@ -2062,10 +2063,11 @@ nfsd4_encode_read(struct nfsd4_compoundr
 	len = maxcount;
 	v = 0;
 	while (len > 0) {
-		pn = resp->rqstp->rq_resused;
-		svc_take_page(resp->rqstp);
-		read->rd_iov[v].iov_base = page_address(resp->rqstp->rq_respages[pn]);
-		read->rd_iov[v].iov_len = len < PAGE_SIZE ? len : PAGE_SIZE;
+		pn = resp->rqstp->rq_resused++;
+		read->rd_iov[v].iov_base =
+			page_address(resp->rqstp->rq_respages[pn]);
+		read->rd_iov[v].iov_len =
+			len < PAGE_SIZE ? len : PAGE_SIZE;
 		v++;
 		len -= PAGE_SIZE;
 	}
@@ -2079,7 +2081,8 @@ nfsd4_encode_read(struct nfsd4_compoundr
 		nfserr = nfserr_inval;
 	if (nfserr)
 		return nfserr;
-	eof = (read->rd_offset + maxcount >= read->rd_fhp->fh_dentry->d_inode->i_size);
+	eof = (read->rd_offset + maxcount >=
+	       read->rd_fhp->fh_dentry->d_inode->i_size);
 
 	WRITE32(eof);
 	WRITE32(maxcount);
@@ -2089,7 +2092,6 @@ nfsd4_encode_read(struct nfsd4_compoundr
 	resp->xbuf->page_len = maxcount;
 
 	/* Use rest of head for padding and remaining ops: */
-	resp->rqstp->rq_restailpage = 0;
 	resp->xbuf->tail[0].iov_base = p;
 	resp->xbuf->tail[0].iov_len = 0;
 	if (maxcount&3) {
@@ -2114,8 +2116,7 @@ nfsd4_encode_readlink(struct nfsd4_compo
 	if (resp->xbuf->page_len)
 		return nfserr_resource;
 
-	svc_take_page(resp->rqstp);
-	page = page_address(resp->rqstp->rq_respages[resp->rqstp->rq_resused-1]);
+	page = page_address(resp->rqstp->rq_respages[resp->rqstp->rq_resused++]);
 
 	maxcount = PAGE_SIZE;
 	RESERVE_SPACE(4);
@@ -2139,7 +2140,6 @@ nfsd4_encode_readlink(struct nfsd4_compo
 	resp->xbuf->page_len = maxcount;
 
 	/* Use rest of head for padding and remaining ops: */
-	resp->rqstp->rq_restailpage = 0;
 	resp->xbuf->tail[0].iov_base = p;
 	resp->xbuf->tail[0].iov_len = 0;
 	if (maxcount&3) {
@@ -2190,8 +2190,7 @@ nfsd4_encode_readdir(struct nfsd4_compou
 		goto err_no_verf;
 	}
 
-	svc_take_page(resp->rqstp);
-	page = page_address(resp->rqstp->rq_respages[resp->rqstp->rq_resused-1]);
+	page = page_address(resp->rqstp->rq_respages[resp->rqstp->rq_resused++]);
 	readdir->common.err = 0;
 	readdir->buflen = maxcount;
 	readdir->buffer = page;
@@ -2216,10 +2215,10 @@ nfsd4_encode_readdir(struct nfsd4_compou
 	p = readdir->buffer;
 	*p++ = 0;	/* no more entries */
 	*p++ = htonl(readdir->common.err == nfserr_eof);
-	resp->xbuf->page_len = ((char*)p) - (char*)page_address(resp->rqstp->rq_respages[resp->rqstp->rq_resused-1]);
+	resp->xbuf->page_len = ((char*)p) - (char*)page_address(
+		resp->rqstp->rq_respages[resp->rqstp->rq_resused-1]);
 
 	/* Use rest of head for padding and remaining ops: */
-	resp->rqstp->rq_restailpage = 0;
 	resp->xbuf->tail[0].iov_base = tailbase;
 	resp->xbuf->tail[0].iov_len = 0;
 	resp->p = resp->xbuf->tail[0].iov_base;

diff .prev/fs/nfsd/nfsxdr.c ./fs/nfsd/nfsxdr.c
--- .prev/fs/nfsd/nfsxdr.c	2006-08-24 16:25:13.000000000 +1000
+++ ./fs/nfsd/nfsxdr.c	2006-08-24 16:25:13.000000000 +1000
@@ -262,8 +262,7 @@ nfssvc_decode_readargs(struct svc_rqst *
 	 */
 	v=0;
 	while (len > 0) {
-		pn=rqstp->rq_resused;
-		svc_take_page(rqstp);
+		pn = rqstp->rq_resused++;
 		args->vec[v].iov_base = page_address(rqstp->rq_respages[pn]);
 		args->vec[v].iov_len = len < PAGE_SIZE?len:PAGE_SIZE;
 		len -= args->vec[v].iov_len;
@@ -295,7 +294,7 @@ nfssvc_decode_writeargs(struct svc_rqst 
 	while (len > args->vec[v].iov_len) {
 		len -= args->vec[v].iov_len;
 		v++;
-		args->vec[v].iov_base = page_address(rqstp->rq_argpages[v]);
+		args->vec[v].iov_base = page_address(rqstp->rq_pages[v]);
 		args->vec[v].iov_len = PAGE_SIZE;
 	}
 	args->vec[v].iov_len = len;
@@ -333,8 +332,7 @@ nfssvc_decode_readlinkargs(struct svc_rq
 {
 	if (!(p = decode_fh(p, &args->fh)))
 		return 0;
-	svc_take_page(rqstp);
-	args->buffer = page_address(rqstp->rq_respages[rqstp->rq_resused-1]);
+	args->buffer = page_address(rqstp->rq_respages[rqstp->rq_resused++]);
 
 	return xdr_argsize_check(rqstp, p);
 }
@@ -375,8 +373,7 @@ nfssvc_decode_readdirargs(struct svc_rqs
 	if (args->count > PAGE_SIZE)
 		args->count = PAGE_SIZE;
 
-	svc_take_page(rqstp);
-	args->buffer = page_address(rqstp->rq_respages[rqstp->rq_resused-1]);
+	args->buffer = page_address(rqstp->rq_respages[rqstp->rq_resused++]);
 
 	return xdr_argsize_check(rqstp, p);
 }
@@ -416,7 +413,6 @@ nfssvc_encode_readlinkres(struct svc_rqs
 	rqstp->rq_res.page_len = resp->len;
 	if (resp->len & 3) {
 		/* need to pad the tail */
-		rqstp->rq_restailpage = 0;
 		rqstp->rq_res.tail[0].iov_base = p;
 		*p = 0;
 		rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
@@ -436,7 +432,6 @@ nfssvc_encode_readres(struct svc_rqst *r
 	rqstp->rq_res.page_len = resp->count;
 	if (resp->count & 3) {
 		/* need to pad the tail */
-		rqstp->rq_restailpage = 0;
 		rqstp->rq_res.tail[0].iov_base = p;
 		*p = 0;
 		rqstp->rq_res.tail[0].iov_len = 4 - (resp->count&3);

diff .prev/fs/nfsd/vfs.c ./fs/nfsd/vfs.c
--- .prev/fs/nfsd/vfs.c	2006-08-24 16:20:33.000000000 +1000
+++ ./fs/nfsd/vfs.c	2006-08-24 16:25:13.000000000 +1000
@@ -791,22 +791,26 @@ nfsd_read_actor(read_descriptor_t *desc,
 {
 	unsigned long count = desc->count;
 	struct svc_rqst *rqstp = desc->arg.data;
+	struct page **pp = rqstp->rq_respages + rqstp->rq_resused;
 
 	if (size > count)
 		size = count;
 
 	if (rqstp->rq_res.page_len == 0) {
 		get_page(page);
-		rqstp->rq_respages[rqstp->rq_resused++] = page;
+		put_page(*pp);
+		*pp = page;
+		rqstp->rq_resused++;
 		rqstp->rq_res.page_base = offset;
 		rqstp->rq_res.page_len = size;
-	} else if (page != rqstp->rq_respages[rqstp->rq_resused-1]) {
+	} else if (page != pp[-1]) {
 		get_page(page);
-		rqstp->rq_respages[rqstp->rq_resused++] = page;
+		put_page(*pp);
+		*pp = page;
+		rqstp->rq_resused++;
 		rqstp->rq_res.page_len += size;
-	} else {
+	} else
 		rqstp->rq_res.page_len += size;
-	}
 
 	desc->count = count - size;
 	desc->written += size;
@@ -840,7 +844,7 @@ nfsd_vfs_read(struct svc_rqst *rqstp, st
 		file->f_ra = ra->p_ra;
 
 	if (file->f_op->sendfile && rqstp->rq_sendfile_ok) {
-		svc_pushback_unused_pages(rqstp);
+		rqstp->rq_resused = 1;
 		err = file->f_op->sendfile(file, &offset, *count,
 						 nfsd_read_actor, rqstp);
 	} else {

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-08-24 16:25:13.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-08-24 16:25:13.000000000 +1000
@@ -153,7 +153,6 @@ static inline void svc_putu32(struct kve
 /*
  * The context of a single thread, including the request currently being
  * processed.
- * NOTE: First two items must be prev/next.
  */
 struct svc_rqst {
 	struct list_head	rq_list;	/* idle list */
@@ -172,12 +171,9 @@ struct svc_rqst {
 
 	struct xdr_buf		rq_arg;
 	struct xdr_buf		rq_res;
-	struct page *		rq_argpages[RPCSVC_MAXPAGES];
-	struct page *		rq_respages[RPCSVC_MAXPAGES];
-	int			rq_restailpage;
-	short			rq_argused;	/* pages used for argument */
-	short			rq_arghi;	/* pages available in argument page list */
-	short			rq_resused;	/* pages used for result */
+	struct page *		rq_pages[RPCSVC_MAXPAGES];
+	struct page *		*rq_respages;	/* points into rq_pages */
+	int			rq_resused;	/* number of pages used for result */
 
 	u32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
@@ -238,63 +234,18 @@ xdr_ressize_check(struct svc_rqst *rqstp
 	return vec->iov_len <= PAGE_SIZE;
 }
 
-static inline struct page *
-svc_take_res_page(struct svc_rqst *rqstp)
+static inline void svc_free_res_pages(struct svc_rqst *rqstp)
 {
-	if (rqstp->rq_arghi <= rqstp->rq_argused)
-		return NULL;
-	rqstp->rq_arghi--;
-	rqstp->rq_respages[rqstp->rq_resused] =
-		rqstp->rq_argpages[rqstp->rq_arghi];
-	return rqstp->rq_respages[rqstp->rq_resused++];
-}
-
-static inline void svc_take_page(struct svc_rqst *rqstp)
-{
-	if (rqstp->rq_arghi <= rqstp->rq_argused) {
-		WARN_ON(1);
-		return;
-	}
-	rqstp->rq_arghi--;
-	rqstp->rq_respages[rqstp->rq_resused] =
-		rqstp->rq_argpages[rqstp->rq_arghi];
-	rqstp->rq_resused++;
-}
-
-static inline void svc_pushback_allpages(struct svc_rqst *rqstp)
-{
-        while (rqstp->rq_resused) {
-		if (rqstp->rq_respages[--rqstp->rq_resused] == NULL)
-			continue;
-		rqstp->rq_argpages[rqstp->rq_arghi++] =
-			rqstp->rq_respages[rqstp->rq_resused];
-		rqstp->rq_respages[rqstp->rq_resused] = NULL;
-	}
-}
-
-static inline void svc_pushback_unused_pages(struct svc_rqst *rqstp)
-{
-	while (rqstp->rq_resused &&
-	       rqstp->rq_res.pages != &rqstp->rq_respages[rqstp->rq_resused]) {
-
-		if (rqstp->rq_respages[--rqstp->rq_resused] != NULL) {
-			rqstp->rq_argpages[rqstp->rq_arghi++] =
-				rqstp->rq_respages[rqstp->rq_resused];
-			rqstp->rq_respages[rqstp->rq_resused] = NULL;
+	while (rqstp->rq_resused) {
+		struct page **pp = (rqstp->rq_respages +
+				    --rqstp->rq_resused);
+		if (*pp) {
+			put_page(*pp);
+			*pp = NULL;
 		}
 	}
 }
 
-static inline void svc_free_allpages(struct svc_rqst *rqstp)
-{
-        while (rqstp->rq_resused) {
-		if (rqstp->rq_respages[--rqstp->rq_resused] == NULL)
-			continue;
-		put_page(rqstp->rq_respages[rqstp->rq_resused]);
-		rqstp->rq_respages[rqstp->rq_resused] = NULL;
-	}
-}
-
 struct svc_deferred_req {
 	u32			prot;	/* protocol (UDP or TCP) */
 	struct sockaddr_in	addr;

diff .prev/net/sunrpc/auth_gss/svcauth_gss.c ./net/sunrpc/auth_gss/svcauth_gss.c
--- .prev/net/sunrpc/auth_gss/svcauth_gss.c	2006-08-24 16:25:13.000000000 +1000
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-08-24 16:25:13.000000000 +1000
@@ -1191,7 +1191,6 @@ svcauth_gss_wrap_resp_integ(struct svc_r
 		resbuf->tail[0].iov_base = resbuf->head[0].iov_base
 						+ resbuf->head[0].iov_len;
 		resbuf->tail[0].iov_len = 0;
-		rqstp->rq_restailpage = 0;
 		resv = &resbuf->tail[0];
 	} else {
 		resv = &resbuf->tail[0];
@@ -1240,7 +1239,7 @@ svcauth_gss_wrap_resp_priv(struct svc_rq
 	inpages = resbuf->pages;
 	/* XXX: Would be better to write some xdr helper functions for
 	 * nfs{2,3,4}xdr.c that place the data right, instead of copying: */
-	if (resbuf->tail[0].iov_base && rqstp->rq_restailpage == 0) {
+	if (resbuf->tail[0].iov_base) {
 		BUG_ON(resbuf->tail[0].iov_base >= resbuf->head[0].iov_base
 							+ PAGE_SIZE);
 		BUG_ON(resbuf->tail[0].iov_base < resbuf->head[0].iov_base);
@@ -1258,7 +1257,6 @@ svcauth_gss_wrap_resp_priv(struct svc_rq
 		resbuf->tail[0].iov_base = resbuf->head[0].iov_base
 			+ resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE;
 		resbuf->tail[0].iov_len = 0;
-		rqstp->rq_restailpage = 0;
 	}
 	if (gss_wrap(gsd->rsci->mechctx, offset, resbuf, inpages))
 		return -ENOMEM;

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-08-24 16:25:13.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-08-24 16:25:13.000000000 +1000
@@ -417,18 +417,15 @@ svc_init_buffer(struct svc_rqst *rqstp, 
 	if (size > RPCSVC_MAXPAYLOAD)
 		size = RPCSVC_MAXPAYLOAD;
 	pages = 2 + (size+ PAGE_SIZE -1) / PAGE_SIZE;
-	rqstp->rq_argused = 0;
-	rqstp->rq_resused = 0;
 	arghi = 0;
 	BUG_ON(pages > RPCSVC_MAXPAGES);
 	while (pages) {
 		struct page *p = alloc_page(GFP_KERNEL);
 		if (!p)
 			break;
-		rqstp->rq_argpages[arghi++] = p;
+		rqstp->rq_pages[arghi++] = p;
 		pages--;
 	}
-	rqstp->rq_arghi = arghi;
 	return ! pages;
 }
 
@@ -438,14 +435,10 @@ svc_init_buffer(struct svc_rqst *rqstp, 
 static void
 svc_release_buffer(struct svc_rqst *rqstp)
 {
-	while (rqstp->rq_arghi)
-		put_page(rqstp->rq_argpages[--rqstp->rq_arghi]);
-	while (rqstp->rq_resused) {
-		if (rqstp->rq_respages[--rqstp->rq_resused] == NULL)
-			continue;
-		put_page(rqstp->rq_respages[rqstp->rq_resused]);
-	}
-	rqstp->rq_argused = 0;
+	int i;
+	for (i=0; i<ARRAY_SIZE(rqstp->rq_pages); i++)
+		if (rqstp->rq_pages[i])
+			put_page(rqstp->rq_pages[i]);
 }
 
 /*
@@ -707,10 +700,10 @@ svc_process(struct svc_rqst *rqstp)
 	/* setup response xdr_buf.
 	 * Initially it has just one page 
 	 */
-	svc_take_page(rqstp); /* must succeed */
+	rqstp->rq_resused = 1;
 	resv->iov_base = page_address(rqstp->rq_respages[0]);
 	resv->iov_len = 0;
-	rqstp->rq_res.pages = rqstp->rq_respages+1;
+	rqstp->rq_res.pages = rqstp->rq_respages + 1;
 	rqstp->rq_res.len = 0;
 	rqstp->rq_res.page_base = 0;
 	rqstp->rq_res.page_len = 0;

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-08-24 16:24:56.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-08-24 16:25:13.000000000 +1000
@@ -313,7 +313,7 @@ svc_sock_release(struct svc_rqst *rqstp)
 
 	svc_release_skb(rqstp);
 
-	svc_free_allpages(rqstp);
+	svc_free_res_pages(rqstp);
 	rqstp->rq_res.page_len = 0;
 	rqstp->rq_res.page_base = 0;
 
@@ -412,7 +412,8 @@ svc_sendto(struct svc_rqst *rqstp, struc
 	/* send head */
 	if (slen == xdr->head[0].iov_len)
 		flags = 0;
-	len = kernel_sendpage(sock, rqstp->rq_respages[0], 0, xdr->head[0].iov_len, flags);
+	len = kernel_sendpage(sock, rqstp->rq_respages[0], 0,
+				  xdr->head[0].iov_len, flags);
 	if (len != xdr->head[0].iov_len)
 		goto out;
 	slen -= xdr->head[0].iov_len;
@@ -437,8 +438,9 @@ svc_sendto(struct svc_rqst *rqstp, struc
 	}
 	/* send tail */
 	if (xdr->tail[0].iov_len) {
-		result = kernel_sendpage(sock, rqstp->rq_respages[rqstp->rq_restailpage],
-					     ((unsigned long)xdr->tail[0].iov_base)& (PAGE_SIZE-1),
+		result = kernel_sendpage(sock, rqstp->rq_respages[0],
+					     ((unsigned long)xdr->tail[0].iov_base)
+					        & (PAGE_SIZE-1),
 					     xdr->tail[0].iov_len, 0);
 
 		if (result > 0)
@@ -708,9 +710,11 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 	if (len <= rqstp->rq_arg.head[0].iov_len) {
 		rqstp->rq_arg.head[0].iov_len = len;
 		rqstp->rq_arg.page_len = 0;
+		rqstp->rq_respages = rqstp->rq_pages+1;
 	} else {
 		rqstp->rq_arg.page_len = len - rqstp->rq_arg.head[0].iov_len;
-		rqstp->rq_argused += (rqstp->rq_arg.page_len + PAGE_SIZE - 1)/ PAGE_SIZE;
+		rqstp->rq_respages = rqstp->rq_pages + 1 +
+			(rqstp->rq_arg.page_len + PAGE_SIZE - 1)/ PAGE_SIZE;
 	}
 
 	if (serv->sv_stats)
@@ -1053,11 +1057,12 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	vlen = PAGE_SIZE;
 	pnum = 1;
 	while (vlen < len) {
-		vec[pnum].iov_base = page_address(rqstp->rq_argpages[rqstp->rq_argused++]);
+		vec[pnum].iov_base = page_address(rqstp->rq_pages[pnum]);
 		vec[pnum].iov_len = PAGE_SIZE;
 		pnum++;
 		vlen += PAGE_SIZE;
 	}
+	rqstp->rq_respages = &rqstp->rq_pages[pnum];
 
 	/* Now receive data */
 	len = svc_recvfrom(rqstp, vec, pnum, len);
@@ -1209,7 +1214,7 @@ svc_recv(struct svc_rqst *rqstp, long ti
 	struct svc_sock		*svsk =NULL;
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_pool		*pool = rqstp->rq_pool;
-	int			len;
+	int			len, i;
 	int 			pages;
 	struct xdr_buf		*arg;
 	DECLARE_WAITQUEUE(wait, current);
@@ -1226,27 +1231,22 @@ svc_recv(struct svc_rqst *rqstp, long ti
 			"svc_recv: service %p, wait queue active!\n",
 			 rqstp);
 
-	/* Initialize the buffers */
-	/* first reclaim pages that were moved to response list */
-	svc_pushback_allpages(rqstp);
 
 	/* now allocate needed pages.  If we get a failure, sleep briefly */
 	pages = 2 + (serv->sv_bufsz + PAGE_SIZE -1) / PAGE_SIZE;
-	while (rqstp->rq_arghi < pages) {
-		struct page *p = alloc_page(GFP_KERNEL);
-		if (!p) {
-			schedule_timeout_uninterruptible(msecs_to_jiffies(500));
-			continue;
+	for (i=0; i < pages ; i++)
+		while (rqstp->rq_pages[i] == NULL) {
+			struct page *p = alloc_page(GFP_KERNEL);
+			if (!p)
+				schedule_timeout_uninterruptible(msecs_to_jiffies(500));
+			rqstp->rq_pages[i] = p;
 		}
-		rqstp->rq_argpages[rqstp->rq_arghi++] = p;
-	}
 
 	/* Make arg->head point to first page and arg->pages point to rest */
 	arg = &rqstp->rq_arg;
-	arg->head[0].iov_base = page_address(rqstp->rq_argpages[0]);
+	arg->head[0].iov_base = page_address(rqstp->rq_pages[0]);
 	arg->head[0].iov_len = PAGE_SIZE;
-	rqstp->rq_argused = 1;
-	arg->pages = rqstp->rq_argpages + 1;
+	arg->pages = rqstp->rq_pages + 1;
 	arg->page_base = 0;
 	/* save at least one page for response */
 	arg->page_len = (pages-2)*PAGE_SIZE;
