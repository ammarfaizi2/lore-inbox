Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWEMEco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWEMEco (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 00:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWEMEco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 00:32:44 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:9320 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932081AbWEMEcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 00:32:43 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Date: Fri, 12 May 2006 21:32:39 -0700
User-Agent: KMail/1.7.1
Cc: "Nathan Becker" <nathanbecker@gmail.com>, linux-kernel@vger.kernel.org
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com> <200605061232.52303.david-b@pacbell.net> <2151339d0605092237m4ef4e835k16b8c779f6ad7046@mail.gmail.com>
In-Reply-To: <2151339d0605092237m4ef4e835k16b8c779f6ad7046@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pFWZE9qdpAH0VGN"
Message-Id: <200605122132.41410.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_pFWZE9qdpAH0VGN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 09 May 2006 10:37 pm, Nathan Becker wrote:
> I added 1 line to drivers/usb/host/ehci-pci.c which sets the DMA mask,
> and now it seems to work with ehci loaded and with 4 GB of RAM.
> Unfortunately, I don't really understand what I did.  Perhaps you have
> a better idea what this is doing and if it is correct.

Interesting.  My guess is that the IOMMU is helping you out, and the
issue is that the silicon erratum applies to the I/O buffers too, not
just to a subset of the schedule data structures.

Can you confirm that this patch also resolves your issue?  Reboot
from scratch a few times (power off, warm reboot, etc) to be
reasonably sure you're seeing the cases that failed before.


--Boundary-00=_pFWZE9qdpAH0VGN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ehci-nf4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ehci-nf4.patch"

Modify workaround for the EHCI quirk in newer NVidia controllers by
assigning the DMA mask, not just the consistent DMA mask.  It seems
to matter, as if the silicon erratum isn't quite what was described
in the original bug workaround (or there's another erratum).


Index: g26/drivers/usb/host/ehci-pci.c
===================================================================
--- g26.orig/drivers/usb/host/ehci-pci.c	2006-05-12 19:40:22.000000000 -0700
+++ g26/drivers/usb/host/ehci-pci.c	2006-05-12 21:15:31.000000000 -0700
@@ -118,7 +118,15 @@ static int ehci_pci_setup(struct usb_hcd
 			if (pci_set_consistent_dma_mask(pdev,
 						DMA_31BIT_MASK) < 0)
 				ehci_warn(ehci, "can't enable NVidia "
-					"workaround for >2GB RAM\n");
+					"workaround %d for >2GB RAM\n", 1);
+
+			/* some users report problems with 4GB when the IOMMU
+			 * doesn't force lowmem addresses... looks like the
+			 * initial report from NVidia wasn't quite right.
+			 */
+			if (pci_set_dma_mask(pdev, DMA_31BIT_MASK) < 0)
+				ehci_warn(ehci, "can't enable NVidia "
+					"workaround %d for >2GB RAM\n", 2);
 			break;
 		/* Some NForce2 chips have problems with selective suspend;
 		 * fixed in newer silicon.

--Boundary-00=_pFWZE9qdpAH0VGN--
