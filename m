Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUGaSUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUGaSUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 14:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUGaSUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 14:20:17 -0400
Received: from nef.ens.fr ([129.199.96.32]:64774 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S267993AbUGaSUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 14:20:03 -0400
Date: Sat, 31 Jul 2004 20:20:01 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       p_gortmaker@yahoo.com
Subject: Re: swsuspend not working
Message-ID: <20040731182001.GA6760@lps.ens.fr>
References: <20040715121042.GB9873@lps.ens.fr> <20040715121825.GC22260@elf.ucw.cz> <20040715132348.GA9939@lps.ens.fr> <20040719191906.GA7053@lps.ens.fr> <20040720131748.GI27492@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040720131748.GI27492@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Sat, 31 Jul 2004 20:20:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 03:17:48PM +0200, Pavel Machek wrote:
> > ? Destination Host Unreachable ? and nothing more. The interrupt count of
> > the card is increasing, however. Unloading and reloading ne2k_pci fixes
> > that.
> 
> Teach ne2k_pci to do on suspend what it does on unload, and to do on
> resume what it does on load. Should be easy.

« Should be easy » is easily said. Well.

The following patch to drivers/net/ne2k-pci.c in 2.6.8-rc1 happens to make
my pci ethernet card (Realtek Semiconductor Co., Ltd. RTL-8029(AS))
suspend to S4 and resume properly.

I know nothing on suspend/resume architecture, I know nothing on
programming ethernet card, I know nothing on patching device drivers; I
just looked at other drivers, picked function calls that had nice looking
names and put them together in ne2k_pci.c. Miraculously, it works.

Do you think it could get in ?

Éric Brunet

--- ne2k-pci.c.orig	2004-07-20 22:15:30.000000000 +0200
+++ ne2k-pci.c	2004-07-31 19:48:38.000000000 +0200
@@ -653,12 +653,43 @@
 	pci_set_drvdata(pdev, NULL);
 }
 
+#ifdef CONFIG_PM
+static int ne2k_pci_suspend (struct pci_dev *pdev, u32 state)
+{
+	struct net_device *dev = pci_get_drvdata (pdev);
+
+	netif_device_detach(dev);
+	ne2k_pci_close(dev);
+	ne2k_pci_reset_8390(dev);
+	pci_set_power_state (pdev, state);
+
+	return 0;
+}
+static int ne2k_pci_resume (struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata (pdev);
+
+	pci_set_power_state(pdev, 0);
+	ne2k_pci_reset_8390(dev);
+	ne2k_pci_open(dev);
+	netif_device_attach(dev);
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 
 static struct pci_driver ne2k_driver = {
 	.name		= DRV_NAME,
 	.probe		= ne2k_pci_init_one,
 	.remove		= __devexit_p(ne2k_pci_remove_one),
 	.id_table	= ne2k_pci_tbl,
+#ifdef CONFIG_PM
+	.suspend	= ne2k_pci_suspend,
+	.resume		= ne2k_pci_resume,
+#endif /* CONFIG_PM */
+
 };
 
 
