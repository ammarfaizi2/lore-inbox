Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSCYCBt>; Sun, 24 Mar 2002 21:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311879AbSCYCBk>; Sun, 24 Mar 2002 21:01:40 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51975 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311564AbSCYCBX>; Sun, 24 Mar 2002 21:01:23 -0500
Message-ID: <3C9E8497.9355C462@zip.com.au>
Date: Sun, 24 Mar 2002 17:59:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: preempt-related hangs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this email to Ingo last week; seems that he's
having some downtime.  It was happening on my dual PIII
and I now discover that the quad pIII does the same
thing.  Any ideas?



Kernel is 2.5.7, dual PIII.  When I enable preempt it
locks during boot.

I applied the kgdb patch and had a poke.

(gdb) info threads
* 6 Thread 6  preempt_schedule () at sched.c:848
  5 Thread 5  preempt_schedule () at sched.c:848
  4 Thread 4  context_thread (startup=0xc0395f90) at context.c:101
  3 Thread 3  migration_thread (unused=0x0) at sched.c:1646
  2 Thread 2  migration_thread (unused=0x0) at sched.c:1646
  1 Thread 1  spawn_ksoftirqd () at softirq.c:407

Note that init is stuck in spawn_ksoftirqd.  It's spinning in
that function, yielding, waiting for the softirqd threads to
come alive.  They're threads 5 and 6.

(gdb) thread 6
[Switching to thread 6 (Thread 6)]#0  preempt_schedule () at sched.c:848
848     }
(gdb) bt
#0  preempt_schedule () at sched.c:848
#1  0xc0117f77 in try_to_wake_up (p=0xefef4dc0) at sched.c:179
#2  0xc0117f8d in wake_up_process (p=0xefef68c0) at sched.c:347
#3  0xc011ad70 in set_cpus_allowed (p=0xefef68c0, new_mask=2) at sched.c:1583
#4  0xc01247fe in ksoftirqd (__bind_cpu=0x1) at softirq.c:371
#5  0xc010586b in kernel_thread (fn=0xc038aa97 <spawn_ksoftirqd+71>, arg=0x10, flags=582)
    at process.c:501
#6  0xffffffff in ?? ()


So ksoftirqd has entered set_cpus_allowed(), and has tried to wake
migration_thread.

try_to_wake_up() has called task_rq_unlock(rq, &flags); and
task_rq_unlock() has done preempt_enable().  Game over at that
point.  Looks like ksoftirqd has scheduled away on that preempt_enable
and is never coming back.

(gdb) info registers
eax            0xefef68c0       -269522752
ecx            0xc03d1540       -1069738688
edx            0x0      0
ebx            0xefed8000       -269647872
esp            0xefed9f18       0xefed9f18
...
(gdb)  p *((struct thread_info *)0xefed8000)->task
$8 = {state = 0, thread_info = 0xefed8000, usage = {counter = 1}, flags = 64, 
  ptrace = 0, lock_depth = -1, prio = 139, static_prio = 139, run_list = {
    next = 0xc03d239c, prev = 0xc03d239c}, array = 0xc03d1f2c, sleep_avg = 0, 
  sleep_timestamp = 117, policy = 0, cpus_allowed = 2, time_slice = 8, tasks = {
    next = 0xc0360580, prev = 0xefef6240}, mm = 0x0, active_mm = 0x0, local_pages = {
    next = 0xefef6910, prev = 0xefef6910}, allocation_order = 0, nr_local_pages = 0, 
  binfmt = 0x0, exit_code = 0, exit_signal = 0, pdeath_signal = 0, personality = 0, 
  did_exec = 0, pid = 6, pgrp = 1, tty_old_pgrp = 0, session = 1, tgid = 0, leader = 0, 
  real_parent = 0xefef4700, parent = 0xefef4700, children = {next = 0xefef6958, 
    prev = 0xefef6958}, sibling = {next = 0xefef4798, prev = 0xefef62a0}, 
  thread_group = {next = 0xefef62a8, prev = 0xefef47a8}, pidhash_next = 0x0, 
  pidhash_pprev = 0xc03e4d98, wait_chldexit = {lock = {lock = 1, magic = 3735899821}, 
    task_list = {next = 0xefef6980, prev = 0xefef6980}}, vfork_done = 0x0, 
  rt_priority = 0, it_real_value = 0, it_prof_value = 0, it_virt_value = 0, 
  it_real_incr = 0, it_prof_incr = 0, it_virt_incr = 0, real_timer = {list = {
      next = 0x0, prev = 0x0}, expires = 0, data = 4025444544, 
    function = 0xc0123548 <it_real_fn>}, times = {tms_utime = 0, tms_stime = 0, 
    tms_cutime = 0, tms_cstime = 0}, start_time = 116, per_cpu_utime = {
    0 <repeats 32 times>}, per_cpu_stime = {0 <repeats 32 times>}, min_flt = 0, 
  maj_flt = 0, nswap = 0, cmin_flt = 0, cmaj_flt = 0, cnswap = 0, swappable = -1, 
  uid = 0, euid = 0, suid = 0, fsuid = 0, gid = 0, egid = 0, sgid = 0, fsgid = 0, 
  ngroups = 0, groups = {0 <repeats 32 times>}, cap_effective = 4294967039, 
  cap_inheritable = 0, cap_permitted = 4294967295, keep_capabilities = 0, 
  user = 0xc0363a8c, rlim = {{rlim_cur = 4294967295, rlim_max = 4294967295}, {
...

It's in state TASK_RUNNING.

It's 100% reproducible.  Happens with gcc-2.91.66 and gcc-3.0.3.
Can diagnose further if needed.

-
