Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVF2S0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVF2S0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVF2S0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:26:47 -0400
Received: from fmr19.intel.com ([134.134.136.18]:42716 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262401AbVF2S0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:26:38 -0400
Date: Wed, 29 Jun 2005 11:25:35 -0700
Message-Id: <200506291825.j5TIPZ1P016842@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
Subject: [patch][kprobes] fix namespace problem and sparc64 build
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net,
       systemtap@sources.redhat.com,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Ananth N Mavinakayanahalli <amavin@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following renames arch_init, a kprobes function for performing
any architecture specific initialization, to arch_init_kprobes in order
to cleanup the namespace.

Also, this patch adds arch_init_kprobes to sparc64 to fix the sparc64 kprobes
build from the last return probe patch.

    --rusty

 arch/i386/kernel/kprobes.c    |    2 +-
 arch/ia64/kernel/kprobes.c    |    2 +-
 arch/ppc64/kernel/kprobes.c   |    2 +-
 arch/sparc64/kernel/kprobes.c |    5 +++++
 arch/x86_64/kernel/kprobes.c  |    2 +-
 include/linux/kprobes.h       |    2 +-
 kernel/kprobes.c              |    2 +-
 7 files changed, 11 insertions(+), 6 deletions(-)

Index: sparc64-linux-2.6.12-mm2/arch/i386/kernel/kprobes.c
===================================================================
--- sparc64-linux-2.6.12-mm2.orig/arch/i386/kernel/kprobes.c
+++ sparc64-linux-2.6.12-mm2/arch/i386/kernel/kprobes.c
@@ -537,7 +537,7 @@ static struct kprobe trampoline_p = {
 	.pre_handler = trampoline_probe_handler
 };
 
-int __init arch_init(void)
+int __init arch_init_kprobes(void)
 {
 	return register_kprobe(&trampoline_p);
 }
Index: sparc64-linux-2.6.12-mm2/arch/ia64/kernel/kprobes.c
===================================================================
--- sparc64-linux-2.6.12-mm2.orig/arch/ia64/kernel/kprobes.c
+++ sparc64-linux-2.6.12-mm2/arch/ia64/kernel/kprobes.c
@@ -713,7 +713,7 @@ static struct kprobe trampoline_p = {
 	.pre_handler = trampoline_probe_handler
 };
 
-int __init arch_init(void)
+int __init arch_init_kprobes(void)
 {
 	trampoline_p.addr =
 		(kprobe_opcode_t *)((struct fnptr *)kretprobe_trampoline)->ip;
Index: sparc64-linux-2.6.12-mm2/arch/ppc64/kernel/kprobes.c
===================================================================
--- sparc64-linux-2.6.12-mm2.orig/arch/ppc64/kernel/kprobes.c
+++ sparc64-linux-2.6.12-mm2/arch/ppc64/kernel/kprobes.c
@@ -444,7 +444,7 @@ static struct kprobe trampoline_p = {
 	.pre_handler = trampoline_probe_handler
 };
 
-int __init arch_init(void)
+int __init arch_init_kprobes(void)
 {
 	return register_kprobe(&trampoline_p);
 }
Index: sparc64-linux-2.6.12-mm2/arch/sparc64/kernel/kprobes.c
===================================================================
--- sparc64-linux-2.6.12-mm2.orig/arch/sparc64/kernel/kprobes.c
+++ sparc64-linux-2.6.12-mm2/arch/sparc64/kernel/kprobes.c
@@ -433,3 +433,8 @@ int longjmp_break_handler(struct kprobe 
 	return 0;
 }
 
+/* architecture specific initialization */
+int arch_init_kprobes(void)
+{
+	return 0;
+}
Index: sparc64-linux-2.6.12-mm2/arch/x86_64/kernel/kprobes.c
===================================================================
--- sparc64-linux-2.6.12-mm2.orig/arch/x86_64/kernel/kprobes.c
+++ sparc64-linux-2.6.12-mm2/arch/x86_64/kernel/kprobes.c
@@ -682,7 +682,7 @@ static struct kprobe trampoline_p = {
 	.pre_handler = trampoline_probe_handler
 };
 
-int __init arch_init(void)
+int __init arch_init_kprobes(void)
 {
 	return register_kprobe(&trampoline_p);
 }
Index: sparc64-linux-2.6.12-mm2/include/linux/kprobes.h
===================================================================
--- sparc64-linux-2.6.12-mm2.orig/include/linux/kprobes.h
+++ sparc64-linux-2.6.12-mm2/include/linux/kprobes.h
@@ -155,7 +155,7 @@ extern void arch_copy_kprobe(struct kpro
 extern void arch_arm_kprobe(struct kprobe *p);
 extern void arch_disarm_kprobe(struct kprobe *p);
 extern void arch_remove_kprobe(struct kprobe *p);
-extern int arch_init(void);
+extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern kprobe_opcode_t *get_insn_slot(void);
 extern void free_insn_slot(kprobe_opcode_t *slot);
Index: sparc64-linux-2.6.12-mm2/kernel/kprobes.c
===================================================================
--- sparc64-linux-2.6.12-mm2.orig/kernel/kprobes.c
+++ sparc64-linux-2.6.12-mm2/kernel/kprobes.c
@@ -574,7 +574,7 @@ static int __init init_kprobes(void)
 		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
 	}
 
-	err = arch_init();
+	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
 
