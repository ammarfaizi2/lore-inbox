Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVAFPIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVAFPIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVAFPHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:07:19 -0500
Received: from mail.gmx.de ([213.165.64.20]:51179 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262858AbVAFPEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:04:23 -0500
X-Authenticated: #4512188
Message-ID: <41DD537B.9030304@gmx.de>
Date: Thu, 06 Jan 2005 16:04:27 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Martin Drab <drab@kepler.fjfi.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: [PATCH] Re: APIC/LAPIC hanging problems on nForce2 system.
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>	 <41DC1AD7.7000705@gmx.de>	 <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>	 <41DC2113.8080604@gmx.de>	 <Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>	 <41DC2353.7010206@gmx.de>	 <Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>	 <41DCFEF0.5050105@gmx.de> <58cb370e05010605527f87297e@mail.gmail.com>
In-Reply-To: <58cb370e05010605527f87297e@mail.gmail.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC5FA0F655EBA9ABD7DC5CEA5"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5FA0F655EBA9ABD7DC5CEA5
Content-Type: multipart/mixed;
 boundary="------------090903040709040708060909"

This is a multi-part message in MIME format.
--------------090903040709040708060909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>>Well, I also think it is quite stupid to only apply the fix if
>>disconnect is enabled at boot time and don't apply it if it is not. The
>>kernel dev responsible for it is rather pedantic: Fix only when needed,

[..]
> Changing _only_ "fixup" bits seems like a reasonable compromise IMO.
> Could you (or Martin) make a patch and submit it to -mm for testing?

Ok, here it goes. It's the first time I write a patch for the kernel, so
please don't bash me. I hope my logics were alright, so please
proof-read it. I haven't tested it yet...

It simplifies the function to

static void __init pci_fixup_nforce2(struct pci_dev *dev)
{
	u32 val;

	/*
	 * Chip  Old value   New value
	 * C17   0x1F0FFF01  0x1F01FF01
	 * C18D  0x9F0FFF01  0x9F01FF01
	 *
	 * Northbridge chip version may be determined by
	 * reading the PCI revision ID (0xC1 or greater is C18D).
	 */
	pci_read_config_dword(dev, 0x6c, &val);

	/*
	 * Apply fixup if needed, but don't touch disconnect state
	 */
	if ((val & 0x00FF0000) != 0x00010000) {
		printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
		pci_write_config_dword(dev, 0x6c, (val & 0xFF00FFFF) | 0x00010000);
	}
}



This patch applies the Nforce2 C1 halt disconnect fix, no matter if
disconnect is enabled of not. I don't know whether checking the whole
affected byte is necessary or the nibble would be enough (I am no Nvidia
engineer).

Signed-off-by: Prakash Punnoor <prakashp@arcor.de>

(My name is soon officially to be changed, in case you are wondering.)


--- arch/i386/pci/fixup.c.o	2005-01-06 15:43:40.535842320 +0100
+++ arch/i386/pci/fixup.c	2005-01-06 16:00:50.174313480 +0100
@@ -227,10 +227,7 @@
   */
  static void __init pci_fixup_nforce2(struct pci_dev *dev)
  {
-	u32 val, fixed_val;
-	u8 rev;
-
-	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+	u32 val;

  	/*
  	 * Chip  Old value   New value
@@ -240,17 +237,14 @@
  	 * Northbridge chip version may be determined by
  	 * reading the PCI revision ID (0xC1 or greater is C18D).
  	 */
-	fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;
-
  	pci_read_config_dword(dev, 0x6c, &val);

  	/*
-	 * Apply fixup only if C1 Halt Disconnect is enabled
-	 * (bit28) because it is not supported on some boards.
+	 * Apply fixup if needed, but don't touch disconnect state
  	 */
-	if ((val & (1 << 28)) && val != fixed_val) {
+	if ((val & 0x00FF0000) != 0x00010000) {
  		printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
-		pci_write_config_dword(dev, 0x6c, fixed_val);
+		pci_write_config_dword(dev, 0x6c, (val & 0xFF00FFFF) | 0x00010000);
  	}
  }
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA,
PCI_DEVICE_ID_NVIDIA_NFORCE2, pci_fixup_nforce2);



--------------090903040709040708060909
Content-Type: text/x-patch;
 name="always_nforce2_c1_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="always_nforce2_c1_fix.patch"

--- arch/i386/pci/fixup.c.o	2005-01-06 15:43:40.535842320 +0100
+++ arch/i386/pci/fixup.c	2005-01-06 16:00:50.174313480 +0100
@@ -227,10 +227,7 @@
  */
 static void __init pci_fixup_nforce2(struct pci_dev *dev)
 {
-	u32 val, fixed_val;
-	u8 rev;
-
-	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+	u32 val;

 	/*
 	 * Chip  Old value   New value
@@ -240,17 +237,14 @@
 	 * Northbridge chip version may be determined by
 	 * reading the PCI revision ID (0xC1 or greater is C18D).
 	 */
-	fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;
-
 	pci_read_config_dword(dev, 0x6c, &val);

 	/*
-	 * Apply fixup only if C1 Halt Disconnect is enabled
-	 * (bit28) because it is not supported on some boards.
+	 * Apply fixup if needed, but don't touch disconnect state
 	 */
-	if ((val & (1 << 28)) && val != fixed_val) {
+	if ((val & 0x00FF0000) != 0x00010000) {
 		printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
-		pci_write_config_dword(dev, 0x6c, fixed_val);
+		pci_write_config_dword(dev, 0x6c, (val & 0xFF00FFFF) | 0x00010000);
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2, pci_fixup_nforce2);

--------------090903040709040708060909--

--------------enigC5FA0F655EBA9ABD7DC5CEA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFB3VN7xU2n/+9+t5gRAuF+AJ9mxO5W2zJek116ZMF15UAGyDgoRQCfcPJs
G5XB0XsTibzUtAuX02hkic0=
=2g4a
-----END PGP SIGNATURE-----

--------------enigC5FA0F655EBA9ABD7DC5CEA5--
