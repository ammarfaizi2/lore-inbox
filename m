Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVBQRre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVBQRre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVBQRrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:47:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:646 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262317AbVBQRpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:45:51 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Date: Thu, 17 Feb 2005 09:45:30 -0800
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200502151557.06049.jbarnes@sgi.com> <200502170929.54100.jbarnes@sgi.com> <9e47339105021709321dc72ab2@mail.gmail.com>
In-Reply-To: <9e47339105021709321dc72ab2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6gNFCmZBKum+k8O"
Message-Id: <200502170945.30536.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_6gNFCmZBKum+k8O
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, February 17, 2005 9:32 am, Jon Smirl wrote:
> On Thu, 17 Feb 2005 09:29:53 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> > On Thursday, February 17, 2005 8:33 am, Jon Smirl wrote:
> > > > No, pci_map_rom shouldn't test the signature IMHO. While PCI ROMs
> > > > should have the signature to be recognized as containing valid
> > > > firmware images on x86 BIOSes an OF, it's just a convention on these
> > > > platforms, and I would rather let people put whatever they want in
> > > > those ROMs and still let them map it...
> > >
> > > pci_map_rom will return a pointer to any ROM it finds. It the
> > > signature is invalid the size returned will be zero. Is this ok or do
> > > we want it to do something different?
> >
> > Shouldn't it return NULL if the signature is invalid?
>
> But then you couldn't get to your non-standard ROMs

Ok, how does this one look to you guys?  The r128 driver would need similar 
fixes.

Thanks,
Jesse

--Boundary-00=_6gNFCmZBKum+k8O
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="radeonfb-pci-map-rom-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="radeonfb-pci-map-rom-fix.patch"

===== drivers/video/aty/radeon_base.c 1.39 vs edited =====
--- 1.39/drivers/video/aty/radeon_base.c	2005-02-10 22:57:44 -08:00
+++ edited/drivers/video/aty/radeon_base.c	2005-02-17 09:43:13 -08:00
@@ -318,54 +318,20 @@
 	temp |= 0x04 << 24;
 	OUTREG(MPP_TB_CONFIG, temp);
 	temp = INREG(MPP_TB_CONFIG);
-                                                                                                          
+
 	rom = pci_map_rom(dev, &rom_size);
 	if (!rom) {
-		printk(KERN_ERR "radeonfb (%s): ROM failed to map\n",
+		printk(KERN_INFO "radeonfb (%s): ROM failed to map\n",
 		       pci_name(rinfo->pdev));
 		return -ENOMEM;
 	}
-	
-	rinfo->bios_seg = rom;
 
-	/* Very simple test to make sure it appeared */
-	if (BIOS_IN16(0) != 0xaa55) {
-		printk(KERN_ERR "radeonfb (%s): Invalid ROM signature %x should be"
-		       "0xaa55\n", pci_name(rinfo->pdev), BIOS_IN16(0));
+	if (!rom_size) /* we mapped something, but it wasn't valid */
 		goto failed;
-	}
-	/* Look for the PCI data to check the ROM type */
+	
+	rinfo->bios_seg = rom;
 	dptr = BIOS_IN16(0x18);
 
-	/* Check the PCI data signature. If it's wrong, we still assume a normal x86 ROM
-	 * for now, until I've verified this works everywhere. The goal here is more
-	 * to phase out Open Firmware images.
-	 *
-	 * Currently, we only look at the first PCI data, we could iteratre and deal with
-	 * them all, and we should use fb_bios_start relative to start of image and not
-	 * relative start of ROM, but so far, I never found a dual-image ATI card
-	 *
-	 * typedef struct {
-	 * 	u32	signature;	+ 0x00
-	 * 	u16	vendor;		+ 0x04
-	 * 	u16	device;		+ 0x06
-	 * 	u16	reserved_1;	+ 0x08
-	 * 	u16	dlen;		+ 0x0a
-	 * 	u8	drevision;	+ 0x0c
-	 * 	u8	class_hi;	+ 0x0d
-	 * 	u16	class_lo;	+ 0x0e
-	 * 	u16	ilen;		+ 0x10
-	 * 	u16	irevision;	+ 0x12
-	 * 	u8	type;		+ 0x14
-	 * 	u8	indicator;	+ 0x15
-	 * 	u16	reserved_2;	+ 0x16
-	 * } pci_data_t;
-	 */
-	if (BIOS_IN32(dptr) !=  (('R' << 24) | ('I' << 16) | ('C' << 8) | 'P')) {
-		printk(KERN_WARNING "radeonfb (%s): PCI DATA signature in ROM"
-		       "incorrect: %08x\n", pci_name(rinfo->pdev), BIOS_IN32(dptr));
-		goto anyway;
-	}
 	rom_type = BIOS_IN8(dptr + 0x14);
 	switch(rom_type) {
 	case 0:
@@ -381,7 +347,7 @@
 		printk(KERN_INFO "radeonfb: Found unknown type %d ROM Image\n", rom_type);
 		goto failed;
 	}
- anyway:
+	
 	/* Locate the flat panel infos, do some sanity checking !!! */
 	rinfo->fp_bios_start = BIOS_IN16(0x48);
 	return 0;

--Boundary-00=_6gNFCmZBKum+k8O--
