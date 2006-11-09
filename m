Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424092AbWKIP7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424092AbWKIP7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424093AbWKIP7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:59:14 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:8356 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1424092AbWKIP7M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:59:12 -0500
Subject: [PATCH -mm 2/3][AIO] - AIO completion signal notification
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       "moi @ Bull" <sebastien.dugue@bull.net>
In-Reply-To: <1163087717.3879.34.camel@frecb000686>
References: <1163087717.3879.34.camel@frecb000686>
Date: Thu, 09 Nov 2006 16:59:00 +0100
Message-Id: <1163087940.3879.41.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2006 17:05:55,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2006 17:05:59,
	Serialize complete at 09/11/2006 17:05:59
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                      Export good_sigevent()


  Move good_sigevent() from posix-timers.c to signal.c where it belongs,
and export it so that it can be used by other subsystems.


 include/linux/signal.h |    2 ++
 kernel/posix-timers.c  |   17 -----------------
 kernel/signal.c        |   23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 17 deletions(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>


Index: linux-2.6.19-rc5-mm1/include/linux/signal.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/linux/signal.h	2006-11-09 10:43:58.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/linux/signal.h	2006-11-09 10:46:23.000000000 +0100
@@ -241,6 +241,8 @@ extern int sigprocmask(int, sigset_t *, 
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 
+extern struct task_struct * good_sigevent(sigevent_t *);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SIGNAL_H */
Index: linux-2.6.19-rc5-mm1/kernel/posix-timers.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/posix-timers.c	2006-11-09 10:43:58.000000000 +0100
+++ linux-2.6.19-rc5-mm1/kernel/posix-timers.c	2006-11-09 10:46:23.000000000 +0100
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
Index: linux-2.6.19-rc5-mm1/kernel/signal.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/signal.c	2006-11-09 10:43:58.000000000 +0100
+++ linux-2.6.19-rc5-mm1/kernel/signal.c	2006-11-09 10:46:23.000000000 +0100
@@ -1189,6 +1189,29 @@ int group_send_sig_info(int sig, struct 
 	return ret;
 }
 
+/***
+ * good_sigevent - check and get target task from a sigevent.
+ * @event: the sigevent to be checked
+ *
+ * This function must be called with tasklist_lock held for reading.
+ */
+struct task_struct * good_sigevent(sigevent_t * event)
+{
+	struct task_struct *rtn = current->group_leader;
+
+	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
+		(!(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
+		 rtn->tgid != current->tgid ||
+		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
+		return NULL;
+
+	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
+	    ((event->sigev_signo <= 0) || (event->sigev_signo > SIGRTMAX)))
+		return NULL;
+
+	return rtn;
+}
+
 /*
  * kill_pgrp_info() sends a signal to a process group: this is what the tty
  * control characters do (^C, ^Z etc)


