Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266897AbRGQSOh>; Tue, 17 Jul 2001 14:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266900AbRGQSO1>; Tue, 17 Jul 2001 14:14:27 -0400
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:7047 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S266897AbRGQSOQ>; Tue, 17 Jul 2001 14:14:16 -0400
Message-ID: <3B548022.F2CB5520@watson.ibm.com>
Date: Tue, 17 Jul 2001 14:12:50 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@us.ibm.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency (FIX)_
In-Reply-To: <OF51487F8A.564A5A7D-ON85256A8C.0063C208@pok.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------5CC6E2A7A562635F9959B087"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5CC6E2A7A562635F9959B087
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

David, thanks for pointing this out. Ofcourse, it has be reset at that point.
Since it is still running, it actually proves that priority overwrites for
reservations work.
Did you have a chance to run it on the offending app. I don't have that one,
hence I only tried on kernel builds etc.
Here is the update patch.

-- Hubertus (frankeh@us.ibm.com)

> Davide Libenzi <davidel@xmailserver.org>@lists.sourceforge.net on
> 07/17/2001 02:00:45 PM
>
> Sent by:  lse-tech-admin@lists.sourceforge.net
>
> To:   Hubertus Frnake <frankeh@watson.ibm.com>
> cc:   linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
>       ak@suse.de
> Subject:  Re: [Lse-tech] Re: CPU affinity & IPI latency (FIX)_
>
> On 17-Jul-2001 Hubertus Frnake wrote:
> > In an attempt to inline the code, somehow the tabs got lost. So here is
> the
> > attached correct patch fo 2.4.5. Please try and let me know whether you
> > see your problems disappear and/or others arise.
> > The sketchy writeup is still the same.
>
> Did You tried the patch ?
> Maybe this could help :
>
> +       next = cpu_resched(this_cpu);
> +       if (next) {
> +               cpu_resched(this_cpu) = NULL;
> -               next = p;
> +               goto found_next;
> +       }
>
> - Davide
>
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/lse-tech

--------------5CC6E2A7A562635F9959B087
Content-Type: text/plain; charset=us-ascii;
 name="cpuaff-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuaff-patch"

diff -uwrbBN linux-2.4.5-van/kernel/sched.c linux-2.4.5-ca/kernel/sched.c
--- linux-2.4.5-van/kernel/sched.c	Fri Apr 20 21:26:16 2001
+++ linux-2.4.5-ca/kernel/sched.c	Tue Jul 17 14:02:13 2001
@@ -97,12 +97,14 @@
 static union {
 	struct schedule_data {
 		struct task_struct * curr;
+		struct task_struct * resched;
 		cycles_t last_schedule;
 	} schedule_data;
 	char __pad [SMP_CACHE_BYTES];
-} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};
+} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0,0}}};
 
 #define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
+#define cpu_resched(cpu) aligned_data[(cpu)].schedule_data.resched
 #define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
 
 struct kernel_stat kstat;
@@ -208,7 +210,7 @@
 {
 #ifdef CONFIG_SMP
 	int this_cpu = smp_processor_id();
-	struct task_struct *tsk, *target_tsk;
+	struct task_struct *tsk, *target_tsk, *rtsk;
 	int cpu, best_cpu, i, max_prio;
 	cycles_t oldest_idle;
 
@@ -219,7 +221,9 @@
 	best_cpu = p->processor;
 	if (can_schedule(p, best_cpu)) {
 		tsk = idle_task(best_cpu);
-		if (cpu_curr(best_cpu) == tsk) {
+		if ((cpu_curr(best_cpu) == tsk) &&
+		    (cpu_resched(best_cpu) == NULL))
+		{
 			int need_resched;
 send_now_idle:
 			/*
@@ -244,13 +248,24 @@
 	 */
 	oldest_idle = (cycles_t) -1;
 	target_tsk = NULL;
+	best_cpu = 0;
 	max_prio = 1;
 
 	for (i = 0; i < smp_num_cpus; i++) {
 		cpu = cpu_logical_map(i);
 		if (!can_schedule(p, cpu))
 			continue;
+		/* first check whether there is an resched IPI
+		 * reservation for that cpu. If so consider priority
+		 * of the reservation instead of current.
+		 * We do not have to set the need_resched flag again
+		 * for the currently running task. It must have been
+		 * signalled before
+		 */
+		tsk = cpu_resched(cpu);
+		if (tsk == NULL)
 		tsk = cpu_curr(cpu);
+
 		/*
 		 * We use the first available idle CPU. This creates
 		 * a priority list between idle CPUs, but this is not
@@ -268,19 +283,30 @@
 				if (prio > max_prio) {
 					max_prio = prio;
 					target_tsk = tsk;
+					best_cpu = cpu;
 				}
 			}
 		}
 	}
 	tsk = target_tsk;
 	if (tsk) {
+		rtsk = cpu_resched(best_cpu);
+		if (rtsk) {
+			rtsk->has_cpu = 0; /* return rtsk to scheduable */
+			tsk->has_cpu  = 1; /* can't schedule this one no more*/
+			cpu_resched(best_cpu) = tsk;
+			return;
+		}
 		if (oldest_idle != -1ULL) {
 			best_cpu = tsk->processor;
 			goto send_now_idle;
 		}
 		tsk->need_resched = 1;
-		if (tsk->processor != this_cpu)
-			smp_send_reschedule(tsk->processor);
+		if (tsk->processor != this_cpu) {
+			tsk->has_cpu  = 1; 
+			cpu_resched(best_cpu) = tsk;
+			smp_send_reschedule(best_cpu);
+		}
 	}
 	return;
 		
@@ -578,6 +604,16 @@
 	 */
 
 repeat_schedule:
+	/* we check whether we have a resched_IPI reservation:
+	 * if so simply select the reserving task and next and
+	 * go to switch to it.
+	 */
+	next = cpu_resched(this_cpu);
+	if (next) {
+		cpu_resched(this_cpu) = NULL;
+		next = p;
+		goto found_next;
+	}
 	/*
 	 * Default process to select..
 	 */
@@ -604,6 +640,7 @@
 	 * switching to the next task, save this fact in
 	 * sched_data.
 	 */
+found_next:
 	sched_data->curr = next;
 #ifdef CONFIG_SMP
  	next->has_cpu = 1;

--------------5CC6E2A7A562635F9959B087--

