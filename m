Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262440AbSI2KMJ>; Sun, 29 Sep 2002 06:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262441AbSI2KMJ>; Sun, 29 Sep 2002 06:12:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34435 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262440AbSI2KMI>;
	Sun, 29 Sep 2002 06:12:08 -0400
Date: Sun, 29 Sep 2002 12:27:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Axel <Axel.Zeuner@gmx.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       NPT library mailing list <phil-list@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: 2.5.39: Signal delivery to thread groups: Bug or feature
In-Reply-To: <200209281638.g8SGcQi23877@mx1.redhat.com>
Message-ID: <Pine.LNX.4.44.0209291222500.18396-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Sep 2002, Axel wrote:

> The main signal dispatching function send_sig_info in kernel/signal.c
> requires at the moment an installed signal handler for delivery of
> signals to members of the thread group.

i fixed this bug, see the attached attached patch, it's against BK-curr.  

It fixes the testcase Ulrich created from your description - does it fix
your testcase as well? (Ulrich added this testcase to NPTL, should show up
in the next drop.)

we still have one more problem left in the signal handling area: atomicity
of signal delivery. Eg. right now it's possible to have a signal 'in
flight' for one specific thread, which manages to block it before handling
the signal. What should the behavior be in that case? Does POSIX say
anything about this?

	Ingo

--- linux/kernel/signal.c.orig	Sun Sep 29 11:59:03 2002
+++ linux/kernel/signal.c	Sun Sep 29 12:17:14 2002
@@ -874,9 +874,23 @@
 	return err;
 }
 
+struct task_struct * find_unblocked_thread(struct task_struct *p, int signr)
+{
+	struct task_struct *tmp;
+	struct list_head *l;
+	struct pid *pid;
+
+	for_each_task_pid(p->tgid, PIDTYPE_TGID, tmp, l, pid)
+		if (!sigismember(&tmp->blocked, signr) &&
+					!sigismember(&tmp->real_blocked, signr))
+			return tmp;
+	return NULL;
+}
+
 int
 send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
+	struct task_struct *t;
 	unsigned long flags;
 	int ret = 0;
 
@@ -905,21 +919,19 @@
 	if (sig_ignored(p, sig))
 		goto out_unlock;
 
-	/* blocked (or ptraced) signals get posted */
-	spin_lock(&p->sigmask_lock);
-	if ((p->ptrace & PT_PTRACED) || sigismember(&p->blocked, sig) ||
-					sigismember(&p->real_blocked, sig)) {
-		spin_unlock(&p->sigmask_lock);
+	if (sig_kernel_specific(sig))
 		goto out_send;
-	}
-	spin_unlock(&p->sigmask_lock);
 
+	/* Does any of the threads unblock the signal? */
+	t = find_unblocked_thread(p, sig);
+	if (!t) {
+		ret = __send_sig_info(sig, info, p, 1);
+		goto out_unlock;
+	}
 	if (sig_kernel_broadcast(sig) || sig_kernel_coredump(sig)) {
 		ret = __broadcast_thread_group(p, sig);
 		goto out_unlock;
 	}
-	if (sig_kernel_specific(sig))
-		goto out_send;
 
 	/* must not happen */
 	BUG();

