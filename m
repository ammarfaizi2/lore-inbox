Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136426AbRD3BGr>; Sun, 29 Apr 2001 21:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136425AbRD3BGh>; Sun, 29 Apr 2001 21:06:37 -0400
Received: from dutidad.twi.tudelft.nl ([130.161.158.199]:18316 "EHLO dutidad")
	by vger.kernel.org with ESMTP id <S136424AbRD3BG2>;
	Sun, 29 Apr 2001 21:06:28 -0400
Date: Mon, 30 Apr 2001 03:06:26 +0200
From: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com, goemon@anime.net
Subject: Re: 2.4.4 Sound corruption [PATCH]
Message-ID: <20010430030626.A7981@dutidad.twi.tudelft.nl>
Reply-To: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
In-Reply-To: <20010430021015.A7925@dutidad.twi.tudelft.nl> <Pine.LNX.4.30.0104291722280.19431-100000@anime.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104291722280.19431-100000@anime.net>; from goemon@anime.net on Sun, Apr 29, 2001 at 05:29:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a patch to the quirks.c in linux kernel 2.4.4 that fixes the
sound corruption problem (thanks to Dan Hollis for the info).  Do I have to
send this anywhere else as well?

On Sun, Apr 29, 2001 at 05:29:05PM -0700, Dan Hollis wrote:
> On Mon, 30 Apr 2001, Charl P. Botha wrote:
> > I have removed this code and everything is now fine on my system.  The
> > problem is that the 686A and 686B have the same PCI IDs, else I would have
> > submitted a patch.
> 
> 686a is rev 0x10 - 0x2f, 686b is rev 0x40 - 0x4f.
> 
> The fixup code should take this into account.
> 
> -Dan

-- 
charl p. botha      | computer graphics and cad/cam 
http://cpbotha.net/ | http://www.cg.its.tudelft.nl/

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via686a_sound_corruption_patch.diff"

--- quirks.c-2.4.4	Mon Apr 30 01:50:36 2001
+++ quirks.c	Mon Apr 30 03:01:28 2001
@@ -88,23 +88,36 @@
  *	VIA Apollo KT133 needs PCI latency patch
  *	Made according to a windows driver based patch by George E. Breese
  *	see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
+ *      Also see http://home.tiscalinet.de/au-ja/review-kt133a-1-en.html for
+ *      the info on which Mr Breese based his work.
  */
 static void __init quirk_vialatency(struct pci_dev *dev)
 {
 	u8 r70;
+	u8 rev;
 
-	printk(KERN_INFO "Applying VIA PCI latency patch.\n");
-	/*
-	 *    In register 0x70, mask off bit 2 (PCI Master read caching)
-	 *    and 1 (Delay Transaction)
-	 */
-	pci_read_config_byte(dev, 0x70, &r70);
-	r70 &= 0xf9;
-	pci_write_config_byte(dev, 0x70, r70);
-	/*
-	 *    Turn off PCI Latency timeout (set to 0 clocks)
-	 */
-	pci_write_config_byte(dev, 0x75, 0x80);
+	/* we test for 686B by revision, only apply patch then (cpbotha@ieee.org) */
+	pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);
+        /* 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A; thanks Dan Hollis */
+	if (rev >= 0x40 && rev <= 0x4f)
+	{
+        	printk(KERN_INFO "Applying VIA PCI latency patch (found VT82C686B).\n");
+		/*
+	 	*    In register 0x70, mask off bit 2 (PCI Master read caching)
+	 	*    and 1 (Delay Transaction)
+	 	*/
+		pci_read_config_byte(dev, 0x70, &r70);
+		r70 &= 0xf9;
+		pci_write_config_byte(dev, 0x70, r70);
+		/*
+	 	 *    Turn off PCI Latency timeout (set to 0 clocks)
+	 	 */
+		pci_write_config_byte(dev, 0x75, 0x80);
+	}
+	else
+	{
+		printk(KERN_INFO "Found VT82C686A, not applying VIA latency patch.\n");
+	}
 }
 
 /*
@@ -312,7 +325,7 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_2, 	quirk_natoma },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_vialatency },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_vt82c586_acpi },

--gBBFr7Ir9EOA20Yy--
