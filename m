Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135328AbRDZQv0>; Thu, 26 Apr 2001 12:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135484AbRDZQvR>; Thu, 26 Apr 2001 12:51:17 -0400
Received: from [63.109.196.26] ([63.109.196.26]:15624 "EHLO
	uscamexcp004.allaire.com") by vger.kernel.org with ESMTP
	id <S135328AbRDZQvI>; Thu, 26 Apr 2001 12:51:08 -0400
Message-ID: <3312CFEA8474D411BAB600508B9587B2586389@S0001EXC0007>
From: Jesse Noller <jnoller@macromedia.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Inquiry: RE: [BUG] threaded processes get stuck in  rt_sigsuspend
	/fillonedir/exit_notify thread.
Date: Thu, 26 Apr 2001 12:47:25 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Afternoon All-

	Basically, I am sending out a pseudo 'help' and bug check. I found
this thread ([BUG] threaded processes get stuck in
rt_sigsuspend/fillonedir/exit_notify) from 9/11/2000. I helping write some
software, and I think I have ran into a bug similiar to this, first, a quick
description of what the program does:

the program runs, creates a pipe and then forks.

The parent
 - immediately starts reading on the pipe, waiting for the child to say "OK"
 - When it gets the OK, the parent exits cleanly.

The child
 - calls setsid() to become a process group leader
 - loads a shared library (ascf.so)
 - calls pthread_sigmask(SIG_BLOCK, ...) for SIGINT, SIGTERM, SIGHUP
 - starts a monitor thread which
   * Proceeds to fork and exec the other server processes
   * After it does this successfully, it writes "OK" to the pipe
   * Proceeds to call wait() waiting to any of its children to die

The main thread continues on to:
 - Starts up two more worker threads  
 - calls sigaction(..) to establish a signal handler function for SIGINT,
SIGTERM & SIGHUP
 - calls pthread_sigmask(SIG_UNBLOCK, ...) for SIGINT, SIGTERM, SIGHUP
 - calls pause() to wait for any incoming signals


Now, the problem is that the child threads/processes do not seem to be
returning the OK, instead, they seem to simply hang, here is some sample
strace output [snipped for brevity]:

main process:

read(4, "1860", 4096)                   = 4
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x4012e000, 4096)                = 0
kill(1860, SIG_0)                       = -1 ESRCH (No such process)
pipe([4, 6])                            = 0
fork()                                  = 2048
close(6) = 0
read(4, 

[it seems to be waiting for the response]

then:

first process:

old_mmap(NULL, 89056, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40314000
mprotect(0x40326000, 15328, PROT_NONE)  = 0
old_mmap(0x40326000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4,
0x11000) = 0x40326000
close(4)                                = 0
mprotect(0x40314000, 73728, PROT_READ|PROT_WRITE) = 0
mprotect(0x40314000, 73728, PROT_READ|PROT_EXEC) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT TERM], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=2147483647}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=2147483647}) = 0
pipe([4, 7])                            = 0
clone(child_stack=0x81a9234,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_PTRACE) = 2049
write(7, "\364\336\0@\5\0\0\0\0\0\0\0\0\0\0\0\0\336\0@\0\0\0\0\220"..., 148)
= 148
rt_sigprocmask(SIG_SETMASK, NULL, [HUP INT TERM CHLD RT_0 RT_5], 8) = 0
write(7, "`\177\24@\0\0\0\0\0\0\0\0\330&\6\10\0\0\0\0\3@\1\200\20"..., 148)
= 148
rt_sigprocmask(SIG_SETMASK, NULL, [HUP INT TERM CHLD RT_0 RT_5], 8) = 0
rt_sigsuspend([HUP INT TERM CHLD RT_5]


	So I guess my question is twofold, Has anyone else seen this on the
most recent kernels (specifically, 2.4.2, and 2.2.18). The 2 kernels are the
only place I see this. Even more specifically, I see it with the compiled
kernel versions shipped with Red Hat 7.1 and SuSE 7.1.

	The second half of the question, am I completely bonkers? If so,
just tell me.

Jesse Noller
Linux Systems Lead / Caffeine Distiller
Department of Shiny Happy People
Macromedia, Inc.
jnoller@macromedia.com

"This place is giving me the Fear. "
-Hunter S. Thompson
       Fear and Loathing in Las Vegas

