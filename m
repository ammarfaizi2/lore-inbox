Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUJBOHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUJBOHA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 10:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUJBOHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 10:07:00 -0400
Received: from baikonur.stro.at ([213.239.196.228]:39657 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266204AbUJBOGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 10:06:52 -0400
Date: Sat, 2 Oct 2004 16:06:59 +0200
From: max attems <janitor@sternwelten.at>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] drivers: remove unused MOD_{DEC,INC}_USE_COUNT
Message-ID: <20041002140659.GG1777@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch send in a patch to remove MOD_{DEC,INC}_USE_COUNT,
let's alsor remove useless references to it (comments, old ifdefs).


Signed-off-by: maximilian attems <janitor@sternwelten.at>
___

btw it's still used in those:
./arch/m32r/drivers/m32r-pldsio.c
./arch/m32r/drivers/m5.c
./arch/m32r/drivers/m5drv.c
./drivers/pcmcia/au1000_generic.c

 isdn/hysdn/hycapi.c               |    3 ---
 isdn/i4l/isdn_bsdcomp.c           |    2 +-
 media/video/bttv-i2c.c            |   15 ---------------
 media/video/saa7134/saa7134-i2c.c |   12 ------------
 net/declance.c                    |    9 ---------
 net/starfire.c                    |   16 ++--------------
 6 files changed, 3 insertions(+), 54 deletions(-)

--- linux-2.6.9-rc3-b/drivers/isdn/i4l/isdn_bsdcomp.c	2004-08-14 12:56:01.000000000 +0200
+++ linux-2.6.9-rc3/drivers/isdn/i4l/isdn_bsdcomp.c	2004-10-02 15:32:00.000000000 +0200
@@ -364,7 +364,7 @@
 		db->lens = (unsigned short *) vmalloc ((maxmaxcode + 1) *
 			sizeof (db->lens[0]));
 		if (!db->lens) {
-			bsd_free (db); /* calls MOD_DEC_USE_COUNT; */
+			bsd_free (db);
 			return (NULL);
 		}
 	}
--- linux-2.6.9-rc3-b/drivers/net/starfire.c	2004-08-14 12:56:25.000000000 +0200
+++ linux-2.6.9-rc3/drivers/net/starfire.c	2004-10-02 15:52:26.000000000 +0200
@@ -312,9 +312,6 @@
 
 #include <linux/if_vlan.h>
 
-#define COMPAT_MOD_INC_USE_COUNT
-#define COMPAT_MOD_DEC_USE_COUNT
-
 #define init_tx_timer(dev, func, timeout) \
 	dev->tx_timeout = func; \
 	dev->watchdog_timeo = timeout;
@@ -1108,14 +1105,9 @@
 	size_t tx_done_q_size, rx_done_q_size, tx_ring_size, rx_ring_size;
 
 	/* Do we ever need to reset the chip??? */
-
-	COMPAT_MOD_INC_USE_COUNT;
-
 	retval = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
-	if (retval) {
-		COMPAT_MOD_DEC_USE_COUNT;
+	if (retval)
 		return retval;
-	}
 
 	/* Disable the Rx and Tx, and reset the chip. */
 	writel(0, ioaddr + GenCtrl);
@@ -1132,10 +1124,8 @@
 		rx_ring_size = sizeof(struct starfire_rx_desc) * RX_RING_SIZE;
 		np->queue_mem_size = tx_done_q_size + rx_done_q_size + tx_ring_size + rx_ring_size;
 		np->queue_mem = pci_alloc_consistent(np->pci_dev, np->queue_mem_size, &np->queue_mem_dma);
-		if (np->queue_mem == 0) {
-			COMPAT_MOD_DEC_USE_COUNT;
+		if (np->queue_mem == 0)
 			return -ENOMEM;
-		}
 
 		np->tx_done_q     = np->queue_mem;
 		np->tx_done_q_dma = np->queue_mem_dma;
@@ -2165,8 +2155,6 @@
 		np->tx_info[i].skb = NULL;
 	}
 
-	COMPAT_MOD_DEC_USE_COUNT;
-
 	return 0;
 }
 
--- linux-2.6.9-rc3-b/drivers/net/declance.c	2004-08-14 12:55:33.000000000 +0200
+++ linux-2.6.9-rc3/drivers/net/declance.c	2004-10-02 15:59:52.000000000 +0200
@@ -812,12 +812,6 @@
 	}
 
 	status = init_restart_lance(lp);
-
-	/*
-	 * if (!status)
-	 *      MOD_INC_USE_COUNT;
-	 */
-
 	return status;
 }
 
@@ -849,9 +843,6 @@
 		free_irq(lp->dma_irq, dev);
 	}
 	free_irq(dev->irq, dev);
-	/*
-	   MOD_DEC_USE_COUNT;
-	 */
 	return 0;
 }
 
--- linux-2.6.9-rc3-b/drivers/media/video/bttv-i2c.c	2004-09-30 22:25:13.000000000 +0200
+++ linux-2.6.9-rc3/drivers/media/video/bttv-i2c.c	2004-10-02 15:22:54.000000000 +0200
@@ -303,21 +303,6 @@
 	.client_unregister = detach_inform,
 };
 
-/* ----------------------------------------------------------------------- */
-/* I2C functions - common stuff                                            */
-
-#ifndef I2C_PEC
-static void bttv_inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void bttv_dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
-#endif
-
 static int attach_inform(struct i2c_client *client)
 {
         struct bttv *btv = i2c_get_adapdata(client->adapter);
--- linux-2.6.9-rc3-b/drivers/media/video/saa7134/saa7134-i2c.c	2004-09-30 22:25:13.000000000 +0200
+++ linux-2.6.9-rc3/drivers/media/video/saa7134/saa7134-i2c.c	2004-10-02 15:20:34.000000000 +0200
@@ -311,18 +311,6 @@
 	return I2C_FUNC_SMBUS_EMUL;
 }
 
-#ifndef I2C_PEC
-static void inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
-#endif
-
 static int attach_inform(struct i2c_client *client)
 {
         struct saa7134_dev *dev = client->adapter->algo_data;
--- linux-2.6.9-rc3-b/drivers/isdn/hysdn/hycapi.c	2004-08-14 12:54:48.000000000 +0200
+++ linux-2.6.9-rc3/drivers/isdn/hysdn/hycapi.c	2004-10-02 16:00:45.000000000 +0200
@@ -246,8 +246,6 @@
 	rp->level3cnt = MaxLogicalConnections;
 	memcpy(&hycapi_applications[appl-1].rp, 
 	       rp, sizeof(capi_register_params));
-	
-/*        MOD_INC_USE_COUNT; */
 }
 
 /*********************************************************************
@@ -311,7 +309,6 @@
 	{
 		hycapi_release_internal(ctrl, appl);
 	}
-/*        MOD_DEC_USE_COUNT;  */
 }
 
 

