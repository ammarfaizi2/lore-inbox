Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWGRJWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWGRJWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWGRJVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:21:46 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44673 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932133AbWGRJVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:21:08 -0400
Message-Id: <20060718091953.545131000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:20 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 20/33] subarch support for interrupt and exception gates
Content-Disposition: inline; filename=i386-idt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the code that sets up interrupt and exception gates, and
add a separate subarch implementation for Xen.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/traps.c                   |   35 ++++++-----------------------
 include/asm-i386/mach-default/mach_idt.h   |   24 +++++++++++++++++++
 include/asm-i386/mach-xen/mach_idt.h       |   25 ++++++++++++++++++++
 include/asm-i386/mach-xen/setup_arch_pre.h |    2 +
 4 files changed, 59 insertions(+), 27 deletions(-)

diff -r 29559215e367 arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	Tue Jun 13 23:38:38 2006 -0700
+++ b/arch/i386/kernel/traps.c	Tue Jun 13 23:40:29 2006 -0700
@@ -1084,29 +1084,11 @@ void __init trap_init_f00f_bug(void)
 }
 #endif
 
-#define _set_gate(gate_addr,type,dpl,addr,seg) \
-do { \
-  int __d0, __d1; \
-  __asm__ __volatile__ ("movw %%dx,%%ax\n\t" \
-	"movw %4,%%dx\n\t" \
-	"movl %%eax,%0\n\t" \
-	"movl %%edx,%1" \
-	:"=m" (*((long *) (gate_addr))), \
-	 "=m" (*(1+(long *) (gate_addr))), "=&a" (__d0), "=&d" (__d1) \
-	:"i" ((short) (0x8000+(dpl<<13)+(type<<8))), \
-	 "3" ((char *) (addr)),"2" ((seg) << 16)); \
-} while (0)
-
-
-/*
- * This needs to use 'idt_table' rather than 'idt', and
- * thus use the _nonmapped_ version of the IDT, as the
- * Pentium F0 0F bugfix can have resulted in the mapped
- * IDT being write-protected.
- */
+#include <mach_idt.h>
+
 void set_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
+	_set_gate(n,14,0,addr,__KERNEL_CS);
 }
 
 /*
@@ -1114,24 +1096,23 @@ void set_intr_gate(unsigned int n, void 
  */
 static inline void set_system_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n, 14, 3, addr, __KERNEL_CS);
+	_set_gate(n, 14, 3, addr, __KERNEL_CS);
 }
 
 static void __init set_trap_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,0,addr,__KERNEL_CS);
+	_set_gate(n,15,0,addr,__KERNEL_CS);
 }
 
 static void __init set_system_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
+	_set_gate(n,15,3,addr,__KERNEL_CS);
 }
 
 static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
 {
-	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
-}
-
+	_set_gate(n,5,0,0,(gdt_entry<<3));
+}
 
 void __init trap_init(void)
 {
diff -r 29559215e367 arch/i386/mach-xen/setup-xen.c
--- a/arch/i386/mach-xen/setup-xen.c	Tue Jun 13 23:38:38 2006 -0700
+++ b/arch/i386/mach-xen/setup-xen.c	Tue Jun 13 23:40:29 2006 -0700
@@ -23,6 +23,8 @@ EXPORT_SYMBOL(xen_start_info);
  */
 struct shared_info *HYPERVISOR_shared_info = (struct shared_info *)empty_zero_page;
 EXPORT_SYMBOL(HYPERVISOR_shared_info);
+
+struct trap_info xen_trap_table[257];
 
 /**
  * machine_specific_memory_setup - Hook for machine specific memory setup.
diff -r 29559215e367 include/asm-i386/mach-xen/setup_arch.h
--- a/include/asm-i386/mach-xen/setup_arch.h	Tue Jun 13 23:38:38 2006 -0700
+++ b/include/asm-i386/mach-xen/setup_arch.h	Tue Jun 13 23:40:29 2006 -0700
@@ -3,6 +3,7 @@
 
 extern struct start_info *xen_start_info;
 extern struct shared_info *HYPERVISOR_shared_info;
+extern struct trap_info xen_trap_table[257];
 
 void __init machine_specific_arch_setup(void);
 
diff -r 29559215e367 include/asm-i386/mach-default/mach_idt.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-default/mach_idt.h	Tue Jun 13 23:40:29 2006 -0700
@@ -0,0 +1,24 @@
+#ifndef __ASM_MACH_IDT_H
+#define __ASM_MACH_IDT_H
+
+/*
+ * This needs to use 'idt_table' rather than 'idt', and
+ * thus use the _nonmapped_ version of the IDT, as the
+ * Pentium F0 0F bugfix can have resulted in the mapped
+ * IDT being write-protected.
+ */
+#define _set_gate(vector,type,dpl,addr,seg) \
+do { \
+  int __d0, __d1; \
+  struct gate_struct *__gate_addr = idt_table + (vector); \
+  __asm__ __volatile__ ("movw %%dx,%%ax\n\t" \
+	"movw %4,%%dx\n\t" \
+	"movl %%eax,%0\n\t" \
+	"movl %%edx,%1" \
+	:"=m" (*((long *) __gate_addr)), \
+	 "=m" (*(1+(long *) __gate_addr)), "=&a" (__d0), "=&d" (__d1) \
+	:"i" ((short) (0x8000+(dpl<<13)+(type<<8))), \
+	 "3" ((char *) (addr)),"2" ((seg) << 16)); \
+} while (0)
+
+#endif /* __ASM_MACH_IDT_H */
diff -r 29559215e367 include/asm-i386/mach-xen/mach_idt.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/mach_idt.h	Tue Jun 13 23:40:29 2006 -0700
@@ -0,0 +1,25 @@
+#ifndef __ASM_MACH_IDT_H
+#define __ASM_MACH_IDT_H
+
+static inline void _set_gate(unsigned int vector, uint8_t type, uint8_t dpl,
+			     void *addr, uint16_t seg)
+{
+	struct trap_info *t = xen_trap_table;
+
+	BUG_ON(vector > 256);
+
+	if (type == 5)
+		return;
+
+	while (t->address && t->vector != vector)
+		t++;
+
+	t->vector = vector;
+	t->cs = seg;
+	TI_SET_DPL(t, dpl);
+	if (type == 14 || vector == 7)
+		TI_SET_IF(t, 1);
+	t->address = (unsigned long)addr;
+}
+
+#endif /* __ASM_MACH_IDT_H */

--
