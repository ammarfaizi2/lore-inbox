Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263624AbUEGPWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUEGPWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUEGPWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:22:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33477 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263624AbUEGPWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:22:05 -0400
Date: Fri, 7 May 2004 11:05:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "David S. Miller" <davem@redhat.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] 1/2 sock_create_kern()
Message-ID: <Xine.LNX.4.44.0405071043540.21372-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds a function sock_create_kern() for use when the kernel 
creates sockets for its own use.

Under SELinux, and potentially other LSMs, we need to be able to
distinguish between user sockets and kernel sockets.  For SELinux
specifically, kernel sockets need to be specially labeled during creation,
then bypass access control checks (they are controlled by the kernel
itself and not subject to SELinux mediation).

This addresses a class of potential issues in SELinux where, for example, 
a TCP NFS session times out, then the kernel re-establishes an RPC 
connection upon further user activity.  We do not want such kernel 
created sockets to be labeled with user security contexts.

sock_create() and sock_create_kern() are wrapper functions, which seems 
semantically clearer to me than e.g. adding a flag to sock_create().  If 
you prefer the latter, then let me know.

The patch also adds an argument to the LSM socket creation functions
indicating whether the socket being created is a kernel socket or not.

An equivalent patch has been in testing in Fedora for several weeks
without incident.

Please apply.

 fs/cifs/connect.c           |    4 ++--
 include/linux/net.h         |    2 ++
 include/linux/security.h    |   21 +++++++++++++--------
 net/bluetooth/rfcomm/core.c |    3 ++-
 net/econet/af_econet.c      |    2 +-
 net/ipv4/icmp.c             |    4 ++--
 net/ipv4/ipvs/ip_vs_sync.c  |    4 ++--
 net/ipv4/tcp_ipv4.c         |    2 +-
 net/ipv6/icmp.c             |    4 ++--
 net/ipv6/mcast.c            |    2 +-
 net/ipv6/ndisc.c            |    2 +-
 net/netlink/netlink_dev.c   |    2 +-
 net/rxrpc/transport.c       |    2 +-
 net/sctp/protocol.c         |    4 ++--
 net/socket.c                |   18 ++++++++++++++----
 net/sunrpc/svcsock.c        |    2 +-
 net/sunrpc/xprt.c           |    2 +-
 security/dummy.c            |    5 +++--
 security/selinux/hooks.c    |   21 +++++++++++++++------
 19 files changed, 67 insertions(+), 39 deletions(-)


diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/fs/cifs/connect.c linux-2.6.6-rc3-mm2.w/fs/cifs/connect.c
--- linux-2.6.6-rc3-mm2.o/fs/cifs/connect.c	2004-05-05 11:16:19.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/fs/cifs/connect.c	2004-05-06 14:48:16.000000000 -0400
@@ -900,7 +900,7 @@
 	unsigned short int orig_port = 0;
 
 	if(*csocket == NULL) {
-		rc = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, csocket);
+		rc = sock_create_kern(PF_INET, SOCK_STREAM, IPPROTO_TCP, csocket);
 		if (rc < 0) {
 			cERROR(1, ("Error %d creating socket",rc));
 			*csocket = NULL;
@@ -1007,7 +1007,7 @@
 	int connected = 0;
 
 	if(*csocket == NULL) {
-		rc = sock_create(PF_INET6, SOCK_STREAM, IPPROTO_TCP, csocket);
+		rc = sock_create_kern(PF_INET6, SOCK_STREAM, IPPROTO_TCP, csocket);
 		if (rc < 0) {
 			cERROR(1, ("Error %d creating ipv6 socket",rc));
 			*csocket = NULL;
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/include/linux/net.h linux-2.6.6-rc3-mm2.w/include/linux/net.h
--- linux-2.6.6-rc3-mm2.o/include/linux/net.h	2004-02-04 08:39:06.000000000 -0500
+++ linux-2.6.6-rc3-mm2.w/include/linux/net.h	2004-05-06 17:25:08.440568736 -0400
@@ -149,6 +149,8 @@
 extern struct socket *sock_alloc(void);
 extern int	     sock_create(int family, int type, int proto,
 				 struct socket **res);
+extern int	     sock_create_kern(int family, int type, int proto,
+				      struct socket **res);
 extern void	     sock_release(struct socket *sock);
 extern int   	     sock_sendmsg(struct socket *sock, struct msghdr *msg,
 				  size_t len);
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/include/linux/security.h linux-2.6.6-rc3-mm2.w/include/linux/security.h
--- linux-2.6.6-rc3-mm2.o/include/linux/security.h	2004-04-29 10:03:52.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/include/linux/security.h	2004-05-06 16:06:22.000000000 -0400
@@ -680,6 +680,7 @@
  *	@family contains the requested protocol family.
  *	@type contains the requested communications type.
  *	@protocol contains the requested protocol.
+ *	@kern set to 1 if a kernel socket.
  *	Return 0 if permission is granted.
  * @socket_post_create:
  *	This hook allows a module to update or allocate a per-socket security
@@ -694,6 +695,7 @@
  *	@family contains the requested protocol family.
  *	@type contains the requested communications type.
  *	@protocol contains the requested protocol.
+ *	@kern set to 1 if a kernel socket.
  * @socket_bind:
  *	Check permission before socket protocol layer bind operation is
  *	performed and the socket @sock is bound to the address specified in the
@@ -1198,9 +1200,9 @@
 				    struct socket * other, struct sock * newsk);
 	int (*unix_may_send) (struct socket * sock, struct socket * other);
 
-	int (*socket_create) (int family, int type, int protocol);
+	int (*socket_create) (int family, int type, int protocol, int kern);
 	void (*socket_post_create) (struct socket * sock, int family,
-				    int type, int protocol);
+				    int type, int protocol, int kern);
 	int (*socket_bind) (struct socket * sock,
 			    struct sockaddr * address, int addrlen);
 	int (*socket_connect) (struct socket * sock,
@@ -2526,17 +2528,19 @@
 	return security_ops->unix_may_send(sock, other);
 }
 
-static inline int security_socket_create (int family, int type, int protocol)
+static inline int security_socket_create (int family, int type,
+					  int protocol, int kern)
 {
-	return security_ops->socket_create(family, type, protocol);
+	return security_ops->socket_create(family, type, protocol, kern);
 }
 
 static inline void security_socket_post_create(struct socket * sock, 
 					       int family,
 					       int type, 
-					       int protocol)
+					       int protocol, int kern)
 {
-	security_ops->socket_post_create(sock, family, type, protocol);
+	security_ops->socket_post_create(sock, family, type,
+					 protocol, kern);
 }
 
 static inline int security_socket_bind(struct socket * sock, 
@@ -2645,7 +2649,8 @@
 	return 0;
 }
 
-static inline int security_socket_create (int family, int type, int protocol)
+static inline int security_socket_create (int family, int type,
+					  int protocol, int kern)
 {
 	return 0;
 }
@@ -2653,7 +2658,7 @@
 static inline void security_socket_post_create(struct socket * sock, 
 					       int family,
 					       int type, 
-					       int protocol)
+					       int protocol, int kern)
 {
 }
 
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/bluetooth/rfcomm/core.c linux-2.6.6-rc3-mm2.w/net/bluetooth/rfcomm/core.c
--- linux-2.6.6-rc3-mm2.o/net/bluetooth/rfcomm/core.c	2004-04-29 10:03:52.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/bluetooth/rfcomm/core.c	2004-05-06 17:25:08.442568432 -0400
@@ -158,7 +158,8 @@
 
 	BT_DBG("");
 
-	err = sock_create(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP, sock);
+	err = sock_create_kern(PF_BLUETOOTH, SOCK_SEQPACKET,
+			       BTPROTO_L2CAP, sock);
 	if (!err) {
 		struct sock *sk = (*sock)->sk;
 		sk->sk_data_ready   = rfcomm_l2data_ready;
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/econet/af_econet.c linux-2.6.6-rc3-mm2.w/net/econet/af_econet.c
--- linux-2.6.6-rc3-mm2.o/net/econet/af_econet.c	2004-04-29 10:03:52.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/econet/af_econet.c	2004-05-06 16:05:27.000000000 -0400
@@ -976,7 +976,7 @@
 
 	/* We can count ourselves lucky Acorn machines are too dim to
 	   speak IPv6. :-) */
-	if ((error = sock_create(PF_INET, SOCK_DGRAM, 0, &udpsock)) < 0)
+	if ((error = sock_create_kern(PF_INET, SOCK_DGRAM, 0, &udpsock)) < 0)
 	{
 		printk("AUN: socket error %d\n", -error);
 		return error;
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/ipv4/icmp.c linux-2.6.6-rc3-mm2.w/net/ipv4/icmp.c
--- linux-2.6.6-rc3-mm2.o/net/ipv4/icmp.c	2004-04-29 10:03:52.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/ipv4/icmp.c	2004-05-06 14:50:55.000000000 -0400
@@ -1108,8 +1108,8 @@
 		if (!cpu_possible(i))
 			continue;
 
-		err = sock_create(PF_INET, SOCK_RAW, IPPROTO_ICMP,
-				  &per_cpu(__icmp_socket, i));
+		err = sock_create_kern(PF_INET, SOCK_RAW, IPPROTO_ICMP,
+				       &per_cpu(__icmp_socket, i));
 
 		if (err < 0)
 			panic("Failed to create the ICMP control socket.\n");
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/ipv4/ipvs/ip_vs_sync.c linux-2.6.6-rc3-mm2.w/net/ipv4/ipvs/ip_vs_sync.c
--- linux-2.6.6-rc3-mm2.o/net/ipv4/ipvs/ip_vs_sync.c	2004-03-11 09:13:23.000000000 -0500
+++ linux-2.6.6-rc3-mm2.w/net/ipv4/ipvs/ip_vs_sync.c	2004-05-06 14:50:00.000000000 -0400
@@ -480,7 +480,7 @@
 	struct socket *sock;
 
 	/* First create a socket */
-	if (sock_create(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &sock) < 0) {
+	if (sock_create_kern(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &sock) < 0) {
 		IP_VS_ERR("Error during creation of socket; terminating\n");
 		return NULL;
 	}
@@ -521,7 +521,7 @@
 	struct socket *sock;
 
 	/* First create a socket */
-	if (sock_create(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &sock) < 0) {
+	if (sock_create_kern(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &sock) < 0) {
 		IP_VS_ERR("Error during creation of socket; terminating\n");
 		return NULL;
 	}
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/ipv4/tcp_ipv4.c linux-2.6.6-rc3-mm2.w/net/ipv4/tcp_ipv4.c
--- linux-2.6.6-rc3-mm2.o/net/ipv4/tcp_ipv4.c	2004-05-05 11:16:20.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/ipv4/tcp_ipv4.c	2004-05-06 14:50:22.000000000 -0400
@@ -2609,7 +2609,7 @@
 
 void __init tcp_v4_init(struct net_proto_family *ops)
 {
-	int err = sock_create(PF_INET, SOCK_RAW, IPPROTO_TCP, &tcp_socket);
+	int err = sock_create_kern(PF_INET, SOCK_RAW, IPPROTO_TCP, &tcp_socket);
 	if (err < 0)
 		panic("Failed to create the TCP control socket.\n");
 	tcp_socket->sk->sk_allocation   = GFP_ATOMIC;
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/ipv6/icmp.c linux-2.6.6-rc3-mm2.w/net/ipv6/icmp.c
--- linux-2.6.6-rc3-mm2.o/net/ipv6/icmp.c	2004-05-05 11:16:20.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/ipv6/icmp.c	2004-05-06 15:02:34.000000000 -0400
@@ -682,8 +682,8 @@
 		if (!cpu_possible(i))
 			continue;
 
-		err = sock_create(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6,
-				  &per_cpu(__icmpv6_socket, i));
+		err = sock_create_kern(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6,
+				       &per_cpu(__icmpv6_socket, i));
 		if (err < 0) {
 			printk(KERN_ERR
 			       "Failed to initialize the ICMP6 control socket "
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/ipv6/mcast.c linux-2.6.6-rc3-mm2.w/net/ipv6/mcast.c
--- linux-2.6.6-rc3-mm2.o/net/ipv6/mcast.c	2004-04-29 10:03:53.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/ipv6/mcast.c	2004-05-06 15:03:39.000000000 -0400
@@ -2452,7 +2452,7 @@
 	struct sock *sk;
 	int err;
 
-	err = sock_create(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6, &igmp6_socket);
+	err = sock_create_kern(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6, &igmp6_socket);
 	if (err < 0) {
 		printk(KERN_ERR
 		       "Failed to initialize the IGMP6 control socket (err %d).\n",
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/ipv6/ndisc.c linux-2.6.6-rc3-mm2.w/net/ipv6/ndisc.c
--- linux-2.6.6-rc3-mm2.o/net/ipv6/ndisc.c	2004-05-05 11:16:20.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/ipv6/ndisc.c	2004-05-06 15:03:02.000000000 -0400
@@ -1443,7 +1443,7 @@
 	struct sock *sk;
         int err;
 
-	err = sock_create(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6, &ndisc_socket);
+	err = sock_create_kern(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6, &ndisc_socket);
 	if (err < 0) {
 		ND_PRINTK0(KERN_ERR
 			   "ICMPv6 NDISC: Failed to initialize the control socket (err %d).\n", 
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/netlink/netlink_dev.c linux-2.6.6-rc3-mm2.w/net/netlink/netlink_dev.c
--- linux-2.6.6-rc3-mm2.o/net/netlink/netlink_dev.c	2004-04-04 00:22:53.000000000 -0500
+++ linux-2.6.6-rc3-mm2.w/net/netlink/netlink_dev.c	2004-05-06 16:04:12.000000000 -0400
@@ -112,7 +112,7 @@
 	if (test_and_set_bit(minor, &open_map))
 		return -EBUSY;
 
-	err = sock_create(PF_NETLINK, SOCK_RAW, minor, &sock);
+	err = sock_create_kern(PF_NETLINK, SOCK_RAW, minor, &sock);
 	if (err < 0)
 		goto out;
 
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/rxrpc/transport.c linux-2.6.6-rc3-mm2.w/net/rxrpc/transport.c
--- linux-2.6.6-rc3-mm2.o/net/rxrpc/transport.c	2004-04-29 10:03:53.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/rxrpc/transport.c	2004-05-06 15:04:04.000000000 -0400
@@ -86,7 +86,7 @@
 	trans->port = port;
 
 	/* create a UDP socket to be my actual transport endpoint */
-	ret = sock_create(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &trans->socket);
+	ret = sock_create_kern(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &trans->socket);
 	if (ret < 0)
 		goto error;
 
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/sctp/protocol.c linux-2.6.6-rc3-mm2.w/net/sctp/protocol.c
--- linux-2.6.6-rc3-mm2.o/net/sctp/protocol.c	2004-04-29 10:03:53.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/sctp/protocol.c	2004-05-06 17:26:12.304859888 -0400
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
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/socket.c linux-2.6.6-rc3-mm2.w/net/socket.c
--- linux-2.6.6-rc3-mm2.o/net/socket.c	2004-05-05 11:16:20.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/socket.c	2004-05-06 17:25:08.445567976 -0400
@@ -983,8 +983,7 @@
 	return 0;
 }
 
-
-int sock_create(int family, int type, int protocol, struct socket **res)
+static int __sock_create(int family, int type, int protocol, struct socket **res, int kern)
 {
 	int i;
 	int err;
@@ -1012,7 +1011,7 @@
 		family = PF_PACKET;
 	}
 
-	err = security_socket_create(family, type, protocol);
+	err = security_socket_create(family, type, protocol, kern);
 	if (err)
 		return err;
 		
@@ -1075,7 +1074,7 @@
 	 */
 	module_put(net_families[family]->owner);
 	*res = sock;
-	security_socket_post_create(sock, family, type, protocol);
+	security_socket_post_create(sock, family, type, protocol, kern);
 
 out:
 	net_family_read_unlock();
@@ -1087,6 +1086,16 @@
 	goto out;
 }
 
+int sock_create(int family, int type, int protocol, struct socket **res)
+{
+	return __sock_create(family, type, protocol, res, 0);
+}
+
+int sock_create_kern(int family, int type, int protocol, struct socket **res)
+{
+	return __sock_create(family, type, protocol, res, 1);
+}
+
 asmlinkage long sys_socket(int family, int type, int protocol)
 {
 	int retval;
@@ -1991,6 +2000,7 @@
 EXPORT_SYMBOL(sock_alloc);
 EXPORT_SYMBOL(sock_alloc_inode);
 EXPORT_SYMBOL(sock_create);
+EXPORT_SYMBOL(sock_create_kern);
 EXPORT_SYMBOL(sock_map_fd);
 EXPORT_SYMBOL(sock_recvmsg);
 EXPORT_SYMBOL(sock_register);
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/sunrpc/svcsock.c linux-2.6.6-rc3-mm2.w/net/sunrpc/svcsock.c
--- linux-2.6.6-rc3-mm2.o/net/sunrpc/svcsock.c	2004-04-29 10:03:53.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/sunrpc/svcsock.c	2004-05-06 17:25:08.447567672 -0400
@@ -1413,7 +1413,7 @@
 	}
 	type = (protocol == IPPROTO_UDP)? SOCK_DGRAM : SOCK_STREAM;
 
-	if ((error = sock_create(PF_INET, type, protocol, &sock)) < 0)
+	if ((error = sock_create_kern(PF_INET, type, protocol, &sock)) < 0)
 		return error;
 
 	if (sin != NULL) {
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/net/sunrpc/xprt.c linux-2.6.6-rc3-mm2.w/net/sunrpc/xprt.c
--- linux-2.6.6-rc3-mm2.o/net/sunrpc/xprt.c	2004-04-29 10:03:53.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/sunrpc/xprt.c	2004-05-06 16:27:41.000000000 -0400
@@ -1567,7 +1567,7 @@
 
 	type = (proto == IPPROTO_UDP)? SOCK_DGRAM : SOCK_STREAM;
 
-	if ((err = sock_create(PF_INET, type, proto, &sock)) < 0) {
+	if ((err = sock_create_kern(PF_INET, type, proto, &sock)) < 0) {
 		printk("RPC: can't create socket (%d).\n", -err);
 		return NULL;
 	}
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/security/dummy.c linux-2.6.6-rc3-mm2.w/security/dummy.c
--- linux-2.6.6-rc3-mm2.o/security/dummy.c	2004-04-29 10:03:53.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/security/dummy.c	2004-05-06 16:06:39.000000000 -0400
@@ -750,13 +750,14 @@
 	return 0;
 }
 
-static int dummy_socket_create (int family, int type, int protocol)
+static int dummy_socket_create (int family, int type,
+				int protocol, int kern)
 {
 	return 0;
 }
 
 static void dummy_socket_post_create (struct socket *sock, int family, int type,
-				      int protocol)
+				      int protocol, int kern)
 {
 	return;
 }
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.o/security/selinux/hooks.c linux-2.6.6-rc3-mm2.w/security/selinux/hooks.c
--- linux-2.6.6-rc3-mm2.o/security/selinux/hooks.c	2004-05-05 11:16:20.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/security/selinux/hooks.c	2004-05-06 16:06:55.000000000 -0400
@@ -2889,34 +2889,43 @@
 	struct inode_security_struct *isec;
 	struct task_security_struct *tsec;
 	struct avc_audit_data ad;
-	int err;
+	int err = 0;
 
 	tsec = task->security;
 	isec = SOCK_INODE(sock)->i_security;
 
+	if (isec->sid == SECINITSID_KERNEL)
+		goto out;
+
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = sock->sk;
 	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
 			   perms, &isec->avcr, &ad);
 
+out:
 	return err;
 }
 
-static int selinux_socket_create(int family, int type, int protocol)
+static int selinux_socket_create(int family, int type,
+				 int protocol, int kern)
 {
-	int err;
+	int err = 0;
 	struct task_security_struct *tsec;
 
-	tsec = current->security;
+	if (kern)
+		goto out;
 
+	tsec = current->security;
 	err = avc_has_perm(tsec->sid, tsec->sid,
 			   socket_type_to_security_class(family, type),
 			   SOCKET__CREATE, NULL, NULL);
 
+out:
 	return err;
 }
 
-static void selinux_socket_post_create(struct socket *sock, int family, int type, int protocol)
+static void selinux_socket_post_create(struct socket *sock, int family,
+				       int type, int protocol, int kern)
 {
 	int err;
 	struct inode_security_struct *isec;
@@ -2929,7 +2938,7 @@
 
 	tsec = current->security;
 	isec->sclass = socket_type_to_security_class(family, type);
-	isec->sid = tsec->sid;
+	isec->sid = kern ? SECINITSID_KERNEL : tsec->sid;
 
 	return;
 }





