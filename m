Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290592AbSBKXGN>; Mon, 11 Feb 2002 18:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290594AbSBKXGE>; Mon, 11 Feb 2002 18:06:04 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:8064
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S290592AbSBKXFm>; Mon, 11 Feb 2002 18:05:42 -0500
Date: Mon, 11 Feb 2002 15:04:57 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200202112304.g1BN4vh01697@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A7M266-D works?
In-Reply-To: <E16aOIs-00081T-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.2.20020211121409.08b9c5f0@mail1.qualcomm.com> <E16aOIs-00081T-00@the-village.bc.nu>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, on the linux-kernel mailing list, you wrote:

> > > The BIOS appears to misconfigure the PCI setup badly, so badly
> > > I've been sticking in PCI quirk fixups to make some drivers work
>
> Check PCI register 0x4C if bits 1 and 2 are clear your board is not
> running in a PCI compliant mode and anything may happen. 

The PCI quirk fixup you posted (reproduced below) uses the test
"(pcic&6)!=6", so do you mean to say "if bit 1 or bit 2 is clear"?

> In paticular since memory and PCI ordering is not preserved you may
> see corruption and failures. Most devices don't have that dependancy
> but a few do - and break horribly.

Might this cause random hard lockups under a compute intensive load?

Since the fixup applies to the AMD762 northbridge, common to the 760MP
and 760MPX chipsets, this discussion applies to all SMP Athlon
motherboards at present, is that right?

Lastly, do you know whether the reason that the A7M266-D comes with a
PCI USB2 card is that the USB support of the AMD768 southbridge is
borked?  Both the Tyan S2466 and the MSI K7D Master come with PCI USB
cards.

Thanks,
Wayne

--- linux.18p8/drivers/pci/quirks.c	Wed Feb  6 06:44:36 2002
+++ linux.18p8-ac1/drivers/pci/quirks.c	Sun Feb 10 19:41:26 2002
@@ -444,13 +444,15 @@
 static void __init quirk_amd_ordering(struct pci_dev *dev)
 {
 	u32 pcic;
-	
-	pci_read_config_dword(dev, 0x42, &pcic);
-	if((pcic&2)==0)
+	pci_read_config_dword(dev, 0x4C, &pcic);
+	if((pcic&6)!=6)
 	{
-		pcic |= 2;
-		printk(KERN_WARNING "BIOS disabled PCI ordering compliance, so we enabled it again.\n");
-		pci_write_config_dword(dev, 0x42, pcic);		
+		pcic |= 6;
+		printk(KERN_WARNING "BIOS failed to enable PCI standards compliance, fixing this error.\n");
+		pci_write_config_dword(dev, 0x4C, pcic);
+		pci_read_config_dword(dev, 0x84, &pcic);
+		pcic |= (1<<23);	/* Required in this mode */
+		pci_write_config_dword(dev, 0x84, pcic);
 	}
 }
 
