Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285452AbRLGK3G>; Fri, 7 Dec 2001 05:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285455AbRLGK25>; Fri, 7 Dec 2001 05:28:57 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:41623 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S285452AbRLGK2k>; Fri, 7 Dec 2001 05:28:40 -0500
Message-ID: <006d01c17f09$f4d61ab0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Calin A. Culianu" <calin@ajvar.org>,
        "Petri Kaukasoina" <kaukasoi@elektroni.ee.tut.fi>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0112061657150.22686-100000@rtlab.med.cornell.edu>
Subject: [PATCH][highly-experimental] via-mwq (Was: Re: VIA acknowledges North Bridge bug...)
Date: Fri, 7 Dec 2001 11:28:47 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_006A_01C17F12.56639430"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_006A_01C17F12.56639430
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

----- Original Message -----
From: "Calin A. Culianu" <calin@ajvar.org>
To: "Petri Kaukasoina" <kaukasoi@elektroni.ee.tut.fi>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 06, 2001 11:09 PM
Subject: Re: VIA acknowledges North Bridge bug (AKA Linux Kernel with Athlon

> Here is the webpage:
>
> This patch detects the 0305, 3099, 3102, and 3112 (KT133x, KT266x, VT8662,
> and KLE133) *only*. On these chipsets, it will patch register 55 in the
> Northbridge, which will supposedly switch off a Memory Write Queue timer.
> In the KT133A datasheet, register 55 is "reserved". But - yikes! - in the
> KT266, the documented MWQ register is register 95, not 55. Register 55
> contains unrelated DDR timing adjustments and could actually be dangerous
> to program. For this reason, I do not recommend installing this driver on
> the KT266x chipsets until VIA examines this issue. For now, use WPCREDIT
> and set bits 5, 6, and 7 to zero in register 95 instead."
>
> ----
>
> Clearly, we need to modify the via workaround patches to take into account
> the other via device id's (namely 3099, 3102, and 3112), and for each one
> change the appropriate register.  Either register 55 or in the case of the
> kt266x, register 95.  I am grepping through quirks.c right now and it
> seems this would be the correct file to modify.. any other suggestions on
> what file to modify?

I've (hastily) put these changes into "arch/i386/kernel/pci-pc.c" and had to
modify "include/linux/pci_ids.h" too.

The patch is included, but a warning: I have no VIA based computer that I
can test this on myself...

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


------=_NextPart_000_006A_01C17F12.56639430
Content-Type: application/octet-stream;
	name="via-mwq.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="via-mwq.patch"

--- linux-2.4.16/arch/i386/kernel/pci-pc.c	Fri Nov  9 22:58:02 2001=0A=
+++ linux-2.4.16-devel/arch/i386/kernel/pci-pc.c	Fri Dec  7 11:00:01 2001=0A=
@@ -1109,25 +1109,38 @@=0A=
 }=0A=
 =0A=
 /*=0A=
- * Nobody seems to know what this does. Damn.=0A=
- *=0A=
- * But it does seem to fix some unspecified problem=0A=
+ * This does seem to fix some unspecified problem=0A=
  * with 'movntq' copies on Athlons.=0A=
  *=0A=
- * VIA 8363 chipset:=0A=
- *  - bit 7 at offset 0x55: Debug (RW)=0A=
+ * VIA 8361/8363/8662 chipset:=0A=
+ *  - bit 7,6,5 at offset 0x55: Debug (RW)=0A=
  */=0A=
 static void __init pci_fixup_via_athlon_bug(struct pci_dev *d)=0A=
 {=0A=
 	u8 v;=0A=
 	pci_read_config_byte(d, 0x55, &v);=0A=
-	if (v & 0x80) {=0A=
-		printk("Trying to stomp on Athlon bug...\n");=0A=
-		v &=3D 0x7f; /* clear bit 55.7 */=0A=
+	if (v & 0xE0) {=0A=
+		printk("PCI: Disabling VIA VT8361/8363/8662 Memory Write Queue\n");=0A=
+		v &=3D 0x1f; /* clear bit 55.7, 6, 5 */=0A=
 		pci_write_config_byte(d, 0x55, v);=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * VIA 8366 chipset:=0A=
+ *  - bit 7,6,5 at offset 0x95: Debug (RW)=0A=
+ */=0A=
+static void __init pci_fixup_via_kt266_athlon_bug(struct pci_dev *d)=0A=
+{=0A=
+	u8 v;=0A=
+	pci_read_config_byte(d, 0x95, &v);=0A=
+	if (v & 0xE0) {=0A=
+		printk("PCI: Disabling VIA VT8366 Memory Write Queue\n");=0A=
+		v &=3D 0x1f; /* clear bit 55.7, 6, 5 */=0A=
+		pci_write_config_byte(d, 0x95, v);=0A=
+	}=0A=
+}=0A=
+=0A=
 struct pci_fixup pcibios_fixups[] =3D {=0A=
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	=
pci_fixup_i450nx },=0A=
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	=
pci_fixup_i450gx },=0A=
@@ -1138,6 +1151,9 @@=0A=
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		=
pci_fixup_latency },=0A=
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	=
PCI_DEVICE_ID_INTEL_82371AB_3,	pci_fixup_piix4_acpi },=0A=
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	=
pci_fixup_via_athlon_bug },=0A=
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8366_0,	=
pci_fixup_via_kt266_athlon_bug },=0A=
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8662_0,	=
pci_fixup_via_athlon_bug },=0A=
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361_0,	=
pci_fixup_via_athlon_bug },=0A=
 	{ 0 }=0A=
 };=0A=
 =0A=
--- linux-2.4.16/include/linux/pci_ids.h	Fri Nov  9 23:11:15 2001=0A=
+++ linux-2.4.16-devel/include/linux/pci_ids.h	Fri Dec  7 00:25:12 2001=0A=
@@ -948,6 +948,9 @@=0A=
 #define PCI_DEVICE_ID_VIA_8233_0	0x3074=0A=
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109=0A=
 #define PCI_DEVICE_ID_VIA_8633_0	0x3091=0A=
+#define PCI_DEVICE_ID_VIA_8366_0	0x3099=0A=
+#define PCI_DEVICE_ID_VIA_8662_0	0x3102=0A=
+#define PCI_DEVICE_ID_VIA_8361_0	0x3112=0A=
 #define PCI_DEVICE_ID_VIA_8367_0	0x3099=0A=
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100=0A=
 #define PCI_DEVICE_ID_VIA_8231		0x8231=0A=

------=_NextPart_000_006A_01C17F12.56639430--

