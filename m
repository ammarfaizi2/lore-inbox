Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268793AbUHLVxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268793AbUHLVxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268804AbUHLVxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:53:34 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:65238 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268793AbUHLVv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:51:58 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Date: Thu, 12 Aug 2004 15:50:15 -0600
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com> <1092259920.5021.117.camel@dhcppc4>
In-Reply-To: <1092259920.5021.117.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408121550.15892.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 August 2004 3:32 pm, Len Brown wrote:
> I've never understood this floppy IRQ6 business.
> Apparently it requests IRQ6, but doesn't show up in /proc/interrupts

floppy_init() requests IRQ6, but then frees it before returning.  It
looks like the driver only holds onto it while the device is actually
open, which explains why it doesn't usually show up in /proc/interrupts.

Len later wrote:
> I assert it is a BIOS bug for the BIOS to set LNKD to
> IRQ6 if there is a floppy present and enabled; but fair
> game if there is no floppy.  Though perhaps floppy.c
> doesn't understand that.

Adrian has the floppies disabled in the BIOS, so maybe it's
legit to use IRQ6 for the NIC PCI interrupt.  But floppy.c
doesn't check for anything like that as far as I can see.

The fact that floppy.c seems to be able to poke the controller
and get an interrupt back (with "pci=routeirq") suggests to me
that the floppy controller responds even when disabled in the
BIOS, and that it actually expects IRQ6 to be level-triggered,
but the BIOS is leaving it configured as edge-triggered.

I suspect that the patch below will "fix" it.  I suppose we could
use a DMI-based quirk to poke this.  But it still feels like a
better solution would be to change floppy.c to:

	if (ACPI && (no floppy in ACPI namespace))
		return -ENODEV
	<poke around as we do today>

--- 2.6.8-rc4-mm1/arch/i386/kernel/dmi_scan.c.orig	2004-08-12 15:04:59.302833471 -0600
+++ 2.6.8-rc4-mm1/arch/i386/kernel/dmi_scan.c	2004-08-12 15:05:08.475684921 -0600
@@ -21,7 +21,7 @@
 	u16	handle;
 };
 
-#undef DMI_DEBUG
+#define DMI_DEBUG 1
 
 #ifdef DMI_DEBUG
 #define dmi_printk(x) printk x
--- 2.6.8-rc4-mm1/arch/i386/pci/irq.c.orig	2004-08-10 16:23:45.801962683 -0600
+++ 2.6.8-rc4-mm1/arch/i386/pci/irq.c	2004-08-12 15:23:35.494226047 -0600
@@ -953,6 +953,17 @@
 
 static int __init pcibios_irq_init(void)
 {
+	unsigned int irq = 6;
+	unsigned char mask = 1 << (irq & 7);
+	unsigned int port = 0x4d0 + (irq >> 3);
+	unsigned char val = inb(port);
+
+	printk("%s: PIC edge/level control 0x%x\n", __FUNCTION__, val);
+	if (!(val & mask)) {
+		printk("%s: changing IRQ6 to level (0x%x)\n", __FUNCTION__, val | mask);
+		outb(val | mask, port);
+	}
+
 	DBG("PCI: IRQ init\n");
 
 	if (pcibios_enable_irq || raw_pci_ops == NULL)
--- 2.6.8-rc4-mm1/drivers/block/floppy.c.orig	2004-08-12 11:20:49.326435733 -0600
+++ 2.6.8-rc4-mm1/drivers/block/floppy.c	2004-08-12 15:28:07.282308655 -0600
@@ -1743,6 +1743,7 @@
 	int do_print;
 	unsigned long f;
 
+	printk("%s\n", __FUNCTION__);
 	lasthandler = handler;
 	interruptjiffies = jiffies;
 
