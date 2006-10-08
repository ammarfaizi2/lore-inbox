Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWJHQTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWJHQTK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 12:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWJHQTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 12:19:09 -0400
Received: from mail-ale01.alestra.net.mx ([207.248.224.149]:39882 "EHLO
	mail-ale01.alestra.net.mx") by vger.kernel.org with ESMTP
	id S1751250AbWJHQTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 12:19:08 -0400
Message-ID: <452924D3.9070907@att.net.mx>
Date: Sun, 08 Oct 2006 11:18:27 -0500
From: Hugo Vanwoerkom <rociobarroso@att.net.mx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: ocilent1@gmail.com
CC: Chris Wedgwood <cw@f00f.org>, Lee Revell <rlrevell@joe-job.com>,
       Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, dsd@gentoo.org
Subject: Re: sound skips on 2.6.18-ck1
References: <200606181204.29626.ocilent1@gmail.com> <20060719063344.GA1677@tuatara.stupidest.org> <44BE37E8.2040706@att.net.mx> <45281E90.2080502@att.net.mx>
In-Reply-To: <45281E90.2080502@att.net.mx>
Content-Type: multipart/mixed;
 boundary="------------050505020406080108020002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050505020406080108020002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hugo Vanwoerkom wrote:
> Hi,
>
>
> I see that on 2.6.18-ck1 still some sort of quirks patch is needed for 
> VIA chips.
>
> I get plenty:
>
> ALSA: underrun, at least 0ms.
>
> and with 2.6.17-ck1 with the quirks.c.patch I did not. But the patch 
> does not fit on 2.6.18 :-(
>
> Strangely enough this time around I do *not* get underruns on vt's 
> with mpg321 and I *do* get them on X. Last time around it was the 
> reverse.
>
> Is there a fix for 2.6.18 ?
>
> Thanks!
>
> Hugo
>

I know nothing about quirks.c but I adapted the patch that worked (TM) 
under 2.6.17 to 2.6.18 and it solves the situation for me.
I attach the reworked patch and my lspci.

Regards

Hugo








--------------050505020406080108020002
Content-Type: text/plain;
 name="quirks.c.2.6.18.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="quirks.c.2.6.18.patch"

diff -Naur linux-2.6.17.orig/drivers/pci/quirks.c linux-2.6.17/drivers/pci/quirks.c
--- linux-2.6.17.orig/drivers/pci/quirks.c	2006-10-08 07:52:25.000000000 -0500
+++ linux-2.6.17/drivers/pci/quirks.c	2006-10-08 07:45:06.000000000 -0500
@@ -650,10 +650,37 @@
  * Some of the on-chip devices are actually '586 devices' so they are
  * listed here.
  */
+
+static int via_irq_fixup_needed = -1;
+
+/*
+ * As some VIA hardware is available in PCI-card form, we need to restrict
+ * this quirk to VIA PCI hardware built onto VIA-based motherboards only.
+ * We try to locate a VIA southbridge before deciding whether the quirk
+ * should be applied.
+ */
+static const struct pci_device_id via_irq_fixup_tbl[] = {
+	{
+		.vendor 	= PCI_VENDOR_ID_VIA,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.class		= PCI_CLASS_BRIDGE_ISA << 8,
+		.class_mask	= 0xffff00,
+	},
+	{ 0, },
+};
+
 static void quirk_via_irq(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
 
+	if (via_irq_fixup_needed == -1)
+		via_irq_fixup_needed = pci_dev_present(via_irq_fixup_tbl);
+
+	if (!via_irq_fixup_needed)
+		return;
+
 	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
@@ -663,14 +690,7 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235_USB_2, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes

--------------050505020406080108020002
Content-Type: text/plain;
 name="11.lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="11.lspci"

00:00.0 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:0a.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a2)
00:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
00:0c.0 Multimedia audio controller: Creative Labs SB Audigy LS
00:0f.0 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 4000 AGP 8x] (rev c1)

--------------050505020406080108020002--
