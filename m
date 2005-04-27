Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVD0SlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVD0SlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVD0Sjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:39:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:22444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261948AbVD0Sin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:38:43 -0400
Date: Wed, 27 Apr 2005 11:38:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [10/07] sparc: Fix PTRACE_CONT bogosity
Message-ID: <20050427183813.GV493@shell0.pdx.osdl.net>
References: <20050427171446.GA3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427171446.GA3195@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


SunOS aparently had this weird PTRACE_CONT semantic which
we copied.  If the addr argument is something other than
1, it sets the process program counter to whatever that
value is.

This is different from every other Linux architecture, which
don't do anything with the addr and data args.

This difference in particular breaks the Linux native GDB support
for fork and vfork tracing on sparc and sparc64.

There is no interest in running SunOS binaries using this weird
PTRACE_CONT behavior, so just delete it so we behave like other
platforms do.

From: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

===== arch/sparc/kernel/ptrace.c 1.22 vs edited =====
--- 1.22/arch/sparc/kernel/ptrace.c	2005-03-13 15:29:55 -08:00
+++ edited/arch/sparc/kernel/ptrace.c	2005-04-13 22:37:33 -07:00
@@ -531,18 +531,6 @@
 			pt_error_return(regs, EIO);
 			goto out_tsk;
 		}
-		if (addr != 1) {
-			if (addr & 3) {
-				pt_error_return(regs, EINVAL);
-				goto out_tsk;
-			}
-#ifdef DEBUG_PTRACE
-			printk ("Original: %08lx %08lx\n", child->thread.kregs->pc, child->thread.kregs->npc);
-			printk ("Continuing with %08lx %08lx\n", addr, addr+4);
-#endif
-			child->thread.kregs->pc = addr;
-			child->thread.kregs->npc = addr + 4;
-		}
 
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
===== arch/sparc64/kernel/ptrace.c 1.24 vs edited =====
--- 1.24/arch/sparc64/kernel/ptrace.c	2005-02-10 19:06:44 -08:00
+++ edited/arch/sparc64/kernel/ptrace.c	2005-04-16 20:52:21 -07:00
@@ -514,25 +563,6 @@
 			pt_error_return(regs, EIO);
 			goto out_tsk;
 		}
-		if (addr != 1) {
-			unsigned long pc_mask = ~0UL;
-
-			if ((child->thread_info->flags & _TIF_32BIT) != 0)
-				pc_mask = 0xffffffff;
-
-			if (addr & 3) {
-				pt_error_return(regs, EINVAL);
-				goto out_tsk;
-			}
-#ifdef DEBUG_PTRACE
-			printk ("Original: %016lx %016lx\n",
-				child->thread_info->kregs->tpc,
-				child->thread_info->kregs->tnpc);
-			printk ("Continuing with %016lx %016lx\n", addr, addr+4);
-#endif
-			child->thread_info->kregs->tpc = (addr & pc_mask);
-			child->thread_info->kregs->tnpc = ((addr + 4) & pc_mask);
-		}
 
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);


