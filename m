Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAYPJk>; Thu, 25 Jan 2001 10:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAYPJa>; Thu, 25 Jan 2001 10:09:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:55023 "EHLO
	e34.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S129143AbRAYPJ0>; Thu, 25 Jan 2001 10:09:26 -0500
From: jekacur@ca.ibm.com
Importance: Normal
Subject: Re: [Fwd: sigcontext on Linux-ppc in user space]
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF38EA3C4D.2A886AF4-ON852569DF.00530F62@LocalDomain>
Date: Thu, 25 Jan 2001 10:09:07 -0500
X-MIMETrack: Serialize by Router on D25ML03/25/M/IBM(Release 5.0.4a |July 24, 2000) at
 01/25/2001 10:09:13 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Kacur/Toronto/IBM@IBMCA
jekacur@ca.ibm.com
(416) 448-2584 (phone)
778-2584 (tie line)


---------------------- Forwarded by John Kacur/Toronto/IBM on 01/25/2001
10:06 AM ---------------------------

John Kacur
01/24/2001 04:47 PM

To:   aj@suse.de
cc:   aj@arthur.inka.de
From: John Kacur/Toronto/IBM@IBMCA
Subject:  Re: [Fwd: sigcontext on Linux-ppc in user space]  (Document link:
      John Kacur)

Thanks for your reply. Yes, you are right I shouldn't include kernel files
in user space programs, and signal.h will contain what I need anyway. But I
still can't get at the sigcontext.c on Linux Powerpc. For example, this
simple program gives me a segmentation fault. (Linux ppc, suse 6.4, kernel
2.2.14


#include <stdio.h>
#include <signal.h>

/* Function Prototypes */
void install_sigusr1_handler(void);
void sigusr_handler(int , siginfo_t *, struct sigcontext * scp);

int main(void)
{
        install_sigusr1_handler();
        printf("SIGUSR1 = %d\n", SIGUSR1);
        raise(SIGUSR1);
        exit(0);
}

void install_sigusr1_handler(void)
{
        struct sigaction newAct;

        if (sigemptyset(&newAct.sa_mask) != 0) {
                fprintf(stderr, "Warning, sigemptyset failed.\n");
        }

        newAct.sa_flags = 0;
        newAct.sa_flags |= SA_SIGINFO | SA_RESTART;

        newAct.sa_sigaction = (void
(*)(int,siginfo_t*,void*))sigusr_handler;

        if (sigaction(SIGUSR1, &newAct, NULL) != 0) {
                fprintf(stderr, "Couldn't install SIGUSR1 handler.\n");
                fprintf(stderr, "Exiting.\n");
                exit(1);
        }
}

void sigusr_handler(int signo, siginfo_t *siginfp, struct sigcontext * scp)
{
        printf("scp = %08x\n", scp);
        printf("scp->signal = %d\n", scp->signal);
}

Ultimately, I want to get at the regs, ie scp->pt_regs->nip for example.

Any ideas?

Thanks.
John Kacur/Toronto/IBM@IBMCA
jekacur@ca.ibm.com
(416) 448-2584 (phone)
778-2584 (tie line)


John Kacur <jkacur@home.com>@e1.ny.us.ibm.com on 01/24/2001 10:26:30 AM

Please respond to John Kacur <jkacur@home.com>

Sent by:  jkacur@e1.ny.us.ibm.com


To:   John Kacur/Toronto/IBM@IBMCA
cc:
Subject:  [Fwd: sigcontext on Linux-ppc in user space]



----- Message from on -----
   
   
   

John Kacur <jkacur@home.com> writes:

> Does anyone know how to get at the struct sigcontext in a signal handler
> on Linux for powerpc? sigaction of course lets you create a signal
> handler as a function with the prototype void(*)(int, siginfo_t *, void
> *)
> where the last argument, a pointer to void, is the sigcontext. I believe
> that the last argument is NOT defined by POSIX and so is implementation
> dependent.
>
> On Intel it seems sufficient to use #include <asm/sigcontext.h>
> to get the definition of struct sigcontext, and then get the values
> you'd like out of the signal handler. But on Linux for powerpc, the same
> thing doesn't work. Does anyone know what the trick is here to
> accomplish this?

You should never include kernel headers in user space.

If you have a glibc 2.1 (or newer) based system, just include
<signal.h> which will include <bits/sigcontext.h> with the struct
(this works on all architectures).

Andreas
--
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
