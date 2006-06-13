Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWFMQVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWFMQVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWFMQVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:21:30 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:27088 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932158AbWFMQV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:21:29 -0400
Subject: Re: [RFC/PATCH 2/2] update sunrpc to use in-kernel sockets API
From: Sridhar Samudrala <sri@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606131006250.3553@d.namei>
References: <1150156564.19929.33.camel@w-sridhar2.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606122320010.31627@d.namei> <448E42AE.1010901@us.ibm.com>
	 <Pine.LNX.4.64.0606131006250.3553@d.namei>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 09:20:26 -0700
Message-Id: <1150215626.31720.9.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 10:07 -0400, James Morris wrote:
> On Mon, 12 Jun 2006, Sridhar Samudrala wrote:
> 
> > > > -	sendpage = sock->ops->sendpage ? : sock_no_sendpage;
> > > > +	sendpage = kernel_sendpage ? : sock_no_sendpage;
> > > >     
> > > 
> > > This is not equivalent.
> > > 
> > >   
> > Actually, we could make this a simple assignment as we check for
> > sock->ops->sendpage in
> > kernel_sendpage().
> >    sendpage = kernel_sendpage;
> 
> No, the code there is setting different values for sendpage depending on 
> whether the page is in high memory or not.

I guess you are referring to the following if stmt in xs_sendpages()
           if (PageHighMem(*ppage))
                   sendpage = sock_no_sendpage;
           err = sendpage(sock, *ppage, base, len, flags);

My patch doesn't touch this section of the code and this is called 
after the assignment we are talking about. So we should be using the
right sendpage in the actual call.

See the updated revised patch.

Thanks
Sridhar

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -388,7 +388,7 @@ svc_sendto(struct svc_rqst *rqstp, struc
 	/* send head */
 	if (slen == xdr->head[0].iov_len)
 		flags = 0;
-	len = sock->ops->sendpage(sock, rqstp->rq_respages[0], 0, xdr->head[0].iov_len, flags);
+	len = kernel_sendpage(sock, rqstp->rq_respages[0], 0, xdr->head[0].iov_len, flags);
 	if (len != xdr->head[0].iov_len)
 		goto out;
 	slen -= xdr->head[0].iov_len;
@@ -400,7 +400,7 @@ svc_sendto(struct svc_rqst *rqstp, struc
 	while (pglen > 0) {
 		if (slen == size)
 			flags = 0;
-		result = sock->ops->sendpage(sock, *ppage, base, size, flags);
+		result = kernel_sendpage(sock, *ppage, base, size, flags);
 		if (result > 0)
 			len += result;
 		if (result != size)
@@ -413,7 +413,7 @@ svc_sendto(struct svc_rqst *rqstp, struc
 	}
 	/* send tail */
 	if (xdr->tail[0].iov_len) {
-		result = sock->ops->sendpage(sock, rqstp->rq_respages[rqstp->rq_restailpage], 
+		result = kernel_sendpage(sock, rqstp->rq_respages[rqstp->rq_restailpage], 
 					     ((unsigned long)xdr->tail[0].iov_base)& (PAGE_SIZE-1),
 					     xdr->tail[0].iov_len, 0);
 
@@ -434,13 +434,10 @@ out:
 static int
 svc_recv_available(struct svc_sock *svsk)
 {
-	mm_segment_t	oldfs;
 	struct socket	*sock = svsk->sk_sock;
 	int		avail, err;
 
-	oldfs = get_fs(); set_fs(KERNEL_DS);
-	err = sock->ops->ioctl(sock, TIOCINQ, (unsigned long) &avail);
-	set_fs(oldfs);
+	err = kernel_ioctl(sock, TIOCINQ, (unsigned long) &avail);
 
 	return (err >= 0)? avail : err;
 }
@@ -472,7 +469,7 @@ svc_recvfrom(struct svc_rqst *rqstp, str
 	 * at accept time. FIXME
 	 */
 	alen = sizeof(rqstp->rq_addr);
-	sock->ops->getname(sock, (struct sockaddr *)&rqstp->rq_addr, &alen, 1);
+	kernel_getpeername(sock, (struct sockaddr *)&rqstp->rq_addr, &alen);
 
 	dprintk("svc: socket %p recvfrom(%p, %Zu) = %d\n",
 		rqstp->rq_sock, iov[0].iov_base, iov[0].iov_len, len);
@@ -758,7 +755,6 @@ svc_tcp_accept(struct svc_sock *svsk)
 	struct svc_serv	*serv = svsk->sk_server;
 	struct socket	*sock = svsk->sk_sock;
 	struct socket	*newsock;
-	const struct proto_ops *ops;
 	struct svc_sock	*newsvsk;
 	int		err, slen;
 
@@ -766,29 +762,23 @@ svc_tcp_accept(struct svc_sock *svsk)
 	if (!sock)
 		return;
 
-	err = sock_create_lite(PF_INET, SOCK_STREAM, IPPROTO_TCP, &newsock);
-	if (err) {
+	clear_bit(SK_CONN, &svsk->sk_flags);
+	err = kernel_accept(sock, &newsock, O_NONBLOCK);
+	if (err < 0) {
 		if (err == -ENOMEM)
 			printk(KERN_WARNING "%s: no more sockets!\n",
 			       serv->sv_name);
-		return;
-	}
-
-	dprintk("svc: tcp_accept %p allocated\n", newsock);
-	newsock->ops = ops = sock->ops;
-
-	clear_bit(SK_CONN, &svsk->sk_flags);
-	if ((err = ops->accept(sock, newsock, O_NONBLOCK)) < 0) {
-		if (err != -EAGAIN && net_ratelimit())
+		else if (err != -EAGAIN && net_ratelimit())
 			printk(KERN_WARNING "%s: accept failed (err %d)!\n",
 				   serv->sv_name, -err);
-		goto failed;		/* aborted connection or whatever */
+		return;
 	}
+
 	set_bit(SK_CONN, &svsk->sk_flags);
 	svc_sock_enqueue(svsk);
 
 	slen = sizeof(sin);
-	err = ops->getname(newsock, (struct sockaddr *) &sin, &slen, 1);
+	err = kernel_getpeername(newsock, (struct sockaddr *) &sin, &slen);
 	if (err < 0) {
 		if (net_ratelimit())
 			printk(KERN_WARNING "%s: peername failed (err %d)!\n",
@@ -1407,14 +1397,14 @@ svc_create_socket(struct svc_serv *serv,
 	if (sin != NULL) {
 		if (type == SOCK_STREAM)
 			sock->sk->sk_reuse = 1; /* allow address reuse */
-		error = sock->ops->bind(sock, (struct sockaddr *) sin,
+		error = kernel_bind(sock, (struct sockaddr *) sin,
 						sizeof(*sin));
 		if (error < 0)
 			goto bummer;
 	}
 
 	if (protocol == IPPROTO_TCP) {
-		if ((error = sock->ops->listen(sock, 64)) < 0)
+		if ((error = kernel_listen(sock, 64)) < 0)
 			goto bummer;
 	}
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -207,7 +207,7 @@ static inline int xs_sendpages(struct so
 		base &= ~PAGE_CACHE_MASK;
 	}
 
-	sendpage = sock->ops->sendpage ? : sock_no_sendpage;
+	sendpage = kernel_sendpage;
 	do {
 		int flags = XS_SENDMSG_FLAGS;
 
@@ -952,7 +952,7 @@ static int xs_bindresvport(struct rpc_xp
 
 	do {
 		myaddr.sin_port = htons(port);
-		err = sock->ops->bind(sock, (struct sockaddr *) &myaddr,
+		err = kernel_bind(sock, (struct sockaddr *) &myaddr,
 						sizeof(myaddr));
 		if (err == 0) {
 			xprt->port = port;
@@ -1047,7 +1047,7 @@ static void xs_tcp_reuse_connection(stru
 	 */
 	memset(&any, 0, sizeof(any));
 	any.sa_family = AF_UNSPEC;
-	result = sock->ops->connect(sock, &any, sizeof(any), 0);
+	result = kernel_connect(sock, &any, sizeof(any), 0);
 	if (result)
 		dprintk("RPC:      AF_UNSPEC connect return code %d\n",
 				result);
@@ -1117,7 +1117,7 @@ static void xs_tcp_connect_worker(void *
 	/* Tell the socket layer to start connecting... */
 	xprt->stat.connect_count++;
 	xprt->stat.connect_start = jiffies;
-	status = sock->ops->connect(sock, (struct sockaddr *) &xprt->addr,
+	status = kernel_connect(sock, (struct sockaddr *) &xprt->addr,
 			sizeof(xprt->addr), O_NONBLOCK);
 	dprintk("RPC: %p  connect status %d connected %d sock state %d\n",
 			xprt, -status, xprt_connected(xprt), sock->sk->sk_state);




