Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbTFSBEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265677AbTFSBEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:04:33 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:34492 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265676AbTFSBE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:04:29 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: davidm@hpl.hp.com
Date: Thu, 19 Jun 2003 11:41:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16113.5317.341448.162576@gargle.gargle.HOWL>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com
Subject: Re: make NFS work with 64KB page-size
In-Reply-To: message from David Mosberger on Wednesday June 18
References: <16112.60959.588900.824473@napali.hpl.hp.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday June 18, davidm@napali.hpl.hp.com wrote:
> NFS currently bugs out on kernels with a page size of 64KB.  The
> reason is a mismatch between RPCSVC_MAXPAGES and a calculation in
> svc_init_buffer().  I'm not entirely certain which calculation is the
> right one, but if I understand the code correctly, RPCSVC_MAXPAGES is
> right and svc_init_buffer() is wrong.  The patch below fixes the
> latter.

I think the +2 is right.

For read/readdir the reply can be slightly larger than the "payload",
(headers, etc) so we need one payload, plus one for the rest of the
reply, plus one to hold the request.

For write, the request can be large than the payload, so again we need
payload + 1 (for request) + 1 (for reply).

Something like the following.

NeilBrown


 ----------- Diffstat output ------------
 ./include/linux/sunrpc/svc.h |   15 +++++++++------
 ./net/sunrpc/svc.c           |    5 ++++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff ./include/linux/sunrpc/svc.h~current~ ./include/linux/sunrpc/svc.h
--- ./include/linux/sunrpc/svc.h~current~	2003-06-18 11:36:17.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2003-06-19 11:37:34.000000000 +1000
@@ -57,11 +57,11 @@ struct svc_serv {
  * Requests are copied into these pages as they arrive.  Remaining
  * pages are available to write the reply into.
  *
- * Currently pages are all re-used by the same server.  Later we 
- * will use ->sendpage to transmit pages with reduced copying.  In
- * that case we will need to give away the page and allocate new ones.
- * In preparation for this, we explicitly move pages off the recv
- * list onto the transmit list, and back.
+ * Pages are sent using ->sendpage so each server thread needs to
+ * allocate more to replace those used in sending.  To help keep track
+ * of these pages we have a recieve list where all pages initialy live,
+ * and a send list where pages are moved to when there are to be part
+ * of a reply.
  *
  * We use xdr_buf for holding responses as it fits well with NFS
  * read responses (that have a header, and some data pages, and possibly
@@ -72,8 +72,11 @@ struct svc_serv {
  * list.  xdr_buf.tail points to the end of the first page.
  * This assumes that the non-page part of an rpc reply will fit
  * in a page - NFSd ensures this.  lockd also has no trouble.
+ *
+ * Each request/reply pair can have atmost one "payload", plus two pages,
+ * one for the request, and one for the reply.
  */
-#define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE + 1)
+#define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE + 2)
 
 static inline u32 svc_getu32(struct iovec *iov)
 {

diff ./net/sunrpc/svc.c~current~ ./net/sunrpc/svc.c
--- ./net/sunrpc/svc.c~current~	2003-06-18 11:36:17.000000000 +1000
+++ ./net/sunrpc/svc.c	2003-06-19 11:38:30.000000000 +1000
@@ -113,9 +113,12 @@ svc_destroy(struct svc_serv *serv)
 static int
 svc_init_buffer(struct svc_rqst *rqstp, unsigned int size)
 {
-	int pages = 2 + (size+ PAGE_SIZE -1) / PAGE_SIZE;
+	int page;
 	int arghi;
 	
+	if (size > RPCSVC_MAXPAYLOAD)
+		size = RPCSVC_MAXPAYLOAD;
+	pages = 2 + (size+ PAGE_SIZE -1) / PAGE_SIZE;
 	rqstp->rq_argused = 0;
 	rqstp->rq_resused = 0;
 	arghi = 0;

