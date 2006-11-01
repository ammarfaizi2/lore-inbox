Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946812AbWKALhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946812AbWKALhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946826AbWKALh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:37:28 -0500
Received: from dea.vocord.ru ([217.67.177.50]:53165 "EHLO
	kano.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1946807AbWKALgz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:36:55 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: [take22 1/4] kevent: Core files.
In-Reply-To: <1162380963981@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Wed, 1 Nov 2006 14:36:03 +0300
Message-Id: <11623809632360@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Core files.

This patch includes core kevent files:
 * userspace controlling
 * kernelspace interfaces
 * initialization
 * notification state machines

Some bits of documentation can be found on project's homepage (and links from there):
http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/arch/i386/kernel/syscall_table.S b/arch/i386/kernel/syscall_table.S
index 7e639f7..a9560eb 100644
--- a/arch/i386/kernel/syscall_table.S
+++ b/arch/i386/kernel/syscall_table.S
@@ -318,3 +318,6 @@ ENTRY(sys_call_table)
 	.long sys_vmsplice
 	.long sys_move_pages
 	.long sys_getcpu
+	.long sys_kevent_get_events
+	.long sys_kevent_ctl		/* 320 */
+	.long sys_kevent_wait
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index b4aa875..cf18955 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -714,8 +714,11 @@ #endif
 	.quad compat_sys_get_robust_list
 	.quad sys_splice
 	.quad sys_sync_file_range
-	.quad sys_tee
+	.quad sys_tee			/* 315 */
 	.quad compat_sys_vmsplice
 	.quad compat_sys_move_pages
 	.quad sys_getcpu
+	.quad sys_kevent_get_events
+	.quad sys_kevent_ctl		/* 320 */
+	.quad sys_kevent_wait
 ia32_syscall_end:		
diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index bd99870..f009677 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -324,10 +324,13 @@ #define __NR_tee		315
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
 #define __NR_getcpu		318
+#define __NR_kevent_get_events	319
+#define __NR_kevent_ctl		320
+#define __NR_kevent_wait	321
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 319
+#define NR_syscalls 322
 #include <linux/err.h>
 
 /*
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index 6137146..c53d156 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -619,10 +619,16 @@ #define __NR_vmsplice		278
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages		279
 __SYSCALL(__NR_move_pages, sys_move_pages)
+#define __NR_kevent_get_events	280
+__SYSCALL(__NR_kevent_get_events, sys_kevent_get_events)
+#define __NR_kevent_ctl		281
+__SYSCALL(__NR_kevent_ctl, sys_kevent_ctl)
+#define __NR_kevent_wait	282
+__SYSCALL(__NR_kevent_wait, sys_kevent_wait)
 
 #ifdef __KERNEL__
 
-#define __NR_syscall_max __NR_move_pages
+#define __NR_syscall_max __NR_kevent_wait
 #include <linux/err.h>
 
 #ifndef __NO_STUBS
diff --git a/include/linux/kevent.h b/include/linux/kevent.h
new file mode 100644
index 0000000..743b328
--- /dev/null
+++ b/include/linux/kevent.h
@@ -0,0 +1,205 @@
+/*
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
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/net.h>
+#include <linux/rcupdate.h>
+#include <linux/kevent_storage.h>
+#include <linux/ukevent.h>
+
+#define KEVENT_MIN_BUFFS_ALLOC	3
+
+struct kevent;
+struct kevent_storage;
+typedef int (* kevent_callback_t)(struct kevent *);
+
+/* @callback is called each time new event has been caught. */
+/* @enqueue is called each time new event is queued. */
+/* @dequeue is called each time event is dequeued. */
+
+struct kevent_callbacks {
+	kevent_callback_t	callback, enqueue, dequeue;
+};
+
+#define KEVENT_READY		0x1
+#define KEVENT_STORAGE		0x2
+#define KEVENT_USER		0x4
+
+struct kevent
+{
+	/* Used for kevent freeing.*/
+	struct rcu_head		rcu_head;
+	struct ukevent		event;
+	/* This lock protects ukevent manipulations, e.g. ret_flags changes. */
+	spinlock_t		ulock;
+
+	/* Entry of user's tree. */
+	struct rb_node		kevent_node;
+	/* Entry of origin's queue. */
+	struct list_head	storage_entry;
+	/* Entry of user's ready. */
+	struct list_head	ready_entry;
+
+	u32			flags;
+
+	/* User who requested this kevent. */
+	struct kevent_user	*user;
+	/* Kevent container. */
+	struct kevent_storage	*st;
+
+	struct kevent_callbacks	callbacks;
+
+	/* Private data for different storages.
+	 * poll()/select storage has a list of wait_queue_t containers
+	 * for each ->poll() { poll_wait()' } here.
+	 */
+	void			*priv;
+};
+
+struct kevent_user
+{
+	struct rb_root		kevent_root;
+	spinlock_t		kevent_lock;
+	/* Number of queued kevents. */
+	unsigned int		kevent_num;
+
+	/* List of ready kevents. */
+	struct list_head	ready_list;
+	/* Number of ready kevents. */
+	unsigned int		ready_num;
+	/* Protects all manipulations with ready queue. */
+	spinlock_t 		ready_lock;
+
+	/* Protects against simultaneous kevent_user control manipulations. */
+	struct mutex		ctl_mutex;
+	/* Wait until some events are ready. */
+	wait_queue_head_t	wait;
+
+	/* Reference counter, increased for each new kevent. */
+	atomic_t		refcnt;
+
+	/* First kevent which was not put into ring buffer due to overflow.
+	 * It will be copied into the buffer, when first event will be removed
+	 * from ready queue (and thus there will be an empty place in the
+	 * ring buffer).
+	 */
+	struct kevent		*overflow_kevent;
+	/* Array of pages forming mapped ring buffer */
+	struct kevent_mring	**pring;
+
+#ifdef CONFIG_KEVENT_USER_STAT
+	unsigned long		im_num;
+	unsigned long		wait_num, mmap_num;
+	unsigned long		total;
+#endif
+};
+
+int kevent_enqueue(struct kevent *k);
+int kevent_dequeue(struct kevent *k);
+int kevent_init(struct kevent *k);
+void kevent_requeue(struct kevent *k);
+int kevent_break(struct kevent *k);
+
+int kevent_add_callbacks(const struct kevent_callbacks *cb, int pos);
+
+int kevent_user_ring_add_event(struct kevent *k);
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
+#ifdef CONFIG_KEVENT_POLL
+void kevent_poll_reinit(struct file *file);
+#else
+static inline void kevent_poll_reinit(struct file *file)
+{
+}
+#endif
+
+#ifdef CONFIG_KEVENT_USER_STAT
+static inline void kevent_stat_init(struct kevent_user *u)
+{
+	u->wait_num = u->im_num = u->total = 0;
+}
+static inline void kevent_stat_print(struct kevent_user *u)
+{
+	printk(KERN_INFO "%s: u: %p, wait: %lu, mmap: %lu, immediately: %lu, total: %lu.\n",
+			__func__, u, u->wait_num, u->mmap_num, u->im_num, u->total);
+}
+static inline void kevent_stat_im(struct kevent_user *u)
+{
+	u->im_num++;
+}
+static inline void kevent_stat_mmap(struct kevent_user *u)
+{
+	u->mmap_num++;
+}
+static inline void kevent_stat_wait(struct kevent_user *u)
+{
+	u->wait_num++;
+}
+static inline void kevent_stat_total(struct kevent_user *u)
+{
+	u->total++;
+}
+#else
+#define kevent_stat_print(u)		({ (void) u;})
+#define kevent_stat_init(u)		({ (void) u;})
+#define kevent_stat_im(u)		({ (void) u;})
+#define kevent_stat_wait(u)		({ (void) u;})
+#define kevent_stat_mmap(u)		({ (void) u;})
+#define kevent_stat_total(u)		({ (void) u;})
+#endif
+
+#ifdef CONFIG_LOCKDEP
+void kevent_socket_reinit(struct socket *sock);
+void kevent_sk_reinit(struct sock *sk);
+#else
+static inline void kevent_socket_reinit(struct socket *sock)
+{
+}
+static inline void kevent_sk_reinit(struct sock *sk)
+{
+}
+#endif
+#ifdef CONFIG_KEVENT_SOCKET
+void kevent_socket_notify(struct sock *sock, u32 event);
+int kevent_socket_dequeue(struct kevent *k);
+int kevent_socket_enqueue(struct kevent *k);
+#define sock_async(__sk) sock_flag(__sk, SOCK_ASYNC)
+#else
+static inline void kevent_socket_notify(struct sock *sock, u32 event)
+{
+}
+#define sock_async(__sk)	({ (void)__sk; 0; })
+#endif
+
+#endif /* __KEVENT_H */
diff --git a/include/linux/kevent_storage.h b/include/linux/kevent_storage.h
new file mode 100644
index 0000000..a38575d
--- /dev/null
+++ b/include/linux/kevent_storage.h
@@ -0,0 +1,11 @@
+#ifndef __KEVENT_STORAGE_H
+#define __KEVENT_STORAGE_H
+
+struct kevent_storage
+{
+	void			*origin;		/* Originator's pointer, e.g. struct sock or struct file. Can be NULL. */
+	struct list_head	list;			/* List of queued kevents. */
+	spinlock_t		lock;			/* Protects users queue. */
+};
+
+#endif /* __KEVENT_STORAGE_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2d1c3d5..71a758f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -54,6 +54,7 @@ struct compat_stat;
 struct compat_timeval;
 struct robust_list_head;
 struct getcpu_cache;
+struct ukevent;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -599,4 +600,8 @@ asmlinkage long sys_set_robust_list(stru
 				    size_t len);
 asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
 
+asmlinkage long sys_kevent_get_events(int ctl_fd, unsigned int min, unsigned int max,
+		__u64 timeout, struct ukevent __user *buf, unsigned flags);
+asmlinkage long sys_kevent_ctl(int ctl_fd, unsigned int cmd, unsigned int num, struct ukevent __user *buf);
+asmlinkage long sys_kevent_wait(int ctl_fd, unsigned int start, unsigned int num, __u64 timeout);
 #endif
diff --git a/include/linux/ukevent.h b/include/linux/ukevent.h
new file mode 100644
index 0000000..daa8202
--- /dev/null
+++ b/include/linux/ukevent.h
@@ -0,0 +1,163 @@
+/*
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
+#ifndef __UKEVENT_H
+#define __UKEVENT_H
+
+/*
+ * Kevent request flags.
+ */
+
+/* Process this event only once and then dequeue. */
+#define KEVENT_REQ_ONESHOT	0x1
+
+/*
+ * Kevent return flags.
+ */
+/* Kevent is broken. */
+#define KEVENT_RET_BROKEN	0x1
+/* Kevent processing was finished successfully. */
+#define KEVENT_RET_DONE		0x2
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
+#define KEVENT_MASK_ALL		0xffffffff
+/* Mask of all possible event values. */
+#define KEVENT_MASK_EMPTY	0x0
+/* Empty mask of ready events. */
+
+struct kevent_id
+{
+	union {
+		__u32		raw[2];
+		__u64		raw_u64 __attribute__((aligned(8)));
+	};
+};
+
+struct ukevent
+{
+	/* Id of this request, e.g. socket number, file descriptor and so on... */
+	struct kevent_id	id;
+	/* Event type, e.g. KEVENT_SOCK, KEVENT_INODE, KEVENT_TIMER and so on... */
+	__u32			type;
+	/* Event itself, e.g. SOCK_ACCEPT, INODE_CREATED, TIMER_FIRED... */
+	__u32			event;
+	/* Per-event request flags */
+	__u32			req_flags;
+	/* Per-event return flags */
+	__u32			ret_flags;
+	/* Event return data. Event originator fills it with anything it likes. */
+	__u32			ret_data[2];
+	/* User's data. It is not used, just copied to/from user.
+	 * The whole structure is aligned to 8 bytes already, so the last union
+	 * is aligned properly.
+	 */
+	union {
+		__u32		user[2];
+		void		*ptr;
+	};
+};
+
+struct mukevent
+{
+	struct kevent_id	id;
+	__u32			ret_flags;
+};
+
+#define KEVENT_MAX_PAGES	2
+
+/*
+ * Note that kevents does not exactly fill the page (each mukevent is 12 bytes),
+ * so we reuse 4 bytes at the begining of the page to store index.
+ * Take that into account if you want to change size of struct mukevent.
+ */
+#define KEVENTS_ON_PAGE ((PAGE_SIZE-2*sizeof(unsigned int))/sizeof(struct mukevent))
+struct kevent_mring
+{
+	unsigned int		kidx, uidx;
+	struct mukevent		event[KEVENTS_ON_PAGE];
+};
+
+/*
+ * Used only for sanitizing of the kevent_wait() input data - do not
+ * allow user to specify number of events more than it is possible to place
+ * into ring buffer. This does not limit number of events which can be
+ * put into kevent queue (which is unlimited).
+ */
+#define KEVENT_MAX_EVENTS	(KEVENT_MAX_PAGES * KEVENTS_ON_PAGE)
+
+#define	KEVENT_CTL_ADD 		0
+#define	KEVENT_CTL_REMOVE	1
+#define	KEVENT_CTL_MODIFY	2
+
+#endif /* __UKEVENT_H */
diff --git a/init/Kconfig b/init/Kconfig
index d2eb7a8..c7d8250 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -201,6 +201,8 @@ config AUDITSYSCALL
 	  such as SELinux.  To use audit's filesystem watch feature, please
 	  ensure that INOTIFY is configured.
 
+source "kernel/kevent/Kconfig"
+
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
diff --git a/kernel/Makefile b/kernel/Makefile
index d62ec66..2d7a6dd 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_KEVENT) += kevent/
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o
diff --git a/kernel/kevent/Kconfig b/kernel/kevent/Kconfig
new file mode 100644
index 0000000..5ba8086
--- /dev/null
+++ b/kernel/kevent/Kconfig
@@ -0,0 +1,39 @@
+config KEVENT
+	bool "Kernel event notification mechanism"
+	help
+	  This option enables event queue mechanism.
+	  It can be used as replacement for poll()/select(), AIO callback
+	  invocations, advanced timer notifications and other kernel
+	  object status changes.
+
+config KEVENT_USER_STAT
+	bool "Kevent user statistic"
+	depends on KEVENT
+	help
+	  This option will turn kevent_user statistic collection on.
+	  Statistic data includes total number of kevent, number of kevents
+	  which are ready immediately at insertion time and number of kevents
+	  which were removed through readiness completion.
+	  It will be printed each time control kevent descriptor is closed.
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
+	  This option allows to use kevent subsystem for poll()/select()
+	  notifications.
+
+config KEVENT_SOCKET
+	bool "Kernel event notifications for sockets"
+	depends on NET && KEVENT
+	help
+	  This option enables notifications through KEVENT subsystem of 
+	  sockets operations, like new packet receiving conditions, 
+	  ready for accept conditions and so on.
+	
diff --git a/kernel/kevent/Makefile b/kernel/kevent/Makefile
new file mode 100644
index 0000000..9130cad
--- /dev/null
+++ b/kernel/kevent/Makefile
@@ -0,0 +1,4 @@
+obj-y := kevent.o kevent_user.o
+obj-$(CONFIG_KEVENT_TIMER) += kevent_timer.o
+obj-$(CONFIG_KEVENT_POLL) += kevent_poll.o
+obj-$(CONFIG_KEVENT_SOCKET) += kevent_socket.o
diff --git a/kernel/kevent/kevent.c b/kernel/kevent/kevent.c
new file mode 100644
index 0000000..25404d3
--- /dev/null
+++ b/kernel/kevent/kevent.c
@@ -0,0 +1,227 @@
+/*
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
+/*
+ * Attempts to add an event into appropriate origin's queue.
+ * Returns positive value if this event is ready immediately,
+ * negative value in case of error and zero if event has been queued.
+ * ->enqueue() callback must increase origin's reference counter.
+ */
+int kevent_enqueue(struct kevent *k)
+{
+	return k->callbacks.enqueue(k);
+}
+
+/*
+ * Remove event from the appropriate queue.
+ * ->dequeue() callback must decrease origin's reference counter.
+ */
+int kevent_dequeue(struct kevent *k)
+{
+	return k->callbacks.dequeue(k);
+}
+
+/*
+ * Mark kevent as broken.
+ */
+int kevent_break(struct kevent *k)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&k->ulock, flags);
+	k->event.ret_flags |= KEVENT_RET_BROKEN;
+	spin_unlock_irqrestore(&k->ulock, flags);
+	return -EINVAL;
+}
+
+static struct kevent_callbacks kevent_registered_callbacks[KEVENT_MAX] __read_mostly;
+
+int kevent_add_callbacks(const struct kevent_callbacks *cb, int pos)
+{
+	struct kevent_callbacks *p;
+
+	if (pos >= KEVENT_MAX)
+		return -EINVAL;
+
+	p = &kevent_registered_callbacks[pos];
+
+	p->enqueue = (cb->enqueue) ? cb->enqueue : kevent_break;
+	p->dequeue = (cb->dequeue) ? cb->dequeue : kevent_break;
+	p->callback = (cb->callback) ? cb->callback : kevent_break;
+
+	printk(KERN_INFO "KEVENT: Added callbacks for type %d.\n", pos);
+	return 0;
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
+	spin_lock_init(&k->ulock);
+	k->flags = 0;
+
+	if (unlikely(k->event.type >= KEVENT_MAX ||
+			!kevent_registered_callbacks[k->event.type].callback))
+		return kevent_break(k);
+
+	k->callbacks = kevent_registered_callbacks[k->event.type];
+	if (unlikely(k->callbacks.callback == kevent_break))
+		return kevent_break(k);
+
+	return 0;
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
+	list_add_tail_rcu(&k->storage_entry, &st->list);
+	k->flags |= KEVENT_STORAGE;
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
+	if (k->flags & KEVENT_STORAGE) {
+		list_del_rcu(&k->storage_entry);
+		k->flags &= ~KEVENT_STORAGE;
+	}
+	spin_unlock_irqrestore(&st->lock, flags);
+}
+
+/*
+ * Call kevent ready callback and queue it into ready queue if needed.
+ * If kevent is marked as one-shot, then remove it from storage queue.
+ */
+static void __kevent_requeue(struct kevent *k, u32 event)
+{
+	int ret, rem;
+	unsigned long flags;
+
+	ret = k->callbacks.callback(k);
+
+	spin_lock_irqsave(&k->ulock, flags);
+	if (ret > 0)
+		k->event.ret_flags |= KEVENT_RET_DONE;
+	else if (ret < 0)
+		k->event.ret_flags |= (KEVENT_RET_BROKEN | KEVENT_RET_DONE);
+	else
+		ret = (k->event.ret_flags & (KEVENT_RET_BROKEN|KEVENT_RET_DONE));
+	rem = (k->event.req_flags & KEVENT_REQ_ONESHOT);
+	spin_unlock_irqrestore(&k->ulock, flags);
+
+	if (ret) {
+		if ((rem || ret < 0) && (k->flags & KEVENT_STORAGE)) {
+			list_del_rcu(&k->storage_entry);
+			k->flags &= ~KEVENT_STORAGE;
+		}
+
+		spin_lock_irqsave(&k->user->ready_lock, flags);
+		if (!(k->flags & KEVENT_READY)) {
+			kevent_user_ring_add_event(k);
+			list_add_tail(&k->ready_entry, &k->user->ready_list);
+			k->flags |= KEVENT_READY;
+			k->user->ready_num++;
+		}
+		spin_unlock_irqrestore(&k->user->ready_lock, flags);
+		wake_up(&k->user->wait);
+	}
+}
+
+/*
+ * Check if kevent is ready (by invoking it's callback) and requeue/remove
+ * if needed.
+ */
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
+	struct kevent *k;
+
+	rcu_read_lock();
+	if (ready_callback)
+		list_for_each_entry_rcu(k, &st->list, storage_entry)
+			(*ready_callback)(k);
+
+	list_for_each_entry_rcu(k, &st->list, storage_entry)
+		if (event & k->event.event)
+			__kevent_requeue(k, event);
+	rcu_read_unlock();
+}
+
+int kevent_storage_init(void *origin, struct kevent_storage *st)
+{
+	spin_lock_init(&st->lock);
+	st->origin = origin;
+	INIT_LIST_HEAD(&st->list);
+	return 0;
+}
+
+/*
+ * Mark all events as broken, that will remove them from storage,
+ * so storage origin (inode, sockt and so on) can be safely removed.
+ * No new entries are allowed to be added into the storage at this point.
+ * (Socket is removed from file table at this point for example).
+ */
+void kevent_storage_fini(struct kevent_storage *st)
+{
+	kevent_storage_ready(st, kevent_break, KEVENT_MASK_ALL);
+}
diff --git a/kernel/kevent/kevent_user.c b/kernel/kevent/kevent_user.c
new file mode 100644
index 0000000..f3fec9b
--- /dev/null
+++ b/kernel/kevent/kevent_user.c
@@ -0,0 +1,1004 @@
+/*
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
+#include <linux/miscdevice.h>
+#include <asm/io.h>
+
+static const char kevent_name[] = "kevent";
+static kmem_cache_t *kevent_cache __read_mostly;
+
+/*
+ * kevents are pollable, return POLLIN and POLLRDNORM
+ * when there is at least one ready kevent.
+ */
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
+/*
+ * Called under kevent_user->ready_lock, so updates are always protected.
+ */
+int kevent_user_ring_add_event(struct kevent *k)
+{
+	unsigned int pidx, off;
+	struct kevent_mring *ring, *copy_ring;
+	
+	ring = k->user->pring[0];
+
+	if ((ring->kidx + 1 == ring->uidx) || 
+			((ring->kidx + 1 == KEVENT_MAX_EVENTS) && ring->uidx == 0)) {
+		if (k->user->overflow_kevent == NULL)
+			k->user->overflow_kevent = k;
+		return -EAGAIN;
+	}
+
+	pidx = ring->kidx/KEVENTS_ON_PAGE;
+	off = ring->kidx%KEVENTS_ON_PAGE;
+
+	if (unlikely(pidx >= KEVENT_MAX_PAGES)) {
+		printk(KERN_ERR "%s: kidx: %u, pidx: %u, on_page: %lu, pidx: %u.\n",
+				__func__, ring->kidx, ring->uidx, KEVENTS_ON_PAGE, pidx);
+		return -EINVAL;
+	}
+
+	copy_ring = k->user->pring[pidx];
+
+	copy_ring->event[off].id.raw[0] = k->event.id.raw[0];
+	copy_ring->event[off].id.raw[1] = k->event.id.raw[1];
+	copy_ring->event[off].ret_flags = k->event.ret_flags;
+
+	if (++ring->kidx >= KEVENT_MAX_EVENTS)
+		ring->kidx = 0;
+
+	return 0;
+}
+
+/*
+ * Initialize mmap ring buffer.
+ * It will store ready kevents, so userspace could get them directly instead
+ * of using syscall. Esentially syscall becomes just a waiting point.
+ * @KEVENT_MAX_PAGES is an arbitrary number of pages to store ready events.
+ */
+static int kevent_user_ring_init(struct kevent_user *u)
+{
+	int i;
+
+	u->pring = kzalloc(KEVENT_MAX_PAGES * sizeof(struct kevent_mring *), GFP_KERNEL);
+	if (!u->pring)
+		return -ENOMEM;
+
+	for (i=0; i<KEVENT_MAX_PAGES; ++i) {
+		u->pring[i] = (struct kevent_mring *)__get_free_page(GFP_KERNEL);
+		if (!u->pring[i])
+			goto err_out_free;
+	}
+
+	u->pring[0]->uidx = u->pring[0]->kidx = 0;
+
+	return 0;
+
+err_out_free:
+	for (i=0; i<KEVENT_MAX_PAGES; ++i) {
+		if (!u->pring[i])
+			break;
+
+		free_page((unsigned long)u->pring[i]);
+	}
+	
+	kfree(u->pring);
+
+	return -ENOMEM;
+}
+
+static void kevent_user_ring_fini(struct kevent_user *u)
+{
+	int i;
+
+	for (i=0; i<KEVENT_MAX_PAGES; ++i)
+		free_page((unsigned long)u->pring[i]);
+
+	kfree(u->pring);
+}
+
+static int kevent_user_open(struct inode *inode, struct file *file)
+{
+	struct kevent_user *u;
+
+	u = kzalloc(sizeof(struct kevent_user), GFP_KERNEL);
+	if (!u)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&u->ready_list);
+	spin_lock_init(&u->ready_lock);
+	kevent_stat_init(u);
+	spin_lock_init(&u->kevent_lock);
+	u->kevent_root = RB_ROOT;
+
+	mutex_init(&u->ctl_mutex);
+	init_waitqueue_head(&u->wait);
+
+	atomic_set(&u->refcnt, 1);
+
+	if (unlikely(kevent_user_ring_init(u))) {
+		kfree(u);
+		return -ENOMEM;
+	}
+
+	file->private_data = u;
+	return 0;
+}
+
+/*
+ * Kevent userspace control block reference counting.
+ * Set to 1 at creation time, when appropriate kevent file descriptor
+ * is closed, that reference counter is decreased.
+ * When counter hits zero block is freed.
+ */
+static inline void kevent_user_get(struct kevent_user *u)
+{
+	atomic_inc(&u->refcnt);
+}
+
+static inline void kevent_user_put(struct kevent_user *u)
+{
+	if (atomic_dec_and_test(&u->refcnt)) {
+		kevent_stat_print(u);
+		kevent_user_ring_fini(u);
+		kfree(u);
+	}
+}
+
+/*
+ * Mmap implementation for ring buffer, which is created as array
+ * of pages, so vm_pgoff is an offset (in pages, not in bytes) of
+ * the first page to be mapped.
+ */
+static int kevent_user_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long start = vma->vm_start, off = vma->vm_pgoff / PAGE_SIZE;
+	struct kevent_user *u = file->private_data;
+
+	if (off >= KEVENT_MAX_PAGES)
+		return -EINVAL;
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_file = file;
+
+	if (vm_insert_page(vma, start, virt_to_page(u->pring[off])))
+		return -EFAULT;
+
+	return 0;
+}
+
+static inline int kevent_compare_id(struct kevent_id *left, struct kevent_id *right)
+{
+	if (left->raw_u64 > right->raw_u64)
+		return -1;
+
+	if (right->raw_u64 > left->raw_u64)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * RCU protects storage list (kevent->storage_entry).
+ * Free entry in RCU callback, it is dequeued from all lists at
+ * this point.
+ */
+
+static void kevent_free_rcu(struct rcu_head *rcu)
+{
+	struct kevent *kevent = container_of(rcu, struct kevent, rcu_head);
+	kmem_cache_free(kevent_cache, kevent);
+}
+
+/*
+ * Must be called under u->ready_lock.
+ * This function removes kevent from ready queue and 
+ * tries to add new kevent into ring buffer.
+ */
+static void kevent_remove_ready(struct kevent *k)
+{
+	struct kevent_user *u = k->user;
+
+	if (++u->pring[0]->uidx == KEVENT_MAX_EVENTS)
+		u->pring[0]->uidx = 0;
+
+	if (u->overflow_kevent) {
+		int err;
+
+		err = kevent_user_ring_add_event(u->overflow_kevent);
+		if (!err || u->overflow_kevent == k) {
+			if (u->overflow_kevent->ready_entry.next == &u->ready_list)
+				u->overflow_kevent = NULL;
+			else
+				u->overflow_kevent = 
+					list_entry(u->overflow_kevent->ready_entry.next, 
+							struct kevent, ready_entry);
+		}
+	}
+	list_del(&k->ready_entry);
+	k->flags &= ~KEVENT_READY;
+	u->ready_num--;
+}
+
+/*
+ * Complete kevent removing - it dequeues kevent from storage list
+ * if it is requested, removes kevent from ready list, drops userspace
+ * control block reference counter and schedules kevent freeing through RCU.
+ */
+static void kevent_finish_user_complete(struct kevent *k, int deq)
+{
+	struct kevent_user *u = k->user;
+	unsigned long flags;
+
+	if (deq)
+		kevent_dequeue(k);
+
+	spin_lock_irqsave(&u->ready_lock, flags);
+	if (k->flags & KEVENT_READY)
+		kevent_remove_ready(k);
+	spin_unlock_irqrestore(&u->ready_lock, flags);
+
+	kevent_user_put(u);
+	call_rcu(&k->rcu_head, kevent_free_rcu);
+}
+
+/*
+ * Remove from all lists and free kevent.
+ * Must be called under kevent_user->kevent_lock to protect
+ * kevent->kevent_entry removing.
+ */
+static void __kevent_finish_user(struct kevent *k, int deq)
+{
+	struct kevent_user *u = k->user;
+
+	rb_erase(&k->kevent_node, &u->kevent_root);
+	k->flags &= ~KEVENT_USER;
+	u->kevent_num--;
+	kevent_finish_user_complete(k, deq);
+}
+
+/*
+ * Remove kevent from user's list of all events,
+ * dequeue it from storage and decrease user's reference counter,
+ * since this kevent does not exist anymore. That is why it is freed here.
+ */
+static void kevent_finish_user(struct kevent *k, int deq)
+{
+	struct kevent_user *u = k->user;
+	unsigned long flags;
+
+	spin_lock_irqsave(&u->kevent_lock, flags);
+	rb_erase(&k->kevent_node, &u->kevent_root);
+	k->flags &= ~KEVENT_USER;
+	u->kevent_num--;
+	spin_unlock_irqrestore(&u->kevent_lock, flags);
+	kevent_finish_user_complete(k, deq);
+}
+
+/*
+ * Dequeue one entry from user's ready queue.
+ */
+static struct kevent *kqueue_dequeue_ready(struct kevent_user *u)
+{
+	unsigned long flags;
+	struct kevent *k = NULL;
+
+	spin_lock_irqsave(&u->ready_lock, flags);
+	if (u->ready_num && !list_empty(&u->ready_list)) {
+		k = list_entry(u->ready_list.next, struct kevent, ready_entry);
+		kevent_remove_ready(k);
+	}
+	spin_unlock_irqrestore(&u->ready_lock, flags);
+
+	return k;
+}
+
+/*
+ * Search a kevent inside kevent tree for given ukevent.
+ */
+static struct kevent *__kevent_search(struct kevent_id *id, struct kevent_user *u)
+{
+	struct kevent *k, *ret = NULL;
+	struct rb_node *n = u->kevent_root.rb_node;
+	int cmp;
+
+	while (n) {
+		k = rb_entry(n, struct kevent, kevent_node);
+		cmp = kevent_compare_id(&k->event.id, id);
+
+		if (cmp > 0)
+			n = n->rb_right;
+		else if (cmp < 0)
+			n = n->rb_left;
+		else {
+			ret = k;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Search and modify kevent according to provided ukevent.
+ */
+static int kevent_modify(struct ukevent *uk, struct kevent_user *u)
+{
+	struct kevent *k;
+	int err = -ENODEV;
+	unsigned long flags;
+
+	spin_lock_irqsave(&u->kevent_lock, flags);
+	k = __kevent_search(&uk->id, u);
+	if (k) {
+		spin_lock(&k->ulock);
+		k->event.event = uk->event;
+		k->event.req_flags = uk->req_flags;
+		k->event.ret_flags = 0;
+		spin_unlock(&k->ulock);
+		kevent_requeue(k);
+		err = 0;
+	}
+	spin_unlock_irqrestore(&u->kevent_lock, flags);
+
+	return err;
+}
+
+/*
+ * Remove kevent which matches provided ukevent.
+ */
+static int kevent_remove(struct ukevent *uk, struct kevent_user *u)
+{
+	int err = -ENODEV;
+	struct kevent *k;
+	unsigned long flags;
+
+	spin_lock_irqsave(&u->kevent_lock, flags);
+	k = __kevent_search(&uk->id, u);
+	if (k) {
+		__kevent_finish_user(k, 1);
+		err = 0;
+	}
+	spin_unlock_irqrestore(&u->kevent_lock, flags);
+
+	return err;
+}
+
+/*
+ * Detaches userspace control block from file descriptor
+ * and decrease it's reference counter.
+ * No new kevents can be added or removed from any list at this point.
+ */
+static int kevent_user_release(struct inode *inode, struct file *file)
+{
+	struct kevent_user *u = file->private_data;
+	struct kevent *k;
+	struct rb_node *n;
+
+	for (n = rb_first(&u->kevent_root); n; n = rb_next(n)) {
+		k = rb_entry(n, struct kevent, kevent_node);
+		kevent_finish_user(k, 1);
+	}
+
+	kevent_user_put(u);
+	file->private_data = NULL;
+
+	return 0;
+}
+
+/*
+ * Read requested number of ukevents in one shot.
+ */
+static struct ukevent *kevent_get_user(unsigned int num, void __user *arg)
+{
+	struct ukevent *ukev;
+
+	ukev = kmalloc(sizeof(struct ukevent) * num, GFP_KERNEL);
+	if (!ukev)
+		return NULL;
+
+	if (copy_from_user(ukev, arg, sizeof(struct ukevent) * num)) {
+		kfree(ukev);
+		return NULL;
+	}
+
+	return ukev;
+}
+
+/*
+ * Read from userspace all ukevents and modify appropriate kevents.
+ * If provided number of ukevents is more that threshold, it is faster
+ * to allocate a room for them and copy in one shot instead of copy
+ * one-by-one and then process them.
+ */
+static int kevent_user_ctl_modify(struct kevent_user *u, unsigned int num, void __user *arg)
+{
+	int err = 0, i;
+	struct ukevent uk;
+
+	mutex_lock(&u->ctl_mutex);
+
+	if (num > u->kevent_num) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (num > KEVENT_MIN_BUFFS_ALLOC) {
+		struct ukevent *ukev;
+
+		ukev = kevent_get_user(num, arg);
+		if (ukev) {
+			for (i = 0; i < num; ++i) {
+				if (kevent_modify(&ukev[i], u))
+					ukev[i].ret_flags |= KEVENT_RET_BROKEN;
+				ukev[i].ret_flags |= KEVENT_RET_DONE;
+			}
+			if (copy_to_user(arg, ukev, num*sizeof(struct ukevent)))
+				err = -EFAULT;
+			kfree(ukev);
+			goto out;
+		}
+	}
+
+	for (i = 0; i < num; ++i) {
+		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (kevent_modify(&uk, u))
+			uk.ret_flags |= KEVENT_RET_BROKEN;
+		uk.ret_flags |= KEVENT_RET_DONE;
+
+		if (copy_to_user(arg, &uk, sizeof(struct ukevent))) {
+			err = -EFAULT;
+			break;
+		}
+
+		arg += sizeof(struct ukevent);
+	}
+out:
+	mutex_unlock(&u->ctl_mutex);
+
+	return err;
+}
+
+/*
+ * Read from userspace all ukevents and remove appropriate kevents.
+ * If provided number of ukevents is more that threshold, it is faster
+ * to allocate a room for them and copy in one shot instead of copy
+ * one-by-one and then process them.
+ */
+static int kevent_user_ctl_remove(struct kevent_user *u, unsigned int num, void __user *arg)
+{
+	int err = 0, i;
+	struct ukevent uk;
+
+	mutex_lock(&u->ctl_mutex);
+
+	if (num > u->kevent_num) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (num > KEVENT_MIN_BUFFS_ALLOC) {
+		struct ukevent *ukev;
+
+		ukev = kevent_get_user(num, arg);
+		if (ukev) {
+			for (i = 0; i < num; ++i) {
+				if (kevent_remove(&ukev[i], u))
+					ukev[i].ret_flags |= KEVENT_RET_BROKEN;
+				ukev[i].ret_flags |= KEVENT_RET_DONE;
+			}
+			if (copy_to_user(arg, ukev, num*sizeof(struct ukevent)))
+				err = -EFAULT;
+			kfree(ukev);
+			goto out;
+		}
+	}
+
+	for (i = 0; i < num; ++i) {
+		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (kevent_remove(&uk, u))
+			uk.ret_flags |= KEVENT_RET_BROKEN;
+
+		uk.ret_flags |= KEVENT_RET_DONE;
+
+		if (copy_to_user(arg, &uk, sizeof(struct ukevent))) {
+			err = -EFAULT;
+			break;
+		}
+
+		arg += sizeof(struct ukevent);
+	}
+out:
+	mutex_unlock(&u->ctl_mutex);
+
+	return err;
+}
+
+/*
+ * Queue kevent into userspace control block and increase
+ * it's reference counter.
+ */
+static int kevent_user_enqueue(struct kevent_user *u, struct kevent *new)
+{
+	unsigned long flags;
+	struct rb_node **p = &u->kevent_root.rb_node, *parent = NULL;
+	struct kevent *k;
+	int err = 0, cmp;
+
+	spin_lock_irqsave(&u->kevent_lock, flags);
+	while (*p) {
+		parent = *p;
+		k = rb_entry(parent, struct kevent, kevent_node);
+
+		cmp = kevent_compare_id(&k->event.id, &new->event.id);
+		if (cmp > 0)
+			p = &parent->rb_right;
+		else if (cmp < 0)
+			p = &parent->rb_left;
+		else {
+			err = -EEXIST;
+			break;
+		}
+	}
+	if (likely(!err)) {
+		rb_link_node(&new->kevent_node, parent, p);
+		rb_insert_color(&new->kevent_node, &u->kevent_root);
+		new->flags |= KEVENT_USER;
+		u->kevent_num++;
+		kevent_user_get(u);
+	}
+	spin_unlock_irqrestore(&u->kevent_lock, flags);
+
+	return err;
+}
+
+/*
+ * Add kevent from both kernel and userspace users.
+ * This function allocates and queues kevent, returns negative value
+ * on error, positive if kevent is ready immediately and zero
+ * if kevent has been queued.
+ */
+int kevent_user_add_ukevent(struct ukevent *uk, struct kevent_user *u)
+{
+	struct kevent *k;
+	int err;
+
+	k = kmem_cache_alloc(kevent_cache, GFP_KERNEL);
+	if (!k) {
+		err = -ENOMEM;
+		goto err_out_exit;
+	}
+
+	memcpy(&k->event, uk, sizeof(struct ukevent));
+	INIT_RCU_HEAD(&k->rcu_head);
+
+	k->event.ret_flags = 0;
+
+	err = kevent_init(k);
+	if (err) {
+		kmem_cache_free(kevent_cache, k);
+		goto err_out_exit;
+	}
+	k->user = u;
+	kevent_stat_total(u);
+	err = kevent_user_enqueue(u, k);
+	if (err) {
+		kmem_cache_free(kevent_cache, k);
+		goto err_out_exit;
+	}
+
+	err = kevent_enqueue(k);
+	if (err) {
+		memcpy(uk, &k->event, sizeof(struct ukevent));
+		kevent_finish_user(k, 0);
+		goto err_out_exit;
+	}
+
+	return 0;
+
+err_out_exit:
+	if (err < 0) {
+		uk->ret_flags |= KEVENT_RET_BROKEN | KEVENT_RET_DONE;
+		uk->ret_data[1] = err;
+	} else if (err > 0)
+		uk->ret_flags |= KEVENT_RET_DONE;
+	return err;
+}
+
+/*
+ * Copy all ukevents from userspace, allocate kevent for each one
+ * and add them into appropriate kevent_storages,
+ * e.g. sockets, inodes and so on...
+ * Ready events will replace ones provided by used and number
+ * of ready events is returned.
+ * User must check ret_flags field of each ukevent structure
+ * to determine if it is fired or failed event.
+ */
+static int kevent_user_ctl_add(struct kevent_user *u, unsigned int num, void __user *arg)
+{
+	int err, cerr = 0, rnum = 0, i;
+	void __user *orig = arg;
+	struct ukevent uk;
+
+	mutex_lock(&u->ctl_mutex);
+
+	err = -EINVAL;
+	if (num > KEVENT_MIN_BUFFS_ALLOC) {
+		struct ukevent *ukev;
+
+		ukev = kevent_get_user(num, arg);
+		if (ukev) {
+			for (i = 0; i < num; ++i) {
+				err = kevent_user_add_ukevent(&ukev[i], u);
+				if (err) {
+					kevent_stat_im(u);
+					if (i != rnum)
+						memcpy(&ukev[rnum], &ukev[i], sizeof(struct ukevent));
+					rnum++;
+				}
+			}
+			if (copy_to_user(orig, ukev, rnum*sizeof(struct ukevent)))
+				cerr = -EFAULT;
+			kfree(ukev);
+			goto out_setup;
+		}
+	}
+
+	for (i = 0; i < num; ++i) {
+		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
+			cerr = -EFAULT;
+			break;
+		}
+		arg += sizeof(struct ukevent);
+
+		err = kevent_user_add_ukevent(&uk, u);
+		if (err) {
+			kevent_stat_im(u);
+			if (copy_to_user(orig, &uk, sizeof(struct ukevent))) {
+				cerr = -EFAULT;
+				break;
+			}
+			orig += sizeof(struct ukevent);
+			rnum++;
+		}
+	}
+
+out_setup:
+	if (cerr < 0) {
+		err = cerr;
+		goto out_remove;
+	}
+
+	err = rnum;
+out_remove:
+	mutex_unlock(&u->ctl_mutex);
+
+	return err;
+}
+
+/*
+ * In nonblocking mode it returns as many events as possible, but not more than @max_nr.
+ * In blocking mode it waits until timeout or if at least @min_nr events are ready.
+ */
+static int kevent_user_wait(struct file *file, struct kevent_user *u,
+		unsigned int min_nr, unsigned int max_nr, __u64 timeout,
+		void __user *buf)
+{
+	struct kevent *k;
+	int num = 0;
+
+	if (!(file->f_flags & O_NONBLOCK)) {
+		wait_event_interruptible_timeout(u->wait,
+			u->ready_num >= min_nr,
+			clock_t_to_jiffies(nsec_to_clock_t(timeout)));
+	}
+
+	while (num < max_nr && ((k = kqueue_dequeue_ready(u)) != NULL)) {
+		if (copy_to_user(buf + num*sizeof(struct ukevent),
+					&k->event, sizeof(struct ukevent)))
+			break;
+
+		/*
+		 * If it is one-shot kevent, it has been removed already from
+		 * origin's queue, so we can easily free it here.
+		 */
+		if (k->event.req_flags & KEVENT_REQ_ONESHOT)
+			kevent_finish_user(k, 1);
+		++num;
+		kevent_stat_wait(u);
+	}
+
+	return num;
+}
+
+static struct file_operations kevent_user_fops = {
+	.mmap		= kevent_user_mmap,
+	.open		= kevent_user_open,
+	.release	= kevent_user_release,
+	.poll		= kevent_user_poll,
+	.owner		= THIS_MODULE,
+};
+
+static struct miscdevice kevent_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = kevent_name,
+	.fops = &kevent_user_fops,
+};
+
+static int kevent_ctl_process(struct file *file, unsigned int cmd, unsigned int num, void __user *arg)
+{
+	int err;
+	struct kevent_user *u = file->private_data;
+
+	switch (cmd) {
+	case KEVENT_CTL_ADD:
+		err = kevent_user_ctl_add(u, num, arg);
+		break;
+	case KEVENT_CTL_REMOVE:
+		err = kevent_user_ctl_remove(u, num, arg);
+		break;
+	case KEVENT_CTL_MODIFY:
+		err = kevent_user_ctl_modify(u, num, arg);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+/*
+ * Used to get ready kevents from queue.
+ * @ctl_fd - kevent control descriptor which must be obtained through kevent_ctl(KEVENT_CTL_INIT).
+ * @min_nr - minimum number of ready kevents.
+ * @max_nr - maximum number of ready kevents.
+ * @timeout - timeout in nanoseconds to wait until some events are ready.
+ * @buf - buffer to place ready events.
+ * @flags - ununsed for now (will be used for mmap implementation).
+ */
+asmlinkage long sys_kevent_get_events(int ctl_fd, unsigned int min_nr, unsigned int max_nr,
+		__u64 timeout, struct ukevent __user *buf, unsigned flags)
+{
+	int err = -EINVAL;
+	struct file *file;
+	struct kevent_user *u;
+
+	file = fget(ctl_fd);
+	if (!file)
+		return -EBADF;
+
+	if (file->f_op != &kevent_user_fops)
+		goto out_fput;
+	u = file->private_data;
+
+	err = kevent_user_wait(file, u, min_nr, max_nr, timeout, buf);
+out_fput:
+	fput(file);
+	return err;
+}
+
+/*
+ * This syscall is used to perform waiting until there is free space in kevent queue
+ * and removes/requeues requested number of events (commits them). Function returns
+ * number of actually committed events.
+ *
+ * @ctl_fd - kevent file descriptor.
+ * @start - number of first ready event.
+ * @num - number of processed kevents.
+ * @timeout - this timeout specifies number of nanoseconds to wait until there is
+ * 	free space in kevent queue.
+ *
+ * Ring buffer is designed in a way that first ready kevent will be at @ring->uidx 
+ * position, and all other ready events will be in FIFO order after it.
+ * So when we need to commit @num events, it means we should just remove first @num
+ * kevents from ready queue and commit them. We do not use any special locking to
+ * protect this function against simultaneous running - kevent dequeueing is atomic,
+ * and we do not care about order in which events were committed.
+ * An example: thread 1 and thread 2 simultaneously call kevent_wait() to 
+ * commit 2 and 3 events. It is possible that first thread will commit 
+ * events 0 and 2 while second thread will commit events 1, 3 and 4.
+ * If there were only 3 ready events, then one of the calls will return lesser number
+ * of committed events than it was requested.
+ * ring->uidx update is atomic, since it is protected by u->ready_lock,
+ * which removes race with kevent_user_ring_add_event().
+ *
+ * If user asks to commit events which have beed removed by kevent_get_events() recently 
+ * (for example when one thread looked into ring indexes and started to commit evets, 
+ * which were simultaneously committed by other thread through kevent_get_events(),
+ * kevent_wait() will not commit unprocessed events, but will return number of actually
+ * committed events instead.
+ *
+ * It is forbidden to try to commit events not from the start of the buffer, but from
+ * some 'futher' event.
+ *
+ * An example: if ready events use positions 2-5, 
+ * it is permitted to start to commit 3 events from position 0, 
+ *   in this case 0 and 1 positions will be ommited and only event in position 2 will 
+ *   be committed and kevent_wait() will return 1, since only one event was actually committed.
+ * It is forbidden to try to commit from position 4, 0 will be returned.
+ * This means that if some events were committed using kevent_get_events(), 
+ * they will not be counted, instead userspace should check ring index and try to commit again.
+ */
+asmlinkage long sys_kevent_wait(int ctl_fd, unsigned int start, unsigned int num, __u64 timeout)
+{
+	int err = -EINVAL, committed = 0;
+	struct file *file;
+	struct kevent_user *u;
+	struct kevent *k;
+	struct kevent_mring *ring;
+	unsigned int i, actual;
+	unsigned long flags;
+
+	if (num >= KEVENT_MAX_EVENTS)
+		return -EINVAL;
+
+	file = fget(ctl_fd);
+	if (!file)
+		return -EBADF;
+
+	if (file->f_op != &kevent_user_fops)
+		goto out_fput;
+	u = file->private_data;
+
+	ring = u->pring[0];
+
+	spin_lock_irqsave(&u->ready_lock, flags);
+	actual = (ring->kidx > ring->uidx)?
+			(ring->kidx - ring->uidx):
+			(KEVENT_MAX_EVENTS - (ring->uidx - ring->kidx));
+
+	if (actual < num)
+		num = actual;
+
+	if (start < ring->uidx) {
+		/*
+		 * Some events have been committed through kevent_get_events().
+		 *                 ready events
+		 * |==========|RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR|==========|
+		 *          ring->uidx                      ring->kidx
+		 *      |               |
+		 *    start           start+num
+		 *
+		 */
+		unsigned int diff = ring->uidx - start;
+
+		if (num < diff)
+			num = 0;
+		else
+			num -= diff;
+	} else if (start > ring->uidx)
+		num = 0;
+	
+	spin_unlock_irqrestore(&u->ready_lock, flags);
+
+	for (i=0; i<num; ++i) {
+		k = kqueue_dequeue_ready(u);
+		if (!k)
+			break;
+
+		if (k->event.req_flags & KEVENT_REQ_ONESHOT)
+			kevent_finish_user(k, 1);
+		kevent_stat_mmap(u);
+		committed++;
+	}
+
+	if (!(file->f_flags & O_NONBLOCK)) {
+		wait_event_interruptible_timeout(u->wait,
+			u->ready_num >= 1,
+			clock_t_to_jiffies(nsec_to_clock_t(timeout)));
+	}
+	
+	fput(file);
+
+	return committed;
+out_fput:
+	fput(file);
+	return err;
+}
+
+/*
+ * This syscall is used to perform various control operations
+ * on given kevent queue, which is obtained through kevent file descriptor @fd.
+ * @cmd - type of operation.
+ * @num - number of kevents to be processed.
+ * @arg - pointer to array of struct ukevent.
+ */
+asmlinkage long sys_kevent_ctl(int fd, unsigned int cmd, unsigned int num, struct ukevent __user *arg)
+{
+	int err = -EINVAL;
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	if (file->f_op != &kevent_user_fops)
+		goto out_fput;
+
+	err = kevent_ctl_process(file, cmd, num, arg);
+
+out_fput:
+	fput(file);
+	return err;
+}
+
+/*
+ * Kevent subsystem initialization - create kevent cache and register
+ * filesystem to get control file descriptors from.
+ */
+static int __init kevent_user_init(void)
+{
+	int err = 0;
+
+	kevent_cache = kmem_cache_create("kevent_cache",
+			sizeof(struct kevent), 0, SLAB_PANIC, NULL, NULL);
+
+	err = misc_register(&kevent_miscdev);
+	if (err) {
+		printk(KERN_ERR "Failed to register kevent miscdev: err=%d.\n", err);
+		goto err_out_exit;
+	}
+
+	printk(KERN_INFO "KEVENT subsystem has been successfully registered.\n");
+
+	return 0;
+
+err_out_exit:
+	kmem_cache_destroy(kevent_cache);
+	return err;
+}
+
+module_init(kevent_user_init);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 7a3b2e7..bc0582b 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -122,6 +122,10 @@ cond_syscall(ppc_rtas);
 cond_syscall(sys_spu_run);
 cond_syscall(sys_spu_create);
 
+cond_syscall(sys_kevent_get_events);
+cond_syscall(sys_kevent_wait);
+cond_syscall(sys_kevent_ctl);
+
 /* mmu depending weak syscall entries */
 cond_syscall(sys_mprotect);
 cond_syscall(sys_msync);

