Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbTENTc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbTENTc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:32:56 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:14210 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261192AbTENTcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:32:52 -0400
Date: Wed, 14 May 2003 12:41:06 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bunk@fs.tum.de, hch@infradead.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, fventuri@mediaone.net
Subject: Re: 2.5.69-mm5: sb1000.c: undefined reference to `alloc_netdev'
Message-Id: <20030514124106.5a13c199.akpm@digeo.com>
In-Reply-To: <1052936763.2492.57.camel@dhcp22.swansea.linux.org.uk>
References: <20030514012947.46b011ff.akpm@digeo.com>
	<20030514144727.GG1346@fs.tum.de>
	<20030514103115.465d18a8.akpm@digeo.com>
	<1052936763.2492.57.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 19:45:35.0253 (UTC) FILETIME=[63063450:01C31A51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> Its far from bogus. Its an rx only cable modem device. Your uplink is
> modem and you dont want to arp on it


diff -puN drivers/net/sb1000.c~sb1000-fix drivers/net/sb1000.c
--- 25/drivers/net/sb1000.c~sb1000-fix	Wed May 14 12:39:10 2003
+++ 25-akpm/drivers/net/sb1000.c	Wed May 14 12:40:20 2003
@@ -137,17 +137,6 @@ static const struct pnp_device_id sb1000
 };
 MODULE_DEVICE_TABLE(pnp, sb1000_pnp_ids);
 
-static void
-sb1000_setup(struct net_device *dev)
-{
-	dev->type		= ARPHRD_ETHER;
-	dev->mtu		= 1500;
-	dev->addr_len		= ETH_ALEN;
-
-	/* New-style flags. */
-	dev->flags		= IFF_POINTOPOINT|IFF_NOARP;
-}
-
 static int
 sb1000_probe_one(struct pnp_dev *pdev, const struct pnp_device_id *id)
 {
@@ -188,11 +177,18 @@ sb1000_probe_one(struct pnp_dev *pdev, c
 			"S/N %#8.8x, IRQ %d.\n", dev->name, dev->base_addr,
 			dev->mem_start, serial_number, dev->irq);
 
-	dev = alloc_netdev(sizeof(struct sb1000_private), "cm%d", sb1000_setup);
+	dev = alloc_etherdev(sizeof(struct sb1000_private));
 	if (!dev) {
 		error = -ENOMEM;
 		goto out_release_regions;
 	}
+
+	/*
+	 * The SB1000 is an rx-only cable modem device.  The uplink is a modem
+	 * and we do not want to arp on it.
+	 */
+	dev->flags = IFF_POINTOPOINT|IFF_NOARP;
+
 	SET_MODULE_OWNER(dev);
 
 	if (sb1000_debug > 0)

_

