Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030637AbWK3Pv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030637AbWK3Pv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030623AbWK3Pvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:51:37 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:19366 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030618AbWK3PvC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:51:02 -0500
Date: Thu, 30 Nov 2006 16:50:10 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-aio <linux-aio@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Bharata B Rao <bharata@in.ibm.com>
Subject: Re: [PATCH -mm 3/5][AIO] - Make good_sigevent non-static
Message-ID: <20061130165010.089d3072@frecb000686>
In-Reply-To: <20061130163839.38689215@frecb000686>
References: <20061130163839.38689215@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 16:58:05,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 16:58:12,
	Serialize complete at 30/11/2006 16:58:12
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


Index: linux-2.6.19-rc6-mm2/include/linux/signal.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/linux/signal.h	2006-11-30 13:18:33.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/linux/signal.h	2006-11-30 13:20:13.000000000 +0100
@@ -240,6 +240,7 @@ extern int sigprocmask(int, sigset_t *, 
 
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
+extern struct task_struct * good_sigevent(sigevent_t *);
 
 extern struct kmem_cache *sighand_cachep;
 
Index: linux-2.6.19-rc6-mm2/kernel/posix-timers.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/posix-timers.c	2006-11-30 13:18:33.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/posix-timers.c	2006-11-30 13:20:13.000000000 +0100
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
Index: linux-2.6.19-rc6-mm2/kernel/signal.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/signal.c	2006-11-30 13:18:33.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/signal.c	2006-11-30 13:33:10.000000000 +0100
@@ -1189,6 +1189,30 @@ int group_send_sig_info(int sig, struct 
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
