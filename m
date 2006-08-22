Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWHVQUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWHVQUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWHVQUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:20:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31638 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751413AbWHVQUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:20:18 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com, steved@redhat.com,
       trond.myklebust@fys.uio.no
cc: linux-kernel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: [PATCH] NFS: Check lengths more thoroughly in NFS4 readdir XDR decode
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 22 Aug 2006 17:19:53 +0100
Message-ID: <32511.1156263593@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Check the bounds of length specifiers more thoroughly in the XDR decoding of
NFS4 readdir reply data.

Currently, if the server returns a bitmap or attr length that causes the
current decode point pointer to wrap, this could go undetected (consider a
small "negative" length on a 32-bit machine).

Also add a check into the main XDR decode handler to make sure that the amount
of data is a multiple of four bytes (as specified by RFC-1014).  This makes
sure that we can do u32* pointer subtraction in the NFS client without risking
an undefined result (the result is undefined if the pointers are not correctly
aligned with respect to one another).

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/nfs4xdr.c  |   22 +++++++++++-----------
 net/sunrpc/clnt.c |   11 +++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 992a713..41a295a 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3355,7 +3355,7 @@ static int decode_readdir(struct xdr_str
 	struct kvec	*iov = rcvbuf->head;
 	unsigned int	nr, pglen = rcvbuf->page_len;
 	uint32_t	*end, *entry, *p, *kaddr;
-	uint32_t	len, attrlen;
+	uint32_t	len, attrlen, xlen;
 	int 		hdrlen, recvd, status;
 
 	status = decode_op_hdr(xdr, OP_READDIR);
@@ -3374,13 +3374,12 @@ static int decode_readdir(struct xdr_str
 	if (pglen > recvd)
 		pglen = recvd;
 	xdr_read_pages(xdr, pglen);
-
 	BUG_ON(pglen + readdir->pgbase > PAGE_CACHE_SIZE);
 	kaddr = p = (uint32_t *) kmap_atomic(page, KM_USER0);
-	end = (uint32_t *) ((char *)p + pglen + readdir->pgbase);
+	end = p + ((pglen + readdir->pgbase) >> 2);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
-		if (p + 3 > end)
+		if (end - p < 3)
 			goto short_pkt;
 		dprintk("cookie = %Lu, ", *((unsigned long long *)p));
 		p += 2;			/* cookie */
@@ -3389,18 +3388,19 @@ static int decode_readdir(struct xdr_str
 			printk(KERN_WARNING "NFS: giant filename in readdir (len 0x%x)\n", len);
 			goto err_unmap;
 		}
-		dprintk("filename = %*s\n", len, (char *)p);
-		p += XDR_QUADLEN(len);
-		if (p + 1 > end)
+		xlen = XDR_QUADLEN(len);
+		if (end - p < xlen)
 			goto short_pkt;
+		dprintk("filename = %*s\n", len, (char *)p);
+		p += xlen;
 		len = ntohl(*p++);	/* bitmap length */
-		p += len;
-		if (p + 1 > end)
+		if (end - p < len)
 			goto short_pkt;
+		p += len;
 		attrlen = XDR_QUADLEN(ntohl(*p++));
-		p += attrlen;		/* attributes */
-		if (p + 2 > end)
+		if (end - p < attrlen + 1)
 			goto short_pkt;
+		p += attrlen;		/* attributes */
 		entry = p;
 	}
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d9eac70..3e19d32 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1181,6 +1181,17 @@ call_verify(struct rpc_task *task)
 	u32	*p = iov->iov_base, n;
 	int error = -EACCES;
 
+	if ((task->tk_rqstp->rq_rcv_buf.len & 3) != 0) {
+		/* RFC-1014 says that the representation of XDR data must be a
+		 * multiple of four bytes
+		 * - if it isn't pointer subtraction in the NFS client may give
+		 *   undefined results
+		 */
+		printk(KERN_WARNING
+		       "call_verify: XDR representation not a multiple of"
+		       " 4 bytes: 0x%x\n", task->tk_rqstp->rq_rcv_buf.len);
+		goto out_eio;
+	}
 	if ((len -= 3) < 0)
 		goto out_overflow;
 	p += 1;	/* skip XID */
