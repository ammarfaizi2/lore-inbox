Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264839AbUEPWVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbUEPWVf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 18:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264838AbUEPWVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 18:21:35 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:52370 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264849AbUEPWUz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 18:20:55 -0400
Subject: Re: NFS & long symlinks = stack overflow
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Pascal Schmidt <der.eremit@email.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040516045538.GR17014@parcelfarce.linux.theplanet.co.uk>
References: <1W7yE-3lZ-13@gated-at.bofh.it> <1W7S5-3Am-13@gated-at.bofh.it>
	 <E1BP0BI-0000lo-09@localhost>
	 <20040515145306.GQ17014@parcelfarce.linux.theplanet.co.uk>
	 <1084642637.3490.29.camel@lade.trondhjem.org>
	 <Pine.LNX.4.58.0405152136380.25502@ppc970.osdl.org>
	 <20040516045538.GR17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1084746048.21654.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 16 May 2004 18:20:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 16/05/2004 klokka 00:55, skreiv
viro@parcelfarce.linux.theplanet.co.uk:
> v2 has a hard limit in protocol (<= 1Kb).  However, we shouldn't assume that
> server is sane...

True... The other thing is that we need to return ENAMETOOLONG rather
than EIO.
Finally, the NFS readlink() methods all take a buffer length argument.
Use that instead of assuming PAGE_SIZE...

OK... How about the following?

Cheers,
  Trond

 nfs2xdr.c |   11 +++++++----
 nfs3xdr.c |   11 +++++++----
 nfs4xdr.c |   11 ++++++-----
 3 files changed, 20 insertions(+), 13 deletions(-)

diff -u --recursive --new-file --show-c-function linux-2.6.6-01-reconnect/fs/nfs/nfs2xdr.c linux-2.6.6-02-symlink_overflow/fs/nfs/nfs2xdr.c
--- linux-2.6.6-01-reconnect/fs/nfs/nfs2xdr.c	2004-05-16 17:07:24.000000000 -0400
+++ linux-2.6.6-02-symlink_overflow/fs/nfs/nfs2xdr.c	2004-05-16 17:36:46.000000000 -0400
@@ -511,8 +511,8 @@ static int
 nfs_xdr_readlinkargs(struct rpc_rqst *req, u32 *p, struct nfs_readlinkargs *args)
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
+	unsigned int count = args->count - 5;
 	unsigned int replen;
-	u32 count = args->count - 4;
 
 	p = xdr_encode_fhandle(p, args->fh);
 	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
@@ -547,12 +547,15 @@ nfs_xdr_readlinkres(struct rpc_rqst *req
 	strlen = (u32*)kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len > rcvbuf->page_len) {
+		dprintk(KERN_WARNING "nfs: server returned giant symlink!\n");
+		kunmap_atomic(strlen, KM_USER0);
+		return -ENAMETOOLONG;
+	}
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
-	string[len] = 0;
+	string[len] = '\0';
 	kunmap_atomic(strlen, KM_USER0);
 	return 0;
 }
diff -u --recursive --new-file --show-c-function linux-2.6.6-01-reconnect/fs/nfs/nfs3xdr.c linux-2.6.6-02-symlink_overflow/fs/nfs/nfs3xdr.c
--- linux-2.6.6-01-reconnect/fs/nfs/nfs3xdr.c	2004-05-16 17:08:10.000000000 -0400
+++ linux-2.6.6-02-symlink_overflow/fs/nfs/nfs3xdr.c	2004-05-16 17:36:39.000000000 -0400
@@ -702,8 +702,8 @@ static int
 nfs3_xdr_readlinkargs(struct rpc_rqst *req, u32 *p, struct nfs3_readlinkargs *args)
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
+	unsigned int count = args->count - 5;
 	unsigned int replen;
-	u32 count = args->count - 4;
 
 	p = xdr_encode_fhandle(p, args->fh);
 	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
@@ -742,12 +742,15 @@ nfs3_xdr_readlinkres(struct rpc_rqst *re
 	strlen = (u32*)kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len > rcvbuf->page_len) {
+		dprintk(KERN_WARNING "nfs: server returned giant symlink!\n");
+		kunmap_atomic(strlen, KM_USER0);
+		return -ENAMETOOLONG;
+	}
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
-	string[len] = 0;
+	string[len] = '\0';
 	kunmap_atomic(strlen, KM_USER0);
 	return 0;
 }
diff -u --recursive --new-file --show-c-function linux-2.6.6-01-reconnect/fs/nfs/nfs4xdr.c linux-2.6.6-02-symlink_overflow/fs/nfs/nfs4xdr.c
--- linux-2.6.6-01-reconnect/fs/nfs/nfs4xdr.c	2004-05-16 17:08:07.000000000 -0400
+++ linux-2.6.6-02-symlink_overflow/fs/nfs/nfs4xdr.c	2004-05-16 17:36:29.000000000 -0400
@@ -947,7 +947,8 @@ static int encode_readdir(struct xdr_str
 static int encode_readlink(struct xdr_stream *xdr, const struct nfs4_readlink *readlink, struct rpc_rqst *req)
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
-	int replen;
+	unsigned int count = readlink->count - 5;
+	unsigned int replen;
 	uint32_t *p;
 
 	RESERVE_SPACE(4);
@@ -958,7 +959,7 @@ static int encode_readlink(struct xdr_st
 	 *      + OP_READLINK + status  = 7
 	 */
 	replen = (RPC_REPHDRSIZE + auth->au_rslack + 7) << 2;
-	xdr_inline_pages(&req->rq_rcv_buf, replen, readlink->pages, 0, readlink->count);
+	xdr_inline_pages(&req->rq_rcv_buf, replen, readlink->pages, 0, count);
 	
 	return 0;
 }
@@ -2921,10 +2922,10 @@ static int decode_readlink(struct xdr_st
 	 */
 	strlen = (uint32_t *) kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	len = ntohl(*strlen);
-	if (len > PAGE_CACHE_SIZE - 5) {
-		printk(KERN_WARNING "nfs: server returned giant symlink!\n");
+	if (len > rcvbuf->page_len) {
+		dprintk(KERN_WARNING "nfs: server returned giant symlink!\n");
 		kunmap_atomic(strlen, KM_USER0);
-		return -EIO;
+		return -ENAMETOOLONG;
 	}
 	*strlen = len;
 

