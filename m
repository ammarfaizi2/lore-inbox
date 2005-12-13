Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVLMVzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVLMVzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVLMVzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:55:16 -0500
Received: from fmr21.intel.com ([143.183.121.13]:60372 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030239AbVLMVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:55:14 -0500
Message-Id: <20051213203900.908870934@csdlinux-2.jf.intel.com>
References: <20051213203547.649087523@csdlinux-2.jf.intel.com>
Date: Tue, 13 Dec 2005 12:35:48 -0800
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: ananth@in.ibm.com, akpm@osdl.org, paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [patch 1/4] Kprobes - Enable funcions only for required arch
Content-Disposition: inline; filename=cleanup_inst_slot.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Kprobes - Enable funcions only for required arch

	Kernel/kprobes.c defines get_insn_slot() and free_insn_slot()
which are currently required _only_ for x86_64 and powerpc (which has
no-exec support).

FYI, get{free}_insn_slot() functions manages the memory
page which is mapped as executable, required for instruction
emulation.

This patch moves those two functions under
__ARCH_WANT_KPROBES_INSN_SLOT and defines
__ARCH_WANT_KPROBES_INSN_SLOT in arch specific
kprobes.h file.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
------------------------------------------------------------------

 include/asm-powerpc/kprobes.h |    2 ++
 include/asm-x86_64/kprobes.h  |    2 ++
 kernel/kprobes.c              |    2 ++
 3 files changed, 6 insertions(+)

Index: linux-2.6.15-rc5-mm2/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-powerpc/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-powerpc/kprobes.h
@@ -29,6 +29,8 @@
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
 
+#define  __ARCH_WANT_KPROBES_INSN_SLOT
+
 struct pt_regs;
 
 typedef unsigned int kprobe_opcode_t;
Index: linux-2.6.15-rc5-mm2/include/asm-x86_64/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-x86_64/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-x86_64/kprobes.h
@@ -27,6 +27,8 @@
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
 
+#define  __ARCH_WANT_KPROBES_INSN_SLOT
+
 struct pt_regs;
 
 typedef u8 kprobe_opcode_t;
Index: linux-2.6.15-rc5-mm2/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/kernel/kprobes.c
@@ -52,6 +52,7 @@ static DEFINE_SPINLOCK(kprobe_lock);	/* 
 DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
 
+#ifdef __ARCH_WANT_KPROBES_INSN_SLOT
 /*
  * kprobe->ainsn.insn points to the copy of the instruction to be
  * single-stepped. x86_64, POWER4 and above have no-exec support and
@@ -151,6 +152,7 @@ void __kprobes free_insn_slot(kprobe_opc
 		}
 	}
 }
+#endif
 
 /* We have preemption disabled.. so it is safe to use __ versions */
 static inline void set_kprobe_instance(struct kprobe *kp)

--

