Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVEaXIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVEaXIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 19:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVEaXIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 19:08:46 -0400
Received: from fmr22.intel.com ([143.183.121.14]:41101 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261252AbVEaXId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 19:08:33 -0400
Date: Tue, 31 May 2005 16:08:15 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: anil.s.keshavamurthy@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       prasanna@in.ibm.com, rusty.lynch@intel.com
Subject: [patch 1/1] Kprobes temporary disarming of reentrant probe for IA64
Message-ID: <20050531160815.B15152@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: kprobes temporary disarming of reentrant probe for ia64

This patch includes IA64 architecture specific changes(ported form i386)
to support temporary disarming on reentrancy of probes.

In case of reentrancy we single step without calling user handler.


signed-of-by: Anil S Keshavamurth <anil.s.keshavamurthy@intel.com>
======================================================================

 arch/ia64/kernel/kprobes.c |   49 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 43 insertions(+), 6 deletions(-)

Index: linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
@@ -41,8 +41,8 @@ extern void jprobe_inst_return(void);
 #define KPROBE_HIT_ACTIVE	0x00000001
 #define KPROBE_HIT_SS		0x00000002
 
-static struct kprobe *current_kprobe;
-static unsigned long kprobe_status;
+static struct kprobe *current_kprobe, *kprobe_prev;
+static unsigned long kprobe_status, kprobe_status_prev;
 static struct pt_regs jprobe_saved_regs;
 
 enum instruction_type {A, I, M, F, B, L, X, u};
@@ -81,6 +81,23 @@ static enum instruction_type bundle_enco
   { u, u, u },  			/* 1F */
 };
 
+static inline void save_previous_kprobe(void)
+{
+	kprobe_prev = current_kprobe;
+	kprobe_status_prev = kprobe_status;
+}
+
+static inline void restore_previous_kprobe(void)
+{
+	current_kprobe = kprobe_prev;
+	kprobe_status = kprobe_status_prev;
+}
+
+static inline void set_current_kprobe(struct kprobe *p)
+{
+	current_kprobe = p;
+}
+
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long) p->addr;
@@ -301,8 +318,18 @@ static int pre_kprobes_handler(struct di
 				unlock_kprobes();
 				goto no_kprobe;
 			}
-			arch_disarm_kprobe(p);
-			ret = 1;
+			/* We have reentered the pre_kprobe_handler(), since
+			 * another probe was hit while within the handler.
+			 * We here save the original kprobes variables and
+			 * just single step on the instruction of the new probe
+			 * without calling any user handlers.
+			 */
+			save_previous_kprobe();
+			set_current_kprobe(p);
+			p->nmissed++;
+			prepare_ss(p, regs);
+			kprobe_status = KPROBE_REENTER;
+			return 1;
 		} else if (args->err == __IA64_BREAK_JPROBE) {
 			/*
 			 * jprobe instrumented function just completed
@@ -325,7 +352,7 @@ static int pre_kprobes_handler(struct di
 	}
 
 	kprobe_status = KPROBE_HIT_ACTIVE;
-	current_kprobe = p;
+	set_current_kprobe(p);
 
 	if (p->pre_handler && p->pre_handler(p, regs))
 		/*
@@ -350,12 +377,22 @@ static int post_kprobes_handler(struct p
 	if (!kprobe_running())
 		return 0;
 
-	if (current_kprobe->post_handler)
+	if ((kprobe_status != KPROBE_REENTER) && current_kprobe->post_handler) {
+		kprobe_status = KPROBE_HIT_SSDONE;
 		current_kprobe->post_handler(current_kprobe, regs, 0);
+	}
 
 	resume_execution(current_kprobe, regs);
 
+	/*Restore back the original saved kprobes variables and continue. */
+	if (kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe();
+		goto out;
+	}
+
 	unlock_kprobes();
+
+out:
 	preempt_enable_no_resched();
 	return 1;
 }
