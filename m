Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRAYVHS>; Thu, 25 Jan 2001 16:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131850AbRAYVGn>; Thu, 25 Jan 2001 16:06:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:58330 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S136140AbRAYVGW>; Thu, 25 Jan 2001 16:06:22 -0500
From: jekacur@ca.ibm.com
Importance: Normal
Subject: Re:sigcontext on Linux-ppc in user space, another hack.
To: khendricks@ivey.uwo.ca, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF3C25E159.46E6987C-ON852569DF.00700BFE@LocalDomain>
Date: Thu, 25 Jan 2001 15:31:38 -0500
X-MIMETrack: Serialize by Router on D25ML03/25/M/IBM(Release 5.0.4a |July 24, 2000) at
 01/25/2001 04:06:09 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears you can just use the siginfo_t * as the struct sigcontext *
!!!!!!
ie
void *signal_handler(int signo, siginfo_t *siginfoptr, struct sigcontext
*scp)
{
     scp = (struct sigcontext_struct *)siginfoptr;
     /* the rest of your code, here */
}


John Kacur/Toronto/IBM@IBMCA
jekacur@ca.ibm.com
(416) 448-2584 (phone)
778-2584 (tie line)


"Kevin B. Hendricks" <khendricks@ivey.uwo.ca> on 01/25/2001 02:02:20 PM

Please respond to khendricks@ivey.uwo.ca

To:   John Kacur/Toronto/IBM@IBMCA
cc:
Subject:  Re: [Fwd: sigcontext on Linux-ppc in user space]


Hi,

Just in case this helps,  here is what I did to accomplish the same thing
in the green_threads jdk.  It definitely is not portable.

Kevin

Inside the signal handler:

#elif defined(__linux__) && defined(__powerpc__)
    /* get the value of r1 (the stack pointer) */
    long * p;
    struct sigcontext_struct * scp;
    __asm__ ( "addi %0,1,0" : "=r" (p) : /* no inputs */ );
    /* follow it back up the chain */
    p = *p;
    /* from here the sigcontext struct is 64 bytes away */
    p = p + 16;
    scp = (struct sigcontext_struct *)p;

On Thursday, January 25, 2001, at 01:50 PM, jekacur@ca.ibm.com wrote:

>
> Ok, actually the segfault was for a more complicated function, but the
> simplified example still gives the wrong answer. i.e scp should point to
a
> struct sigcontext and scp->signal should be 10 in the sample program.
>
> John Kacur/Toronto/IBM@IBMCA
> jekacur@ca.ibm.com
> (416) 448-2584 (phone)
> 778-2584 (tie line)
>
>
> "Kevin B. Hendricks" <khendricks@ivey.uwo.ca> on 01/25/2001 01:10:40 PM
>
> Please respond to khendricks@ivey.uwo.ca
>
> To:   John Kacur/Toronto/IBM@IBMCA
> cc:   linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
> Subject:  Re: [Fwd: sigcontext on Linux-ppc in user space]
>
>
> Hi,
>
> Here is what I get from running it on my system (ppc linux with 2.2.15
> kernel with some mods and glibc-2.1.3).
>
> But no segfault.
>
> Kevin
>
>
> [kbhend@localhost ~]$ gcc -O2 -ojunk junk.c
> [kbhend@localhost ~]$ ./junk
> SIGUSR1 = 10
> scp = 7fffe9a4
> scp->signal = 0
> [kbhend@localhost ~]$
>
>
>
>
> On Thursday, January 25, 2001, at 10:09 AM, jekacur@ca.ibm.com wrote:
>
> > #include <stdio.h>
> > #include <signal.h>
> >
> > /* Function Prototypes */
> > void install_sigusr1_handler(void);
> > void sigusr_handler(int , siginfo_t *, struct sigcontext * scp);
> >
> > int main(void)
> > {
> >         install_sigusr1_handler();
> >         printf("SIGUSR1 = %d\n", SIGUSR1);
> >         raise(SIGUSR1);
> >         exit(0);
> > }
> >
> > void install_sigusr1_handler(void)
> > {
> >         struct sigaction newAct;
> >
> >         if (sigemptyset(&newAct.sa_mask) != 0) {
> >                 fprintf(stderr, "Warning, sigemptyset failed.\n");
> >         }
> >
> >         newAct.sa_flags = 0;
> >         newAct.sa_flags |= SA_SIGINFO | SA_RESTART;
> >
> >         newAct.sa_sigaction = (void
> > (*)(int,siginfo_t*,void*))sigusr_handler;
> >
> >         if (sigaction(SIGUSR1, &newAct, NULL) != 0) {
> >                 fprintf(stderr, "Couldn't install SIGUSR1 handler.\n");

> >                 fprintf(stderr, "Exiting.\n");
> >                 exit(1);
> >         }
> > }
> >
> > void sigusr_handler(int signo, siginfo_t *siginfp, struct sigcontext *
> scp)
> > {
> >         printf("scp = %08x\n", scp);
> >         printf("scp->signal = %d\n", scp->signal);
> > }
> >
> >
>
>
>
>




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
