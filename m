Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUEWIzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUEWIzl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 04:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUEWIzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 04:55:40 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:50333 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262391AbUEWIzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 04:55:25 -0400
Message-ID: <40B066EC.1010107@yahoo.com.au>
Date: Sun, 23 May 2004 18:55:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Gergely Czuczy <phoemix@harmless.hu>
CC: linux-kernel@vger.kernel.org, itk-sysadm@ppke.hu
Subject: Re: Linux 2.4 VS 2.6 fork VS thread creation time test
References: <Pine.LNX.4.60.0405230914330.15840@localhost>
In-Reply-To: <Pine.LNX.4.60.0405230914330.15840@localhost>
Content-Type: multipart/mixed;
 boundary="------------020807030405050804060606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020807030405050804060606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Gergely Czuczy wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello everyone,
> 
> Today morning I've made a test about the thead and child process
> creation(fork) time on both 2.4 and 2.6 kernels.
> 
> The test systems
> ================
> 
> Box A:
>  - kernel: Linux 2.4.22-xfs
>  - CPU: Intel P3-700 MHz (slot1)
>  - Ram: 384MB SDR SDRAM
> 
> Box B:
>  - kernel: Linux 2.6.6-mm5
>  - CPU: Intel P4-2.6Ghz
>  - Ram: 512 DDR SDRAM
> 
> Box B is a lot better, but it doesn't metter according to the test,
> because the aim was to get the ratio of the two times with different
> sample rates.
> 

Even so, you really should be using the same system if you want
comparable results. The pentium 4 in particular can do worse at
specific things in microbenchmarks.

Your problem with not being able large numbers of threads and
processes could be ulimits or sysctl limits. Look at ulimit
and /proc/sys/kernel/threads-max and pid_max.

[ snip numbers ]

> Conlusion
> =========
> 
> It's easy to notice that in case of 2.4 the ratios of the creation times
> are converges to 1, so it depends on the load, while in case of a 2.6
> kernel the ratios are mostly fix, about 9. This means that creating a new
> child process takes much more time than creating a new thread.
> 

I tried your code on a P3-1000. 2.4.23 is not 100% comparable because it
was built with an old compiler and possibly different options.

Anyway, results with 256 samples were as follows:
processes			256
2.4.23:
Total fork time: 		48.224 msecs
Total thread time: 		30.180 msecs
Total fork/thread ratio: 	 1.598

2.6.6-mm5:
Total fork time: 		40.795 msecs
Total thread time: 		17.615 msecs
Total fork/thread ratio: 	 2.316

2.6.6-mm5+child-runs-last:
Total fork time: 		16.080 msecs
Total thread time: 		 8.600 msecs
Total fork/thread ratio: 	 1.870

2.6 introduced an optimisation called child-runs-first. Apparently
it is nice for many common things, but it also causes a context
switch at every fork(), so sucks for these microbenchmarks. Child-
runs-last simply reverts that. Patch is attached if anyone is
interested.

--------------020807030405050804060606
Content-Type: text/x-patch;
 name="no-child-run-first.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-child-run-first.patch"

 linux-2.6-npiggin/kernel/fork.c  |    7 +------
 linux-2.6-npiggin/kernel/sched.c |   20 ++------------------
 2 files changed, 3 insertions(+), 24 deletions(-)

diff -puN kernel/sched.c~no-child-run-first kernel/sched.c
--- linux-2.6/kernel/sched.c~no-child-run-first	2004-05-23 18:22:41.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2004-05-23 18:22:41.000000000 +1000
@@ -1073,15 +1073,7 @@ void fastcall wake_up_forked_process(tas
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
-	if (unlikely(!current->array))
-		__activate_task(p, rq);
-	else {
-		p->prio = current->prio;
-		list_add_tail(&p->run_list, &current->run_list);
-		p->array = current->array;
-		p->array->nr_active++;
-		rq->nr_running++;
-	}
+	__activate_task(p, rq);
 	task_rq_unlock(rq, &flags);
 }
 
@@ -1395,15 +1387,7 @@ lock_again:
 	set_task_cpu(p, cpu);
 
 	if (cpu == this_cpu) {
-		if (unlikely(!current->array))
-			__activate_task(p, rq);
-		else {
-			p->prio = current->prio;
-			list_add_tail(&p->run_list, &current->run_list);
-			p->array = current->array;
-			p->array->nr_active++;
-			rq->nr_running++;
-		}
+		__activate_task(p, rq);
 	} else {
 		schedstat_inc(sd, sbc_pushed);
 		/* Not the local CPU - must adjust timestamp */
diff -puN kernel/fork.c~no-child-run-first kernel/fork.c
--- linux-2.6/kernel/fork.c~no-child-run-first	2004-05-23 18:22:41.000000000 +1000
+++ linux-2.6-npiggin/kernel/fork.c	2004-05-23 18:22:41.000000000 +1000
@@ -1239,12 +1239,7 @@ long do_fork(unsigned long clone_flags,
 			wait_for_completion(&vfork);
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
-		} else
-			/*
-			 * Let the child process run first, to avoid most of the
-			 * COW overhead when the child exec()s afterwards.
-			 */
-			set_need_resched();
+		}
 	}
 	return pid;
 }

_

--------------020807030405050804060606--
