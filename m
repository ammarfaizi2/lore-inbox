Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUHXLwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUHXLwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUHXLwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:52:06 -0400
Received: from pop.gmx.net ([213.165.64.20]:41902 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267595AbUHXLvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:51:03 -0400
Date: Tue, 24 Aug 2004 13:51:02 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       Tonnerre <tonnerre@thundrix.ch>
MIME-Version: 1.0
References: <200408202004.i7KK4HZN001285@magilla.sf.frob.com>
Subject: Re: [PATCH] waitid system call
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <12606.1093348262@www48.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland,

> Can you give a complete specification of what these other systems do?
> Do they zero the whole structure?  i.e., test by filling with 
> recognizable garbage, and then examine all the fields after the 
> waitid call and tell me what they are.

I've now run a slightly revised version(see below) of my 
program on a number of platforms.  (If anyone can run
this program on other Unix implementations supporting 
waitid(), it would be interesting to see the results 
posted into this thread.

[Tonnerre: I tried contacting you offlist, but did not hear 
back -- I'd still be interested in the results on AIX, if you 
care to run the program below, and post the results into this
thread.   As noted in my other mail, you may need to change 
a line of the code below:

    #if ! defined(__hpux)

to:

    #if ! defined(__hpux) && ! defined(_AIX)

in order to get the program to compile.
]

I added an option that initializes all of the fields to 
a recognizable garbage value (99), so that one can clearly 
see if WNOHANG modifies the fields when there are no 
waitable children.  

The following table is my attempt to summarise and analyse 
the results.  The actual shell logs of the various runs are 
shown below.

           Linux   Tru64   Solaris  HP-UX  Irix
           2.6.8.1  5.1       8      11    6.5
           +waitid
si_pid     y.      y*      y*       y      y* 
si_uid     y.      n* [1]  n* [2]   n [1]  n*
si_signo   y.      y*      y*       y      y*
si_status  y.      y*      y*       y      y#
si_code    y.      y*      y*       y      y*
si_errno   ?.      ?*      ?*       ?      ?*
si_stime   n.      n*      y* [3]   -      n#
si_utime   n.      n*      y* [3]   -      n*

Key
---

The first character in each table cell indicates whether
waitid() sets the field on this platform:

    y   this field is set on this platform

    n   this field is not set on this platform

    ?   there is insufficient information to determine if
        this field is meaningfully set on this platform

    -   this field is not available on this platform

    NOTE: The given test does not reveal whether si_errno is 
          meaningfully set on any platform (and I haven't 
          examined the header files sufficiently closely 
          enough to check if any further details can be 
          determined).  Offhand, I can't think of any 
          circumstances where it could be meaningful with 
          waitid().)

The second character in each table cell indicates (if present) 
how the field is treated when a WNOHANG operation is performed
and there is no child in a waitable state

    .   the field is left unchanged

    *   the field is explicitly initialized to 0

    #   the field is initialized to some random value 
        (i.e., something I don't understand) 

    NOTE: WNOHANG is broken on HP/UX 11 – if there are no 
          children that have yet terminated, waitid() fails 
          with the error ECHILD.

Notes to table:

[1] On Tru64 5.1 and HP-UX 11, si_uid is not meaningful, 
    but coincides with si_status, so a value is filled in.

[2] On Solaris 8, si_uid is not meaningful, but coincides with 
    si_utime, so a value is filled in.

[3] On Solaris 8, the si_stime and si_utime fields 
    return values in centiseconds.


Summary points
--------------

1. On all implementations (other than Linux), when WNOHANG 
   is specified, all fields of the siginfo_t structure are 
   returned zeroed out if no child is in a waitable state, 
   with the following exceptions:

       WNOHANG on HP-UX is broken as noted above.  

       On Irix 6.5, si_status and si_stime are filled in
       with some unexplained values; the remaining fields
       are zeroed out.

2. All waitpid() implementations support si_pid, si_signo,
   si_status, and si_code.

3. Only Linux supports si_uid (and the rusage fields, which
   weren't employed in this test).

4. Solaris is the only implementation that supports 
   si_utime and si_mtime.

Actual runs on the various platforms are shown below.

Cheers,

Michael

===========

Linux 2.6.8.1 + waitid patch

$ ./a.out escHi 1 3
Linux tekapo 2.6.8.1 #1 Wed Aug 18 11:04:01 CEST 2004 i686 i686 i386
GNU/Linux
child 1 PID=8208 started
child 2 PID=8209 started
0.04: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
0.54: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
child 1 PID=8208 finished
1.04: waitid() returned 0
        si_pid=8208; si_uid=500; si_signo=17;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=99; si_utime=99;
1.55: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
2.05: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
2.55: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
child 2 PID=8209 finished
3.05: waitid() returned 0
        si_pid=8209; si_uid=500; si_signo=17;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=99; si_utime=99;
3.55: waitid: No child processes

===========

Tru64 5.1

[I have no explanation for the odd si_errno setting on the 
first call below.]

$ ./a.out escHi 1 3
OSF1 spe206.testdrive.hp.com V5.1 2650 alpha
child 1 PID=1884812 started
0.01: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=-1024;
        si_stime=0; si_utime=0;
child 2 PID=1885104 started
0.53: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
child 1 PID=1884812 finished
1.03: waitid() returned 0
        si_pid=1884812; si_uid=22; si_signo=20;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=0; si_utime=0;
1.53: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
2.03: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
2.53: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
child 2 PID=1885104 finished
3.03: waitid() returned 0
        si_pid=1885104; si_uid=22; si_signo=20;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=0; si_utime=0;
3.54: waitid: No child processes

===========

HP-UX 11

[WNOHANG is broken on this platform]

$ ./a.out escHi 1 3
HP-UX spe192 B.11.11 U 9000/800 1839940656 unlimited-user license
child 2 PID=5729 started
child 1 PID=5728 started
0.03: waitid: No child processes
$ child 1 PID=5728 finished
child 2 PID=5729 finished

./a.out esci 1 3
HP-UX spe192 B.11.11 U 9000/800 1839940656 unlimited-user license
child 1 PID=5733 started
child 2 PID=5734 started
child 1 PID=5733 finished
1.01: waitid() returned 0
        si_pid=5733; si_uid=22; si_signo=18;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
child 2 PID=5734 finished
3.01: waitid() returned 0
        si_pid=5734; si_uid=22; si_signo=18;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
3.01: waitid: No child processes

===========

Solaris 8

$ ./a.out escHi 1 3
SunOS sunbode6 5.8 Generic_108528-14 sun4u sparc SUNW,Ultra-4
child 1 PID=20682 started
0.02: child 2 PID=20683 started
waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
0.52: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
child 1 PID=20682 finished
1.03: waitid() returned 0
        si_pid=20682; si_uid=80; si_signo=18;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=20; si_utime=80;
1.54: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
2.05: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
2.56: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
child 2 PID=20683 finished
3.07: waitid() returned 0
        si_pid=20683; si_uid=239; si_signo=18;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=61; si_utime=239;
3.58: waitid: No child processes

===========

Irix 6.5

$ ./a.out escHi 1 3
IRIX64 max 6.5 04091957 IP30
child 1 PID=62684 started
child 2 PID=62704 started
0.04: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=809598976; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
0.59: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=4; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
child 1 PID=62684 finished
1.10: waitid() returned 0
        si_pid=62684; si_uid=0; si_signo=18; 
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0; 
        si_stime=0; si_utime=0; 
1.61: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=4; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
2.12: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=4; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
2.63: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=4; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
child 2 PID=62704 finished
3.14: waitid() returned 0
        si_pid=62704; si_uid=0; si_signo=18; 
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0; 
        si_stime=0; si_utime=0; 
3.65: waitid: No child processes

===========

Test program:

/* waitid_test.c

   Michael Kerrisk, Aug 2004

   Change history

   19 Aug 04    Initial creation
   23 Aug 04    Revised/enhanced
*/

#include <sys/types.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <time.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#define errMsg(msg)     { perror(msg); }

#define errExit(msg)    { perror(msg); exit(EXIT_FAILURE); }

#define fatalErr(msg)   { fprintf(stderr, "%s\n", msg); \
                              exit(EXIT_FAILURE); }

#ifdef __linux__

#include <syscall.h>

#define __NR_waitid        284          /* Syscall number on x86 */

_syscall4(int, waitid, idtype_t, __idtype, __id_t, __id,
          siginfo_t *, __infop, int, __options)

#define WSTOPPED    WUNTRACED
#define WEXITED     0x00000004
#define WCONTINUED  0x00000008
#define WNOWAIT     0x01000000

#endif

#define DUMMY_VAL 99

#if ! defined(__hpux)
#define HAVE_TIME_FIELDS
#endif

/* Consume CPU time for 'nsecs' seconds of *elapsed* time */

static void
burnCpu(int nsecs)
{
    struct timeval start, curr;
    int diff;

    if (gettimeofday(&start, NULL) == -1) errExit("gettimeofday");

    for (;;) {

        /* gettimeofday() is not a system call on some Unix
           implementations, so we call getppid() as well, so that
           both user and system CPU time are consumed */

        getppid();

        if (gettimeofday(&curr, NULL) == -1) errExit("gettimeofday");
        diff = (curr.tv_sec - start.tv_sec) * 1000000 +
               (curr.tv_usec - start.tv_usec);

        if (diff >= nsecs * 1000000)
            break;
    } 
} /* burnCpu */

static void
child(int cnum, int nsecs)
{
    printf("child %d PID=%ld started\n", cnum, (long) getpid());
    burnCpu(nsecs);     /* So that values can show up in si_stime
                           and si_utime */
    printf("child %d PID=%ld finished\n", cnum, (long) getpid());
} /* child */

int
main(int argc, char *argv[])
{
    siginfo_t info;
    int options, j, s;
    char *p;
    int init, e;
    struct timeval start, curr;

    if (gettimeofday(&start, NULL) == -1) errExit("gettimeofday");

    if (argc < 3) {
        fprintf(stderr, "%s {escHWi} child-secs...\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    system("uname -a");

    options = 0;
    init = 0;

    for (p = argv[1]; *p != '\0'; p++) {
        if (*p == 'e') options |= WEXITED;
        else if (*p == 's') options |= WSTOPPED;
        else if (*p == 'c') options |= WCONTINUED;
        else if (*p == 'H') options |= WNOHANG;
        else if (*p == 'W') options |= WNOWAIT;

        else if (*p == 'i') init = 1;

        else fatalErr("Bad option letter");
    }

    for (j = 2; j < argc; j++) {
        switch (fork()) {
        case -1:
            errExit("fork");

        case 0:
            child(j - 1, atoi(argv[j]));
            exit(22);   /* Non-zero so it can be clearly
                           distinguished in si_status */

        default:
            break;
        }
    }

    for (;;) {
        if (init) {
            info.si_pid = DUMMY_VAL;
#ifdef HAVE_TIME_FIELDS
            info.si_stime = DUMMY_VAL;
            info.si_utime = DUMMY_VAL;
#endif
            info.si_uid = DUMMY_VAL;
            info.si_status = DUMMY_VAL;
            info.si_code = DUMMY_VAL;
            info.si_signo = DUMMY_VAL;
            info.si_errno = DUMMY_VAL;
        }

        s = waitid(P_ALL, 0, &info, options);
        e = errno;

        if (gettimeofday(&curr, NULL) == -1) errExit("gettimeofday");

        printf("%0.2f: ", (float) (curr.tv_sec - start.tv_sec) +
                  (float) (curr.tv_usec - start.tv_usec) / 1000000);
        fflush(NULL);

        errno = e;
        if (s == -1)
            errExit("waitid");

        printf("waitid() returned %d\n", s);
        printf("\t");
        printf("si_pid=%ld; ", (long) info.si_pid);
        printf("si_uid=%ld; ", (long) info.si_uid);
        printf("si_signo=%ld; ", (long) info.si_signo);
        printf("\n");
        printf("\t");
        printf("si_status=%ld; ", (long) info.si_status);
        printf("si_code=%ld ", (long) info.si_code);
        printf("(%s); ",
                (info.si_code == CLD_EXITED) ? "CLD_EXITED" :
                (info.si_code == CLD_KILLED) ? "CLD_KILLED" :
                (info.si_code == CLD_DUMPED) ? "CLD_DUMPED" :
                (info.si_code == CLD_TRAPPED) ? "CLD_TRAPPED" :
                (info.si_code == CLD_STOPPED) ? "CLD_STOPPED" :
                (info.si_code == CLD_CONTINUED) ? "CLD_CONTINUED" :
                "????"
              );
        printf("si_errno=%ld; ", (long) info.si_errno);
        printf("\n");
#ifdef HAVE_TIME_FIELDS
        printf("\t");
        printf("si_stime=%ld; si_utime=%ld; ",
                (long) info.si_stime, (long) info.si_utime);
        printf("\n");
#endif

        if ((options & WNOHANG) != 0)
            usleep(500000);     /* Just slow things down a little */
    }
} /* main */



-- 
NEU: Bis zu 10 GB Speicher für e-mails & Dateien!
1 GB bereits bei GMX FreeMail http://www.gmx.net/de/go/mail

