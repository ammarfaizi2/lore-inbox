Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136433AbRD3CCK>; Sun, 29 Apr 2001 22:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136434AbRD3CCB>; Sun, 29 Apr 2001 22:02:01 -0400
Received: from dutidad.twi.tudelft.nl ([130.161.158.199]:19084 "EHLO dutidad")
	by vger.kernel.org with ESMTP id <S136433AbRD3CBz>;
	Sun, 29 Apr 2001 22:01:55 -0400
Date: Mon, 30 Apr 2001 04:01:52 +0200
From: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com, goemon@anime.net
Subject: Re: 2.4.4 Sound corruption [PATCH] NEW, ignore previous patch
Message-ID: <20010430040152.A8052@dutidad.twi.tudelft.nl>
Reply-To: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
In-Reply-To: <20010430021015.A7925@dutidad.twi.tudelft.nl> <Pine.LNX.4.30.0104291722280.19431-100000@anime.net> <20010430030626.A7981@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010430030626.A7981@dutidad.twi.tudelft.nl>; from c.p.botha@its.tudelft.nl on Mon, Apr 30, 2001 at 03:06:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please IGNORE the previous patch, it was faulty (I blame it on the time of
day).  The one attached with this is guaranteed to be perfect(tm).

On Mon, Apr 30, 2001 at 03:06:26AM +0200, Charl P. Botha wrote:
> Attached is a patch to the quirks.c in linux kernel 2.4.4 that fixes the
> sound corruption problem (thanks to Dan Hollis for the info).  Do I have to
> send this anywhere else as well?

-- 
charl p. botha      | computer graphics and cad/cam 
http://cpbotha.net/ | http://www.cg.its.tudelft.nl/

--J/dobhs11T7y2rNN
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

--J/dobhs11T7y2rNN--
