Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbUAADoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 22:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265358AbUAADoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 22:44:01 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:58028 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265357AbUAADnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 22:43:37 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 31 Dec 2003 19:45:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20031231231637.912362C013@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0312311935080.5831-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003, Rusty Russell wrote:

> But an alternate implementation would be to have a "kthread" kernel
> thread, which would actually be parent to the kthread threads.  This
> means it can allocate and clean up, since it catches *all* thread
> deaths, including "exit()".
> 
> What do you think?

Did you take a look at the stuff I sent you? I'll append here with a 
simple comment (this goes over you bits).

1)
Define a structure:

struct kt_message {
       spinlock_t lock;
       struct task_struct *from;
       void *info;
};

and add it inside the task struct. There's no need to cleanup this 
structure on exit.


2)
The global mutex, the global spinlock and the global "struct kt_message" go away. 


3) The "creator" of the kthread is not picked up with a message but is 
passed with the kernel data.


The reason for those bits would be that basically the communication is 
really 1<->1, so IMHO there's no need to converge into static global data 
for this. OTOH it does not really have scalability problems, so it is a 
matter of personal taste. Burn those bits if you like :-)



- Davide



diff -Nru linux-2.6-mm1/include/linux/init_task.h linux-2.6-mm1.mod/include/linux/init_task.h
--- linux-2.6-mm1/include/linux/init_task.h	2003-12-31 11:30:48.529434800 -0800
+++ linux-2.6-mm1.mod/include/linux/init_task.h	2003-12-31 12:07:58.929362472 -0800
@@ -109,6 +109,9 @@
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
 	.io_wait	= NULL,						\
+	.ktm		= {						\
+		.lock		= SPIN_LOCK_UNLOCKED			\
+	},								\
 }
 
 
diff -Nru linux-2.6-mm1/include/linux/sched.h linux-2.6-mm1.mod/include/linux/sched.h
--- linux-2.6-mm1/include/linux/sched.h	2003-12-31 11:30:48.842387224 -0800
+++ linux-2.6-mm1.mod/include/linux/sched.h	2003-12-31 12:05:39.808512056 -0800
@@ -326,6 +326,11 @@
 	struct sigqueue *sigq;		/* signal queue entry. */
 };
 
+struct kt_message {
+	spinlock_t lock;
+	struct task_struct *from;
+	void *info;
+};
 
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
@@ -471,6 +476,9 @@
  * to a stack based synchronous wait) if its doing sync IO.
  */
 	wait_queue_t *io_wait;
+
+/* Used to exchange messages by kthread. */
+	struct kt_message ktm;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -Nru linux-2.6-mm1/kernel/kthread.c linux-2.6-mm1.mod/kernel/kthread.c
--- linux-2.6-mm1/kernel/kthread.c	2003-12-31 11:33:26.056487048 -0800
+++ linux-2.6-mm1.mod/kernel/kthread.c	2003-12-31 12:38:08.989191552 -0800
@@ -10,32 +10,14 @@
 #include <linux/err.h>
 #include <asm/semaphore.h>
 
-/* This makes sure only one kthread is being talked to at once. */
-static DECLARE_MUTEX(kthread_control);
-
-/* This coordinates communication between the kthread and routine
- * controlling it.  Strictly unneccessary, but without it it's barrier
- * hell. */
-static spinlock_t ktm_lock = SPIN_LOCK_UNLOCKED;
-
-/* All thread comms is command -> ack, so we keep it simple. */
-struct kt_message
-{
-	struct task_struct *from, *to;
-	void *info;
-};
-
-static struct kt_message ktm;
 
 static void ktm_send(struct task_struct *to, void *info)
 {
-	spin_lock(&ktm_lock);
-	ktm.to = to;
-	ktm.from = current;
-	ktm.info = info;
-	if (ktm.to)
-		wake_up_process(ktm.to);
-	spin_unlock(&ktm_lock);
+	spin_lock(&to->ktm.lock);
+	to->ktm.from = current;
+	to->ktm.info = info;
+	wake_up_process(to);
+	spin_unlock(&to->ktm.lock);
 }
 
 static struct kt_message ktm_receive(void)
@@ -43,15 +25,16 @@
 	struct kt_message m;
 
 	for (;;) {
-		spin_lock(&ktm_lock);
-		if (ktm.to == current)
+		spin_lock(&current->ktm.lock);
+		if (current->ktm.from)
 			break;
 		current->state = TASK_INTERRUPTIBLE;
-		spin_unlock(&ktm_lock);
+		spin_unlock(&current->ktm.lock);
 		schedule();
 	}
-	m = ktm;
-	spin_unlock(&ktm_lock);
+	m = current->ktm;
+	current->ktm.from = NULL;
+	spin_unlock(&current->ktm.lock);
 	return m;
 }
 
@@ -63,17 +46,25 @@
 	char *name;
 };
 
+struct kthread_create
+{
+	struct task_struct *creator;
+	struct task_struct *result;
+	struct kthread k;
+	struct completion done;
+};
+
 /* Check if we're being told to stop. */
 static int time_to_die(struct kt_message *m)
 {
         int ret = 0;
 
-        spin_lock(&ktm_lock);
-        if (ktm.to == current && ktm.info == NULL) {
-                *m = ktm;
+        spin_lock(&current->ktm.lock);
+        if (current->ktm.from && !current->ktm.info) {
+                *m = current->ktm;
                 ret = 1;
         }
-        spin_unlock(&ktm_lock);
+        spin_unlock(&current->ktm.lock);
         return ret;
 }
 
@@ -81,7 +72,8 @@
 static int kthread(void *data)
 {
 	/* Copy data: it's on keventd_init's stack */
-	struct kthread k = *(struct kthread *)data;
+	struct kthread_create *kc = data;
+	struct kthread k = kc->k;
 	struct kt_message m;
 	int ret = 0;
 	sigset_t blocked;
@@ -94,7 +86,7 @@
 	flush_signals(current);
 
 	/* Send to spawn_kthread, so it knows who we are. */
-	ktm_send(ktm.info, current);
+	ktm_send(kc->creator, current);
 
 	/* Receive from kthread_start or kthread_destroy */
 	m = ktm_receive();
@@ -124,24 +116,16 @@
 	return ret;
 }
 
-struct kthread_create
-{
-	struct task_struct *result;
-	struct kthread k;
-	struct completion done;
-};
-
 /* We are keventd().  We create a thread. */
 static void spawn_kthread(void *data)
 {
 	struct kthread_create *kc = data;
 	int ret;
 
-	/* Set up message so they know who their parent is. */
-	ktm_send(NULL, current);
+	kc->creator = current;
 
 	/* We want our own signal handler (we take no signals by default). */
-	ret = kernel_thread(kthread, &kc->k, CLONE_FS | CLONE_FILES | SIGCHLD);
+	ret = kernel_thread(kthread, kc, CLONE_FS | CLONE_FILES | SIGCHLD);
 	if (ret < 0)
 		kc->result = ERR_PTR(ret);
 	else {
@@ -174,7 +158,6 @@
 	kc.k.data = data;
 	kc.k.name = name;
 
-	down(&kthread_control);
 	/* If we're being called to start the first workqueue, we
 	 * can't use keventd. */
 	if (!keventd_up())
@@ -183,7 +166,6 @@
 		schedule_work(&work);
 		wait_for_completion(&kc.done);
 	}
-	up(&kthread_control);
 	return kc.result;
 }
 
@@ -199,10 +181,8 @@
 
 	get_task_struct(k);
 
-	down(&kthread_control);
 	ktm_send(k, k);
 	m = ktm_receive();
-	up(&kthread_control);
 
 	if (IS_ERR(m.info))
 		wait_for_death(k);
@@ -217,10 +197,8 @@
 
 	get_task_struct(k);
 
-	down(&kthread_control);
 	ktm_send(k, NULL);
 	m = ktm_receive();
-	up(&kthread_control);
 
 	wait_for_death(k);
 	put_task_struct(k);

