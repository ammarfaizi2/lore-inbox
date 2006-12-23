Return-Path: <linux-kernel-owner+w=401wt.eu-S1753658AbWLWQyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbWLWQyc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 11:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbWLWQyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 11:54:07 -0500
Received: from dea.vocord.ru ([217.67.177.50]:33220 "EHLO
	kano.factory.vocord.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753620AbWLWQwv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 11:52:51 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>
Subject: [take29 2/8] kevent: Core files.
In-Reply-To: <11668927002665@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Sat, 23 Dec 2006 19:51:40 +0300
Message-Id: <11668927003479@2ka.mipt.ru>
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
index 7e639f7..a6221c2 100644
--- a/arch/i386/kernel/syscall_table.S
+++ b/arch/i386/kernel/syscall_table.S
@@ -318,3 +318,8 @@ ENTRY(sys_call_table)
 	.long sys_vmsplice
 	.long sys_move_pages
 	.long sys_getcpu
+	.long sys_kevent_get_events
+	.long sys_kevent_ctl		/* 320 */
+	.long sys_kevent_wait
+	.long sys_kevent_commit
+	.long sys_kevent_init
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index b4aa875..dda2168 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -714,8 +714,13 @@ ia32_sys_call_table:
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
+	.quad sys_kevent_commit
+	.quad sys_kevent_init
 ia32_syscall_end:		
diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index bd99870..57a6b8c 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -324,10 +324,15 @@
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
 #define __NR_getcpu		318
+#define __NR_kevent_get_events	319
+#define __NR_kevent_ctl		320
+#define __NR_kevent_wait	321
+#define __NR_kevent_commit	322
+#define __NR_kevent_init	323
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 319
+#define NR_syscalls 324
 #include <linux/err.h>
 
 /*
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index 6137146..17d750d 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -619,10 +619,20 @@ __SYSCALL(__NR_sync_file_range, sys_sync_file_range)
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages		279
 __SYSCALL(__NR_move_pages, sys_move_pages)
+#define __NR_kevent_get_events	280
+__SYSCALL(__NR_kevent_get_events, sys_kevent_get_events)
+#define __NR_kevent_ctl		281
+__SYSCALL(__NR_kevent_ctl, sys_kevent_ctl)
+#define __NR_kevent_wait	282
+__SYSCALL(__NR_kevent_wait, sys_kevent_wait)
+#define __NR_kevent_commit	283
+__SYSCALL(__NR_kevent_commit, sys_kevent_commit)
+#define __NR_kevent_init	284
+__SYSCALL(__NR_kevent_init, sys_kevent_init)
 
 #ifdef __KERNEL__
 
-#define __NR_syscall_max __NR_move_pages
+#define __NR_syscall_max __NR_kevent_init
 #include <linux/err.h>
 
 #ifndef __NO_STUBS
diff --git a/include/linux/kevent.h b/include/linux/kevent.h
new file mode 100644
index 0000000..2c31df3
--- /dev/null
+++ b/include/linux/kevent.h
@@ -0,0 +1,244 @@
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
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/hrtimer.h>
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
+/* @flags - flags for given set of callbacks. */
+
+struct kevent_callbacks {
+	kevent_callback_t	callback, enqueue, dequeue;
+	unsigned int		flags;
+};
+
+#define KEVENT_CALLBACKS_KERNELONLY	0x1
+
+int kevent_event_is_allowed(struct ukevent *e);
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
+	/* Exit from syscall if someone wants us to do it */
+	int			need_exit;
+
+	/* Reference counter, increased for each new kevent. */
+	atomic_t		refcnt;
+
+	/* Mutex protecting userspace ring buffer. */
+	struct mutex		ring_lock;
+	/* Kernel index and size of the userspace ring buffer. */
+	unsigned int		kidx, uidx, ring_size, ring_over, full;
+	/* Pointer to userspace ring buffer. */
+	struct kevent_ring __user *pring;
+
+	/* Is used for absolute waiting times. */
+	struct hrtimer		timer;
+
+#ifdef CONFIG_KEVENT_USER_STAT
+	unsigned long		im_num;
+	unsigned long		wait_num, ring_num;
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
+void kevent_storage_ready(struct kevent_storage *st,
+		kevent_callback_t ready_callback, u32 event);
+int kevent_storage_init(void *origin, struct kevent_storage *st);
+void kevent_storage_fini(struct kevent_storage *st);
+int kevent_storage_enqueue(struct kevent_storage *st, struct kevent *k);
+void kevent_storage_dequeue(struct kevent_storage *st, struct kevent *k);
+
+void kevent_ready(struct kevent *k, int ret);
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
+	u->wait_num = u->im_num = u->total = u->ring_num = 0;
+}
+static inline void kevent_stat_print(struct kevent_user *u)
+{
+	printk(KERN_INFO "%s: u: %p, wait: %lu, ring: %lu, immediately: %lu, total: %lu.\n",
+			__func__, u, u->wait_num, u->ring_num, u->im_num, u->total);
+}
+static inline void kevent_stat_im(struct kevent_user *u)
+{
+	u->im_num++;
+}
+static inline void kevent_stat_ring(struct kevent_user *u)
+{
+	u->ring_num++;
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
+#define kevent_stat_ring(u)		({ (void) u;})
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
+#ifdef CONFIG_KEVENT_POLL
+static inline void kevent_init_file(struct file *file)
+{
+	kevent_storage_init(file, &file->st);
+}
+
+static inline void kevent_cleanup_file(struct file *file)
+{
+	kevent_storage_fini(&file->st);
+}
+#else
+static inline void kevent_init_file(struct file *file) {}
+static inline void kevent_cleanup_file(struct file *file) {}
+#endif
+
+#ifdef CONFIG_KEVENT_PIPE
+extern void kevent_pipe_notify(struct inode *inode, u32 events);
+#else
+static inline void kevent_pipe_notify(struct inode *inode, u32 events) {}
+#endif
+
+#ifdef CONFIG_KEVENT_SIGNAL
+extern int kevent_signal_notify(struct task_struct *tsk, int sig);
+#else
+static inline int kevent_signal_notify(struct task_struct *tsk, int sig) {return 0;}
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
index 2d1c3d5..7574ec3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -54,6 +54,8 @@ struct compat_stat;
 struct compat_timeval;
 struct robust_list_head;
 struct getcpu_cache;
+struct ukevent;
+struct kevent_ring;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -599,4 +601,11 @@ asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
 
+asmlinkage long sys_kevent_get_events(int ctl_fd, unsigned int min, unsigned int max,
+		struct timespec timeout, struct ukevent __user *buf, unsigned flags);
+asmlinkage long sys_kevent_ctl(int ctl_fd, unsigned int cmd, unsigned int num, struct ukevent __user *buf);
+asmlinkage long sys_kevent_wait(int ctl_fd, unsigned int num, unsigned int old_uidx, 
+		struct timespec timeout, unsigned int flags);
+asmlinkage long sys_kevent_commit(int ctl_fd, unsigned int new_uidx, unsigned int over);
+asmlinkage long sys_kevent_init(int ctl_fd, struct kevent_ring __user *ring, unsigned int num, unsigned int flags);
 #endif
diff --git a/include/linux/ukevent.h b/include/linux/ukevent.h
new file mode 100644
index 0000000..e59dda7
--- /dev/null
+++ b/include/linux/ukevent.h
@@ -0,0 +1,186 @@
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
+#include <linux/types.h>
+
+/*
+ * Kevent request flags.
+ */
+
+/* Process this event only once and then remove it. */
+#define KEVENT_REQ_ONESHOT	0x1
+/* Kevent wakes up only first thread interested in given event,
+ * or all threads if this flag is set.
+ */
+#define KEVENT_REQ_WAKEUP_ALL	0x2
+/* Edge Triggered behaviour. */
+#define KEVENT_REQ_ET		0x4
+/* Perform the last check on kevent (call appropriate callback) when
+ * kevent is marked as ready and has been removed from ready queue.
+ * If it will be confirmed that kevent is ready 
+ * (k->callbacks.callback(k) returns true) then kevent will be copied
+ * to userspace, otherwise it will be requeued back to storage. 
+ * Second (checking) call is performed with this bit _cleared_ so
+ * callback can detect when it was called from 
+ * kevent_storage_ready() - bit is set, or 
+ * kevent_dequeue_ready() - bit is cleared. 
+ * If kevent will be requeued, bit will be set again. */
+#define KEVENT_REQ_LAST_CHECK	0x8
+/*
+ * Always queue kevent even if it is immediately ready.
+ */
+#define KEVENT_REQ_ALWAYS_QUEUE	0x10
+
+/*
+ * Kevent return flags.
+ */
+/* Kevent is broken. */
+#define KEVENT_RET_BROKEN	0x1
+/* Kevent processing was finished successfully. */
+#define KEVENT_RET_DONE		0x2
+/* Kevent was not copied into ring buffer due to some error conditions. */
+#define KEVENT_RET_COPY_FAILED	0x4
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
+#define KEVENT_PIPE		6
+#define KEVENT_SIGNAL		7
+#define KEVENT_POSIX_TIMER	8
+
+/* Used as array size, so must be equal to the last KEVENT type + 1 */
+#define	KEVENT_MAX		9
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
+ * Socket/network asynchronous IO and PIPE events.
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
+#define KEVENT_POLL_POLLRDHUP	0x2000
+
+/*
+ * Asynchronous IO events.
+ */
+#define	KEVENT_AIO_BIO		0x1
+
+/*
+ * Signal events.
+ */
+#define KEVENT_SIGNAL_DELIVERY		0x1
+
+/* If set in raw64, then given signals will not be delivered
+ * in a usual way through sigmask update and signal callback 
+ * invocation. */
+#define KEVENT_SIGNAL_NOMASK	0x8000000000000000ULL
+
+/* Mask of all possible event values. */
+#define KEVENT_MASK_ALL		0xffffffff
+/* Empty mask of ready events. */
+#define KEVENT_MASK_EMPTY	0x0
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
+struct kevent_ring
+{
+	unsigned int		ring_kidx, ring_over;
+	struct ukevent		event[0];
+};
+
+#define	KEVENT_CTL_ADD 		0
+#define	KEVENT_CTL_REMOVE	1
+#define	KEVENT_CTL_MODIFY	2
+#define	KEVENT_CTL_READY	3
+
+/* Provided timespec parameter uses absolute time, i.e. 'wait until Aug 27, 2194' */
+#define KEVENT_FLAGS_ABSTIME	1
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
@@ -47,6 +47,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softlockup.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_KEVENT) += kevent/
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o
diff --git a/kernel/kevent/Kconfig b/kernel/kevent/Kconfig
new file mode 100644
index 0000000..c6cdb0a
--- /dev/null
+++ b/kernel/kevent/Kconfig
@@ -0,0 +1,66 @@
+config KEVENT
+	bool "Kernel event notification mechanism" if EMBEDDED
+	default y
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
+	default y
+	help
+	  This option allows to use timers through KEVENT subsystem.
+
+config KEVENT_POLL
+	bool "Kernel event notifications for poll()/select()"
+	depends on KEVENT
+	default y
+	help
+	  This option allows to use kevent subsystem for poll()/select()
+	  notifications.
+
+config KEVENT_SOCKET
+	bool "Kernel event notifications for sockets"
+	depends on NET && KEVENT
+	default y
+	help
+	  This option enables notifications through KEVENT subsystem of 
+	  sockets operations, like new packet receiving conditions, 
+	  ready for accept conditions and so on.
+
+config KEVENT_PIPE
+	bool "Kernel event notifications for pipes"
+	depends on KEVENT
+	default y
+	help
+	  This option enables notifications through KEVENT subsystem of 
+	  pipe read/write operations.
+
+config KEVENT_SIGNAL
+	bool "Kernel event notifications for signals"
+	depends on KEVENT
+	default y
+	help
+	  This option enables signal delivery through KEVENT subsystem.
+	  Signals which were requested to be delivered through kevent
+	  subsystem must be registered through usual signal() and others
+	  syscalls, this option allows alternative delivery.
+	  With KEVENT_SIGNAL_NOMASK flag being set in kevent for set of 
+	  signals, they will not be delivered in a usual way.
+	  Kevents for appropriate signals are not copied when process forks,
+	  new process must add new kevents after fork(). Mask of signals
+	  is copied as before.
+
diff --git a/kernel/kevent/Makefile b/kernel/kevent/Makefile
new file mode 100644
index 0000000..f98e0c8
--- /dev/null
+++ b/kernel/kevent/Makefile
@@ -0,0 +1,6 @@
+obj-y := kevent.o kevent_user.o
+obj-$(CONFIG_KEVENT_TIMER) += kevent_timer.o
+obj-$(CONFIG_KEVENT_POLL) += kevent_poll.o
+obj-$(CONFIG_KEVENT_SOCKET) += kevent_socket.o
+obj-$(CONFIG_KEVENT_PIPE) += kevent_pipe.o
+obj-$(CONFIG_KEVENT_SIGNAL) += kevent_signal.o
diff --git a/kernel/kevent/kevent.c b/kernel/kevent/kevent.c
new file mode 100644
index 0000000..1781c57
--- /dev/null
+++ b/kernel/kevent/kevent.c
@@ -0,0 +1,265 @@
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
+int kevent_event_is_allowed(struct ukevent *e)
+{
+	if (unlikely(e->type >= KEVENT_MAX))
+		return 0;
+
+	if (!kevent_registered_callbacks[e->type].callback)
+		return 0;
+
+	if (unlikely(kevent_registered_callbacks[e->type].callback == kevent_break))
+		return 0;
+
+	if (kevent_registered_callbacks[e->type].flags & KEVENT_CALLBACKS_KERNELONLY)
+		return 0;
+	
+	return 1;
+}
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
+	p->flags = cb->flags;
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
+	if (unlikely(k->event.type >= KEVENT_MAX)) {
+		kevent_break(k);
+		return -ENOSYS;
+	}
+
+	if (!kevent_registered_callbacks[k->event.type].callback) {
+		kevent_break(k);
+		return -ENOSYS;
+	}
+
+	k->callbacks = kevent_registered_callbacks[k->event.type];
+	if (unlikely(k->callbacks.callback == kevent_break)) {
+		kevent_break(k);
+		return -ENOSYS;
+	}
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
+void kevent_ready(struct kevent *k, int ret)
+{
+	unsigned long flags;
+	int rem;
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
+ * Call kevent ready callback and queue it into ready queue if needed.
+ * If kevent is marked as one-shot, then remove it from storage queue.
+ */
+static int __kevent_requeue(struct kevent *k, u32 event)
+{
+	int ret;
+
+	ret = k->callbacks.callback(k);
+
+	kevent_ready(k, ret);
+
+	return ret;
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
+	int wake_num = 0;
+
+	rcu_read_lock();
+	if (unlikely(ready_callback))
+		list_for_each_entry_rcu(k, &st->list, storage_entry)
+			(*ready_callback)(k);
+
+	list_for_each_entry_rcu(k, &st->list, storage_entry) {
+		if (event & k->event.event)
+			if ((k->event.req_flags & KEVENT_REQ_WAKEUP_ALL) || wake_num == 0)
+				if (__kevent_requeue(k, event))
+					wake_num++;
+	}
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
+ * so storage origin (inode, socket and so on) can be safely removed.
+ * No new entries are allowed to be added into the storage at this point.
+ * (Socket is removed from file table at this point for example).
+ */
+void kevent_storage_fini(struct kevent_storage *st)
+{
+	kevent_storage_ready(st, kevent_break, KEVENT_MASK_ALL);
+}
diff --git a/kernel/kevent/kevent_user.c b/kernel/kevent/kevent_user.c
new file mode 100644
index 0000000..2ed628d
--- /dev/null
+++ b/kernel/kevent/kevent_user.c
@@ -0,0 +1,1363 @@
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
+static kmem_cache_t *kevent_cache __read_mostly;
+static kmem_cache_t *kevent_user_cache __read_mostly;
+
+static int kevent_debug_abstime;
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
+	if (u->ready_num || u->need_exit)
+		mask |= POLLIN | POLLRDNORM;
+	u->need_exit = 0;
+
+	return mask;
+}
+
+static inline unsigned int kevent_ring_space(struct kevent_user *u)
+{
+	if (!u->pring)
+		return 1;
+
+	if (u->full)
+		return 0;
+
+	return (u->uidx > u->kidx)?
+		(u->uidx - u->kidx):
+		(u->ring_size - (u->kidx - u->uidx));
+}
+
+static inline int kevent_ring_index_inc(unsigned int *pidx, unsigned int size)
+{
+	unsigned int idx = *pidx;
+
+	if (++idx >= size)
+		idx = 0;
+	*pidx = idx;
+	return (idx == 0);
+}
+
+/*
+ * Copies kevent into userspace ring buffer if it was initialized.
+ * Returns 
+ *  0 on success or if ring buffer is not used
+ *  -EAGAIN if there were no place for that kevent
+ *  -EFAULT if copy_to_user() failed.
+ *
+ *  Must be called under kevent_user->ring_lock locked.
+ */
+static int kevent_copy_ring_buffer(struct kevent *k)
+{
+	struct kevent_ring __user *ring;
+	struct kevent_user *u = k->user;
+	unsigned long flags;
+	int err;
+
+	ring = u->pring;
+	if (!ring)
+		return 0;
+
+	if (!kevent_ring_space(u))
+		return -EAGAIN;
+
+	if (copy_to_user(&ring->event[u->kidx], &k->event, sizeof(struct ukevent))) {
+		err = -EFAULT;
+		goto err_out_exit;
+	}
+
+	kevent_ring_index_inc(&u->kidx, u->ring_size);
+
+	if (u->kidx == u->uidx)
+		u->full = 1;
+
+	if (put_user(u->kidx, &ring->ring_kidx)) {
+		err = -EFAULT;
+		goto err_out_exit;
+	}
+
+	return 0;
+
+err_out_exit:
+	spin_lock_irqsave(&k->ulock, flags);
+	k->event.ret_flags |= KEVENT_RET_COPY_FAILED;
+	spin_unlock_irqrestore(&k->ulock, flags);
+	return err;
+}
+
+static struct kevent_user *kevent_user_alloc(struct kevent_ring __user *ring, unsigned int num)
+{
+	struct kevent_user *u;
+
+	u = kmem_cache_alloc(kevent_user_cache, GFP_KERNEL);
+	if (!u)
+		return NULL;
+
+	INIT_LIST_HEAD(&u->ready_list);
+	spin_lock_init(&u->ready_lock);
+	kevent_stat_init(u);
+	spin_lock_init(&u->kevent_lock);
+	u->kevent_root = RB_ROOT;
+
+	mutex_init(&u->ctl_mutex);
+	init_waitqueue_head(&u->wait);
+	u->need_exit = 0;
+
+	atomic_set(&u->refcnt, 1);
+
+	mutex_init(&u->ring_lock);
+	u->kidx = u->uidx = u->ring_over = u->full = 0;
+
+	u->pring = ring;
+	u->ring_size = num;
+
+	hrtimer_init(&u->timer, CLOCK_REALTIME, HRTIMER_ABS);
+
+	return u;
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
+		hrtimer_cancel(&u->timer);
+		kmem_cache_free(kevent_user_cache, u);
+	}
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
+ * This function unlinks kevent from ready queue.
+ */
+static inline void kevent_unlink_ready(struct kevent *k)
+{
+	list_del(&k->ready_entry);
+	k->flags &= ~KEVENT_READY;
+	k->user->ready_num--;
+}
+
+static void kevent_remove_ready(struct kevent *k)
+{
+	struct kevent_user *u = k->user;
+	unsigned long flags;
+
+	spin_lock_irqsave(&u->ready_lock, flags);
+	if (k->flags & KEVENT_READY)
+		kevent_unlink_ready(k);
+	spin_unlock_irqrestore(&u->ready_lock, flags);
+}
+
+/*
+ * Complete kevent removing - it dequeues kevent from storage list
+ * if it is requested, removes kevent from ready list, drops userspace
+ * control block reference counter and schedules kevent freeing through RCU.
+ */
+static void kevent_finish_user_complete(struct kevent *k, int deq)
+{
+	if (deq)
+		kevent_dequeue(k);
+
+	kevent_remove_ready(k);
+
+	kevent_user_put(k->user);
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
+static struct kevent *__kevent_dequeue_ready_one(struct kevent_user *u)
+{
+	unsigned long flags;
+	struct kevent *k = NULL;
+
+	if (u->ready_num) {
+		spin_lock_irqsave(&u->ready_lock, flags);
+		if (u->ready_num && !list_empty(&u->ready_list)) {
+			k = list_entry(u->ready_list.next, struct kevent, ready_entry);
+			kevent_unlink_ready(k);
+		}
+		spin_unlock_irqrestore(&u->ready_lock, flags);
+	}
+
+	return k;
+}
+
+static struct kevent *kevent_dequeue_ready_one(struct kevent_user *u)
+{
+	struct kevent *k = NULL;
+
+	while (u->ready_num && !k) {
+		k = __kevent_dequeue_ready_one(u);
+
+		if (k && (k->event.req_flags & KEVENT_REQ_LAST_CHECK)) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&k->ulock, flags);
+			k->event.req_flags &= ~KEVENT_REQ_LAST_CHECK;
+			spin_unlock_irqrestore(&k->ulock, flags);
+
+			if (!k->callbacks.callback(k)) {
+				spin_lock_irqsave(&k->ulock, flags);
+				k->event.req_flags |= KEVENT_REQ_LAST_CHECK;
+				k->event.ret_flags = 0;
+				k->event.ret_data[0] = k->event.ret_data[1] = 0;
+				spin_unlock_irqrestore(&k->ulock, flags);
+				k = NULL;
+			}
+		} else
+			break;
+	}
+
+	return k;
+}
+
+static inline void kevent_copy_ring(struct kevent *k)
+{
+	unsigned long flags;
+
+	if (!k)
+		return;
+
+	if (kevent_copy_ring_buffer(k)) {
+		spin_lock_irqsave(&k->ulock, flags);
+		k->event.ret_flags |= KEVENT_RET_COPY_FAILED;
+		spin_unlock_irqrestore(&k->ulock, flags);
+	}
+}
+
+/*
+ * Dequeue one entry from user's ready queue.
+ */
+static struct kevent *kevent_dequeue_ready(struct kevent_user *u)
+{
+	struct kevent *k;
+
+	mutex_lock(&u->ring_lock);
+	k = kevent_dequeue_ready_one(u);
+	kevent_copy_ring(k);
+	mutex_unlock(&u->ring_lock);
+
+	return k;
+}
+
+/*
+ * Dequeue one entry from user's ready queue if there is space in ring buffer.
+ */
+static struct kevent *kevent_dequeue_ready_ring(struct kevent_user *u)
+{
+	struct kevent *k = NULL;
+
+	mutex_lock(&u->ring_lock);
+	if (kevent_ring_space(u)) {
+		k = kevent_dequeue_ready_one(u);
+		kevent_copy_ring(k);
+	}
+	mutex_unlock(&u->ring_lock);
+
+	return k;
+}
+
+static void kevent_complete_ready(struct kevent *k)
+{
+	if (k->event.req_flags & KEVENT_REQ_ONESHOT)
+		/*
+		 * If it is one-shot kevent, it has been removed already from
+		 * origin's queue, so we can easily free it here.
+		 */
+		kevent_finish_user(k, 1);
+	else if (k->event.req_flags & KEVENT_REQ_ET) {
+		unsigned long flags;
+
+		/*
+		 * Edge-triggered behaviour: mark event as clear new one.
+		 */
+
+		spin_lock_irqsave(&k->ulock, flags);
+		k->event.ret_flags = 0;
+		k->event.ret_data[0] = k->event.ret_data[1] = 0;
+		spin_unlock_irqrestore(&k->ulock, flags);
+	}
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
+static int kevent_mark_ready(struct ukevent *uk, struct kevent_user *u)
+{
+	struct kevent *k;
+	int err = -ENODEV;
+	unsigned long flags;
+
+	spin_lock_irqsave(&u->kevent_lock, flags);
+	k = __kevent_search(&uk->id, u);
+	if (k) {
+		spin_lock(&k->st->lock);
+		kevent_ready(k, 1);
+		spin_unlock(&k->st->lock);
+		err = 0;
+	}
+	spin_unlock_irqrestore(&u->kevent_lock, flags);
+
+	return err;
+}
+
+/*
+ * Mark appropriate kevents as ready.
+ * If number of events is zero just wake up one listener.
+ */
+static int kevent_user_ctl_ready(struct kevent_user *u, unsigned int num, void __user *arg)
+{
+	int err = -EINVAL, cerr = 0, rnum = 0, i;
+	void __user *orig = arg;
+	struct ukevent uk;
+
+	if (num > u->kevent_num)
+		return err;
+	
+	if (!num) {
+		u->need_exit = 1;
+		wake_up(&u->wait);
+		return 0;
+	}
+
+	mutex_lock(&u->ctl_mutex);
+
+	if (num > KEVENT_MIN_BUFFS_ALLOC) {
+		struct ukevent *ukev;
+
+		ukev = kevent_get_user(num, arg);
+		if (ukev) {
+			for (i = 0; i < num; ++i) {
+				err = kevent_mark_ready(&ukev[i], u);
+				if (err) {
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
+		err = kevent_mark_ready(&uk, u);
+		if (err) {
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
+	err = num - rnum;
+out_remove:
+	mutex_unlock(&u->ctl_mutex);
+
+	return err;
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
+				if (!kevent_event_is_allowed(&ukev[i])) {
+					if (i != rnum)
+						memcpy(&ukev[rnum], 
+							&ukev[i], 
+							sizeof(struct ukevent));
+					rnum++;
+				} else {
+					err = kevent_user_add_ukevent(&ukev[i], u);
+					if (err) {
+						kevent_stat_im(u);
+						if (i != rnum)
+							memcpy(&ukev[rnum], 
+								&ukev[i], 
+								sizeof(struct ukevent));
+						rnum++;
+					}
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
+		if (!kevent_event_is_allowed(&uk)) {
+			err = 1;
+		} else {
+			err = kevent_user_add_ukevent(&uk, u);
+			if (err)
+				kevent_stat_im(u);
+		}
+		if (err) {
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
+/* Used to wakeup waiting syscalls in case high-resolution timer is used. */
+static int kevent_user_wake(struct hrtimer *timer)
+{
+	struct kevent_user *u = container_of(timer, struct kevent_user, timer);
+
+	u->need_exit = 1;
+	wake_up(&u->wait);
+
+	return HRTIMER_NORESTART;
+}
+
+
+/*
+ * In nonblocking mode it returns as many events as possible, but not more than @max_nr.
+ * In blocking mode it waits until timeout or if at least @min_nr events are ready.
+ */
+static int kevent_user_wait(struct file *file, struct kevent_user *u,
+		unsigned int min_nr, unsigned int max_nr, struct timespec timeout,
+		void __user *buf, unsigned int flags)
+{
+	struct kevent *k;
+	int num = 0;
+	long tm = MAX_SCHEDULE_TIMEOUT;
+
+	if (!(file->f_flags & O_NONBLOCK)) {
+		if (!timespec_valid(&timeout))
+			return -EINVAL;
+
+		if (flags & KEVENT_FLAGS_ABSTIME) {
+			hrtimer_cancel(&u->timer);
+			hrtimer_init(&u->timer, CLOCK_REALTIME, HRTIMER_ABS);
+			u->timer.expires = ktime_set(timeout.tv_sec, timeout.tv_nsec);
+			u->timer.function = &kevent_user_wake;
+			hrtimer_start(&u->timer, u->timer.expires, HRTIMER_ABS);
+			if (unlikely(kevent_debug_abstime == 0)) {
+				printk(KERN_INFO "kevent: author was wrong, "
+						"someone uses absolute time in %s, "
+						"please report to remove this warning.\n", __func__);
+				kevent_debug_abstime = 1;
+			}
+		} else {
+			tm = timespec_to_jiffies(&timeout);
+		}
+
+		wait_event_interruptible_timeout(u->wait,
+			((u->ready_num >= 1) && kevent_ring_space(u)) || u->need_exit, tm);
+	}
+	u->need_exit = 0;
+
+	while (num < max_nr && ((k = kevent_dequeue_ready(u)) != NULL)) {
+		if (copy_to_user(buf + num*sizeof(struct ukevent),
+					&k->event, sizeof(struct ukevent))) {
+			if (num == 0)
+				num = -EFAULT;
+			break;
+		}
+		kevent_complete_ready(k);
+		++num;
+		kevent_stat_wait(u);
+	}
+
+	return num;
+}
+
+struct file_operations kevent_user_fops = {
+	.release	= kevent_user_release,
+	.poll		= kevent_user_poll,
+	.owner		= THIS_MODULE,
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
+	case KEVENT_CTL_READY:
+		err = kevent_user_ctl_ready(u, num, arg);
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
+ * @timeout - time to wait until some events are ready.
+ * @buf - buffer to place ready events.
+ * @flags - various flags (see include/linux/ukevent.h KEVENT_FLAGS_*).
+ */
+asmlinkage long sys_kevent_get_events(int ctl_fd, unsigned int min_nr, unsigned int max_nr,
+		struct timespec timeout, struct ukevent __user *buf, unsigned flags)
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
+	err = kevent_user_wait(file, u, min_nr, max_nr, timeout, buf, flags);
+out_fput:
+	fput(file);
+	return err;
+}
+
+static struct vfsmount *kevent_mnt __read_mostly;
+
+static int kevent_get_sb(struct file_system_type *fs_type, int flags,
+		   const char *dev_name, void *data, struct vfsmount *mnt)
+{
+	return get_sb_pseudo(fs_type, "kevent", NULL, 0xaabbccdd, mnt);
+}
+
+static struct file_system_type kevent_fs_type = {
+	.name		= "keventfs",
+	.get_sb		= kevent_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+static int keventfs_delete_dentry(struct dentry *dentry)
+{
+	return 1;
+}
+
+static struct dentry_operations keventfs_dentry_operations = {
+	.d_delete	= keventfs_delete_dentry,
+};
+
+asmlinkage long sys_kevent_init(struct kevent_ring __user *ring, unsigned int num, unsigned int flags)
+{
+	struct qstr this;
+	char name[32];
+	struct dentry *dentry;
+	struct inode *inode;
+	struct file *file;
+	int err = -ENFILE, fd;
+	struct kevent_user *u;
+
+	if ((ring && !num) || (!ring && num) || (num == 1))
+		return -EINVAL;
+
+	file = get_empty_filp();
+	if (!file)
+		goto err_out_exit;
+
+	inode = new_inode(kevent_mnt->mnt_sb);
+	if (!inode)
+		goto err_out_fput;
+
+	inode->i_fop = &kevent_user_fops;
+
+	inode->i_state = I_DIRTY;
+	inode->i_mode = S_IRUSR | S_IWUSR;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+
+	err = get_unused_fd();
+	if (err < 0)
+		goto err_out_iput;
+	fd = err;
+
+	err = -ENOMEM;
+	u = kevent_user_alloc(ring, num);
+	if (!u)
+		goto err_out_put_fd;
+
+	sprintf(name, "[%lu]", inode->i_ino);
+	this.name = name;
+	this.len = strlen(name);
+	this.hash = inode->i_ino;
+	dentry = d_alloc(kevent_mnt->mnt_sb->s_root, &this);
+	if (!dentry)
+		goto err_out_free;
+	dentry->d_op = &keventfs_dentry_operations;
+	d_add(dentry, inode);
+	file->f_vfsmnt = mntget(kevent_mnt);
+	file->f_dentry = dentry;
+	file->f_mapping = inode->i_mapping;
+	file->f_pos = 0;
+	file->f_flags = O_RDONLY;
+	file->f_op = &kevent_user_fops;
+	file->f_mode = FMODE_READ;
+	file->f_version = 0;
+	file->private_data = u;
+
+	fd_install(fd, file);
+
+	return fd;
+
+err_out_free:
+	kmem_cache_free(kevent_user_cache, u);
+err_out_put_fd:
+	put_unused_fd(fd);
+err_out_iput:
+	iput(inode);
+err_out_fput:
+	put_filp(file);
+err_out_exit:
+	return err;
+}
+
+/*
+ * Commits user's index (consumer index).
+ * Must be called under u->ring_lock mutex held.
+ */
+static int __kevent_user_commit(struct kevent_user *u, unsigned int new_uidx, unsigned int over)
+{
+	int err = -EOVERFLOW, comm = 0;
+	struct kevent_ring __user *ring = u->pring;
+
+	if (!ring) {
+		err = 0;
+		goto err_out_exit;
+	}
+
+	if (new_uidx >= u->ring_size) {
+		err = -EINVAL;
+		goto err_out_exit;
+	}
+
+	if ((over != u->ring_over - 1) && (over != u->ring_over))
+		goto err_out_exit;
+
+	if (u->uidx < u->kidx && new_uidx > u->kidx) {
+		err = -EINVAL;
+		goto err_out_exit;
+	}
+
+	if (new_uidx > u->uidx) {
+		if (over != u->ring_over)
+			goto err_out_exit;
+
+		comm = new_uidx - u->uidx;
+		u->uidx = new_uidx;
+		u->full = 0;
+	} else if (new_uidx < u->uidx) {
+		comm = u->ring_size - (u->uidx - new_uidx);
+		u->uidx = new_uidx;
+		u->full = 0;
+		u->ring_over++;
+
+		if (put_user(u->ring_over, &ring->ring_over)) {
+			err = -EFAULT;
+			goto err_out_exit;
+		}
+	}
+
+	return comm;
+
+err_out_exit:
+	return err;
+}
+
+/*
+ * This syscall is used to perform waiting until there is free space in the ring
+ * buffer, in that case some events will be copied there.
+ * Function returns number of actually copied ready events in ring buffer.
+ * After this function is completed userspace ring->ring_kidx will be updated.
+ *
+ * @ctl_fd - kevent file descriptor.
+ * @num - number of kevents to process.
+ * @old_uidx - the last index user is aware of.
+ * @timeout - time to wait until there is free space in kevent queue.
+ * @flags - various flags (see include/linux/ukevent.h KEVENT_FLAGS_*).
+ *
+ * When we need to commit @num events, it means we should just remove first @num
+ * kevents from ready queue and copy them into the buffer. 
+ * Kevents will be copied into ring buffer in order they were placed into ready queue.
+ * One-shot kevents will be removed here, since there is no way they can be reused.
+ * Edge-triggered events will be requeued here for better performance.
+ */
+asmlinkage long sys_kevent_wait(int ctl_fd, unsigned int num, unsigned int old_uidx, 
+		struct timespec timeout, unsigned int flags)
+{
+	int err = -EINVAL, copied = 0;
+	struct file *file;
+	struct kevent_user *u;
+	struct kevent *k;
+	struct kevent_ring __user *ring;
+	long tm = MAX_SCHEDULE_TIMEOUT;
+	unsigned int i;
+
+	file = fget(ctl_fd);
+	if (!file)
+		return -EBADF;
+
+	if (file->f_op != &kevent_user_fops)
+		goto out_fput;
+	u = file->private_data;
+
+	ring = u->pring;
+	if (!ring || num > u->ring_size)
+		goto out_fput;
+#if 0
+	/*
+	 * Allow to immediately update ring index, but it is not supported,
+	 * since syscall() has limited number of arguments which is actually
+	 * a good idea - use kevent_commit() instead.
+	 */
+	if ((u->uidx != new_uidx) && (new_uidx != 0xffffffff)) {
+		mutex_lock(&u->ring_lock);
+		__kevent_user_commit(u, new_uidx, over);
+		mutex_unlock(&u->ring_lock);
+	}
+#endif
+
+	if (!(file->f_flags & O_NONBLOCK)) {
+		if (!timespec_valid(&timeout))
+			goto out_fput;
+
+		if (flags & KEVENT_FLAGS_ABSTIME) {
+			hrtimer_cancel(&u->timer);
+			hrtimer_init(&u->timer, CLOCK_REALTIME, HRTIMER_ABS);
+			u->timer.expires = ktime_set(timeout.tv_sec, timeout.tv_nsec);
+			u->timer.function = &kevent_user_wake;
+			hrtimer_start(&u->timer, u->timer.expires, HRTIMER_ABS);
+			if (unlikely(kevent_debug_abstime == 0)) {
+				printk(KERN_INFO "kevent: author was wrong, "
+						"someone uses absolute time in %s, "
+						"please report to remove this warning.\n", __func__);
+				kevent_debug_abstime = 1;
+			}
+		} else {
+			tm = timespec_to_jiffies(&timeout);
+		}
+
+		wait_event_interruptible_timeout(u->wait,
+			((u->ready_num >= 1) && kevent_ring_space(u)) || 
+				u->need_exit || old_uidx != u->uidx,
+				tm);
+	}
+	u->need_exit = 0;
+
+	for (i=0; i<num; ++i) {
+		k = kevent_dequeue_ready_ring(u);
+		if (!k)
+			break;
+		kevent_complete_ready(k);
+
+		if (k->event.ret_flags & KEVENT_RET_COPY_FAILED)
+			break;
+		kevent_stat_ring(u);
+		copied++;
+	}
+
+	fput(file);
+
+	return copied;
+out_fput:
+	fput(file);
+	return err;
+}
+
+/*
+ * This syscall is used to commit events in ring buffer, i.e. mark appropriate
+ * entries as unused by userspace so subsequent kevent_wait() could overwrite them.
+ * This fucntion returns actual number of kevents which were committed.
+ * After this function is completed userspace ring->ring_over can be updated.
+ *
+ * @ctl_fd - kevent file descriptor.
+ * @new_uidx - the last committed kevent.
+ * @over - number of overflows given queue had.
+ */
+asmlinkage long sys_kevent_commit(int ctl_fd, unsigned int new_uidx, unsigned int over)
+{
+	int err = -EINVAL, comm = 0;
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
+	mutex_lock(&u->ring_lock);
+	err = __kevent_user_commit(u, new_uidx, over);
+	if (err < 0)
+		goto err_out_unlock;
+	comm = err;
+	mutex_unlock(&u->ring_lock);
+
+	fput(file);
+
+	return comm;
+
+err_out_unlock:
+	mutex_unlock(&u->ring_lock);
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
+ * Kevent subsystem initialization - create caches and register
+ * filesystem to get control file descriptors from.
+ */
+static int __init kevent_user_init(void)
+{
+	int err = 0;
+
+	kevent_cache = kmem_cache_create("kevent_cache",
+			sizeof(struct kevent), 0, SLAB_PANIC, NULL, NULL);
+	
+	kevent_user_cache = kmem_cache_create("kevent_user_cache",
+			sizeof(struct kevent_user), 0, SLAB_PANIC, NULL, NULL);
+	
+	err = register_filesystem(&kevent_fs_type);
+	if (err)
+		goto err_out_exit;
+	
+	kevent_mnt = kern_mount(&kevent_fs_type);
+	err = PTR_ERR(kevent_mnt);
+	if (IS_ERR(kevent_mnt))
+		goto err_out_unreg;
+
+	printk(KERN_INFO "KEVENT subsystem has been successfully registered.\n");
+
+	return 0;
+
+err_out_unreg:
+	unregister_filesystem(&kevent_fs_type);
+err_out_exit:
+	kmem_cache_destroy(kevent_cache);
+	return err;
+}
+
+module_init(kevent_user_init);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 7a3b2e7..3b7d35f 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -122,6 +122,12 @@ cond_syscall(ppc_rtas);
 cond_syscall(sys_spu_run);
 cond_syscall(sys_spu_create);
 
+cond_syscall(sys_kevent_get_events);
+cond_syscall(sys_kevent_ctl);
+cond_syscall(sys_kevent_wait);
+cond_syscall(sys_kevent_commit);
+cond_syscall(sys_kevent_init);
+
 /* mmu depending weak syscall entries */
 cond_syscall(sys_mprotect);
 cond_syscall(sys_msync);

