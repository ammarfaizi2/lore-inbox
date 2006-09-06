Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWIFLcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWIFLcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 07:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWIFLce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 07:32:34 -0400
Received: from dea.vocord.ru ([217.67.177.50]:31880 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1750835AbWIFLbs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 07:31:48 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: [take16 3/4] kevent: Socket notifications.
In-Reply-To: <11575437232230@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Sep 2006 15:55:23 +0400
Message-Id: <11575437234110@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Socket notifications.

This patch include socket send/recv/accept notifications.
Using trivial web server based on kevent and this features 
instead of epoll it's performance increased more than noticebly.
More details about benchmark and server itself (evserver_kevent.c)
can be found on project's homepage.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mitp.ru>

diff --git a/fs/inode.c b/fs/inode.c
index 0bf9f04..181521d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -21,6 +21,7 @@ #include <linux/pagemap.h>
 #include <linux/cdev.h>
 #include <linux/bootmem.h>
 #include <linux/inotify.h>
+#include <linux/kevent.h>
 #include <linux/mount.h>
 
 /*
@@ -165,12 +166,18 @@ #endif
 		}
 		memset(&inode->u, 0, sizeof(inode->u));
 		inode->i_mapping = mapping;
+#if defined CONFIG_KEVENT_SOCKET
+		kevent_storage_init(inode, &inode->st);
+#endif
 	}
 	return inode;
 }
 
 void destroy_inode(struct inode *inode) 
 {
+#if defined CONFIG_KEVENT_SOCKET
+	kevent_storage_fini(&inode->st);
+#endif
 	BUG_ON(inode_has_buffers(inode));
 	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2561020..a697930 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -236,6 +236,7 @@ #include <linux/prio_tree.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
+#include <linux/kevent.h>
 
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
@@ -546,6 +547,10 @@ #ifdef CONFIG_INOTIFY
 	struct mutex		inotify_mutex;	/* protects the watches list */
 #endif
 
+#ifdef CONFIG_KEVENT_SOCKET
+	struct kevent_storage	st;
+#endif
+
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
@@ -698,6 +703,9 @@ #ifdef CONFIG_EPOLL
 	struct list_head	f_ep_links;
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
+#ifdef CONFIG_KEVENT_POLL
+	struct kevent_storage	st;
+#endif
 	struct address_space	*f_mapping;
 };
 extern spinlock_t files_lock;
diff --git a/include/net/sock.h b/include/net/sock.h
index 324b3ea..5d71ed7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -48,6 +48,7 @@ #include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/security.h>
+#include <linux/kevent.h>
 
 #include <linux/filter.h>
 
@@ -450,6 +451,21 @@ static inline int sk_stream_memory_free(
 
 extern void sk_stream_rfree(struct sk_buff *skb);
 
+struct socket_alloc {
+	struct socket socket;
+	struct inode vfs_inode;
+};
+
+static inline struct socket *SOCKET_I(struct inode *inode)
+{
+	return &container_of(inode, struct socket_alloc, vfs_inode)->socket;
+}
+
+static inline struct inode *SOCK_INODE(struct socket *socket)
+{
+	return &container_of(socket, struct socket_alloc, socket)->vfs_inode;
+}
+
 static inline void sk_stream_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 	skb->sk = sk;
@@ -477,6 +493,7 @@ static inline void sk_add_backlog(struct
 		sk->sk_backlog.tail = skb;
 	}
 	skb->next = NULL;
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
 }
 
 #define sk_wait_event(__sk, __timeo, __condition)		\
@@ -679,21 +696,6 @@ static inline struct kiocb *siocb_to_kio
 	return si->kiocb;
 }
 
-struct socket_alloc {
-	struct socket socket;
-	struct inode vfs_inode;
-};
-
-static inline struct socket *SOCKET_I(struct inode *inode)
-{
-	return &container_of(inode, struct socket_alloc, vfs_inode)->socket;
-}
-
-static inline struct inode *SOCK_INODE(struct socket *socket)
-{
-	return &container_of(socket, struct socket_alloc, socket)->vfs_inode;
-}
-
 extern void __sk_stream_mem_reclaim(struct sock *sk);
 extern int sk_stream_mem_schedule(struct sock *sk, int size, int kind);
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7a093d0..69f4ad2 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -857,6 +857,7 @@ static inline int tcp_prequeue(struct so
 			tp->ucopy.memory = 0;
 		} else if (skb_queue_len(&tp->ucopy.prequeue) == 1) {
 			wake_up_interruptible(sk->sk_sleep);
+			kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 			if (!inet_csk_ack_scheduled(sk))
 				inet_csk_reset_xmit_timer(sk, ICSK_TIME_DACK,
 						          (3 * TCP_RTO_MIN) / 4,
diff --git a/kernel/kevent/kevent_socket.c b/kernel/kevent/kevent_socket.c
new file mode 100644
index 0000000..5b15f22
--- /dev/null
+++ b/kernel/kevent/kevent_socket.c
@@ -0,0 +1,142 @@
+/*
+ * 	kevent_socket.c
+ * 
+ * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/file.h>
+#include <linux/tcp.h>
+#include <linux/kevent.h>
+
+#include <net/sock.h>
+#include <net/request_sock.h>
+#include <net/inet_connection_sock.h>
+
+static int kevent_socket_callback(struct kevent *k)
+{
+	struct inode *inode = k->st->origin;
+	struct sock *sk = SOCKET_I(inode)->sk;
+	int rmem;
+	
+	if (k->event.event & KEVENT_SOCKET_RECV) {
+		int ret = 0;
+		
+		if ((rmem = atomic_read(&sk->sk_rmem_alloc)) > 0 || 
+				!skb_queue_empty(&sk->sk_receive_queue))
+			ret = 1;
+		if (sk->sk_shutdown & RCV_SHUTDOWN)
+			ret = 1;
+		if (ret)
+			return ret;
+	}
+	if ((k->event.event & KEVENT_SOCKET_ACCEPT) && 
+		(!reqsk_queue_empty(&inet_csk(sk)->icsk_accept_queue) || 
+		 	reqsk_queue_len_young(&inet_csk(sk)->icsk_accept_queue))) {
+		k->event.ret_data[1] = reqsk_queue_len(&inet_csk(sk)->icsk_accept_queue);
+		return 1;
+	}
+
+	return 0;
+}
+
+int kevent_socket_enqueue(struct kevent *k)
+{
+	struct inode *inode;
+	struct socket *sock;
+	int err = -ENODEV;
+
+	sock = sockfd_lookup(k->event.id.raw[0], &err);
+	if (!sock)
+		goto err_out_exit;
+
+	inode = igrab(SOCK_INODE(sock));
+	if (!inode)
+		goto err_out_fput;
+
+	err = kevent_storage_enqueue(&inode->st, k);
+	if (err)
+		goto err_out_iput;
+
+	err = k->callbacks.callback(k);
+	if (err)
+		goto err_out_dequeue;
+
+	sockfd_put(sock);
+	return err;
+
+err_out_dequeue:
+	kevent_storage_dequeue(k->st, k);
+err_out_iput:
+	iput(inode);
+err_out_fput:
+	sockfd_put(sock);
+err_out_exit:
+	return err;
+}
+
+int kevent_socket_dequeue(struct kevent *k)
+{
+	struct inode *inode = k->st->origin;
+
+	kevent_storage_dequeue(k->st, k);
+	iput(inode);
+
+	return 0;
+}
+
+void kevent_socket_notify(struct sock *sk, u32 event)
+{
+	if (sk->sk_socket)
+		kevent_storage_ready(&SOCK_INODE(sk->sk_socket)->st, NULL, event);
+}
+
+#ifdef CONFIG_LOCKDEP
+static struct lock_class_key kevent_sock_key;
+
+void kevent_socket_reinit(struct socket *sock)
+{
+	struct inode *inode = SOCK_INODE(sock);
+
+	lockdep_set_class(&inode->st.lock, &kevent_sock_key);
+}
+
+void kevent_sk_reinit(struct sock *sk)
+{
+	if (sk->sk_socket) {
+		struct inode *inode = SOCK_INODE(sk->sk_socket);
+
+		lockdep_set_class(&inode->st.lock, &kevent_sock_key);
+	}
+}
+#endif
+static int __init kevent_init_socket(void)
+{
+	struct kevent_callbacks sc = {
+		.callback = &kevent_socket_callback,
+		.enqueue = &kevent_socket_enqueue,
+		.dequeue = &kevent_socket_dequeue};
+
+	return kevent_add_callbacks(&sc, KEVENT_SOCKET);
+}
+module_init(kevent_init_socket);
diff --git a/net/core/sock.c b/net/core/sock.c
index 51fcfbc..4f91615 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1406,6 +1406,7 @@ static void sock_def_wakeup(struct sock 
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
 		wake_up_interruptible_all(sk->sk_sleep);
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_error_report(struct sock *sk)
@@ -1415,6 +1416,7 @@ static void sock_def_error_report(struct
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,0,POLL_ERR); 
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_readable(struct sock *sk, int len)
@@ -1424,6 +1426,7 @@ static void sock_def_readable(struct soc
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,1,POLL_IN);
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_write_space(struct sock *sk)
@@ -1443,6 +1446,7 @@ static void sock_def_write_space(struct 
 	}
 
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
 }
 
 static void sock_def_destruct(struct sock *sk)
@@ -1493,6 +1497,8 @@ #endif
 	sk->sk_state		=	TCP_CLOSE;
 	sk->sk_socket		=	sock;
 
+	kevent_sk_reinit(sk);
+
 	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if(sock)
@@ -1559,8 +1565,10 @@ void fastcall release_sock(struct sock *
 	if (sk->sk_backlog.tail)
 		__release_sock(sk);
 	sk->sk_lock.owner = NULL;
-	if (waitqueue_active(&sk->sk_lock.wq))
+	if (waitqueue_active(&sk->sk_lock.wq)) {
 		wake_up(&sk->sk_lock.wq);
+		kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
+	}
 	spin_unlock_bh(&sk->sk_lock.slock);
 }
 EXPORT_SYMBOL(release_sock);
diff --git a/net/core/stream.c b/net/core/stream.c
index d1d7dec..2878c2a 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -36,6 +36,7 @@ void sk_stream_write_space(struct sock *
 			wake_up_interruptible(sk->sk_sleep);
 		if (sock->fasync_list && !(sk->sk_shutdown & SEND_SHUTDOWN))
 			sock_wake_async(sock, 2, POLL_OUT);
+		kevent_socket_notify(sk, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
 	}
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 104af5d..14cee12 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3112,6 +3112,7 @@ static void tcp_ofo_queue(struct sock *s
 
 		__skb_unlink(skb, &tp->out_of_order_queue);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
 		tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 		if(skb->h.th->fin)
 			tcp_fin(skb, sk, skb->h.th);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4b04c3e..cda1500 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -61,6 +61,7 @@ #include <linux/cache.h>
 #include <linux/jhash.h>
 #include <linux/init.h>
 #include <linux/times.h>
+#include <linux/kevent.h>
 
 #include <net/icmp.h>
 #include <net/inet_hashtables.h>
@@ -867,6 +868,7 @@ #endif
 	   	reqsk_free(req);
 	} else {
 		inet_csk_reqsk_queue_hash_add(sk, req, TCP_TIMEOUT_INIT);
+		kevent_socket_notify(sk, KEVENT_SOCKET_ACCEPT);
 	}
 	return 0;
 
diff --git a/net/socket.c b/net/socket.c
index b4848ce..42e19e2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -85,6 +85,7 @@ #include <linux/compat.h>
 #include <linux/kmod.h>
 #include <linux/audit.h>
 #include <linux/wireless.h>
+#include <linux/kevent.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -526,6 +527,8 @@ static struct socket *sock_alloc(void)
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 
+	kevent_socket_reinit(sock);
+
 	get_cpu_var(sockets_in_use)++;
 	put_cpu_var(sockets_in_use);
 	return sock;

