Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWFOMJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWFOMJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWFOMJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:09:33 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:62167 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030287AbWFOMJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:09:33 -0400
Date: Thu, 15 Jun 2006 20:09:31 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] posix cpu timers fixes
Message-ID: <20060615160931.GA21450@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stultz hit run_posix_cpu_timers()->BUG_ON(tsk->exit_state), see

	http://marc.theaimsgroup.com/?l=linux-kernel&m=115015841413687

This was fixed by

	Commit 3de463c7d9d58f8cf3395268230cb20a4c15bffa
	[PATCH] posix-timers: remove false BUG_ON() from run_posix_cpu_timers()
	(now re-sended as [PATCH 2/3])

but it was reverted because it triggered a problem,

Chris Wright wrote: // Message-ID: <20051026232112.GJ5856@shell0.pdx.osdl.net>
>
> I'm still getting lockups with current kernel.  Let this run for a
> bit, then ^C is typically all it takes.  Haven't looked any closer to
> see what's the cause.  Looks like deadlock with irq's off, maybe in
> settime vs. run_posix_cpu_timers.
> 
> #include <errno.h>
> #include <stdio.h>
> #include <signal.h>
> #include <string.h>
> #include <stdlib.h>
> #include <stdarg.h>
> #include <unistd.h>
> #include <sys/time.h>
> #include <sys/mman.h>
> #include <sched.h>
> #include <pthread.h>
> #include <linux/unistd.h>
> 
> #define CPUCLOCK_PERTHREAD_MASK 4
> 
> #define MAKE_PROCESS_CPUCLOCK(pid, clock) \
> 	((~(clockid_t) (pid) << 3) | (clockid_t) (clock))
> 
> #define MAKE_THREAD_CPUCLOCK(tid, clock) \
> 	MAKE_PROCESS_CPUCLOCK((tid), (clock) | CPUCLOCK_PERTHREAD_MASK)
> 
> /* get glibc out of the way */
> static inline int _timer_create(clockid_t c, struct sigevent *e, timer_t *t)
> {
> 	return syscall(__NR_timer_create, c, e, t);
> }
> static inline int _timer_settime(timer_t t, int f, struct itimerspec *i, struct itimerspec *o)
> {
> 	return syscall(__NR_timer_settime, t, f, i, o);
> }
> 
> int do_thread(void *data)
> {
> 	struct sigevent sigev = {.sigev_signo = SIGRTMIN,
> 				 .sigev_notify = SIGEV_SIGNAL};
> 	struct itimerspec itsp = {.it_value.tv_nsec = 1,
> 				  .it_interval.tv_nsec = 1};
> 	timer_t tid;
> 	clockid_t clock = MAKE_PROCESS_CPUCLOCK(getpid(), 0);
> 
> 	if (_timer_create(clock, &sigev, &tid) == -1) {
> 		perror("timer_create");
> 		syscall(__NR_exit, 1);
> 	}
> 
> 	if (_timer_settime(tid, 0, &itsp, NULL)) {
> 		perror("timer_settime");
> 		syscall(__NR_exit, 1);
> 	}
> 	pause();
> 	syscall(__NR_exit, 0);
> }
> 
> int main(int argc, char *argv[])
> {
> 	int max=(int)(~0U>>1), i=0;
> 	struct sigaction sa = { .sa_handler = SIG_IGN};
> 	sigaction(SIGRTMIN, &sa, NULL);
> 
> 	if (argc > 1)
> 		max = strtoul(argv[1], NULL, 0);
> 
> 	for (i=0; i<max; i++) {
> 		pid_t tid;
> 		size_t len = getpagesize();
> 		void *addr = mmap(NULL, len, PROT_READ|PROT_WRITE,
> 			    MAP_PRIVATE|MAP_ANONYMOUS|MAP_GROWSDOWN, -1, 0);
> 		if (addr == MAP_FAILED) {
> 			perror("mmap");
> 			break;
> 		}
> 		addr = (void *)((unsigned long)addr + len);
> 		tid = clone(do_thread, addr, 
> 			    SIGCHLD|CLONE_VM|CLONE_SIGHAND|CLONE_FILES|CLONE_THREAD,
> 			    NULL);
> 		if (tid == -1) {
> 			perror("clone");
> 			break;
> 		}
> 	}
> 	printf("maxed %d threads, spinning...\n", i);
> 	/* eat cpu */
> 	while(1);
> }

The reason of this lockup is another bug in check_process_timers(),
it may enter an endless loop with ->siglock held, this explains a
trace seen by Chris:

> [  385.918035] Call Trace: <IRQ> <ffffffff804951c9>{_spin_lock+9} <ffffffff8014eaa4>{arm_timer+116}
> [  385.927052]        <ffffffff8014edc9>{posix_cpu_timer_schedule+265} <ffffffff8014ee39>{cpu_timer_fire+89}
> [  385.936854]        <ffffffff8014fa61>{run_posix_cpu_timers+1761} <ffffffff8014074d>{update_process_times+2}
> [  385.947008]        <ffffffff80119c67>{smp_local_timer_interrupt+183} <ffffffff80119cb9>{smp_apic_timer_int}
> [  385.957790]        <ffffffff8010e9d4>{apic_timer_interrupt+132}  <EOI> <ffffffff8049532b>{_spin_unlock_irq}
> [  385.968051]        <ffffffff80143e41>{get_signal_to_deliver+1361} <ffffffff8010d07d>{do_signal+125}
> [  385.977321]        <ffffffff80133ff4>{__put_task_struct+260} <ffffffff80493c50>{thread_return+160}
> [  385.986499]        <ffffffff8014c632>{sys_timer_settime+562} <ffffffff8010dd07>{sysret_signal+28}
> [  385.995596]        <ffffffff8010d7e0>{do_notify_resume+48} <ffffffff8010dfef>{ptregscall_common+103}

This bug is fixed by [PATCH 1/3].

With these patches applied Chris's program exits without any problems.

John, could you please try these patches while you are testing posix
cpu timers?

Oleg.

