Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278019AbRJIWWp>; Tue, 9 Oct 2001 18:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278018AbRJIWWi>; Tue, 9 Oct 2001 18:22:38 -0400
Received: from Expansa.sns.it ([192.167.206.189]:10770 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278020AbRJIWWS>;
	Tue, 9 Oct 2001 18:22:18 -0400
Date: Wed, 10 Oct 2001 00:22:35 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Gergely Tamas <dice@mfa.kfki.hu>
cc: Marco Berizzi <pupilla@hotmail.com>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
In-Reply-To: <Pine.LNX.4.33.0110091347001.12835-100000@falka.mfa.kfki.hu>
Message-ID: <Pine.LNX.4.33.0110100021360.24292-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on 2.4.10

*** linux/arch/i386/kernel/pci-pc.c     Mon Sep 24 00:21:37 2001
--- 2.4.10/arch/i386/kernel/pci-pc.c    Sat Sep 29 12:03:13 2001
***************
*** 907,912 ****
--- 907,928 ----
        return rt;
  }

+ /* Fixes some oopses on fast_copy_page when it uses 'movntq's
+  * instead of 'movq's on Athlon/Duron optimized kernels.
+  * Bit 7 at offset 0x55 seems to be responsible.
+  * > Device 0 Offset 55 - Debug (RW)
+  * > 7-0 Reserved (do not program). default = 0
+  * > *** ABIT KT7A 3R BIOS: non-zero!? (oopses)
+  * > *** ABIT KT7A YH BIOS: zero. (works)
+  */
+ static void __init pci_fixup_athlon_bug(struct pci_dev *d)
+ {
+        u8 v;
+        printk("Trying to stomp on Athlon bug...\n");
+        pci_read_config_byte(d, 0x55, &v);
+        v &= 0x7f; /* clear bit 55.7 */
+        pci_write_config_byte(d, 0x55, v);
+ }

  int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq)
  {
***************
*** 1172,1177 ****
--- 1188,1194 ----
        { PCI_FIXUP_HEADER,     PCI_ANY_ID,             PCI_ANY_ID,
pci_fixup_ide_bases },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,
PCI_DEVICE_ID_SI_5597, pci_fixup_latency },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,
PCI_DEVICE_ID_SI_5598, pci_fixup_latency },
+       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,
+PCI_DEVICE_ID_VIA_8363_0, pci_fixup_athlon_bug },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82371AB_3,  pci_fixup_piix4_acpi },
        { 0 }
  };



On Tue, 9 Oct 2001, Gergely Tamas wrote:

> Hi!
>
>  > Could I try to patch also 2.4.10 kernel?
>
> You can do this 'by hand'. 2.4.10 changed the structure a bit. But I sent
> VDA a modified patch some time ago. Maybe just ask him.
>
>  > This patch will be included in kernel 2.4.11?
>
> I don't think so. :(
>
> Honestly I'm not happy about this, but there had beed a large discussion
> about it. There were some people which mobo worked right 'out of the box',
> and they found that others should patch their kernels by hand to be able
> to use their linux boxes. :(((
>
> Gergely
>
> ps: I use this patch too on an ABIT KT7A mobo with Duron 750
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

