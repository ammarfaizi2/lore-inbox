Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTILUp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbTILUp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:45:56 -0400
Received: from 62-37-19-42.dialup.uni2.es ([62.37.19.42]:8964 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261893AbTILUpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:45:54 -0400
Subject: Re: SII SATA request size limit
From: Eduardo Casino <casino_e@terra.es>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Sep 2003 22:48:04 +0200
Message-Id: <1063399684.1184.7.camel@centinela>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I had a look at the NetBSD pciide.c driver and found this interesting
bit of code:
	
	/*
	 * Rev. <= 0x01 of the 3112 have a bug that can cause data
	 * corruption if DMA transfers cross an 8K boundary.  This is
	 * apparently hard to tickle, but we'll go ahead and play it
	 * safe.
	 */
	if (PCI_REVISION(pa->pa_class) <= 0x01) {
		sc->sc_dma_maxsegsz = 8192;
		sc->sc_dma_boundary = 8192;
	}

This is basically the same as setting hwif->rqsize to 15, but the NetBSD
folks apply the restriction only if the SiI3112 chipset revision is 1 or
lower. As I have a rev. 2 chip, I raised the rqsize to 128 and made some
disk intensive tests: kernel compilation while recursively copying some
huge (~400MB) files. A couple of hours later, my system remained stable
and getting transfers over 55MB/s with my 120GB Seagate. I'm running
2.4.22-ac1.

This silly patch makes the siimage driver to set rqsize to 15 only for
older, supposedly buggy chips, and leaves the default for the rest.

Regards,
Eduardo.


--- siimage.c.orig	2003-09-12 11:52:26.000000000 +0200
+++ siimage.c	2003-09-12 15:42:20.000000000 +0200
@@ -1065,7 +1065,12 @@ static void __init init_iops_siimage (id
 	hwif->hwif_data = 0;
 
 	hwif->rqsize = 128;
-	if (is_sata(hwif))
+	/*
+	 * From the NetBSD driver:
+	 * "Rev. <= 0x01 of the 3112 have a bug that can cause data
+	 *  corruption if DMA transfers cross an 8K boundary."
+	 */
+	if (dev->device == PCI_DEVICE_ID_SII_3112 && class_rev < 0x02)
 		hwif->rqsize = 15;
 
 	if (pci_get_drvdata(dev) == NULL)



