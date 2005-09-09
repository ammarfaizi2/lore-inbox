Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbVIIF1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbVIIF1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 01:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965260AbVIIF1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 01:27:43 -0400
Received: from siaag2ah.compuserve.com ([149.174.40.141]:40490 "EHLO
	siaag2ah.compuserve.com") by vger.kernel.org with ESMTP
	id S965257AbVIIF1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 01:27:43 -0400
Date: Fri, 9 Sep 2005 01:25:51 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13]  x86_64: Fix incorrect FP signals
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509090127_MC3-1-A998-1B0D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same patch that went into i386 just before 2.6.13
came out.  I still can't build 64-bit user apps, so I tested
with program (see below) in 32-bit mode on 64-bit kernel:

Before:

$ fpsig
handler: nr = 8, si = 0x0804bc90, vuc = 0x0804bd10
handler: altstack is at 0x0804b000, ebp = 0x0804bc7c
handler: si_signo = 8, si_errno = 0, si_code = 0 [unknown]
handler: fpu cwd = 0xb40, fpu swd = 0xbaa0
handler: i387 unmasked precision exception, rounded up

After:

$ fpsig
handler: nr = 8, si = 0x0804bc90, vuc = 0x0804bd10
handler: altstack is at 0x0804b000, ebp = 0x0804bc7c
handler: si_signo = 8, si_errno = 0, si_code = 6 [inexact result]
handler: fpu cwd = 0xb40, fpu swd = 0xbaa0
handler: i387 unmasked precision exception, rounded up


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/x86_64/kernel/traps.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

--- 2.6.13-64.orig/arch/x86_64/kernel/traps.c
+++ 2.6.13-64/arch/x86_64/kernel/traps.c
@@ -786,13 +786,16 @@ asmlinkage void do_coprocessor_error(str
 	 */
 	cwd = get_fpu_cwd(task);
 	swd = get_fpu_swd(task);
-	switch (((~cwd) & swd & 0x3f) | (swd & 0x240)) {
+	switch (swd & ~cwd & 0x3f) {
 		case 0x000:
 		default:
 			break;
 		case 0x001: /* Invalid Op */
-		case 0x041: /* Stack Fault */
-		case 0x241: /* Stack Fault | Direction */
+			/*
+			 * swd & 0x240 == 0x040: Stack Underflow
+			 * swd & 0x240 == 0x240: Stack Overflow
+			 * User must clear the SF bit (0x40) if set
+			 */
 			info.si_code = FPE_FLTINV;
 			break;
 		case 0x002: /* Denormalize */
================================================================================
/* i387 fp signal test */

#define _GNU_SOURCE
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <errno.h>

/* define this to nozero to hexdump the altstack */
#define DUMP_STACK 0

#define STACKSIZE 4096
__attribute__ ((aligned(STACKSIZE))) unsigned char altstack[STACKSIZE];
stack_t ss = {
	.ss_sp   = altstack,
	.ss_size = sizeof(altstack),
};
unsigned short cw = 0x0b40; /* unmask all exceptions, round up */
struct sigaction sa;

static void handler(int nr, siginfo_t *si, void *vuc)
{
	char *decode;
	unsigned int ebp;
	int code = si->si_code;
	struct ucontext *uc = (struct ucontext *)vuc;
	struct sigcontext *sc = (struct sigcontext *)&uc->uc_mcontext;
	unsigned short cwd = (unsigned short)sc->fpstate->cw;
	unsigned short swd = (unsigned short)sc->fpstate->sw;

	switch (code) {
		case FPE_INTDIV:
			decode = "divide by zero";
			break;
		case FPE_FLTRES:
			decode = "inexact result";
			break;
		case FPE_FLTINV:
			decode = "invalid operand";
			break;
		default:
			decode = "unknown";
			break;
	}
	asm volatile ("mov %%ebp, %0" : "=m" (ebp));
	printf("handler: nr = %d, si = 0x%08x, vuc = 0x%08x\n",
		nr, (unsigned int)si, (unsigned int)vuc);
	printf("handler: altstack is at 0x%08x, ebp = 0x%08x\n",
		(unsigned int)altstack, ebp);
	printf("handler: si_signo = %d, si_errno = %d, si_code = %d [%s]\n",
		si->si_signo, si->si_errno, code, decode);
#if DUMP_STACK
#define ROWSIZE 16
	{
	int empty, i, j;
	for (i = 0; i < sizeof(altstack); i += ROWSIZE) {
		empty = 1;
		for (j = 0; j < ROWSIZE; j++)
			if (altstack[i + j])
				empty = 0;
		if (!empty) {
			printf("%04x: ", i);
			for (j = 0; j < ROWSIZE; j++)
				printf("%02hhx ", altstack[i + j]);
			printf("\n");
		}
	}
	}
#endif /* DUMP_STACK */

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
		"mov $0xaaaaaaaa,%%eax ; mov $0xbbbbbbbb,%%ebx ; "
		"mov $0xcccccccc,%%ecx ; mov $0xdddddddd,%%edx ; "
		"fdivp ; fwait" : : : "eax", "ebx", "ecx", "edx");

	return 0;
}
__
Chuck
