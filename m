Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSHHJ6A>; Thu, 8 Aug 2002 05:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSHHJ6A>; Thu, 8 Aug 2002 05:58:00 -0400
Received: from 213-97-251-19.uc.nombres.ttd.es ([213.97.251.19]:33419 "EHLO
	mortadelo") by vger.kernel.org with ESMTP id <S317433AbSHHJ57>;
	Thu, 8 Aug 2002 05:57:59 -0400
Date: Thu, 8 Aug 2002 12:04:02 +0200
From: Roberto Gordo Saez <rgs@linalco.com>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] GMAC ethernet controller (Apple PowerPC)
Message-ID: <20020808100402.GA7953@filemon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small fix for the link status (carrier) on PowerPC GMAC net driver.

Now ifconfig reports correctly the "RUNNING" flag, the same way that it is reported with other network cards i've tested (intel eepro100 on i386).


--- linux-2.4.19.orig/drivers/net/gmac.c	2002-08-08 08:38:10.000000000 +0200
+++ linux-2.4.19/drivers/net/gmac.c	2002-08-08 09:26:07.000000000 +0200
@@ -246,6 +246,7 @@
 #endif
 		    	full_duplex = ((aux_stat & MII_BCM5201_AUXCTLSTATUS_DUPLEX) != 0);
 		    	link_100 = ((aux_stat & MII_BCM5201_AUXCTLSTATUS_SPEED) != 0);
+			netif_carrier_on(gm->dev);
 		        break;
 		      case PHY_B5400:
 		      case PHY_B5401:
@@ -260,6 +261,7 @@
 		    	full_duplex = phy_BCM5400_link_table[link][0];
 		    	link_100 = phy_BCM5400_link_table[link][1];
 		    	gigabit = phy_BCM5400_link_table[link][2];
+			netif_carrier_on(gm->dev);
 		    	break;
 		      case PHY_LXT971:
 		    	aux_stat = mii_read(gm, gm->phy_addr, MII_LXT971_STATUS2);
@@ -269,6 +271,7 @@
 #endif
 		    	full_duplex = ((aux_stat & MII_LXT971_STATUS2_FULLDUPLEX) != 0);
 		    	link_100 = ((aux_stat & MII_LXT971_STATUS2_SPEED) != 0);
+			netif_carrier_on(gm->dev);
 		    	break;
 		      default:
 		    	full_duplex = (lpar_ability & MII_ANLPA_FDAM) != 0;
@@ -296,6 +299,7 @@
 #ifdef DEBUG_PHY
 		    printk(KERN_INFO "%s:    Link down !\n", gm->dev->name);
 #endif
+			netif_carrier_off(gm->dev);
 		}
 	}
 }
@@ -1101,7 +1105,10 @@
 	
 	/* Initialize the multicast tables & promisc mode if any */
 	gmac_set_multicast(dev);
-	
+
+	/* Initialize the carrier status */
+	netif_carrier_off(dev);
+
 	/*
 	 * Check out PHY status and start auto-poll
 	 * 
