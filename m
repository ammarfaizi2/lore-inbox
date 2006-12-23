Return-Path: <linux-kernel-owner+w=401wt.eu-S1753652AbWLWQxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbWLWQxl (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 11:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbWLWQwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 11:52:55 -0500
Received: from dea.vocord.ru ([217.67.177.50]:33186 "EHLO
	kano.factory.vocord.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753598AbWLWQwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 11:52:18 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>
Subject: [take29 4/8] kevent: Socket notifications.
In-Reply-To: <11668927002190@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Sat, 23 Dec 2006 19:51:41 +0300
Message-Id: <11668927012580@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Socket notifications.

This patch includes socket send/recv/accept notifications.
Using trivial web server based on kevent and this features
instead of epoll it's performance increased more than noticebly.
More details about various benchmarks and server itself 
(evserver_kevent.c) can be found on project's homepage.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mitp.ru>

diff --git a/fs/inode.c b/fs/inode.c
index ada7643..2740617 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -21,6 +21,7 @@
 #include <linux/cdev.h>
 #include <linux/bootmem.h>
 #include <linux/inotify.h>
+#include <linux/kevent.h>
 #include <linux/mount.h>
 
 /*
@@ -164,12 +165,18 @@ static struct inode *alloc_inode(struct super_block *sb)
 		}
 		inode->i_private = 0;
 		inode->i_mapping = mapping;
+#if defined CONFIG_KEVENT_SOCKET || defined CONFIG_KEVENT_PIPE
+		kevent_storage_init(inode, &inode->st);
+#endif
 	}
 	return inode;
 }
 
 void destroy_inode(struct inode *inode) 
 {
+#if defined CONFIG_KEVENT_SOCKET || defined CONFIG_KEVENT_PIPE
+	kevent_storage_fini(&inode->st);
+#endif
 	BUG_ON(inode_has_buffers(inode));
 	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
diff --git a/include/net/sock.h b/include/net/sock.h
index edd4d73..d48ded8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -48,6 +48,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/security.h>
+#include <linux/kevent.h>
 
 #include <linux/filter.h>
 
@@ -450,6 +451,21 @@ static inline int sk_stream_memory_free(struct sock *sk)
 
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
@@ -477,6 +493,7 @@ static inline void sk_add_backlog(struct sock *sk, struct sk_buff *skb)
 		sk->sk_backlog.tail = skb;
 	}
 	skb->next = NULL;
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
 }
 
 #define sk_wait_event(__sk, __timeo, __condition)		\
@@ -679,21 +696,6 @@ static inline struct kiocb *siocb_to_kiocb(struct sock_iocb *si)
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
@@ -857,6 +857,7 @@ static inline int tcp_prequeue(struct sock *sk, struct sk_buff *skb)
 			tp->ucopy.memory = 0;
 		} else if (skb_queue_len(&tp->ucopy.prequeue) == 1) {
 			wake_up_interruptible(sk->sk_sleep);
+			kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 			if (!inet_csk_ack_scheduled(sk))
 				inet_csk_reset_xmit_timer(sk, ICSK_TIME_DACK,
 						          (3 * TCP_RTO_MIN) / 4,
diff --git a/kernel/kevent/kevent_socket.c b/kernel/kevent/kevent_socket.c
new file mode 100644
index 0000000..d1a2701
--- /dev/null
+++ b/kernel/kevent/kevent_socket.c
@@ -0,0 +1,144 @@
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
+	unsigned int events = SOCKET_I(inode)->ops->poll(SOCKET_I(inode)->file, SOCKET_I(inode), NULL);
+
+	if ((events & (POLLIN | POLLRDNORM)) && (k->event.event & (KEVENT_SOCKET_RECV | KEVENT_SOCKET_ACCEPT)))
+		return 1;
+	if ((events & (POLLOUT | POLLWRNORM)) && (k->event.event & KEVENT_SOCKET_SEND))
+		return 1;
+	if (events & (POLLERR | POLLHUP | POLLRDHUP | POLLREMOVE))
+		return -1;
+	return 0;
+}
+
+int kevent_socket_enqueue(struct kevent *k)
+{
+	struct inode *inode;
+	struct socket *sock;
+	int err = -EBADF;
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
+	if (k->event.req_flags & KEVENT_REQ_ALWAYS_QUEUE) {
+		kevent_requeue(k);
+		err = 0;
+	} else {
+		err = k->callbacks.callback(k);
+		if (err)
+			goto err_out_dequeue;
+	}
+
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
+	struct socket *sock;
+
+	kevent_storage_dequeue(k->st, k);
+
+	sock = SOCKET_I(inode);
+	iput(inode);
+	sockfd_put(sock);
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
+/*
+ * It is required for network protocols compiled as modules, like IPv6.
+ */
+EXPORT_SYMBOL_GPL(kevent_socket_notify);
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
+		.dequeue = &kevent_socket_dequeue,
+		.flags = 0,
+	};
+
+	return kevent_add_callbacks(&sc, KEVENT_SOCKET);
+}
+module_init(kevent_init_socket);
diff --git a/net/core/sock.c b/net/core/sock.c
index b77e155..7d5fa3e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1402,6 +1402,7 @@ static void sock_def_wakeup(struct sock *sk)
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
 		wake_up_interruptible_all(sk->sk_sleep);
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_error_report(struct sock *sk)
@@ -1411,6 +1412,7 @@ static void sock_def_error_report(struct sock *sk)
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,0,POLL_ERR); 
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_readable(struct sock *sk, int len)
@@ -1420,6 +1422,7 @@ static void sock_def_readable(struct sock *sk, int len)
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,1,POLL_IN);
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_write_space(struct sock *sk)
@@ -1439,6 +1442,7 @@ static void sock_def_write_space(struct sock *sk)
 	}
 
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
 }
 
 static void sock_def_destruct(struct sock *sk)
@@ -1489,6 +1493,8 @@ void sock_init_data(struct socket *sock, struct sock *sk)
 	sk->sk_state		=	TCP_CLOSE;
 	sk->sk_socket		=	sock;
 
+	kevent_sk_reinit(sk);
+
 	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if(sock)
@@ -1555,8 +1561,10 @@ void fastcall release_sock(struct sock *sk)
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
@@ -36,6 +36,7 @@ void sk_stream_write_space(struct sock *sk)
 			wake_up_interruptible(sk->sk_sleep);
 		if (sock->fasync_list && !(sk->sk_shutdown & SEND_SHUTDOWN))
 			sock_wake_async(sock, 2, POLL_OUT);
+		kevent_socket_notify(sk, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
 	}
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3f884ce..e7dd989 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3119,6 +3119,7 @@ static void tcp_ofo_queue(struct sock *sk)
 
 		__skb_unlink(skb, &tp->out_of_order_queue);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
 		tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 		if(skb->h.th->fin)
 			tcp_fin(skb, sk, skb->h.th);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c83938b..b0dd70d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -61,6 +61,7 @@
 #include <linux/jhash.h>
 #include <linux/init.h>
 #include <linux/times.h>
+#include <linux/kevent.h>
 
 #include <net/icmp.h>
 #include <net/inet_hashtables.h>
@@ -870,6 +871,7 @@ int tcp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	   	reqsk_free(req);
 	} else {
 		inet_csk_reqsk_queue_hash_add(sk, req, TCP_TIMEOUT_INIT);
+		kevent_socket_notify(sk, KEVENT_SOCKET_ACCEPT);
 	}
 	return 0;
 
diff --git a/net/socket.c b/net/socket.c
index 1bc4167..5582b4a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -85,6 +85,7 @@
 #include <linux/kmod.h>
 #include <linux/audit.h>
 #include <linux/wireless.h>
+#include <linux/kevent.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -490,6 +491,8 @@ static struct socket *sock_alloc(void)
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 
+	kevent_socket_reinit(sock);
+
 	get_cpu_var(sockets_in_use)++;
 	put_cpu_var(sockets_in_use);
 	return sock;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b43a278..9e64fb0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1562,8 +1562,10 @@ static int unix_dgram_recvmsg(struct kiocb *iocb, struct socket *sock,
 	struct scm_cookie tmp_scm;
 	struct sock *sk = sock->sk;
 	struct unix_sock *u = unix_sk(sk);
+	struct sock *other;
 	int noblock = flags & MSG_DONTWAIT;
 	struct sk_buff *skb;
+
 	int err;
 
 	err = -EOPNOTSUPP;
@@ -1579,6 +1581,12 @@ static int unix_dgram_recvmsg(struct kiocb *iocb, struct socket *sock,
 		goto out_unlock;
 
 	wake_up_interruptible(&u->peer_wait);
+	other =unix_peer_get(sk);
+	if (other) {
+		kevent_socket_notify(other, KEVENT_SOCKET_SEND);
+		sock_put(other);
+	} else
+		kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
 
 	if (msg->msg_name)
 		unix_copy_addr(msg, skb->sk);
@@ -1673,7 +1681,7 @@ static int unix_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 {
 	struct sock_iocb *siocb = kiocb_to_siocb(iocb);
 	struct scm_cookie tmp_scm;
-	struct sock *sk = sock->sk;
+	struct sock *sk = sock->sk, *other;
 	struct unix_sock *u = unix_sk(sk);
 	struct sockaddr_un *sunaddr=msg->msg_name;
 	int copied = 0;
@@ -1802,6 +1810,14 @@ static int unix_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 		}
 	} while (size);
 
+	other =unix_peer_get(sk);
+	if (other) {
+		kevent_socket_notify(other, KEVENT_SOCKET_SEND);
+		sock_put(other);
+	}
+	if (sk->sk_shutdown & RCV_SHUTDOWN || !other)
+		kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
+
 	mutex_unlock(&u->readlock);
 	scm_recv(sock, msg, siocb->scm, flags);
 out:
@@ -1823,6 +1839,10 @@ static int unix_shutdown(struct socket *sock, int mode)
 			sock_hold(other);
 		unix_state_wunlock(sk);
 		sk->sk_state_change(sk);
+		kevent_socket_notify(sk, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
+		if (other)
+			kevent_socket_notify(other, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
+		kevent_socket_notify(sk, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
 
 		if (other &&
 			(sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET)) {

