Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUHJIe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUHJIe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUHJIe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:34:26 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:42697 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S262329AbUHJIeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:34:05 -0400
Date: Tue, 10 Aug 2004 10:33:50 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc4 [RESEND] via-rhine: Really call rhine_power_init()
Message-ID: <20040810083350.GA23771@k3.hellgate.ch>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408091958450.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408091958450.1839@ppc970.osdl.org>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my third and last attempt to get this fix merged for 2.6.8.

Without this patch, mainline via-rhine cannot wake the chip if some other
driver puts it to D3. The problem has hit quite a few people already.

This is a fix for the heisenbug with via-rhine refusing to work
sometimes. Patch "[9/9] Restructure reset code" contained a change made
necessary by patch [8/9]. Mainline merged [8/9] for 2.6.8 and is still
missing the fix, while -mm got it with [9/9].

Jesper Juhl provided crucial test data when no one else was able to
reproduce the symptoms.

Roger

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- tmp/drivers/net/via-rhine.c.00_broken	2004-07-29 13:58:17.000000000 +0200
+++ tmp/drivers/net/via-rhine.c	2004-07-30 15:12:36.656007543 +0200
@@ -748,6 +748,8 @@ static int __devinit rhine_init_one(stru
 	}
 #endif /* USE_MMIO */
 	dev->base_addr = ioaddr;
+	rp = netdev_priv(dev);
+	rp->quirks = quirks;
 
 	rhine_power_init(dev);
 
@@ -792,10 +794,8 @@ static int __devinit rhine_init_one(stru
 
 	dev->irq = pdev->irq;
 
-	rp = netdev_priv(dev);
 	spin_lock_init(&rp->lock);
 	rp->pdev = pdev;
-	rp->quirks = quirks;
 	rp->mii_if.dev = dev;
 	rp->mii_if.mdio_read = mdio_read;
 	rp->mii_if.mdio_write = mdio_write;
