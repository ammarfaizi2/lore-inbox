Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUDNBC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 21:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUDNBC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 21:02:56 -0400
Received: from fmr10.intel.com ([192.55.52.30]:36236 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S263419AbUDNBCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 21:02:51 -0400
Subject: Re: IO-APIC on nforce2 [PATCH]
From: Len Brown <len.brown@intel.com>
To: ross@datscreative.com.au
Cc: christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
In-Reply-To: <200404131703.09572.ross@datscreative.com.au>
References: <200404131117.31306.ross@datscreative.com.au>
	 <1081832914.2253.623.camel@dhcppc4>
	 <200404131703.09572.ross@datscreative.com.au>
Content-Type: multipart/mixed; boundary="=-rMgQvLyM53Yf3YzgihY4"
Organization: 
Message-Id: <1081893978.2251.653.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Apr 2004 21:02:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rMgQvLyM53Yf3YzgihY4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Re: IRQ0 XT-PIC timer issue

Since the hardware is connected to APIC pin0, it is a BIOS bug
that an ACPI interrupt source override from pin2 to IRQ0 exists.

With this simple 2.6.5 patch you can specify "acpi_skip_timer_override"
to ignore that bogus BIOS directive.  The result is with your
ACPI-enabled APIC-enabled kernel, you'll get IRQ0 IO-APIC-edge timer.

Probably there is a more clever way to trigger this workaround
automatcially instead of via boot parameter.

cheers,
-Len

===== Documentation/kernel-parameters.txt 1.44 vs edited =====
--- 1.44/Documentation/kernel-parameters.txt	Mon Mar 22 16:03:22 2004
+++ edited/Documentation/kernel-parameters.txt	Tue Apr 13 17:47:11 2004
@@ -122,6 +122,10 @@
 
 	acpi_serialize	[HW,ACPI] force serialization of AML methods
 
+	acpi_skip_timer_override [HW,ACPI]]
+			Recognize IRQ0/pin2 Interrupt Source Override
+			and ignore it -- for broken nForce2 BIOS.
+
 	ad1816=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>
 			See also Documentation/sound/oss/AD1816.
===== arch/i386/kernel/setup.c 1.115 vs edited =====
--- 1.115/arch/i386/kernel/setup.c	Fri Apr  2 07:21:43 2004
+++ edited/arch/i386/kernel/setup.c	Tue Apr 13 17:41:31 2004
@@ -614,6 +614,12 @@
 		else if (!memcmp(from, "acpi_sci=low", 12))
 			acpi_sci_flags.polarity = 3;
 
+		else if (!memcmp(from, "acpi_skip_timer_override", 24)) {
+			extern int acpi_skip_timer_override;
+
+			acpi_skip_timer_override = 1;
+		}
+
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6))
===== arch/i386/kernel/acpi/boot.c 1.57 vs edited =====
--- 1.57/arch/i386/kernel/acpi/boot.c	Tue Mar 30 17:05:19 2004
+++ edited/arch/i386/kernel/acpi/boot.c	Tue Apr 13 17:50:14 2004
@@ -62,6 +62,7 @@
 
 acpi_interrupt_flags acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;
+int acpi_skip_timer_override __initdata;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
@@ -327,6 +328,12 @@
 		acpi_sci_ioapic_setup(intsrc->global_irq,
 			intsrc->flags.polarity, intsrc->flags.trigger);
 		return 0;
+	}
+
+	if (acpi_skip_timer_override &&
+		intsrc->bus_irq == 0 && intsrc->global_irq == 2) {
+			printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
+			return 0;
 	}
 
 	mp_override_legacy_irq (



--=-rMgQvLyM53Yf3YzgihY4
Content-Disposition: attachment; filename=wip.patch
Content-Type: text/plain; name=wip.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== Documentation/kernel-parameters.txt 1.44 vs edited =====
--- 1.44/Documentation/kernel-parameters.txt	Mon Mar 22 16:03:22 2004
+++ edited/Documentation/kernel-parameters.txt	Tue Apr 13 17:47:11 2004
@@ -122,6 +122,10 @@
 
 	acpi_serialize	[HW,ACPI] force serialization of AML methods
 
+	acpi_skip_timer_override [HW,ACPI]]
+			Recognize IRQ0/pin2 Interrupt Source Override
+			and ignore it -- for broken nForce2 BIOS.
+
 	ad1816=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>
 			See also Documentation/sound/oss/AD1816.
===== arch/i386/kernel/setup.c 1.115 vs edited =====
--- 1.115/arch/i386/kernel/setup.c	Fri Apr  2 07:21:43 2004
+++ edited/arch/i386/kernel/setup.c	Tue Apr 13 17:41:31 2004
@@ -614,6 +614,12 @@
 		else if (!memcmp(from, "acpi_sci=low", 12))
 			acpi_sci_flags.polarity = 3;
 
+		else if (!memcmp(from, "acpi_skip_timer_override", 24)) {
+			extern int acpi_skip_timer_override;
+
+			acpi_skip_timer_override = 1;
+		}
+
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6))
===== arch/i386/kernel/acpi/boot.c 1.57 vs edited =====
--- 1.57/arch/i386/kernel/acpi/boot.c	Tue Mar 30 17:05:19 2004
+++ edited/arch/i386/kernel/acpi/boot.c	Tue Apr 13 17:50:14 2004
@@ -62,6 +62,7 @@
 
 acpi_interrupt_flags acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;
+int acpi_skip_timer_override __initdata;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
@@ -327,6 +328,12 @@
 		acpi_sci_ioapic_setup(intsrc->global_irq,
 			intsrc->flags.polarity, intsrc->flags.trigger);
 		return 0;
+	}
+
+	if (acpi_skip_timer_override &&
+		intsrc->bus_irq == 0 && intsrc->global_irq == 2) {
+			printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
+			return 0;
 	}
 
 	mp_override_legacy_irq (

--=-rMgQvLyM53Yf3YzgihY4--

