Return-Path: <linux-kernel-owner+w=401wt.eu-S1751108AbXAFCek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbXAFCek (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbXAFCeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:34:24 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53921 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbXAFCeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:34:09 -0500
Message-Id: <20070106023627.569107000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:36 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Georg Chini <georg.chini@triaton-webhosting.com>
Subject: [patch 43/50] SOUND: Sparc CS4231: Fix IRQ return value and initialization.
Content-Disposition: inline; filename=sound-sparc-cs4231-fix-irq-return-value-and-initialization.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Georg Chini <georg.chini@triaton-webhosting.com>

fix some initialisation problems.

Change period_bytes_min from 4096 to 256 to allow driver to work with
low latency (VOIP) applications. Hope this does not break EBUS.

Signed-off-by: Georg Chini <georg.chini@triaton-webhosting.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit d35a1b9e10481c9f1d3b87e778a0f1f6a0a2dd48

 sound/sparc/cs4231.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- linux-2.6.19.1.orig/sound/sparc/cs4231.c
+++ linux-2.6.19.1/sound/sparc/cs4231.c
@@ -1268,7 +1268,7 @@ static struct snd_pcm_hardware snd_cs423
 	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= (32*1024),
-	.period_bytes_min	= 4096,
+	.period_bytes_min	= 256,
 	.period_bytes_max	= (32*1024),
 	.periods_min		= 1,
 	.periods_max		= 1024,
@@ -1288,7 +1288,7 @@ static struct snd_pcm_hardware snd_cs423
 	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= (32*1024),
-	.period_bytes_min	= 4096,
+	.period_bytes_min	= 256,
 	.period_bytes_max	= (32*1024),
 	.periods_min		= 1,
 	.periods_max		= 1024,
@@ -1796,7 +1796,7 @@ static irqreturn_t snd_cs4231_sbus_inter
 	snd_cs4231_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
 	spin_unlock_irqrestore(&chip->lock, flags);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 /*
@@ -1821,7 +1821,6 @@ static int sbus_dma_request(struct cs423
 	if (!(csr & test))
 		goto out;
 	err = -EBUSY;
-	csr = sbus_readl(base->regs + APCCSR);
 	test = APC_XINT_CNVA;
 	if ( base->dir == APC_PLAY )
 		test = APC_XINT_PNVA;
@@ -1862,17 +1861,16 @@ static void sbus_dma_enable(struct cs423
 
 	spin_lock_irqsave(&base->lock, flags);
 	if (!on) {
-		if (base->dir == APC_PLAY) { 
-			sbus_writel(0, base->regs + base->dir + APCNVA); 
-			sbus_writel(1, base->regs + base->dir + APCC); 
-		}
-		else
-		{
-			sbus_writel(0, base->regs + base->dir + APCNC); 
-			sbus_writel(0, base->regs + base->dir + APCVA); 
-		} 
+		sbus_writel(0, base->regs + base->dir + APCNC);
+		sbus_writel(0, base->regs + base->dir + APCNVA);
+		sbus_writel(0, base->regs + base->dir + APCC);
+		sbus_writel(0, base->regs + base->dir + APCVA);
+
+		/* ACK any APC interrupts. */
+		csr = sbus_readl(base->regs + APCCSR);
+		sbus_writel(csr, base->regs + APCCSR);
 	} 
-	udelay(600); 
+	udelay(1000);
 	csr = sbus_readl(base->regs + APCCSR);
 	shift = 0;
 	if ( base->dir == APC_PLAY )

--
