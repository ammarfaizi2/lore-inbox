Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273337AbRINI1F>; Fri, 14 Sep 2001 04:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273340AbRINI0z>; Fri, 14 Sep 2001 04:26:55 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:34321 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S273337AbRINI0y>;
	Fri, 14 Sep 2001 04:26:54 -0400
Date: Fri, 14 Sep 2001 05:27:49 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Chris Vandomelen <chrisv@b0rked.dhs.org>, linux-kernel@vger.kernel.org,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Athlon: Try this (was: Re: Athlon bug stomping #2)
In-Reply-To: <Pine.GSO.4.21.0109140430540.2204-100000@jacui>
Message-ID: <Pine.GSO.4.21.0109140523060.3130-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Roberto Jung Drebes wrote:

> On 13 Sep 2001, Eric W. Biederman wrote:
> 
> > Anyone want to generate a kernel patch so this fix can get some wider
> > testing?
> 
> I'll try to isolate the single bit in the register that is causing the
> fault and will send the diff.

I tested here and it seems that bit 7 is responsible. Here is the diff to
pci-pc.c:

=================================================
--- linux-2.4.9/arch/i386/kernel/pci-pc.c.orig	Fri Sep 14 05:03:59 2001
+++ linux-2.4.9/arch/i386/kernel/pci-pc.c	Fri Sep 14 05:12:28 2001
@@ -701,6 +701,22 @@
 	return rt;
 }
 
+/* Fixes some oopses on fast_copy_page when it uses 'movntq's
+ * instead of 'movq's on Athlon/Duron optimized kernels. 
+ * Bit 7 at offset 0x55 seems to be responsible. 
+ * > Device 0 Offset 55 - Debug (RW)
+ * > 7-0 Reserved (do not program). default = 0
+ * > *** ABIT KT7A 3R BIOS: non-zero!? (oopses)
+ * > *** ABIT KT7A YH BIOS: zero. (works)
+ */
+static void __init pci_fixup_athlon_bug(struct pci_dev *d)
+{ 
+       u8 v; 
+       printk("Trying to stomp on Athlon bug...\n");
+       pci_read_config_byte(d, 0x55, &v);
+       v &= 0x7f; /* clear bit 55.7 */
+       pci_write_config_byte(d, 0x55, v);
+}
 
 int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq)
 {
@@ -966,6 +982,8 @@
 	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			pci_fixup_ide_bases },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		pci_fixup_latency },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		pci_fixup_latency },
+	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,   PCI_DEVICE_ID_VIA_8363_0,
+     pci_fixup_athlon_bug }, 
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	pci_fixup_piix4_acpi },
 	{ 0 }
 };
=================================================

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

