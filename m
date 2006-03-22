Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWCVGnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWCVGnk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWCVGiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:38:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:7040 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750878AbWCVGhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:38 -0500
Message-Id: <20060322063752.437169000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:56 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 16/35] subarch support for interrupt and exception gates
Content-Disposition: inline; filename=15-i386-idt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the code that sets up interrupt and exception gates, and
add a separate subarch implementation for Xen.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/traps.c                   |   49 ---------------------------
 include/asm-i386/mach-default/mach_idt.h   |   52 +++++++++++++++++++++++++++++
 include/asm-i386/mach-xen/mach_idt.h       |   50 +++++++++++++++++++++++++++
 include/asm-i386/mach-xen/setup_arch_pre.h |    2 +
 4 files changed, 105 insertions(+), 48 deletions(-)

--- xen-subarch-2.6.orig/arch/i386/kernel/traps.c
+++ xen-subarch-2.6/arch/i386/kernel/traps.c
@@ -1043,54 +1043,7 @@ void __init trap_init_f00f_bug(void)
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
-void set_intr_gate(unsigned int n, void *addr)
-{
-	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
-}
-
-/*
- * This routine sets up an interrupt gate at directory privilege level 3.
- */
-static inline void set_system_intr_gate(unsigned int n, void *addr)
-{
-	_set_gate(idt_table+n, 14, 3, addr, __KERNEL_CS);
-}
-
-static void __init set_trap_gate(unsigned int n, void *addr)
-{
-	_set_gate(idt_table+n,15,0,addr,__KERNEL_CS);
-}
-
-static void __init set_system_gate(unsigned int n, void *addr)
-{
-	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
-}
-
-static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
-{
-	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
-}
-
+#include <mach_idt.h>
 
 void __init trap_init(void)
 {
--- xen-subarch-2.6.orig/include/asm-i386/mach-xen/setup_arch_pre.h
+++ xen-subarch-2.6/include/asm-i386/mach-xen/setup_arch_pre.h
@@ -6,6 +6,8 @@
 struct start_info *xen_start_info;
 EXPORT_SYMBOL(xen_start_info);
 
+struct trap_info xen_trap_table[257];
+
 /*
  * Point at the empty zero page to start with. We map the real shared_info
  * page as soon as fixmap is up and running.
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-default/mach_idt.h
@@ -0,0 +1,52 @@
+#ifndef __ASM_MACH_IDT_H
+#define __ASM_MACH_IDT_H
+
+#define _set_gate(gate_addr,type,dpl,addr,seg) \
+do { \
+  int __d0, __d1; \
+  __asm__ __volatile__ ("movw %%dx,%%ax\n\t" \
+	"movw %4,%%dx\n\t" \
+	"movl %%eax,%0\n\t" \
+	"movl %%edx,%1" \
+	:"=m" (*((long *) (gate_addr))), \
+	 "=m" (*(1+(long *) (gate_addr))), "=&a" (__d0), "=&d" (__d1) \
+	:"i" ((short) (0x8000+(dpl<<13)+(type<<8))), \
+	 "3" ((char *) (addr)),"2" ((seg) << 16)); \
+} while (0)
+
+
+/*
+ * This needs to use 'idt_table' rather than 'idt', and
+ * thus use the _nonmapped_ version of the IDT, as the
+ * Pentium F0 0F bugfix can have resulted in the mapped
+ * IDT being write-protected.
+ */
+void set_intr_gate(unsigned int n, void *addr)
+{
+	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
+}
+
+/*
+ * This routine sets up an interrupt gate at directory privilege level 3.
+ */
+static inline void set_system_intr_gate(unsigned int n, void *addr)
+{
+	_set_gate(idt_table+n, 14, 3, addr, __KERNEL_CS);
+}
+
+static void __init set_trap_gate(unsigned int n, void *addr)
+{
+	_set_gate(idt_table+n,15,0,addr,__KERNEL_CS);
+}
+
+static void __init set_system_gate(unsigned int n, void *addr)
+{
+	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
+}
+
+static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
+{
+	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
+}
+
+#endif /* __ASM_MACH_IDT_H */
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-xen/mach_idt.h
@@ -0,0 +1,50 @@
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
+void set_intr_gate(unsigned int n, void *addr)
+{
+	_set_gate(n, 14, 0, addr, __KERNEL_CS);
+}
+
+/*
+ * This routine sets up an interrupt gate at directory privilege level 3.
+ */
+static inline void set_system_intr_gate(unsigned int n, void *addr)
+{
+	_set_gate(n, 14, 3, addr, __KERNEL_CS);
+}
+
+static void __init set_trap_gate(unsigned int n, void *addr)
+{
+	_set_gate(n, 15, 0, addr, __KERNEL_CS);
+}
+
+static void __init set_system_gate(unsigned int n, void *addr)
+{
+	_set_gate(n, 15, 3, addr, __KERNEL_CS);
+}
+
+static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
+{
+	/* _set_gate(n, 5, 0, 0, (gdt_entry<<3)); */
+}
+
+#endif /* __ASM_MACH_IDT_H */

--
