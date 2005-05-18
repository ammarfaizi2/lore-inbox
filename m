Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVERIVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVERIVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 04:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVERIVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 04:21:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:12165 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262130AbVERIUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 04:20:48 -0400
Date: Wed, 18 May 2005 10:20:47 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: roland@redhat.com
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
Subject: waitid() fails with EINVAL for SA_RESTART signals
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <24601.1116404447@www71.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland,

I'm seeing a strange behaviour with waitid() in 2.6.12-rc3 
(I'm fairly sure the behaviour also appears in other 2.6.x).

If we establish a handler for a signal with SA_RESTART, and that 
signal interrupts a blocked waitid(), then waitid() fails with 
the error EINVAL.  I would expect the call to be restarted
(like wait(), waitpid(), etc.) or if you are choosing to design
waitid() to ignore SA_RESTART, then fail with EINTR.

I haven't been able to spot the source of the EINVAL in kernel
or glibc sources.

The program below can be used to demonstrate the problem.

Cheers,

Michael

/* waitid_intr.c

   Michael Kerrisk, May 2005

   Demonstration of a problem with waitid() on Linux (Linux 2.6.12-rc3).

   If S_A_RESTART was specified for a signal handler, and that signal
   is delivered during a blocked waitid(), then the waitid() fails
   with EINVAL, when it should either be restarted or (if the intent
   is to ignore SA_RESTART in the waitid() implementation) fail
   with EINTR.  This program demonstrates the problem.

   The program creates two children.  The first is a child that sleeps
   for argv[2] seconds and is then reaped by waitid() in the parent.
   The second child sends a signal (SIG) to the parent after argv[3]
   seconds.

   argv[1] specifies options for the waitid() call (see the code
   below).

   If the optional argv[4] is present (as any string), then the
   handler for the signal sent by the second child is established
   with SA_RESTART.

   To demonstrate the waitid() problem, use the following command:

       ./waitid_intr esc 10 2 restart
*/
#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <syscall.h>
#include <unistd.h>
#include <errno.h>

#define errExit(msg)    { perror(msg); exit(EXIT_FAILURE); }

#define fatalErr(msg)   { fprintf(stderr, "%s\n", msg); \
                              exit(EXIT_FAILURE); }

static void
handler(int sig)
{
    int savedErrno;

    savedErrno = errno;
    printf("Caught signal\n");
    errno = savedErrno;
} /* handler */

#define SIG SIGUSR1

int
main(int argc, char *argv[])
{
    siginfo_t info;
    int options, s;
    char *p;
    pid_t pid;
    struct rusage ru;
    struct sigaction sa;

    setbuf(stdout, NULL);

    printf("Parent's PID is %ld\n", (long) getpid());

    if (argc < 4) {
        fprintf(stderr, "%s {escHW} child-secs sig-secs [sa_restart]\n",
                argv[0]);
        exit(EXIT_FAILURE);
    } 

    options = 0;

    for (p = argv[1]; *p != '\0'; p++) {
        if      (*p == 'e') options |= WEXITED;
        else if (*p == 's') options |= WSTOPPED;
        else if (*p == 'c') options |= WCONTINUED;
        else if (*p == 'H') options |= WNOHANG;
        else if (*p == 'W') options |= WNOWAIT;

        else fatalErr("Bad option letter");
    }

    /* Create first child to waitid() for */

    pid = fork();
    if (pid == -1) errExit("fork");

    if (pid == 0) {
        printf("child (PID = %ld) started\n", (long) getpid());
        sleep(atoi(argv[2]));
        printf("child (PID = %ld) finished\n", (long) getpid());
        exit(EXIT_SUCCESS);
    } 

    /* Parent falls through */

    /* Set up handler for signal sent by child 2 */

    sa.sa_handler = handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = (argc > 4) ? SA_RESTART : 0;
    if (sigaction(SIG, &sa, NULL) == -1) errExit("sigaction");

    /* Create  a second child that will send parent a signal */

    switch (fork()) {
    case -1:
        errExit("fork-2");

    case 0:
        sleep(atoi(argv[3]));
        printf("Sending signal to parent\n");
        if (kill(getppid(), SIG) == -1) errExit("kill");
        exit(EXIT_SUCCESS);

    default:
        break;
    } 

    /* Parent now waits for the first child */

    memset(&info, 0, sizeof(siginfo_t));

    s = waitid(P_PID, pid, &info, options);
    //s = syscall(SYS_waitid, P_ALL,  0, &info, options, &ru);
    //s = syscall(SYS_waitpid, -1, NULL, 0);

    if (s == -1) errExit("waitid");

    printf("waitid() returned %d\n", s);
    printf("    ");
    printf("si_pid=%ld; ", (long) info.si_pid);
    printf("si_uid=%ld; ", (long) info.si_uid);
    printf("si_signo=%ld; ", (long) info.si_signo);
    printf("\n");
    printf("    ");
    printf("si_status=%ld; ", (long) info.si_status);
    printf("si_code=%ld ", (long) info.si_code);
    printf("(%s); ",
                (info.si_code == CLD_EXITED) ? "CLD_EXITED" :
                (info.si_code == CLD_KILLED) ? "CLD_KILLED" :
                (info.si_code == CLD_DUMPED) ? "CLD_DUMPED" :
                (info.si_code == CLD_TRAPPED) ? "CLD_TRAPPED" :
                (info.si_code == CLD_STOPPED) ? "CLD_STOPPED" :
                (info.si_code == CLD_CONTINUED) ? "CLD_CONTINUED" :
                "????");
    printf("\n");
} /* main */


-- 
Weitersagen: GMX DSL-Flatrates mit Tempo-Garantie!
Ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl
