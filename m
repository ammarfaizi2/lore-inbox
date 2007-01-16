Return-Path: <linux-kernel-owner+w=401wt.eu-S1751411AbXAPCiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbXAPCiB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXAPCiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:38:01 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:28259 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751363AbXAPChy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:37:54 -0500
From: Nate Diller <nate@agami.com>
To: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Date: Mon, 15 Jan 2007 17:54:50 -0800
Message-Id: <20070116015450.9764.24404.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 2/10][RFC] aio: net use struct socket for io
X-OriginalArrivalTime: 16 Jan 2007 01:55:01.0066 (UTC) FILETIME=[553D5AA0:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused arg from socket operations

The sendmsg and recvmsg socket operations take a kiocb pointer, but none of
the functions actually use it.  There's really no need even theoretically,
it's really quite ugly having it there at all.  Also, removing it will pave
the way for a more generic completion path in the file_operations.

---

 drivers/net/pppoe.c               |    8 +++----
 include/linux/net.h               |   18 +++++++----------
 include/net/bluetooth/bluetooth.h |    2 -
 include/net/inet_common.h         |    3 --
 include/net/sock.h                |   19 ++++++++----------
 include/net/tcp.h                 |    6 ++---
 include/net/udp.h                 |    3 --
 net/appletalk/ddp.c               |    5 +---
 net/atm/common.c                  |    6 +----
 net/atm/common.h                  |    7 ++----
 net/ax25/af_ax25.c                |    7 ++----
 net/bluetooth/af_bluetooth.c      |    4 +--
 net/bluetooth/hci_sock.c          |    7 ++----
 net/bluetooth/l2cap.c             |    2 -
 net/bluetooth/rfcomm/sock.c       |    8 +++----
 net/bluetooth/sco.c               |    3 --
 net/core/sock.c                   |   12 ++++-------
 net/dccp/dccp.h                   |    8 +++----
 net/dccp/probe.c                  |    3 --
 net/dccp/proto.c                  |    7 ++----
 net/decnet/af_decnet.c            |    7 ++----
 net/econet/af_econet.c            |    7 ++----
 net/ipv4/af_inet.c                |    5 +---
 net/ipv4/raw.c                    |    8 ++-----
 net/ipv4/tcp.c                    |    7 ++----
 net/ipv4/tcp_probe.c              |    3 --
 net/ipv4/udp.c                    |    9 +++-----
 net/ipv4/udp_impl.h               |    2 -
 net/ipv6/raw.c                    |    6 +----
 net/ipv6/udp.c                    |   10 +++------
 net/ipv6/udp_impl.h               |    6 +----
 net/ipx/af_ipx.c                  |    7 ++----
 net/irda/af_irda.c                |   29 +++++++++++++---------------
 net/key/af_key.c                  |    6 +----
 net/llc/af_llc.c                  |    7 ++----
 net/netlink/af_netlink.c          |    6 +----
 net/netrom/af_netrom.c            |    7 ++----
 net/packet/af_packet.c            |   11 ++++------
 net/rose/af_rose.c                |    7 ++----
 net/sctp/socket.c                 |    9 +++-----
 net/socket.c                      |   32 ++++++-------------------------
 net/tipc/socket.c                 |   28 +++++++++------------------
 net/unix/af_unix.c                |   39 +++++++++++++++-----------------------
 net/wanrouter/af_wanpipe.c        |    7 ++----
 net/x25/af_x25.c                  |    6 +----
 45 files changed, 166 insertions(+), 243 deletions(-)

---

diff -urpN -X dontdiff a/drivers/net/pppoe.c b/drivers/net/pppoe.c
--- a/drivers/net/pppoe.c	2007-01-12 11:18:47.244855016 -0800
+++ b/drivers/net/pppoe.c	2007-01-12 11:29:21.179177108 -0800
@@ -746,8 +746,8 @@ static int pppoe_ioctl(struct socket *so
 }
 
 
-static int pppoe_sendmsg(struct kiocb *iocb, struct socket *sock,
-		  struct msghdr *m, size_t total_len)
+static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
+			 size_t total_len)
 {
 	struct sk_buff *skb = NULL;
 	struct sock *sk = sock->sk;
@@ -912,8 +912,8 @@ static struct ppp_channel_ops pppoe_chan
 	.start_xmit = pppoe_xmit,
 };
 
-static int pppoe_recvmsg(struct kiocb *iocb, struct socket *sock,
-		  struct msghdr *m, size_t total_len, int flags)
+static int pppoe_recvmsg(struct socket *sock, struct msghdr *m,
+			 size_t total_len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb = NULL;
diff -urpN -X dontdiff a/include/linux/net.h b/include/linux/net.h
--- a/include/linux/net.h	2007-01-12 11:18:56.683629587 -0800
+++ b/include/linux/net.h	2007-01-12 11:29:21.185175058 -0800
@@ -118,7 +118,6 @@ struct socket {
 
 struct vm_area_struct;
 struct page;
-struct kiocb;
 struct sockaddr;
 struct msghdr;
 struct module;
@@ -156,11 +155,10 @@ struct proto_ops {
 				      int optname, char __user *optval, int optlen);
 	int		(*compat_getsockopt)(struct socket *sock, int level,
 				      int optname, char __user *optval, int __user *optlen);
-	int		(*sendmsg)   (struct kiocb *iocb, struct socket *sock,
-				      struct msghdr *m, size_t total_len);
-	int		(*recvmsg)   (struct kiocb *iocb, struct socket *sock,
-				      struct msghdr *m, size_t total_len,
-				      int flags);
+	int		(*sendmsg)   (struct socket *sock, struct msghdr *m,
+				      size_t total_len);
+	int		(*recvmsg)   (struct socket *sock, struct msghdr *m,
+				      size_t total_len, int flags);
 	int		(*mmap)	     (struct file *file, struct socket *sock,
 				      struct vm_area_struct * vma);
 	ssize_t		(*sendpage)  (struct socket *sock, struct page *page,
@@ -276,10 +274,10 @@ SOCKCALL_WRAP(name, setsockopt, (struct 
 			 char __user *optval, int optlen), (sock, level, optname, optval, optlen)) \
 SOCKCALL_WRAP(name, getsockopt, (struct socket *sock, int level, int optname, \
 			 char __user *optval, int __user *optlen), (sock, level, optname, optval, optlen)) \
-SOCKCALL_WRAP(name, sendmsg, (struct kiocb *iocb, struct socket *sock, struct msghdr *m, size_t len), \
-	      (iocb, sock, m, len)) \
-SOCKCALL_WRAP(name, recvmsg, (struct kiocb *iocb, struct socket *sock, struct msghdr *m, size_t len, int flags), \
-	      (iocb, sock, m, len, flags)) \
+SOCKCALL_WRAP(name, sendmsg, (struct socket *sock, struct msghdr *m, size_t len), \
+	      (sock, m, len)) \
+SOCKCALL_WRAP(name, recvmsg, (struct socket *sock, struct msghdr *m, size_t len, int flags), \
+	      (sock, m, len, flags)) \
 SOCKCALL_WRAP(name, mmap, (struct file *file, struct socket *sock, struct vm_area_struct *vma), \
 	      (file, sock, vma)) \
 	      \
diff -urpN -X dontdiff a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
--- a/include/net/bluetooth/bluetooth.h	2006-11-29 13:57:37.000000000 -0800
+++ b/include/net/bluetooth/bluetooth.h	2007-01-12 11:29:21.191173008 -0800
@@ -119,7 +119,7 @@ int  bt_sock_register(int proto, struct 
 int  bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
-int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
+int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len, int flags);
 uint bt_sock_poll(struct file * file, struct socket *sock, poll_table *wait);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 
diff -urpN -X dontdiff a/include/net/inet_common.h b/include/net/inet_common.h
--- a/include/net/inet_common.h	2006-11-29 13:57:37.000000000 -0800
+++ b/include/net/inet_common.h	2007-01-12 11:29:21.196171300 -0800
@@ -25,8 +25,7 @@ extern int			inet_dgram_connect(struct s
 						   int addr_len, int flags);
 extern int			inet_accept(struct socket *sock, 
 					    struct socket *newsock, int flags);
-extern int			inet_sendmsg(struct kiocb *iocb,
-					     struct socket *sock, 
+extern int			inet_sendmsg(struct socket *sock, 
 					     struct msghdr *msg, 
 					     size_t size);
 extern int			inet_shutdown(struct socket *sock, int how);
diff -urpN -X dontdiff a/include/net/sock.h b/include/net/sock.h
--- a/include/net/sock.h	2007-01-12 11:28:23.510888256 -0800
+++ b/include/net/sock.h	2007-01-12 11:29:21.201169591 -0800
@@ -535,10 +535,9 @@ struct proto {
 					int level,
 					int optname, char __user *optval,
 					int __user *option);
-	int			(*sendmsg)(struct kiocb *iocb, struct sock *sk,
-					   struct msghdr *msg, size_t len);
-	int			(*recvmsg)(struct kiocb *iocb, struct sock *sk,
-					   struct msghdr *msg,
+	int			(*sendmsg)(struct sock *sk, struct msghdr *msg,
+					size_t len);
+	int			(*recvmsg)(struct sock *sk, struct msghdr *msg,
 					size_t len, int noblock, int flags, 
 					int *addr_len);
 	int			(*sendpage)(struct sock *sk, struct page *page,
@@ -813,10 +812,10 @@ extern int			sock_no_getsockopt(struct s
 						   char __user *, int __user *);
 extern int			sock_no_setsockopt(struct socket *, int, int,
 						   char __user *, int);
-extern int                      sock_no_sendmsg(struct kiocb *, struct socket *,
-						struct msghdr *, size_t);
-extern int                      sock_no_recvmsg(struct kiocb *, struct socket *,
-						struct msghdr *, size_t, int);
+extern int                      sock_no_sendmsg(struct socket *, struct msghdr *,
+						size_t);
+extern int                      sock_no_recvmsg(struct socket *, struct msghdr *,
+						size_t, int);
 extern int			sock_no_mmap(struct file *file,
 					     struct socket *sock,
 					     struct vm_area_struct *vma);
@@ -831,8 +830,8 @@ extern ssize_t			sock_no_sendpage(struct
  */
 extern int sock_common_getsockopt(struct socket *sock, int level, int optname,
 				  char __user *optval, int __user *optlen);
-extern int sock_common_recvmsg(struct kiocb *iocb, struct socket *sock,
-			       struct msghdr *msg, size_t size, int flags);
+extern int sock_common_recvmsg(struct socket *sock, struct msghdr *msg,
+				size_t size, int flags);
 extern int sock_common_setsockopt(struct socket *sock, int level, int optname,
 				  char __user *optval, int optlen);
 extern int compat_sock_common_getsockopt(struct socket *sock, int level,
diff -urpN -X dontdiff a/include/net/tcp.h b/include/net/tcp.h
--- a/include/net/tcp.h	2007-01-12 11:18:57.743267486 -0800
+++ b/include/net/tcp.h	2007-01-12 11:29:21.206167883 -0800
@@ -273,8 +273,8 @@ extern int			tcp_v4_remember_stamp(struc
 
 extern int		    	tcp_v4_tw_remember_stamp(struct inet_timewait_sock *tw);
 
-extern int			tcp_sendmsg(struct kiocb *iocb, struct sock *sk,
-					    struct msghdr *msg, size_t size);
+extern int			tcp_sendmsg(struct sock *sk, struct msghdr *msg,
+					    size_t size);
 extern ssize_t			tcp_sendpage(struct socket *sock, struct page *page, int offset, size_t size, int flags);
 
 extern int			tcp_ioctl(struct sock *sk, 
@@ -364,7 +364,7 @@ extern int			compat_tcp_setsockopt(struc
 					int level, int optname,
 					char __user *optval, int optlen);
 extern void			tcp_set_keepalive(struct sock *sk, int val);
-extern int			tcp_recvmsg(struct kiocb *iocb, struct sock *sk,
+extern int			tcp_recvmsg(struct sock *sk,
 					    struct msghdr *msg,
 					    size_t len, int nonblock, 
 					    int flags, int *addr_len);
diff -urpN -X dontdiff a/include/net/udp.h b/include/net/udp.h
--- a/include/net/udp.h	2007-01-12 11:18:57.766259629 -0800
+++ b/include/net/udp.h	2007-01-12 11:29:21.210166516 -0800
@@ -127,8 +127,7 @@ extern int	udp_get_port(struct sock *sk,
 			     int (*saddr_cmp)(const struct sock *, const struct sock *));
 extern void	udp_err(struct sk_buff *, u32);
 
-extern int	udp_sendmsg(struct kiocb *iocb, struct sock *sk,
-			    struct msghdr *msg, size_t len);
+extern int	udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
 
 extern int	udp_rcv(struct sk_buff *skb);
 extern int	udp_ioctl(struct sock *sk, int cmd, unsigned long arg);
diff -urpN -X dontdiff a/net/appletalk/ddp.c b/net/appletalk/ddp.c
--- a/net/appletalk/ddp.c	2007-01-12 11:18:58.625965849 -0800
+++ b/net/appletalk/ddp.c	2007-01-12 11:29:21.215164808 -0800
@@ -1527,8 +1527,7 @@ freeit:
 	return 0;
 }
 
-static int atalk_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg,
-			 size_t len)
+static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct atalk_sock *at = at_sk(sk);
@@ -1688,7 +1687,7 @@ static int atalk_sendmsg(struct kiocb *i
 	return len;
 }
 
-static int atalk_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg,
+static int atalk_recvmsg(struct socket *sock, struct msghdr *msg,
 			 size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
diff -urpN -X dontdiff a/net/atm/common.c b/net/atm/common.c
--- a/net/atm/common.c	2007-01-12 11:19:49.454595039 -0800
+++ b/net/atm/common.c	2007-01-12 11:29:21.220163099 -0800
@@ -472,8 +472,7 @@ int vcc_connect(struct socket *sock, int
 }
 
 
-int vcc_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg,
-		size_t size, int flags)
+int vcc_recvmsg(struct socket *sock, struct msghdr *msg, size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct atm_vcc *vcc;
@@ -511,8 +510,7 @@ int vcc_recvmsg(struct kiocb *iocb, stru
 }
 
 
-int vcc_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m,
-		size_t total_len)
+int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 {
 	struct sock *sk = sock->sk;
 	DEFINE_WAIT(wait);
diff -urpN -X dontdiff a/net/atm/common.h b/net/atm/common.h
--- a/net/atm/common.h	2006-11-29 13:57:37.000000000 -0800
+++ b/net/atm/common.h	2007-01-12 11:29:21.224161733 -0800
@@ -13,10 +13,9 @@
 int vcc_create(struct socket *sock, int protocol, int family);
 int vcc_release(struct socket *sock);
 int vcc_connect(struct socket *sock, int itf, short vpi, int vci);
-int vcc_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg,
-		size_t size, int flags);
-int vcc_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m,
-		size_t total_len);
+int vcc_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
+		int flags);
+int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len);
 unsigned int vcc_poll(struct file *file, struct socket *sock, poll_table *wait);
 int vcc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int vcc_setsockopt(struct socket *sock, int level, int optname,
diff -urpN -X dontdiff a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
--- a/net/ax25/af_ax25.c	2007-01-12 11:18:58.769916658 -0800
+++ b/net/ax25/af_ax25.c	2007-01-12 11:29:21.229160024 -0800
@@ -1417,8 +1417,7 @@ out:
 	return err;
 }
 
-static int ax25_sendmsg(struct kiocb *iocb, struct socket *sock,
-			struct msghdr *msg, size_t len)
+static int ax25_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sockaddr_ax25 *usax = (struct sockaddr_ax25 *)msg->msg_name;
 	struct sock *sk = sock->sk;
@@ -1604,8 +1603,8 @@ out:
 	return err;
 }
 
-static int ax25_recvmsg(struct kiocb *iocb, struct socket *sock,
-	struct msghdr *msg, size_t size, int flags)
+static int ax25_recvmsg(struct socket *sock, struct msghdr *msg,
+			size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
diff -urpN -X dontdiff a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
--- a/net/bluetooth/af_bluetooth.c	2006-11-29 13:57:37.000000000 -0800
+++ b/net/bluetooth/af_bluetooth.c	2007-01-12 11:29:21.234158316 -0800
@@ -193,8 +193,8 @@ struct sock *bt_accept_dequeue(struct so
 }
 EXPORT_SYMBOL(bt_accept_dequeue);
 
-int bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-	struct msghdr *msg, size_t len, int flags)
+int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+		    size_t len, int flags)
 {
 	int noblock = flags & MSG_DONTWAIT;
 	struct sock *sk = sock->sk;
diff -urpN -X dontdiff a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
--- a/net/bluetooth/hci_sock.c	2007-01-12 11:19:49.548562920 -0800
+++ b/net/bluetooth/hci_sock.c	2007-01-12 11:29:21.238156949 -0800
@@ -348,8 +348,8 @@ static inline void hci_sock_cmsg(struct 
 	}
 }
  
-static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock, 
-				struct msghdr *msg, size_t len, int flags)
+static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+			    size_t len, int flags)
 {
 	int noblock = flags & MSG_DONTWAIT;
 	struct sock *sk = sock->sk;
@@ -385,8 +385,7 @@ static int hci_sock_recvmsg(struct kiocb
 	return err ? : copied;
 }
 
-static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock, 
-			    struct msghdr *msg, size_t len)
+static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev;
diff -urpN -X dontdiff a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
--- a/net/bluetooth/l2cap.c	2007-01-12 11:18:58.824897870 -0800
+++ b/net/bluetooth/l2cap.c	2007-01-12 11:29:21.243155241 -0800
@@ -906,7 +906,7 @@ fail:
 	return err;
 }
 
-static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
+static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
diff -urpN -X dontdiff a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
--- a/net/bluetooth/rfcomm/sock.c	2007-01-12 11:19:49.562558136 -0800
+++ b/net/bluetooth/rfcomm/sock.c	2007-01-12 11:29:21.250152849 -0800
@@ -551,8 +551,8 @@ static int rfcomm_sock_getname(struct so
 	return 0;
 }
 
-static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
-			       struct msghdr *msg, size_t len)
+static int rfcomm_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+			       size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
@@ -631,8 +631,8 @@ static long rfcomm_sock_data_wait(struct
 	return timeo;
 }
 
-static int rfcomm_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-			       struct msghdr *msg, size_t size, int flags)
+static int rfcomm_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+			       size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
diff -urpN -X dontdiff a/net/bluetooth/sco.c b/net/bluetooth/sco.c
--- a/net/bluetooth/sco.c	2006-11-29 13:57:37.000000000 -0800
+++ b/net/bluetooth/sco.c	2007-01-12 11:29:21.268146698 -0800
@@ -627,8 +627,7 @@ static int sco_sock_getname(struct socke
 	return 0;
 }
 
-static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock, 
-			    struct msghdr *msg, size_t len)
+static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
diff -urpN -X dontdiff a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c	2007-01-12 11:18:59.001837406 -0800
+++ b/net/core/sock.c	2007-01-12 11:29:21.274144648 -0800
@@ -1352,14 +1352,12 @@ int sock_no_getsockopt(struct socket *so
 	return -EOPNOTSUPP;
 }
 
-int sock_no_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m,
-		    size_t len)
+int sock_no_sendmsg(struct socket *sock, struct msghdr *m, size_t len)
 {
 	return -EOPNOTSUPP;
 }
 
-int sock_no_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m,
-		    size_t len, int flags)
+int sock_no_recvmsg(struct socket *sock, struct msghdr *m, size_t len, int flags)
 {
 	return -EOPNOTSUPP;
 }
@@ -1605,14 +1603,14 @@ int compat_sock_common_getsockopt(struct
 EXPORT_SYMBOL(compat_sock_common_getsockopt);
 #endif
 
-int sock_common_recvmsg(struct kiocb *iocb, struct socket *sock,
-			struct msghdr *msg, size_t size, int flags)
+int sock_common_recvmsg(struct socket *sock, struct msghdr *msg,
+			size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	int addr_len = 0;
 	int err;
 
-	err = sk->sk_prot->recvmsg(iocb, sk, msg, size, flags & MSG_DONTWAIT,
+	err = sk->sk_prot->recvmsg(sk, msg, size, flags & MSG_DONTWAIT,
 				   flags & ~MSG_DONTWAIT, &addr_len);
 	if (err >= 0)
 		msg->msg_namelen = addr_len;
diff -urpN -X dontdiff a/net/dccp/dccp.h b/net/dccp/dccp.h
--- a/net/dccp/dccp.h	2007-01-12 11:18:59.097804612 -0800
+++ b/net/dccp/dccp.h	2007-01-12 11:29:21.278143282 -0800
@@ -257,10 +257,10 @@ extern int	   compat_dccp_setsockopt(str
 				char __user *optval, int optlen);
 #endif
 extern int	   dccp_ioctl(struct sock *sk, int cmd, unsigned long arg);
-extern int	   dccp_sendmsg(struct kiocb *iocb, struct sock *sk,
-				struct msghdr *msg, size_t size);
-extern int	   dccp_recvmsg(struct kiocb *iocb, struct sock *sk,
-				struct msghdr *msg, size_t len, int nonblock,
+extern int	   dccp_sendmsg(struct sock *sk, struct msghdr *msg,
+				size_t size);
+extern int	   dccp_recvmsg(struct sock *sk, struct msghdr *msg,
+				size_t len, int nonblock,
 				int flags, int *addr_len);
 extern void	   dccp_shutdown(struct sock *sk, int how);
 extern int	   inet_dccp_listen(struct socket *sock, int backlog);
diff -urpN -X dontdiff a/net/dccp/probe.c b/net/dccp/probe.c
--- a/net/dccp/probe.c	2007-01-12 11:18:59.137790948 -0800
+++ b/net/dccp/probe.c	2007-01-12 11:29:21.282141915 -0800
@@ -75,8 +75,7 @@ static void printl(const char *fmt, ...)
 	wake_up(&dccpw.wait);
 }
 
-static int jdccp_sendmsg(struct kiocb *iocb, struct sock *sk,
-			 struct msghdr *msg, size_t size)
+static int jdccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	const struct dccp_minisock *dmsk = dccp_msk(sk);
 	const struct inet_sock *inet = inet_sk(sk);
diff -urpN -X dontdiff a/net/dccp/proto.c b/net/dccp/proto.c
--- a/net/dccp/proto.c	2007-01-12 11:18:59.142789240 -0800
+++ b/net/dccp/proto.c	2007-01-12 11:29:21.287140206 -0800
@@ -634,8 +634,7 @@ int compat_dccp_getsockopt(struct sock *
 EXPORT_SYMBOL_GPL(compat_dccp_getsockopt);
 #endif
 
-int dccp_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		 size_t len)
+int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	const struct dccp_sock *dp = dccp_sk(sk);
 	const int flags = msg->msg_flags;
@@ -690,8 +689,8 @@ out_discard:
 
 EXPORT_SYMBOL_GPL(dccp_sendmsg);
 
-int dccp_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		 size_t len, int nonblock, int flags, int *addr_len)
+int dccp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
+		 int flags, int *addr_len)
 {
 	const struct dccp_hdr *dh;
 	long timeo;
diff -urpN -X dontdiff a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
--- a/net/decnet/af_decnet.c	2006-11-29 13:57:37.000000000 -0800
+++ b/net/decnet/af_decnet.c	2007-01-12 11:29:21.293138156 -0800
@@ -1666,8 +1666,8 @@ static int dn_data_ready(struct sock *sk
 }
 
 
-static int dn_recvmsg(struct kiocb *iocb, struct socket *sock,
-	struct msghdr *msg, size_t size, int flags)
+static int dn_recvmsg(struct socket *sock, struct msghdr *msg,
+		      size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct dn_scp *scp = DN_SK(sk);
@@ -1903,8 +1903,7 @@ static inline struct sk_buff *dn_alloc_s
 	return skb;
 }
 
-static int dn_sendmsg(struct kiocb *iocb, struct socket *sock,
-		      struct msghdr *msg, size_t size)
+static int dn_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct dn_scp *scp = DN_SK(sk);
diff -urpN -X dontdiff a/net/econet/af_econet.c b/net/econet/af_econet.c
--- a/net/econet/af_econet.c	2007-01-12 11:19:49.657525676 -0800
+++ b/net/econet/af_econet.c	2007-01-12 11:29:21.298136448 -0800
@@ -114,8 +114,8 @@ static void econet_insert_socket(struct 
  *	If necessary we block.
  */
 
-static int econet_recvmsg(struct kiocb *iocb, struct socket *sock,
-			  struct msghdr *msg, size_t len, int flags)
+static int econet_recvmsg(struct socket *sock, struct msghdr *msg,
+			  size_t len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
@@ -260,8 +260,7 @@ static void ec_tx_done(struct sk_buff *s
  *	and hence whether to use real Econet or the UDP emulation.
  */
 
-static int econet_sendmsg(struct kiocb *iocb, struct socket *sock,
-			  struct msghdr *msg, size_t len)
+static int econet_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_ec *saddr=(struct sockaddr_ec *)msg->msg_name;
diff -urpN -X dontdiff a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	2007-01-12 11:19:49.671520892 -0800
+++ b/net/ipv4/af_inet.c	2007-01-12 11:29:21.303134739 -0800
@@ -655,8 +655,7 @@ int inet_getname(struct socket *sock, st
 	return 0;
 }
 
-int inet_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg,
-		 size_t size)
+int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 
@@ -664,7 +663,7 @@ int inet_sendmsg(struct kiocb *iocb, str
 	if (!inet_sk(sk)->num && inet_autobind(sk))
 		return -EAGAIN;
 
-	return sk->sk_prot->sendmsg(iocb, sk, msg, size);
+	return sk->sk_prot->sendmsg(sk, msg, size);
 }
 
 
diff -urpN -X dontdiff a/net/ipv4/raw.c b/net/ipv4/raw.c
--- a/net/ipv4/raw.c	2007-01-12 11:18:59.767575737 -0800
+++ b/net/ipv4/raw.c	2007-01-12 11:29:21.307133373 -0800
@@ -48,7 +48,6 @@
 #include <linux/stddef.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
-#include <linux/aio.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/sockios.h>
@@ -376,8 +375,7 @@ static int raw_probe_proto_opt(struct fl
 	return 0;
 }
 
-static int raw_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		       size_t len)
+static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct ipcm_cookie ipc;
@@ -574,8 +572,8 @@ out:	return ret;
  *	we return it, otherwise we block.
  */
 
-static int raw_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		       size_t len, int noblock, int flags, int *addr_len)
+static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+		       int noblock, int flags, int *addr_len)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	size_t copied = 0;
diff -urpN -X dontdiff a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c	2007-01-12 11:19:49.806474764 -0800
+++ b/net/ipv4/tcp.c	2007-01-12 11:29:21.313131323 -0800
@@ -658,8 +658,7 @@ static inline int select_size(struct soc
 	return tmp;
 }
 
-int tcp_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		size_t size)
+int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	struct iovec *iov;
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1097,8 +1096,8 @@ int tcp_read_sock(struct sock *sk, read_
  *	Probably, code can be easily improved even more.
  */
 
-int tcp_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		size_t len, int nonblock, int flags, int *addr_len)
+int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+		int nonblock, int flags, int *addr_len)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int copied = 0;
diff -urpN -X dontdiff a/net/ipv4/tcp_probe.c b/net/ipv4/tcp_probe.c
--- a/net/ipv4/tcp_probe.c	2006-11-29 13:57:37.000000000 -0800
+++ b/net/ipv4/tcp_probe.c	2007-01-12 11:29:21.319129273 -0800
@@ -78,8 +78,7 @@ static void printl(const char *fmt, ...)
 	wake_up(&tcpw.wait);
 }
 
-static int jtcp_sendmsg(struct kiocb *iocb, struct sock *sk,
-			struct msghdr *msg, size_t size)
+static int jtcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	const struct inet_sock *inet = inet_sk(sk);
diff -urpN -X dontdiff a/net/ipv4/udp.c b/net/ipv4/udp.c
--- a/net/ipv4/udp.c	2007-01-12 11:18:59.882536452 -0800
+++ b/net/ipv4/udp.c	2007-01-12 11:29:21.324127564 -0800
@@ -504,8 +504,7 @@ out:
 	return err;
 }
 
-int udp_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		size_t len)
+int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct udp_sock *up = udp_sk(sk);
@@ -723,7 +722,7 @@ int udp_sendpage(struct sock *sk, struct
 		 * sendpage interface can't pass.
 		 * This will succeed only when the socket is connected.
 		 */
-		ret = udp_sendmsg(NULL, sk, &msg, 0);
+		ret = udp_sendmsg(sk, &msg, 0);
 		if (ret < 0)
 			return ret;
 	}
@@ -803,8 +802,8 @@ int udp_ioctl(struct sock *sk, int cmd, 
  * 	return it, otherwise we block.
  */
 
-int udp_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-	        size_t len, int noblock, int flags, int *addr_len)
+int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+		int noblock, int flags, int *addr_len)
 {
 	struct inet_sock *inet = inet_sk(sk);
   	struct sockaddr_in *sin = (struct sockaddr_in *)msg->msg_name;
diff -urpN -X dontdiff a/net/ipv4/udp_impl.h b/net/ipv4/udp_impl.h
--- a/net/ipv4/udp_impl.h	2007-01-12 11:18:59.885535427 -0800
+++ b/net/ipv4/udp_impl.h	2007-01-12 11:29:21.328126197 -0800
@@ -25,7 +25,7 @@ extern int	compat_udp_setsockopt(struct 
 extern int	compat_udp_getsockopt(struct sock *sk, int level, int optname,
 				      char __user *optval, int __user *optlen);
 #endif
-extern int	udp_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
+extern int	udp_recvmsg(struct sock *sk, struct msghdr *msg,
 			    size_t len, int noblock, int flags, int *addr_len);
 extern int	udp_sendpage(struct sock *sk, struct page *page, int offset,
 			     size_t size, int flags);
diff -urpN -X dontdiff a/net/ipv6/raw.c b/net/ipv6/raw.c
--- a/net/ipv6/raw.c	2007-01-12 11:19:49.875451187 -0800
+++ b/net/ipv6/raw.c	2007-01-12 11:29:21.333124489 -0800
@@ -391,8 +391,7 @@ int rawv6_rcv(struct sock *sk, struct sk
  *	we return it, otherwise we block.
  */
 
-static int rawv6_recvmsg(struct kiocb *iocb, struct sock *sk,
-		  struct msghdr *msg, size_t len,
+static int rawv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		  int noblock, int flags, int *addr_len)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -667,8 +666,7 @@ static int rawv6_probe_proto_opt(struct 
 	return 0;
 }
 
-static int rawv6_sendmsg(struct kiocb *iocb, struct sock *sk,
-		   struct msghdr *msg, size_t len)
+static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct ipv6_txoptions opt_space;
 	struct sockaddr_in6 * sin6 = (struct sockaddr_in6 *) msg->msg_name;
diff -urpN -X dontdiff a/net/ipv6/udp.c b/net/ipv6/udp.c
--- a/net/ipv6/udp.c	2007-01-12 11:19:49.884448112 -0800
+++ b/net/ipv6/udp.c	2007-01-12 11:29:21.341121755 -0800
@@ -113,8 +113,7 @@ static struct sock *__udp6_lib_lookup(st
  * 	return it, otherwise we block.
  */
 
-int udpv6_recvmsg(struct kiocb *iocb, struct sock *sk,
-		  struct msghdr *msg, size_t len,
+int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		  int noblock, int flags, int *addr_len)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -545,8 +544,7 @@ out:
 	return err;
 }
 
-int udpv6_sendmsg(struct kiocb *iocb, struct sock *sk,
-		  struct msghdr *msg, size_t len)
+int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct ipv6_txoptions opt_space;
 	struct udp_sock *up = udp_sk(sk);
@@ -607,12 +605,12 @@ int udpv6_sendmsg(struct kiocb *iocb, st
 do_udp_sendmsg:
 			if (__ipv6_only_sock(sk))
 				return -ENETUNREACH;
-			return udp_sendmsg(iocb, sk, msg, len);
+			return udp_sendmsg(sk, msg, len);
 		}
 	}
 
 	if (up->pending == AF_INET)
-		return udp_sendmsg(iocb, sk, msg, len);
+		return udp_sendmsg(sk, msg, len);
 
 	/* Rough check on arithmetic overflow,
 	   better check is made in ip6_build_xmit
diff -urpN -X dontdiff a/net/ipv6/udp_impl.h b/net/ipv6/udp_impl.h
--- a/net/ipv6/udp_impl.h	2007-01-12 11:19:00.080468814 -0800
+++ b/net/ipv6/udp_impl.h	2007-01-12 11:29:21.346120047 -0800
@@ -20,10 +20,8 @@ extern int	compat_udpv6_setsockopt(struc
 extern int	compat_udpv6_getsockopt(struct sock *sk, int level, int optname,
 				       char __user *optval, int __user *optlen);
 #endif
-extern int	udpv6_sendmsg(struct kiocb *iocb, struct sock *sk,
-			      struct msghdr *msg, size_t len);
-extern int	udpv6_recvmsg(struct kiocb *iocb, struct sock *sk,
-			      struct msghdr *msg, size_t len,
+extern int	udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
+extern int	udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		  	      int noblock, int flags, int *addr_len);
 extern int	udpv6_queue_rcv_skb(struct sock * sk, struct sk_buff *skb);
 extern int	udpv6_destroy_sock(struct sock *sk);
diff -urpN -X dontdiff a/net/ipx/af_ipx.c b/net/ipx/af_ipx.c
--- a/net/ipx/af_ipx.c	2006-11-29 13:57:37.000000000 -0800
+++ b/net/ipx/af_ipx.c	2007-01-12 11:29:21.351118339 -0800
@@ -1692,8 +1692,7 @@ out:
 	return rc;
 }
 
-static int ipx_sendmsg(struct kiocb *iocb, struct socket *sock,
-	struct msghdr *msg, size_t len)
+static int ipx_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct ipx_sock *ipxs = ipx_sk(sk);
@@ -1757,8 +1756,8 @@ out:
 }
 
 
-static int ipx_recvmsg(struct kiocb *iocb, struct socket *sock,
-		struct msghdr *msg, size_t size, int flags)
+static int ipx_recvmsg(struct socket *sock, struct msghdr *msg,
+		       size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct ipx_sock *ipxs = ipx_sk(sk);
diff -urpN -X dontdiff a/net/irda/af_irda.c b/net/irda/af_irda.c
--- a/net/irda/af_irda.c	2006-11-29 13:57:37.000000000 -0800
+++ b/net/irda/af_irda.c	2007-01-12 11:29:21.357116288 -0800
@@ -1263,14 +1263,13 @@ static int irda_release(struct socket *s
 }
 
 /*
- * Function irda_sendmsg (iocb, sock, msg, len)
+ * Function irda_sendmsg (sock, msg, len)
  *
  *    Send message down to TinyTP. This function is used for both STREAM and
  *    SEQPACK services. This is possible since it forces the client to
  *    fragment the message if necessary
  */
-static int irda_sendmsg(struct kiocb *iocb, struct socket *sock,
-			struct msghdr *msg, size_t len)
+static int irda_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct irda_sock *self;
@@ -1340,13 +1339,13 @@ static int irda_sendmsg(struct kiocb *io
 }
 
 /*
- * Function irda_recvmsg_dgram (iocb, sock, msg, size, flags)
+ * Function irda_recvmsg_dgram (sock, msg, size, flags)
  *
  *    Try to receive message and copy it to user. The frame is discarded
  *    after being read, regardless of how much the user actually read
  */
-static int irda_recvmsg_dgram(struct kiocb *iocb, struct socket *sock,
-			      struct msghdr *msg, size_t size, int flags)
+static int irda_recvmsg_dgram(struct socket *sock, struct msghdr *msg,
+			      size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct irda_sock *self = irda_sk(sk);
@@ -1395,10 +1394,10 @@ static int irda_recvmsg_dgram(struct kio
 }
 
 /*
- * Function irda_recvmsg_stream (iocb, sock, msg, size, flags)
+ * Function irda_recvmsg_stream (sock, msg, size, flags)
  */
-static int irda_recvmsg_stream(struct kiocb *iocb, struct socket *sock,
-			       struct msghdr *msg, size_t size, int flags)
+static int irda_recvmsg_stream(struct socket *sock, struct msghdr *msg,
+			       size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct irda_sock *self = irda_sk(sk);
@@ -1519,14 +1518,14 @@ static int irda_recvmsg_stream(struct ki
 }
 
 /*
- * Function irda_sendmsg_dgram (iocb, sock, msg, len)
+ * Function irda_sendmsg_dgram (sock, msg, len)
  *
  *    Send message down to TinyTP for the unreliable sequenced
  *    packet service...
  *
  */
-static int irda_sendmsg_dgram(struct kiocb *iocb, struct socket *sock,
-			      struct msghdr *msg, size_t len)
+static int irda_sendmsg_dgram(struct socket *sock, struct msghdr *msg,
+			      size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct irda_sock *self;
@@ -1589,14 +1588,14 @@ static int irda_sendmsg_dgram(struct kio
 }
 
 /*
- * Function irda_sendmsg_ultra (iocb, sock, msg, len)
+ * Function irda_sendmsg_ultra (sock, msg, len)
  *
  *    Send message down to IrLMP for the unreliable Ultra
  *    packet service...
  */
 #ifdef CONFIG_IRDA_ULTRA
-static int irda_sendmsg_ultra(struct kiocb *iocb, struct socket *sock,
-			      struct msghdr *msg, size_t len)
+static int irda_sendmsg_ultra(struct socket *sock, struct msghdr *msg,
+			      size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct irda_sock *self;
diff -urpN -X dontdiff a/net/key/af_key.c b/net/key/af_key.c
--- a/net/key/af_key.c	2007-01-12 11:19:00.142447635 -0800
+++ b/net/key/af_key.c	2007-01-12 11:29:21.363114238 -0800
@@ -3118,8 +3118,7 @@ static int pfkey_send_new_mapping(struct
 	return pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_REGISTERED, NULL);
 }
 
-static int pfkey_sendmsg(struct kiocb *kiocb,
-			 struct socket *sock, struct msghdr *msg, size_t len)
+static int pfkey_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb = NULL;
@@ -3160,8 +3159,7 @@ out:
 	return err ? : len;
 }
 
-static int pfkey_recvmsg(struct kiocb *kiocb,
-			 struct socket *sock, struct msghdr *msg, size_t len,
+static int pfkey_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			 int flags)
 {
 	struct sock *sk = sock->sk;
diff -urpN -X dontdiff a/net/llc/af_llc.c b/net/llc/af_llc.c
--- a/net/llc/af_llc.c	2007-01-12 11:19:00.148445585 -0800
+++ b/net/llc/af_llc.c	2007-01-12 11:29:21.368112530 -0800
@@ -656,8 +656,8 @@ out:
  *	Copy received data to the socket user.
  *	Returns non-negative upon success, negative otherwise.
  */
-static int llc_ui_recvmsg(struct kiocb *iocb, struct socket *sock,
-			  struct msghdr *msg, size_t len, int flags)
+static int llc_ui_recvmsg(struct socket *sock, struct msghdr *msg,
+			  size_t len, int flags)
 {
 	struct sockaddr_llc *uaddr = (struct sockaddr_llc *)msg->msg_name;
 	const int nonblock = flags & MSG_DONTWAIT;
@@ -818,8 +818,7 @@ copy_uaddr:
  *	Transmit data provided by the socket user.
  *	Returns non-negative upon success, negative otherwise.
  */
-static int llc_ui_sendmsg(struct kiocb *iocb, struct socket *sock,
-			  struct msghdr *msg, size_t len)
+static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
diff -urpN -X dontdiff a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
--- a/net/netlink/af_netlink.c	2007-01-12 11:28:23.515886548 -0800
+++ b/net/netlink/af_netlink.c	2007-01-12 11:29:21.373110822 -0800
@@ -1103,8 +1103,7 @@ static inline void netlink_rcv_wake(stru
 		wake_up_interruptible(&nlk->wait);
 }
 
-static int netlink_sendmsg(struct kiocb *kiocb, struct socket *sock,
-			   struct msghdr *msg, size_t len)
+static int netlink_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
@@ -1182,8 +1181,7 @@ out:
 	return err;
 }
 
-static int netlink_recvmsg(struct kiocb *kiocb, struct socket *sock,
-			   struct msghdr *msg, size_t len,
+static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			   int flags)
 {
 	struct scm_cookie scm;
diff -urpN -X dontdiff a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
--- a/net/netrom/af_netrom.c	2007-01-12 11:19:00.396360867 -0800
+++ b/net/netrom/af_netrom.c	2007-01-12 11:29:21.378109113 -0800
@@ -1009,8 +1009,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 	return 1;
 }
 
-static int nr_sendmsg(struct kiocb *iocb, struct socket *sock,
-		      struct msghdr *msg, size_t len)
+static int nr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct nr_sock *nr = nr_sk(sk);
@@ -1123,8 +1122,8 @@ out:
 	return err;
 }
 
-static int nr_recvmsg(struct kiocb *iocb, struct socket *sock,
-		      struct msghdr *msg, size_t size, int flags)
+static int nr_recvmsg(struct socket *sock, struct msghdr *msg,
+		      size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_ax25 *sax = (struct sockaddr_ax25 *)msg->msg_name;
diff -urpN -X dontdiff a/net/packet/af_packet.c b/net/packet/af_packet.c
--- a/net/packet/af_packet.c	2007-01-12 11:19:49.994410526 -0800
+++ b/net/packet/af_packet.c	2007-01-12 11:29:21.383107405 -0800
@@ -324,8 +324,8 @@ oom:
  *	protocol layers and you must therefore supply it with a complete frame
  */
  
-static int packet_sendmsg_spkt(struct kiocb *iocb, struct socket *sock,
-			       struct msghdr *msg, size_t len)
+static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
+			       size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_pkt *saddr=(struct sockaddr_pkt *)msg->msg_name;
@@ -697,8 +697,7 @@ ring_is_full:
 #endif
 
 
-static int packet_sendmsg(struct kiocb *iocb, struct socket *sock,
-			  struct msghdr *msg, size_t len)
+static int packet_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_ll *saddr=(struct sockaddr_ll *)msg->msg_name;
@@ -1048,8 +1047,8 @@ out:
  *	If necessary we block.
  */
 
-static int packet_recvmsg(struct kiocb *iocb, struct socket *sock,
-			  struct msghdr *msg, size_t len, int flags)
+static int packet_recvmsg(struct socket *sock, struct msghdr *msg,
+			  size_t len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
diff -urpN -X dontdiff a/net/rose/af_rose.c b/net/rose/af_rose.c
--- a/net/rose/af_rose.c	2007-01-12 11:19:00.415354377 -0800
+++ b/net/rose/af_rose.c	2007-01-12 11:29:21.389105355 -0800
@@ -1009,8 +1009,7 @@ int rose_rx_call_request(struct sk_buff 
 	return 1;
 }
 
-static int rose_sendmsg(struct kiocb *iocb, struct socket *sock,
-			struct msghdr *msg, size_t len)
+static int rose_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct rose_sock *rose = rose_sk(sk);
@@ -1179,8 +1178,8 @@ static int rose_sendmsg(struct kiocb *io
 }
 
 
-static int rose_recvmsg(struct kiocb *iocb, struct socket *sock,
-			struct msghdr *msg, size_t size, int flags)
+static int rose_recvmsg(struct socket *sock, struct msghdr *msg,
+			size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct rose_sock *rose = rose_sk(sk);
diff -urpN -X dontdiff a/net/sctp/socket.c b/net/sctp/socket.c
--- a/net/sctp/socket.c	2007-01-12 11:19:00.627281957 -0800
+++ b/net/sctp/socket.c	2007-01-12 11:29:21.397102621 -0800
@@ -1348,8 +1348,8 @@ static int sctp_error(struct sock *sk, i
 
 SCTP_STATIC int sctp_msghdr_parse(const struct msghdr *, sctp_cmsgs_t *);
 
-SCTP_STATIC int sctp_sendmsg(struct kiocb *iocb, struct sock *sk,
-			     struct msghdr *msg, size_t msg_len)
+SCTP_STATIC int sctp_sendmsg(struct sock *sk, struct msghdr *msg,
+			     size_t msg_len)
 {
 	struct sctp_sock *sp;
 	struct sctp_endpoint *ep;
@@ -1803,9 +1803,8 @@ static int sctp_skb_pull(struct sk_buff 
  */
 static struct sk_buff *sctp_skb_recv_datagram(struct sock *, int, int, int *);
 
-SCTP_STATIC int sctp_recvmsg(struct kiocb *iocb, struct sock *sk,
-			     struct msghdr *msg, size_t len, int noblock,
-			     int flags, int *addr_len)
+SCTP_STATIC int sctp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			     int noblock, int flags, int *addr_len)
 {
 	struct sctp_ulpevent *event = NULL;
 	struct sctp_sock *sp = sctp_sk(sk);
diff -urpN -X dontdiff a/net/socket.c b/net/socket.c
--- a/net/socket.c	2007-01-12 11:28:23.521884498 -0800
+++ b/net/socket.c	2007-01-12 11:29:21.442087245 -0800
@@ -548,8 +548,7 @@ void sock_release(struct socket *sock)
 	sock->file = NULL;
 }
 
-static inline int __sock_sendmsg(struct kiocb *iocb, struct socket *sock,
-				 struct msghdr *msg, size_t size)
+int sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	int err;
 
@@ -557,15 +556,7 @@ static inline int __sock_sendmsg(struct 
 	if (err)
 		return err;
 
-	return sock->ops->sendmsg(iocb, sock, msg, size);
-}
-
-int sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
-{
-	struct kiocb iocb;
-
-	init_sync_kiocb(&iocb, NULL);
-	return __sock_sendmsg(&iocb, sock, msg, size);
+	return sock->ops->sendmsg(sock, msg, size);
 }
 
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
@@ -586,8 +577,8 @@ int kernel_sendmsg(struct socket *sock, 
 	return result;
 }
 
-static inline int __sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-				 struct msghdr *msg, size_t size, int flags)
+int sock_recvmsg(struct socket *sock, struct msghdr *msg,
+		 size_t size, int flags)
 {
 	int err;
 
@@ -595,16 +586,7 @@ static inline int __sock_recvmsg(struct 
 	if (err)
 		return err;
 
-	return sock->ops->recvmsg(iocb, sock, msg, size, flags);
-}
-
-int sock_recvmsg(struct socket *sock, struct msghdr *msg,
-		 size_t size, int flags)
-{
-	struct kiocb iocb;
-
-	init_sync_kiocb(&iocb, NULL);
-	return __sock_recvmsg(&iocb, sock, msg, size, flags);
+	return sock->ops->recvmsg(sock, msg, size, flags);
 }
 
 int kernel_recvmsg(struct socket *sock, struct msghdr *msg,
@@ -664,7 +646,7 @@ static ssize_t sock_aio_read(struct kioc
 	msg.msg_iovlen = nr_segs;
 	msg.msg_flags = (iocb->ki_filp->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
 
-	return __sock_recvmsg(iocb, sock, &msg, size, msg.msg_flags);
+	return sock_recvmsg(sock, &msg, size, msg.msg_flags);
 }
 
 static ssize_t sock_aio_write(struct kiocb *iocb, const struct iovec *iov,
@@ -694,7 +676,7 @@ static ssize_t sock_aio_write(struct kio
 	if (sock->type == SOCK_SEQPACKET)
 		msg.msg_flags |= MSG_EOR;
 
-	return __sock_sendmsg(iocb, sock, &msg, size);
+	return sock_sendmsg(sock, &msg, size);
 }
 
 /*
diff -urpN -X dontdiff a/net/tipc/socket.c b/net/tipc/socket.c
--- a/net/tipc/socket.c	2006-11-29 13:57:37.000000000 -0800
+++ b/net/tipc/socket.c	2007-01-12 11:29:21.447085537 -0800
@@ -431,7 +431,6 @@ static int dest_name_check(struct sockad
 
 /**
  * send_msg - send message in connectionless manner
- * @iocb: (unused)
  * @sock: socket structure
  * @m: message to send
  * @total_len: length of message
@@ -444,8 +443,7 @@ static int dest_name_check(struct sockad
  * Returns the number of bytes sent on success, or errno otherwise
  */
 
-static int send_msg(struct kiocb *iocb, struct socket *sock,
-		    struct msghdr *m, size_t total_len)
+static int send_msg(struct socket *sock, struct msghdr *m, size_t total_len)
 {
 	struct tipc_sock *tsock = tipc_sk(sock->sk);
         struct sockaddr_tipc *dest = (struct sockaddr_tipc *)m->msg_name;
@@ -537,7 +535,6 @@ exit:                                
 
 /** 
  * send_packet - send a connection-oriented message
- * @iocb: (unused)
  * @sock: socket structure
  * @m: message to send
  * @total_len: length of message
@@ -547,8 +544,7 @@ exit:                                
  * Returns the number of bytes sent on success, or errno otherwise
  */
 
-static int send_packet(struct kiocb *iocb, struct socket *sock,
-		       struct msghdr *m, size_t total_len)
+static int send_packet(struct socket *sock, struct msghdr *m, size_t total_len)
 {
 	struct tipc_sock *tsock = tipc_sk(sock->sk);
         struct sockaddr_tipc *dest = (struct sockaddr_tipc *)m->msg_name;
@@ -557,7 +553,7 @@ static int send_packet(struct kiocb *ioc
 	/* Handle implied connection establishment */
 
 	if (unlikely(dest))
-		return send_msg(iocb, sock, m, total_len);
+		return send_msg(sock, m, total_len);
 
 	if (down_interruptible(&tsock->sem)) {
 		return -ERESTARTSYS;
@@ -592,7 +588,6 @@ exit:
 
 /** 
  * send_stream - send stream-oriented data
- * @iocb: (unused)
  * @sock: socket structure
  * @m: data to send
  * @total_len: total length of data to be sent
@@ -604,8 +599,7 @@ exit:
  */
 
 
-static int send_stream(struct kiocb *iocb, struct socket *sock,
-		       struct msghdr *m, size_t total_len)
+static int send_stream(struct socket *sock, struct msghdr *m, size_t total_len)
 {
 	struct msghdr my_msg;
 	struct iovec my_iov;
@@ -618,7 +612,7 @@ static int send_stream(struct kiocb *ioc
 	int res;
 	
 	if (likely(total_len <= TIPC_MAX_USER_MSG_SIZE))
-		return send_packet(iocb, sock, m, total_len);
+		return send_packet(sock, m, total_len);
 
 	/* Can only send large data streams if already connected */
 
@@ -657,7 +651,7 @@ static int send_stream(struct kiocb *ioc
 				? curr_left : TIPC_MAX_USER_MSG_SIZE;
 			my_iov.iov_base = curr_start;
 			my_iov.iov_len = bytes_to_send;
-                        if ((res = send_packet(iocb, sock, &my_msg, 0)) < 0) {
+                        if ((res = send_packet(sock, &my_msg, 0)) < 0) {
 				return bytes_sent ? bytes_sent : res;
 			}
 			curr_left -= bytes_to_send;
@@ -792,7 +786,6 @@ static int anc_data_recv(struct msghdr *
 
 /** 
  * recv_msg - receive packet-oriented message
- * @iocb: (unused)
  * @m: descriptor for message info
  * @buf_len: total size of user buffer area
  * @flags: receive flags
@@ -803,8 +796,8 @@ static int anc_data_recv(struct msghdr *
  * Returns size of returned message data, errno otherwise
  */
 
-static int recv_msg(struct kiocb *iocb, struct socket *sock,
-		    struct msghdr *m, size_t buf_len, int flags)
+static int recv_msg(struct socket *sock, struct msghdr *m,
+		    size_t buf_len, int flags)
 {
 	struct tipc_sock *tsock = tipc_sk(sock->sk);
 	struct sk_buff *buf;
@@ -924,7 +917,6 @@ exit:
 
 /** 
  * recv_stream - receive stream-oriented data
- * @iocb: (unused)
  * @m: descriptor for message info
  * @buf_len: total size of user buffer area
  * @flags: receive flags
@@ -935,8 +927,8 @@ exit:
  * Returns size of returned message data, errno otherwise
  */
 
-static int recv_stream(struct kiocb *iocb, struct socket *sock,
-		       struct msghdr *m, size_t buf_len, int flags)
+static int recv_stream(struct socket *sock, struct msghdr *m,
+		       size_t buf_len, int flags)
 {
 	struct tipc_sock *tsock = tipc_sk(sock->sk);
 	struct sk_buff *buf;
diff -urpN -X dontdiff a/net/unix/af_unix.c b/net/unix/af_unix.c
--- a/net/unix/af_unix.c	2007-01-12 11:28:23.526882789 -0800
+++ b/net/unix/af_unix.c	2007-01-12 11:29:21.453083487 -0800
@@ -478,18 +478,13 @@ static int unix_getname(struct socket *,
 static unsigned int unix_poll(struct file *, struct socket *, poll_table *);
 static int unix_ioctl(struct socket *, unsigned int, unsigned long);
 static int unix_shutdown(struct socket *, int);
-static int unix_stream_sendmsg(struct kiocb *, struct socket *,
-			       struct msghdr *, size_t);
-static int unix_stream_recvmsg(struct kiocb *, struct socket *,
-			       struct msghdr *, size_t, int);
-static int unix_dgram_sendmsg(struct kiocb *, struct socket *,
-			      struct msghdr *, size_t);
-static int unix_dgram_recvmsg(struct kiocb *, struct socket *,
-			      struct msghdr *, size_t, int);
+static int unix_stream_sendmsg(struct socket *, struct msghdr *, size_t);
+static int unix_stream_recvmsg(struct socket *, struct msghdr *, size_t, int);
+static int unix_dgram_sendmsg(struct socket *, struct msghdr *, size_t);
+static int unix_dgram_recvmsg(struct socket *, struct msghdr *, size_t, int);
 static int unix_dgram_connect(struct socket *, struct sockaddr *,
 			      int, int);
-static int unix_seqpacket_sendmsg(struct kiocb *, struct socket *,
-				  struct msghdr *, size_t);
+static int unix_seqpacket_sendmsg(struct socket *, struct msghdr *, size_t);
 
 static const struct proto_ops unix_stream_ops = {
 	.family =	PF_UNIX,
@@ -1264,8 +1259,8 @@ static void unix_attach_fds(struct scm_c
  *	Send AF_UNIX data.
  */
 
-static int unix_dgram_sendmsg(struct kiocb *kiocb, struct socket *sock,
-			      struct msghdr *msg, size_t len)
+static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
+			      size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct unix_sock *u = unix_sk(sk);
@@ -1413,8 +1408,8 @@ out:
 }
 
 		
-static int unix_stream_sendmsg(struct kiocb *kiocb, struct socket *sock,
-			       struct msghdr *msg, size_t len)
+static int unix_stream_sendmsg(struct socket *sock,  struct msghdr *msg,
+			       size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct sock *other = NULL;
@@ -1516,8 +1511,8 @@ out_err:
 	return sent ? : err;
 }
 
-static int unix_seqpacket_sendmsg(struct kiocb *kiocb, struct socket *sock,
-				  struct msghdr *msg, size_t len)
+static int unix_seqpacket_sendmsg(struct socket *sock, struct msghdr *msg,
+				  size_t len)
 {
 	int err;
 	struct sock *sk = sock->sk;
@@ -1532,7 +1527,7 @@ static int unix_seqpacket_sendmsg(struct
 	if (msg->msg_namelen)
 		msg->msg_namelen = 0;
 
-	return unix_dgram_sendmsg(kiocb, sock, msg, len);
+	return unix_dgram_sendmsg(sock, msg, len);
 }
                                                                                             
 static void unix_copy_addr(struct msghdr *msg, struct sock *sk)
@@ -1546,9 +1541,8 @@ static void unix_copy_addr(struct msghdr
 	}
 }
 
-static int unix_dgram_recvmsg(struct kiocb *iocb, struct socket *sock,
-			      struct msghdr *msg, size_t size,
-			      int flags)
+static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
+			      size_t size, int flags)
 {
 	struct scm_cookie scm;
 	struct sock *sk = sock->sk;
@@ -1655,9 +1649,8 @@ static long unix_stream_data_wait(struct
 
 
 
-static int unix_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
-			       struct msghdr *msg, size_t size,
-			       int flags)
+static int unix_stream_recvmsg(struct socket *sock, struct msghdr *msg,
+			       size_t size, int flags)
 {
 	struct scm_cookie scm;
 	struct sock *sk = sock->sk;
diff -urpN -X dontdiff a/net/wanrouter/af_wanpipe.c b/net/wanrouter/af_wanpipe.c
--- a/net/wanrouter/af_wanpipe.c	2007-01-12 11:19:00.807220468 -0800
+++ b/net/wanrouter/af_wanpipe.c	2007-01-12 11:29:21.459081437 -0800
@@ -542,8 +542,7 @@ static struct sock *wanpipe_alloc_socket
  *      a packet is queued into sk->sk_write_queue.
  *===========================================================*/
 
-static int wanpipe_sendmsg(struct kiocb *iocb, struct socket *sock,
-			   struct msghdr *msg, int len)
+static int wanpipe_sendmsg(struct socket *sock, struct msghdr *msg, int len)
 {
 	wanpipe_opt *wp;
 	struct sock *sk = sock->sk;
@@ -1546,8 +1545,8 @@ static int wanpipe_create(struct socket 
  *      to the user. If necessary we block.
  *===========================================================*/
 
-static int wanpipe_recvmsg(struct kiocb *iocb, struct socket *sock,
-			   struct msghdr *msg, int len, int flags)
+static int wanpipe_recvmsg(struct socket *sock, struct msghdr *msg,
+			   int len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
diff -urpN -X dontdiff a/net/x25/af_x25.c b/net/x25/af_x25.c
--- a/net/x25/af_x25.c	2007-01-12 11:19:00.816217393 -0800
+++ b/net/x25/af_x25.c	2007-01-12 11:29:21.464079728 -0800
@@ -958,8 +958,7 @@ out_clear_request:
 	goto out;
 }
 
-static int x25_sendmsg(struct kiocb *iocb, struct socket *sock,
-		       struct msghdr *msg, size_t len)
+static int x25_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct x25_sock *x25 = x25_sk(sk);
@@ -1134,8 +1133,7 @@ out_kfree_skb:
 }
 
 
-static int x25_recvmsg(struct kiocb *iocb, struct socket *sock,
-		       struct msghdr *msg, size_t size,
+static int x25_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		       int flags)
 {
 	struct sock *sk = sock->sk;
