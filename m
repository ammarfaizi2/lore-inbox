Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270009AbRIBW3D>; Sun, 2 Sep 2001 18:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270031AbRIBW2w>; Sun, 2 Sep 2001 18:28:52 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:14607 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S270009AbRIBW2j>; Sun, 2 Sep 2001 18:28:39 -0400
Date: Mon, 3 Sep 2001 00:28:55 +0200
From: Jan Niehusmann <jan@gondor.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VCool - cool your Athlon/Duron during idle
Message-ID: <20010903002855.A645@gondor.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0B7@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0B7@orsmsx35.jf.intel.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 02:26:09AM -0700, Grover, Andrew wrote:
> Well I don't want to inhibit your hackerly fervor, but C2 and C3 handling
> are already supported by the ACPI driver, in a vendor-neutral manner.

I did look into this, and indeed the ACPI code is doing this much better
than my patch did. 

The only thing it is missing is enabling disconnect in C2 mode. Of course,
enabling a feature that may have been disabled by the BIOS with a good reason
may be dangerous. Still, it seems to work for me ;-) and saves a lot of power.

With the ACPI code and a simple patch that enables bus disconnection, I get
the same power saving as with the lvcool userspace program, but a much better
performance for things like NFS access. (in fact, NFS access is the only
thing where I notice a significant slowdown when running lvcool)

Additionaly, this patch is much smaller than the last one. But of course,
it's only usefull if ACPI is working (which it is for me).
I added the code to quirks.c because it allowed some quick cut&paste ;-)
The code is enabled if the kernel is booted with via_disconnect=yes

To give some numbers (measured with a simple, probably not very accurate
'power monitor'):
Idle without disconnect: ~80W
Idle with disconnect: ~60W
Compiling a kernel: ~90W
(all numbers for a Duron 800, Asus A7V133, Voodoo 3, Maxtor 80GB hard disk,
256MB RAM and some PCI cards)

By the way, does anybody know why modprobe ospm_busmgr doesn't return, but
the module works if I interrupt the modprobe with CTRL-C?

Jan


diff -ur linux-2.4.9-ac5/drivers/pci/quirks.c linux-2.4.9-ac5-vcool/drivers/pci/quirks.c
--- linux-2.4.9-ac5/drivers/pci/quirks.c	Sun Sep  2 15:37:56 2001
+++ linux-2.4.9-ac5-vcool/drivers/pci/quirks.c	Sun Sep  2 23:58:12 2001
@@ -21,6 +21,8 @@
 
 #undef DEBUG
 
+int enable_via_disconnect;
+
 /* Deal with broken BIOS'es that neglect to enable passive release,
    which can cause problems in combination with the 82441FX/PPro MTRRs */
 static void __init quirk_passive_release(struct pci_dev *dev)
@@ -146,6 +148,21 @@
 	printk(KERN_INFO "Applying VIA southbridge workaround.\n");
 }
 
+static void __init quirk_viadisconnect(struct pci_dev *dev)
+{
+	u32 res32;
+
+	if(!enable_via_disconnect) return;
+
+	pci_read_config_dword(dev,0x52&0xfc,&res32);
+	if ((res32&0x00800000)==0) {
+		printk(KERN_INFO "Enabling disconnect in VIA northbridge.\n");
+		res32|=0x00800000;
+		pci_write_config_dword(dev,0x52&0xfc,res32);
+	} else
+		printk(KERN_INFO "Disconnect already anabled in VIA northbridge.\n");
+}
+
 /*
  *	VIA Apollo VP3 needs ETBF on BT848/878
  */
@@ -453,6 +470,8 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_viadisconnect },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_0,	quirk_viadisconnect },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	0x3112	/* Not out yet ? */,	quirk_vialatency },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf },
@@ -500,3 +519,12 @@
 	pci_do_fixups(dev, pass, pcibios_fixups);
 	pci_do_fixups(dev, pass, pci_fixups);
 }
+
+static int __init via_disconnect_setup (char *str) {
+	if(!strncmp(str,"yes",3)) {
+		enable_via_disconnect=1;
+	}
+	return 1;
+}
+
+__setup("via_disconnect=", via_disconnect_setup);
