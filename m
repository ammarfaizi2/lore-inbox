Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTENRRO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTENRRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:17:13 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:16480 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262524AbTENRRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:17:09 -0400
Date: Wed, 14 May 2003 10:31:15 -0700
From: Andrew Morton <akpm@digeo.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       fventuri@mediaone.net
Subject: Re: 2.5.69-mm5: sb1000.c: undefined reference to `alloc_netdev'
Message-Id: <20030514103115.465d18a8.akpm@digeo.com>
In-Reply-To: <20030514144727.GG1346@fs.tum.de>
References: <20030514012947.46b011ff.akpm@digeo.com>
	<20030514144727.GG1346@fs.tum.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 17:29:52.0123 (UTC) FILETIME=[6D572CB0:01C31A3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> drivers/built-in.o(.text+0x22e7b5): In function `sb1000_probe_one':
>  : undefined reference to `alloc_netdev'
>  ...

This should fix.  I'm not sure why it's overriding dev->flags.


 drivers/net/sb1000.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff -puN drivers/net/sb1000.c~sb1000-fix drivers/net/sb1000.c
--- 25/drivers/net/sb1000.c~sb1000-fix	2003-05-14 10:24:35.000000000 -0700
+++ 25-akpm/drivers/net/sb1000.c	2003-05-14 10:30:36.000000000 -0700
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
@@ -188,11 +177,16 @@ sb1000_probe_one(struct pnp_dev *pdev, c
 			"S/N %#8.8x, IRQ %d.\n", dev->name, dev->base_addr,
 			dev->mem_start, serial_number, dev->irq);
 
-	dev = alloc_netdev(sizeof(struct sb1000_private), "cm%d", sb1000_setup);
+	dev = alloc_etherdev(sizeof(struct sb1000_private));
 	if (!dev) {
 		error = -ENOMEM;
 		goto out_release_regions;
 	}
+
+	/* New-style flags. */
+	/* This seems bogus */
+	dev->flags = IFF_POINTOPOINT|IFF_NOARP;
+
 	SET_MODULE_OWNER(dev);
 
 	if (sb1000_debug > 0)

_

