Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbUDNEcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 00:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUDNEcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 00:32:04 -0400
Received: from fmr10.intel.com ([192.55.52.30]:33490 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S263693AbUDNEbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 00:31:51 -0400
Subject: RE: [PATCH] 2.6.5- es7000 subarch update
From: Len Brown <len.brown@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
In-Reply-To: <452548B29F0CCE48B8ABB094307EBA1C04220150@USRV-EXCH2.na.uis.unisys.com>
References: <452548B29F0CCE48B8ABB094307EBA1C04220150@USRV-EXCH2.na.uis.unisys.com>
Content-Type: multipart/mixed; boundary="=-hXFN+HoJxVBdTORQfPMx"
Organization: 
Message-Id: <1081916952.2252.823.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Apr 2004 00:29:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hXFN+HoJxVBdTORQfPMx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-04-12 at 23:44, Protasevich, Natalie wrote:

> >Perhaps I should send you a patch you can test on the ES7000,
> >since I don't have one of those?
> 
> Yes, please send me the patch and I will test it immediately.

Natalie,
This 2.6.5 patch adds the interrupt source overrides
to mp_irqs[] before adding identity mappings for
the remaining legacy IRQS.  So it handles both
the classic timer-override and the ES7000 scenario(s)
in a consistent manner.

It works on my vanilla Xeon boxes,
please test it on your ES7000.  I'd love to see
the full dmesg from an ES7000 if you can grow your
CONFIG_LOG_BUF_SHIFT to capture it all.

A note about (ISA) interrupt-source-overrides and Linux.
As Maciej explained to me, the Linux convention is that
IRQs < 16 retain the IRQ# they had when in PIC mode.

This means that the classic timer override from IRQ0
to apic pin 2, is called IRQ0, not IRQ2.  And it
prevents both a subsequent identity mapping on
IRQ0 or on IRQ2.

ES7000 mappings below 16 will work the same way.
IRQ15 override to pin 13 is still called IRQ15,
and it prevents a subsequent identity mapping on
either IRQ15 or IRQ13.  (though conceivably,
another override could still map IRQ13 to
yet a different pin.)

This also applies to ES7000 mappings to pins > 15.
IRQ6 mapped to apic pin 16 will still be IRQ6 --
not IRQ16.  Note that a request_irq(16) will not
work because IRQ6 has absconded with the pin 16
and so there is no pin associated with IRQ16.

This is all just a Linux convention,
and for the ACPI SCI I do something different.
Say the ACPI FADT tells us the SCI_INT is IRQ 9.
We use this to recognize an override from IRQ9
to say, apic pin 22.  We install this as IRQ22,
not as IRQ9.  This allows a subsequent identity
mapping at IRQ9 to still be used, and also allows
another device to request_irq(22) and share the
interrupt with ACPI.  Both of these happen in
practice -- simultaneously.

I expect that if the Linux IRQ convention was working
on the ES7000 before, this patch will maintain
compatibility with that.  However, if things were
not working as expected before, I just wanted to
point out that another convention is possible --
particularly with a sub-architecture.

cheers,
-Len

ps. note that this patch enabled some debug prink's
    and that it will need x86_64 update too.

===== arch/i386/kernel/mpparse.c 1.69 vs edited =====
--- 1.69/arch/i386/kernel/mpparse.c	Mon Mar 22 16:00:03 2004
+++ edited/arch/i386/kernel/mpparse.c	Tue Apr 13 23:30:27 2004
@@ -929,8 +929,6 @@
 	u32			gsi)
 {
 	struct mpc_config_intsrc intsrc;
-	int			i = 0;
-	int			found = 0;
 	int			ioapic = -1;
 	int			pin = -1;
 
@@ -958,28 +956,14 @@
 	intsrc.mpc_dstapic = mp_ioapics[ioapic].mpc_apicid;	   /* APIC ID */
 	intsrc.mpc_dstirq = pin;				    /* INTIN# */
 
-	Dprintk("Int: type %d, pol %d, trig %d, bus %d, irq %d, %d-%d\n",
+	printk("Int: type %d, pol %d, trig %d, bus %d, irq %d, %d-%d\n",
 		intsrc.mpc_irqtype, intsrc.mpc_irqflag & 3, 
 		(intsrc.mpc_irqflag >> 2) & 3, intsrc.mpc_srcbus, 
 		intsrc.mpc_srcbusirq, intsrc.mpc_dstapic, intsrc.mpc_dstirq);
 
-	/* 
-	 * If an existing [IOAPIC.PIN -> IRQ] routing entry exists we override
it.
-	 * Otherwise create a new entry (e.g. gsi == 2).
-	 */
-	for (i = 0; i < mp_irq_entries; i++) {
-		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
-			mp_irqs[i] = intsrc;
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
-		mp_irqs[mp_irq_entries] = intsrc;
-		if (++mp_irq_entries == MAX_IRQ_SOURCES)
-			panic("Max # of irq sources exceeded!\n");
-	}
+	mp_irqs[mp_irq_entries] = intsrc;
+	if (++mp_irq_entries == MAX_IRQ_SOURCES)
+		panic("Max # of irq sources exceeded!\n");
 
 	return;
 }
@@ -1010,19 +994,26 @@
 	intsrc.mpc_dstapic = mp_ioapics[ioapic].mpc_apicid;
 
 	/* 
-	 * Use the default configuration for the IRQs 0-15.  These may be
+	 * Use the default configuration for the IRQs 0-15.  Unless
 	 * overriden by (MADT) interrupt source override entries.
 	 */
 	for (i = 0; i < 16; i++) {
+		int idx;
+
+		for (idx = 0; idx < mp_irq_entries; idx++)
+			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
+				(mp_irqs[idx].mpc_srcbusirq == i ||
+				mp_irqs[idx].mpc_dstirq == i))
+					break;
 
-		if (i == 2)
-			continue;			/* Don't connect IRQ2 */
+		if (idx != mp_irq_entries)
+			continue;			  /* IRQ already used */
 
 		intsrc.mpc_irqtype = mp_INT;
 		intsrc.mpc_srcbusirq = i;		   /* Identity mapped */
 		intsrc.mpc_dstirq = i;
 
-		Dprintk("Int: type %d, pol %d, trig %d, bus %d, irq %d, "
+		printk("Int: type %d, pol %d, trig %d, bus %d, irq %d, "
 			"%d-%d\n", intsrc.mpc_irqtype, intsrc.mpc_irqflag & 3, 
 			(intsrc.mpc_irqflag >> 2) & 3, intsrc.mpc_srcbus, 
 			intsrc.mpc_srcbusirq, intsrc.mpc_dstapic, 
===== arch/i386/kernel/acpi/boot.c 1.57 vs edited =====
--- 1.57/arch/i386/kernel/acpi/boot.c	Tue Mar 30 17:05:19 2004
+++ edited/arch/i386/kernel/acpi/boot.c	Tue Apr 13 22:40:47 2004
@@ -653,9 +653,6 @@
 		return count;
 	}
 
-	/* Build a default routing table for legacy (ISA) interrupts. */
-	mp_config_acpi_legacy_irqs();
-
 	count = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR,
acpi_parse_int_src_ovr, NR_IRQ_VECTORS);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing interrupt source overrides
entry\n");
@@ -669,6 +666,9 @@
 	 */
 	if (!acpi_sci_override_gsi)
 		acpi_sci_ioapic_setup(acpi_fadt.sci_int, 0, 0);
+
+	/* Fill in identity legacy mapings where no override */
+	mp_config_acpi_legacy_irqs();
 
 	count = acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src,
NR_IRQ_VECTORS);
 	if (count < 0) {



--=-hXFN+HoJxVBdTORQfPMx
Content-Disposition: attachment; filename=wip.patch
Content-Type: text/plain; name=wip.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== arch/i386/kernel/mpparse.c 1.69 vs edited =====
--- 1.69/arch/i386/kernel/mpparse.c	Mon Mar 22 16:00:03 2004
+++ edited/arch/i386/kernel/mpparse.c	Tue Apr 13 23:30:27 2004
@@ -929,8 +929,6 @@
 	u32			gsi)
 {
 	struct mpc_config_intsrc intsrc;
-	int			i = 0;
-	int			found = 0;
 	int			ioapic = -1;
 	int			pin = -1;
 
@@ -958,28 +956,14 @@
 	intsrc.mpc_dstapic = mp_ioapics[ioapic].mpc_apicid;	   /* APIC ID */
 	intsrc.mpc_dstirq = pin;				    /* INTIN# */
 
-	Dprintk("Int: type %d, pol %d, trig %d, bus %d, irq %d, %d-%d\n",
+	printk("Int: type %d, pol %d, trig %d, bus %d, irq %d, %d-%d\n",
 		intsrc.mpc_irqtype, intsrc.mpc_irqflag & 3, 
 		(intsrc.mpc_irqflag >> 2) & 3, intsrc.mpc_srcbus, 
 		intsrc.mpc_srcbusirq, intsrc.mpc_dstapic, intsrc.mpc_dstirq);
 
-	/* 
-	 * If an existing [IOAPIC.PIN -> IRQ] routing entry exists we override it.
-	 * Otherwise create a new entry (e.g. gsi == 2).
-	 */
-	for (i = 0; i < mp_irq_entries; i++) {
-		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
-			mp_irqs[i] = intsrc;
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
-		mp_irqs[mp_irq_entries] = intsrc;
-		if (++mp_irq_entries == MAX_IRQ_SOURCES)
-			panic("Max # of irq sources exceeded!\n");
-	}
+	mp_irqs[mp_irq_entries] = intsrc;
+	if (++mp_irq_entries == MAX_IRQ_SOURCES)
+		panic("Max # of irq sources exceeded!\n");
 
 	return;
 }
@@ -1010,19 +994,26 @@
 	intsrc.mpc_dstapic = mp_ioapics[ioapic].mpc_apicid;
 
 	/* 
-	 * Use the default configuration for the IRQs 0-15.  These may be
+	 * Use the default configuration for the IRQs 0-15.  Unless
 	 * overriden by (MADT) interrupt source override entries.
 	 */
 	for (i = 0; i < 16; i++) {
+		int idx;
+
+		for (idx = 0; idx < mp_irq_entries; idx++)
+			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
+				(mp_irqs[idx].mpc_srcbusirq == i ||
+				mp_irqs[idx].mpc_dstirq == i))
+					break;
 
-		if (i == 2)
-			continue;			/* Don't connect IRQ2 */
+		if (idx != mp_irq_entries)
+			continue;			  /* IRQ already used */
 
 		intsrc.mpc_irqtype = mp_INT;
 		intsrc.mpc_srcbusirq = i;		   /* Identity mapped */
 		intsrc.mpc_dstirq = i;
 
-		Dprintk("Int: type %d, pol %d, trig %d, bus %d, irq %d, "
+		printk("Int: type %d, pol %d, trig %d, bus %d, irq %d, "
 			"%d-%d\n", intsrc.mpc_irqtype, intsrc.mpc_irqflag & 3, 
 			(intsrc.mpc_irqflag >> 2) & 3, intsrc.mpc_srcbus, 
 			intsrc.mpc_srcbusirq, intsrc.mpc_dstapic, 
===== arch/i386/kernel/acpi/boot.c 1.57 vs edited =====
--- 1.57/arch/i386/kernel/acpi/boot.c	Tue Mar 30 17:05:19 2004
+++ edited/arch/i386/kernel/acpi/boot.c	Tue Apr 13 22:40:47 2004
@@ -653,9 +653,6 @@
 		return count;
 	}
 
-	/* Build a default routing table for legacy (ISA) interrupts. */
-	mp_config_acpi_legacy_irqs();
-
 	count = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr, NR_IRQ_VECTORS);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing interrupt source overrides entry\n");
@@ -669,6 +666,9 @@
 	 */
 	if (!acpi_sci_override_gsi)
 		acpi_sci_ioapic_setup(acpi_fadt.sci_int, 0, 0);
+
+	/* Fill in identity legacy mapings where no override */
+	mp_config_acpi_legacy_irqs();
 
 	count = acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src, NR_IRQ_VECTORS);
 	if (count < 0) {

--=-hXFN+HoJxVBdTORQfPMx--

