Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbTLFNJz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 08:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265159AbTLFNJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 08:09:55 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:61105 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265158AbTLFNJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 08:09:52 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Subject: [PATCH] Re: Catching NForce2 lockup with NMI watchdog - found
Date: Sat, 6 Dec 2003 14:11:37 +0100
User-Agent: KMail/1.5.4
Cc: cheuche+lkml@free.fr, linux-kernel@vger.kernel.org
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com> <20031206081848.GA4023@localnet> <3FD1CA81.9010708@gmx.de>
In-Reply-To: <3FD1CA81.9010708@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312061411.37795.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is possible :-).  Here is a completly untested patch.

[PATCH] fix lockups with APIC support on nForce2

Add PCI quirk to disable Halt Disconnect and Stop Grant Disconnect
(based on athcool program by Osamu Kayasono).

 arch/i386/pci/fixup.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

diff -puN arch/i386/pci/fixup.c~nforce2_disconnect_quirk arch/i386/pci/fixup.c
--- linux-2.6.0-test11/arch/i386/pci/fixup.c~nforce2_disconnect_quirk	2003-12-06 13:36:56.147911576 +0100
+++ linux-2.6.0-test11-root/arch/i386/pci/fixup.c	2003-12-06 14:03:41.655837272 +0100
@@ -187,6 +187,18 @@ static void __devinit pci_fixup_transpar
 		dev->transparent = 1;
 }
 
+/*
+ * Halt Disconnect and Stop Grant Disconnect (bit 4 at offset 0x6F)
+ * must be disabled when APIC is used (or lockups will happen).
+ */
+static void __devinit pci_fixup_nforce2_disconnect(struct pci_dev *d)
+{
+	u8 t;
+
+	pci_read_config_byte(d, 0x6F, &t);
+	pci_write_config_byte(d, 0x6F, (t & 0xef));
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci_fixup_i450gx },
@@ -205,5 +217,6 @@ struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2,	pci_fixup_nforce2_disconnect },
 	{ 0 }
 };

_

On Saturday 06 of December 2003 13:24, Prakash K. Cheemplavam wrote:
> cheuche+lkml@free.fr wrote:
> > On Sat, Dec 06, 2003 at 12:49:50AM +0100, Prakash K. Cheemplavam wrote:
> >>So gals and guys, try disabling cpu disconnect in bios and see whether
> >>aopic now runs stable.
> >
> > Yes that fix it. Well time will tell but I cannot make it crash with
> > hdparm -tT or cat /dev/hda so far. I'm dumping hda to /dev/null right
> > now.
> >
> > After testing to make it crash, I used athcool to reenable CPU
> > disconnect, and guess what, test after that just crashed the box.
> > You found the problem, congratulations.
> >
> :-)
>
> Isn't it possible to ad athcool's code into the kernel, maybe into the
> pm section or even make it an kernel option. It seems to be a nice
> workaround for the time-being.
>
> Prakash

