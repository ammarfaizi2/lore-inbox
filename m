Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSL0L3z>; Fri, 27 Dec 2002 06:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSL0L3z>; Fri, 27 Dec 2002 06:29:55 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:38916 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264886AbSL0L3y>; Fri, 27 Dec 2002 06:29:54 -0500
Date: Fri, 27 Dec 2002 14:37:54 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jason Papadopoulos <jasonp@boo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: panic during boot: 2.5.53 on alpha
Message-ID: <20021227143754.A2107@jurassic.park.msu.ru>
References: <3.0.6.32.20021226204855.007e4e30@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3.0.6.32.20021226204855.007e4e30@boo.net>; from jasonp@boo.net on Thu, Dec 26, 2002 at 08:48:55PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2002 at 08:48:55PM -0500, Jason Papadopoulos wrote:
> Turning off module support lets the 2.5.53 kernel compile on an Alpha, but
> when booting on a DS10 the kernel claims that the argument to "root=" is
> invalid, fails to mount the root filesystem, and panics. 
> 
> The 2.2 and 2.4 kernels all worked fine with "root=/dev/hda3". The machine
> has a single IDE drive; /boot is mounted on hda1, /tmp on hda2, and / on hda3.
> The gzipped vmlinux and System.map are both in /boot.

The 2.5 is known to have problems with certain IDE chipsets.
Please try appended patch.

Ivan.

--- 2.5.53/drivers/pci/quirks.c	Tue Dec 24 16:13:22 2002
+++ linux/drivers/pci/quirks.c	Fri Dec 27 14:17:43 2002
@@ -536,6 +536,48 @@ static void __init quirk_mediagx_master(
 }
 
 /*
+ * As per PCI spec, ignore base address registers 0-3 of the IDE controllers
+ * running in Compatible mode (bits 0 and 2 in the ProgIf for primary and
+ * secondary channels respectively). If the device reports Compatible mode
+ * but does use BAR0-3 for address decoding, we assume that firmware has
+ * programmed these BARs with standard values (0x1f0,0x3f4 and 0x170,0x374).
+ * Exceptions (if they exist) must be handled in chip/architecture specific
+ * fixups.
+ */ 
+static void __devinit
+quirk_ide_bases(struct pci_dev *dev)
+{
+	struct resource *res;
+	int first_bar = 2, last_bar = 0;
+
+	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
+		return;
+
+	res = &dev->resource[0];
+
+	/* primary channel: ProgIf bit 0, BAR0, BAR1 */
+	if (!(dev->class & 1) && (res[0].flags || res[1].flags)) { 
+		res[0].start = res[0].end = res[0].flags = 0;
+		res[1].start = res[1].end = res[1].flags = 0;
+		first_bar = 0;
+		last_bar = 1;
+	}
+
+	/* secondary channel: ProgIf bit 2, BAR2, BAR3 */
+	if (!(dev->class & 4) && (res[2].flags || res[3].flags)) { 
+		res[2].start = res[2].end = res[2].flags = 0;
+		res[3].start = res[3].end = res[3].flags = 0;
+		last_bar = 3;
+	}
+
+	if (!last_bar)
+		return;
+
+	printk(KERN_INFO "PCI: Ignoring BAR%d-%d of IDE controller %s\n",
+	       first_bar, last_bar, dev->slot_name);
+}
+
+/*
  *  The main table of quirks.
  */
 
@@ -577,6 +619,7 @@ static struct pci_fixup pci_fixups[] __d
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb },
+	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_ide_bases },
 	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy },
 
 #ifdef CONFIG_X86_IO_APIC 
