Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbUCMCHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 21:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUCMCHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 21:07:37 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:45557 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262638AbUCMCHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 21:07:33 -0500
Message-ID: <40526CE3.7000509@acm.org>
Date: Fri, 12 Mar 2004 20:07:31 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Race in signal handling with reproducer program
References: <404F8FDE.3050305@acm.org>
In-Reply-To: <404F8FDE.3050305@acm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a program to reproduce this problem.  The attached program will 
segv pretty quickly on 2.4 and 2.6 kernels on SMP machines, and I assume 
this is possible (although less likely) with preempt on a uniprocessor 
(I could not reproduce the problem that way, but I didn't try very 
hard).  It ends up crashing because the program counter is set to 
0x00000001, not surprisingly the value of SIG_IGN.  Just to test and see 
if the program was ok, I changed the SIG_IGN to a second signal handler 
function and everything worked ok, so I think the program is valid.

The program below has three threads that share signal handlers.  Thread 
1 changes the signal handler for a signal from a handler to SIG_IGN and 
back.  Thread 0 sends signals to thread 3, which just receives them.  
What I believe is happening is that thread 1 changes the signal handler 
in the process of thread 3 receiving the signal, between the time that 
thread 3 fetches the signal info using get_signal_to_deliver() and 
actually delivers the signal with handle_signal().

Although the program is obvously an extreme case, it seems like any time 
you set the handler value of a signal to SIG_IGN or SIG_DFL, you can 
have this happen.  Changing signal attributes might also cause problems, 
although I am not so sure about that.

Has anyone seen this?  Is there a fix available?  It seems to me that to 
fix this properly, get_signal_to_deliver() would have to return all the 
information about the signal delivery and that's a pretty major change 
that would affect all architectures.

The program....

#include <signal.h>
#include <stdio.h>
#include <sched.h>

char stack1[4096];
char stack2[4096];

void
sighnd(int sig)
{
}

int
child1(void *data)
{
  struct sigaction act;

  sigemptyset(&act.sa_mask);
  act.sa_flags = 0;
  for (;;) {
    act.sa_handler = sighnd;
    sigaction(45, &act, NULL);
    act.sa_handler = SIG_IGN;
    sigaction(45, &act, NULL);
  }
}

int
child2(void *data)
{
  for (;;) {
    sleep(100);
  }
}

int
main(int argc, char *argv[])
{
  int pid1, pid2;

  signal(45, SIG_IGN);
  pid2 = clone(child2, stack2+4092, CLONE_SIGHAND | CLONE_VM, NULL);
  pid1 = clone(child1, stack1+4092, CLONE_SIGHAND | CLONE_VM, NULL);

  for (;;) {
    kill(pid2, 45);
  }
}

Corey Minyard wrote:

> I'm hoping I am wrong, but I think I have found a race in signal 
> handling.  I believe this can only happen in an SMP system or a system 
> with preempt on.  I'll use 2.6 for the example, but I think it applies 
> to 2.4, too.
>
> In arch/i386/signal.c, in the do_signal() function, it calls 
> get_signal_to_deliver() which returns the signal number to deliver 
> (along with siginfo).  get_signal_to_deliver() grabs and releases the 
> lock, so the signal handler lock is not held in do_signal().  Then the 
> do_signal() calls handle_signal(), which uses the signal number to 
> extract the sa_handler, etc.
>
> Since no lock is held, it seems like another thread with the same 
> signal handler set can come in and call sigaction(), it can change 
> sa_handler between the call to get_signal_to_deliver() and fetching 
> the value of sa_handler.  If the sigaction() call set it to SIG_IGN, 
> SIG_DFL, or some other fundamental change, that bad things can happen.
>
> Am I correct here, or am I missing something?
>
> -Corey
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



