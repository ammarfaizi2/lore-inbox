Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVASJIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVASJIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVASIEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:04:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54207 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261640AbVASHdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:44 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/29] x86_64-apic-virtwire-on-shutdown
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When coming out of apic mode attempt to set the appropriate
apic back into virtual wire mode.  This improves on previous versions
of this patch by by never setting bot the local apic and the ioapic
into veritual wire mode.

This code looks at data from the mptable to see if an ioapic has
an ExtInt input to make this decision.  A future improvement
is to figure out which apic or ioapic was in virtual wire mode
at boot time and to remember it.  That is potentially a more accurate
method, of selecting which apic to place in virutal wire mode.


Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/apic.c    |   38 +++++++++++++++++++++++++++++++++++++-
 arch/x86_64/kernel/io_apic.c |   36 ++++++++++++++++++++++++++++++++++--
 include/asm-x86_64/apic.h    |    2 +-
 3 files changed, 72 insertions(+), 4 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-apic-virtwire-on-shutdown/arch/x86_64/kernel/apic.c linux-2.6.11-rc1-mm1-nokexec-x86_64-apic-virtwire-on-shutdown/arch/x86_64/kernel/apic.c
--- linux-2.6.11-rc1-mm1-nokexec-x86-apic-virtwire-on-shutdown/arch/x86_64/kernel/apic.c	Fri Jan 14 04:28:33 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-apic-virtwire-on-shutdown/arch/x86_64/kernel/apic.c	Tue Jan 18 22:45:16 2005
@@ -132,7 +132,7 @@
 	}
 }
 
-void disconnect_bsp_APIC(void)
+void disconnect_bsp_APIC(int virt_wire_setup)
 {
 	if (pic_mode) {
 		/*
@@ -144,6 +144,42 @@
 		apic_printk(APIC_QUIET, "disabling APIC mode, entering PIC mode.\n");
 		outb(0x70, 0x22);
 		outb(0x00, 0x23);
+	}
+	else {
+		/* Go back to Virtual Wire compatibility mode */
+		unsigned long value;
+
+		/* For the spurious interrupt use vector F, and enable it */
+		value = apic_read(APIC_SPIV);
+		value &= ~APIC_VECTOR_MASK;
+		value |= APIC_SPIV_APIC_ENABLED;
+		value |= 0xf;
+		apic_write_around(APIC_SPIV, value);
+
+		if (!virt_wire_setup) {
+			/* For LVT0 make it edge triggered, active high, external and enabled */
+			value = apic_read(APIC_LVT0);
+			value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
+				APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
+				APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
+			value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+			value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
+			apic_write_around(APIC_LVT0, value);
+		}
+		else {
+			/* Disable LVT0 */
+			apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
+		}
+
+		/* For LVT1 make it edge triggered, active high, nmi and enabled */
+		value = apic_read(APIC_LVT1);
+		value &= ~(
+			APIC_MODE_MASK | APIC_SEND_PENDING |
+			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
+			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
+		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
+		apic_write_around(APIC_LVT1, value);
 	}
 }
 
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-apic-virtwire-on-shutdown/arch/x86_64/kernel/io_apic.c linux-2.6.11-rc1-mm1-nokexec-x86_64-apic-virtwire-on-shutdown/arch/x86_64/kernel/io_apic.c
--- linux-2.6.11-rc1-mm1-nokexec-x86-apic-virtwire-on-shutdown/arch/x86_64/kernel/io_apic.c	Fri Jan 14 04:32:23 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-apic-virtwire-on-shutdown/arch/x86_64/kernel/io_apic.c	Tue Jan 18 22:45:17 2005
@@ -327,7 +327,7 @@
 /*
  * Find the pin to which IRQ[irq] (ISA) is connected
  */
-static int __init find_isa_irq_pin(int irq, int type)
+static int find_isa_irq_pin(int irq, int type)
 {
 	int i;
 
@@ -1125,12 +1125,44 @@
  */
 void disable_IO_APIC(void)
 {
+	int pin;
 	/*
 	 * Clear the IO-APIC before rebooting:
 	 */
 	clear_IO_APIC();
 
-	disconnect_bsp_APIC();
+	/*
+	 * If the i82559 is routed through an IOAPIC
+	 * Put that IOAPIC in virtual wire mode
+	 * so legacy interrups can be delivered.
+	 */
+	pin = find_isa_irq_pin(0, mp_ExtINT);
+	if (pin != -1) {
+		struct IO_APIC_route_entry entry;
+		unsigned long flags;
+
+		memset(&entry, 0, sizeof(entry));
+		entry.mask            = 0; /* Enabled */
+		entry.trigger         = 0; /* Edge */
+		entry.irr             = 0;
+		entry.polarity        = 0; /* High */
+		entry.delivery_status = 0;
+		entry.dest_mode       = 0; /* Physical */
+		entry.delivery_mode   = 7; /* ExtInt */
+		entry.vector          = 0;
+		entry.dest.physical.physical_dest = 0;
+
+
+		/*
+		 * Add it to the IO-APIC irq-routing table:
+		 */
+		spin_lock_irqsave(&ioapic_lock, flags);
+		io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
+		io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
+		spin_unlock_irqrestore(&ioapic_lock, flags);
+	}
+
+	disconnect_bsp_APIC(pin != -1);
 }
 
 /*
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-apic-virtwire-on-shutdown/include/asm-x86_64/apic.h linux-2.6.11-rc1-mm1-nokexec-x86_64-apic-virtwire-on-shutdown/include/asm-x86_64/apic.h
--- linux-2.6.11-rc1-mm1-nokexec-x86-apic-virtwire-on-shutdown/include/asm-x86_64/apic.h	Fri Jan  7 12:54:16 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-apic-virtwire-on-shutdown/include/asm-x86_64/apic.h	Tue Jan 18 22:45:17 2005
@@ -77,7 +77,7 @@
 extern int get_maxlvt (void);
 extern void clear_local_APIC (void);
 extern void connect_bsp_APIC (void);
-extern void disconnect_bsp_APIC (void);
+extern void disconnect_bsp_APIC (int virt_wire_setup);
 extern void disable_local_APIC (void);
 extern int verify_local_APIC (void);
 extern void cache_APIC_registers (void);
