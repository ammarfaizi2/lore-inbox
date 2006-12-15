Return-Path: <linux-kernel-owner+w=401wt.eu-S964868AbWLOUzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWLOUzX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWLOUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:55:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43955 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964861AbWLOUzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:55:21 -0500
Date: Fri, 15 Dec 2006 12:55:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smc911x: fix netpoll compilation faliure
Message-Id: <20061215125518.c2bfee56.akpm@osdl.org>
In-Reply-To: <20061215161328.9797232d.vitalywool@gmail.com>
References: <20061215161328.9797232d.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 16:13:28 +0300
Vitaly Wool <vitalywool@gmail.com> wrote:

> Hello folks,
> 
> the trivial patch below fixes the compilation failure for smc911x.c when NET_POLL_CONTROLLER is set.
> 
>  drivers/net/smc911x.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
> 
> diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
> index 2c43433..797ab91 100644
> --- a/drivers/net/smc911x.c
> +++ b/drivers/net/smc911x.c
> @@ -1331,7 +1331,7 @@ smc911x_rx_dma_irq(int dma, void *data)
>  static void smc911x_poll_controller(struct net_device *dev)
>  {
>  	disable_irq(dev->irq);
> -	smc911x_interrupt(dev->irq, dev, NULL);
> +	smc911x_interrupt(dev->irq, dev);
>  	enable_irq(dev->irq);
>  }
>  #endif

That's a 2.6.19 fix, yes?

It looks like this driver needs a 2.6.20 fix also...

From: Andrew Morton <akpm@osdl.org>

Teach this driver about the workqueue changes.

Cc: Vitaly Wool <vitalywool@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/smc911x.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff -puN drivers/net/smc911x.c~smc911-workqueue-fixes drivers/net/smc911x.c
--- a/drivers/net/smc911x.c~smc911-workqueue-fixes
+++ a/drivers/net/smc911x.c
@@ -148,6 +148,8 @@ struct smc911x_local {
 	int tx_throttle;
 	spinlock_t lock;
 
+	struct net_device *netdev;
+
 #ifdef SMC_USE_DMA
 	/* DMA needs the physical address of the chip */
 	u_long physaddr;
@@ -948,10 +950,11 @@ static void smc911x_phy_check_media(stru
  * of autonegotiation.)  If the RPC ANEG bit is cleared, the selection
  * is controlled by the RPC SPEED and RPC DPLX bits.
  */
-static void smc911x_phy_configure(void *data)
+static void smc911x_phy_configure(struct work_struct *work)
 {
-	struct net_device *dev = data;
-	struct smc911x_local *lp = netdev_priv(dev);
+	struct smc911x_local *lp = container_of(work, struct smc911x_local,
+						phy_configure);
+	struct net_device *dev = lp->netdev;
 	unsigned long ioaddr = dev->base_addr;
 	int phyaddr = lp->mii.phy_id;
 	int my_phy_caps; /* My PHY capabilities */
@@ -1495,6 +1498,8 @@ static void smc911x_set_multicast_list(s
 static int
 smc911x_open(struct net_device *dev)
 {
+	struct smc911x_local *lp = netdev_priv(dev);
+
 	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
 
 	/*
@@ -1511,7 +1516,7 @@ smc911x_open(struct net_device *dev)
 	smc911x_reset(dev);
 
 	/* Configure the PHY, initialize the link state */
-	smc911x_phy_configure(dev);
+	smc911x_phy_configure(&lp->phy_configure);
 
 	/* Turn on Tx + Rx */
 	smc911x_enable(dev);
@@ -2060,7 +2065,7 @@ static int __init smc911x_probe(struct n
 	dev->poll_controller = smc911x_poll_controller;
 #endif
 
-	INIT_WORK(&lp->phy_configure, smc911x_phy_configure, dev);
+	INIT_WORK(&lp->phy_configure, smc911x_phy_configure);
 	lp->mii.phy_id_mask = 0x1f;
 	lp->mii.reg_num_mask = 0x1f;
 	lp->mii.force_media = 0;
@@ -2154,6 +2159,7 @@ static int smc911x_drv_probe(struct plat
 {
 	struct net_device *ndev;
 	struct resource *res;
+	struct smc911x_local *lp;
 	unsigned int *addr;
 	int ret;
 
@@ -2183,6 +2189,8 @@ static int smc911x_drv_probe(struct plat
 
 	ndev->dma = (unsigned char)-1;
 	ndev->irq = platform_get_irq(pdev, 0);
+	lp = netdev_priv(ndev);
+	lp->netdev = ndev;
 
 	addr = ioremap(res->start, SMC911X_IO_EXTENT);
 	if (!addr) {
@@ -2204,7 +2212,6 @@ out:
 	}
 #ifdef SMC_USE_DMA
 	else {
-		struct smc911x_local *lp = netdev_priv(ndev);
 		lp->physaddr = res->start;
 		lp->dev = &pdev->dev;
 	}
@@ -2275,7 +2282,7 @@ static int smc911x_drv_resume(struct pla
 			smc911x_reset(ndev);
 			smc911x_enable(ndev);
 			if (lp->phy_type != 0)
-				smc911x_phy_configure(ndev);
+				smc911x_phy_configure(&lp->phy_configure);
 			netif_device_attach(ndev);
 		}
 	}
_

