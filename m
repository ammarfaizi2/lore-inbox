Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVHWR5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVHWR5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVHWR5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:57:47 -0400
Received: from siaag2ag.compuserve.com ([149.174.40.140]:16850 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S932256AbVHWR5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:57:47 -0400
Date: Tue, 23 Aug 2005 13:54:56 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc6] i386: fix incorrect FP signal delivery
To: Andi Kleen <ak@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200508231357_MC3-1-A810-1891@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2005 02:20:07 +0200, Andi Kleen wrote:

> every reviewer has to look up all the bits in the manual?

 I fixed the test program too:

 Before patch:

$ ./fpsig
handler: signum = 8, errno = 0, code = 0 [unknown]
handler: fpu cwd = 0xb40, fpu swd = 0xbaa0
handler: i387 unmasked precision exception, rounded up

 After:

$ ./fpsig
handler: signum = 8, errno = 0, code = 6 [inexact result]
handler: fpu cwd = 0xb40, fpu swd = 0xbaa0
handler: i387 unmasked precision exception, rounded up

/* i387 fp signal test */

#define _GNU_SOURCE
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <errno.h>

__attribute__ ((aligned(4096))) unsigned char altstack[4096];
unsigned short cw = 0x0b40; /* unmask all exceptions, round up */
struct sigaction sa;
stack_t ss = {
	.ss_sp   = &altstack[2047],
	.ss_size = sizeof(altstack)/2,
};

static void handler(int nr, siginfo_t *si, void *uc)
{
	char *decode;
	int code = si->si_code;
	unsigned short cwd = *(unsigned short *)&altstack[0xd84];
	unsigned short swd = *(unsigned short *)&altstack[0xd88];

	switch (code) {
		case FPE_INTDIV:
			decode = "divide by zero";
			break;
		case FPE_FLTRES:
			decode = "inexact result";
			break;
		case FPE_FLTINV:
			decode = "invalid operation";
			break;
		default:
			decode = "unknown";
			break;
	}
	printf("handler: signum = %d, errno = %d, code = %d [%s]\n",
		si->si_signo, si->si_errno, code, decode);
	printf("handler: fpu cwd = 0x%hx, fpu swd = 0x%hx\n", cwd, swd);
	if (swd & 0x20 & ~cwd)
		printf("handler: i387 unmasked precision exception, rounded %s\n",
			swd & 0x200 ? "up" : "down");
	exit(1);
}

int main(int argc, char * const argv[])
{
	sa.sa_sigaction = handler;
	sa.sa_flags     = SA_ONSTACK | SA_SIGINFO;

	if (sigaltstack(&ss, 0))
		perror("sigaltstack");
	if (sigaction(SIGFPE, &sa, NULL))
		perror("sigaction");

	asm volatile ("fnclex ; fldcw %0" : : "m" (cw));
	asm volatile ( /*  st(1) = 3.0, st = 1.0  */
	    "fld1 ; fld1 ; faddp ; fld1 ; faddp ; fld1");
	asm volatile (
	    "fdivp ; fwait");  /*  1.0 / 3.0  */

	return 0;
}
__
Chuck
