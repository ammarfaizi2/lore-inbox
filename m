Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbULQXiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbULQXiO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbULQXiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:38:13 -0500
Received: from siaag2ad.compuserve.com ([149.174.40.134]:8332 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262230AbULQXhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:37:51 -0500
Date: Fri, 17 Dec 2004 18:35:38 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200412171837_MC3-1-9129-C5D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004 at 15:00:56 -0800 (PST) Linus Torvalds wrote:

> Checking for kernel CS also requires checking that it's not vm86 mode, 
> btw. So that's not just a "regs->xcs & 0xffff == __KERNEL_CS" either.
>
> But something like
> 
>       static inline int kernel_mode(struct pt_regs *regs)
>       {
>               return !((regs->eflags & VM_MASK) | (regs->xcs & 3));
>       }
>
> should DTRT.
>
> Can you pls double-check my thinking, and test?


 There is already a user_mode() macro in asm-i386/ptrace.h but it's slow.

 x86_64's macro is ugly but at least there's no logical-or in it.

 Your i386 code is better, so how about applying this patch (boots/runs/is faster
on my tests):

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- linux-2.6.9.1/include/asm-i386/ptrace.h     2004-10-19 15:28:18.000000000 -0400
+++ linux-2.6.9.2/include/asm-i386/ptrace.h     2004-12-17 16:59:39.956099664 -0500
@@ -55,7 +55,11 @@ struct pt_regs {
 #define PTRACE_SET_THREAD_AREA    26
 
 #ifdef __KERNEL__
-#define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
+static inline int kernel_mode(struct pt_regs *regs)
+{
+       return !((3 & (regs)->xcs) | (VM_MASK & (regs)->eflags));
+}
+#define user_mode(regs) (!kernel_mode(regs))
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);

--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
