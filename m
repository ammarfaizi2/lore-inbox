Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWGCCkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWGCCkT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 22:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWGCCkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 22:40:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:53900 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750726AbWGCCkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 22:40:17 -0400
X-IronPort-AV: i="4.06,199,1149490800"; 
   d="scan'208"; a="59763298:sNHT627133822"
Message-ID: <44A882D3.9000208@intel.com>
Date: Mon, 03 Jul 2006 02:37:07 +0000
From: "bibo, mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>,
       SystemTAP <systemtap@sources.redhat.com>, bibo.mao@intel.com
Subject: [PATCH] IA64 kprobe invalidate icache of jump buffer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   Kprobe inserts breakpoint instruction in probepoint and then jumps
to instruction slot when breakpoint is hit, the instruction slot icache
must be consistent with dcache. Here is the patch which invalidates
instruction slot icache area.
   Without this patch, in some machines there will be fault when executing
instruction slot where icache content is inconsistent with dcache.This patch
is based on 2.6.17 version.	

Signed-off-by: bibo,mao <bibo.mao@intel.com>

thanks
bibo,mao          

 arch/ia64/kernel/kprobes.c    |    9 +++++++++
 include/asm-i386/kprobes.h    |    1 +
 include/asm-ia64/kprobes.h    |    1 +
 include/asm-powerpc/kprobes.h |    1 +
 include/asm-sparc64/kprobes.h |    1 +
 include/asm-x86_64/kprobes.h  |    1 +
 kernel/kprobes.c              |    1 +
 7 files changed, 15 insertions(+)

----------------------------------------------------------------------------
diff -Nruap 2.6.17.org/arch/ia64/kernel/kprobes.c 2.6.17/arch/ia64/kernel/kprobes.c
--- 2.6.17.org/arch/ia64/kernel/kprobes.c	2006-06-29 03:50:15.000000000 +0800
+++ 2.6.17/arch/ia64/kernel/kprobes.c	2006-07-03 02:43:16.000000000 +0800
@@ -449,11 +449,20 @@ int __kprobes arch_prepare_kprobe(struct
 	return 0;
 }
 
+void __kprobes flush_insn_slot(struct kprobe *p)
+{
+	unsigned long arm_addr;
+
+	arm_addr = ((unsigned long)&p->opcode.bundle) & ~0xFULL;
+	flush_icache_range(arm_addr, arm_addr + sizeof(bundle_t));
+}
+
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long)p->addr;
 	unsigned long arm_addr = addr & ~0xFULL;
 
+	flush_insn_slot(p);
 	memcpy((char *)arm_addr, &p->ainsn.insn.bundle, sizeof(bundle_t));
 	flush_icache_range(arm_addr, arm_addr + sizeof(bundle_t));
 }
diff -Nruap 2.6.17.org/include/asm-i386/kprobes.h 2.6.17/include/asm-i386/kprobes.h
--- 2.6.17.org/include/asm-i386/kprobes.h	2006-06-29 03:50:18.000000000 +0800
+++ 2.6.17/include/asm-i386/kprobes.h	2006-06-30 02:32:17.000000000 +0800
@@ -44,6 +44,7 @@ typedef u8 kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define ARCH_SUPPORTS_KRETPROBES
+#define flush_insn_slot(p)	do { } while (0)
 
 void arch_remove_kprobe(struct kprobe *p);
 void kretprobe_trampoline(void);
diff -Nruap 2.6.17.org/include/asm-ia64/kprobes.h 2.6.17/include/asm-ia64/kprobes.h
--- 2.6.17.org/include/asm-ia64/kprobes.h	2006-03-27 14:41:22.000000000 +0800
+++ 2.6.17/include/asm-ia64/kprobes.h	2006-06-30 02:33:04.000000000 +0800
@@ -124,5 +124,6 @@ static inline void jprobe_return(void)
 }
 extern void invalidate_stacked_regs(void);
 extern void flush_register_stack(void);
+extern void flush_insn_slot(struct kprobe *p);
 
 #endif				/* _ASM_KPROBES_H */
diff -Nruap 2.6.17.org/include/asm-powerpc/kprobes.h 2.6.17/include/asm-powerpc/kprobes.h
--- 2.6.17.org/include/asm-powerpc/kprobes.h	2006-03-27 14:41:22.000000000 +0800
+++ 2.6.17/include/asm-powerpc/kprobes.h	2006-06-30 02:32:34.000000000 +0800
@@ -50,6 +50,7 @@ typedef unsigned int kprobe_opcode_t;
 			IS_TWI(instr) || IS_TDI(instr))
 
 #define ARCH_SUPPORTS_KRETPROBES
+#define flush_insn_slot(p)	do { } while (0)
 void kretprobe_trampoline(void);
 extern void arch_remove_kprobe(struct kprobe *p);
 
diff -Nruap 2.6.17.org/include/asm-sparc64/kprobes.h 2.6.17/include/asm-sparc64/kprobes.h
--- 2.6.17.org/include/asm-sparc64/kprobes.h	2006-03-27 14:41:23.000000000 +0800
+++ 2.6.17/include/asm-sparc64/kprobes.h	2006-06-30 02:32:50.000000000 +0800
@@ -13,6 +13,7 @@ typedef u32 kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define arch_remove_kprobe(p)	do {} while (0)
+#define flush_insn_slot(p)	do { } while (0)
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
diff -Nruap 2.6.17.org/include/asm-x86_64/kprobes.h 2.6.17/include/asm-x86_64/kprobes.h
--- 2.6.17.org/include/asm-x86_64/kprobes.h	2006-03-27 14:41:23.000000000 +0800
+++ 2.6.17/include/asm-x86_64/kprobes.h	2006-06-30 02:32:05.000000000 +0800
@@ -43,6 +43,7 @@ typedef u8 kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define ARCH_SUPPORTS_KRETPROBES
+#define flush_insn_slot(p)	do { } while (0)
 
 void kretprobe_trampoline(void);
 extern void arch_remove_kprobe(struct kprobe *p);
diff -Nruap 2.6.17.org/kernel/kprobes.c 2.6.17/kernel/kprobes.c
--- 2.6.17.org/kernel/kprobes.c	2006-06-29 03:50:19.000000000 +0800
+++ 2.6.17/kernel/kprobes.c	2006-07-03 02:42:37.000000000 +0800
@@ -388,6 +388,7 @@ static int __kprobes add_new_kprobe(stru
 static inline void add_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	copy_kprobe(p, ap);
+	flush_insn_slot(ap);
 	ap->addr = p->addr;
 	ap->pre_handler = aggr_pre_handler;
 	ap->post_handler = aggr_post_handler;
