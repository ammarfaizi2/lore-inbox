Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318254AbSG3NDe>; Tue, 30 Jul 2002 09:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSG3NDe>; Tue, 30 Jul 2002 09:03:34 -0400
Received: from pc2-oxfd3-5-cust41.oxf.cable.ntl.com ([213.107.67.41]:31239
	"EHLO noetbook.telent.net") by vger.kernel.org with ESMTP
	id <S318254AbSG3NDd>; Tue, 30 Jul 2002 09:03:33 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4, arch-dependent floating point exception and trap handling 
From: Daniel Barlow <dan@telent.net>
Date: Tue, 30 Jul 2002 14:06:57 +0100
Message-ID: <873cu1nz4e.fsf@noetbook.telent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing discrepancies between the way that floating point
exceptions are handled on different architectures.  Briefly, I have a
program that uses the glibc function feenableexcept() to enable SIGFPE
on divide-by-zero errors, then installs a SIGFPE handler that uses
sigsetjmp/siglongjmp, then divides 1.0 by 0.0 twice.

What I expect to happen is for my signal handler to be called twice.
What actually happens varies:

On Alpha: 2.4.19-pre1-ac2, gcc version 2.95.4 20011002, PCA56 (SX164)

:; cc -o foo foo.c -lm -mieee
foo.c: In function `main':
foo.c:23: warning: assignment from incompatible pointer type
:; ./foo
exceptions enabled: 0
exceptions enabled: 40000
hello
in handler
abort
in handler
abort
terminating

- exactly as expected

On x86: 2.4.19-rc1, gcc version 2.95.4 20011002 , Pentium III (Coppermine)

my signal handler is called the first time, and then the second
attempt gets "inf".  I've run this under gdb as well; the second SIGFPE is 
not received by the process

:; gcc -o foo foo.c -lm
foo.c: In function `main':
foo.c:23: warning: assignment from incompatible pointer type
:; ./foo
exceptions enabled: 0
exceptions enabled: 4
hello
in handler
abort
a/b=inf
terminating


On PPC: 2.4.19-pre8, gcc version 2.95.4 20011002,  266MHz 740/750 rev 2.2
(tangerine iMac) I have x86-like behaviour

:; cc -o foo foo.c -lm
foo.c: In function `main':
foo.c:23: warning: assignment from incompatible pointer type
:; ./foo
exceptions enabled: 0
exceptions enabled: 4000000
hello
in handler
abort
a/b=inf
terminating

All of these are uniprocessor machines running uniprocessor kernels.
The behaviour I'd like _most_ is for the pre-signal environment to be
restored, but at least to get the same behaviour everywhere would be a
good thing.

I append the test program I've been using so you can tell me whether
my whole approach is misguided

---cut here---
#include <signal.h>
#include <stdio.h>
#include <sys/signal.h>
#include <ucontext.h>
#include <fenv.h>
#include <setjmp.h>

sigjmp_buf env;
double a=1.0,b=0.0;

int handler(int signal, struct siginfo *info, struct ucontext *context) {
    printf("in handler\n");
    siglongjmp(env,signal);
}

main() {
    struct sigaction sa;

    a=1.0;
    printf("exceptions enabled: %x\n", fegetexcept());
    feenableexcept(FE_DIVBYZERO);   
    printf("exceptions enabled: %x\n", fegetexcept());
    sa.sa_sigaction = handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_SIGINFO | SA_RESTART;
    sigaction(SIGFPE, &sa, NULL); 
    printf("hello\n");
    /* first time */
    if(sigsetjmp(env,1)) printf("abort\n");
    else                 printf("a/b=%f\n", a/b);

    /* now try again, see if things were restored */
    if(sigsetjmp(env,1)) printf("abort\n");
    else                 printf("a/b=%f\n", a/b);
    printf("terminating\n");
}

--- cut here ---

If this message should have been sent elsewhere (e.g. to port-specific
lists or maintainers) please feel free to tell me where and/or to
forward it.

Thanks!


-dan

-- 

  http://ww.telent.net/cliki/ - Link farm for free CL-on-Unix resources 
