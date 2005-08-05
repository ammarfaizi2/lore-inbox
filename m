Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbVHEL6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbVHEL6G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 07:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVHEL6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 07:58:06 -0400
Received: from pop.gmx.de ([213.165.64.20]:23259 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262993AbVHEL6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 07:58:05 -0400
Date: Fri, 5 Aug 2005 13:58:04 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: drepper@redhat.com, jakub@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
MIME-Version: 1.0
References: <1118835415.22181.68.camel@hades.cambridge.redhat.com>
Subject: =?ISO-8859-1?Q?Re:_Add_pselect,_ppoll_system_calls.?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <11156.1123243084@www3.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Woodhouse <dwmw2@infradead.org>
> Subject: Re: Add pselect, ppoll system calls.
> Date: Wed, 15 Jun 2005 12:36:54 +0100
> 
> On Mon, 2005-06-13 at 08:38 -0700, Ulrich Drepper wrote:
> > > Eep -- I hadn't noticed that difference. Will update patch
> > accordingly. 
> > 
> > And change [the poll timeout] to expect a 64bit value I hope...
> 
> I believe that 64-bit int types in syscalls are a pain on some
> architectures because of restrictions on precisely which register pairs
> may be used. I think I'd rather just use a struct timespec, which also
> makes it consistent with pselect().
> 
> > > The other documented difference (other than the signal mask bit) is
> > > that
> > > pselect() is documented not to modify the timeout parameter. I'm not
> > > sure whether I should preserve that difference, or not.
> > 
> > As long as there is a configuration where the timeout value is not
> > modified, it doesn't matter.  That is the case for select() using a
> > personality switch.
> 
> I've made pselect() consistent with select() by using the same
> personality switch to control its behaviour.
> 
> I've also fixed select() so that timeouts of greater than LONG_MAX
> jiffies are implemented accurately, instead of being infinite.

Hi David,

I applied the 15 Jun version of your patch agains 2.6.12 and 
tried a test program.  I see some behaviour that puzzles me.
When I run the program below, and type control-C, the program
tells me that the SIGINT hander was *not* called:

./t_pselect -
Making syscall(SYS_pselect6) call
[Type ^C]
pselect: Unknown error 514           <-- ERESTNOHAND
ready = -1
stdin IS NOT readable
signal handler WAS NOT called

I'm not sure whether this is possibly a mistake in the way 
I've constructed my test program (I don't think so, but I'm 
not !00% confident), or some bug in the implementation
(I did try making a syscall(SYS__newselect), and that *did* 
show the signal handler being called.  Also, I now have a test 
result on Solaris 10 for pselect(), and it shows the signal 
handler is called in this case.)

Cheers,

Michael

/* t_pselect.c

   Michael Kerrisk, Aug 2005
*/
#if defined(__linux__) && !defined(NO_SYSCALL)
#define USE_PSELECT_SYSCALL 1
#endif

#ifdef USE_PSELECT_SYSCALL
#define _GNU_SOURCE
#include <syscall.h>
#endif
#include <sys/time.h>
#include <sys/select.h>
#include <signal.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

#define errMsg(msg)             do { perror(msg); } while (0)

#define errExit(msg)            do { perror(msg); exit(EXIT_FAILURE); \
                                } while (0)

#ifdef USE_PSELECT_SYSCALL
/* Following are for x86 */
#define SYS_pselect6           289
#define SYS_ppoll              290
#endif

sig_atomic_t gotsig = 0;

static void
handler(int sig)
{
    gotsig = 1;
    printf("Caught signal %d\n", sig);  /* UNSAFE (see Section $$$) */
} /* handler */

int
main(int argc, char *argv[])
{
    fd_set readfds;
    int ready, nfds;
    struct timespec timeout;
    struct timespec *pto;
    struct sigaction sa;
#ifdef USE_PSELECT_SYSCALL
    struct {
        sigset_t *sp;
        size_t size;
    } pselarg6;
#endif
    sigset_t empty, all;

    if (argc != 2) {
        fprintf(stderr, "Usage: %s {nsecs|-}\n", argv[1]);
        exit(EXIT_FAILURE);
    }

    setbuf(stdout, NULL);

   /* Block all sigs */

    sigfillset(&all);
    if (sigprocmask(SIG_BLOCK, &all, NULL) == -1) errExit("sigprocmask");

    /* Establish hander for SIGINT */

    sa.sa_handler = handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    if (sigaction(SIGINT, &sa, NULL) == -1) errExit("sigaction");

    /* Timeout is specified in argv[1] */

    if (strcmp(argv[1], "-") == 0) {
        pto = NULL;             /* Infinite timeout */
    } else {
        pto = &timeout;
        timeout.tv_sec = atoi(argv[1]);
        timeout.tv_nsec = 0;
    }

    /* Initialize descriptor set */

    nfds = 1;
    FD_ZERO(&readfds);
    FD_SET(STDIN_FILENO, &readfds);

    sigemptyset(&empty);
    /* sigaddset(&empty, SIGINT); */

    /* Make the call */

#ifdef USE_PSELECT_SYSCALL
#if 1
    printf("Making syscall(SYS_pselect6) call\n");
    pselarg6.sp = &empty;
    pselarg6.size = 8; /* sizeof(sigset_t) */
    ready = syscall(SYS_pselect6, nfds, &readfds, NULL, NULL,
                    pto, &pselarg6);
#else
    /* The following is just some testing cruft */
    {
    struct timeval tv;
    struct timeval *ptv;

    if (strcmp(argv[1], "-") == 0) {
        ptv = NULL;             /* Infinite timeout */
    } else {
        ptv = &tv;
        tv.tv_sec = atoi(argv[1]);
        tv.tv_usec = 0;
    }

    if (sigprocmask(SIG_SETMASK, &empty, NULL) == -1)
        errExit("sigprocmask");

    printf("Making syscall(SYS__newselect) call\n");
    ready = syscall(SYS__newselect, nfds, &readfds, NULL, NULL, ptv);
    printf("!!!! Ignore timeout information printed below !!!!\n");
    }
#endif


#else
    /* This is how a "proper" pselect() call looks on other
       implementations, or when calling the non-atomic glibc version */
    printf("Making simple pselect() call\n");
    ready = pselect(nfds, &readfds, NULL, NULL, pto, &empty);
#endif

    /* Now see what happened */

    if (ready == -1) errMsg("pselect");

    printf("ready = %d\n", ready);
    printf("stdin %s readable\n",
                ready > 0 && FD_ISSET(STDIN_FILENO, &readfds) ?
                        "IS" : "IS NOT");
    printf("Signal handler %s called\n", gotsig ? "WAS" : "WAS NOT");

    if (pto != NULL)
        printf("timeout after select(): %ld.%03ld\n",
               (long) timeout.tv_sec, (long) timeout.tv_nsec / 10000000);
    exit(EXIT_SUCCESS);
} /* main */

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++
