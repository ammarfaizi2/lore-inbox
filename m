Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272778AbSISTeL>; Thu, 19 Sep 2002 15:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272779AbSISTeK>; Thu, 19 Sep 2002 15:34:10 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:33286 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S272778AbSISTeF>;
	Thu, 19 Sep 2002 15:34:05 -0400
To: Robert Schwebel <robert@schwebel.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: MediaGX/Geode performance fix, Was: Which processor/board for embedded NTP
References: <1032354632.23252.14.camel@venus> <87r8frqech.fsf@zoo.weinigel.se>
	<20020919060218.GD10773@pengutronix.de>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 19 Sep 2002 21:39:04 +0200
In-Reply-To: <20020919060218.GD10773@pengutronix.de>
Message-ID: <873cs5vkfb.fsf_-_@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This mail contains a patch to fix a performance problem with many
Cyrix MediaGX/NatSemi Geode platforms.  The register settings have
been officially recommended by NatSemi themselves.  The patch is
against linux-2.4.20-pre7.  Should this be merged into the mainsteam
linux kernel?

Robert Schwebel <robert@schwebel.de> writes:

> Hi Christer, 
> 
> On Wed, Sep 18, 2002 at 09:37:02PM +0200, Christer Weinigel wrote:
> > On the newer "IA on a chip" geodes (SC1200, SC2200 and SC3200) there
> > is also a high speed timer in the chipset that seems to be quite
> > stable.
> 
> Did the realtime behaviour of the newer Geodes also change to the
> better? Last time we tested them with RTAI there have been Buslocks
> which prevented them from being usefull...

Speaking about this, there is a bug in many BIOS:es for the Cyrix
MediaGX and Natsemi Geode that according to the BIOS errata will lower
the performance of master PCI transfers from 70MB/s to 25MB/s.

What happens is that the bit SDBE is set to 1 when it should be set to
0, causing PCI disconnects every 16 bytes which is slow.

    Index 41h PCI Control Function 2 Register (R/W)

    3:2 SDB Slave Disconnect Boundary: PCI slave issues a disconnect with
    data when it crosses line boundary:
        00 = 128 bytes
        01 = 256 bytes
        10 = 512 bytes
        11 = 1024 bytes
    Works in conjunction with bit 1.

    1 SDBE Slave Disconnect Boundary Enable:
        0 = PCI slave disconnects on boundaries set by bits [3:2].
        1 = PCI disconnects on cache line boundary which is 16 bytes.

So, this patch just sets the SDBE bit to 0 and prints a message to
that effect.

  /Christer

diff -ur linux/drivers/pci/quirks.c.orig linux/drivers/pci/quirks.c
--- linux/drivers/pci/quirks.c.orig	Thu Sep 19 21:34:21 2002
+++ linux/drivers/pci/quirks.c	Thu Sep 19 21:35:07 2002
@@ -477,6 +477,24 @@
 }
 
 /*
+ * Common misconfiguration of the MediaGX/Geode PCI master that will
+ * reduce PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1
+ * datasheets found at http://www.national.com/ds/GX for info on what
+ * these bits do.  <christer@weinigel.se>
+ */
+ 
+static void __init quirk_mediagx_master(struct pci_dev *dev)
+{
+	u8 reg;
+	pci_read_config_byte(dev, 0x41, &reg);
+	if (reg & 2) {
+		reg &= ~2;
+		printk(KERN_INFO "PCI: Fixup for MediaGX/Geode Slave Disconnect Boundary (0x41=0x%02x)\n", reg);
+                pci_write_config_byte(dev, 0x41, reg);
+	}
+}
+
+/*
  *  The main table of quirks.
  */
 
@@ -538,6 +556,8 @@
 	 */
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge },
 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master },
+
 	{ 0 }
 };
 
-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
