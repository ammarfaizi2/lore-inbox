Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267836AbRGUWK5>; Sat, 21 Jul 2001 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267834AbRGUWKr>; Sat, 21 Jul 2001 18:10:47 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:41738 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S267832AbRGUWKl>; Sat, 21 Jul 2001 18:10:41 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200107212211.AAA28049@green.mif.pg.gda.pl>
Subject: Re: about alim15x3 ide driver (fwd)
To: wqb123@yahoo.com
Date: Sun, 22 Jul 2001 00:11:10 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list), andre@linux-ide.org
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>From kufel!ankry  Sun Jul 22 00:09:41 2001
Return-Path: <kufel!ankry>
Received: from kufel.UUCP (uucp@localhost)
	by green.mif.pg.gda.pl (8.9.3/8.9.3) with UUCP id AAA28004
	for green.mif.pg.gda.pl!ankry; Sun, 22 Jul 2001 00:09:41 +0200
Received: (from ankry@localhost)
	by kufel.dom (8.9.3/8.9.3) id AAA14645
	for green!ankry; Sun, 22 Jul 2001 00:09:49 +0200
From: Andrzej Krzysztofowicz <kufel!ankry>
Message-Id: <200107212209.AAA14645@kufel.dom>
Subject: Re: about alim15x3 ide driver
To: kufel!green.mif.pg.gda.pl!ankry
Date: Sun, 22 Jul 2001 00:09:49 +0200 (CEST)
In-Reply-To: <20010721164538.16010.qmail@web13908.mail.yahoo.com> from "Barry Wu" at lip 21, 2001 09:45:38 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

To: wqb123@yahoo.com
Cc: lk, andre@linux-ide.org

> I meet problem about Ali 1535D alim15x3 ide driver.
> Because our hardware bug in mips evaluation board,
> I can not use DMA mode in alim15x3.c, I have to
> use PIO mode. In 2.2.12, I just modify ali15x3_dmaproc
> function, and can support PIO directly.
> I do not know how to support only PIO mode for
> alim15x3 under 2.4.3 kernel.
> If someone knows, please help me. Thanks!

The following patch should be appropriate for your configuration.
Unfortunately, I have not access to ALi hardware at the moment - I cannot
test it.

Andre, is there any reason that all the PCI IDE drivers in 2.4 depend on
CONFIG_BLK_DEV_IDEDMA_PCI instead of CONFIG_BLK_DEV_IDEPCI ?
As you see, pure PIO configuration for PCI IDE is still useful for some
people...

Andrzej

******************************************************************
--- alim15x3.c.old	Thu Jul 19 08:47:28 2001
+++ alim15x3.c	Sat Jul 21 23:52:37 2001
@@ -698,8 +698,10 @@
 
 void __init ide_dmacapable_ali15x3 (ide_hwif_t *hwif, unsigned long dmabase)
 {
+#ifdef CONFIG_BLK_DEV_IDEDMA
 	if ((dmabase) && (m5229_revision < 0x20)) {
 		return;
 	}
 	ide_setup_dma(hwif, dmabase, 8);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 }
--- Config.in.old	Sat Jul 21 23:43:02 2001
+++ Config.in	Sat Jul 21 23:44:13 2001
@@ -50,7 +50,7 @@
 	    dep_bool '      Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
 	    dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool '      AEC62XX Tuning support' CONFIG_AEC62XX_TUNING $CONFIG_BLK_DEV_AEC62XX
-	    dep_bool '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEPCI
 	    dep_mbool '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
 	    dep_bool '    AMD Viper support' CONFIG_BLK_DEV_AMD7409 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool '      AMD Viper ATA-66 Override (WIP)' CONFIG_AMD7409_OVERRIDE $CONFIG_BLK_DEV_AMD7409 $CONFIG_IDEDMA_PCI_WIP


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
