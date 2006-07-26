Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWGZIzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWGZIzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWGZIzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:55:53 -0400
Received: from dea.vocord.ru ([217.67.177.50]:15502 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1030458AbWGZIzs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:55:48 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev <netdev@vger.kernel.org>
Subject: [2/4] kevent: network AIO, socket notifications.
In-Reply-To: <11539054952689@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Wed, 26 Jul 2006 13:18:15 +0400
Message-Id: <1153905495613@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset includes socket notifications and network asynchronous IO.
Network AIO is based on kevent and works as usual kevent storage on top
of inode.

When new socket is created it is associated with inode (to save some space,
since inode already has kevent_storage embedded) and when some activity is 
detected appropriate notifications are generated and kevent_naio_callback() 
is called.

When new kevent is being registered, network AIO ->enqueue() callback
simply marks itself like usual socket event watcher. It also locks
physical userspace pages in memory and stores appropriate pointers in
private kevent structure. I have not created additional DMA memory
allocation methods, like Ulrich described in his article, so I handle it
inside NAIO which has some overhead (I posted get_user_pages()
sclability graph some time ago). New set of syscalls to allocate DMAable
memory is in TODO.

Network AIO callback gets pointers to userspace pages and tries to copy
data from receiving skb queue into them using protocol specific
callback. This callback is very similar to ->recvmsg(), so they could
share a lot in future (as far as I recall it worked only with hardware
capable to do checksumming, I'm a bit lazy, it is in TODO)

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>


diff --git a/kernel/kevent/kevent_socket.c b/kernel/kevent/kevent_socket.c
new file mode 100644
index 0000000..c230aaa
--- /dev/null
+++ b/kernel/kevent/kevent_socket.c
@@ -0,0 +1,125 @@
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
+	int err, fput_needed;
+
+	file = fget_light(k->event.id.raw[0], &fput_needed);
+	if (!file)
+		return -ENODEV;
+
+	err = -EINVAL;
+	if (!file->f_dentry || !file->f_dentry->d_inode)
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
+	err = k->callback(k);
+	if (err)
+		goto err_out_dequeue;
+
+	fput_light(file, fput_needed);
+	return err;
+
+err_out_dequeue:
+	kevent_storage_dequeue(k->st, k);
+err_out_iput:
+	iput(inode);
+err_out_fput:
+	fput_light(file, fput_needed);
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
+int kevent_init_socket(struct kevent *k)
+{
+	k->enqueue = &kevent_socket_enqueue;
+	k->dequeue = &kevent_socket_dequeue;
+	k->callback = &kevent_socket_callback;
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

diff --git a/kernel/kevent/kevent_naio.c b/kernel/kevent/kevent_naio.c
new file mode 100644
index 0000000..1c71021
--- /dev/null
+++ b/kernel/kevent/kevent_naio.c
@@ -0,0 +1,239 @@
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
+	int err, fput_needed;
+	struct ukevent uk;
+
+	file = fget_light(ctl_fd, &fput_needed);
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
+	fput_light(file, fput_needed);
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
+	int fput_needed;
+
+	file = fget_light(k->event.id.raw[0], &fput_needed);
+	if (!file)
+		return -ENODEV;
+
+	err = -EINVAL;
+	if (!file->f_dentry || !file->f_dentry->d_inode)
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
+	fput_light(file, fput_needed);
+
+	return err;
+
+err_out_put_pages:
+	for (i=0; i<num; ++i)
+		page_cache_release(page[i]);
+err_out_free:
+	kfree(page);
+err_out_fput:
+	fput_light(file, fput_needed);
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
+int kevent_init_naio(struct kevent *k)
+{
+	k->enqueue = &kevent_naio_enqueue;
+	k->dequeue = &kevent_naio_dequeue;
+	k->callback = &kevent_naio_callback;
+	return 0;
+}

