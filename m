Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWGZI4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWGZI4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWGZI4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:56:24 -0400
Received: from dea.vocord.ru ([217.67.177.50]:16014 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1030459AbWGZIz6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:55:58 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev <netdev@vger.kernel.org>
Subject: [1/4] kevent: core files.
In-Reply-To: <11539054941027@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Wed, 26 Jul 2006 13:18:15 +0400
Message-Id: <11539054952689@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch includes core kevent files:
 - userspace controlling
 - kernelspace interfaces
 - initialization
 - notification state machines

It might also inlclude parts from other subsystem (like network related
syscalls, so it is possible that it will not compile without other
patches applied).

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/arch/i386/kernel/syscall_table.S b/arch/i386/kernel/syscall_table.S
index af56987..93e23ff 100644
--- a/arch/i386/kernel/syscall_table.S
+++ b/arch/i386/kernel/syscall_table.S
@@ -316,3 +316,7 @@ ENTRY(sys_call_table)
 	.long sys_sync_file_range
 	.long sys_tee			/* 315 */
 	.long sys_vmsplice
+	.long sys_aio_recv
+	.long sys_aio_send
+	.long sys_aio_sendfile
+	.long sys_kevent_ctl
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index 5a92fed..534d516 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -696,4 +696,8 @@ #endif
 	.quad sys_sync_file_range
 	.quad sys_tee
 	.quad compat_sys_vmsplice
+	.quad sys_aio_recv
+	.quad sys_aio_send
+	.quad sys_aio_sendfile
+	.quad sys_kevent_ctl
 ia32_syscall_end:		

diff --git a/include/asm-i386/socket.h b/include/asm-i386/socket.h
index 802ae76..3473f5c 100644
--- a/include/asm-i386/socket.h
+++ b/include/asm-i386/socket.h
@@ -49,4 +49,6 @@ #define SO_ACCEPTCONN		30
 
 #define SO_PEERSEC		31
 
+#define SO_ASYNC_SOCK		34
+
 #endif /* _ASM_SOCKET_H */
diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index de2ccc1..52f8642 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -322,10 +322,14 @@ #define __NR_splice		313
 #define __NR_sync_file_range	314
 #define __NR_tee		315
 #define __NR_vmsplice		316
+#define __NR_aio_recv		317
+#define __NR_aio_send		318
+#define __NR_aio_sendfile	319
+#define __NR_kevent_ctl		320
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 317
+#define NR_syscalls 321
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff --git a/include/asm-x86_64/socket.h b/include/asm-x86_64/socket.h
index f2cdbea..1f31f86 100644
--- a/include/asm-x86_64/socket.h
+++ b/include/asm-x86_64/socket.h
@@ -49,4 +49,6 @@ #define SO_ACCEPTCONN		30
 
 #define SO_PEERSEC             31
 
+#define SO_ASYNC_SOCK		34
+
 #endif /* _ASM_SOCKET_H */
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index 0aff22b..352c34b 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -617,11 +617,18 @@ #define __NR_sync_file_range	277
 __SYSCALL(__NR_sync_file_range, sys_sync_file_range)
 #define __NR_vmsplice		278
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
+#define __NR_aio_recv		279
+__SYSCALL(__NR_aio_recv, sys_aio_recv)
+#define __NR_aio_send		280
+__SYSCALL(__NR_aio_send, sys_aio_send)
+#define __NR_aio_sendfile	281
+__SYSCALL(__NR_aio_sendfile, sys_aio_sendfile)
+#define __NR_kevent_ctl		282
+__SYSCALL(__NR_kevent_ctl, sys_kevent_ctl)
 
 #ifdef __KERNEL__
 
-#define __NR_syscall_max __NR_vmsplice
-
+#define __NR_syscall_max __NR_kevent_ctl
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */

diff --git a/include/linux/kevent.h b/include/linux/kevent.h
new file mode 100644
index 0000000..e94a7bf
--- /dev/null
+++ b/include/linux/kevent.h
@@ -0,0 +1,263 @@
+/*
+ * 	kevent.h
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
+#ifndef __KEVENT_H
+#define __KEVENT_H
+
+/*
+ * Kevent request flags.
+ */
+
+#define KEVENT_REQ_ONESHOT	0x1		/* Process this event only once and then dequeue. */
+
+/*
+ * Kevent return flags.
+ */
+#define KEVENT_RET_BROKEN	0x1		/* Kevent is broken. */
+#define KEVENT_RET_DONE		0x2		/* Kevent processing was finished successfully. */
+
+/*
+ * Kevent type set.
+ */
+#define KEVENT_SOCKET 		0
+#define KEVENT_INODE		1
+#define KEVENT_TIMER		2
+#define KEVENT_POLL		3
+#define KEVENT_NAIO		4
+#define KEVENT_AIO		5
+#define	KEVENT_MAX		6
+
+/*
+ * Per-type event sets.
+ * Number of per-event sets should be exactly as number of kevent types.
+ */
+
+/*
+ * Timer events.
+ */
+#define	KEVENT_TIMER_FIRED	0x1
+
+/*
+ * Socket/network asynchronous IO events.
+ */
+#define	KEVENT_SOCKET_RECV	0x1
+#define	KEVENT_SOCKET_ACCEPT	0x2
+#define	KEVENT_SOCKET_SEND	0x4
+
+/*
+ * Inode events.
+ */
+#define	KEVENT_INODE_CREATE	0x1
+#define	KEVENT_INODE_REMOVE	0x2
+
+/*
+ * Poll events.
+ */
+#define	KEVENT_POLL_POLLIN	0x0001
+#define	KEVENT_POLL_POLLPRI	0x0002
+#define	KEVENT_POLL_POLLOUT	0x0004
+#define	KEVENT_POLL_POLLERR	0x0008
+#define	KEVENT_POLL_POLLHUP	0x0010
+#define	KEVENT_POLL_POLLNVAL	0x0020
+
+#define	KEVENT_POLL_POLLRDNORM	0x0040
+#define	KEVENT_POLL_POLLRDBAND	0x0080
+#define	KEVENT_POLL_POLLWRNORM	0x0100
+#define	KEVENT_POLL_POLLWRBAND	0x0200
+#define	KEVENT_POLL_POLLMSG	0x0400
+#define	KEVENT_POLL_POLLREMOVE	0x1000
+
+/*
+ * Asynchronous IO events.
+ */
+#define	KEVENT_AIO_BIO		0x1
+
+#define KEVENT_MASK_ALL		0xffffffff	/* Mask of all possible event values. */
+#define KEVENT_MASK_EMPTY	0x0		/* Empty mask of ready events. */
+
+struct kevent_id
+{
+	__u32		raw[2];
+};
+
+struct ukevent
+{
+	struct kevent_id	id;			/* Id of this request, e.g. socket number, file descriptor and so on... */
+	__u32			type;			/* Event type, e.g. KEVENT_SOCK, KEVENT_INODE, KEVENT_TIMER and so on... */
+	__u32			event;			/* Event itself, e.g. SOCK_ACCEPT, INODE_CREATED, TIMER_FIRED... */
+	__u32			req_flags;		/* Per-event request flags */
+	__u32			ret_flags;		/* Per-event return flags */
+	__u32			ret_data[2];		/* Event return data. Event originator fills it with anything it likes. */
+	union {
+		__u32		user[2];		/* User's data. It is not used, just copied to/from user. */
+		void		*ptr;
+	};
+};
+
+#define	KEVENT_CTL_ADD 		0
+#define	KEVENT_CTL_REMOVE	1
+#define	KEVENT_CTL_MODIFY	2
+#define	KEVENT_CTL_WAIT		3
+#define	KEVENT_CTL_INIT		4
+
+struct kevent_user_control
+{
+	unsigned int		cmd;			/* Control command, e.g. KEVENT_ADD, KEVENT_REMOVE... */
+	unsigned int		num;			/* Number of ukevents this strucutre controls. */
+	unsigned int		timeout;		/* Timeout in milliseconds waiting for "num" events to become ready. */
+};
+
+#define KEVENT_USER_SYMBOL	'K'
+#define KEVENT_USER_CTL		_IOWR(KEVENT_USER_SYMBOL, 0, struct kevent_user_control)
+#define KEVENT_USER_WAIT	_IOWR(KEVENT_USER_SYMBOL, 1, struct kevent_user_control)
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/kevent_storage.h>
+#include <asm/semaphore.h>
+
+struct inode;
+struct dentry;
+struct sock;
+
+struct kevent;
+struct kevent_storage;
+typedef int (* kevent_callback_t)(struct kevent *);
+
+struct kevent
+{
+	struct ukevent		event;
+	spinlock_t		lock;			/* This lock protects ukevent manipulations, e.g. ret_flags changes. */
+
+	struct list_head	kevent_entry;		/* Entry of user's queue. */
+	struct list_head	storage_entry;		/* Entry of origin's queue. */
+	struct list_head	ready_entry;		/* Entry of user's ready. */
+
+	struct kevent_user	*user;			/* User who requested this kevent. */
+	struct kevent_storage	*st;			/* Kevent container. */
+
+	kevent_callback_t	callback;		/* Is called each time new event has been caught. */
+	kevent_callback_t	enqueue;		/* Is called each time new event is queued. */
+	kevent_callback_t	dequeue;		/* Is called each time event is dequeued. */
+
+	void			*priv;			/* Private data for different storages. 
+							 * poll()/select storage has a list of wait_queue_t containers 
+							 * for each ->poll() { poll_wait()' } here.
+							 */
+};
+
+#define KEVENT_HASH_MASK	0xff
+
+struct kevent_list
+{
+	struct list_head	kevent_list;		/* List of all kevents. */
+	spinlock_t 		kevent_lock;		/* Protects all manipulations with queue of kevents. */
+};
+
+struct kevent_user
+{
+	struct kevent_list	kqueue[KEVENT_HASH_MASK+1];
+	unsigned int		kevent_num;		/* Number of queued kevents. */
+
+	struct list_head	ready_list;		/* List of ready kevents. */
+	unsigned int		ready_num;		/* Number of ready kevents. */
+	spinlock_t 		ready_lock;		/* Protects all manipulations with ready queue. */
+
+	unsigned int		max_ready_num;		/* Requested number of kevents. */
+
+	struct semaphore	ctl_mutex;		/* Protects against simultaneous kevent_user control manipulations. */
+	struct semaphore	wait_mutex;		/* Protects against simultaneous kevent_user waits. */
+	wait_queue_head_t	wait;			/* Wait until some events are ready. */
+
+	atomic_t		refcnt;			/* Reference counter, increased for each new kevent. */
+#ifdef CONFIG_KEVENT_USER_STAT
+	unsigned long		im_num;
+	unsigned long		wait_num;
+	unsigned long		total;
+#endif
+};
+
+#define KEVENT_MAX_REQUESTS		PAGE_SIZE/sizeof(struct kevent)
+
+struct kevent *kevent_alloc(gfp_t mask);
+void kevent_free(struct kevent *k);
+int kevent_enqueue(struct kevent *k);
+int kevent_dequeue(struct kevent *k);
+int kevent_init(struct kevent *k);
+void kevent_requeue(struct kevent *k);
+
+#define list_for_each_entry_reverse_safe(pos, n, head, member)		\
+	for (pos = list_entry((head)->prev, typeof(*pos), member),	\
+		n = list_entry(pos->member.prev, typeof(*pos), member);	\
+	     prefetch(pos->member.prev), &pos->member != (head); 	\
+	     pos = n, n = list_entry(pos->member.prev, typeof(*pos), member))
+
+int kevent_break(struct kevent *k);
+int kevent_init(struct kevent *k);
+
+int kevent_init_socket(struct kevent *k);
+int kevent_init_inode(struct kevent *k);
+int kevent_init_timer(struct kevent *k);
+int kevent_init_poll(struct kevent *k);
+int kevent_init_naio(struct kevent *k);
+int kevent_init_aio(struct kevent *k);
+
+void kevent_storage_ready(struct kevent_storage *st, 
+		kevent_callback_t ready_callback, u32 event);
+int kevent_storage_init(void *origin, struct kevent_storage *st);
+void kevent_storage_fini(struct kevent_storage *st);
+int kevent_storage_enqueue(struct kevent_storage *st, struct kevent *k);
+void kevent_storage_dequeue(struct kevent_storage *st, struct kevent *k);
+
+int kevent_user_add_ukevent(struct ukevent *uk, struct kevent_user *u);
+
+#ifdef CONFIG_KEVENT_INODE
+void kevent_inode_notify(struct inode *inode, u32 event);
+void kevent_inode_notify_parent(struct dentry *dentry, u32 event);
+void kevent_inode_remove(struct inode *inode);
+#else
+static inline void kevent_inode_notify(struct inode *inode, u32 event)
+{
+}
+static inline void kevent_inode_notify_parent(struct dentry *dentry, u32 event)
+{
+}
+static inline void kevent_inode_remove(struct inode *inode)
+{
+}
+#endif /* CONFIG_KEVENT_INODE */
+#ifdef CONFIG_KEVENT_SOCKET
+
+void kevent_socket_notify(struct sock *sock, u32 event);
+int kevent_socket_dequeue(struct kevent *k);
+int kevent_socket_enqueue(struct kevent *k);
+#define sock_async(__sk) sock_flag(__sk, SOCK_ASYNC)
+#else
+static inline void kevent_socket_notify(struct sock *sock, u32 event)
+{
+}
+#define sock_async(__sk)	0
+#endif
+#endif /* __KERNEL__ */
+#endif /* __KEVENT_H */
diff --git a/include/linux/kevent_storage.h b/include/linux/kevent_storage.h
new file mode 100644
index 0000000..bd891f0
--- /dev/null
+++ b/include/linux/kevent_storage.h
@@ -0,0 +1,12 @@
+#ifndef __KEVENT_STORAGE_H
+#define __KEVENT_STORAGE_H
+
+struct kevent_storage
+{
+	void			*origin;		/* Originator's pointer, e.g. struct sock or struct file. Can be NULL. */
+	struct list_head	list;			/* List of queued kevents. */
+	unsigned int		qlen;			/* Number of queued kevents. */
+	spinlock_t		lock;			/* Protects users queue. */
+};
+
+#endif /* __KEVENT_STORAGE_H */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 66f8819..ea914c3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1269,6 +1269,8 @@ extern struct sk_buff *skb_recv_datagram
 					 int noblock, int *err);
 extern unsigned int    datagram_poll(struct file *file, struct socket *sock,
 				     struct poll_table_struct *wait);
+extern int	       skb_copy_datagram(const struct sk_buff *from, 
+					 int offset, void *dst, int size);
 extern int	       skb_copy_datagram_iovec(const struct sk_buff *from,
 					       int offset, struct iovec *to,
 					       int size);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index bd67a44..33d436e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -587,4 +587,8 @@ asmlinkage long sys_get_robust_list(int 
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+asmlinkage long sys_aio_recv(int ctl_fd, int s, void __user *buf, size_t size, unsigned flags);
+asmlinkage long sys_aio_send(int ctl_fd, int s, void __user *buf, size_t size, unsigned flags);
+asmlinkage long sys_aio_sendfile(int ctl_fd, int fd, int s, size_t size, unsigned flags);
+asmlinkage long sys_kevent_ctl(int ctl_fd, void __user *buf);
 #endif
diff --git a/include/net/sock.h b/include/net/sock.h
index d10dfec..7a2bee3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -47,6 +47,7 @@ #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/security.h>
+#include <linux/kevent.h>
 
 #include <linux/filter.h>
 
@@ -386,6 +387,8 @@ enum sock_flags {
 	SOCK_NO_LARGESEND, /* whether to sent large segments or not */
 	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
 	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
+	SOCK_ASYNC,
+	SOCK_ASYNC_INUSE,
 };
 
 static inline void sock_copy_flags(struct sock *nsk, struct sock *osk)
@@ -445,6 +448,21 @@ static inline int sk_stream_memory_free(
 
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
@@ -472,6 +490,7 @@ static inline void sk_add_backlog(struct
 		sk->sk_backlog.tail = skb;
 	}
 	skb->next = NULL;
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
 }
 
 #define sk_wait_event(__sk, __timeo, __condition)		\
@@ -543,6 +562,12 @@ struct proto {
 
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
@@ -674,21 +699,6 @@ static inline struct kiocb *siocb_to_kio
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
index 5f4eb5c..820cd5a 100644
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
diff --git a/init/Kconfig b/init/Kconfig
index df864a3..6135afc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -185,6 +185,8 @@ config AUDITSYSCALL
 	  such as SELinux.  To use audit's filesystem watch feature, please
 	  ensure that INOTIFY is configured.
 
+source "kernel/kevent/Kconfig"
+
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
diff --git a/kernel/Makefile b/kernel/Makefile
index f6ef00f..eb057ea 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_KEVENT) += kevent/
 obj-$(CONFIG_RELAY) += relay.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
diff --git a/kernel/kevent/Kconfig b/kernel/kevent/Kconfig
new file mode 100644
index 0000000..88b35af
--- /dev/null
+++ b/kernel/kevent/Kconfig
@@ -0,0 +1,57 @@
+config KEVENT
+	bool "Kernel event notification mechanism"
+	help
+	  This option enables event queue mechanism.
+	  It can be used as replacement for poll()/select(), AIO callback invocations,
+	  advanced timer notifications and other kernel object status changes.
+
+config KEVENT_USER_STAT
+	bool "Kevent user statistic"
+	depends on KEVENT
+	default N
+	help
+	  This option will turn kevent_user statistic collection on.
+	  Statistic data includes total number of kevent, number of kevents which are ready
+	  immediately at insertion time and number of kevents which were removed through
+	  readiness completion. It will be printed each time control kevent descriptor
+	  is closed.
+
+config KEVENT_SOCKET
+	bool "Kernel event notifications for sockets"
+	depends on NET && KEVENT
+	help
+	  This option enables notifications through KEVENT subsystem of 
+	  sockets operations, like new packet receiving conditions, ready for accept
+  	  conditions and so on.
+	
+config KEVENT_INODE
+	bool "Kernel event notifications for inodes"
+	depends on KEVENT
+	help
+	  This option enables notifications through KEVENT subsystem of 
+	  inode operations, like file creation, removal and so on.
+
+config KEVENT_TIMER
+	bool "Kernel event notifications for timers"
+	depends on KEVENT
+	help
+	  This option allows to use timers through KEVENT subsystem.
+
+config KEVENT_POLL
+	bool "Kernel event notifications for poll()/select()"
+	depends on KEVENT
+	help
+	  This option allows to use kevent subsystem for poll()/select() notifications.
+
+config KEVENT_NAIO
+	bool "Network asynchronous IO"
+	depends on KEVENT && KEVENT_SOCKET
+	help
+	  This option enables kevent based network asynchronous IO subsystem.
+
+config KEVENT_AIO
+	bool "Asynchronous IO"
+	depends on KEVENT
+	help
+	  This option allows to use kevent subsystem for AIO operations.
+	  AIO read is currently supported.
diff --git a/kernel/kevent/Makefile b/kernel/kevent/Makefile
new file mode 100644
index 0000000..7dcd651
--- /dev/null
+++ b/kernel/kevent/Makefile
@@ -0,0 +1,7 @@
+obj-y := kevent.o kevent_user.o kevent_init.o
+obj-$(CONFIG_KEVENT_SOCKET) += kevent_socket.o
+obj-$(CONFIG_KEVENT_INODE) += kevent_inode.o
+obj-$(CONFIG_KEVENT_TIMER) += kevent_timer.o
+obj-$(CONFIG_KEVENT_POLL) += kevent_poll.o
+obj-$(CONFIG_KEVENT_NAIO) += kevent_naio.o
+obj-$(CONFIG_KEVENT_AIO) += kevent_aio.o
diff --git a/kernel/kevent/kevent.c b/kernel/kevent/kevent.c
new file mode 100644
index 0000000..f699a13
--- /dev/null
+++ b/kernel/kevent/kevent.c
@@ -0,0 +1,260 @@
+/*
+ * 	kevent.c
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
+#include <linux/mempool.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/kevent.h>
+
+static kmem_cache_t *kevent_cache;
+
+/*
+ * Attempts to add an event into appropriate origin's queue.
+ * Returns positive value if this event is ready immediately,
+ * negative value in case of error and zero if event has been queued.
+ * ->enqueue() callback must increase origin's reference counter.
+ */
+int kevent_enqueue(struct kevent *k)
+{
+	if (k->event.type >= KEVENT_MAX)
+		return -E2BIG;
+
+	if (!k->enqueue) {
+		kevent_break(k);
+		return -EINVAL;
+	}
+	
+	return k->enqueue(k);
+}
+
+/*
+ * Remove event from the appropriate queue.
+ * ->dequeue() callback must decrease origin's reference counter.
+ */
+int kevent_dequeue(struct kevent *k)
+{
+	if (k->event.type >= KEVENT_MAX)
+		return -E2BIG;
+	
+	if (!k->dequeue) {
+		kevent_break(k);
+		return -EINVAL;
+	}
+
+	return k->dequeue(k);
+}
+
+/*
+ * Must be called before event is going to be added into some origin's queue.
+ * Initializes ->enqueue(), ->dequeue() and ->callback() callbacks.
+ * If failed, kevent should not be used or kevent_enqueue() will fail to add
+ * this kevent into origin's queue with setting
+ * KEVENT_RET_BROKEN flag in kevent->event.ret_flags.
+ */
+int kevent_init(struct kevent *k)
+{
+	int err;
+
+	spin_lock_init(&k->lock);
+	k->kevent_entry.next = LIST_POISON1;
+	k->storage_entry.next = LIST_POISON1;
+	k->ready_entry.next = LIST_POISON1;
+
+	if (k->event.type >= KEVENT_MAX)
+		return -E2BIG;
+	
+	switch (k->event.type) {
+		case KEVENT_NAIO:
+			err = kevent_init_naio(k);
+			break;
+		case KEVENT_SOCKET:
+			err = kevent_init_socket(k);
+			break;
+		case KEVENT_INODE:
+			err = kevent_init_inode(k);
+			break;
+		case KEVENT_TIMER:
+			err = kevent_init_timer(k);
+			break;
+		case KEVENT_POLL:
+			err = kevent_init_poll(k);
+			break;
+		case KEVENT_AIO:
+			err = kevent_init_aio(k);
+			break;
+		default:
+			err = -ENODEV;
+	}
+
+	return err;
+}
+
+/*
+ * Called from ->enqueue() callback when reference counter for given
+ * origin (socket, inode...) has been increased.
+ */
+int kevent_storage_enqueue(struct kevent_storage *st, struct kevent *k)
+{
+	unsigned long flags;
+
+	k->st = st;
+	spin_lock_irqsave(&st->lock, flags);
+	list_add_tail(&k->storage_entry, &st->list);
+	st->qlen++;
+	spin_unlock_irqrestore(&st->lock, flags);
+	return 0;
+}
+
+/*
+ * Dequeue kevent from origin's queue. 
+ * It does not decrease origin's reference counter in any way 
+ * and must be called before it, so storage itself must be valid.
+ * It is called from ->dequeue() callback.
+ */
+void kevent_storage_dequeue(struct kevent_storage *st, struct kevent *k)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&st->lock, flags);
+	if (k->storage_entry.next != LIST_POISON1) {
+		list_del(&k->storage_entry);
+		st->qlen--;
+	}
+	spin_unlock_irqrestore(&st->lock, flags);
+}
+
+static void __kevent_requeue(struct kevent *k, u32 event)
+{
+	int err, rem = 0;
+	unsigned long flags;
+
+	err = k->callback(k);
+
+	spin_lock_irqsave(&k->lock, flags);
+	if (err > 0) {
+		k->event.ret_flags |= KEVENT_RET_DONE;
+	} else if (err < 0) {
+		k->event.ret_flags |= KEVENT_RET_BROKEN;
+		k->event.ret_flags |= KEVENT_RET_DONE;
+	}
+	rem = (k->event.req_flags & KEVENT_REQ_ONESHOT);
+	if (!err)
+		err = (k->event.ret_flags & (KEVENT_RET_BROKEN|KEVENT_RET_DONE));
+	spin_unlock_irqrestore(&k->lock, flags);
+
+	if (err) {
+		if (rem) {
+			list_del(&k->storage_entry);
+			k->st->qlen--;
+		}
+		
+		spin_lock_irqsave(&k->user->ready_lock, flags);
+		if (k->ready_entry.next == LIST_POISON1) {
+			list_add_tail(&k->ready_entry, &k->user->ready_list);
+			k->user->ready_num++;
+		}
+		spin_unlock_irqrestore(&k->user->ready_lock, flags);
+		wake_up(&k->user->wait);
+	}
+}
+
+void kevent_requeue(struct kevent *k)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&k->st->lock, flags);
+	__kevent_requeue(k, 0);
+	spin_unlock_irqrestore(&k->st->lock, flags);
+}
+
+/*
+ * Called each time some activity in origin (socket, inode...) is noticed.
+ */
+void kevent_storage_ready(struct kevent_storage *st, 
+		kevent_callback_t ready_callback, u32 event)
+{
+	struct kevent *k, *n;
+
+	spin_lock(&st->lock);
+	list_for_each_entry_safe(k, n, &st->list, storage_entry) {
+		if (ready_callback)
+			ready_callback(k);
+
+		if (event & k->event.event)
+			__kevent_requeue(k, event);
+	}
+	spin_unlock(&st->lock);
+}
+
+int kevent_storage_init(void *origin, struct kevent_storage *st)
+{
+	spin_lock_init(&st->lock);
+	st->origin = origin;
+	st->qlen = 0;
+	INIT_LIST_HEAD(&st->list);
+	return 0;
+}
+
+void kevent_storage_fini(struct kevent_storage *st)
+{
+	kevent_storage_ready(st, kevent_break, KEVENT_MASK_ALL);
+}
+
+struct kevent *kevent_alloc(gfp_t mask)
+{
+	struct kevent *k;
+	
+	if (kevent_cache)
+		k = kmem_cache_alloc(kevent_cache, mask);
+	else
+		k = kzalloc(sizeof(struct kevent), mask);
+
+	return k;
+}
+
+void kevent_free(struct kevent *k)
+{
+	memset(k, 0xab, sizeof(struct kevent));
+
+	if (kevent_cache)
+		kmem_cache_free(kevent_cache, k);
+	else
+		kfree(k);
+}
+
+int __init kevent_sys_init(void)
+{
+	int err = 0;
+
+	kevent_cache = kmem_cache_create("kevent_cache", 
+			sizeof(struct kevent), 0, 0, NULL, NULL);
+	if (!kevent_cache)
+		err = -ENOMEM;
+	
+	return err;
+}
+
+late_initcall(kevent_sys_init);

diff --git a/kernel/kevent/kevent_init.c b/kernel/kevent/kevent_init.c
new file mode 100644
index 0000000..ec95114
--- /dev/null
+++ b/kernel/kevent/kevent_init.c
@@ -0,0 +1,85 @@
+/*
+ * 	kevent_init.c
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
+#include <linux/errno.h>
+#include <linux/kevent.h>
+
+int kevent_break(struct kevent *k)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&k->lock, flags);
+	k->event.ret_flags |= KEVENT_RET_BROKEN;
+	spin_unlock_irqrestore(&k->lock, flags);
+	return 0;
+}
+
+#ifndef CONFIG_KEVENT_SOCKET
+int kevent_init_socket(struct kevent *k)
+{
+	kevent_break(k);
+	return -ENODEV;
+}
+#endif
+
+#ifndef CONFIG_KEVENT_INODE
+int kevent_init_inode(struct kevent *k)
+{
+	kevent_break(k);
+	return -ENODEV;
+}
+#endif
+
+#ifndef CONFIG_KEVENT_TIMER
+int kevent_init_timer(struct kevent *k)
+{
+	kevent_break(k);
+	return -ENODEV;
+}
+#endif
+
+#ifndef CONFIG_KEVENT_POLL
+int kevent_init_poll(struct kevent *k)
+{
+	kevent_break(k);
+	return -ENODEV;
+}
+#endif
+
+#ifndef CONFIG_KEVENT_NAIO
+int kevent_init_naio(struct kevent *k)
+{
+	kevent_break(k);
+	return -ENODEV;
+}
+#endif
+
+#ifndef CONFIG_KEVENT_AIO
+int kevent_init_aio(struct kevent *k)
+{
+	kevent_break(k);
+	return -ENODEV;
+}
+#endif

diff --git a/kernel/kevent/kevent_user.c b/kernel/kevent/kevent_user.c
new file mode 100644
index 0000000..2f71fe4
--- /dev/null
+++ b/kernel/kevent/kevent_user.c
@@ -0,0 +1,728 @@
+/*
+ * 	kevent_user.c
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
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/mount.h>
+#include <linux/device.h>
+#include <linux/poll.h>
+#include <linux/kevent.h>
+#include <linux/jhash.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+
+static struct class *kevent_user_class;
+static char kevent_name[] = "kevent";
+static int kevent_user_major;
+
+static int kevent_user_open(struct inode *, struct file *);
+static int kevent_user_release(struct inode *, struct file *);
+static int kevent_user_ioctl(struct inode *, struct file *, 
+		unsigned int, unsigned long);
+static unsigned int kevent_user_poll(struct file *, struct poll_table_struct *);
+
+static struct file_operations kevent_user_fops = {
+	.open		= kevent_user_open,
+	.release	= kevent_user_release,
+	.ioctl		= kevent_user_ioctl,
+	.poll		= kevent_user_poll,
+	.owner		= THIS_MODULE,
+};
+
+static struct super_block *kevent_get_sb(struct file_system_type *fs_type, 
+		int flags, const char *dev_name, void *data)
+{
+	/* So original magic... */
+	return get_sb_pseudo(fs_type, kevent_name, NULL, 0xabcdef);	
+}
+
+static struct file_system_type kevent_fs_type = {
+	.name		= kevent_name,
+	.get_sb		= kevent_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+static struct vfsmount *kevent_mnt;
+
+static unsigned int kevent_user_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct kevent_user *u = file->private_data;
+	unsigned int mask;
+	
+	poll_wait(file, &u->wait, wait);
+	mask = 0;
+
+	if (u->ready_num)
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+static struct kevent_user *kevent_user_alloc(void)
+{
+	struct kevent_user *u;
+	int i;
+
+	u = kzalloc(sizeof(struct kevent_user), GFP_KERNEL);
+	if (!u)
+		return NULL;
+
+	INIT_LIST_HEAD(&u->ready_list);
+	spin_lock_init(&u->ready_lock);
+	u->ready_num = 0;
+#ifdef CONFIG_KEVENT_USER_STAT
+	u->wait_num = u->im_num = u->total = 0;
+#endif
+	for (i=0; i<KEVENT_HASH_MASK+1; ++i) {
+		INIT_LIST_HEAD(&u->kqueue[i].kevent_list);
+		spin_lock_init(&u->kqueue[i].kevent_lock);
+	}
+	u->kevent_num = 0;
+	
+	init_MUTEX(&u->ctl_mutex);
+	init_MUTEX(&u->wait_mutex);
+	init_waitqueue_head(&u->wait);
+	u->max_ready_num = 0;
+
+	atomic_set(&u->refcnt, 1);
+
+	return u;
+}
+
+static int kevent_user_open(struct inode *inode, struct file *file)
+{
+	struct kevent_user *u = kevent_user_alloc();
+	
+	if (!u)
+		return -ENOMEM;
+
+	file->private_data = u;
+	
+	return 0;
+}
+
+static inline void kevent_user_get(struct kevent_user *u)
+{
+	atomic_inc(&u->refcnt);
+}
+
+static inline void kevent_user_put(struct kevent_user *u)
+{
+	if (atomic_dec_and_test(&u->refcnt)) {
+#ifdef CONFIG_KEVENT_USER_STAT
+		printk("%s: u=%p, wait=%lu, immediately=%lu, total=%lu.\n", 
+				__func__, u, u->wait_num, u->im_num, u->total);
+#endif
+		kfree(u);
+	}
+}
+
+#if 0
+static inline unsigned int kevent_user_hash(struct ukevent *uk)
+{
+	unsigned int h = (uk->user[0] ^ uk->user[1]) ^ (uk->id.raw[0] ^ uk->id.raw[1]);
+	
+	h = (((h >> 16) & 0xffff) ^ (h & 0xffff)) & 0xffff;
+	h = (((h >> 8) & 0xff) ^ (h & 0xff)) & KEVENT_HASH_MASK;
+
+	return h;
+}
+#else
+static inline unsigned int kevent_user_hash(struct ukevent *uk)
+{
+	return jhash_1word(uk->id.raw[0], 0) & KEVENT_HASH_MASK;
+}
+#endif
+
+/*
+ * Remove kevent from user's list of all events, 
+ * dequeue it from storage and decrease user's reference counter,
+ * since this kevent does not exist anymore. That is why it is freed here.
+ */
+static void kevent_finish_user(struct kevent *k, int lock, int deq)
+{
+	struct kevent_user *u = k->user;
+	unsigned long flags;
+
+	if (lock) {
+		unsigned int hash = kevent_user_hash(&k->event);
+		struct kevent_list *l = &u->kqueue[hash];
+
+		spin_lock_irqsave(&l->kevent_lock, flags);
+		list_del(&k->kevent_entry);
+		u->kevent_num--;
+		spin_unlock_irqrestore(&l->kevent_lock, flags);
+	} else {
+		list_del(&k->kevent_entry);
+		u->kevent_num--;
+	}
+
+	if (deq)
+		kevent_dequeue(k);
+
+	spin_lock_irqsave(&u->ready_lock, flags);
+	if (k->ready_entry.next != LIST_POISON1) {
+		list_del(&k->ready_entry);
+		u->ready_num--;
+	}
+	spin_unlock_irqrestore(&u->ready_lock, flags);
+	
+	kevent_user_put(u);
+	kevent_free(k);
+}
+
+/*
+ * Dequeue one entry from user's ready queue.
+ */
+static struct kevent *__kqueue_dequeue_one_ready(struct list_head *q, 
+		unsigned int *qlen)
+{
+	struct kevent *k = NULL;
+	unsigned int len = *qlen;
+	
+	if (len && !list_empty(q)) {
+		k = list_entry(q->next, struct kevent, ready_entry);
+		list_del(&k->ready_entry);
+		*qlen = len - 1;
+	}
+	
+	return k;
+}
+
+static struct kevent *kqueue_dequeue_ready(struct kevent_user *u)
+{
+	unsigned long flags;
+	struct kevent *k;
+
+	spin_lock_irqsave(&u->ready_lock, flags);
+	k = __kqueue_dequeue_one_ready(&u->ready_list, &u->ready_num);
+	spin_unlock_irqrestore(&u->ready_lock, flags);
+
+	return k;
+}
+
+static struct kevent *__kevent_search(struct kevent_list *l, struct ukevent *uk, 
+		struct kevent_user *u)
+{
+	struct kevent *k;
+	int found = 0;
+	
+	list_for_each_entry(k, &l->kevent_list, kevent_entry) {
+		spin_lock(&k->lock);
+		if (k->event.user[0] == uk->user[0] && k->event.user[1] == uk->user[1] &&
+				k->event.id.raw[0] == uk->id.raw[0] && 
+				k->event.id.raw[1] == uk->id.raw[1]) {
+			found = 1;
+			spin_unlock(&k->lock);
+			break;
+		}
+		spin_unlock(&k->lock);
+	}
+
+	return (found)?k:NULL;
+}
+
+static int kevent_modify(struct ukevent *uk, struct kevent_user *u)
+{
+	struct kevent *k;
+	unsigned int hash = kevent_user_hash(uk);
+	struct kevent_list *l = &u->kqueue[hash];
+	int err = -ENODEV;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&l->kevent_lock, flags);
+	k = __kevent_search(l, uk, u);
+	if (k) {
+		spin_lock(&k->lock);
+		k->event.event = uk->event;
+		k->event.req_flags = uk->req_flags;
+		k->event.ret_flags = 0;
+		spin_unlock(&k->lock);
+		kevent_requeue(k);
+		err = 0;
+	}
+	spin_unlock_irqrestore(&l->kevent_lock, flags);
+	
+	return err;
+}
+
+static int kevent_remove(struct ukevent *uk, struct kevent_user *u)
+{
+	int err = -ENODEV;
+	struct kevent *k;
+	unsigned int hash = kevent_user_hash(uk);
+	struct kevent_list *l = &u->kqueue[hash];
+	unsigned long flags;
+
+	spin_lock_irqsave(&l->kevent_lock, flags);
+	k = __kevent_search(l, uk, u);
+	if (k) {
+		kevent_finish_user(k, 0, 1);
+		err = 0;
+	}
+	spin_unlock_irqrestore(&l->kevent_lock, flags);
+
+	return err;
+}
+
+/*
+ * No new entry can be added or removed from any list at this point.
+ * It is not permitted to call ->ioctl() and ->release() in parallel.
+ */
+static int kevent_user_release(struct inode *inode, struct file *file)
+{
+	struct kevent_user *u = file->private_data;
+	struct kevent *k, *n;
+	int i;
+
+	for (i=0; i<KEVENT_HASH_MASK+1; ++i) {
+		struct kevent_list *l = &u->kqueue[i];
+		
+		list_for_each_entry_safe(k, n, &l->kevent_list, kevent_entry)
+			kevent_finish_user(k, 1, 1);
+	}
+
+	kevent_user_put(u);
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static int kevent_user_ctl_modify(struct kevent_user *u, 
+		struct kevent_user_control *ctl, void __user *arg)
+{
+	int err = 0, i;
+	struct ukevent uk;
+
+	if (down_interruptible(&u->ctl_mutex))
+		return -ERESTARTSYS;
+
+	for (i=0; i<ctl->num; ++i) {
+		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (kevent_modify(&uk, u))
+			uk.ret_flags |= KEVENT_RET_BROKEN;
+		uk.ret_flags |= KEVENT_RET_DONE;
+
+		if (copy_to_user(arg, &uk, sizeof(struct ukevent))) {
+			err = -EINVAL;
+			break;
+		}
+
+		arg += sizeof(struct ukevent);
+	}
+
+	up(&u->ctl_mutex);
+
+	return err;
+}
+
+static int kevent_user_ctl_remove(struct kevent_user *u, 
+		struct kevent_user_control *ctl, void __user *arg)
+{
+	int err = 0, i;
+	struct ukevent uk;
+
+	if (down_interruptible(&u->ctl_mutex))
+		return -ERESTARTSYS;
+
+	for (i=0; i<ctl->num; ++i) {
+		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (kevent_remove(&uk, u))
+			uk.ret_flags |= KEVENT_RET_BROKEN;
+
+		uk.ret_flags |= KEVENT_RET_DONE;
+
+		if (copy_to_user(arg, &uk, sizeof(struct ukevent))) {
+			err = -EINVAL;
+			break;
+		}
+
+		arg += sizeof(struct ukevent);
+	}
+
+	up(&u->ctl_mutex);
+
+	return err;
+}
+
+int kevent_user_add_ukevent(struct ukevent *uk, struct kevent_user *u)
+{
+	struct kevent *k;
+	int err;
+
+	k = kevent_alloc(GFP_KERNEL);
+	if (!k) {
+		err = -ENOMEM;
+		goto err_out_exit;
+	}
+
+	memcpy(&k->event, uk, sizeof(struct ukevent));
+
+	k->event.ret_flags = 0;
+
+	err = kevent_init(k);
+	if (err) {
+		kevent_free(k);
+		goto err_out_exit;
+	}
+	k->user = u;
+#ifdef CONFIG_KEVENT_USER_STAT
+	u->total++;
+#endif
+	{
+		unsigned long flags;
+		unsigned int hash = kevent_user_hash(&k->event);
+		struct kevent_list *l = &u->kqueue[hash];
+		
+		spin_lock_irqsave(&l->kevent_lock, flags);
+		list_add_tail(&k->kevent_entry, &l->kevent_list);
+		u->kevent_num++;
+		kevent_user_get(u);
+		spin_unlock_irqrestore(&l->kevent_lock, flags);
+	}
+
+	err = kevent_enqueue(k);
+	if (err) {
+		memcpy(uk, &k->event, sizeof(struct ukevent));
+		if (err < 0)
+			uk->ret_flags |= KEVENT_RET_BROKEN;
+		uk->ret_flags |= KEVENT_RET_DONE;
+		kevent_finish_user(k, 1, 0);
+	} 
+
+err_out_exit:
+	return err;
+}
+
+/*
+ * Copy all ukevents from userspace, allocate kevent for each one 
+ * and add them into appropriate kevent_storages, 
+ * e.g. sockets, inodes and so on...
+ * If something goes wrong, all events will be dequeued and 
+ * negative error will be returned. 
+ * On success zero is returned and 
+ * ctl->num will be a number of finished events, either completed or failed. 
+ * Array of finished events (struct ukevent) will be placed behind 
+ * kevent_user_control structure. User must run through that array and check 
+ * ret_flags field of each ukevent structure to determine if it is fired or failed event.
+ */
+static int kevent_user_ctl_add(struct kevent_user *u, 
+		struct kevent_user_control *ctl, void __user *arg)
+{
+	int err = 0, cerr = 0, num = 0, knum = 0, i;
+	void __user *orig, *ctl_addr;
+	struct ukevent uk;
+
+	if (down_interruptible(&u->ctl_mutex))
+		return -ERESTARTSYS;
+
+	orig = arg;
+	ctl_addr = arg - sizeof(struct kevent_user_control);
+#if 1
+	err = -ENFILE;
+	if (u->kevent_num + ctl->num >= 1024)
+		goto err_out_remove;
+#endif
+	for (i=0; i<ctl->num; ++i) {
+		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
+			cerr = -EINVAL;
+			break;
+		}
+		arg += sizeof(struct ukevent);
+
+		err = kevent_user_add_ukevent(&uk, u);
+		if (err) {
+#ifdef CONFIG_KEVENT_USER_STAT
+			u->im_num++;
+#endif
+			if (copy_to_user(orig, &uk, sizeof(struct ukevent)))
+				cerr = -EINVAL;
+			orig += sizeof(struct ukevent);
+			num++;
+		} else
+			knum++;
+	}
+
+	if (cerr < 0)
+		goto err_out_remove;
+
+	ctl->num = num;
+	if (copy_to_user(ctl_addr, ctl, sizeof(struct kevent_user_control)))
+		cerr = -EINVAL;
+
+	if (cerr)
+		err = cerr;
+	if (!err)
+		err = num;
+
+err_out_remove:
+	up(&u->ctl_mutex);
+
+	return err;
+}
+
+/*
+ * Waits until at least ctl->ready_num events are ready or timeout and returns 
+ * number of ready events (in case of timeout) or number of requested events.
+ */
+static int kevent_user_wait(struct file *file, struct kevent_user *u, 
+		struct kevent_user_control *ctl, void __user *arg)
+{
+	struct kevent *k;
+	int cerr = 0, num = 0;
+	void __user *ptr = arg + sizeof(struct kevent_user_control);
+
+	if (down_interruptible(&u->ctl_mutex))
+		return -ERESTARTSYS;
+
+	if (!(file->f_flags & O_NONBLOCK)) {
+		if (ctl->timeout)
+			wait_event_interruptible_timeout(u->wait, 
+				u->ready_num >= ctl->num, msecs_to_jiffies(ctl->timeout));
+		else
+			wait_event_interruptible_timeout(u->wait, 
+					u->ready_num > 0, msecs_to_jiffies(1000));
+	}
+	while (num < ctl->num && ((k = kqueue_dequeue_ready(u)) != NULL)) {
+		if (copy_to_user(ptr + num*sizeof(struct ukevent), 
+					&k->event, sizeof(struct ukevent)))
+			cerr = -EINVAL;
+
+		/*
+		 * If it is one-shot kevent, it has been removed already from
+		 * origin's queue, so we can easily free it here.
+		 */
+		if (k->event.req_flags & KEVENT_REQ_ONESHOT)
+			kevent_finish_user(k, 1, 1);
+		++num;
+#ifdef CONFIG_KEVENT_USER_STAT
+		u->wait_num++;
+#endif
+	}
+
+	ctl->num = num;
+	if (copy_to_user(arg, ctl, sizeof(struct kevent_user_control)))
+		cerr = -EINVAL;
+
+	up(&u->ctl_mutex);
+
+	return (cerr)?cerr:num;
+}
+
+static int kevent_ctl_init(void)
+{
+	struct kevent_user *u;
+	struct file *file;
+	int fd, ret;
+
+	fd = get_unused_fd();
+	if (fd < 0)
+		return fd;
+
+	file = get_empty_filp();
+	if (!file) {
+		ret = -ENFILE;
+		goto out_put_fd;
+	}
+
+	u = kevent_user_alloc();
+	if (unlikely(!u)) {
+		ret = -ENOMEM;
+		goto out_put_file;
+	}
+
+	file->f_op = &kevent_user_fops;
+	file->f_vfsmnt = mntget(kevent_mnt);
+	file->f_dentry = dget(kevent_mnt->mnt_root);
+	file->f_mapping = file->f_dentry->d_inode->i_mapping;
+	file->f_mode = FMODE_READ;
+	file->f_flags = O_RDONLY;
+	file->private_data = u;
+	
+	fd_install(fd, file);
+
+	return fd;
+
+out_put_file:
+	put_filp(file);
+out_put_fd:
+	put_unused_fd(fd);
+	return ret;
+}
+
+static int kevent_ctl_process(struct file *file, 
+		struct kevent_user_control *ctl, void __user *arg)
+{
+	int err;
+	struct kevent_user *u = file->private_data;
+
+	if (!u)
+		return -EINVAL;
+
+	switch (ctl->cmd) {
+		case KEVENT_CTL_ADD:
+			err = kevent_user_ctl_add(u, ctl, 
+					arg+sizeof(struct kevent_user_control));
+			break;
+		case KEVENT_CTL_REMOVE:
+			err = kevent_user_ctl_remove(u, ctl, 
+					arg+sizeof(struct kevent_user_control));
+			break;
+		case KEVENT_CTL_MODIFY:
+			err = kevent_user_ctl_modify(u, ctl, 
+					arg+sizeof(struct kevent_user_control));
+			break;
+		case KEVENT_CTL_WAIT:
+			err = kevent_user_wait(file, u, ctl, arg);
+			break;
+		case KEVENT_CTL_INIT:
+			err = kevent_ctl_init();
+		default:
+			err = -EINVAL;
+			break;
+	}
+
+	return err;
+}
+
+asmlinkage long sys_kevent_ctl(int fd, void __user *arg)
+{
+	int err, fput_needed;
+	struct kevent_user_control ctl;
+	struct file *file;
+
+	if (copy_from_user(&ctl, arg, sizeof(struct kevent_user_control)))
+		return -EINVAL;
+
+	if (ctl.cmd == KEVENT_CTL_INIT)
+		return kevent_ctl_init();
+
+	file = fget_light(fd, &fput_needed);
+	if (!file)
+		return -ENODEV;
+
+	err = kevent_ctl_process(file, &ctl, arg);
+
+	fput_light(file, fput_needed);
+	return err;
+}
+
+static int kevent_user_ioctl(struct inode *inode, struct file *file, 
+		unsigned int cmd, unsigned long arg)
+{
+	int err = -ENODEV;
+	struct kevent_user_control ctl;
+	struct kevent_user *u = file->private_data;
+	void __user *ptr = (void __user *)arg;
+
+	if (copy_from_user(&ctl, ptr, sizeof(struct kevent_user_control)))
+		return -EINVAL;
+
+	switch (cmd) {
+		case KEVENT_USER_CTL:
+			err = kevent_ctl_process(file, &ctl, ptr);
+			break;
+		case KEVENT_USER_WAIT:
+			err = kevent_user_wait(file, u, &ctl, ptr);
+			break;
+		default:
+			break;
+	}
+
+	return err;
+}
+
+static int __devinit kevent_user_init(void)
+{
+	struct class_device *dev;
+	int err = 0;
+	
+	err = register_filesystem(&kevent_fs_type);
+	if (err)
+		panic("%s: failed to register filesystem: err=%d.\n",
+			       kevent_name, err);
+
+	kevent_mnt = kern_mount(&kevent_fs_type);
+	if (IS_ERR(kevent_mnt))
+		panic("%s: failed to mount silesystem: err=%ld.\n", 
+				kevent_name, PTR_ERR(kevent_mnt));
+	
+	kevent_user_major = register_chrdev(0, kevent_name, &kevent_user_fops);
+	if (kevent_user_major < 0) {
+		printk(KERN_ERR "Failed to register \"%s\" char device: err=%d.\n", 
+				kevent_name, kevent_user_major);
+		return -ENODEV;
+	}
+
+	kevent_user_class = class_create(THIS_MODULE, "kevent");
+	if (IS_ERR(kevent_user_class)) {
+		printk(KERN_ERR "Failed to register \"%s\" class: err=%ld.\n", 
+				kevent_name, PTR_ERR(kevent_user_class));
+		err = PTR_ERR(kevent_user_class);
+		goto err_out_unregister;
+	}
+
+	dev = class_device_create(kevent_user_class, NULL, 
+			MKDEV(kevent_user_major, 0), NULL, kevent_name);
+	if (IS_ERR(dev)) {
+		printk(KERN_ERR "Failed to create %d.%d class device in \"%s\" class: err=%ld.\n", 
+				kevent_user_major, 0, kevent_name, PTR_ERR(dev));
+		err = PTR_ERR(dev);
+		goto err_out_class_destroy;
+	}
+
+	printk("KEVENT subsystem: chardev helper: major=%d.\n", kevent_user_major);
+
+	return 0;
+
+err_out_class_destroy:
+	class_destroy(kevent_user_class);
+err_out_unregister:
+	unregister_chrdev(kevent_user_major, kevent_name);
+
+	return err;
+}
+
+static void __devexit kevent_user_fini(void)
+{
+	class_device_destroy(kevent_user_class, MKDEV(kevent_user_major, 0));
+	class_destroy(kevent_user_class);
+	unregister_chrdev(kevent_user_major, kevent_name);
+	mntput(kevent_mnt);
+	unregister_filesystem(&kevent_fs_type);
+}
+
+module_init(kevent_user_init);
+module_exit(kevent_user_fini);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 5433195..dcbacf5 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -121,6 +121,11 @@ cond_syscall(ppc_rtas);
 cond_syscall(sys_spu_run);
 cond_syscall(sys_spu_create);
 
+cond_syscall(sys_aio_recv);
+cond_syscall(sys_aio_send);
+cond_syscall(sys_aio_sendfile);
+cond_syscall(sys_kevent_ctl);
+
 /* mmu depending weak syscall entries */
 cond_syscall(sys_mprotect);
 cond_syscall(sys_msync);
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
index 5d820c3..3345048 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -564,6 +564,16 @@ #endif
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
 
 		/* We implement the SO_SNDLOWAT etc to
 		   not be settable (1003.1g 5.3) */
@@ -1313,6 +1323,7 @@ static void sock_def_wakeup(struct sock 
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
 		wake_up_interruptible_all(sk->sk_sleep);
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_error_report(struct sock *sk)
@@ -1322,6 +1333,7 @@ static void sock_def_error_report(struct
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,0,POLL_ERR); 
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_readable(struct sock *sk, int len)
@@ -1331,6 +1343,7 @@ static void sock_def_readable(struct soc
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,1,POLL_IN);
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
 }
 
 static void sock_def_write_space(struct sock *sk)
@@ -1350,6 +1363,7 @@ static void sock_def_write_space(struct 
 	}
 
 	read_unlock(&sk->sk_callback_lock);
+	kevent_socket_notify(sk, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
 }
 
 static void sock_def_destruct(struct sock *sk)
@@ -1454,8 +1468,10 @@ void fastcall release_sock(struct sock *
 	if (sk->sk_backlog.tail)
 		__release_sock(sk);
 	sk->sk_lock.owner = NULL;
-        if (waitqueue_active(&(sk->sk_lock.wq)))
+        if (waitqueue_active(&(sk->sk_lock.wq))) {
 		wake_up(&(sk->sk_lock.wq));
+		kevent_socket_notify(sk, KEVENT_SOCKET_RECV|KEVENT_SOCKET_SEND);
+	}
 	spin_unlock_bh(&(sk->sk_lock.slock));
 }
 EXPORT_SYMBOL(release_sock);
diff --git a/net/core/stream.c b/net/core/stream.c
index e948969..91e2e07 100644
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
index 74998f2..403d33e 100644
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
@@ -1085,6 +1086,275 @@ int tcp_read_sock(struct sock *sk, read_
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
+		skb_shinfo(skb)->tso_segs = 0;
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
+
+		err = skb_copy_datagram(skb, offset, dst, used);
+		if (err) {
+			/* Exception. Bailout! */
+			if (!copied)
+				copied = -EFAULT;
+			break;
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
+		sk_eat_skb(sk, skb);
+		continue;
+
+	found_fin_ok:
+		/* Process the FIN. */
+		++*seq;
+		sk_eat_skb(sk, skb);
+		break;
+	} while (len > 0);
+
+	/* Clean up data we have read: This will do ACK frames. */
+	cleanup_rbuf(sk, copied);
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
@@ -2259,6 +2529,8 @@ EXPORT_SYMBOL(tcp_getsockopt);
 EXPORT_SYMBOL(tcp_ioctl);
 EXPORT_SYMBOL(tcp_poll);
 EXPORT_SYMBOL(tcp_read_sock);
+EXPORT_SYMBOL(tcp_async_recv);
+EXPORT_SYMBOL(tcp_async_send);
 EXPORT_SYMBOL(tcp_recvmsg);
 EXPORT_SYMBOL(tcp_sendmsg);
 EXPORT_SYMBOL(tcp_sendpage);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e08245b..5655b1e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3113,6 +3113,7 @@ static void tcp_ofo_queue(struct sock *s
 
 		__skb_unlink(skb, &tp->out_of_order_queue);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		kevent_socket_notify(sk, KEVENT_SOCKET_RECV);
 		tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 		if(skb->h.th->fin)
 			tcp_fin(skb, sk, skb->h.th);
@@ -3956,7 +3957,8 @@ int tcp_rcv_established(struct sock *sk,
 			int copied_early = 0;
 
 			if (tp->copied_seq == tp->rcv_nxt &&
-			    len - tcp_header_len <= tp->ucopy.len) {
+			    len - tcp_header_len <= tp->ucopy.len &&
+			    !sock_async(sk)) {
 #ifdef CONFIG_NET_DMA
 				if (tcp_dma_try_early_copy(sk, skb, tcp_header_len)) {
 					copied_early = 1;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 25ecc6e..05d7086 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -62,6 +62,7 @@ #include <linux/cache.h>
 #include <linux/jhash.h>
 #include <linux/init.h>
 #include <linux/times.h>
+#include <linux/kevent.h>
 
 #include <net/icmp.h>
 #include <net/inet_hashtables.h>
@@ -850,6 +851,7 @@ #endif
 	   	reqsk_free(req);
 	} else {
 		inet_csk_reqsk_queue_hash_add(sk, req, TCP_TIMEOUT_INIT);
+		kevent_socket_notify(sk, KEVENT_SOCKET_ACCEPT);
 	}
 	return 0;
 
@@ -1089,24 +1091,30 @@ process:
 
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
 
@@ -1830,6 +1838,8 @@ struct proto tcp_prot = {
 	.getsockopt		= tcp_getsockopt,
 	.sendmsg		= tcp_sendmsg,
 	.recvmsg		= tcp_recvmsg,
+	.async_recv		= tcp_async_recv,
+	.async_send		= tcp_async_send,
 	.backlog_rcv		= tcp_v4_do_rcv,
 	.hash			= tcp_v4_hash,
 	.unhash			= tcp_unhash,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index a50eb30..e27e231 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1215,22 +1215,28 @@ process:
 
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
@@ -1580,6 +1586,8 @@ struct proto tcpv6_prot = {
 	.getsockopt		= tcp_getsockopt,
 	.sendmsg		= tcp_sendmsg,
 	.recvmsg		= tcp_recvmsg,
+	.async_recv		= tcp_async_recv,
+	.async_send		= tcp_async_send,
 	.backlog_rcv		= tcp_v6_do_rcv,
 	.hash			= tcp_v6_hash,
 	.unhash			= tcp_unhash,

