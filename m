Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVG0CAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVG0CAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 22:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVG0CAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 22:00:42 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:2450 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261964AbVG0CAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 22:00:39 -0400
Date: Tue, 26 Jul 2005 21:57:24 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc3] i386: clean up user_mode macros
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200507262159_MC3-1-A5A2-A862@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005 at 16:13:13 -0700 (PDT), Linus Torvalds wrote:

> On Mon, 25 Jul 2005, Chuck Ebbert wrote:
> > 
> > Recent patches from the Xen group changed the X86 user_mode macros.
> > 
> > This patch does the following:
> > 
> >         1. Makes the new user_mode() return 0 or 1 (same as x86_64)
>
> I _really_ prefer
> 
>       x != 0
> 
> over 
> 
>       !!x


  Take 2:  compile tested only.


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
===================================================================
--- 2.6.13-rc3.orig/include/asm-i386/ptrace.h
+++ 2.6.13-rc3/include/asm-i386/ptrace.h
@@ -57,14 +57,21 @@
 #ifdef __KERNEL__
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
-#define user_mode(regs)		(3 & (regs)->xcs)
-#define user_mode_vm(regs)	((VM_MASK & (regs)->eflags) || user_mode(regs))
+
+static inline int user_mode(struct pt_regs *regs)
+{
+	return (regs->xcs & 3) != 0;
+}
+static inline int user_mode_vm(struct pt_regs *regs)
+{
+	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
+}
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);
 #else
 #define profile_pc(regs) instruction_pointer(regs)
 #endif
-#endif
+#endif /* __KERNEL__ */
 
 #endif
__
Chuck
