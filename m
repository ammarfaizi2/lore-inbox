Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754855AbWKKRmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbWKKRmA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 12:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754854AbWKKRmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 12:42:00 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:47319 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754451AbWKKRl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 12:41:59 -0500
Date: Sat, 11 Nov 2006 20:36:10 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: [take24 7/6] kevent: signal notifications.
Message-ID: <20061111173610.GA29072@2ka.mipt.ru>
References: <1154985aa0591036@2ka.mipt.ru> <11630606361046@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <11630606361046@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 11 Nov 2006 20:36:12 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signals which were requested to be delivered through kevent
subsystem must be registered through usual signal() and others
syscalls, this option allows alternative delivery.

With KEVENT_SIGNAL_NOMASK flag being set in kevent for set of
signals, they will not be delivered in a usual way.
Kevents for appropriate signals are not copied when process forks,
new process must add new kevents after fork(). Mask of signals
is copied as before.

Test application which registers two signal callbacks for usr1 and usr2
signals and it's deivery through kevent (the former with both callback and
kevent notifications, the latter only through kevent) is called signal.c
and can be found in archive on project homepage
http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/include/linux/kevent.h b/include/linux/kevent.h
index f7cbf6b..e588ae6 100644
--- a/include/linux/kevent.h
+++ b/include/linux/kevent.h
@@ -28,6 +28,7 @@ #include <linux/wait.h>
 #include <linux/net.h>
 #include <linux/rcupdate.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/kevent_storage.h>
 #include <linux/ukevent.h>
 
@@ -220,4 +221,10 @@ #else
 static inline void kevent_pipe_notify(struct inode *inode, u32 events) {}
 #endif
 
+#ifdef CONFIG_KEVENT_SIGNAL
+extern int kevent_signal_notify(struct task_struct *tsk, int sig);
+#else
+static inline int kevent_signal_notify(struct task_struct *tsk, int sig) {return 0;}
+#endif
+
 #endif /* __KEVENT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index fc4a987..ef38a3c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -80,6 +80,7 @@ #include <linux/param.h>
 #include <linux/resource.h>
 #include <linux/timer.h>
 #include <linux/hrtimer.h>
+#include <linux/kevent_storage.h>
 
 #include <asm/processor.h>
 
@@ -1013,6 +1014,10 @@ #endif
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_KEVENT_SIGNAL
+	struct kevent_storage st;
+	u32 kevent_signals;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff --git a/include/linux/ukevent.h b/include/linux/ukevent.h
index b14e14e..a6038eb 100644
--- a/include/linux/ukevent.h
+++ b/include/linux/ukevent.h
@@ -68,7 +68,8 @@ #define KEVENT_POLL		3
 #define KEVENT_NAIO		4
 #define KEVENT_AIO		5
 #define KEVENT_PIPE		6
-#define	KEVENT_MAX		7
+#define KEVENT_SIGNAL		7
+#define	KEVENT_MAX		8
 
 /*
  * Per-type event sets.
@@ -81,7 +82,7 @@ #define	KEVENT_MAX		7
 #define	KEVENT_TIMER_FIRED	0x1
 
 /*
- * Socket/network asynchronous IO events.
+ * Socket/network asynchronous IO and PIPE events.
  */
 #define	KEVENT_SOCKET_RECV	0x1
 #define	KEVENT_SOCKET_ACCEPT	0x2
@@ -115,10 +116,20 @@ #define	KEVENT_POLL_POLLREMOVE	0x1000
  */
 #define	KEVENT_AIO_BIO		0x1
 
-#define KEVENT_MASK_ALL		0xffffffff
+/*
+ * Signal events.
+ */
+#define KEVENT_SIGNAL_DELIVERY		0x1
+
+/* If set in raw64, then given signals will not be delivered
+ * in a usual way through sigmask update and signal callback 
+ * invokation. */
+#define KEVENT_SIGNAL_NOMASK	0x8000000000000000ULL
+
 /* Mask of all possible event values. */
-#define KEVENT_MASK_EMPTY	0x0
+#define KEVENT_MASK_ALL		0xffffffff
 /* Empty mask of ready events. */
+#define KEVENT_MASK_EMPTY	0x0
 
 struct kevent_id
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 1c999f3..e5b5b14 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -46,6 +46,7 @@ #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
 #include <linux/random.h>
+#include <linux/kevent.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -115,6 +116,9 @@ void __put_task_struct(struct task_struc
 	WARN_ON(atomic_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+#ifdef CONFIG_KEVENT_SIGNAL
+	kevent_storage_fini(&tsk->st);
+#endif
 	security_task_free(tsk);
 	free_uid(tsk->user);
 	put_group_info(tsk->group_info);
@@ -1121,6 +1125,10 @@ #endif
 	if (retval)
 		goto bad_fork_cleanup_namespace;
 
+#ifdef CONFIG_KEVENT_SIGNAL
+	kevent_storage_init(p, &p->st);
+#endif
+
 	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? child_tidptr : NULL;
 	/*
 	 * Clear TID on mm_release()?
diff --git a/kernel/kevent/Kconfig b/kernel/kevent/Kconfig
index 267fc53..4b137ee 100644
--- a/kernel/kevent/Kconfig
+++ b/kernel/kevent/Kconfig
@@ -43,3 +43,18 @@ config KEVENT_PIPE
 	help
 	  This option enables notifications through KEVENT subsystem of 
 	  pipe read/write operations.
+
+config KEVENT_SIGNAL
+	bool "Kernel event notifications for signals"
+	depends on KEVENT
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
index d4d6b68..f98e0c8 100644
--- a/kernel/kevent/Makefile
+++ b/kernel/kevent/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_KEVENT_TIMER) += kevent_tim
 obj-$(CONFIG_KEVENT_POLL) += kevent_poll.o
 obj-$(CONFIG_KEVENT_SOCKET) += kevent_socket.o
 obj-$(CONFIG_KEVENT_PIPE) += kevent_pipe.o
+obj-$(CONFIG_KEVENT_SIGNAL) += kevent_signal.o
diff --git a/kernel/kevent/kevent_signal.c b/kernel/kevent/kevent_signal.c
new file mode 100644
index 0000000..15f9d1f
--- /dev/null
+++ b/kernel/kevent/kevent_signal.c
@@ -0,0 +1,87 @@
+/*
+ * 	kevent_signal.c
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
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kevent.h>
+
+static int kevent_signal_callback(struct kevent *k)
+{
+	struct task_struct *tsk = k->st->origin;
+	int sig = k->event.id.raw[0];
+	int ret = 0;
+
+	if (sig == tsk->kevent_signals)
+		ret = 1;
+
+	if (ret && (k->event.id.raw_u64 & KEVENT_SIGNAL_NOMASK))
+		tsk->kevent_signals |= 0x80000000;
+
+	return ret;
+}
+
+int kevent_signal_enqueue(struct kevent *k)
+{
+	int err;
+
+	err = kevent_storage_enqueue(&current->st, k);
+	if (err)
+		goto err_out_exit;
+
+	err = k->callbacks.callback(k);
+	if (err)
+		goto err_out_dequeue;
+
+	return err;
+
+err_out_dequeue:
+	kevent_storage_dequeue(k->st, k);
+err_out_exit:
+	return err;
+}
+
+int kevent_signal_dequeue(struct kevent *k)
+{
+	kevent_storage_dequeue(k->st, k);
+	return 0;
+}
+
+int kevent_signal_notify(struct task_struct *tsk, int sig)
+{
+	tsk->kevent_signals = sig;
+	kevent_storage_ready(&tsk->st, NULL, KEVENT_SIGNAL_DELIVERY);
+	return (tsk->kevent_signals & 0x80000000);
+}
+
+static int __init kevent_init_signal(void)
+{
+	struct kevent_callbacks sc = {
+		.callback = &kevent_signal_callback,
+		.enqueue = &kevent_signal_enqueue,
+		.dequeue = &kevent_signal_dequeue};
+
+	return kevent_add_callbacks(&sc, KEVENT_SIGNAL);
+}
+module_init(kevent_init_signal);
diff --git a/kernel/signal.c b/kernel/signal.c
index fb5da6d..d3d3594 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -23,6 +23,7 @@ #include <linux/syscalls.h>
 #include <linux/ptrace.h>
 #include <linux/signal.h>
 #include <linux/capability.h>
+#include <linux/kevent.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -703,6 +704,9 @@ static int send_signal(int sig, struct s
 {
 	struct sigqueue * q = NULL;
 	int ret = 0;
+	
+	if (kevent_signal_notify(t, sig))
+		return 1;
 
 	/*
 	 * fast-pathed signals for kernel-internal things like SIGSTOP
@@ -782,6 +786,17 @@ specific_send_sig_info(int sig, struct s
 	ret = send_signal(sig, info, t, &t->pending);
 	if (!ret && !sigismember(&t->blocked, sig))
 		signal_wake_up(t, sig == SIGKILL);
+#ifdef CONFIG_KEVENT_SIGNAL
+	/*
+	 * Kevent allows to deliver signals through kevent queue, 
+	 * it is possible to setup kevent to not deliver
+	 * signal through the usual way, in that case send_signal()
+	 * returns 1 and signal is delivered only through kevent queue.
+	 * We simulate successfull delivery notification through this hack:
+	 */
+	if (ret == 1)
+		ret = 0;
+#endif
 out:
 	return ret;
 }
@@ -971,6 +986,17 @@ __group_send_sig_info(int sig, struct si
 	 * to avoid several races.
 	 */
 	ret = send_signal(sig, info, p, &p->signal->shared_pending);
+#ifdef CONFIG_KEVENT_SIGNAL
+	/*
+	 * Kevent allows to deliver signals through kevent queue, 
+	 * it is possible to setup kevent to not deliver
+	 * signal through the usual way, in that case send_signal()
+	 * returns 1 and signal is delivered only through kevent queue.
+	 * We simulate successfull delivery notification through this hack:
+	 */
+	if (ret == 1)
+		ret = 0;
+#endif
 	if (unlikely(ret))
 		return ret;
 

-- 
	Evgeniy Polyakov
