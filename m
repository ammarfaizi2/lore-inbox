Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbSIXAPE>; Mon, 23 Sep 2002 20:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSIXAPE>; Mon, 23 Sep 2002 20:15:04 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:39901 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261488AbSIXAPD>;
	Mon, 23 Sep 2002 20:15:03 -0400
Date: Mon, 23 Sep 2002 17:20:15 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.38] : Minor Wavelan fixes...
Message-ID: <20020924002014.GA13200@bougret.hpl.hp.com>
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

	Minor Wavelan fixes :
	o use 'time_after' (contributed by Tim Schmielau)
	o fix compile warning in my previous patch (Rene Scharfe)
	o use 'inline' to try to minimise ethtool bloat (me)

	Have fun...

	Jean

----------------------------------------------------------

diff -u -p linux/drivers/net/wireless/wavelan_cs.b2.c  linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless/wavelan_cs.b2.c	Mon Sep 23 17:07:40 2002
+++ linux/drivers/net/wireless/wavelan_cs.c	Mon Sep 23 17:12:54 2002
@@ -676,7 +676,7 @@ void wl_cell_expiry(unsigned long data)
   
   while(wavepoint!=NULL)
     {
-      if(wavepoint->last_seen < jiffies-CELL_TIMEOUT)
+      if(time_after(jiffies, wavepoint->last_seen + CELL_TIMEOUT))
 	{
 #ifdef WAVELAN_ROAMING_DEBUG
 	  printk(KERN_DEBUG "WaveLAN: Bye bye %.4X\n",wavepoint->nwid);
@@ -1859,7 +1859,8 @@ wl_his_gather(device *	dev,
 }
 #endif	/* HISTOGRAM */
 
-static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
+static inline int
+wl_netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
 {
 	u32 ethcmd;
 
@@ -2901,7 +2902,9 @@ wavelan_ioctl(struct net_device *	dev,	/
 	      struct ifreq *	rq,	/* Data passed */
 	      int		cmd)	/* Ioctl number */
 {
+#if WIRELESS_EXT <= 12
   struct iwreq *	wrq = (struct iwreq *) rq;
+#endif
   int			ret = 0;
 
 #ifdef DEBUG_IOCTL_TRACE
@@ -2912,7 +2915,7 @@ wavelan_ioctl(struct net_device *	dev,	/
   switch(cmd)
     {
     case SIOCETHTOOL:
-      ret = netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
+      ret = wl_netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
       break;
 
 #if WIRELESS_EXT <= 12

