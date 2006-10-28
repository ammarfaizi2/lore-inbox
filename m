Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWJ2CpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWJ2CpF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 22:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWJ2CpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 22:45:05 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:61864 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964946AbWJ2CpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 22:45:02 -0400
Message-Id: <20061029024605.950760000@sous-sol.org>
References: <20061029024504.760769000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Sat, 28 Oct 2006 00:00:03 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org, ak@muc.de
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: [PATCH 3/7] More generic paravirtualization entry point.
Content-Disposition: inline; filename=011-paravirt-head.S.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) Each hypervisor writes a probe function to detect whether we are
   running under that hypervisor.  paravirt_probe() registers this
   function.

2) If vmlinux is booted with ring != 0, we call all the probe
   functions (with registers except %esp intact) in link order: the
   winner will not return.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>

---
 arch/i386/kernel/Makefile      |    2 ++
 arch/i386/kernel/head.S        |   33 +++++++++++++++++++++++++++++++++
 arch/i386/kernel/paravirt.c    |    6 +++++-
 arch/i386/kernel/vmlinux.lds.S |    6 ++++++
 include/asm-i386/paravirt.h    |    5 +++++
 5 files changed, 51 insertions(+), 1 deletion(-)

--- linux-2.6-pv.orig/arch/i386/kernel/Makefile
+++ linux-2.6-pv/arch/i386/kernel/Makefile
@@ -39,6 +39,8 @@ obj-$(CONFIG_VM86)		+= vm86.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_K8_NB)		+= k8.o
+
+# Make sure this is linked after any other paravirt_ops structs: see head.S
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 
 EXTRA_AFLAGS   := -traditional
--- linux-2.6-pv.orig/arch/i386/kernel/head.S
+++ linux-2.6-pv/arch/i386/kernel/head.S
@@ -55,6 +55,12 @@
  */
 ENTRY(startup_32)
 
+#ifdef CONFIG_PARAVIRT
+        movl %cs, %eax
+        testl $0x3, %eax
+        jnz startup_paravirt
+#endif
+
 /*
  * Set segments to known values.
  */
@@ -486,6 +492,33 @@ ignore_int:
 #endif
 	iret
 
+#ifdef CONFIG_PARAVIRT
+startup_paravirt:
+	cld
+ 	movl $(init_thread_union+THREAD_SIZE),%esp
+
+	/* We take pains to preserve all the regs. */
+	pushl	%edx
+	pushl	%ecx
+	pushl	%eax
+
+	/* paravirt.o is last in link, and that probe fn never returns */
+	pushl	$__start_paravirtprobe
+1:
+	movl	0(%esp), %eax
+	pushl	(%eax)
+	movl	8(%esp), %eax
+	call	*(%esp)
+	popl	%eax
+
+	movl	4(%esp), %eax
+	movl	8(%esp), %ecx
+	movl	12(%esp), %edx
+
+	addl	$4, (%esp)
+	jmp	1b
+#endif
+
 /*
  * Real beginning of normal "text" segment
  */
--- linux-2.6-pv.orig/arch/i386/kernel/paravirt.c
+++ linux-2.6-pv/arch/i386/kernel/paravirt.c
@@ -392,7 +392,11 @@ static int __init print_banner(void)
 	return 0;
 }
 core_initcall(print_banner);
- 
+
+/* We simply declare start_kernel to be the paravirt probe of last resort. */
+asmlinkage void __init start_kernel(void);
+paravirt_probe(start_kernel);
+  
 struct paravirt_ops paravirt_ops = {
 	.name = "bare hardware",
 	.paravirt_enabled = 0,
--- linux-2.6-pv.orig/arch/i386/kernel/vmlinux.lds.S
+++ linux-2.6-pv/arch/i386/kernel/vmlinux.lds.S
@@ -60,6 +60,12 @@ SECTIONS
 	CONSTRUCTORS
 	} :data
 
+  __start_paravirtprobe = .;
+  .paravirtprobe : AT(ADDR(.paravirtprobe) - LOAD_OFFSET) {
+	*(.paravirtprobe)
+  }
+  __stop_paravirtprobe = .;
+
   . = ALIGN(4096);
   __nosave_begin = .;
   .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) { *(.data.nosave) }
--- linux-2.6-pv.orig/include/asm-i386/paravirt.h
+++ linux-2.6-pv/include/asm-i386/paravirt.h
@@ -120,6 +120,11 @@ struct paravirt_ops
 	void (fastcall *iret)(void);
 };
 
+/* Mark a paravirt probe function. */
+#define paravirt_probe(fn)						\
+	static void (*__paravirtprobe_##fn)(void) __attribute_used__	\
+		__attribute__((__section__(".paravirtprobe"))) = fn
+
 extern struct paravirt_ops paravirt_ops;
 
 #define paravirt_enabled() (paravirt_ops.paravirt_enabled)

--
