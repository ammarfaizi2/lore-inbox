Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVHKPVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVHKPVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVHKPVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:21:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:62201 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751081AbVHKPVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:21:17 -0400
Subject: 2.6.13-rc4-mm1: Divide by zero in find_idlest_group
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 10:21:14 -0500
Message-Id: <1123773675.9252.11.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encounted this trap on a 2-way i386 box running 2.6.13-rc4-mm1:

[70347.743727] divide error: 0000 [#2]
[70347.752979] PREEMPT SMP DEBUG_PAGEALLOC
[70347.773060] last sysfs file: /devices/pnp0/00:11/id

Program received signal SIGTRAP, Trace/breakpoint trap.
0xc0119556 in find_idlest_group (sd=0xc1084dc0, p=0xc3b96030, this_cpu=0)
    at sched.c:1033
1033                    target_load = target_load * rq->prio_bias / rq->nr_running;

(gdb) where
#0  0xc0119556 in find_idlest_group (sd=0xc1084dc0, p=0xc3b96030, this_cpu=0)
    at sched.c:1033
#1  0xc0119744 in sched_balance_self (cpu=0, flag=4) at sched.c:1151
#2  0xc011a63f in sched_exec () at sched.c:1840
#3  0xc016cacb in do_execve (filename=0xc3e35000 "/bin/sh", argv=0xbfff512c,
    envp=0xbfff6010, regs=0xa00) at exec.c:1162
#4  0xc0101b5a in sys_execve (regs=
      {ebx = -1208173323, ecx = -1073786580, edx = -1073782768, esi = -1073782768, edi = -1208107392, ebp = -1073786620, eax = 11, xds = 123, xes = -1072693125, orig_eax = 11, eip = -1208664822, xcs = 115, eflags = 658, esp = -1073786628, xss = 123}) at process.c:787
#5  0xc0102fdd in syscall_call () at current.h:9
#6  0xb7fcbcf5 in ?? ()

print *(struct runqueue *)0xc108c400
$1 = {lock = {raw_lock = {slock = 1}, break_lock = 0}, nr_running = 0,
  prio_bias = 0, cpu_load = {0, 0, 0}, nr_switches = 8877527,
  nr_uninterruptible = 132930, expired_timestamp = 0,
  timestamp_last_tick = 70347783539837, curr = 0xc1103550, idle = 0xc1103550,
  prev_mm = 0x0, active = 0xc108c8c0, expired = 0xc108c448, arrays = {{
      nr_active = 0, bitmap = {0, 0, 0, 0, 4096}, queue = {{next = 0xc108c460,
          prev = 0xc108c460}, {next = 0xc108c468, prev = 0xc108c468}, {
          next = 0xc108c470, prev = 0xc108c470}, {next = 0xc108c478,
          prev = 0xc108c478}, {next = 0xc108c480, prev = 0xc108c480}, {
          next = 0xc108c488, prev = 0xc108c488}, {next = 0xc108c490,

in __source_load, it looks like rq_nr_running must have changed between
the if statement and the divide:

        if (rq->nr_running > 1 || (idle == NOT_IDLE && rq->nr_running))
                /*
                 * If we are busy rebalancing the load is biased by
                 * priority to create 'nice' support across cpus. When
                 * idle rebalancing we should only bias the source_load if
                 * there is more than one task running on that queue to
                 * prevent idle rebalance from trying to pull tasks from a
                 * queue with only one running task.
                 */
                source_load = source_load * rq->prio_bias / rq->nr_running;

Should there be any locking around this?  Or should the value of
rq->nr_running be saved to a local variable as in this untested patch?

diff -urp linux-2.6.13-rc5-mm1/kernel/sched.c linux/kernel/sched.c
--- linux-2.6.13-rc5-mm1/kernel/sched.c	2005-08-11 09:41:30.000000000 -0500
+++ linux/kernel/sched.c	2005-08-11 09:47:27.000000000 -0500
@@ -989,15 +989,16 @@ void kick_process(task_t *p)
 static inline unsigned long __source_load(int cpu, int type, enum idle_type idle)
 {
 	runqueue_t *rq = cpu_rq(cpu);
+	unsigned long running = rq->nr_running;
 	unsigned long source_load, cpu_load = rq->cpu_load[type-1],
-		load_now = rq->nr_running * SCHED_LOAD_SCALE;
+		load_now = running * SCHED_LOAD_SCALE;
 
 	if (type == 0)
 		source_load = load_now;
 	else
 		source_load = min(cpu_load, load_now);
 
-	if (rq->nr_running > 1 || (idle == NOT_IDLE && rq->nr_running))
+	if (running > 1 || (idle == NOT_IDLE && running))
 		/*
 		 * If we are busy rebalancing the load is biased by
 		 * priority to create 'nice' support across cpus. When
@@ -1006,7 +1007,7 @@ static inline unsigned long __source_loa
 		 * prevent idle rebalance from trying to pull tasks from a
 		 * queue with only one running task.
 		 */
-		source_load = source_load * rq->prio_bias / rq->nr_running;
+		source_load = source_load * rq->prio_bias / running;
 
 	return source_load;
 }
@@ -1022,16 +1023,17 @@ static inline unsigned long source_load(
 static inline unsigned long __target_load(int cpu, int type, enum idle_type idle)
 {
 	runqueue_t *rq = cpu_rq(cpu);
+	unsigned long running = rq->nr_running;
 	unsigned long target_load, cpu_load = rq->cpu_load[type-1],
-		load_now = rq->nr_running * SCHED_LOAD_SCALE;
+		load_now = running * SCHED_LOAD_SCALE;
 
 	if (type == 0)
 		target_load = load_now;
 	else
 		target_load = max(cpu_load, load_now);
 
-	if (rq->nr_running > 1 || (idle == NOT_IDLE && rq->nr_running))
-		target_load = target_load * rq->prio_bias / rq->nr_running;
+	if (running > 1 || (idle == NOT_IDLE && running))
+		target_load = target_load * rq->prio_bias / running;
 
 	return target_load;
 }

-- 
David Kleikamp
IBM Linux Technology Center

