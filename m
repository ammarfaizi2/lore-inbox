Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUEGU1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUEGU1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUEGU0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:26:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13717 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263761AbUEGUR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:17:28 -0400
Date: Fri, 7 May 2004 15:53:30 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][SELINUX] 2/2 sock_create_lite()
In-Reply-To: <Xine.LNX.4.44.0405071118490.21529-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0405071531480.22499-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004, James Morris wrote:

> On Fri, 7 May 2004, Christoph Hellwig wrote:
> 
> > On Fri, May 07, 2004 at 11:06:04AM -0400, James Morris wrote:
> > > This patch adds a function sock_create_lite(), deprecating kernel-wide use
> > > of sock_alloc(), which has been made static to net/socket.c.
> > 
> > We're in the stable series and removing exported APIs there shoudn't happen.
> > Given that sock_alloc() is actually okay for every normal use I don't think
> > there's enough reason to remove it from the API.
> 


Ok, here's a version of this patch which doesn't do anything with 
sock_alloc().


diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/include/linux/net.h linux-2.6.6-rc3-mm2.w/include/linux/net.h
--- linux-2.6.6-rc3-mm2.p/include/linux/net.h	2004-05-06 16:59:28.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/include/linux/net.h	2004-05-07 13:57:47.669957104 -0400
@@ -151,6 +151,8 @@
 				 struct socket **res);
 extern int	     sock_create_kern(int family, int type, int proto,
 				      struct socket **res);
+extern int	     sock_create_lite(int family, int type, int proto,
+				      struct socket **res); 
 extern void	     sock_release(struct socket *sock);
 extern int   	     sock_sendmsg(struct socket *sock, struct msghdr *msg,
 				  size_t len);
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/net/bluetooth/rfcomm/core.c linux-2.6.6-rc3-mm2.w/net/bluetooth/rfcomm/core.c
--- linux-2.6.6-rc3-mm2.p/net/bluetooth/rfcomm/core.c	2004-05-06 16:59:28.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/bluetooth/rfcomm/core.c	2004-05-07 13:56:02.770904184 -0400
@@ -1642,11 +1642,9 @@
 
 	BT_DBG("session %p", s);
 
-	nsock = sock_alloc();
-	if (!nsock)
+	if (sock_create_lite(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP, &nsock))
 		return;
-
-	nsock->type = sock->type;
+	
 	nsock->ops  = sock->ops;
 
 	__module_get(nsock->ops->owner);
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/net/netlink/af_netlink.c linux-2.6.6-rc3-mm2.w/net/netlink/af_netlink.c
--- linux-2.6.6-rc3-mm2.p/net/netlink/af_netlink.c	2004-05-05 11:16:20.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/netlink/af_netlink.c	2004-05-07 13:56:02.771904032 -0400
@@ -833,11 +833,9 @@
 	if (unit<0 || unit>=MAX_LINKS)
 		return NULL;
 
-	if (!(sock = sock_alloc())) 
+	if (sock_create_lite(PF_NETLINK, SOCK_DGRAM, unit, &sock))
 		return NULL;
 
-	sock->type = SOCK_RAW;
-
 	if (netlink_create(sock, unit) < 0) {
 		sock_release(sock);
 		return NULL;
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/net/sctp/protocol.c linux-2.6.6-rc3-mm2.w/net/sctp/protocol.c
--- linux-2.6.6-rc3-mm2.p/net/sctp/protocol.c	2004-04-29 10:03:53.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/sctp/protocol.c	2004-05-06 17:26:12.000000000 -0400
@@ -653,8 +653,8 @@
 	else
 		family = PF_INET;
 
-	err = sock_create(family, SOCK_SEQPACKET, IPPROTO_SCTP,
-			  &sctp_ctl_socket);
+	err = sock_create_kern(family, SOCK_SEQPACKET, IPPROTO_SCTP,
+			       &sctp_ctl_socket);
 	if (err < 0) {
 		printk(KERN_ERR
 		       "SCTP: Failed to create the SCTP control socket.\n");
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/net/socket.c linux-2.6.6-rc3-mm2.w/net/socket.c
--- linux-2.6.6-rc3-mm2.p/net/socket.c	2004-05-06 16:59:28.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/socket.c	2004-05-07 13:57:40.429057888 -0400
@@ -457,7 +457,7 @@
  *	NULL is returned.
  */
 
-struct socket *sock_alloc(void)
+static struct socket *sock_alloc(void)
 {
 	struct inode * inode;
 	struct socket * sock;
@@ -840,6 +840,27 @@
 	return err;
 }
 
+int sock_create_lite(int family, int type, int protocol, struct socket **res)
+{
+	int err;
+	struct socket *sock = NULL;
+	
+	err = security_socket_create(family, type, protocol, 1);
+	if (err)
+		goto out;
+
+	sock = sock_alloc();
+	if (!sock) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	security_socket_post_create(sock, family, type, protocol, 1);
+	sock->type = type;
+out:
+	*res = sock;
+	return err;
+}
 
 /* No kernel lock held - perfect */
 static unsigned int sock_poll(struct file *file, poll_table * wait)
@@ -2001,6 +2022,7 @@
 EXPORT_SYMBOL(sock_alloc_inode);
 EXPORT_SYMBOL(sock_create);
 EXPORT_SYMBOL(sock_create_kern);
+EXPORT_SYMBOL(sock_create_lite);
 EXPORT_SYMBOL(sock_map_fd);
 EXPORT_SYMBOL(sock_recvmsg);
 EXPORT_SYMBOL(sock_register);
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/net/sunrpc/svcsock.c linux-2.6.6-rc3-mm2.w/net/sunrpc/svcsock.c
--- linux-2.6.6-rc3-mm2.p/net/sunrpc/svcsock.c	2004-05-06 16:59:28.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/sunrpc/svcsock.c	2004-05-07 13:56:02.775903424 -0400
@@ -781,13 +781,15 @@
 	if (!sock)
 		return;
 
-	if (!(newsock = sock_alloc())) {
-		printk(KERN_WARNING "%s: no more sockets!\n", serv->sv_name);
+	err = sock_create_lite(PF_INET, SOCK_STREAM, IPPROTO_TCP, &newsock);
+	if (err) {
+		if (err == -ENOMEM)
+			printk(KERN_WARNING "%s: no more sockets!\n",
+			       serv->sv_name);
 		return;
 	}
-	dprintk("svc: tcp_accept %p allocated\n", newsock);
 
-	newsock->type = sock->type;
+	dprintk("svc: tcp_accept %p allocated\n", newsock);
 	newsock->ops = ops = sock->ops;
 
 	clear_bit(SK_CONN, &svsk->sk_flags);

