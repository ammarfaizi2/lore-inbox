Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWCYMpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWCYMpU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWCYMpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:45:18 -0500
Received: from www.osadl.org ([213.239.205.134]:13533 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751147AbWCYMpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:45:17 -0500
Message-Id: <20060325121223.557385000@localhost.localdomain>
References: <20060325121219.172731000@localhost.localdomain>
Date: Sat, 25 Mar 2006 12:46:01 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 1/2] hrtimer
Content-Disposition: inline; filename=hrtimer-create-generic-sleeper.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The removal of the data field in the hrtimer structure enforces the embedding
of the timer into another data structure. nanosleep now uses a private
implementation of the most common used timer callback function (simple task wakeup).
In order to avoid the reimplentation of such functionality all over the place
a generic hrtimer_sleeper functionality is created.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/hrtimer.h |   16 ++++++++++++++++
 kernel/hrtimer.c        |   19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

Index: linux-2.6.16/include/linux/hrtimer.h
===================================================================
--- linux-2.6.16.orig/include/linux/hrtimer.h
+++ linux-2.6.16/include/linux/hrtimer.h
@@ -58,6 +58,19 @@ struct hrtimer {
 };
 
 /**
+ * struct hrtimer_sleeper - simple sleeper structure
+ *
+ * @timer:	embedded timer structure
+ * @task:	task to wake up
+ *
+ * task is set to NULL, when the timer expires.
+ */
+struct hrtimer_sleeper {
+	struct hrtimer timer;
+	struct task_struct *task;
+};
+
+/**
  * struct hrtimer_base - the timer base for a specific clock
  *
  * @index:		clock type index for per_cpu support when moving a timer
@@ -127,6 +140,9 @@ extern long hrtimer_nanosleep(struct tim
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
+extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
+				 struct task_struct *tsk);
+
 /* Soft interrupt function to run the hrtimer queues: */
 extern void hrtimer_run_queues(void);
 
Index: linux-2.6.16/kernel/hrtimer.c
===================================================================
--- linux-2.6.16.orig/kernel/hrtimer.c
+++ linux-2.6.16/kernel/hrtimer.c
@@ -656,6 +656,25 @@ void hrtimer_run_queues(void)
  * Sleep related functions:
  */
 
+static int hrtimer_wakeup(struct hrtimer *timer)
+{
+	struct hrtimer_sleeper *t =
+		container_of(timer, struct hrtimer_sleeper, timer);
+	struct task_struct *task = t->task;
+
+	t->task = NULL;
+	if (task)
+		wake_up_process(task);
+
+	return HRTIMER_NORESTART;
+}
+
+void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, task_t *task)
+{
+	sl->timer.function = hrtimer_wakeup;
+	sl->task = task;
+}
+
 struct sleep_hrtimer {
 	struct hrtimer timer;
 	struct task_struct *task;

--

