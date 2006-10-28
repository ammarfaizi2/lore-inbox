Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWJ2Cpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWJ2Cpn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 22:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWJ2Cpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 22:45:42 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:681 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964949AbWJ2Cpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 22:45:35 -0400
Message-Id: <20061029024607.401333000@sous-sol.org>
References: <20061029024504.760769000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Sat, 28 Oct 2006 00:00:06 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org, ak@muc.de
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Content-Disposition: inline; filename=01A-apicops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add APIC accessors to paravirt-ops.  Unfortunately, we need two write
functions, as some older broken hardware requires workarounds for
Pentium APIC errata - this is the purpose of apic_write_atomic.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>

---
 arch/i386/kernel/paravirt.c |   28 ++++++++++++++++++++++++++++
 include/asm-i386/apic.h     |    5 ++++-
 include/asm-i386/paravirt.h |   27 +++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

--- linux-2.6-pv.orig/arch/i386/kernel/paravirt.c
+++ linux-2.6-pv/arch/i386/kernel/paravirt.c
@@ -28,6 +28,8 @@
 #include <asm/time.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
+#include <asm/fixmap.h>
+#include <asm/apic.h>
 
 /* nop stub */
 static void native_nop(void)
@@ -382,6 +384,26 @@ static fastcall void native_io_delay(voi
 	asm volatile("outb %al,$0x80");
 }
 
+#ifdef CONFIG_X86_LOCAL_APIC
+/*
+ * Basic functions for reading and writing APIC registers
+ */
+static fastcall void native_apic_write(unsigned long reg, unsigned long v)
+{
+	*((volatile unsigned long *)(APIC_BASE+reg)) = v;
+}
+
+static fastcall void native_apic_write_atomic(unsigned long reg, unsigned long v)
+{
+	xchg((volatile unsigned long *)(APIC_BASE+reg), v);
+}
+
+static fastcall unsigned long native_apic_read(unsigned long reg)
+{
+	return *((volatile unsigned long *)(APIC_BASE+reg));
+}
+#endif /* CONFIG_X86_LOCAL_APIC */
+
 /* These are in entry.S */
 extern fastcall void native_iret(void);
 extern fastcall void native_irq_enable_sysexit(void);
@@ -452,6 +474,12 @@ struct paravirt_ops paravirt_ops = {
 	.io_delay = native_io_delay,
 	.const_udelay = __const_udelay,
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	.apic_write = native_apic_write,
+	.apic_write_atomic = native_apic_write_atomic,
+	.apic_read = native_apic_read,
+#endif
+
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
 };
--- linux-2.6-pv.orig/include/asm-i386/apic.h
+++ linux-2.6-pv/include/asm-i386/apic.h
@@ -37,7 +37,9 @@ extern void generic_apic_probe(void);
 /*
  * Basic functions accessing APICs.
  */
-
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 static __inline void apic_write(unsigned long reg, unsigned long v)
 {
 	*((volatile unsigned long *)(APIC_BASE+reg)) = v;
@@ -52,6 +54,7 @@ static __inline unsigned long apic_read(
 {
 	return *((volatile unsigned long *)(APIC_BASE+reg));
 }
+#endif
 
 static __inline__ void apic_wait_icr_idle(void)
 {
--- linux-2.6-pv.orig/include/asm-i386/paravirt.h
+++ linux-2.6-pv/include/asm-i386/paravirt.h
@@ -115,6 +115,12 @@ struct paravirt_ops
 	void (fastcall *io_delay)(void);
 	void (*const_udelay)(unsigned long loops);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	void (fastcall *apic_write)(unsigned long reg, unsigned long v);
+	void (fastcall *apic_write_atomic)(unsigned long reg, unsigned long v);
+	unsigned long (fastcall *apic_read)(unsigned long reg);
+#endif
+
 	/* These two are jmp to, not actually called. */
 	void (fastcall *irq_enable_sysexit)(void);
 	void (fastcall *iret)(void);
@@ -280,6 +286,27 @@ static inline void slow_down_io(void) {
 #endif
 }
 
+#ifdef CONFIG_X86_LOCAL_APIC
+/*
+ * Basic functions accessing APICs.
+ */
+static __inline void apic_write(unsigned long reg, unsigned long v)
+{
+	paravirt_ops.apic_write(reg,v);
+}
+
+static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
+{
+	paravirt_ops.apic_write_atomic(reg,v);
+}
+
+static __inline unsigned long apic_read(unsigned long reg)
+{
+	return paravirt_ops.apic_read(reg);
+}
+#endif
+
+
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch {
 	u8 *instr; 		/* original instructions */

--
