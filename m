Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293553AbSBZJ0w>; Tue, 26 Feb 2002 04:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293550AbSBZJ0n>; Tue, 26 Feb 2002 04:26:43 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:12479 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S293553AbSBZJ0a>; Tue, 26 Feb 2002 04:26:30 -0500
Date: Tue, 26 Feb 2002 03:26:29 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] ServerWorks autodma behavior
Message-ID: <20020226032629.A930@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There wasn't a specific MAINTAINER for this stuff, other than perhaps
Andre Hedrick by proxy, so I decided it might be best to post this
directly.

I have a lot of ServerWorks OSB4 IDE hardware, which has the annoyingly
suboptimal behavior of corrupting filesystems when DMA is active.
Unfortunately, serverworks.c (in recent 2.4, at least) does not honor
the CONFIG_IDEDMA_AUTO config option -- it turns dma on only unless
"ide=nodma" is set on the kernel command line.

Personally, I think the correct behavior is for the subdrivers to honor
this config value.  However, only VIA behaves in this way, and PIIX only
because of its funky CONFIG_PIIX_TUNING config.  This obviates having to
modify lilo.conf (or similar) on all machines, and having to remember
to do so, etc etc.

The alternative is that, somewhat unintuitively, the correct behavior is
for the subdrivers to make their own non-CONFIGurable decisions on DMA.
In this case, VIA and PIIX should be corrected, I would think.

In any case, I've appended the patch I'm using to be able to turn off
auto-DMA at config-time rather than run-time for ServerWorks.  One
alternative is to shed this code altogether, since ide-pci.c seems to
set a rational default.

I just wanted to see if there was any clear consensus on this -- I'd be
glad to whip out patches for either behavior.

Thanks,
-- 
Ken.
brownfld@irridia.com


--- linux/drivers/ide/serverworks.c.orig	Sun Sep  9 10:43:02 2001
+++ linux/drivers/ide/serverworks.c	Tue Feb 26 00:39:17 2002
@@ -590,8 +590,10 @@
 #else /* CONFIG_BLK_DEV_IDEDMA */
 
 	if (hwif->dma_base) {
+#ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			hwif->autodma = 1;
+#endif
 		hwif->dmaproc = &svwks_dmaproc;
 	} else {
 		hwif->autodma = 0;

