Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbRGQRfK>; Tue, 17 Jul 2001 13:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266882AbRGQRfC>; Tue, 17 Jul 2001 13:35:02 -0400
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:20232 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S266868AbRGQRes>; Tue, 17 Jul 2001 13:34:48 -0400
Message-ID: <3B5476E0.EBC7CA12@watson.ibm.com>
Date: Tue, 17 Jul 2001 13:33:21 -0400
From: Hubertus Frnake <frankeh@watson.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ak@suse.de, lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency (FIX)_
In-Reply-To: <OF46AE0C03.7FA13916-ON85256A8C.005E4CEB@pok.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------682E429C9884B5414AFC4670"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------682E429C9884B5414AFC4670
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

In an attempt to inline the code, somehow the tabs got lost. So here is the
attached correct patch fo 2.4.5. Please try and let me know whether you
see your problems disappear and/or others arise.
The sketchy writeup is still the same.

-- Hubertus Franke  (frankeh@us.ibm.com)


>
>
> Enclosed is a patch for the fixing the process bouncing problem a.k.a
> "PU affinity & IPI latency".
>
> The patch is again 2.4.5 (all I had last night), so Andi could you please
> test  it
> on your stuff and see whether it works for you. It works on stock apps.
>
> Basic principle is as follows:
>
> When reschedule_idle(p) determines to IPI a task, it sets a pointer
> to <p> in schedule_data(target_cpu). We raise the <p->has_cpu> flag
> to indicate that p should not be considered for scheduling.
>
> In schedule(), we check after going to <still_running> whether, this call
> is based on an IPI, if so we always take this task.
>
> To be functionally correct, we also consider the reservation in
> reschedule_idle(), i.e., we first look for the reservation, then for idle
> and then cpu_curr to determine the best task.
> If indeed the decision is to "preempt" the reserving task, (actually, its
> not
> running yet), we simply lower the current reservation  has_cpu=0) and
> replace it with <p>.
>
> -- Hubertus Franke  (frankeh@us.ibm.com)
>
> diff -uwrbBN linux-2.4.5-van/kernel/sched.c linux-2.4.5-ca/kernel/sched.c
> --- linux-2.4.5-van/kernel/sched.c      Fri Apr 20 21:26:16 2001
> +++ linux-2.4.5-ca/kernel/sched.c       Tue Jul 17 07:31:10 2001
> @@ -97,12 +97,14 @@
>  static union {
>         struct schedule_data {
>                 struct task_struct * curr;
> +               struct task_struct * resched;
>                 cycles_t last_schedule;
>         } schedule_data;
>         char __pad [SMP_CACHE_BYTES];
> -} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};
> +} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0,0}}};
>
>  #define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
> +#define cpu_resched(cpu) aligned_data[(cpu)].schedule_data.resched
>  #define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
>
>  struct kernel_stat kstat;
> @@ -208,7 +210,7 @@
>  {
>  #ifdef CONFIG_SMP
>         int this_cpu = smp_processor_id();
> -       struct task_struct *tsk, *target_tsk;
> +       struct task_struct *tsk, *target_tsk, *rtsk;
>         int cpu, best_cpu, i, max_prio;
>         cycles_t oldest_idle;
>
> @@ -219,7 +221,9 @@
>         best_cpu = p->processor;
>         if (can_schedule(p, best_cpu)) {
>                 tsk = idle_task(best_cpu);
> -               if (cpu_curr(best_cpu) == tsk) {
> +               if ((cpu_curr(best_cpu) == tsk) &&
> +                   (cpu_resched(best_cpu) == NULL))
> +               {
>                         int need_resched;
>  send_now_idle:
>                         /*
> @@ -244,13 +248,24 @@
>          */
>         oldest_idle = (cycles_t) -1;
>         target_tsk = NULL;
> +       best_cpu = 0;
>         max_prio = 1;
>
>         for (i = 0; i < smp_num_cpus; i++) {
>                 cpu = cpu_logical_map(i);
>                 if (!can_schedule(p, cpu))
>                         continue;
> +               /* first check whether there is an resched IPI
> +                * reservation for that cpu. If so consider priority
> +                * of the reservation instead of current.
> +                * We do not have to set the need_resched flag again
> +                * for the currently running task. It must have been
> +                * signalled before
> +                */
> +               tsk = cpu_resched(cpu);
> +               if (tsk == NULL)
>                 tsk = cpu_curr(cpu);
> +
>                 /*
>                  * We use the first available idle CPU. This creates
>                  * a priority list between idle CPUs, but this is not
> @@ -268,19 +283,30 @@
>                                 if (prio > max_prio) {
>                                         max_prio = prio;
>                                         target_tsk = tsk;
> +                                       best_cpu = cpu;
>                                 }
>                         }
>                 }
>         }
>         tsk = target_tsk;
>         if (tsk) {
> +               rtsk = cpu_resched(best_cpu);
> +               if (rtsk) {
> +                       rtsk->has_cpu = 0; /* return rtsk to scheduable */
> +                       tsk->has_cpu  = 1; /* can't schedule this one no
> more*/ +                       cpu_resched(best_cpu) = tsk;
> +                       return;
> +               }
>                 if (oldest_idle != -1ULL) {
>                         best_cpu = tsk->processor;
>                         goto send_now_idle;
>                 }
>                 tsk->need_resched = 1;
> -               if (tsk->processor != this_cpu)
> -                       smp_send_reschedule(tsk->processor);
> +               if (tsk->processor != this_cpu) {
> +                       tsk->has_cpu  = 1;
> +                       cpu_resched(best_cpu) = tsk;
> +                       smp_send_reschedule(best_cpu);
> +               }
>         }
>         return;
>
> @@ -578,6 +604,15 @@
>          */
>
>  repeat_schedule:
> +       /* we check whether we have a resched_IPI reservation:
> +        * if so simply select the reserving task and next and
> +        * go to switch to it.
> +        */
> +       next = cpu_resched(this_cpu);
> +       if (next) {
> +               next = p;
> +               goto found_next;
> +       }
>         /*
>          * Default process to select..
>          */
> @@ -604,6 +639,7 @@
>          * switching to the next task, save this fact in
>          * sched_data.
>          */
> +found_next:
>         sched_data->curr = next;
>  #ifdef CONFIG_SMP
>         next->has_cpu = 1;
>
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/lse-tech

--------------682E429C9884B5414AFC4670
Content-Type: text/plain; charset=us-ascii;
 name="cpuaff-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuaff-patch"

diff -uwrbBN linux-2.4.5-van/kernel/sched.c linux-2.4.5-ca/kernel/sched.c
--- linux-2.4.5-van/kernel/sched.c	Fri Apr 20 21:26:16 2001
+++ linux-2.4.5-ca/kernel/sched.c	Tue Jul 17 07:31:10 2001
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
 		
@@ -578,6 +604,15 @@
 	 */
 
 repeat_schedule:
+	/* we check whether we have a resched_IPI reservation:
+	 * if so simply select the reserving task and next and
+	 * go to switch to it.
+	 */
+	next = cpu_resched(this_cpu);
+	if (next) {
+		next = p;
+		goto found_next;
+	}
 	/*
 	 * Default process to select..
 	 */
@@ -604,6 +639,7 @@
 	 * switching to the next task, save this fact in
 	 * sched_data.
 	 */
+found_next:
 	sched_data->curr = next;
 #ifdef CONFIG_SMP
  	next->has_cpu = 1;

--------------682E429C9884B5414AFC4670--

