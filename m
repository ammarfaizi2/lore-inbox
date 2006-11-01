Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946765AbWKAKch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946765AbWKAKch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946766AbWKAKch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:32:37 -0500
Received: from ozlabs.org ([203.10.76.45]:63170 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946765AbWKAKcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:32:36 -0500
Subject: [PATCH 6/7] paravirtualization: Add APIC accessors to paravirt-ops.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162377093.23462.14.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
	 <1162376894.23462.7.camel@localhost.localdomain>
	 <1162376981.23462.10.camel@localhost.localdomain>
	 <1162377043.23462.12.camel@localhost.localdomain>
	 <1162377093.23462.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:32:30 +1100
Message-Id: <1162377150.23462.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add APIC accessors to paravirt-ops.  Unfortunately, we need two write
functions, as some older broken hardware requires workarounds for
Pentium APIC errata - this is the purpose of apic_write_atomic.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -29,6 +29,8 @@
 #include <asm/time.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
+#include <asm/fixmap.h>
+#include <asm/apic.h>
 
 /* nop stub */
 static void native_nop(void)
@@ -441,6 +443,12 @@ struct paravirt_ops paravirt_ops = {
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
===================================================================
--- a/include/asm-i386/apic.h
+++ b/include/asm-i386/apic.h
@@ -37,18 +37,27 @@ extern void generic_apic_probe(void);
 /*
  * Basic functions accessing APICs.
  */
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define apic_write native_apic_write
+#define apic_write_atomic native_apic_write_atomic
+#define apic_read native_apic_read
+#endif
 
-static __inline void apic_write(unsigned long reg, unsigned long v)
+static __inline fastcall void native_apic_write(unsigned long reg,
+						unsigned long v)
 {
 	*((volatile unsigned long *)(APIC_BASE+reg)) = v;
 }
 
-static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
+static __inline fastcall void native_apic_write_atomic(unsigned long reg,
+						       unsigned long v)
 {
 	xchg((volatile unsigned long *)(APIC_BASE+reg), v);
 }
 
-static __inline unsigned long apic_read(unsigned long reg)
+static __inline fastcall unsigned long native_apic_read(unsigned long reg)
 {
 	return *((volatile unsigned long *)(APIC_BASE+reg));
 }
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -114,6 +114,12 @@ struct paravirt_ops
 
 	void (fastcall *io_delay)(void);
 	void (*const_udelay)(unsigned long loops);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	void (fastcall *apic_write)(unsigned long reg, unsigned long v);
+	void (fastcall *apic_write_atomic)(unsigned long reg, unsigned long v);
+	unsigned long (fastcall *apic_read)(unsigned long reg);
+#endif
 
 	/* These two are jmp to, not actually called. */
 	void (fastcall *irq_enable_sysexit)(void);
@@ -275,6 +281,27 @@ static inline void slow_down_io(void) {
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


