Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRD3SHR>; Mon, 30 Apr 2001 14:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRD3SHJ>; Mon, 30 Apr 2001 14:07:09 -0400
Received: from dutidad.twi.tudelft.nl ([130.161.158.199]:23692 "EHLO dutidad")
	by vger.kernel.org with ESMTP id <S130487AbRD3SG6>;
	Mon, 30 Apr 2001 14:06:58 -0400
Date: Mon, 30 Apr 2001 20:06:56 +0200
From: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com, goemon@anime.net
Subject: Re: 2.4.4 Sound corruption [PATCH]
Message-ID: <20010430200656.A8835@dutidad.twi.tudelft.nl>
Reply-To: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
In-Reply-To: <20010430030626.A7981@dutidad.twi.tudelft.nl> <E14uH0V-0008Hk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14uH0V-0008Hk-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 30, 2001 at 05:58:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2001 at 05:58:40PM +0100, Alan Cox wrote:
> > Attached is a patch to the quirks.c in linux kernel 2.4.4 that fixes the
> > sound corruption problem (thanks to Dan Hollis for the info).  Do I have to
> > send this anywhere else as well?
> 
> It seems very broken
> 
> > -	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency },
> > +	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_vialatency },
> 
> You are hacking the wrong chip..

That's the first version I sent which was admittedly broken.  About 20
minutes later I sent the fixed version (mail with subject: "Re: 2.4.4 Sound
corruption [PATCH] NEW, ignore previous patch").  In case you can't find
this, I've re-attached the patch.

Regards,
Charl

-- 
charl p. botha      | computer graphics and cad/cam 
http://cpbotha.net/ | http://www.cg.its.tudelft.nl/

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via686a_sound_corruption_patch.diff"

--- quirks.c-2.4.4	Mon Apr 30 01:50:36 2001
+++ quirks.c	Mon Apr 30 03:54:08 2001
@@ -88,23 +88,44 @@
  *	VIA Apollo KT133 needs PCI latency patch
  *	Made according to a windows driver based patch by George E. Breese
  *	see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
+ *      Also see http://home.tiscalinet.de/au-ja/review-kt133a-1-en.html for
+ *      the info on which Mr Breese based his work.
  */
 static void __init quirk_vialatency(struct pci_dev *dev)
 {
 	u8 r70;
-
-	printk(KERN_INFO "Applying VIA PCI latency patch.\n");
-	/*
-	 *    In register 0x70, mask off bit 2 (PCI Master read caching)
-	 *    and 1 (Delay Transaction)
+	u8 rev;
+	struct pci_dev *vt82c686;
+   
+   
+	/* we want to look for a VT82C686 south bridge, and then apply the via latency
+	 * patch if we find that it's a 686B (by revision) <cpbotha@ieee.org>
 	 */
-	pci_read_config_byte(dev, 0x70, &r70);
-	r70 &= 0xf9;
-	pci_write_config_byte(dev, 0x70, r70);
-	/*
-	 *    Turn off PCI Latency timeout (set to 0 clocks)
-	 */
-	pci_write_config_byte(dev, 0x75, 0x80);
+	vt82c686 = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, NULL);
+	if (vt82c686)   
+     	{
+		pci_read_config_byte(vt82c686, PCI_CLASS_REVISION, &rev);
+        	/* 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A; thanks Dan Hollis */
+		if (rev >= 0x40 && rev <= 0x4f)
+		{
+        		printk(KERN_INFO "Applying VIA PCI latency patch (found VT82C686B).\n");
+			/*
+	 		 *    In register 0x70, mask off bit 2 (PCI Master read caching)
+	 		 *    and 1 (Delay Transaction)
+	 		 */
+			pci_read_config_byte(dev, 0x70, &r70);
+			r70 &= 0xf9;
+			pci_write_config_byte(dev, 0x70, r70);
+			/*
+	 	 	 *    Turn off PCI Latency timeout (set to 0 clocks)
+	 	 	 */
+			pci_write_config_byte(dev, 0x75, 0x80);
+		}
+		else
+		{
+			printk(KERN_INFO "Found VT82C686A, not applying VIA latency patch.\n");
+		}
+	} /* if (vt82c686) ... */
 }
 
 /*

--WIyZ46R2i8wDzkSu--
