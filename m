Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132720AbRDDAP2>; Tue, 3 Apr 2001 20:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132719AbRDDAPU>; Tue, 3 Apr 2001 20:15:20 -0400
Received: from chromium11.wia.com ([207.66.214.139]:25360 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S132720AbRDDAPK>; Tue, 3 Apr 2001 20:15:10 -0400
Message-ID: <3ACA683A.89D24DED@chromium.com>
Date: Tue, 03 Apr 2001 17:18:03 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <mkravetz@sequent.com>
CC: Ingo Molnar <mingo@elte.hu>, frankeh@us.ibm.com,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: a quest for a better scheduler
In-Reply-To: <20010403121308.A1054@w-mikek2.sequent.com> <Pine.LNX.4.30.0104032024290.9285-100000@elte.hu> <20010403154314.E1054@w-mikek2.sequent.com>
Content-Type: multipart/mixed;
 boundary="------------B46085350AE53D8B14855445"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B46085350AE53D8B14855445
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dear all,

I've spent my afternoon running some benchmarks to see if MQ patches would
degrade performance in the "normal case".

To measure performance I've used the latest lmbench and I have mesured the
kernel compile times on a dual pentium III box runing at 1GHz with an 133MHz
bus.

Results (attached) show that there is no measurable difference in performace
between a vanilla scheduler and a multiqueue scheduler when running only few
processes (the compilation benchmark runs essentially two processes, one per
CPU).

I have measured the HP and not the "scalability" patch because the two do more
or less the same thing and give me the same performance advantages, but the
former is a lot simpler and I could port it with no effort on any recent
kernel. It is indeed interesting to see that this patch was originally designed
for a 2.4.0-test10 kernel, and still works fine on the latest kernels, only a
minor change (one line) was required. A version of the patch for the 2.4.2-ac26
kernel is attached to this message.

Given the zero impact on "normal case" performance and the huge positive impact
(> 20%) in the heavy load case (70-80 runnable processess on a load of about
1400 total) I don't see why such a thing shouldn't be accepted in the
mainstream scheduler.

 - Fabio


--------------B46085350AE53D8B14855445
Content-Type: text/plain; charset=us-ascii;
 name="mqpatch242ac26"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mqpatch242ac26"

--- sched.c.orig	Tue Mar 27 17:30:58 2001
+++ sched.c	Tue Apr  3 16:45:21 2001
@@ -34,6 +34,7 @@
 extern void timer_bh(void);
 extern void tqueue_bh(void);
 extern void immediate_bh(void);
+static inline void hop_queues(struct task_struct *, int);
 
 /*
  * scheduler variables
@@ -90,7 +91,8 @@
 spinlock_t runqueue_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;  /* inner */
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;	/* outer */
 
-static LIST_HEAD(runqueue_head);
+static struct list_head runqueue_head[NR_CPUS] = { LIST_HEAD_INIT((runqueue_head[0]))};
+static LIST_HEAD(rt_queue_head);
 
 /*
  * We align per-CPU scheduling data on cacheline boundaries,
@@ -100,12 +102,15 @@
 	struct schedule_data {
 		struct task_struct * curr;
 		cycles_t last_schedule;
+		struct list_head runqueue_head;
 	} schedule_data;
 	char __pad [SMP_CACHE_BYTES];
-} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};
+} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0,
+	LIST_HEAD_INIT((aligned_data[0].schedule_data.runqueue_head))}}};
 
 #define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
 #define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
+#define cpu_rq(cpu) (aligned_data[(cpu)].schedule_data.runqueue_head)
 
 struct kernel_stat kstat;
 
@@ -199,6 +204,33 @@
 	return goodness(p, cpu, prev->active_mm) - goodness(prev, cpu, prev->active_mm);
 }
 
+
+static inline int other_goodness(struct task_struct * p, int this_cpu, struct mm_struct *this_mm)
+{
+	int weight;
+
+	/*
+	 * select the current process after every other
+	 * runnable process, but before the idle thread.
+	 * Also, dont trigger a counter recalculation.
+	 * 
+	 * Give the process a first-approximation goodness value
+	 * according to the number of clock-ticks it has left.
+	 *
+	 * Don't do any other calculations if the time slice is
+	 * over..
+	 */
+	weight = p->counter;
+	if (!weight)
+		goto out2;
+			
+	/* .. and a slight advantage to the current MM */
+	if (p->mm == this_mm || !p->mm)
+		weight += 1;
+	weight += 20 - p->nice;
+out2:
+	return weight;
+}
 /*
  * This is ugly, but reschedule_idle() is very timing-critical.
  * We are called with the runqueue spinlock held and we must
@@ -266,6 +298,10 @@
 		} else {
 			if (oldest_idle == -1ULL) {
 				int prio = preemption_goodness(tsk, p, cpu);
+				/* 
+				 * this will never be true for < 400 HZ non
+				 * realtime. optimize this?  SAR
+				 */
 
 				if (prio > max_prio) {
 					max_prio = prio;
@@ -277,6 +313,10 @@
 	tsk = target_tsk;
 	if (tsk) {
 		if (oldest_idle != -1ULL) {
+			/* push onto best queue */
+			if (p->policy == SCHED_OTHER){
+				hop_queues(p, tsk->processor);
+			}
 			best_cpu = tsk->processor;
 			goto send_now_idle;
 		}
@@ -306,20 +346,28 @@
  */
 static inline void add_to_runqueue(struct task_struct * p)
 {
-	list_add(&p->run_list, &runqueue_head);
+	if (p->policy == SCHED_OTHER){
+		list_add(&p->run_list, &cpu_rq(p->processor));
+	} else  list_add(&p->run_list, &rt_queue_head);
 	nr_running++;
 }
 
-static inline void move_last_runqueue(struct task_struct * p)
+static inline void move_last_rt_queue(struct task_struct * p)
+{
+	list_del(&p->run_list);
+	list_add_tail(&p->run_list, &rt_queue_head);
+}
+
+static inline void move_first_rt_queue(struct task_struct * p)
 {
 	list_del(&p->run_list);
-	list_add_tail(&p->run_list, &runqueue_head);
+	list_add(&p->run_list, &rt_queue_head);
 }
 
-static inline void move_first_runqueue(struct task_struct * p)
+static inline void hop_queues(struct task_struct * p, int this_cpu)
 {
 	list_del(&p->run_list);
-	list_add(&p->run_list, &runqueue_head);
+	list_add(&p->run_list, &cpu_rq(this_cpu));
 }
 
 /*
@@ -343,6 +391,7 @@
 	if (task_on_runqueue(p))
 		goto out;
 	add_to_runqueue(p);
+ 	/* LATER : make an effort to choose rq before add ? */
 	if (!synchronous || !(p->cpus_allowed & (1 << smp_processor_id())))
 		reschedule_idle(p);
 	success = 1;
@@ -531,9 +580,9 @@
 asmlinkage void schedule(void)
 {
 	struct schedule_data * sched_data;
-	struct task_struct *prev, *next, *p;
+	struct task_struct *prev, *next, *p = NULL; /* LATER fix this */
 	struct list_head *tmp;
-	int this_cpu, c;
+	int this_cpu, c, i;
 
 
 	spin_lock_prefetch(&runqueue_lock);
@@ -592,18 +641,63 @@
 		goto still_running;
 
 still_running_back:
-	list_for_each(tmp, &runqueue_head) {
+	/* 
+	 * we unrolled the original combined runqueue in to two separate
+	 * checks, first the real time and then then policy OTHER for own
+	 * cpu, and finally theft from another cpu.
+	 */
+	list_for_each(tmp, &rt_queue_head) {
 		p = list_entry(tmp, struct task_struct, run_list);
-		if (can_schedule(p, this_cpu)) {
-			int weight = goodness(p, this_cpu, prev->active_mm);
+		if (can_schedule(p, this_cpu) && !(p->policy & SCHED_YIELD)) {
+			int weight = 1000 + p->rt_priority;
 			if (weight > c)
 				c = weight, next = p;
 		}
 	}
 
+	if (c >= 1000)
+		goto choice_made;
+
+	list_for_each(tmp, &cpu_rq(this_cpu)) {
+		p = list_entry(tmp, struct task_struct, run_list);
+		if (can_schedule(p, this_cpu) && !(p->policy & SCHED_YIELD)) {
+			int weight = other_goodness(p, this_cpu, prev->active_mm);
+			if (weight > c)
+				c = weight, next = p;
+		}
+	}
+
+#ifdef CONFIG_SMP
+	if (c > 0)
+		goto choice_made;
+
+	/* 
+	 * try to steal from another CPU's queue.  since we don't have to 
+	 * worry about real time or CPU preference, pick anything available.
+	 * this is an area for detailed policy.
+	 */
+	for (i = 0; i < smp_num_cpus; i++) {
+		int cpu = cpu_logical_map(i);
+		if (cpu == this_cpu) 
+			continue;
+
+		list_for_each(tmp, &cpu_rq(cpu)) {
+                	p = list_entry(tmp, struct task_struct, run_list);
+                	if (can_schedule(p, this_cpu) && !(p->policy & SCHED_YIELD)) {
+                        	int weight = other_goodness(p, cpu, prev->active_mm);
+                        	if (weight > c)
+                                	c = weight, next = p;
+                	}
+        	}
+	}
+
+	if (c > 0)
+		hop_queues(next, this_cpu); /* pull onto mine */
+#endif
 	/* Do we need to re-calculate counters? */
 	if (!c)
 		goto recalculate;
+choice_made:
 	/*
 	 * from this point on nothing can prevent us from
 	 * switching to the next task, save this fact in
@@ -705,7 +799,7 @@
 move_rr_last:
 	if (!prev->counter) {
 		prev->counter = NICE_TO_TICKS(prev->nice);
-		move_last_runqueue(prev);
+		move_last_rt_queue(prev);
 	}
 	goto move_rr_back;
 
@@ -938,8 +1032,14 @@
 	retval = 0;
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
-	if (task_on_runqueue(p))
-		move_first_runqueue(p);
+	if (task_on_runqueue(p)){
+		if (policy != SCHED_OTHER)
+			move_first_rt_queue(p);
+		else {
+			/* push onto appropriate non-rt queue */
+			hop_queues(p, p->processor);
+		}
+	}
 
 	current->need_resched = 1;
 
@@ -1251,9 +1351,12 @@
 	 * process right in SMP mode.
 	 */
 	int cpu = smp_processor_id();
-	int nr;
+	int nr, i;
 
 	init_task.processor = cpu;
+	for (i=1; i<NR_CPUS; i++){
+		INIT_LIST_HEAD(&cpu_rq(i));
+	}
 
 	for(nr = 0; nr < PIDHASH_SZ; nr++)
 		pidhash[nr] = NULL;

--------------B46085350AE53D8B14855445
Content-Type: text/plain; charset=us-ascii;
 name="compile_times"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compile_times"

Kernel compilation times
========================

three runs of "time make -j2"

--

Linux 2.4.2-ac26 + HP Multiqueue patch

216.34user 14.36system 2:00.03elapsed 192%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (482269major+691020minor)pagefaults 0swaps

216.53user 14.23system 1:57.91elapsed 195%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (482269major+691020minor)pagefaults 0swaps

217.65user 13.46system 1:58.05elapsed 195%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (482269major+691020minor)pagefaults 0swaps

--

Linux 2.4.2-ac26

220.07user 14.88system 2:02.67elapsed 191%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (482269major+691019minor)pagefaults 0swaps

220.31user 14.90system 2:00.64elapsed 194%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (482269major+691018minor)pagefaults 0swaps

220.58user 14.84system 2:00.57elapsed 195%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (482269major+691018minor)pagefaults 0swaps


LMBENCH-2BETA1
==============

First two: Linux 2.4.2-ac26 + HP Multiqueue patch

Second Two: Linux 2.4.2-ac26

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
skinny    Linux 2.4.2-a  997 0.34 0.56 3.96 5.04    27 0.89 2.72  245 1128 4044
skinny    Linux 2.4.2-a  997 0.34 0.57 4.19 5.32    25 0.89 2.71  247 1150 4067
skinny    Linux 2.4.2-a  997 0.34 0.58 3.90 5.00    25 0.89 2.69  249 1121 3968
skinny    Linux 2.4.2-a  997 0.34 0.57 3.90 5.01    25 0.87 2.70  246 1126 4018

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
skinny    Linux 2.4.2-a 1.820 4.7700     12 8.0800    109      27     110
skinny    Linux 2.4.2-a 1.890 4.7300     20 6.6500    109      27     110
skinny    Linux 2.4.2-a 1.620 4.5900     12 6.7000    109      24     109
skinny    Linux 2.4.2-a 1.700 4.6400     12 7.0600    109      26     109

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
skinny    Linux 2.4.2-a 1.820 7.390   15    16    52    23    91   55
skinny    Linux 2.4.2-a 1.890 7.185   14    16    41    23    56   54
skinny    Linux 2.4.2-a 1.620 6.793   15    16    40    21    56   54
skinny    Linux 2.4.2-a 1.700 6.801   15    16    40    21    55   54

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
skinny    Linux 2.4.2-a 6.2054 0.7192     12 1.6973      451 0.672 2.00000
skinny    Linux 2.4.2-a 6.2469 0.7360     12 1.7142      465 0.668 2.00000
skinny    Linux 2.4.2-a 3.1992 0.7182     12 1.5857      449 0.680 2.00000
skinny    Linux 2.4.2-a 6.1576 0.7119     12 1.5817      448 0.669 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
skinny    Linux 2.4.2-a  823  233  162    434    558    271    218  558   282
skinny    Linux 2.4.2-a  828  289  243    408    558    269    216  558   281
skinny    Linux 2.4.2-a  839  285  249    445    558    222    147  558   219
skinny    Linux 2.4.2-a  811  284  242    445    558    222    147  558   219

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
skinny    Linux 2.4.2-a   997 3.009 7.0230    101
skinny    Linux 2.4.2-a   997 3.010 7.0220    101
skinny    Linux 2.4.2-a   997 3.010 7.0280    101
skinny    Linux 2.4.2-a   997 3.009 7.0290    101

--------------B46085350AE53D8B14855445--

