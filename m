Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWILPyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWILPyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWILPyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:54:43 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:34974 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751434AbWILPvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:51:00 -0400
Message-Id: <20060912144904.998523000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 18/20] netlink: add SOCK_VMIO support to AF_NETLINK
Content-Disposition: inline; filename=netlink_vmio.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the netlink code so that SOCK_VMIO has the desired effect on the
user-space side of the connection.

Modify sys_{send,recv}msg to use sk->sk_allocation instead of GFP_KERNEL,
this should not change existing behaviour because the default of
sk->sk_allocation is GFP_KERNEL, and no user-space exposed socket would
have it any different at this time.

This change allows the system calls to succeed for SOCK_VMIO sockets 
(who have sk->sk_allocation |= GFP_EMERGENCY) even under extreme memory
pressure.

Since netlink_sendmsg is used to transfer msgs from user- to kernel-space
treat the skb allocation there as a receive allocation.

Also export netlink_lookup, this is needed to locate the kernel side struct
sock object associated with the user-space netlink socket. 

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: David Miller <davem@davemloft.net>
CC: Mike Christie <michaelc@cs.wisc.edu>
---
 include/linux/netlink.h  |    1 +
 net/compat.c             |    2 +-
 net/netlink/af_netlink.c |    8 +++++---
 net/socket.c             |    6 +++---
 4 files changed, 10 insertions(+), 7 deletions(-)

Index: linux-2.6/net/netlink/af_netlink.c
===================================================================
--- linux-2.6.orig/net/netlink/af_netlink.c
+++ linux-2.6/net/netlink/af_netlink.c
@@ -199,7 +199,7 @@ netlink_unlock_table(void)
 		wake_up(&nl_table_wait);
 }
 
-static __inline__ struct sock *netlink_lookup(int protocol, u32 pid)
+__inline__ struct sock *netlink_lookup(int protocol, u32 pid)
 {
 	struct nl_pid_hash *hash = &nl_table[protocol].hash;
 	struct hlist_head *head;
@@ -1147,7 +1147,7 @@ static int netlink_sendmsg(struct kiocb 
 	if (len > sk->sk_sndbuf - 32)
 		goto out;
 	err = -ENOBUFS;
-	skb = alloc_skb(len, GFP_KERNEL);
+	skb = __alloc_skb(len, GFP_KERNEL, SKB_ALLOC_RX);
 	if (skb==NULL)
 		goto out;
 
@@ -1178,7 +1178,8 @@ static int netlink_sendmsg(struct kiocb 
 
 	if (dst_group) {
 		atomic_inc(&skb->users);
-		netlink_broadcast(sk, skb, dst_pid, dst_group, GFP_KERNEL);
+		netlink_broadcast(sk, skb, dst_pid, dst_group,
+				sk->sk_allocation);
 	}
 	err = netlink_unicast(sk, skb, dst_pid, msg->msg_flags&MSG_DONTWAIT);
 
@@ -1788,6 +1789,7 @@ panic:
 
 core_initcall(netlink_proto_init);
 
+EXPORT_SYMBOL(netlink_lookup);
 EXPORT_SYMBOL(netlink_ack);
 EXPORT_SYMBOL(netlink_run_queue);
 EXPORT_SYMBOL(netlink_queue_skip);
Index: linux-2.6/net/socket.c
===================================================================
--- linux-2.6.orig/net/socket.c
+++ linux-2.6/net/socket.c
@@ -1790,7 +1790,7 @@ asmlinkage long sys_sendmsg(int fd, stru
 	err = -ENOMEM;
 	iov_size = msg_sys.msg_iovlen * sizeof(struct iovec);
 	if (msg_sys.msg_iovlen > UIO_FASTIOV) {
-		iov = sock_kmalloc(sock->sk, iov_size, GFP_KERNEL);
+		iov = sock_kmalloc(sock->sk, iov_size, sock->sk->sk_allocation);
 		if (!iov)
 			goto out_put;
 	}
@@ -1818,7 +1818,7 @@ asmlinkage long sys_sendmsg(int fd, stru
 	} else if (ctl_len) {
 		if (ctl_len > sizeof(ctl))
 		{
-			ctl_buf = sock_kmalloc(sock->sk, ctl_len, GFP_KERNEL);
+			ctl_buf = sock_kmalloc(sock->sk, ctl_len, sock->sk->sk_allocation);
 			if (ctl_buf == NULL) 
 				goto out_freeiov;
 		}
@@ -1891,7 +1891,7 @@ asmlinkage long sys_recvmsg(int fd, stru
 	err = -ENOMEM;
 	iov_size = msg_sys.msg_iovlen * sizeof(struct iovec);
 	if (msg_sys.msg_iovlen > UIO_FASTIOV) {
-		iov = sock_kmalloc(sock->sk, iov_size, GFP_KERNEL);
+		iov = sock_kmalloc(sock->sk, iov_size, sock->sk->sk_allocation);
 		if (!iov)
 			goto out_put;
 	}
Index: linux-2.6/include/linux/netlink.h
===================================================================
--- linux-2.6.orig/include/linux/netlink.h
+++ linux-2.6/include/linux/netlink.h
@@ -150,6 +150,7 @@ struct netlink_skb_parms
 #define NETLINK_CREDS(skb)	(&NETLINK_CB((skb)).creds)
 
 
+extern struct sock *netlink_lookup(int protocol, __u32 pid);
 extern struct sock *netlink_kernel_create(int unit, unsigned int groups, void (*input)(struct sock *sk, int len), struct module *module);
 extern void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err);
 extern int netlink_has_listeners(struct sock *sk, unsigned int group);
Index: linux-2.6/net/compat.c
===================================================================
--- linux-2.6.orig/net/compat.c
+++ linux-2.6/net/compat.c
@@ -170,7 +170,7 @@ int cmsghdr_from_user_compat_to_kern(str
 	 * from the user.
 	 */
 	if (kcmlen > stackbuf_size)
-		kcmsg_base = kcmsg = sock_kmalloc(sk, kcmlen, GFP_KERNEL);
+		kcmsg_base = kcmsg = sock_kmalloc(sk, kcmlen, sk->sk_allocation);
 	if (kcmsg == NULL)
 		return -ENOBUFS;
 

--

