Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267077AbUBEXkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267083AbUBEXks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:40:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:26017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267077AbUBEXjk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:39:40 -0500
Date: Thu, 5 Feb 2004 15:40:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>
Cc: david+challenge-response@blue-labs.org, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
Message-Id: <20040205154059.6649dd74.akpm@osdl.org>
In-Reply-To: <4022B55B.1090309@wanadoo.es>
References: <402298C7.5050405@wanadoo.es>
	<40229D2C.20701@blue-labs.org>
	<4022B55B.1090309@wanadoo.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Miguel García <ktech@wanadoo.es> wrote:
>
> David Ford wrote:
> 
> > I have the same problem.  I "solved" it a while ago by mucking with 
> > the AGP stuff.  IIRC, it was turning off AGP fast writes or 8x or 
> > something similar in cmos.  Went from incredibly broken to stable 
> > instantly.  I'll check my cmos settings in a bit and refresh my memory.
> >
> > What patches are you using?
> 
> 
> I'm using nforce2-apic.patch and nforce2-disconnect-quirk.patch that 
> Andrew Morton have sent to me. I think they have been included in 
> previous mm kernels but now are droped because they caused some 
> temperature problems for some people with no nforce motherboards.

Yes, the patch which disables "Halt Disconnect and Stop Grant Disconnect"
apparently causes the CPU to run hot.

> By the way, is anyone involved in solving the IO-APIC thing in nforce 
> motherboards? Anyone trying a different approach? Anyone contacting 
> nvidia about this problem?

As far as I know, we're dead in the water on these problems.

Here's one:


[x86] do not wrongly override mp_ExtINT IRQ

From: Mathieu <cheuche+lkml@free.fr>.

With this patch timer IRQ0 is correctly set to IO-APIC-edge
(not XT-PIC) on nForce2 boards when using APIC and ACPI.

 arch/i386/kernel/mpparse.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/mpparse.c~nforce2-apic arch/i386/kernel/mpparse.c
--- linux-2.6.0-test11/arch/i386/kernel/mpparse.c~nforce2-apic	2003-12-08 00:12:25.782597272 +0100
+++ linux-2.6.0-test11-root/arch/i386/kernel/mpparse.c	2003-12-08 00:12:25.786596664 +0100
@@ -962,7 +962,8 @@ void __init mp_override_legacy_irq (
 	 */
 	for (i = 0; i < mp_irq_entries; i++) {
 		if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic) 
-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
+			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)
+			&& (mp_irqs[i].mpc_irqtype == intsrc.mpc_irqtype)) {
 			mp_irqs[i] = intsrc;
 			found = 1;
 			break;

_

Here's the other:


From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

[PATCH] fix lockups with APIC support on nForce2

Add PCI quirk to disable Halt Disconnect and Stop Grant Disconnect
(based on athcool program by Osamu Kayasono).

(Mark McPherson <mark@mahonia.com> reports that this patch causes his CPU
temperature to skyrocket).


 25-akpm/arch/i386/pci/fixup.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

diff -puN arch/i386/pci/fixup.c~nforce2-disconnect-quirk arch/i386/pci/fixup.c
--- 25/arch/i386/pci/fixup.c~nforce2-disconnect-quirk	Mon Jan  5 12:07:45 2004
+++ 25-akpm/arch/i386/pci/fixup.c	Mon Jan  5 12:07:45 2004
@@ -187,6 +187,22 @@ static void __devinit pci_fixup_transpar
 		dev->transparent = 1;
 }
 
+/*
+ * Halt Disconnect and Stop Grant Disconnect (bit 4 at offset 0x6F)
+ * must be disabled when APIC is used (or lockups will happen).
+ */
+static void __devinit pci_fixup_nforce2_disconnect(struct pci_dev *d)
+{
+	u8 t;
+
+	pci_read_config_byte(d, 0x6F, &t);
+	if (t & 0x10) {
+		printk(KERN_INFO "PCI: disabling nForce2 Halt Disconnect"
+				 " and Stop Grant Disconnect\n");
+		pci_write_config_byte(d, 0x6F, (t & 0xef));
+	}
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci_fixup_i450gx },
@@ -205,5 +221,6 @@ struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2,	pci_fixup_nforce2_disconnect },
 	{ 0 }
 };

_

