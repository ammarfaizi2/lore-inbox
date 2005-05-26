Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVEZVaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVEZVaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVEZV3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:29:08 -0400
Received: from fmr22.intel.com ([143.183.121.14]:60626 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261800AbVEZVZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:25:49 -0400
Date: Thu, 26 May 2005 14:25:39 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       anil.s.keshavamurthy@intel.com, Rusty Lynch <rusty.lynch@intel.com>,
       systemtap@sources.redhat.com
Subject: Kprobes IA64 check jprobe break before handling
Message-ID: <20050526142539.A24770@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: anil.s.keshavamurthy@intel.com
Subject: Kprobes IA64 check jprobe break before handling

Once the jprobe instrumented function returns, it executes
a jprobe_break which is a break instruction with
__IA64_JPROBE_BREAK value. The current patch checks for
this break value, before assuming that jprobe 
instrumented function just completed.

The previous code was not checking for this value and
that was a bug.


Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
===================================================================


 arch/ia64/kernel/kprobes.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
@@ -284,10 +284,11 @@ static void prepare_ss(struct kprobe *p,
 	ia64_psr(regs)->ss = 1;
 }
 
-static int pre_kprobes_handler(struct pt_regs *regs)
+static int pre_kprobes_handler(struct die_args *args)
 {
 	struct kprobe *p;
 	int ret = 0;
+	struct pt_regs *regs = args->regs;
 	kprobe_opcode_t *addr = (kprobe_opcode_t *)instruction_pointer(regs);
 
 	preempt_disable();
@@ -302,7 +303,7 @@ static int pre_kprobes_handler(struct pt
 			}
 			arch_disarm_kprobe(p);
 			ret = 1;
-		} else {
+		} else if (args->err == __IA64_BREAK_JPROBE) {
 			/*
 			 * jprobe instrumented function just completed
 			 */
@@ -310,6 +311,9 @@ static int pre_kprobes_handler(struct pt
 			if (p->break_handler && p->break_handler(p, regs)) {
 				goto ss_probe;
 			}
+		} else {
+			/* Not our break */
+			goto no_kprobe;
 		}
 	}
 
@@ -380,7 +384,7 @@ int kprobe_exceptions_notify(struct noti
 	struct die_args *args = (struct die_args *)data;
 	switch(val) {
 	case DIE_BREAK:
-		if (pre_kprobes_handler(args->regs))
+		if (pre_kprobes_handler(args))
 			return NOTIFY_STOP;
 		break;
 	case DIE_SS:
