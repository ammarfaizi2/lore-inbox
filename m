Return-Path: <linux-kernel-owner+w=401wt.eu-S932240AbXAQJ7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbXAQJ7h (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbXAQJ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:59:07 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:42800 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbXAQJ6h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:58:37 -0500
Date: Wed, 17 Jan 2007 10:49:33 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-aio <linux-aio@kvack.org>,
       Bharata B Rao <bharata@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: [PATCH -mm 3/5][AIO] - Make good_sigevent non-static
Message-ID: <20070117104933.343a3224@frecb000686>
In-Reply-To: <20070117104601.36b2ab18@frecb000686>
References: <20070117104601.36b2ab18@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 11:06:52,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 11:06:52,
	Serialize complete at 17/01/2007 11:06:52
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                      Make good_sigevent() non-static


  Move good_sigevent() from posix-timers.c to signal.c where it belongs,
and make it non-static so that it can be used by other subsystems.


 include/linux/signal.h |    1 +
 kernel/posix-timers.c  |   17 -----------------
 kernel/signal.c        |   24 ++++++++++++++++++++++++
 3 files changed, 25 insertions(+), 17 deletions(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>


Index: linux-2.6.20-rc4-mm1/include/linux/signal.h
===================================================================
--- linux-2.6.20-rc4-mm1.orig/include/linux/signal.h	2007-01-12 11:40:30.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/signal.h	2007-01-12 12:15:06.000000000 +0100
@@ -240,6 +240,7 @@ extern int sigprocmask(int, sigset_t *, 
 
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
+extern struct task_struct * good_sigevent(sigevent_t *);
 
 extern struct kmem_cache *sighand_cachep;
 
Index: linux-2.6.20-rc4-mm1/kernel/posix-timers.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/kernel/posix-timers.c	2007-01-12 11:40:39.000000000 +0100
+++ linux-2.6.20-rc4-mm1/kernel/posix-timers.c	2007-01-12 12:15:06.000000000 +0100
@@ -367,23 +367,6 @@ static enum hrtimer_restart posix_timer_
 	return ret;
 }
 
-static struct task_struct * good_sigevent(sigevent_t * event)
-{
-	struct task_struct *rtn = current->group_leader;
-
-	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
-		(!(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
-		 rtn->tgid != current->tgid ||
-		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
-		return NULL;
-
-	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
-	    ((event->sigev_signo <= 0) || (event->sigev_signo > SIGRTMAX)))
-		return NULL;
-
-	return rtn;
-}
-
 void register_posix_clock(const clockid_t clock_id, struct k_clock *new_clock)
 {
 	if ((unsigned) clock_id >= MAX_CLOCKS) {
Index: linux-2.6.20-rc4-mm1/kernel/signal.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/kernel/signal.c	2007-01-12 11:40:39.000000000 +0100
+++ linux-2.6.20-rc4-mm1/kernel/signal.c	2007-01-12 12:15:06.000000000 +0100
@@ -1213,6 +1213,30 @@ int group_send_sig_info(int sig, struct 
 	return ret;
 }
 
+/***
+ * good_sigevent - check and get target task from a sigevent.
+ * @event: the sigevent to be checked
+ *
+ * This function must be called with the tasklist_lock held for reading.
+ */
+struct task_struct * good_sigevent(sigevent_t * event)
+{
+	struct task_struct *task = current->group_leader;
+
+	if ((event->sigev_notify & SIGEV_THREAD_ID ) == SIGEV_THREAD_ID) {
+		task = find_task_by_pid(event->sigev_notify_thread_id);
+
+		if (!task || task->tgid != current->tgid)
+			return NULL;
+	} else if (event->sigev_notify == SIGEV_SIGNAL) {
+		if ((event->sigev_signo <= 0) || (event->sigev_signo > SIGRTMAX))
+			return NULL;
+	} else
+		return NULL;
+
+	return task;
+}
+
 /*
  * kill_pgrp_info() sends a signal to a process group: this is what the tty
  * control characters do (^C, ^Z etc)
