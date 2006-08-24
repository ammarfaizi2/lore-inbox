Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWHXPVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWHXPVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWHXPVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:21:21 -0400
Received: from pat.uio.no ([129.240.10.4]:56232 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964997AbWHXPVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:21:20 -0400
Subject: Re: [PATCH] NFS: Check lengths more thoroughly in NFS4 readdir XDR
	decode
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com, steved@redhat.com,
       linux-kernel@vger.kernel.org, nfsv4@linux-nfs.org
In-Reply-To: <32511.1156263593@warthog.cambridge.redhat.com>
References: <32511.1156263593@warthog.cambridge.redhat.com>
Content-Type: multipart/mixed; boundary="=-Hw9ZxVE3+AOsxb0Ibq02"
Date: Thu, 24 Aug 2006 11:20:59 -0400
Message-Id: <1156432859.5629.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.885, required 12,
	autolearn=disabled, AWL 0.60, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hw9ZxVE3+AOsxb0Ibq02
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-08-22 at 17:19 +0100, David Howells wrote:
> Check the bounds of length specifiers more thoroughly in the XDR decoding of
> NFS4 readdir reply data.

Hmm... Your patch fails to check for buffer overflows on the read of the
bitmap/attribute length, and on the end-of-record markers. The attached
slightly revamped patch corrects those oversights.

Cheers,
  Trond

--=-Hw9ZxVE3+AOsxb0Ibq02
Content-Disposition: inline; filename=linux-2.6.18-069-check_lengths_in_nfs4_readdir_xdr_decode.dif
Content-Type: message/rfc822; name=linux-2.6.18-069-check_lengths_in_nfs4_readdir_xdr_decode.dif

From: David Howells <dhowells@redhat.com>
NFS: Check lengths more thoroughly in NFS4 readdir XDR decode
Date: Thu, 24 Aug 2006 11:20:51 -0400
Subject: No Subject
Message-Id: <1156432851.5629.23.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

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
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/nfs4xdr.c  |   21 +++++++++++----------
 net/sunrpc/clnt.c |   11 +++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 83c90d0..3dd413f 100644
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
@@ -3377,10 +3377,10 @@ static int decode_readdir(struct xdr_str
 
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
@@ -3389,18 +3389,19 @@ static int decode_readdir(struct xdr_str
 			printk(KERN_WARNING "NFS: giant filename in readdir (len 0x%x)\n", len);
 			goto err_unmap;
 		}
-		dprintk("filename = %*s\n", len, (char *)p);
-		p += XDR_QUADLEN(len);
-		if (p + 1 > end)
+		xlen = XDR_QUADLEN(len);
+		if (end - p < xlen + 1)
 			goto short_pkt;
+		dprintk("filename = %*s\n", len, (char *)p);
+		p += xlen;
 		len = ntohl(*p++);	/* bitmap length */
-		p += len;
-		if (p + 1 > end)
+		if (end - p < len + 1)
 			goto short_pkt;
+		p += len;
 		attrlen = XDR_QUADLEN(ntohl(*p++));
-		p += attrlen;		/* attributes */
-		if (p + 2 > end)
+		if (end - p < attrlen + 2)
 			goto short_pkt;
+		p += attrlen;		/* attributes */
 		entry = p;
 	}
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 88c98ac..87efcd2 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1229,6 +1229,17 @@ call_verify(struct rpc_task *task)
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

--=-Hw9ZxVE3+AOsxb0Ibq02--

