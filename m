Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSH0SJ7>; Tue, 27 Aug 2002 14:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSH0SJ7>; Tue, 27 Aug 2002 14:09:59 -0400
Received: from mail.netikka.fi ([62.148.192.132]:59381 "EHLO mail.netikka.fi")
	by vger.kernel.org with ESMTP id <S316695AbSH0SJ4>;
	Tue, 27 Aug 2002 14:09:56 -0400
Message-ID: <000b01c24df5$aacc7ed0$d20a5f0a@deldaran>
From: "Lahti Oy" <rlahti@netikka.fi>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched.c
Date: Tue, 27 Aug 2002 21:15:03 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small patch that makes NR_CPUS loops decrement from 31 to 0 in sched.c to
squeeze out some cycles (of course only on SMP machines). Also deprecated a
macro that was only used once in the code and changed one if-conditional to
else if.

If everyone agrees, do I need to post the patch to someone or will it be
picked from the list?

Furthermore, there are probably many other juicy spots in the kernel where
decrementing loops could be applied. Is there a reason for not doing so at
the moment?

--- sched.c.orig Tue Aug 27 08:32:38 2002
+++ sched.c Tue Aug 27 08:32:38 2002
@@ -161,7 +161,6 @@
 #define cpu_rq(cpu)  (runqueues + (cpu))
 #define this_rq()  cpu_rq(smp_processor_id())
 #define task_rq(p)  cpu_rq(task_cpu(p))
-#define cpu_curr(cpu)  (cpu_rq(cpu)->curr)
 #define rt_task(p)  ((p)->prio < MAX_RT_PRIO)

 /*
@@ -543,7 +542,7 @@
 {
  unsigned long i, sum = 0;

- for (i = 0; i < NR_CPUS; i++)
+ for (i = NR_CPUS; i; i--)
   sum += cpu_rq(i)->nr_running;

  return sum;
@@ -553,7 +552,7 @@
 {
  unsigned long i, sum = 0;

- for (i = 0; i < NR_CPUS; i++)
+ for (i = NR_CPUS; i; i--)
   sum += cpu_rq(i)->nr_uninterruptible;

  return sum;
@@ -563,7 +562,7 @@
 {
  unsigned long i, sum = 0;

- for (i = 0; i < NR_CPUS; i++)
+ for (i = NR_CPUS; i; i--)
   sum += cpu_rq(i)->nr_switches;

  return sum;
@@ -667,7 +666,7 @@

  busiest = NULL;
  max_load = 1;
- for (i = 0; i < NR_CPUS; i++) {
+ for (i = NR_CPUS; i; i--) {
   if (!cpu_online(i))
    continue;

@@ -1297,7 +1296,7 @@
   if (increment < -40)
    increment = -40;
  }
- if (increment > 40)
+ else if (increment > 40)
   increment = 40;

  nice = PRIO_TO_NICE(current->static_prio) + increment;
@@ -1344,7 +1343,7 @@
  */
 int idle_cpu(int cpu)
 {
- return cpu_curr(cpu) == cpu_rq(cpu)->idle;
+ return cpu_rq(cpu)->curr == cpu_rq(cpu)->idle;
 }

 /**
@@ -2081,7 +2080,7 @@
  runqueue_t *rq;
  int i, j, k;

- for (i = 0; i < NR_CPUS; i++) {
+ for (i = NR_CPUS; i; i--) {
   prio_array_t *array;

   rq = cpu_rq(i);

