Return-Path: <linux-kernel-owner+w=401wt.eu-S932348AbXADJ1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbXADJ1S (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 04:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbXADJ1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 04:27:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:33633 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342AbXADJ1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 04:27:16 -0500
Date: Thu, 4 Jan 2007 15:04:33 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: [PATCHSET 3][PATCH 3/5][AIO] - Make good_sigevent non-static
Message-ID: <20070104093433.GG9608@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20070104092733.GD9608@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070104092733.GD9608@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

                      Make good_sigevent() non-static

  Move good_sigevent() from posix-timers.c to signal.c where it belongs,
and make it non-static so that it can be used by other subsystems.

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="export-good_sigevent.patch"
Content-Transfer-Encoding: 8bit


From: Sébastien Dugué <sebastien.dugue@bull.net>

  Move good_sigevent() from posix-timers.c to signal.c where it belongs,
and make it non-static so that it can be used by other subsystems.

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 include/linux/signal.h |    1 +
 kernel/posix-timers.c  |   17 -----------------
 kernel/signal.c        |   24 ++++++++++++++++++++++++
 3 files changed, 25 insertions(+), 17 deletions(-)

diff -puN include/linux/signal.h~export-good_sigevent include/linux/signal.h
--- linux-2.6.20-rc2/include/linux/signal.h~export-good_sigevent	2007-01-03 10:17:28.000000000 +0530
+++ linux-2.6.20-rc2-bharata/include/linux/signal.h	2007-01-03 10:17:28.000000000 +0530
@@ -240,6 +240,7 @@ extern int sigprocmask(int, sigset_t *, 
 
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
+extern struct task_struct * good_sigevent(sigevent_t *);
 
 extern struct kmem_cache *sighand_cachep;
 
diff -puN kernel/posix-timers.c~export-good_sigevent kernel/posix-timers.c
--- linux-2.6.20-rc2/kernel/posix-timers.c~export-good_sigevent	2007-01-03 10:17:28.000000000 +0530
+++ linux-2.6.20-rc2-bharata/kernel/posix-timers.c	2007-01-03 10:17:28.000000000 +0530
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
diff -puN kernel/signal.c~export-good_sigevent kernel/signal.c
--- linux-2.6.20-rc2/kernel/signal.c~export-good_sigevent	2007-01-03 10:17:28.000000000 +0530
+++ linux-2.6.20-rc2-bharata/kernel/signal.c	2007-01-04 13:21:28.000000000 +0530
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
_

--5gxpn/Q6ypwruk0T--
