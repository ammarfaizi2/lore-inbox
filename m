Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSIDX0o>; Wed, 4 Sep 2002 19:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSIDX0o>; Wed, 4 Sep 2002 19:26:44 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:9173 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316309AbSIDX0k>;
	Wed, 4 Sep 2002 19:26:40 -0400
Date: Wed, 4 Sep 2002 16:31:15 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : Netwave update
Message-ID: <20020904233115.GE21592@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi Jeff,

        Could you please push the following patch upstream ?
	This add spinlock protection to the Netwave driver and gets
rid of save_flags();cli();. I was pleasantly surprised that the driver
was working fine on my SMP system with those obvious fixes. Tested on
2.5.32 SMP.

        Have fun...

        Jean

----------------------------------------------------------

diff -u -p linux/drivers/net/wireless/netwave_cs.25.c linux/drivers/net/wireless/netwave_cs.c
--- linux/drivers/net/wireless/netwave_cs.25.c	Tue Sep  3 14:51:59 2002
+++ linux/drivers/net/wireless/netwave_cs.c	Tue Sep  3 15:12:29 2002
@@ -324,6 +324,7 @@ struct site_survey {
 typedef struct netwave_private {
     dev_link_t link;
     struct net_device      dev;
+    spinlock_t	spinlock;	/* Serialize access to the hardware (SMP) */
     dev_node_t node;
     u_char     *ramBase;
     int        timeoutCounter;
@@ -415,8 +416,7 @@ static struct iw_statistics *netwave_get
 	
     wstats = &priv->iw_stats;
 
-    save_flags(flags);
-    cli();
+    spin_lock_irqsave(&priv->spinlock, flags);
 	
     netwave_snapshot( priv, ramBase, iobase);
 
@@ -428,7 +428,7 @@ static struct iw_statistics *netwave_get
     wstats->discard.code = 0L;
     wstats->discard.misc = 0L;
 
-    restore_flags(flags);
+    spin_unlock_irqrestore(&priv->spinlock, flags);
     
     return &priv->iw_stats;
 }
@@ -491,6 +491,10 @@ static dev_link_t *netwave_attach(void)
     link->conf.ConfigIndex = 1;
     link->conf.Present = PRESENT_OPTION;
 
+    /* Netwave private struct init. link/dev/node already taken care of,
+     * other stuff zero'd - Jean II */
+    spin_lock_init(&priv->spinlock);
+
     /* Netwave specific entries in the device structure */
     dev->hard_start_xmit = &netwave_start_xmit;
     dev->set_config = &netwave_config;
@@ -640,8 +644,7 @@ static int netwave_set_nwid(struct net_d
 	u_char *ramBase = priv->ramBase;
 
 	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&priv->spinlock, flags);
 
 #if WIRELESS_EXT > 8
 	if(!wrqu->nwid.disabled) {
@@ -660,7 +663,7 @@ static int netwave_set_nwid(struct net_d
 	}
 
 	/* ReEnable interrupts & restore flags */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&priv->spinlock, flags);
     
 	return 0;
 }
@@ -699,8 +702,7 @@ static int netwave_set_scramble(struct n
 	u_char *ramBase = priv->ramBase;
 
 	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&priv->spinlock, flags);
 
 	scramble_key = (key[0] << 8) | key[1];
 	wait_WOC(iobase);
@@ -710,7 +712,7 @@ static int netwave_set_scramble(struct n
 	writeb(NETWAVE_CMD_EOC, ramBase + NETWAVE_EREG_CB + 3);
 
 	/* ReEnable interrupts & restore flags */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&priv->spinlock, flags);
     
 	return 0;
 }
@@ -816,8 +818,7 @@ static int netwave_get_snap(struct net_d
 	u_char *ramBase = priv->ramBase;
 
 	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&priv->spinlock, flags);
 
 	/* Take snapshot of environment */
 	netwave_snapshot( priv, ramBase, iobase);
@@ -827,7 +828,7 @@ static int netwave_get_snap(struct net_d
 	priv->lastExec = jiffies;
 
 	/* ReEnable interrupts & restore flags */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&priv->spinlock, flags);
     
 	return(0);
 }
@@ -1376,8 +1377,7 @@ static int netwave_hw_xmit(unsigned char
     ioaddr_t iobase = dev->base_addr;
 
     /* Disable interrupts & save flags */
-    save_flags(flags);
-    cli();
+    spin_lock_irqsave(&priv->spinlock, flags);
 
     /* Check if there are transmit buffers available */
     wait_WOC(iobase);
@@ -1385,7 +1385,7 @@ static int netwave_hw_xmit(unsigned char
 	/* No buffers available */
 	printk(KERN_DEBUG "netwave_hw_xmit: %s - no xmit buffers available.\n",
 	       dev->name);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&priv->spinlock, flags);
 	return 1;
     }
 
@@ -1426,7 +1426,7 @@ static int netwave_hw_xmit(unsigned char
     writeb((len>>8) & 0xff, ramBase + NETWAVE_EREG_CB + 2);
     writeb(NETWAVE_CMD_EOC, ramBase + NETWAVE_EREG_CB + 3);
 
-    restore_flags( flags);
+    spin_unlock_irqrestore(&priv->spinlock, flags);
     return 0;
 }
 
@@ -1618,16 +1618,15 @@ static struct net_device_stats *netwave_
 }
 
 static void update_stats(struct net_device *dev) {
-    unsigned long flags;
+    //unsigned long flags;
+/*     netwave_private *priv = (netwave_private*) dev->priv; */
 
-    save_flags(flags);
-    cli();
+    //spin_lock_irqsave(&priv->spinlock, flags);
 
-/*     netwave_private *priv = (netwave_private*) dev->priv;
-    priv->stats.rx_packets = readb(priv->ramBase + 0x18e); 
+/*    priv->stats.rx_packets = readb(priv->ramBase + 0x18e); 
     priv->stats.tx_packets = readb(priv->ramBase + 0x18f); */
 
-    restore_flags(flags);
+    //spin_unlock_irqrestore(&priv->spinlock, flags);
 }
 
 static int netwave_rx(struct net_device *dev) {
