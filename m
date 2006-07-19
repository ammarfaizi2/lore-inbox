Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWGSB0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWGSB0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 21:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWGSB0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 21:26:46 -0400
Received: from student.uhasselt.be ([193.190.2.1]:26629 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S932448AbWGSB0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 21:26:46 -0400
Date: Wed, 19 Jul 2006 03:26:43 +0200
To: linux-kernel@vger.kernel.org
Cc: ralf@linux-mips.org
Subject: [PATCH] sb1250-mac: Check for memory allocation failure
Message-ID: <20060719012643.GE30823@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

Broadcom SiByte SOC GB Ethernet driver lacked check for memory
allocation failure. Did not clear the entire allocated block of memory.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
Applies to current GIT or 2.6.18-rc2.

 drivers/net/sb1250-mac.c |   39 +++++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/sb1250-mac.c b/drivers/net/sb1250-mac.c
index 9ab1618..61caf95 100644
--- a/drivers/net/sb1250-mac.c
+++ b/drivers/net/sb1250-mac.c
@@ -276,7 +276,7 @@ struct sbmac_softc {
  *  Prototypes
  ********************************************************************* */
 
-static void sbdma_initctx(sbmacdma_t *d,
+static int sbdma_initctx(sbmacdma_t *d,
 			  struct sbmac_softc *s,
 			  int chan,
 			  int txrx,
@@ -673,7 +673,7 @@ static void sbmac_mii_write(struct sbmac
  *  	   nothing
  ********************************************************************* */
 
-static void sbdma_initctx(sbmacdma_t *d,
+static int sbdma_initctx(sbmacdma_t *d,
 			  struct sbmac_softc *s,
 			  int chan,
 			  int txrx,
@@ -735,8 +735,11 @@ #endif
 
 	d->sbdma_maxdescr = maxdescr;
 
-	d->sbdma_dscrtable = (sbdmadscr_t *)
-		kmalloc((d->sbdma_maxdescr+1)*sizeof(sbdmadscr_t), GFP_KERNEL);
+	d->sbdma_dscrtable = kcalloc(d->sbdma_maxdescr+1, sizeof(sbdmadscr_t), GFP_KERNEL);
+	if (!d->sbdma_dscrtable) {
+		printk(KERN_ERR "unable to allocate memory for ring, aborting\n");
+		return -ENOMEM;
+	}
 
 	/*
 	 * The descriptor table must be aligned to at least 16 bytes or the
@@ -745,8 +748,6 @@ #endif
 	d->sbdma_dscrtable = (sbdmadscr_t *)
 		ALIGN((unsigned long)d->sbdma_dscrtable, sizeof(sbdmadscr_t));
 
-	memset(d->sbdma_dscrtable,0,d->sbdma_maxdescr*sizeof(sbdmadscr_t));
-
 	d->sbdma_dscrtable_end = d->sbdma_dscrtable + d->sbdma_maxdescr;
 
 	d->sbdma_dscrtable_phys = virt_to_phys(d->sbdma_dscrtable);
@@ -755,10 +756,11 @@ #endif
 	 * And context table
 	 */
 
-	d->sbdma_ctxtable = (struct sk_buff **)
-		kmalloc(d->sbdma_maxdescr*sizeof(struct sk_buff *), GFP_KERNEL);
-
-	memset(d->sbdma_ctxtable,0,d->sbdma_maxdescr*sizeof(struct sk_buff *));
+	d->sbdma_ctxtable = kcalloc(d->sbdma_maxdescr, sizeof(struct sk_buff *), GFP_KERNEL);
+	if (!d->sbdma_ctxtable) {
+		printk(KERN_ERR "unable to allocate context table, aborting\n");
+		return -ENOMEM;
+	}
 
 #ifdef CONFIG_SBMAC_COALESCE
 	/*
@@ -777,7 +779,7 @@ #ifdef CONFIG_SBMAC_COALESCE
 		d->sbdma_int_timeout = 0;
 	}
 #endif
-
+	return 0;
 }
 
 /**********************************************************************
@@ -1360,7 +1362,7 @@ static void sbdma_tx_process(struct sbma
  *  	   s - sbmac context structure
  *
  *  Return value:
- *  	   0
+ *  	   status
  ********************************************************************* */
 
 static int sbmac_initctx(struct sbmac_softc *s)
@@ -1392,8 +1394,10 @@ static int sbmac_initctx(struct sbmac_so
 	 * Note: Only do this _once_, as it allocates memory from the kernel!
 	 */
 
-	sbdma_initctx(&(s->sbm_txdma),s,0,DMA_TX,SBMAC_MAX_TXDESCR);
-	sbdma_initctx(&(s->sbm_rxdma),s,0,DMA_RX,SBMAC_MAX_RXDESCR);
+	if (sbdma_initctx(&(s->sbm_txdma),s,0,DMA_TX,SBMAC_MAX_TXDESCR))
+		return -1;
+	if (sbdma_initctx(&(s->sbm_rxdma),s,0,DMA_RX,SBMAC_MAX_RXDESCR))
+		return -1;
 
 	/*
 	 * initial state is OFF
@@ -2335,7 +2339,8 @@ static int sb1250_change_mtu(struct net_
  *  	   dev - net_device structure
  *
  *  Return value:
- *  	   status
+ *  	   0 if OK
+ *        -1 if a problem occurred
  ********************************************************************* */
 
 static int sbmac_init(struct net_device *dev, int idx)
@@ -2384,7 +2389,9 @@ static int sbmac_init(struct net_device 
 	 * allocate the memory for the descriptor tables.
 	 */
 
-	sbmac_initctx(sc);
+	err = sbmac_initctx(sc);
+	if (err)
+		goto out_uninit;
 
 	/*
 	 * Set up Linux device callins
-- 
1.4.1.gd3ba6

