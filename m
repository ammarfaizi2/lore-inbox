Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVEWPsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVEWPsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVEWPsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:48:32 -0400
Received: from fmr19.intel.com ([134.134.136.18]:12753 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261899AbVEWPrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:47:25 -0400
Message-Id: <20050523154228.049327000@csdlinux-2.jf.intel.com>
References: <20050523153906.988390000@csdlinux-2.jf.intel.com>
Date: Mon, 23 May 2005 08:39:07 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: tony.luck@intel.com, rohit.seth@intel.com, rusty.lynch@intel.com,
       prasanna@in.ibm.com, ananth@in.ibm.com, systemtap@sources.redhat.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com
Subject: [patch 1/4] Kprobes support for IA64
Content-Disposition: inline; filename=kprobes-ia64-kdebug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the kdebug die notification mechanism needed by Kprobes.

For break instruction on Branch type slot, imm21 is ignored and value
zero is placed in IIM register, hence we need to handle kprobes
for switch case zero.
=========================================================================

signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>
=========================================================================

 arch/ia64/kernel/traps.c  |   33 ++++++++++++++++++++++++
 arch/ia64/mm/fault.c      |    8 ++++++
 include/asm-ia64/break.h  |    2 +
 include/asm-ia64/kdebug.h |   61 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc4/arch/ia64/kernel/traps.c
===================================================================
--- linux-2.6.12-rc4.orig/arch/ia64/kernel/traps.c	2005-05-19 15:39:40.000000000 -0700
+++ linux-2.6.12-rc4/arch/ia64/kernel/traps.c	2005-05-22 23:27:53.000000000 -0700
@@ -21,12 +21,26 @@
 #include <asm/intrinsics.h>
 #include <asm/processor.h>
 #include <asm/uaccess.h>
+#include <asm/kdebug.h>
 
 extern spinlock_t timerlist_lock;
 
 fpswa_interface_t *fpswa_interface;
 EXPORT_SYMBOL(fpswa_interface);
 
+struct notifier_block *ia64die_chain;
+static DEFINE_SPINLOCK(die_notifier_lock);
+
+int register_die_notifier(struct notifier_block *nb)
+{
+	int err = 0;
+	unsigned long flags;
+	spin_lock_irqsave(&die_notifier_lock, flags);
+	err = notifier_chain_register(&ia64die_chain, nb);
+	spin_unlock_irqrestore(&die_notifier_lock, flags);
+	return err;
+}
+
 void __init
 trap_init (void)
 {
@@ -119,6 +133,10 @@
 
 	switch (break_num) {
 	      case 0: /* unknown error (used by GCC for __builtin_abort()) */
+		if (notify_die(DIE_BREAK, "kprobe", regs, break_num, TRAP_BRKPT, SIGTRAP)
+			       	== NOTIFY_STOP) {
+			return;
+		}
 		die_if_kernel("bugcheck!", regs, break_num);
 		sig = SIGILL; code = ILL_ILLOPC;
 		break;
@@ -171,6 +189,15 @@
 		sig = SIGILL; code = __ILL_BNDMOD;
 		break;
 
+	      case 0x80200:
+	      case 0x80300:
+		if (notify_die(DIE_BREAK, "kprobe", regs, break_num, TRAP_BRKPT, SIGTRAP)
+			       	== NOTIFY_STOP) {
+			return;
+		}
+		sig = SIGTRAP; code = TRAP_BRKPT;
+		break;
+
 	      default:
 		if (break_num < 0x40000 || break_num > 0x100000)
 			die_if_kernel("Bad break", regs, break_num);
@@ -521,7 +548,11 @@
 #endif
 			break;
 		      case 35: siginfo.si_code = TRAP_BRANCH; ifa = 0; break;
-		      case 36: siginfo.si_code = TRAP_TRACE; ifa = 0; break;
+		      case 36:
+			      if (notify_die(DIE_SS, "ss", &regs, vector,
+					     vector, SIGTRAP) == NOTIFY_STOP)
+				      return;
+			      siginfo.si_code = TRAP_TRACE; ifa = 0; break;
 		}
 		siginfo.si_signo = SIGTRAP;
 		siginfo.si_errno = 0;
Index: linux-2.6.12-rc4/arch/ia64/mm/fault.c
===================================================================
--- linux-2.6.12-rc4.orig/arch/ia64/mm/fault.c	2005-05-19 15:39:40.000000000 -0700
+++ linux-2.6.12-rc4/arch/ia64/mm/fault.c	2005-05-22 23:05:02.000000000 -0700
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/kdebug.h>
 
 extern void die (char *, struct pt_regs *, long);
 
@@ -102,6 +103,13 @@
 		goto bad_area_no_up;
 #endif
 
+	/*
+	 * This is to handle the kprobes on user space access instructions
+	 */
+	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, code, TRAP_BRKPT,
+					SIGSEGV) == NOTIFY_STOP)
+		return;
+
 	down_read(&mm->mmap_sem);
 
 	vma = find_vma_prev(mm, address, &prev_vma);
Index: linux-2.6.12-rc4/include/asm-ia64/break.h
===================================================================
--- linux-2.6.12-rc4.orig/include/asm-ia64/break.h	2005-05-19 15:39:40.000000000 -0700
+++ linux-2.6.12-rc4/include/asm-ia64/break.h	2005-05-19 15:39:44.000000000 -0700
@@ -12,6 +12,8 @@
  * OS-specific debug break numbers:
  */
 #define __IA64_BREAK_KDB		0x80100
+#define __IA64_BREAK_KPROBE		0x80200
+#define __IA64_BREAK_JPROBE		0x80300
 
 /*
  * OS-specific break numbers:
Index: linux-2.6.12-rc4/include/asm-ia64/kdebug.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc4/include/asm-ia64/kdebug.h	2005-05-19 15:39:44.000000000 -0700
@@ -0,0 +1,61 @@
+#ifndef _IA64_KDEBUG_H
+#define _IA64_KDEBUG_H 1
+/*
+ * include/asm-ia64/kdebug.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) Intel Corporation, 2005
+ *
+ * 2005-Apr     Rusty Lynch <rusty.lynch@intel.com> and Anil S Keshavamurthy
+ *              <anil.s.keshavamurthy@intel.com> adopted from
+ *              include/asm-x86_64/kdebug.h
+ */
+#include <linux/notifier.h>
+
+struct pt_regs;
+
+struct die_args {
+	struct pt_regs *regs;
+	const char *str;
+	long err;
+	int trapnr;
+	int signr;
+};
+
+int register_die_notifier(struct notifier_block *nb);
+extern struct notifier_block *ia64die_chain;
+
+enum die_val {
+	DIE_BREAK = 1,
+	DIE_SS,
+	DIE_PAGE_FAULT,
+};
+
+static inline int notify_die(enum die_val val, char *str, struct pt_regs *regs,
+			     long err, int trap, int sig)
+{
+	struct die_args args = {
+		.regs   = regs,
+		.str    = str,
+		.err    = err,
+		.trapnr = trap,
+		.signr  = sig
+	};
+
+	return notifier_call_chain(&ia64die_chain, val, &args);
+}
+
+#endif

--
