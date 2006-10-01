Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751993AbWJABlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWJABlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 21:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWJABlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 21:41:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:53519 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751993AbWJABla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 21:41:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VO3q1ZBWtvcaWhGeKUcnMKDKhGureOibShXYyVkbw6AUU4oaKdYSFoG48ULi6IA2B7ZGkIQg1u2Qhjpv8ly1AcaPnMqEqyySuiflo3KvcFou+127Q26s0U4HRhqs4AuMBf6ZL0jwNs89Rsl9bb5c/gQtHe/RZDlikImXWq4aT2w=
Message-ID: <5f3c152b0609301841h220b94e4wdbf000a729f8992c@mail.gmail.com>
Date: Sun, 1 Oct 2006 03:41:28 +0200
From: "Eric Rannaud" <eric.rannaud@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: zoran driver breaks 'make all{yes,mod}config'
Cc: v4l-dvb-maintainer@linuxtv.org,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <451F1887.3040102@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <451F1887.3040102@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, the following -mm patch from Alan Cox is missing:
pci-quirks-update.patch


-- (should be the most recent) --
From: Alan Cox
This fixes two things

Firstly someone mistakenly used "errata" for the singular. This causes
Dave Woodhouse to emit diagnostics whenever the string is read, and so
should be fixed.

Secondly the AMD AGP tunnel has an erratum which causes hangs if you try
and do direct PCI to AGP transfers in some cases. We have a flag for
PCI/PCI failures but we need a different flag for this really as in this
case we don't want to stop PCI/PCI transfers using things like IOAT and
the new RAID offload work.

I'll post some updates to make proper use of the PCIAGP flag in the
media/video drivers to Mauro.

Signed-off-by: Alan Cox <a...@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude
linux.vanilla-2.6.18-rc6-mm1/drivers/pci/quirks.c
linux-2.6.18-rc6-mm1/drivers/pci/quirks.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/pci/quirks.c   2006-09-11
17:00:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/pci/quirks.c   2006-09-13
15:09:15.000000000 +0100
@@ -93,8 +93,21 @@
                pci_pci_problems |= PCIPCI_FAIL;
        }
 }
+
+static void __devinit quirk_nopciamd(struct pci_dev *dev)
+{
+       u8 rev;
+       pci_read_config_byte(dev, 0x08, &rev);
+       if (rev == 0x13) {
+               /* Erratum 24 */
+               printk(KERN_INFO "Chipset erratum: Disabling direct
PCI/AGP transfers.\n");
+               pci_pci_problems |= PCIAGP_FAIL;
+       }
+}
+
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,      PCI_DEVICE_ID_SI_5597,
         quirk_nopcipci );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,      PCI_DEVICE_ID_SI_496,
         quirk_nopcipci );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_8151_0,       quirk_nopciamd );

 /*
  *     Triton requires workarounds to be used by the drivers
@@ -561,7 +574,7 @@
  * is currently marked NoFix
  *
  * We have multiple reports of hangs with this chipset that went away with
- * noapic specified. For the moment we assume its the errata. We may be wrong
+ * noapic specified. For the moment we assume its the erratum. We may be wrong
  * of course. However the advice is demonstrably good even if so..
  */
 static void __devinit quirk_amd_ioapic(struct pci_dev *dev)
@@ -570,7 +583,7 @@

        pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
        if (rev >= 0x02) {
-               printk(KERN_WARNING "I/O APIC: AMD Errata #22 may be
present. In the event of instability try\n");
+               printk(KERN_WARNING "I/O APIC: AMD Erratum #22 may be
present. In the event of instability try\n");
                printk(KERN_WARNING "        : booting with the
\"noapic\" option.\n");
        }
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude
linux.vanilla-2.6.18-rc6-mm1/include/linux/pci.h
linux-2.6.18-rc6-mm1/include/linux/pci.h
--- linux.vanilla-2.6.18-rc6-mm1/include/linux/pci.h    2006-09-11
17:00:24.000000000 +0100
+++ linux-2.6.18-rc6-mm1/include/linux/pci.h    2006-09-13
12:11:46.000000000 +0100
@@ -875,12 +875,13 @@
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);

 extern int pci_pci_problems;
-#define PCIPCI_FAIL            1
+#define PCIPCI_FAIL            1       /* No PCI PCI DMA */
 #define PCIPCI_TRITON          2
 #define PCIPCI_NATOMA          4
 #define PCIPCI_VIAETBF         8
 #define PCIPCI_VSFX            16
-#define PCIPCI_ALIMAGIK                32
+#define PCIPCI_ALIMAGIK                32      /* Need low latency setting */
+#define PCIAGP_FAIL            64      /* No PCI to AGP DMA */

 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
--
