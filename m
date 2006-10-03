Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbWJCFl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbWJCFl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbWJCFl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:41:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:38806 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965257AbWJCFl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:41:57 -0400
From: Neil Brown <neilb@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Date: Tue, 3 Oct 2006 15:41:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17697.63511.32591.797058@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Banks <gnb@melbourne.sgi.com>
Subject: Re: [NFS] [PATCH 008 of 11] knfsd: Prepare knfsd for support of	rsize/wsize of up to 1MB, over TCP.
In-Reply-To: message from J. Bruce Fields on Monday October 2
References: <20060824162917.3600.patches@notabene>
	<1060824063711.5008@suse.de>
	<20060925154316.GA17465@fieldses.org>
	<17697.48800.933642.581926@cse.unsw.edu.au>
	<20061003021304.GB12867@fieldses.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 2, bfields@fieldses.org wrote:
> On Tue, Oct 03, 2006 at 11:36:32AM +1000, Neil Brown wrote:
> > The only real problem is that NFSv4 can have arbitrarily large
> > non-payload data, and arbitrarily many payloads.  But I guess any
> > client that trying to send two full-sized payloads in the one request
> > is asking for trouble (I don't suppose the RPC spells this out at
> > all?).
> 
> The RFC?

RFC, RPC, only a few pixel different :-)

  Well, it does have a "RESOURCE" error that the server can
> return for overly complicated compounds.  It doesn't give much guidance
> on when exactly that could happen, but if there's ever a clear case for
> returning NFS4ERR_RESOURCE, I think it must be the case of a client
> trying to circumvent the maximum read/write size by using multiple read
> or write operations in a single compound.

It would be nice if the RFC specified some minimum that the client
could be sure of not getting NFS4ERR_RESOURCE for, but maybe that
isn't really necessary.

> 
> There's also the check at the end of svc_tcp_recvfrom():
> 
> 	if (svsk->sk_reclen > serv->sv_bufsz) {
> 		printk(KERN_NOTICE "RPC: bad TCP reclen 0x%08lx (large)\n",
> 		       (unsigned long) svsk->sk_reclen);
> 		goto err_delete;
> 	}

Groan... and a whole lot more besides.  Thanks.
I had tried to avoid storing separate 'payload max' and 'message max'
numbers, but it doesn't seem like that is going to work, so it is time
to just give in and make it explicit.

Comments on the below?

Thanks,
NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/svc.h |    3 ++-
 ./net/sunrpc/svc.c           |   17 ++++++++++-------
 ./net/sunrpc/svcsock.c       |   28 ++++++++++++++--------------
 3 files changed, 26 insertions(+), 22 deletions(-)

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-09-29 11:44:31.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-10-03 15:26:38.000000000 +1000
@@ -57,7 +57,8 @@ struct svc_serv {
 	struct svc_stat *	sv_stats;	/* RPC statistics */
 	spinlock_t		sv_lock;
 	unsigned int		sv_nrthreads;	/* # of server threads */
-	unsigned int		sv_bufsz;	/* datagram buffer size */
+	unsigned int		sv_max_payload;	/* datagram payload size */
+	unsigned int		sv_max_mesg;	/* bufsz + 1 page for overheads */
 	unsigned int		sv_xdrsize;	/* XDR buffer size */
 
 	struct list_head	sv_permsocks;	/* all permanent sockets */

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-09-29 11:44:31.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-10-03 15:39:27.000000000 +1000
@@ -282,7 +282,8 @@ __svc_create(struct svc_program *prog, u
 	serv->sv_program   = prog;
 	serv->sv_nrthreads = 1;
 	serv->sv_stats     = prog->pg_stats;
-	serv->sv_bufsz	   = bufsize? bufsize : 4096;
+	serv->sv_max_payload = bufsize? bufsize : 4096;
+	serv->sv_max_mesg  = roundup(serv->sv_max_payload + PAGE_SIZE, PAGE_SIZE);
 	serv->sv_shutdown  = shutdown;
 	xdrsize = 0;
 	while (prog) {
@@ -414,9 +415,11 @@ svc_init_buffer(struct svc_rqst *rqstp, 
 	int pages;
 	int arghi;
 	
-	if (size > RPCSVC_MAXPAYLOAD)
-		size = RPCSVC_MAXPAYLOAD;
-	pages = 2 + (size+ PAGE_SIZE -1) / PAGE_SIZE;
+	if (size > RPCSVC_MAXPAYLOAD + PAGE_SIZE)
+		size = RPCSVC_MAXPAYLOAD + PAGE_SIZE;
+	pages = size + PAGE_SIZE; /* extra page as we hold both request and reply.
+				   * We assume one is at most one page
+				   */
 	arghi = 0;
 	BUG_ON(pages > RPCSVC_MAXPAGES);
 	while (pages) {
@@ -463,7 +466,7 @@ __svc_create_thread(svc_thread_fn func, 
 
 	if (!(rqstp->rq_argp = kmalloc(serv->sv_xdrsize, GFP_KERNEL))
 	 || !(rqstp->rq_resp = kmalloc(serv->sv_xdrsize, GFP_KERNEL))
-	 || !svc_init_buffer(rqstp, serv->sv_bufsz))
+	 || !svc_init_buffer(rqstp, serv->sv_max_mesg))
 		goto out_thread;
 
 	serv->sv_nrthreads++;
@@ -938,8 +941,8 @@ u32 svc_max_payload(const struct svc_rqs
 
 	if (rqstp->rq_sock->sk_sock->type == SOCK_DGRAM)
 		max = RPCSVC_MAXPAYLOAD_UDP;
-	if (rqstp->rq_server->sv_bufsz < max)
-		max = rqstp->rq_server->sv_bufsz;
+	if (rqstp->rq_server->sv_max_payload < max)
+		max = rqstp->rq_server->sv_max_payload;
 	return max;
 }
 EXPORT_SYMBOL_GPL(svc_max_payload);

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-09-29 11:44:33.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-10-03 15:35:08.000000000 +1000
@@ -192,13 +192,13 @@ svc_sock_enqueue(struct svc_sock *svsk)
 	svsk->sk_pool = pool;
 
 	set_bit(SOCK_NOSPACE, &svsk->sk_sock->flags);
-	if (((atomic_read(&svsk->sk_reserved) + serv->sv_bufsz)*2
+	if (((atomic_read(&svsk->sk_reserved) + serv->sv_max_mesg)*2
 	     > svc_sock_wspace(svsk))
 	    && !test_bit(SK_CLOSE, &svsk->sk_flags)
 	    && !test_bit(SK_CONN, &svsk->sk_flags)) {
 		/* Don't enqueue while not enough space for reply */
 		dprintk("svc: socket %p  no space, %d*2 > %ld, not enqueued\n",
-			svsk->sk_sk, atomic_read(&svsk->sk_reserved)+serv->sv_bufsz,
+			svsk->sk_sk, atomic_read(&svsk->sk_reserved)+serv->sv_max_mesg,
 			svc_sock_wspace(svsk));
 		svsk->sk_pool = NULL;
 		clear_bit(SK_BUSY, &svsk->sk_flags);
@@ -220,7 +220,7 @@ svc_sock_enqueue(struct svc_sock *svsk)
 				rqstp, rqstp->rq_sock);
 		rqstp->rq_sock = svsk;
 		atomic_inc(&svsk->sk_inuse);
-		rqstp->rq_reserved = serv->sv_bufsz;
+		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &svsk->sk_reserved);
 		BUG_ON(svsk->sk_pool != pool);
 		wake_up(&rqstp->rq_wait);
@@ -639,8 +639,8 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 	     * which will access the socket.
 	     */
 	    svc_sock_setbufsize(svsk->sk_sock,
-				(serv->sv_nrthreads+3) * serv->sv_bufsz,
-				(serv->sv_nrthreads+3) * serv->sv_bufsz);
+				(serv->sv_nrthreads+3) * serv->sv_max_mesg,
+				(serv->sv_nrthreads+3) * serv->sv_max_mesg);
 
 	if ((rqstp->rq_deferred = svc_deferred_dequeue(svsk))) {
 		svc_sock_received(svsk);
@@ -749,8 +749,8 @@ svc_udp_init(struct svc_sock *svsk)
 	 * svc_udp_recvfrom will re-adjust if necessary
 	 */
 	svc_sock_setbufsize(svsk->sk_sock,
-			    3 * svsk->sk_server->sv_bufsz,
-			    3 * svsk->sk_server->sv_bufsz);
+			    3 * svsk->sk_server->sv_max_mesg,
+			    3 * svsk->sk_server->sv_max_mesg);
 
 	set_bit(SK_DATA, &svsk->sk_flags); /* might have come in before data_ready set up */
 	set_bit(SK_CHNGBUF, &svsk->sk_flags);
@@ -993,8 +993,8 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		 * as soon a a complete request arrives.
 		 */
 		svc_sock_setbufsize(svsk->sk_sock,
-				    (serv->sv_nrthreads+3) * serv->sv_bufsz,
-				    3 * serv->sv_bufsz);
+				    (serv->sv_nrthreads+3) * serv->sv_max_mesg,
+				    3 * serv->sv_max_mesg);
 
 	clear_bit(SK_DATA, &svsk->sk_flags);
 
@@ -1032,7 +1032,7 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		}
 		svsk->sk_reclen &= 0x7fffffff;
 		dprintk("svc: TCP record, %d bytes\n", svsk->sk_reclen);
-		if (svsk->sk_reclen > serv->sv_bufsz) {
+		if (svsk->sk_reclen > serv->sv_max_mesg) {
 			printk(KERN_NOTICE "RPC: bad TCP reclen 0x%08lx (large)\n",
 			       (unsigned long) svsk->sk_reclen);
 			goto err_delete;
@@ -1171,8 +1171,8 @@ svc_tcp_init(struct svc_sock *svsk)
 		 * svc_tcp_recvfrom will re-adjust if necessary
 		 */
 		svc_sock_setbufsize(svsk->sk_sock,
-				    3 * svsk->sk_server->sv_bufsz,
-				    3 * svsk->sk_server->sv_bufsz);
+				    3 * svsk->sk_server->sv_max_mesg,
+				    3 * svsk->sk_server->sv_max_mesg);
 
 		set_bit(SK_CHNGBUF, &svsk->sk_flags);
 		set_bit(SK_DATA, &svsk->sk_flags);
@@ -1234,7 +1234,7 @@ svc_recv(struct svc_rqst *rqstp, long ti
 
 
 	/* now allocate needed pages.  If we get a failure, sleep briefly */
-	pages = 2 + (serv->sv_bufsz + PAGE_SIZE -1) / PAGE_SIZE;
+	pages = (serv->sv_max_mesg + PAGE_SIZE) / PAGE_SIZE;
 	for (i=0; i < pages ; i++)
 		while (rqstp->rq_pages[i] == NULL) {
 			struct page *p = alloc_page(GFP_KERNEL);
@@ -1263,7 +1263,7 @@ svc_recv(struct svc_rqst *rqstp, long ti
 	if ((svsk = svc_sock_dequeue(pool)) != NULL) {
 		rqstp->rq_sock = svsk;
 		atomic_inc(&svsk->sk_inuse);
-		rqstp->rq_reserved = serv->sv_bufsz;	
+		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &svsk->sk_reserved);
 	} else {
 		/* No data pending. Go to sleep */
