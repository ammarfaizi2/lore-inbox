Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUDCWgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 17:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUDCWg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 17:36:28 -0500
Received: from viefep15-int.chello.at ([213.46.255.19]:65122 "EHLO
	viefep15-int.chello.at") by vger.kernel.org with ESMTP
	id S261996AbUDCWgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 17:36:18 -0500
Subject: RE: BUG: nforce IDE DMA with APIC enabled bug has re-emerged
	Kernel 2.6.4
From: Attila BODY <compi@freemail.hu>
To: linux-kernel@vger.kernel.org
Cc: Richard James <richard@techdrive.com.au>
Content-Type: text/plain
Message-Id: <1081031766.1026.499.camel@smiley.localnet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 04 Apr 2004 00:36:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>The ugly nforce IDE DMA with APIC enabled bug has re-emerged on my
>system

>Kernel 2.6.4 fails, they hard lock linux no ctrl-alt-delete, music goes
>bzzzzt then stops. I have to either 6 seconds on the power switch or
>hit the
>reset switch to reboot. This usually occurs within a few minutes of
>booting
>or faster if I force a large disk read or copy.

Almost the same here.

I cannot reproduce the issue on my asus a7n8x with the same HDD &
installed OS, only on biostar M7NCD Pro. a7n8x has an Barton 2500 with
166MHz FSB, m7ncd has an XP 1700 with 133MHz FSB. The machine freezes
completely, the IDE activity led stays on.

It also happens if I disable APIC in the BIOS or passing noapic to the
kernel

A dd if=/dev/hda of=/dev/null freezes the system almost immediately.

Fedora Core 2 Test1 with kernel 2.6.1 seems working, also 2.4 series.
Debian's and stock 2.6.3 works like a charm, but stock 2.6.3 freezes.

2.6.5-rc3-mm4 shows the same sympthoms, dd causes death almost
immediately.

Back to stock 2.6.4:

It seems that disabling both ACPI and APIC in the kernel config solves
the problem

hdparm -d0 also solves the problem but performance is awful without DMA

Finally it seems there is a solution: I've updated the patch
http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-disconnect-quirk.patch
to be able to apply to 2.6.4 and now everything is working flawlessly. 

Can anyone enlighten me why isn't it merged to the mainstream kernel
yet? I've found lots of people with the same problems while searching
for the solution to mine, so it seems a common problem with some nforce2
motherboards.

Here is the modified patch:

>>>>>>>>>>>CUT HERE <<<<<<<<<<<<
diff -upNr linux-2.6.4/arch/i386/pci/fixup.c
linux-2.6.4.nf2/arch/i386/pci/fixup.c
--- linux-2.6.4/arch/i386/pci/fixup.c	2004-03-11 03:55:36.000000000
+0100
+++ linux-2.6.4.nf2/arch/i386/pci/fixup.c	2004-04-03 20:55:24.000000000
+0200
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
 	{
 		.pass		= PCI_FIXUP_HEADER,
@@ -290,5 +306,11 @@ struct pci_fixup pcibios_fixups[] = {
 		.device		= PCI_ANY_ID,
 		.hook		= pci_fixup_transparent_bridge
 	},
+	{
+		.pass		= PCI_FIXUP_HEADER,
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2,
+		.hook		= pci_fixup_nforce2_disconnect
+	},
 	{ .pass = 0 }
 };
>>>>>>>>>>>CUT HERE <<<<<<<<<<<<


