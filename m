Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966980AbWK2KfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966980AbWK2KfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966973AbWK2Keo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:34:44 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:45021 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S966993AbWK2KeM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:34:12 -0500
Date: Wed, 29 Nov 2006 11:32:34 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: [PATCH -mm 3/5][AIO] - export good_sigevent()
Message-ID: <20061129113234.38c12911@frecb000686>
In-Reply-To: <20061129112441.745351c9@frecb000686>
References: <20061129112441.745351c9@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:41:18,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:41:23,
	Serialize complete at 29/11/2006 11:41:23
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                      Export good_sigevent()


  Move good_sigevent() from posix-timers.c to signal.c where it belongs,
and export it so that it can be used by other subsystems.


 include/linux/signal.h |    1 +
 kernel/posix-timers.c  |   17 -----------------
 kernel/signal.c        |   23 +++++++++++++++++++++++
 3 files changed, 24 insertions(+), 17 deletions(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>


Index: linux-2.6.19-rc6-mm2/include/linux/signal.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/linux/signal.h	2006-11-28
12:49:40.000000000 +0100 +++ linux-2.6.19-rc6-mm2/include/linux/signal.h
2006-11-28 12:51:43.000000000 +0100 @@ -240,6 +240,7 @@ extern int
sigprocmask(int, sigset_t *, 
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction
*return_ka, struct pt_regs *regs, void *cookie); +extern struct task_struct *
good_sigevent(sigevent_t *); 
 extern struct kmem_cache *sighand_cachep;
 
Index: linux-2.6.19-rc6-mm2/kernel/posix-timers.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/posix-timers.c	2006-11-28
12:49:40.000000000 +0100 +++ linux-2.6.19-rc6-mm2/kernel/posix-timers.c
2006-11-28 12:51:43.000000000 +0100 @@ -367,23 +367,6 @@ static enum
hrtimer_restart posix_timer_ return ret;
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
--- linux-2.6.19-rc6-mm2.orig/kernel/signal.c	2006-11-28
12:49:40.000000000 +0100 +++ linux-2.6.19-rc6-mm2/kernel/signal.c
2006-11-28 12:51:43.000000000 +0100 @@ -1189,6 +1189,29 @@ int
group_send_sig_info(int sig, struct return ret;
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
