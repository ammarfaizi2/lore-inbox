Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTGGRjg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTGGRjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:39:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:33238 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264082AbTGGRje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:39:34 -0400
Message-ID: <3F09B3BF.8010108@gmx.at>
Date: Mon, 07 Jul 2003 19:54:07 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: highpoint driver problem, 2.4.21-ac4
References: <4V9E.47E.39@gated-at.bofh.it>	<4V9E.47E.37@gated-at.bofh.it>	<4WyE.5oC.19@gated-at.bofh.it>	<3F04823A.5030403@gmx.at>	<20030703184427.3cb71051.wilreichert@yahoo.com>	<3F074C25.5060004@gmx.at> <20030706132507.240683d1.wilreichert@yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------070803060007020704080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070803060007020704080702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wil Reichert wrote:
 >> could you try the attachted patch, and report if this changes
 >> something?
 >
 >
 > Applied patch & rebuilt with hpt366 as a module.  No more oops, dmesg
 > prints the following:
 >
 > HPT372A: IDE controller at PCI slot 01:0b.0 HPT372A: chipset revision
 > 2 HPT372A: not 100% native mode: will probe irqs later hpt: HPT372N
 > detected, using 372N timing. FREQ: 126 PLL: 45 hpt: no known IDE
 > timings, disabling DMA. hpt: no known IDE timings, disabling DMA.
 >
 > It has 2 drives attached to it, neither seems to be found.
 >
 > Other things: the 2.5.xx seems to work ok and my board supports some
 > 'RAID 1.5' which seems to be nothing more than PR crap and some
 > firmware hacks.  Could that cause problems?
 >
 > Wil

ide_get_or_set_dma_base() is may be called via ide_setup_pci_device() 
when an ide controller module is loaded. however, 
ide_get_or_set_dma_base() is defined with __init and the function is 
called when its memory is already deallocated.

greetings,
Wilfried

--------------070803060007020704080702
Content-Type: text/plain;
 name="linux-2.4.21-ac4-idedmafix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.21-ac4-idedmafix.patch"

--- linux/drivers/ide/setup-pci.c.orig	2003-07-06 00:04:06.000000000 +0200
+++ linux/drivers/ide/setup-pci.c	2003-07-06 00:04:12.000000000 +0200
@@ -172,7 +172,7 @@ static int ide_setup_pci_baseregs (struc
  *	is already in DMA mode we check and enforce IDE simplex rules.
  */
 
-static unsigned long __init ide_get_or_set_dma_base (ide_hwif_t *hwif)
+static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
 {
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;

--------------070803060007020704080702--

