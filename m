Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934178AbWKTOWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934178AbWKTOWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934181AbWKTOWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:22:47 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:22994 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S934178AbWKTOWp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:22:45 -0500
Date: Mon, 20 Nov 2006 15:22:44 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 2/4][AIO] - export good_sigevent()
Message-ID: <20061120152244.275f425a@frecb000686>
In-Reply-To: <20061120151700.4a4f9407@frecb000686>
References: <20061120151700.4a4f9407@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/11/2006 15:29:44,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/11/2006 15:29:46,
	Serialize complete at 20/11/2006 15:29:46
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



                      Export good_sigevent()


  Move good_sigevent() from posix-timers.c to signal.c where it belongs,
and export it so that it can be used by other subsystems.


 include/linux/signal.h |    2 ++
 kernel/posix-timers.c  |   17 -----------------
 kernel/signal.c        |   23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 17 deletions(-)

Signed-off-by: S�bastien Dugu� <sebastien.dugue@bull.net>


Index: linux-2.6.19-rc5-mm2/include/linux/signal.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/signal.h	2006-11-17
11:20:08.000000000 +0100 +++ linux-2.6.19-rc5-mm2/include/linux/signal.h
2006-11-17 11:20:31.000000000 +0100 @@ -241,6 +241,8 @@ extern int
sigprocmask(int, sigset_t *, struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction
*return_ka, struct pt_regs *regs, void *cookie); 
+extern struct task_struct * good_sigevent(sigevent_t *);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SIGNAL_H */
Index: linux-2.6.19-rc5-mm2/kernel/posix-timers.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/posix-timers.c	2006-11-17
11:20:08.000000000 +0100 +++ linux-2.6.19-rc5-mm2/kernel/posix-timers.c
2006-11-17 11:20:31.000000000 +0100 @@ -367,23 +367,6 @@ static enum
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
Index: linux-2.6.19-rc5-mm2/kernel/signal.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/signal.c	2006-11-17
11:20:08.000000000 +0100 +++ linux-2.6.19-rc5-mm2/kernel/signal.c
2006-11-17 11:20:31.000000000 +0100 @@ -1189,6 +1189,29 @@ int
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
