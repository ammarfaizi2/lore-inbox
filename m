Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbRGSO04>; Thu, 19 Jul 2001 10:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267570AbRGSO0r>; Thu, 19 Jul 2001 10:26:47 -0400
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:57380 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S267569AbRGSO0c>; Thu, 19 Jul 2001 10:26:32 -0400
Message-ID: <3B56EDBC.39A7ECB@watson.ibm.com>
Date: Thu, 19 Jul 2001 10:25:00 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davidel@ewok.dev.mcafeelabs.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency (updated patch)
In-Reply-To: <OF67655A11.398205F1-ON85256A8E.004D7BD7@pok.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------723D2898115BD0BF7AF1B265"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------723D2898115BD0BF7AF1B265
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


David, thanks for talking this through. I attach the latest patch that
I think corrects the problems identified earlier and should serve as the base
discussion for our discussion.


> Sent by:  davidel@ewok.dev.mcafeelabs.com
>
> To:   Hubertus Franke/Watson/IBM@IBMUS
> cc:   mkravetz@sequent.com, ak@suse.de
> Subject:  Re: [Lse-tech] Re: CPU affinity & IPI latency (FIX)_
>
> On 18-Jul-2001 Hubertus Franke wrote:
> >
> > The only reason one might want to put it outside is to force a shorter
> > schedule function, as this one only takes cpu_schedule(cpu) rather
> > then running the whole list.
> > I moved it inside the function.
>
> Maybe we're talking about two different things :)
> What's the line number you refer to ?

I am talking about this line in the fast track of reschedule_idle().
The current thing that we seem to agree on is
this (and that's in the atached whole patch)

@@ -229,8 +233,11 @@
                         */
                        need_resched = tsk->need_resched;
                        tsk->need_resched = 1;
-                       if ((best_cpu != this_cpu) && !need_resched)
+                       if ((best_cpu != this_cpu) && !need_resched) {
+                               p->has_cpu = 1;
+                               cpu_resched(best_cpu) = p;
                                smp_send_reschedule(best_cpu);
+                       }
                        return;
                }
        }

What could be done is the following. If we haven't
issued a need_resched event yet, then lock down <p>
to the best_cpu and if necessary issue an IPI.
This would ensure due to the fast check in schedule()
that we wouldn't run through the whole list in this
particular case either.

@@ -229,8 +233,11 @@
                         */
                        need_resched = tsk->need_resched;
                        tsk->need_resched = 1;
-                       if ((best_cpu != this_cpu) && !need_resched)
+                       if (!need_resched) {
+                               p->has_cpu = 1;
+                               cpu_resched(best_cpu) = p;
+                               if (best_cpu != this_cpu)
                                          smp_send_reschedule(best_cpu);
+                       }
                        return;
                }
        }

>
> >
> > In general is this something we should push for in the kernel scheduler
> > or should your quote be taken as the remedy for this problem ?
> > "If You want to have a better reschedule latency use the poll idle."
>
> The poll idle is power expensive but it has a better latency.
> Right now is boot command line settable.
>
> - Davide

I know, my question was, whether you think this whole discussion is useless
because somebody can always switch over to poll and should do so if he/she
has a problem with the current implementation ?

Also somebody contacted me with concerns to hot-plug cpus. Not a problem
One merely needs to do something  like this before yanking the cpu.

if (cpu_resched(yankcpu)) {
        cpu_resched(yankcpu)->has_cpu = 0;
        cpu_resched(yankcpu) = NULL;
}

and the temp-bound   task is free to be scheduable from anywhere else again.

-- Hubertus Franke
(frankeh@us.ibm.com)



--------------723D2898115BD0BF7AF1B265
Content-Type: text/plain; charset=us-ascii;
 name="cpuaff-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuaff-patch"

diff -uwrbBN linux-2.4.5-van/Makefile linux-2.4.5-ca/Makefile
--- linux-2.4.5-van/Makefile	Fri May 25 12:51:33 2001
+++ linux-2.4.5-ca/Makefile	Tue Jul 17 06:07:50 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 5
-EXTRAVERSION =
+EXTRAVERSION = -ca
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -uwrbBN linux-2.4.5-van/kernel/sched.c linux-2.4.5-ca/kernel/sched.c
--- linux-2.4.5-van/kernel/sched.c	Fri Apr 20 21:26:16 2001
+++ linux-2.4.5-ca/kernel/sched.c	Wed Jul 18 17:01:36 2001
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
@@ -229,8 +233,11 @@
 			 */
 			need_resched = tsk->need_resched;
 			tsk->need_resched = 1;
-			if ((best_cpu != this_cpu) && !need_resched)
+			if ((best_cpu != this_cpu) && !need_resched) {
+				p->has_cpu = 1;
+				cpu_resched(best_cpu) = p;
 				smp_send_reschedule(best_cpu);
+			}
 			return;
 		}
 	}
@@ -244,13 +251,24 @@
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
@@ -268,19 +286,30 @@
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
+			p->has_cpu  = 1; /* can't schedule this one no more*/
+			cpu_resched(best_cpu) = p;
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
+			p->has_cpu  = 1; 
+			cpu_resched(best_cpu) = p;
+			smp_send_reschedule(best_cpu);
+		}
 	}
 	return;
 		
@@ -578,6 +607,15 @@
 	 */
 
 repeat_schedule:
+	/* we check whether we have a resched_IPI reservation:
+	 * if so simply select the reserving task and next and
+	 * go to switch to it.
+	 */
+	next = cpu_resched(this_cpu);
+	if (next) {
+		cpu_resched(this_cpu) = NULL;
+		goto found_next;
+	}
 	/*
 	 * Default process to select..
 	 */
@@ -604,6 +642,7 @@
 	 * switching to the next task, save this fact in
 	 * sched_data.
 	 */
+found_next:
 	sched_data->curr = next;
 #ifdef CONFIG_SMP
  	next->has_cpu = 1;

--------------723D2898115BD0BF7AF1B265--

