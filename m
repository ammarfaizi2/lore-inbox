Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUANP2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 10:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUANP2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 10:28:31 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:13066 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S265331AbUANP1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 10:27:51 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Re: [patch] fix runqueue corruption, 2.6.1-rc3-A0
Date: Wed, 14 Jan 2004 09:27:44 -0600
Message-ID: <8C91B010B3B7994C88A266E1A72184D3034D9F08@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Re: [patch] fix runqueue corruption, 2.6.1-rc3-A0
Thread-Index: AcPasvThood9WHTHR2qeHgzD7l181Q==
From: "Schmitz, Christoph" <christoph.schmitz@hp.com>
To: <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 14 Jan 2004 15:27:46.0003 (UTC) FILETIME=[F5D6BA30:01C3DAB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear group, 

The patch indicated in the first post does not fix the problem.
The second patch proposed does not seem to work either, but I am less sure of that, since 
a) I had trouble applying the patch (had to do manual intervention).
b) It is not clear wheter the second patch is supersedes or complements the first patch (i.e. should it be applied alone or in conjuction with patch #1).

But maybe I should start from the beginning:

During my (job related) testing of the 2.6.x series of kernels, I have noticed kernel panics.  I have seen these crashes when creating multiple pthreads and then killing them by sending a SIGTERM and simultaneously calling exit().  The small sample program that reproduces this behavior quickly is shown below (forkbomb.c).  
I have noticed that the problem occurs more quickly as the number of processors increases.  I have not been able to reproduce the issue on a single processor system.  I have also tried this on various manufacturers hardware (I have access to various server hardware) and see the same results.

	--- SNIP ----

	#include <stdio.h>
	#include <unistd.h>
	#include <sys/types.h>
	#include <signal.h>
	#include <errno.h>
	#include <pthread.h>

	#define MAXTHREADS 5
	#define MAXPROCS 5 
	#define SLEEPTIME 10000 /* in microseconds */

	int time_to_exit = 0;

	void * do_thread_stuff(void * param)
	{
		unsigned int x = 0;
		unsigned int y = 0;
		while (1) { /* burn up cpu cycles doing stupid stuff. */
			x++;
			y = (x + y ) * (x + y) % 31;
			if (time_to_exit) {
				exit(0);
			}
		}
		return NULL;
	}

	void sigterm_handler(int whatever)
	{
		time_to_exit = 1;
	}

	void catch_sigterm()
	{
		struct sigaction sa = { 0 };
		sa.sa_handler = sigterm_handler;
		sigaction(SIGTERM, &sa, NULL); 
	}

	void do_child_stuff()
	{
		int i;
		pthread_t thr[MAXTHREADS];

		catch_sigterm();

		for (i=0;i<MAXTHREADS;i++) {
			pthread_create(&thr[i], NULL, do_thread_stuff, NULL);
		}
		exit(0);
	}

	void forkproc(int *pid)
	{
		int p;
	       
		p = fork();
		if (p == -1) {
			perror("fork");
			*pid = -1;
		}
		if (p == 0)
			do_child_stuff();
		else
			*pid = p;
	}

	int main(int argc, char *argv[])
	{
		int i;
		int pid[MAXPROCS], waitstatus;

		while (1) {
			printf("Starting processes\n");
			/* Start up MAXPROCS processes */
			for (i=0;i<MAXPROCS;i++)
				forkproc(&pid[i]);

			/* Wait some number of microseconds */
			usleep(SLEEPTIME);

			/* Kill all those processes */
			printf("terminating processes\n");
			for (i=0;i<MAXPROCS;i++)
				if (pid[i] != -1)
					kill(pid[i], SIGTERM);
			for (i=0;i<MAXPROCS;i++)
				wait(&waitstatus);
			usleep(SLEEPTIME);
		}
		exit(0);
	}

	--- SNIP forkbomb.c ---

	Compile this program with

	gcc -D_REENTRANT -o forkbomb forkbomb.c -lpthread

Below are three crash dumps which exhibit the problem on 2.6.0-test11.

I have also found other references to issues similar to, but not necessarily the same as my issue that may be of help.

	----- SNIP --------

	::::::::::::::
	dl760g2-2.6.0-test11-run1.txt
	::::::::::::::
	Stack: c3f2e628 f6d36d00 f56ab310 c01208a0 c040cd20 c3f2e62c 00000000 00000082
	       f6d73940 00000009 00000002 f5aafde8 c0120394 f6d73940 00000005 00000000
	       00000000 c012e9c1 00000009 00000002 f6d73f14 00000000 f6d73940 00000000
	Call Trace:
	 [<c01208a0>] load_balance+0x1a1/0x3d7
	 [<c0120394>] wake_up_state+0x1a/0x1e
	 [<c012e9c1>] specific_send_sig_info+0xe5/0x158
	 [<c012ebc4>] force_sig_specific+0x85/0xf1
	 [<c0160e68>] zap_threads+0x96/0x9f
	 [<c0160eba>] coredump_wait+0x49/0xa9
	 [<c0161012>] do_coredump+0xf8/0x1f0
	 [<c012e3fa>] __dequeue_signal+0xe8/0x186
	 [<c012e4cd>] dequeue_signal+0x35/0x92
	 [<c01308d2>] get_signal_to_deliver+0x222/0x380
	 [<c010b0df>] do_signal+0xda/0x10a
	 [<c0121136>] schedule+0x54/0x624
	 [<c011e16e>] do_page_fault+0x0/0x539
	 [<c010b167>] do_notify_resume+0x58/0x5a
	 [<c010b35a>] work_notifysig+0x13/0x15

	Code: 80 3e 00 7e f9 e9 a8 d2 ff ff f3 90 80 38 00 7e f9 e9 df d4
	console shuts up ...
	 N I Watchdog detected LOCKUP on CPU12, eip c0122eec, registers:
	::::::::::::::
	dl760g2-2.6.0-test11-run2.txt
	::::::::::::::
	NMI Watchdog detected LOCKUP on CPU15, eip c0122eec, registers:
	CPU:    15
	EIP:    0060:[<c0122eec>]    Not tainted
	EFLAGS: 00000086
	EIP is at .text.lock.sched+0x26/0x1e6
	eax: 00000000   ebx: c3f3f700   ecx: 00000000   edx: c3f34100
	esi: c3f3f700   edi: 00000001   ebp: f4d07e24   esp: f4d07df0
	ds: 007b   es: 007b   ss: 0068
	Process forkbomb (pid: 29719, threadinfo=f4d06000 task=f4abb940)
	Stack: c040cd20 f4abb940 c3f34100 00000000 f4d07e14 f4d07e14 0000000f 5ab15000 
	       0000ffff 00000003 c3f3fba0 f4abb940 f4abb940 f4d07e78 c0121678 c3f3f700 
	       00000001 0000ffff 42976bf8 00000001 00000001 c3f3f728 c01388c4 42976bf8 
	Call Trace:
	 [<c0121678>] schedule+0x596/0x624
	 [<c01388c4>] sys_futex+0x10b/0x123
	 [<c01b8503>] rwsem_down_write_failed+0x82/0x125
	 [<c012804e>] .text.lock.exit+0xf6/0x194
	 [<c012786e>] do_group_exit+0x90/0xb3
	 [<c01308b9>] get_signal_to_deliver+0x209/0x380
	 [<c010b0df>] do_signal+0xda/0x10a
	 [<c01387b7>] do_futex+0x7e/0x80
	 [<c01388c4>] sys_futex+0x10b/0x123
	 [<c010b167>] do_notify_resume+0x58/0x5a
	 [<c010b35a>] work_notifysig+0x13/0x15
	Code: 80 3a 00 7e f9 e9 7d db ff ff f3 90 80 3b 00 7e f9 e9 7a db 
	console shuts up ...
	 MI Watchdog detected LOCKUP on CPU7  eip c0122f04, registers:
	  NMI Watchdog detected LOCKUP on CPU5, eip c01161be, registers:
	< >CP Wa chdog
	deIP:    00CKUP o0122U13, e   No1 taint re
	isteAGS
	00000086
	 NMI Watchdog detected LOCKUP on CPU12, eip c0122ed4, registers:
	 N I Watchdog detected LOCKUP on CPU4, eip c0122f04, registers:
	 NMI Watchdog detected LOCKUP on CPU6, eip c0122f04, registers:
	NMI Watchdog detected
	::::::::::::::
	dl760g2-2.6.0-test11-run3.txt
	::::::::::::::
	invalid operand: 0000 [#1]
	CPU:    3
	EIP:    b222:[<f4d95dc8>]    Not tainted
	EFLAGS: f4dfb940
	EIP is at 0xf4d95dc8
	eax: f57c6619   ebx: f5a70a80   ecx: 00000000   edx: 00000000
	esi: f536f940   edi: f4dcff78   ebp: c010b222   esp: 007d0f00
	ds: fe00   es: 0800   ss: 5b08
	Process forkbomb (pid: 29989, threadinfo=f4c06000 task=f536f940)
	 <0>Kernel panic: Fatal exception in interrupt
	In interrupt handler - not syncing
	 NMI Watchdog detected LOCKUP on CPU5, eip c010a24f, registers:
	CPU:    5
	EIP:    0060:[<c010a24f>]    Not tainted
	EFLAGS: 00000087
	EIP is at __write_lock_failed+0xf/0x20
	eax: c03da680   ebx: f5dabe40   ecx: 00000000   edx: f7ffeaa0
	esi: 00000000   edi: f4e07940   ebp: f4e07940   esp: f4c85e6c
	ds: 007b   es: 007b   ss: 0068
	Process forkbomb (pid: 29979, threadinfo=f4c84000 task=f4e07940)
	Stack: c0128029 f5d79580 f4d66080 00000000 00000000 f4e07940 00000000 c012376e 
	       f5eb2580 00000000 f4e07940 f5dabe40 00000000 f4e07940 00000000 c01276e2 
	       f4e07940 f5eb2580 f4e07f04 f4c85f24 f53be340 00000000 f4c84000 f4c85f24 
	Call Trace:
	 [<c0128029>] .text.lock.exit+0xd1/0x194
	 [<c012376e>] mm_release+0x96/0xa2
	 [<c01276e2>] do_exit+0x29a/0x318
	 [<c012786e>] do_group_exit+0x90/0xb3
	 [<c01308b9>] get_signal_to_deliver+0x209/0x380
	 [<c010b0df>] do_signal+0xda/0x10a
	 [<c0120376>] wake_up_process+0x1e/0x22
	 [<c01b862b>] rwsem_wake+0x85/0xbc
	 [<c010b167>] do_notify_resume+0x58/0x5a
	 [<c010b35a>] work_notifysig+0x13/0x15
	Code: 75 f6 f0 81 28 00 00 00 01 0f 85 e2 ff ff ff c3 90 f0 ff 00 
	console shuts up ...
	 N I Watchdog detected LOCKUP on CPU8, eip c010a249, registers:
	 N I Watchdog detected LOCKUP on CPU6, eip c0122f37, registers:
	 N I 

	----- SNIP --------

I noticed that Ingo's first patch proposal was integrated into the 2.6.1 tree, however, the follow up post after initial feedback by Linus was NOT picked up.

Anyway, the situation has markedly improved. However, I observe a hang now after ca. 60 minutes into the test (120000 iterations).
It turns out that in this run PID 19124 is now stuck on one processor hogging it 100 %. The system appears responsive otherwise. NMI watchdog was enabled, but did not trigger.

	::::::::::::::
	dl760g2-2.6.1-run1.txt
	::::::::::::::
	bash          S 86D99FEF     0  1359   1347  1442               (NOTLB)
	f5f5df3c 00000086 f5c466b0 86d99fef 0000000e f5bb0820 f5cfcb80 f5b5cce0 
	       c011e296 f5bb0800 86d99fef 0000000e f5c466b0 c3f17a00 0002664c 86d9f405 
	       0000000e f5b5cce0 f5b5cea8 fffffe00 f5b5cce0 f5b5cd88 f5b5cd88 c0127fd2 
	Call Trace:
	 [<c011e296>] do_page_fault+0x124/0x546
	 [<c0127fd2>] sys_wait4+0x1bc/0x263
	 [<c0161f77>] pipe_release+0x9a/0xcd
	 [<c0121756>] default_wake_function+0x0/0x12
	 [<c0130c7d>] sigprocmask+0x5c/0xd3
	 [<c0121756>] default_wake_function+0x0/0x12
	 [<c0130deb>] sys_rt_sigprocmask+0xf7/0x169
	 [<c01280a0>] sys_waitpid+0x27/0x2b
	 [<c010b2c1>] sysenter_past_esp+0x52/0x71
	forkbomb      S 00000001     0  1442   1359 19124               (NOTLB)
	f5f4ff50 00000086 c3f34100 00000001 0000ffff f4f5d310 c01263e2 f4f5d310 
	       f5c46758 f4f5d310 bfffe8ec 00004aae bfffe8f0 c3f34100 00000c7e 30bf52b1 
	       000003cc f5c466b0 f5c46878 fffffe00 f5c466b0 f5c46758 f5c46758 c0127fd2 
	Call Trace:
	 [<c01263e2>] release_task+0x187/0x1dd
	 [<c0127fd2>] sys_wait4+0x1bc/0x263
	 [<c0121756>] default_wake_function+0x0/0x12
	 [<c012db0a>] sys_nanosleep+0x102/0x1b0
	 [<c0121756>] default_wake_function+0x0/0x12
	 [<c010b2c1>] sysenter_past_esp+0x52/0x71
	forkbomb      R F5B6FDF0    12 19124   1442                     (NOTLB)
	c0135821 c012111e f5b6fdf0 f5b6fdf0 c3f1ef7c 00000000 f5b6e000 00000001 
	       c01294a4 00000000 c040b68c f5b6e000 f5b6fe3c c010cd8f f5b6e000 f5b6fe48 
	       c010cd8f f5b6fe48 00000003 00000000 00000000 00000000 00000002 c011e172 
	Call Trace:
	 [<c0135821>] rcu_process_callbacks+0x112/0x131
	 [<c012111e>] scheduler_tick+0x58d/0x592
	 [<c01294a4>] tasklet_action+0x6b/0xb6
	 [<c010cd8f>] do_nmi+0x58/0x5a
	 [<c010cd8f>] do_nmi+0x58/0x5a
	 [<c011e172>] do_page_fault+0x0/0x546
	 [<c010bd7d>] error_code+0x2d/0x38
	 [<c01237b7>] mm_release+0x68/0xa2
	 [<c0125e6f>] profile_exit_task+0x33/0x4c
	 [<c01275e5>] do_exit+0x8f/0x356
	 [<c01279ba>] do_group_exit+0x90/0xb3
	 [<c0130a8d>] get_signal_to_deliver+0x209/0x380
	 [<c010b0e3>] do_signal+0xda/0x10a
	 [<c0123154>] free_task+0x27/0x2f
	 [<c0124aca>] do_fork+0x50/0x191
	 [<c014dc5a>] .text.lock.mprotect+0x4e/0x64
	 [<c0109afd>] sys_clone+0x49/0x51
	 [<c010b16b>] do_notify_resume+0x58/0x5a
	 [<c010b35e>] work_notifysig+0x13/0x15

	----- SNIP --------

In conclusion, I would like to point out that there seems to be a locking omission in do_group_exit() and especially do_exit().
While a function like

1814                         do_signal_stop(signr); /* releases siglock */

is being called WITH a siglock held (in get_signal_to_deliver()), 

do_group_exit() is called without it (released in 1818).
1818                 spin_unlock_irq(&current->sighand->siglock);
1819 
1820                 /*
1821                  * Anything else is fatal, maybe with a core dump.
1822                  */
1823                 current->flags |= PF_SIGNALED;
1824                 if (sig_kernel_coredump(signr) &&
1825                     do_coredump((long)signr, signr, regs)) {
1826                         /*
1827                          * That killed all other threads in the group and
1828                          * synchronized with their demise, so there can't
1829                          * be any more left to kill now.  The group_exit
1830                          * flags are set by do_coredump.  Note that
1831                          * thread_group_empty won't always be true yet,
1832                          * because those threads were blocked in __exit_mm
1833                          * and we just let them go to finish dying.
1834                          */
1835                         const int code = signr | 0x80;
1836                         BUG_ON(!current->signal->group_exit);
1837                         BUG_ON(current->signal->group_exit_code != code);
1838                         do_exit(code);
1839                         /* NOTREACHED */
1840                 }
1841 
1842                 /*
1843                  * Death signals, no core dump.
1844                  */
1845                 do_group_exit(signr);

Though do_group_exit DOES seize the siglock for some operations, do_exit() is completely unguarded by the siglock. Interrupts are enabled, as well. 
Isn't this a problem (signal receive may happen during interrupt time) ?
Related to this I found the following post by Ernie Petrides:
http://groups.google.com/groups?q=ernie+petrides+redhat+signal&hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=cE1Q.1mh.5%40gated-at.bofh.it&rnum=1

Anybody's feedback, especially Ingo's or Linus' would be extremely welcome, as this is kind of a showstopper for me.

Regards, 

Christoph Schmitz
Systems Engineer
Hewlett-Packard Company

