Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266830AbUHSRVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266830AbUHSRVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUHSRVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:21:13 -0400
Received: from pop.gmx.de ([213.165.64.20]:21952 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266830AbUHSRUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:20:19 -0400
Date: Thu, 19 Aug 2004 19:20:16 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <200408162112.i7GLCqTB030682@magilla.sf.frob.com>
Subject: Re: [PATCH] waitid system call
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <19958.1092936016@www27.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland,

> > Precisely what kernel version was the patch against?  
> 
> It is against 2.6.8.1.
> 
> > I've (twice) tried applying the patch against 2.6.8.1 and building the
> > kernel.  The build succeeds, but I am running into a strange kernel
panic
> > ("Unable to mount root fs") when I try to boot the resulting kernel.
> > (Compiling and booting 2.6.8.1 on the same x86 machine works fine.)
> 
> Well, it sure works fine for me.  Unless someone else can reproduce your
> issue, you'll have to look into it yourself.  I don't discount the
> likelihood it's a bug caused by my patch, but such an error is so far
> afield that there is no way for me to guess at what you might be seeing.

Yes, I assumed it would work for you ;-).  Sorry, I applied 2.6.8* 
against an existing (near vanilla) 2.6.7 tree in which I didn't 
realise I'd tweaked some file system support stuff.  I've now 
built against a truly vanilla 2.6.8.1 and it builds and boots 
fine.  

I've tested out various things (see below for a summary), and 
all seems well, with one possible doubt.  How can one 
distinguish "no children to wait for case" and the "child 
successfully waited for case" when using WNOHANG?  SUSv3 is a 
bit silent on this point, but the Solaris man page helpfully 
says:

    If WNOHANG was used, 0 can be returned (indicating
    no error); however, no children may have changed state if
    info->si_pid is 0.

And testing (program below), shows that this is indeed what 
happens on Solaris 8.  As things stand, this doesn't seem 
to happen with your patch for Linux -- it would perhaps be nice 
if it did.  Here's what I see when I run the test program at the 
end of this message (here, the command requests options as
WSTOPPED|WEXITED|WCONTINUED|WNOHANG, and creates two children 
each of which for the specified number of seconds);

$ ./waitid_test secH 1 2
child 1 PID=28443 started
child 2 PID=28444 started
  0: waitid() returned 0
        si_pid=1073838904; si_uid=-1073746612; si_status=1
        si_code=1073838488  (????); si_signo=-1073746624;   
  1: waitid() returned 0
        si_pid=1073838904; si_uid=-1073746612; si_status=1
        si_code=1073838488  (????); si_signo=-1073746624; 
child 1 PID=28443 finished
  1: waitid() returned 0
        si_pid=28443; si_uid=500; si_status=0
        si_code=1  (CLD_EXITED); si_signo=17; 
  2: waitid() returned 0
        si_pid=28443; si_uid=500; si_status=0
        si_code=1  (CLD_EXITED); si_signo=17; 
child 2 PID=28444 finished
  2: waitid() returned 0
        si_pid=28444; si_uid=500; si_status=0
        si_code=1  (CLD_EXITED); si_signo=17; 
waitid: No child processes

On Solaris 8, the 1st, 2nd, and 4th waitid() calls 
return si_pid == 0.

Cheers,

Michael



OTHER TESTS (all successful)
===========

1. WSTOPPED
    tested by sending SIGSTOP to child -- WORKS
        info.si_signo set to 17 (SIGCHLD)
        info.so_pid set to PID of child
        info.si_uid set to UID of child
        info.si_status set to 0x13 (signalled 19, SIGSTOP)
        info.si_code set to 5 (CLD_STOPPED)

    tested by sending SIGTSTP to child -- WORKS
        info.si_signo set to 17 (SIGCHLD)
        info.so_pid set to PID of child
        info.si_uid set to UID of child
        info.si_status set to 0x14 (signalled 20, SIGTSTP)
        info.si_code set to 5 (CLD_STOPPED)

2. WCONTINUED -- WORKS
        info.si_signo set to 17 (SIGCHLD)
        info.so_pid set to PID of child
        info.si_uid set to UID of child
        info.si_status set to 0x12 (signalled 18, SIGCONT)
        info.si_code set to 6 (CLD_CONTINUED)

3. WEXITED
    tested termination by signal SIGKILL -- WORKS
        info.si_signo set to 17 (SIGCHLD)
        info.so_pid set to PID of child
        info.si_uid set to UID of child
        info.si_status set to 0x9 (signalled 9, SIGKILL)
        info.si_code set to 2 (CLD_KILLED)

    tested for normal process termination (exit(0)) –- WORKS
        info.si_signo set to 17 (SIGCHLD)
        info.so_pid set to PID of child
        info.si_uid set to UID of child
        info.si_status set to 0x0 (exited, status 0)
        info.si_code set to 1 (CLD_EXITED)

    tested for normal process termination (exit(1)) –- WORKS
        info.si_signo set to 17 (SIGCHLD)
        info.so_pid set to PID of child
        info.si_uid set to UID of child
        info.si_status set to 0x1 (exited, status 1)
        info.si_code set to 1 (CLD_EXITED)
    
4. Waiting for combinations of WCONTINUED, WEXITED, WSTOPPED: works

5. Waiting for one of WCONTINUED, WEXITED, WSTOPPED while child
   undergoes a state transition in another category 
   (e.g., waiting for WEXITED and child is stopped by a signal)

   WORKS (waitid() remains blocked)

6. WNOWAIT -- leaves child in waitable state -- WORKS
  
   Tested for WCONTINUED, WEXITED (normal and abnormal termination), 
   and WSTOPPED transitions
    
7. Create multiple process groups; select of child by process 
   group (idtype == P_PGID) -- WORKS

8. Selection of one child out of several by PID 
   (idtype == P_PID) – WORKS

9. Selection of any child (idtype == P_ALL) -- WORKS

10. No child -– WORKS (returns errno set to ECHILD)



TEXT PROGRAM
============

/* waitid_test.c
  
   Michael Kerrisk, Aug 2004 
*/

#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#define errMsg(msg)     { perror(msg); }

#define errExit(msg)    { perror(msg); exit(EXIT_FAILURE); }

#ifdef __linux__

#include <syscall.h>

#define __NR_waitid        284          /* Syscall number on x86 */

_syscall4(int, waitid, idtype_t, __idtype, __id_t, __id,
          siginfo_t *, __infop, int, __options)

#define WSTOPPED    WUNTRACED
#define WEXITED        0x00000004
#define WCONTINUED    0x00000008
#define WNOWAIT        0x01000000

#endif

static void
child(int cnum, int nsecs)
{
    printf("child %d PID=%ld started\n", cnum, (long) getpid());
    sleep(nsecs);
    printf("child %d PID=%ld finished\n", cnum, (long) getpid());
} /* child */

int
main(int argc, char *argv[])
{
    siginfo_t info;
    int options, j, s;
    char *p;
    time_t start;

    start = time(NULL);

    if (argc < 3) {
        fprintf(stderr, "%s {escnW} child-secs...\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    options = 0;

    for (p = argv[1]; *p != '\0'; p++) {
        if (*p == 'e') options |= WEXITED;
        else if (*p == 's') options |= WSTOPPED;
        else if (*p == 'c') options |= WCONTINUED;
        else if (*p == 'H') options |= WNOHANG;
        else if (*p == 'W') options |= WNOWAIT;
    }

    for (j = 2; j < argc; j++) {
        switch (fork()) {
        case -1:
            errExit("fork");

        case 0:
            child(j - 1, atoi(argv[j]));
            exit(EXIT_SUCCESS);

        default:
            break;
        }
    }

    for (;;) {
        s = waitid(P_ALL, 0, &info, options);
        if (s == -1)
            errExit("waitid");

        printf("%3ld: waitid() returned %d\n",
                (long) (time(NULL) - start), s);
        printf("        si_pid=%ld; ", (long) info.si_pid);
        printf("si_uid=%ld; ", (long) info.si_uid);
        printf("si_status=%ld\n", (long) info.si_status);
        printf("        si_code=%ld ", (long) info.si_code);
        printf(" (%s); ",
                (info.si_code == CLD_EXITED) ? "CLD_EXITED" :
                (info.si_code == CLD_KILLED) ? "CLD_KILLED" :
                (info.si_code == CLD_DUMPED) ? "CLD_DUMPED" :
                (info.si_code == CLD_TRAPPED) ? "CLD_TRAPPED" :
                (info.si_code == CLD_STOPPED) ? "CLD_STOPPED" :
                (info.si_code == CLD_CONTINUED) ? "CLD_CONTINUED" :
                "????"
              );
        printf("si_signo=%ld;\n", (long) info.si_signo);

        if ((options & WNOHANG) != 0)
            usleep(500000);     /* Just slow things down a little */
    }
} /* main */

-- 
NEU: Bis zu 10 GB Speicher für e-mails & Dateien!
1 GB bereits bei GMX FreeMail http://www.gmx.net/de/go/mail

