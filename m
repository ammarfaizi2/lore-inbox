Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVHVXqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVHVXqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVHVXqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:46:45 -0400
Received: from siaag2ai.mx.compuserve.com ([149.174.40.147]:6081 "EHLO
	siaag2ai.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751310AbVHVXqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:46:44 -0400
Date: Mon, 22 Aug 2005 19:43:57 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc6] i386: fix incorrect FP signal delivery
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <200508221945_MC3-1-A7EF-CB11@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch fixes a problem with incorrect floating-point exception
signal delivery on i386 kernels.  In some cases, an error code of zero
is delivered instead of the correct code, as the output from my test
program shows:


Before patch:

$ ./fpsig
handler: signum = 8, errno = 0, code = 0
handler: fpu cwd = 0xb40, fpu swd = 0xbaa0


After:

$ ./fpsig
handler: signum = 8, errno = 0, code = 6
handler: fpu cwd = 0xb40, fpu swd = 0xbaa0


2.4 also has this problem; the patch applies with offsets on 2.4.31
but I didn't test it beyond that.  Patch also applies to 2.6.13-rc6-mm1
with offsets.

x86-64 also looks to be affected but I have no way to test it


Test program:

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
	printf("handler: signum = %d, errno = %d, code = %d\n",
		si->si_signo, si->si_errno, si->si_code);
	printf("handler: fpu cwd = 0x%hx, fpu swd = 0x%hx\n",
		*(unsigned short *)&altstack[0xd84],
		*(unsigned short *)&altstack[0xd88]);
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


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>


 arch/i386/kernel/traps.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--- 2.6.13-rc6a.orig/arch/i386/kernel/traps.c
+++ 2.6.13-rc6a/arch/i386/kernel/traps.c
@@ -778,7 +778,7 @@ void math_error(void __user *eip)
 {
 	struct task_struct * task;
 	siginfo_t info;
-	unsigned short cwd, swd;
+	unsigned short cwd, swd, wd;
 
 	/*
 	 * Save the info for the exception handler and clear the error.
@@ -803,7 +803,11 @@ void math_error(void __user *eip)
 	 */
 	cwd = get_fpu_cwd(task);
 	swd = get_fpu_swd(task);
-	switch (((~cwd) & swd & 0x3f) | (swd & 0x240)) {
+	wd = swd & 0x3f & ~cwd;
+	if (wd & 1)
+		wd |= swd & 0x240;
+
+	switch (wd) {
 		case 0x000:
 		default:
 			break;
__
Chuck
