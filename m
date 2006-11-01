Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946640AbWKAK3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946640AbWKAK3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946756AbWKAK3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:29:49 -0500
Received: from ozlabs.org ([203.10.76.45]:55234 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946640AbWKAK3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:29:47 -0500
Subject: [PATCH 3/7] paravirtualization: More generic paravirtualization
	entry point.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162376894.23462.7.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
	 <1162376894.23462.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:29:41 +1100
Message-Id: <1162376981.23462.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
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

===================================================================
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -39,6 +39,8 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_prin
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_K8_NB)		+= k8.o
+
+# Make sure this is linked after any other paravirt_ops structs: see head.S
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 
 EXTRA_AFLAGS   := -traditional
===================================================================
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -54,6 +54,12 @@
  * can.
  */
 ENTRY(startup_32)
+
+#ifdef CONFIG_PARAVIRT
+        movl %cs, %eax
+        testl $0x3, %eax
+        jnz startup_paravirt
+#endif
 
 /*
  * Set segments to known values.
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
===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/efi.h>
 #include <linux/bcd.h>
+#include <linux/start_kernel.h>
 
 #include <asm/bug.h>
 #include <asm/paravirt.h>
@@ -381,7 +382,10 @@ static int __init print_banner(void)
 	return 0;
 }
 core_initcall(print_banner);
- 
+
+/* We simply declare start_kernel to be the paravirt probe of last resort. */
+paravirt_probe(start_kernel);
+  
 struct paravirt_ops paravirt_ops = {
 	.name = "bare hardware",
 	.paravirt_enabled = 0,
===================================================================
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
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
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -119,6 +119,11 @@ struct paravirt_ops
 	void (fastcall *irq_enable_sysexit)(void);
 	void (fastcall *iret)(void);
 };
+
+/* Mark a paravirt probe function. */
+#define paravirt_probe(fn)						\
+	static void (*__paravirtprobe_##fn)(void) __attribute_used__	\
+		__attribute__((__section__(".paravirtprobe"))) = fn
 
 extern struct paravirt_ops paravirt_ops;
 


