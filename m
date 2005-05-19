Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVETGLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVETGLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 02:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVETGLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 02:11:08 -0400
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:4224 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S261353AbVETGKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 02:10:48 -0400
Subject: [patch 1/1] Proposed: Let's not waste precious IRQs...
To: akpm@osdl.org
Cc: ak@suse.de, zwane@arm.linux.org.uk, len.brown@intel.com,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Thu, 19 May 2005 04:06:13 -0700
Message-Id: <20050519110613.B817D27266@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I suggest to change the way IRQs are handed out to PCI devices. Currently, each I/O APIC pin gets associated with an IRQ, no matter if the pin is used or not. It is expected that each pin can potentually be engaged by a device inserted into the corresponding PCI slot. However, this imposes severe limitation on systems that have designs that employ many  I/O APICs, only utilizing couple lines of each, such as P64H2 chipset. It is used in ES7000, and currently, there is no way to boot the system with more that 9 I/O APICs. The simple change below allows to boot a system with say 64 (or more) I/O APICs, each providing 1 slot, which otherwise impossible because of the IRQ gaps created for unused lines on each I/O APIC. It does not resolve the problem with number of devices that exceeds number of possible IRQs, but eases up a tension for IRQs on any large system with potentually large number of devices. I only implemented this for the ACPI boot, since if the system is this big and
  using newer chipsets it is probably (better be!) an ACPI based system :). The change is completely "mechanical" and does not alter any internal structures or interrupt model/implementation. The patch works for both i386 and x86_64 archs. It works with MSIs just fine, and should not intervene with implementations like shared vectors, when they get worked out and incorporated.


To illustrate, below is the interrupt distribution for 2-cell ES7000 with 20 I/O APICs, and an Ethernet card in the last slot, which should be eth1 and which was not configured because its IRQ exceeded allowable number (it actially turned out huge - 480!):

zorro-tb2:~ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
  0:      65716      30012      30007      30002      30009      30010      30010      30010    IO-APIC-edge  timer
  4:        373          0        725        280          0          0          0          0    IO-APIC-edge  serial
  8:          0          0          0          0          0          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0          0          0          0          0   IO-APIC-level  acpi
 14:         39          3          0          0          0          0          0          0    IO-APIC-edge  ide0
 16:        108         13          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb1
 18:          0          0          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb3
 19:         15          0          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb2
 23:          3          0          0          0          0          0          0          0   IO-APIC-level  ehci_hcd:usb4
 96:       4240        397         18          0          0          0          0          0   IO-APIC-level  aic7xxx
 97:         15          0          0          0          0          0          0          0   IO-APIC-level  aic7xxx
192:        847          0          0          0          0          0          0          0   IO-APIC-level  eth0
NMI:          0          0          0          0          0          0          0          0
LOC:     273423     274528     272829     274228     274092     273761     273827     273694
ERR:          7
MIS:          0

Even thouigh the system doesn't have that many devices, some don't get enabled only because of IRQ numbering model.

This is the IRQ picture after the patch was applied:

zorro-tb2:~ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
  0:      44169      10004      10004      10001      10004      10003      10004       6135    IO-APIC-edge  timer
  4:        345          0          0          0          0        244          0          0    IO-APIC-edge  serial
  8:          0          0          0          0          0          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0          0          0          0          0   IO-APIC-level  acpi
 14:         39          0          3          0          0          0          0          0    IO-APIC-edge  ide0
 17:       4425          0          9          0          0          0          0          0   IO-APIC-level  aic7xxx
 18:         15          0          0          0          0          0          0          0   IO-APIC-level  aic7xxx, uhci_hcd:usb3
 21:        231          0          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb1
 22:         26          0          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb2
 23:          3          0          0          0          0          0          0          0   IO-APIC-level  ehci_hcd:usb4
 24:        348          0          0          0          0          0          0          0   IO-APIC-level  eth0
 25:          6        192          0          0          0          0          0          0   IO-APIC-level  eth1
NMI:          0          0          0          0          0          0          0          0
LOC:     107981     107636     108899     108698     108489     108326     108331     108254
ERR:          7
MIS:          0

Not only we see the card in the last I/O APIC, but we are not even close to using up available IRQs, since we didn't waste any.

Signed-off-by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>
---


diff -puN arch/x86_64/kernel/mpparse.c~irq-pack-x86_64 arch/x86_64/kernel/mpparse.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/kernel/mpparse.c~irq-pack-x86_64	2005-05-18 15:32:19.369637392 -0700
+++ linux-2.6.12-rc4-mm2-root/arch/x86_64/kernel/mpparse.c	2005-05-19 02:36:07.017914536 -0700
@@ -903,11 +903,20 @@ void __init mp_config_acpi_legacy_irqs (
 	return;
 }
 
+#define MAX_GSI_NUM	4096
+
 int mp_register_gsi(u32 gsi, int edge_level, int active_high_low)
 {
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
 	int			idx, bit = 0;
+	static int		pci_irq = 16;
+	/*
+	 * Mapping between Global System Interrupts, which
+	 * represent all possible interrupts, to the IRQs 
+	 * assigned to actual devices.
+	 */
+	static int		gsi_to_irq[MAX_GSI_NUM];
 
 	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC)
 		return gsi;
@@ -942,11 +951,21 @@ int mp_register_gsi(u32 gsi, int edge_le
 	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-		return gsi;
+		return gsi_to_irq[gsi];
 	}
 
 	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
+	if (edge_level) {
+		/*
+		 * For PCI devices assign IRQs in order, avoiding gaps
+		 * due to unused I/O APIC pins.
+		 */
+		int irq = gsi;
+		gsi = pci_irq++;
+		gsi_to_irq[irq] = gsi;
+	}
+
 	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
 		edge_level == ACPI_EDGE_SENSITIVE ? 0 : 1,
 		active_high_low == ACPI_ACTIVE_HIGH ? 0 : 1);
_
