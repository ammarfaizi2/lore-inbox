Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUDSV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUDSV13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUDSV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:27:29 -0400
Received: from mail.cyclades.com ([64.186.161.6]:13986 "EHLO mail.cyclades.com")
	by vger.kernel.org with ESMTP id S261925AbUDSV1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:27:08 -0400
Date: Mon, 19 Apr 2004 18:28:10 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Cc: drepper@redhat.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040419212810.GB10956@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(forgot the subject on the first message)

Andrew, 

Here goes the signal pending & POSIX mqueue's per-uid limit patch. 

Initialization has been moved to include/asm-i386/resource.h, as you suggested.

The global mqueue limit has been increased to 256 (64 per user), and the global 
signal pending limit to 4096 (1024 per user).

This has been well tested.

If you are OK with it for inclusion (-mm) I'll generate the arch-dependant
changes for the other architectures.

Comments are welcome.

diff -Nur --show-c-function linux-2.6.5.org/arch/i386/kernel/init_task.c linux-2.6.5/arch/i386/kernel/init_task.c
--- linux-2.6.5.org/arch/i386/kernel/init_task.c	2004-04-15 11:13:32.000000000 -0300
+++ linux-2.6.5/arch/i386/kernel/init_task.c	2004-04-17 01:25:59.000000000 -0300
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -Nur --show-c-function linux-2.6.5.org/include/asm-i386/resource.h linux-2.6.5/include/asm-i386/resource.h
--- linux-2.6.5.org/include/asm-i386/resource.h	2004-04-15 11:13:28.000000000 -0300
+++ linux-2.6.5/include/asm-i386/resource.h	2004-04-17 02:36:31.000000000 -0300
@@ -16,8 +16,11 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* max number of POSIX msg queues */
+
+#define RLIM_NLIMITS	13
 
-#define RLIM_NLIMITS	11
 
 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +43,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
+	{    IR_SIGNALS,    IR_SIGNALS },		\
+	{    IR_MSGQUEUE,  IR_MSGQUEUE },		\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function linux-2.6.5.org/include/linux/mqueue.h linux-2.6.5/include/linux/mqueue.h
--- linux-2.6.5.org/include/linux/mqueue.h	2004-04-15 19:20:57.000000000 -0300
+++ linux-2.6.5/include/linux/mqueue.h	2004-04-17 02:36:25.000000000 -0300
@@ -21,6 +21,8 @@
 #include <linux/types.h>
 
 #define MQ_PRIO_MAX 	32768
+#define DFLT_QUEUESMAX	256
+#define IR_MSGQUEUE	(DFLT_QUEUESMAX / 4)
 
 struct mq_attr {
 	long	mq_flags;	/* message queue flags			*/
diff -Nur --show-c-function linux-2.6.5.org/include/linux/sched.h linux-2.6.5/include/linux/sched.h
--- linux-2.6.5.org/include/linux/sched.h	2004-04-15 19:20:57.000000000 -0300
+++ linux-2.6.5/include/linux/sched.h	2004-04-17 03:48:31.000000000 -0300
@@ -281,6 +281,7 @@ struct signal_struct {
 	int leader;
 
 	struct tty_struct *tty; /* NULL if no tty */
+	atomic_t sigpending;
 };
 
 /*
@@ -310,6 +311,9 @@ struct user_struct {
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
+	atomic_t signal_pending; /* How many pending signals does this user have? */
+	/* protected by mq_lock 	*/
+	int msg_queues; 	/* How many message queues does this user have? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
diff -Nur --show-c-function linux-2.6.5.org/include/linux/signal.h linux-2.6.5/include/linux/signal.h
--- linux-2.6.5.org/include/linux/signal.h	2004-04-15 11:13:23.000000000 -0300
+++ linux-2.6.5/include/linux/signal.h	2004-04-17 02:34:53.000000000 -0300
@@ -7,6 +7,10 @@
 #include <asm/siginfo.h>
 
 #ifdef __KERNEL__
+
+#define MAX_QUEUED_SIGNALS	4096
+#define IR_SIGNALS	(MAX_QUEUED_SIGNALS/4)
+
 /*
  * Real Time signals may be queued.
  */
diff -Nur --show-c-function linux-2.6.5.org/ipc/mqueue.c linux-2.6.5/ipc/mqueue.c
--- linux-2.6.5.org/ipc/mqueue.c	2004-04-15 19:20:57.000000000 -0300
+++ linux-2.6.5/ipc/mqueue.c	2004-04-19 16:43:15.539968016 -0300
@@ -43,7 +43,6 @@
 #define CTL_MSGSIZEMAX 	4
 
 /* default values */
-#define DFLT_QUEUESMAX	64	/* max number of message queues */
 #define DFLT_MSGMAX 	40	/* max number of messages in each queue */
 #define HARD_MSGMAX 	(131072/sizeof(void*))
 #define DFLT_MSGSIZEMAX 16384	/* max message size */
@@ -217,6 +216,14 @@ static void mqueue_delete_inode(struct i
 
 	spin_lock(&mq_lock);
 	queues_count--;
+
+	/* 
+	 * If we create mqueues, then "setuid()", and destroy 
+	 * mqueues later on (with the new uid), msg_queues 
+	 * can get negative.
+	 */
+	if (current->user->msg_queues > 0)
+		current->user->msg_queues--;
 	spin_unlock(&mq_lock);
 }
 
@@ -225,13 +232,18 @@ static int mqueue_create(struct inode *d
 {
 	struct inode *inode;
 	int error;
+	struct task_struct *p = current;
 
 	spin_lock(&mq_lock);
-	if (queues_count >= queues_max && !capable(CAP_SYS_RESOURCE)) {
+	if (!capable(CAP_SYS_RESOURCE) && (queues_count >= queues_max || 
+	  p->user->msg_queues >= p->rlim[RLIMIT_MSGQUEUE].rlim_cur)) {
 		error = -ENOSPC;
 		goto out_lock;
 	}
+
+
 	queues_count++;
+	p->user->msg_queues++;
 	spin_unlock(&mq_lock);
 
 	inode = mqueue_get_inode(dir->i_sb, mode);
@@ -239,6 +251,7 @@ static int mqueue_create(struct inode *d
 		error = -ENOMEM;
 		spin_lock(&mq_lock);
 		queues_count--;
+		p->user->msg_queues--;
 		goto out_lock;
 	}
 
diff -Nur --show-c-function linux-2.6.5.org/kernel/signal.c linux-2.6.5/kernel/signal.c
--- linux-2.6.5.org/kernel/signal.c	2004-04-15 19:20:57.000000000 -0300
+++ linux-2.6.5/kernel/signal.c	2004-04-19 17:59:40.441956968 -0300
@@ -32,7 +32,7 @@
 static kmem_cache_t *sigqueue_cachep;
 
 atomic_t nr_queued_signals;
-int max_queued_signals = 1024;
+int max_queued_signals = MAX_QUEUED_SIGNALS;
 
 /*
  * In POSIX a signal is sent either to a specific thread (Linux task)
@@ -268,10 +268,13 @@ struct sigqueue *__sigqueue_alloc(void)
 {
 	struct sigqueue *q = 0;
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&nr_queued_signals) < max_queued_signals &&
+	    atomic_read(&current->user->signal_pending) <= 
+			current->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 	if (q) {
 		atomic_inc(&nr_queued_signals);
+		atomic_inc(&current->user->signal_pending);
 		INIT_LIST_HEAD(&q->list);
 		q->flags = 0;
 		q->lock = 0;
@@ -285,6 +288,14 @@ static inline void __sigqueue_free(struc
 		return;
 	kmem_cache_free(sigqueue_cachep, q);
 	atomic_dec(&nr_queued_signals);
+
+	/* 
+	 * Decrease per-user sigpending count. Check 
+	 * for negative value, we might have done setuid()
+	 * with pending signals.
+	 */
+	if (atomic_read(&current->user->signal_pending) > 0)
+		atomic_dec(&current->user->signal_pending);
 }
 
 static void flush_sigqueue(struct sigpending *queue)
@@ -701,11 +712,15 @@ static int send_signal(int sig, struct s
 	   make sure at least one signal gets delivered and don't
 	   pass on the info struct.  */
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&nr_queued_signals) < max_queued_signals &&
+		atomic_read(&current->user->signal_pending) <=
+			current->rlim[RLIMIT_SIGPENDING].rlim_cur) 
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 
 	if (q) {
 		atomic_inc(&nr_queued_signals);
+		atomic_inc(&current->user->signal_pending);
+
 		q->flags = 0;
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
diff -Nur --show-c-function linux-2.6.5.org/kernel/user.c linux-2.6.5/kernel/user.c
--- linux-2.6.5.org/kernel/user.c	2004-04-15 11:14:05.000000000 -0300
+++ linux-2.6.5/kernel/user.c	2004-04-19 15:08:14.000000000 -0300
@@ -30,7 +30,9 @@ static spinlock_t uidhash_lock = SPIN_LO
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
-	.files		= ATOMIC_INIT(0)
+	.files		= ATOMIC_INIT(0),
+	.signal_pending = ATOMIC_INIT(0),
+	.msg_queues = 0
 };
 
 /*
@@ -97,6 +99,9 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		atomic_set(&new->signal_pending, 0);
+
+		new->msg_queues = 0;
 
 		/*
 		 * Before adding this, check whether we raced

----- End forwarded message -----
