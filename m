Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754817AbWKMPEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbWKMPEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbWKMPEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:04:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18562 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1754817AbWKMPEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:04:43 -0500
Date: Mon, 13 Nov 2006 15:22:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Fremlin <not@just.any.name>
Cc: kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com, ak@suse.de
Subject: AHCI power saving (was Re: Ten hours on X60s)
Message-ID: <20061113142219.GA2703@elf.ucw.cz>
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061009215221.GC30702@elf.ucw.cz> <87ods6loe8.fsf-genuine-vii@john.fremlin.org> <20061025070920.GG5851@elf.ucw.cz> <87y7r3xlif.fsf-genuine-vii@john.fremlin.org> <20061026204655.GA1767@elf.ucw.cz> <87slgv6ccz.fsf-genuine-vii@john.fremlin.org> <20061112183614.GA5081@ucw.cz> <87hcx3adcd.fsf-genuine-vii@john.fremlin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hcx3adcd.fsf-genuine-vii@john.fremlin.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There are a couple of bits for turning on the hardware's
> power-saving. It makes me think it might save me about a watt, but the
> effect could be entirely psychological.

No, I did not mean _those_ bits. This made little or difference for
me... (100mW or so, definitely not watt).

doing ahci_pci_device_{suspend,resume} should definitely do the trick,
and ahci_{start,stop}_engine might be enough.

> Here is the patch. It is not correct and ready for general use,
> because you are supposed to check whether the AHCI chipset supports
> the feature.

> So there is no example code for sending the AHCI chipset to S3 and
> bringing it back? I thought you said there was before, but I can't
> find it!

ahci_pci_device_{suspend,resume} seems to be the code...

Here's the port of your patch to recent -git.
								Pavel

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index cef2e70..82a8a44 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -148,6 +148,8 @@ enum {
 				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
+	PORT_CMD_ALPE		= (1 << 27), /* Aggressive Link Power Management Enable */
+	PORT_CMD_ASP		= (1 << 26), /* Aggressive entrance to Slumber or Partial power management states */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
@@ -486,7 +488,7 @@ static void ahci_power_up(void __iomem *
 	}
 
 	/* wake up link */
-	writel(cmd | PORT_CMD_ICC_ACTIVE, port_mmio + PORT_CMD);
+	writel(cmd | PORT_CMD_ICC_ACTIVE | PORT_CMD_ALPE | PORT_CMD_ASP, port_mmio + PORT_CMD);
 }
 
 static void ahci_power_down(void __iomem *port_mmio, u32 cap)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
