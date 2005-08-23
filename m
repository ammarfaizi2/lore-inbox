Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVHWCt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVHWCt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 22:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVHWCt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 22:49:57 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:40878 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750797AbVHWCt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 22:49:56 -0400
Date: Mon, 22 Aug 2005 22:47:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc6] i386: fix incorrect FP signal delivery
To: Andi Kleen <ak@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200508222249_MC3-1-A800-4F7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2005 02:20:07 +0200, Andi Kleen wrote:

> How about you describe what you actually changed and why so that not 
> every reviewer has to look up all the bits in the manual?


 The patch had a bug anyway, so here's another try.  *** Replace
the previous patch with this one. ***


i386 floating-point exception handling has a bug that can cause error
code 0 to be sent instead of the proper code during signal delivery.
This is caused by unconditionally checking the IS and c1 bits from
the FPU status word when they are not always relevant.  The IS bit
tells whether an exception is a stack fault and is only relevant
when the exception is IE (invalid operation.)  The C1 bit determines
whether a stack fault is overflow or underflow and is only relevant
when IS and IE are set.

This bug also exists in the 2.4 kernel and appears to be in the 2.6
x86_64 code as well.

Patch applies with offsets to 2.4.31 and 2.6.13-rc6-mm1.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/i386/kernel/traps.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

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
@@ -803,7 +803,21 @@ void math_error(void __user *eip)
 	 */
 	cwd = get_fpu_cwd(task);
 	swd = get_fpu_swd(task);
-	switch (((~cwd) & swd & 0x3f) | (swd & 0x240)) {
+	wd = swd & 0x3f & ~cwd;
+	/*
+	 * If the exception is invalid operation, the IS bit is needed
+	 * to see if it's a stack fault.
+	 */
+	if (wd & 1)
+		wd |= swd & 0x40;
+	/*
+	 * If it's a stack fault, C1 is needed to see if it's overflow or
+	 * underflow.
+	 */
+	if (wd & 0x40)
+		wd |= swd & 0x200;
+
+	switch (wd) {
 		case 0x000:
 		default:
 			break;
__
Chuck
