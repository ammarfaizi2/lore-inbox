Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264317AbRFNFdk>; Thu, 14 Jun 2001 01:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264407AbRFNFdb>; Thu, 14 Jun 2001 01:33:31 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:42485 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S264320AbRFNFdR>;
	Thu, 14 Jun 2001 01:33:17 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: Question about signal handling
Date: Thu, 14 Jun 2001 01:33:08 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGAEJPCJAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010614050151.3779.qmail@nwcst292.netaddress.usa.net>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hopefully I'm not asking a really stupid question here, but...

	When setting up a signal handler, using sa_handler, there is a
quasi-documented 2nd parameter of 'struct context ctx' passed to the signal
handler.  This seems to work on 2.2.12, 2.2.18, and 2.4.5-ac2.  According to
various documents, when using sa_siginfo (and setting SA_SIGINFO), the third
parameter to the handler is defined as a 'void *', but actually passes a
'ucontext_t' data type.  Which is not defined in any kernel code, except for
the sparc64 branch.  Casting this to a 'struct context' or a 'struct context
*' doesn't seem to achieve the desired results on any of the three kernels I
tested.

	Google searches indicate different things.  POSIX 1 compliance says it
should be a 'ucontext_t *'
(www.opengroup.org/onlinepubs/007908799/xsh/sigaction.html+sigcontext+siginf
o_t+sigaction&hl=en&lr=lang_en) (I realize that's the Open standard, but the
comments at the bottom talk about POSIX compliance).  Other searches say it
returns as a 'struct context *'.

	I tried following the code through the kernel, but I'm not familiar enough
with yet to really understand how it's getting scheduled, and exactly which
parameters are getting passed back.

	What is the correct behavior supposed to be?  And if using sa_siginfo, how
does one get at the context parameters to find the EIP the fault occurred
at?

	Here's a sample bit of code I used for testing.  Leaving #define SIGACTION
demonstrates the third parameter not (seemingly) being passed as a context
pointer, #undef demonstrates the sa_handler 2 paramter handler, which
returns a correct context.

#include <stdio.h>
#include <signal.h>
#include <errno.h>
#include <string.h>

#define SIGACTION

#ifdef SIGACTION
void fSegvHandler (int sigNo, siginfo_t *si, void *p)
{
   struct sigcontext *context = (struct sigcontext *) p;
#else
void fSegvHandler (int sigNo, void *p)
{
   struct sigcontext *context = (struct sigcontext *) &p;
#endif

   printf ("\nContext: %08X\n",context);
   fflush (stdout);
   printf ("gs:  %04X\tfs:  %04X\tes:  %04X\tds:  %04X\n"
           "edi: %08X\tesi: %08X\tebp: %04X\tesp: %04X\n"
           "ebx: %08X\tedx: %08X\tecx: %08X\teax: %08X\n"
           "trap: %d\terr: %d\teip: %08X\tcs:  %04X\n"
           "flag: %08X\tSP: %08X\tss:  %04X\tcr2: %08X\n",
           context->gs, context->fs, context->es, context->ds,
           context->edi, context->esi, context->ebp, context->esp,
           context->ebx, context->edx, context->ecx, context->eax,
           context->trapno, context->err, context->eip, context->cs,
           context->eflags, context->esp_at_signal, context->ss,
context->cr2);
   fflush (stdout);
   exit (0);
}

int main (int argc, char **argv)
{
   struct sigaction sSegvHdl;

   sigemptyset (&sSegvHdl.sa_mask);
   sigaddset (&sSegvHdl.sa_mask, SIGSEGV);

#ifdef SIGACTION
   sSegvHdl.sa_flags   = SA_SIGINFO | SA_ONESHOT;
   sSegvHdl.sa_sigaction = fSegvHandler;
#else
   sSegvHdl.sa_flags   = SA_ONESHOT;
   sSegvHdl.sa_handler = fSegvHandler;
#endif

   if (sigaction (SIGSEGV, &sSegvHdl, NULL))
      perror ("sigaction");
   else
      *(char *) 0x0 = 0x01;
}

	-- John



