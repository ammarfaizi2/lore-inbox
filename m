Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVAGNyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVAGNyC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVAGNyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:54:02 -0500
Received: from pop.gmx.de ([213.165.64.20]:28822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261412AbVAGNxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:53:53 -0500
X-Authenticated: #4512188
Message-ID: <41DE9466.50006@gmx.de>
Date: Fri, 07 Jan 2005 14:53:42 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bzolnier@gmail.com, drab@kepler.fjfi.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: APIC/LAPIC hanging problems on nForce2 system.
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>	<41DC1AD7.7000705@gmx.de>	<Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>	<41DC2113.8080604@gmx.de>	<Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>	<41DC2353.7010206@gmx.de>	<Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>	<41DCFEF0.5050105@gmx.de>	<58cb370e05010605527f87297e@mail.gmail.com>	<41DD537B.9030304@gmx.de>	<20050106154650.33c3b11c.akpm@osdl.org>	<41DDD7C3.8040406@gmx.de> <20050106164952.0a46df7e.akpm@osdl.org>
In-Reply-To: <20050106164952.0a46df7e.akpm@osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C9B605C47DD45F797A56643"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C9B605C47DD45F797A56643
Content-Type: multipart/mixed;
 boundary="------------070407020901070906000301"

This is a multi-part message in MIME format.
--------------070407020901070906000301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton schrieb:
> "Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
>
>>Perhaps firfox fscked up the inlined patch, so please
>>try the attached version. If it goes alright, I'll resubmit it,
>>inlcuding more detailed description.
>
>
> There was no attachment.

*sigh* Not in my last email, but when I submitted the patch...

> Please go ahead and prepare a final patch against Linus's latest tree.  The
> simplest way to obtain that is via the topmost link at
> http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/.

It applies cleanly there. Nevertheless, once again, with more details.
If inlined version doesn't patch, please try attached!

current state:
Systems with Nforce2 could freeze on high disk i/o activity in APIC mode
when CPU Disconnect is enabled. If bios doesn't fix this, current kernel
fix changes the registers according to follwing table:

      * Chip  Old value   New value
      * C17   0x1F0FFF01  0x1F01FF01
      * C18D  0x9F0FFF01  0x9F01FF01

But this is only done, if cpu disconnect has been enabled in bios.


why change this:
If CPU disconnect is not enabled in bios, and bios is broken (some
manufacturers like Abit don't care about their customers and even the
latest bios doesn't fix this; I have an Abit mainboard), the kernel
doesn't apply the fix, so if cpu disconnect is enabled at a later stage
(in userspace), the system will be unstable and most likely freeze.

new behaviour:
The fix is now applied regardless of cpu disconnect being enabled at
boot time, or not. As you only have to change byte 3 to 0x01, reading
out chipset version isn't needed, so the patch simplifies the fix. Now
turning cpu disconnect on, at later stage won't break the system, and if
it was already enabled, it gets fixed, as the old version did.


Signed-off-by: Prakash Punnoor <prakashp@arcor.de>


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

--------------070407020901070906000301
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

--------------070407020901070906000301--

--------------enig2C9B605C47DD45F797A56643
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFB3pRuxU2n/+9+t5gRAjX2AJ4qcmHa6BS18F6uXsDnufaHzv5nhQCeKtIK
nmRbNxQoq/C+xTVf0Y+rZ3k=
=eIJu
-----END PGP SIGNATURE-----

--------------enig2C9B605C47DD45F797A56643--
