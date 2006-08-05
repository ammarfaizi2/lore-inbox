Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161321AbWHEMif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161321AbWHEMif (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 08:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWHEMie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 08:38:34 -0400
Received: from dea.vocord.ru ([217.67.177.50]:43244 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1161308AbWHEMib convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 08:38:31 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: [take4 3/4] kevent: Network AIO, socket notifications.
In-Reply-To: <11547829583197@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Sat, 5 Aug 2006 17:02:38 +0400
Message-Id: <11547829583618@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Network AIO, socket notifications.

This patchset includes socket notifications and network asynchronous IO.
Network AIO is based on kevent and works as usual kevent storage on top
of inode.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/include/asm-i386/socket.h b/include/asm-i386/socket.h
index 5755d57..9300678 100644
--- a/include/asm-i386/socket.h
+++ b/include/asm-i386/socket.h
@@ -50,4 +50,6 @@ #define SO_ACCEPTCONN		30
 #define SO_PEERSEC		31
 #define SO_PASSSEC		34
 
+#define SO_ASYNC_SOCK		35
+
 #endif /* _ASM_SOCKET_H */
diff --git a/include/asm-x86_64/socket.h b/include/asm-x86_64/socket.h
index b467026..fc2b49d 100644
--- a/include/asm-x86_64/socket.h
+++ b/include/asm-x86_64/socket.h
@@ -50,4 +50,6 @@ #define SO_ACCEPTCONN		30
 #define SO_PEERSEC             31
 #define SO_PASSSEC		34
 
+#define SO_ASYNC_SOCK		35
+
 #endif /* _ASM_SOCKET_H */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4307e76..9267873 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1283,6 +1283,8 @@ extern struct sk_buff *skb_recv_datagram
 					 int noblock, int *err);
 extern unsigned int    datagram_poll(struct file *file, struct socket *sock,
 				     struct poll_table_struct *wait);
+extern int	       skb_copy_datagram(const struct sk_buff *from, 
+					 int offset, void *dst, int size);
 extern int	       skb_copy_datagram_iovec(const struct sk_buff *from,
 					       int offset, struct iovec *to,
 					       int size);
diff --git a/include/net/sock.h b/include/net/sock.h
index 324b3ea..c43a153 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -48,6 +48,7 @@ #include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/security.h>
+#include <linux/kevent.h>
 
 #include <linux/filter.h>
 
@@ -391,6 +392,8 @@ enum sock_flags {
 	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
 	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
 	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
+	SOCK_ASYNC,
+	SOCK_ASYNC_INUSE,
 };
 
 static inline void sock_copy_flags(struct sock *nsk, struct sock *osk)
@@ -450,6 +453,21 @@ static inline int sk_stream_memory_free(
 
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
@@ -477,6 +495,7 @@ static inline void sk_add_backlog(struct
 		sk->sk_backlog.tail = skb;
 	}
 	skb->next = NULL;
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
 }
 
 #define sk_wait_event(__sk, __timeo, __condition)		\
@@ -548,6 +567,12 @@ struct proto {
 
 	int			(*backlog_rcv) (struct sock *sk, 
 						struct sk_buff *skb);
+	
+	int			(*async_recv) (struct sock *sk, 
+						void *dst, size_t size);
+	int			(*async_send) (struct sock *sk, 
+						struct page **pages, unsigned int poffset, 
+						size_t size);
 
 	/* Keeping track of sk's, looking them up, and port selection methods. */
 	void			(*hash)(struct sock *sk);
@@ -679,21 +704,6 @@ static inline struct kiocb *siocb_to_kio
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
index 0720bdd..5a1899b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -364,6 +364,8 @@ extern int			compat_tcp_setsockopt(struc
 					int level, int optname,
 					char __user *optval, int optlen);
 extern void			tcp_set_keepalive(struct sock *sk, int val);
+extern int			tcp_async_recv(struct sock *sk, void *dst, size_t size);
+extern int			tcp_async_send(struct sock *sk, struct page **pages, unsigned int poffset, size_t size);
 extern int			tcp_recvmsg(struct kiocb *iocb, struct sock *sk,
 					    struct msghdr *msg,
 					    size_t len, int nonblock, 
@@ -857,6 +859,7 @@ static inline int tcp_prequeue(struct so
 			tp->ucopy.memory = 0;
 		} else if (skb_queue_len(&tp->ucopy.prequeue) == 1) {
 			wake_up_interruptible(sk->sk_sleep);
+			kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 			if (!inet_csk_ack_scheduled(sk))
 				inet_csk_reset_xmit_timer(sk, ICSK_TIME_DACK,
 						          (3 * TCP_RTO_MIN) / 4,
diff --git a/kernel/kevent/kevent_naio.c b/kernel/kevent/kevent_naio.c
new file mode 100644
index 0000000..98c357f
--- /dev/null
+++ b/kernel/kevent/kevent_naio.c
@@ -0,0 +1,243 @@
+/*
+ * 	kevent_naio.c
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
+#include <linux/spinlock.h>
+#include <linux/file.h>
+#include <linux/pagemap.h>
+#include <linux/kevent.h>
+
+#include <net/sock.h>
+#include <net/tcp_states.h>
+
+static int kevent_naio_enqueue(struct kevent *k);
+static int kevent_naio_dequeue(struct kevent *k);
+static int kevent_naio_callback(struct kevent *k);
+
+static int kevent_naio_setup_aio(int ctl_fd, int s, void __user *buf, 
+		size_t size, u32 event)
+{
+	struct kevent_user *u;
+	struct file *file;
+	int err;
+	struct ukevent uk;
+
+	file = fget(ctl_fd);
+	if (!file)
+		return -ENODEV;
+
+	u = file->private_data;
+	if (!u) {
+		err = -EINVAL;
+		goto err_out_fput;
+	}
+
+	memset(&uk, 0, sizeof(struct ukevent));
+	uk.type = KEVENT_NAIO;
+	uk.ptr = buf;
+	uk.req_flags = KEVENT_REQ_ONESHOT;
+	uk.event = event;
+	uk.id.raw[0] = s;
+	uk.id.raw[1] = size;
+
+	err = kevent_user_add_ukevent(&uk, u);
+
+err_out_fput:
+	fput(file);
+	return err;
+}
+
+asmlinkage long sys_aio_recv(int ctl_fd, int s, void __user *buf, 
+		size_t size, unsigned flags)
+{
+	return kevent_naio_setup_aio(ctl_fd, s, buf, size, KEVENT_SOCKET_RECV);
+}
+
+asmlinkage long sys_aio_send(int ctl_fd, int s, void __user *buf, 
+		size_t size, unsigned flags)
+{
+	return kevent_naio_setup_aio(ctl_fd, s, buf, size, KEVENT_SOCKET_SEND);
+}
+
+static int kevent_naio_enqueue(struct kevent *k)
+{
+	int err, i;
+	struct page **page;
+	void *addr;
+	unsigned int size = k->event.id.raw[1];
+	int num = size/PAGE_SIZE;
+	struct file *file;
+	struct sock *sk = NULL;
+
+	file = fget(k->event.id.raw[0]);
+	if (!file)
+		return -ENODEV;
+
+	err = -EINVAL;
+	if (!file->f_dentry || !file->f_dentry->d_inode)
+		goto err_out_fput;
+	if (file->f_op != &socket_file_ops)
+		goto err_out_fput;
+
+	sk = SOCKET_I(file->f_dentry->d_inode)->sk;
+
+	err = -ESOCKTNOSUPPORT;
+	if (!sk || !sk->sk_prot->async_recv || !sk->sk_prot->async_send || 
+		!sock_flag(sk, SOCK_ASYNC))
+		goto err_out_fput;
+	
+	addr = k->event.ptr;
+	if (((unsigned long)addr & PAGE_MASK) != (unsigned long)addr)
+		num++;
+
+	page = kmalloc(sizeof(struct page *) * num, GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	down_read(&current->mm->mmap_sem);
+	err = get_user_pages(current, current->mm, (unsigned long)addr, 
+			num, 1, 0, page, NULL);
+	up_read(&current->mm->mmap_sem);
+	if (err <= 0)
+		goto err_out_free;
+	num = err;
+
+	k->event.ret_data[0] = num;
+	k->event.ret_data[1] = offset_in_page(k->event.ptr);
+	k->priv = page;
+
+	sk->sk_allocation = GFP_ATOMIC;
+
+	spin_lock_bh(&sk->sk_lock.slock);
+	err = kevent_socket_enqueue(k);
+	spin_unlock_bh(&sk->sk_lock.slock);
+	if (err)
+		goto err_out_put_pages;
+
+	fput(file);
+
+	return err;
+
+err_out_put_pages:
+	for (i=0; i<num; ++i)
+		page_cache_release(page[i]);
+err_out_free:
+	kfree(page);
+err_out_fput:
+	fput(file);
+
+	return err;
+}
+
+static int kevent_naio_dequeue(struct kevent *k)
+{
+	int err, i, num;
+	struct page **page = k->priv;
+
+	num = k->event.ret_data[0];
+
+	err = kevent_socket_dequeue(k);
+
+	for (i=0; i<num; ++i)
+		page_cache_release(page[i]);
+
+	kfree(k->priv);
+	k->priv = NULL;
+
+	return err;
+}
+
+static int kevent_naio_callback(struct kevent *k)
+{
+	struct inode *inode = k->st->origin;
+	struct sock *sk = SOCKET_I(inode)->sk;
+	unsigned int size = k->event.id.raw[1];
+	unsigned int off = k->event.ret_data[1];
+	struct page **pages = k->priv, *page;
+	int ready = 0, num = off/PAGE_SIZE, err = 0, send = 0;
+	void *ptr, *optr;
+	unsigned int len;
+
+	if (!sock_flag(sk, SOCK_ASYNC))
+		return -1;
+
+	if (k->event.event & KEVENT_SOCKET_SEND)
+		send = 1;
+	else if (!(k->event.event & KEVENT_SOCKET_RECV))
+		return -EINVAL;
+
+	/*
+	 * sk_prot->async_*() can return either number of bytes processed,
+	 * or negative error value, or zero if socket is closed.
+	 */
+
+	if (!send) {
+		page = pages[num];
+
+		optr = ptr = kmap_atomic(page, KM_IRQ0);
+		if (!ptr)
+			return -ENOMEM;
+
+		ptr += off % PAGE_SIZE;
+		len = min_t(unsigned int, PAGE_SIZE - (ptr - optr), size);
+
+		err = sk->sk_prot->async_recv(sk, ptr, len);
+
+		kunmap_atomic(optr, KM_IRQ0);
+	} else {
+		len = size;
+		err = sk->sk_prot->async_send(sk, pages, off, size);
+	}
+
+	if (err > 0) {
+		num++;
+		size -= err;
+		off += err;
+	}
+
+	k->event.ret_data[1] = off;
+	k->event.id.raw[1] = size;
+
+	if (err == 0 || (err < 0 && err != -EAGAIN))
+		ready = -1;
+
+	if (!size)
+		ready = 1;
+#if 0
+	printk("%s: sk=%p, k=%p, size=%4u, off=%4u, err=%3d, ready=%1d.\n",
+			__func__, sk, k, size, off, err, ready);
+#endif
+
+	return ready;
+}
+
+static int __init kevent_init_naio(void)
+{
+	struct kevent_callbacks *nc = &kevent_registered_callbacks[KEVENT_NAIO];
+
+	nc->callback = &kevent_naio_enqueue;
+	nc->dequeue = &kevent_naio_dequeue;
+	nc->callback = &kevent_naio_callback;
+	return 0;
+}
+late_initcall(kevent_init_naio);
diff --git a/kernel/kevent/kevent_socket.c b/kernel/kevent/kevent_socket.c
new file mode 100644
index 0000000..59f50ba
--- /dev/null
+++ b/kernel/kevent/kevent_socket.c
@@ -0,0 +1,149 @@
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
+	struct file *file;
+	struct inode *inode;
+	int err;
+
+	file = fget(k->event.id.raw[0]);
+	if (!file)
+		return -ENODEV;
+
+	err = -EINVAL;
+	if (!file->f_dentry || !file->f_dentry->d_inode)
+		goto err_out_fput;
+	
+	if (file->f_op != &socket_file_ops)
+		goto err_out_fput;
+
+	inode = igrab(file->f_dentry->d_inode);
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
+	fput(file);
+	return err;
+
+err_out_dequeue:
+	kevent_storage_dequeue(k->st, k);
+err_out_iput:
+	iput(inode);
+err_out_fput:
+	fput(file);
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
+	if (sk->sk_socket && !test_and_set_bit(SOCK_ASYNC_INUSE, &sk->sk_flags)) {
+		kevent_storage_ready(&SOCK_INODE(sk->sk_socket)->st, NULL, event);
+		sock_reset_flag(sk, SOCK_ASYNC_INUSE);
+	}
+}
+
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
+
+static int __init kevent_init_socket(void)
+{
+	struct kevent_callbacks *sc = &kevent_registered_callbacks[KEVENT_SOCKET];
+
+	sc->enqueue = &kevent_socket_enqueue;
+	sc->dequeue = &kevent_socket_dequeue;
+	sc->callback = &kevent_socket_callback;
+	return 0;
+}
+late_initcall(kevent_init_socket);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index aecddcc..493245b 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -236,6 +236,60 @@ void skb_kill_datagram(struct sock *sk, 
 EXPORT_SYMBOL(skb_kill_datagram);
 
 /**
+ *	skb_copy_datagram - Copy a datagram.
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@to: pointer to copy to
+ *	@len: amount of data to copy from buffer to iovec
+ */
+int skb_copy_datagram(const struct sk_buff *skb, int offset,
+			    void *to, int len)
+{
+	int i, fraglen, end = 0;
+	struct sk_buff *next = skb_shinfo(skb)->frag_list;
+
+	if (!len)
+		return 0;
+
+next_skb:
+	fraglen = skb_headlen(skb);
+	i = -1;
+
+	while (1) {
+		int start = end;
+
+		if ((end += fraglen) > offset) {
+			int copy = end - offset, o = offset - start;
+
+			if (copy > len)
+				copy = len;
+			if (i == -1)
+				memcpy(to, skb->data + o, copy);
+			else {
+				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+				struct page *page = frag->page;
+				void *p = kmap(page) + frag->page_offset + o;
+				memcpy(to, p, copy);
+				kunmap(page);
+			}
+			if (!(len -= copy))
+				return 0;
+			offset += copy;
+		}
+		if (++i >= skb_shinfo(skb)->nr_frags)
+			break;
+		fraglen = skb_shinfo(skb)->frags[i].size;
+	}
+	if (next) {
+		skb = next;
+		BUG_ON(skb_shinfo(skb)->frag_list);
+		next = skb->next;
+		goto next_skb;
+	}
+	return -EFAULT;
+}
+
+/**
  *	skb_copy_datagram_iovec - Copy a datagram to an iovec.
  *	@skb: buffer to copy
  *	@offset: offset in the buffer to start copying from
@@ -530,6 +584,7 @@ unsigned int datagram_poll(struct file *
 
 EXPORT_SYMBOL(datagram_poll);
 EXPORT_SYMBOL(skb_copy_and_csum_datagram_iovec);
+EXPORT_SYMBOL(skb_copy_datagram);
 EXPORT_SYMBOL(skb_copy_datagram_iovec);
 EXPORT_SYMBOL(skb_free_datagram);
 EXPORT_SYMBOL(skb_recv_datagram);
diff --git a/net/core/sock.c b/net/core/sock.c
index 51fcfbc..138ce90 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -617,6 +617,16 @@ #endif
 			spin_unlock_bh(&sk->sk_lock.slock);
 			ret = -ENONET;
 			break;
+#ifdef CONFIG_KEVENT_SOCKET
+		case SO_ASYNC_SOCK:
+			spin_lock_bh(&sk->sk_lock.slock);
+			if (valbool)
+				sock_set_flag(sk, SOCK_ASYNC);
+			else
+				sock_reset_flag(sk, SOCK_ASYNC);
+			spin_unlock_bh(&sk->sk_lock.slock);
+			break;
+#endif
 
 		case SO_PASSSEC:
 			if (valbool)
@@ -1406,6 +1416,7 @@ static void sock_def_wakeup(struct sock 
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
 		wake_up_interruptible_all(sk->sk_sleep);
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_error_report(struct sock *sk)
@@ -1415,6 +1426,7 @@ static void sock_def_error_report(struct
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,0,POLL_ERR); 
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_readable(struct sock *sk, int len)
@@ -1424,6 +1436,7 @@ static void sock_def_readable(struct soc
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,1,POLL_IN);
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_write_space(struct sock *sk)
@@ -1443,6 +1456,7 @@ static void sock_def_write_space(struct 
 	}
 
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
 }
 
 static void sock_def_destruct(struct sock *sk)
@@ -1493,6 +1507,8 @@ #endif
 	sk->sk_state		=	TCP_CLOSE;
 	sk->sk_socket		=	sock;
 
+	kevent_sk_reinit(sk);
+
 	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if(sock)
@@ -1559,8 +1575,10 @@ void fastcall release_sock(struct sock *
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
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f6a2d92..e878a41 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -206,6 +206,7 @@
  *					lingertime == 0 (RFC 793 ABORT Call)
  *	Hirokazu Takahashi	:	Use copy_from_user() instead of
  *					csum_and_copy_from_user() if possible.
+ *	Evgeniy Polyakov	:	Network asynchronous IO.
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -1085,6 +1086,301 @@ int tcp_read_sock(struct sock *sk, read_
 }
 
 /*
+ * Must be called with locked sock.
+ */
+int tcp_async_send(struct sock *sk, struct page **pages, unsigned int poffset, size_t len)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int mss_now, size_goal;
+	int err = -EAGAIN;
+	ssize_t copied;
+
+	/* Wait for a connection to finish. */
+	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT))
+		goto out_err;
+
+	clear_bit(SOCK_ASYNC_NOSPACE, &sk->sk_socket->flags);
+
+	mss_now = tcp_current_mss(sk, 1);
+	size_goal = tp->xmit_size_goal;
+	copied = 0;
+
+	err = -EPIPE;
+	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN) || sock_flag(sk, SOCK_DONE) ||
+			(sk->sk_state == TCP_CLOSE) || (atomic_read(&sk->sk_refcnt) == 1))
+		goto do_error;
+
+	while (len > 0) {
+		struct sk_buff *skb = sk->sk_write_queue.prev;
+		struct page *page = pages[poffset / PAGE_SIZE];
+		int copy, i, can_coalesce;
+		int offset = poffset % PAGE_SIZE;
+		int size = min_t(size_t, len, PAGE_SIZE - offset);
+
+		if (!sk->sk_send_head || (copy = size_goal - skb->len) <= 0) {
+new_segment:
+			if (!sk_stream_memory_free(sk))
+				goto wait_for_sndbuf;
+
+			skb = sk_stream_alloc_pskb(sk, 0, 0,
+						   sk->sk_allocation);
+			if (!skb)
+				goto wait_for_memory;
+
+			skb_entail(sk, tp, skb);
+			copy = size_goal;
+		}
+
+		if (copy > size)
+			copy = size;
+
+		i = skb_shinfo(skb)->nr_frags;
+		can_coalesce = skb_can_coalesce(skb, i, page, offset);
+		if (!can_coalesce && i >= MAX_SKB_FRAGS) {
+			tcp_mark_push(tp, skb);
+			goto new_segment;
+		}
+		if (!sk_stream_wmem_schedule(sk, copy))
+			goto wait_for_memory;
+		
+		if (can_coalesce) {
+			skb_shinfo(skb)->frags[i - 1].size += copy;
+		} else {
+			get_page(page);
+			skb_fill_page_desc(skb, i, page, offset, copy);
+		}
+
+		skb->len += copy;
+		skb->data_len += copy;
+		skb->truesize += copy;
+		sk->sk_wmem_queued += copy;
+		sk->sk_forward_alloc -= copy;
+		skb->ip_summed = CHECKSUM_HW;
+		tp->write_seq += copy;
+		TCP_SKB_CB(skb)->end_seq += copy;
+		skb_shinfo(skb)->gso_segs = 0;
+
+		if (!copied)
+			TCP_SKB_CB(skb)->flags &= ~TCPCB_FLAG_PSH;
+
+		copied += copy;
+		poffset += copy;
+		if (!(len -= copy))
+			goto out;
+
+		if (skb->len < mss_now)
+			continue;
+
+		if (forced_push(tp)) {
+			tcp_mark_push(tp, skb);
+			__tcp_push_pending_frames(sk, tp, mss_now, TCP_NAGLE_PUSH);
+		} else if (skb == sk->sk_send_head)
+			tcp_push_one(sk, mss_now);
+		continue;
+
+wait_for_sndbuf:
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+wait_for_memory:
+		if (copied)
+			tcp_push(sk, tp, 0, mss_now, TCP_NAGLE_PUSH);
+
+		err = -EAGAIN;
+		goto do_error;
+	}
+
+out:
+	if (copied)
+		tcp_push(sk, tp, 0, mss_now, tp->nonagle);
+	return copied;
+
+do_error:
+	if (copied)
+		goto out;
+out_err:
+	return sk_stream_error(sk, 0, err);
+}
+
+/*
+ * Must be called with locked sock.
+ */
+int tcp_async_recv(struct sock *sk, void *dst, size_t len)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int copied = 0;
+	u32 *seq;
+	unsigned long used;
+	int err;
+	int target;		/* Read at least this many bytes */
+	int copied_early = 0;
+
+	TCP_CHECK_TIMER(sk);
+
+	err = -ENOTCONN;
+	if (sk->sk_state == TCP_LISTEN)
+		goto out;
+
+	seq = &tp->copied_seq;
+
+	target = sock_rcvlowat(sk, 0, len);
+
+	do {
+		struct sk_buff *skb;
+		u32 offset;
+
+		/* Are we at urgent data? Stop if we have read anything or have SIGURG pending. */
+		if (tp->urg_data && tp->urg_seq == *seq) {
+			if (copied)
+				break;
+		}
+
+		/* Next get a buffer. */
+
+		skb = skb_peek(&sk->sk_receive_queue);
+		do {
+			if (!skb)
+				break;
+
+			/* Now that we have two receive queues this
+			 * shouldn't happen.
+			 */
+			if (before(*seq, TCP_SKB_CB(skb)->seq)) {
+				printk(KERN_INFO "async_recv bug: copied %X "
+				       "seq %X\n", *seq, TCP_SKB_CB(skb)->seq);
+				break;
+			}
+			offset = *seq - TCP_SKB_CB(skb)->seq;
+			if (skb->h.th->syn)
+				offset--;
+			if (offset < skb->len)
+				goto found_ok_skb;
+			if (skb->h.th->fin)
+				goto found_fin_ok;
+			skb = skb->next;
+		} while (skb != (struct sk_buff *)&sk->sk_receive_queue);
+
+		if (copied)
+			break;
+
+		if (sock_flag(sk, SOCK_DONE))
+			break;
+
+		if (sk->sk_err) {
+			copied = sock_error(sk);
+			break;
+		}
+
+		if (sk->sk_shutdown & RCV_SHUTDOWN)
+			break;
+
+		if (sk->sk_state == TCP_CLOSE) {
+			if (!sock_flag(sk, SOCK_DONE)) {
+				/* This occurs when user tries to read
+				 * from never connected socket.
+				 */
+				copied = -ENOTCONN;
+				break;
+			}
+			break;
+		}
+
+		copied = -EAGAIN;
+		break;
+
+	found_ok_skb:
+		/* Ok so how much can we use? */
+		used = skb->len - offset;
+		if (len < used)
+			used = len;
+
+		/* Do we have urgent data here? */
+		if (tp->urg_data) {
+			u32 urg_offset = tp->urg_seq - *seq;
+			if (urg_offset < used) {
+				if (!urg_offset) {
+					if (!sock_flag(sk, SOCK_URGINLINE)) {
+						++*seq;
+						offset++;
+						used--;
+						if (!used)
+							goto skip_copy;
+					}
+				} else
+					used = urg_offset;
+			}
+		}
+#ifdef CONFIG_NET_DMA
+		if (!tp->ucopy.dma_chan && tp->ucopy.pinned_list)
+			tp->ucopy.dma_chan = get_softnet_dma();
+
+		if (tp->ucopy.dma_chan) {
+			tp->ucopy.dma_cookie = dma_skb_copy_datagram_iovec(
+				tp->ucopy.dma_chan, skb, offset,
+				msg->msg_iov, used,
+				tp->ucopy.pinned_list);
+
+			if (tp->ucopy.dma_cookie < 0) {
+
+				printk(KERN_ALERT "dma_cookie < 0\n");
+
+				/* Exception. Bailout! */
+				if (!copied)
+					copied = -EFAULT;
+				break;
+			}
+			if ((offset + used) == skb->len)
+				copied_early = 1;
+
+		} else
+#endif
+		{
+			err = skb_copy_datagram(skb, offset, dst, used);
+			if (err) {
+				/* Exception. Bailout! */
+				if (!copied)
+					copied = -EFAULT;
+				break;
+			}
+		}
+
+		*seq += used;
+		copied += used;
+		len -= used;
+		dst += used;
+
+		tcp_rcv_space_adjust(sk);
+
+skip_copy:
+		if (tp->urg_data && after(tp->copied_seq, tp->urg_seq)) {
+			tp->urg_data = 0;
+			tcp_fast_path_check(sk, tp);
+		}
+		if (used + offset < skb->len)
+			continue;
+
+		if (skb->h.th->fin)
+			goto found_fin_ok;
+		sk_eat_skb(sk, skb, copied_early);
+		continue;
+
+	found_fin_ok:
+		/* Process the FIN. */
+		++*seq;
+		sk_eat_skb(sk, skb, copied_early);
+		break;
+	} while (len > 0);
+
+	/* Clean up data we have read: This will do ACK frames. */
+	tcp_cleanup_rbuf(sk, copied);
+
+	TCP_CHECK_TIMER(sk);
+	return copied;
+
+out:
+	TCP_CHECK_TIMER(sk);
+	return err;
+}
+
+/*
  *	This routine copies from a sock struct into the user buffer.
  *
  *	Technical note: in 2.3 we work on _locked_ socket, so that
@@ -2342,6 +2638,8 @@ EXPORT_SYMBOL(tcp_getsockopt);
 EXPORT_SYMBOL(tcp_ioctl);
 EXPORT_SYMBOL(tcp_poll);
 EXPORT_SYMBOL(tcp_read_sock);
+EXPORT_SYMBOL(tcp_async_recv);
+EXPORT_SYMBOL(tcp_async_send);
 EXPORT_SYMBOL(tcp_recvmsg);
 EXPORT_SYMBOL(tcp_sendmsg);
 EXPORT_SYMBOL(tcp_sendpage);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 738dad9..f70d045 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3112,6 +3112,7 @@ static void tcp_ofo_queue(struct sock *s
 
 		__skb_unlink(skb, &tp->out_of_order_queue);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
 		tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 		if(skb->h.th->fin)
 			tcp_fin(skb, sk, skb->h.th);
@@ -3955,7 +3956,8 @@ int tcp_rcv_established(struct sock *sk,
 			int copied_early = 0;
 
 			if (tp->copied_seq == tp->rcv_nxt &&
-			    len - tcp_header_len <= tp->ucopy.len) {
+			    len - tcp_header_len <= tp->ucopy.len &&
+			    !sock_async(sk)) {
 #ifdef CONFIG_NET_DMA
 				if (tcp_dma_try_early_copy(sk, skb, tcp_header_len)) {
 					copied_early = 1;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f6f39e8..ae4f23c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -61,6 +61,7 @@ #include <linux/cache.h>
 #include <linux/jhash.h>
 #include <linux/init.h>
 #include <linux/times.h>
+#include <linux/kevent.h>
 
 #include <net/icmp.h>
 #include <net/inet_hashtables.h>
@@ -868,6 +869,7 @@ #endif
 	   	reqsk_free(req);
 	} else {
 		inet_csk_reqsk_queue_hash_add(sk, req, TCP_TIMEOUT_INIT);
+		kevent_socket_notify(sk, KEVENT_SOCKET_ACCEPT);
 	}
 	return 0;
 
@@ -1108,24 +1110,30 @@ process:
 
 	skb->dev = NULL;
 
-	bh_lock_sock_nested(sk);
 	ret = 0;
-	if (!sock_owned_by_user(sk)) {
+	if (sock_async(sk)) {
+		spin_lock_bh(&sk->sk_lock.slock);
+		ret = tcp_v4_do_rcv(sk, skb);
+		spin_unlock_bh(&sk->sk_lock.slock);
+	} else {
+		bh_lock_sock_nested(sk);
+		if (!sock_owned_by_user(sk)) {
 #ifdef CONFIG_NET_DMA
-		struct tcp_sock *tp = tcp_sk(sk);
-		if (!tp->ucopy.dma_chan && tp->ucopy.pinned_list)
-			tp->ucopy.dma_chan = get_softnet_dma();
-		if (tp->ucopy.dma_chan)
-			ret = tcp_v4_do_rcv(sk, skb);
-		else
+			struct tcp_sock *tp = tcp_sk(sk);
+			if (!tp->ucopy.dma_chan && tp->ucopy.pinned_list)
+				tp->ucopy.dma_chan = get_softnet_dma();
+			if (tp->ucopy.dma_chan)
+				ret = tcp_v4_do_rcv(sk, skb);
+			else
 #endif
-		{
-			if (!tcp_prequeue(sk, skb))
-			ret = tcp_v4_do_rcv(sk, skb);
-		}
-	} else
-		sk_add_backlog(sk, skb);
-	bh_unlock_sock(sk);
+			{
+				if (!tcp_prequeue(sk, skb))
+				ret = tcp_v4_do_rcv(sk, skb);
+			}
+		} else
+			sk_add_backlog(sk, skb);
+		bh_unlock_sock(sk);
+	}
 
 	sock_put(sk);
 
@@ -1849,6 +1857,8 @@ struct proto tcp_prot = {
 	.getsockopt		= tcp_getsockopt,
 	.sendmsg		= tcp_sendmsg,
 	.recvmsg		= tcp_recvmsg,
+	.async_recv		= tcp_async_recv,
+	.async_send		= tcp_async_send,
 	.backlog_rcv		= tcp_v4_do_rcv,
 	.hash			= tcp_v4_hash,
 	.unhash			= tcp_unhash,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 923989d..a5d3ac8 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1230,22 +1230,28 @@ process:
 
 	skb->dev = NULL;
 
-	bh_lock_sock(sk);
 	ret = 0;
-	if (!sock_owned_by_user(sk)) {
+	if (sock_async(sk)) {
+		spin_lock_bh(&sk->sk_lock.slock);
+		ret = tcp_v4_do_rcv(sk, skb);
+		spin_unlock_bh(&sk->sk_lock.slock);
+	} else {
+		bh_lock_sock(sk);
+		if (!sock_owned_by_user(sk)) {
 #ifdef CONFIG_NET_DMA
-                struct tcp_sock *tp = tcp_sk(sk);
-                if (tp->ucopy.dma_chan)
-                        ret = tcp_v6_do_rcv(sk, skb);
-                else
-#endif
-		{
-			if (!tcp_prequeue(sk, skb))
+			struct tcp_sock *tp = tcp_sk(sk);
+			if (tp->ucopy.dma_chan)
 				ret = tcp_v6_do_rcv(sk, skb);
-		}
-	} else
-		sk_add_backlog(sk, skb);
-	bh_unlock_sock(sk);
+			else
+#endif
+			{
+				if (!tcp_prequeue(sk, skb))
+					ret = tcp_v6_do_rcv(sk, skb);
+			}
+		} else
+			sk_add_backlog(sk, skb);
+		bh_unlock_sock(sk);
+	}
 
 	sock_put(sk);
 	return ret ? -1 : 0;
@@ -1596,6 +1602,8 @@ struct proto tcpv6_prot = {
 	.getsockopt		= tcp_getsockopt,
 	.sendmsg		= tcp_sendmsg,
 	.recvmsg		= tcp_recvmsg,
+	.async_recv		= tcp_async_recv,
+	.async_send		= tcp_async_send,
 	.backlog_rcv		= tcp_v6_do_rcv,
 	.hash			= tcp_v6_hash,
 	.unhash			= tcp_unhash,

