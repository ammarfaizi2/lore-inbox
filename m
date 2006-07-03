Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWGCOqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWGCOqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWGCOqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:46:32 -0400
Received: from mail.jambit.com ([62.245.207.83]:47535 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S1750836AbWGCOqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:46:31 -0400
Message-ID: <44A92DC8.9000401@gmx.net>
Date: Mon, 03 Jul 2006 16:46:32 +0200
From: Michael Kerrisk <michael.kerrisk@gmx.net>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tytso@mit.edu, torvalds@osdl.com, drepper@redhat.com,
       Eric Paire <paire@ri.silicomp.fr>, Paul Eggert <eggert@cs.ucla.edu>,
       Manfred Spraul <manfred@colorfullife.com>, roland@redhat.com,
       Robert Love <rlove@rlove.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       mtk-lkml@gmx.net
Subject: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

[Various parties involved in past discussions on this topic CCed.]

First off, it's worth mentioning that the topic that I'll go into below 
has been visited a few times before, and in particular during one of the 
more recent visits, Linus's position was:

     http://marc.theaimsgroup.com/?l=linux-kernel&m=104502401330898&w=2
     List:       linux-kernel
     Subject:    Re: another subtle signals issue
     From:       Linus Torvalds
     Date:       2003-02-12 4:21:02

     ...

     And I have multiple times said that as far as Linux is
     concerned, ^Z is, has always been, and certainly for the 2.6.x
     timeframe _will_ be a signal that the kernel considers "caught".

The problem is that the "2.6.x timeframe" means something different now 
than it did then, and the question is when the following Linux-specific 
(mis)behaviour will ever be fixed.

==

Linux exhibits a unique behaviour among Unix implementations with 
respect to signals.  When a program that is blocked in the middle of 
certain system calls is suspended by a signal (SIGSTSTP (^Z), SIGSTOP, 
SIGGTIIN, SIGTTOU) and then resumed by a SIGCONT signal, the system call 
fails with the error EINTR.  ***This behaviour occurs even when no 
signal handler is installed for the stop or SIGCONT signals.***  (An 
example program showing the behaviour for one system call is appended to 
this message.)

This can cause applications that work on other Unix systems to behave 
unexpectedly on Linux.

On Linux, the current (2.6.17) system calls and functions that exhibit 
this behaviour are: futex(FUTEX_WAIT), epoll_wait(), poll(), read() from 
an inotify file descriptor (but not read()s from any other type of file 
descriptor, AFAIK), sem_wait(3) (because of futex(2)), semop(), 
semtimedop(), sigtimedwait(), and sigwaitinfo().

I have never seen this behaviour on any other Unix system, and at 
various times I've explicitly tested various blocking system calls on at 
least the following: Solaris 8, FreeBSD 4.8, HP-UX 11, Tru64 5.1B, Irix 
6.5, and Darwin 7.2.

My reading of POSIX is that POSIX only permits a system call to fail 
with EINTR if a signal handler is involved (i.e., a signal is only 
considered "caught" if a handler is involved, a different definition of 
Linus's "caught" quoted at the start of this message).  Some inquiries 
on the Austin group list quite a while back:

https://www.opengroup.org/sophocles/show_archive.tpl?source=L&listname=austin-group-l&first=1&pagesize=80&searchstring=signals+and+interruption+of+system+calls&zone=G
Or: http://tinyurl.com/l5at8

     Date: Fri, 13 Feb 2004 11:44:50 +0100 (MET)
     From: "Michael T Kerrisk"
     To: The Austin Group
     Subject: Stop signals and interruption of system calls on Linux

got answers that agreed with my interpretation, including:

https://www.opengroup.org/sophocles/show_mail.tpl?CALLER=show_archive.tpl&source=L&listname=austin-group-l&id=6668
Or: http://tinyurl.com/rdd7d

Quoting Paul Eggert:

   This topic came up in a POSIX.1 standards meeting on April 22, 1993,
   and the consensus of that meeting also agreed with you.

   > (And of course I'm still curious if any other implementation behaves
   > like Linux.)

   Long-ago AIX hosts had that bug as well, but they were fixed after
   that POSIX.1 discussion of a decade ago.  For more details about this,
   please see:

   David A. Willcox (Motorola MCG - Urbana)
   Job Control and POSIX
   <http://groups.google.com/groups?selm=1r77ojINN85n%40ftp.UU.NET>
   1993-04-22

==

Given the current development model, a fix now, in kernel 2.6.x seems in 
order.  Probably all of the system calls listed above should be fixed so 
that in this circumstance the system call is automatically restarted, 
just as currently occurs for many other similar blocking system calls 
(e.g., select(), pselect(), mq_send(), mq_receive(), accep(), connect(), 
recv(), send(), wait(), flock(), fcntl(F_SETLKW), etc.).

In some past threads on this topic I have seen arguments about ABI 
compatability advanced, but I don't believe these hold, for the 
following reasons:

a) We are talking about signals involved in *interactive* job control; 
therefore any ABI issues are likely to be minimal (and see "c)" below).

b) There is no consistency about which system calls show this behaviour 
and which do not.  For example poll() shows it, but select() does not. 
Notably, ppoll() also does not have the behaviour, since it does signal 
processing differently from poll()!  Another notable example is read(): 
on an inotify file descriptor it demonstrates this behaviour, but on 
other file descriptors it does not.

c) The Linux baehviour has been arbitrary across kernel versions and 
system calls.  In particular, the following system calls showed this 
behaviour in earlier kernel versions, but then the behaviour was changed 
without forewarning and (AFAIK) without subsequent complaint:

       * nanosleep() in kernel 2.4 and earlier

       * msgsnd() and msgrcv() in kernels before 2.6.9.

==

As far as I can see, there seems no compelling argument not to make 
Linux consistent with other current and historical Unix implementations 
with respect to the treatment of blocking syscalls and stop 
signals+SIGCONT.  Is there any reason not to fix things now?

Cheers,

Michael


PS Just for completeness, I note that this topic has been visited before:

http://marc.theaimsgroup.com/?l=linux-kernel&m=94464821126712&w=2
List:       linux-kernel
Subject:    SIGCONT misbehaviour in Linux
From:       Eric PAIRE <eric.paire () ri ! silicomp ! fr>
Date:       1999-12-08 10:14:13

and

http://marc.theaimsgroup.com/?l=linux-kernel&m=104501574824496&w=2
List:       linux-kernel
Subject:    another subtle signals issue
From:       Roland McGrath <roland () redhat ! com>
Date:       2003-02-12 2:06:54


==

Below is an example program demonstrating the behaviour for semop(). 
This is a sample run:

$ ./a.out x
<type ^Z>
[1]+  Stopped                 ./r x
$ fg
./a.out x
semop: Interrupted system call

The last line of output shows that the system call failed with EINTR.

$ cat restart_semop.c
/* restart_semop.c */

#define _GNU_SOURCE
#include <string.h>
#include <signal.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

#define errMsg(msg)     do { perror(msg); } while (0)

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                         } while (0)

static void
catcher(int sig)
{
     char msg[100];

     sprintf(msg, "Caught signal %d %s\n", sig, strsignal(sig));
     fprintf(stderr, "%s", msg);
} /* catcher */

int
main(int argc, char *argv[])
{
     struct sigaction sa;
     int semId;
     struct sembuf sops[10];

     sa.sa_handler = catcher;
     sigemptyset(&sa.sa_mask);

     /* Make system calls restartable if argc > 1 */

     sa.sa_flags = (argc > 1) ? SA_RESTART : 0;

     if (sigaction(SIGINT, &sa, NULL) == -1) errMsg("sigaction");

     semId = semget(IPC_PRIVATE, 1, IPC_CREAT | S_IRUSR | S_IWUSR);

     if (semId == -1) errExit("semget");

     if (semctl(semId, 0, SETVAL, 1) == -1) errExit("semctl");

     sops[0].sem_num = 0;
     sops[0].sem_op = 0;
     sops[0].sem_flg = 0;

     for (;;)
         if (semop(semId, sops, 1) == -1) errMsg("semop");
}
