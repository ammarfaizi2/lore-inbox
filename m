Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTEODiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTEODWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:22:22 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:27116 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263813AbTEODS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:27 -0400
Date: Thu, 15 May 2003 04:31:15 +0100
Message-Id: <200305150331.h4F3VFAm000746@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: byte counters for mkiss
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 2.4 from way back 13 months ago..

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/hamradio/mkiss.c linux-2.5/drivers/net/hamradio/mkiss.c
--- bk-linus/drivers/net/hamradio/mkiss.c	2003-04-24 03:50:37.000000000 +0100
+++ linux-2.5/drivers/net/hamradio/mkiss.c	2003-04-24 03:53:14.000000000 +0100
@@ -347,6 +347,7 @@ static void ax_bump(struct ax_disp *ax)
 	netif_rx(skb);
 	tmp_ax->dev->last_rx = jiffies;
 	tmp_ax->rx_packets++;
+	tmp_ax->rx_bytes+=count;
 }
 
 /* Encapsulate one AX.25 packet and stuff into a TTY queue. */
@@ -386,6 +387,7 @@ static void ax_encaps(struct ax_disp *ax
 		ax->tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
 		actual = ax->tty->driver->write(ax->tty, 0, ax->xbuff, count);
 		ax->tx_packets++;
+		ax->tx_bytes+=actual;
 		ax->dev->trans_start = jiffies;
 		ax->xleft = count - actual;
 		ax->xhead = ax->xbuff + actual;
@@ -394,6 +396,7 @@ static void ax_encaps(struct ax_disp *ax
 		ax->mkiss->tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
 		actual = ax->mkiss->tty->driver->write(ax->mkiss->tty, 0, ax->mkiss->xbuff, count);
 		ax->tx_packets++;
+		ax->tx_bytes+=actual;
 		ax->mkiss->dev->trans_start = jiffies;
 		ax->mkiss->xleft = count - actual;
 		ax->mkiss->xhead = ax->mkiss->xbuff + actual;
@@ -709,6 +712,8 @@ static struct net_device_stats *ax_get_s
 
 	stats.rx_packets     = ax->rx_packets;
 	stats.tx_packets     = ax->tx_packets;
+	stats.rx_bytes	     = ax->rx_bytes;
+	stats.tx_bytes       = ax->tx_bytes;
 	stats.rx_dropped     = ax->rx_dropped;
 	stats.tx_dropped     = ax->tx_dropped;
 	stats.tx_errors      = ax->tx_errors;
@@ -936,7 +941,7 @@ static int ax25_init(struct net_device *
 	memcpy(dev->dev_addr,  ax25_test,  AX25_ADDR_LEN);
 
 	/* New-style flags. */
-	dev->flags      = 0;
+	dev->flags      = IFF_BROADCAST | IFF_MULTICAST;
 
 	return 0;
 }
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/hamradio/mkiss.h linux-2.5/drivers/net/hamradio/mkiss.h
--- bk-linus/drivers/net/hamradio/mkiss.h	2003-04-10 06:01:21.000000000 +0100
+++ linux-2.5/drivers/net/hamradio/mkiss.h	2003-03-17 23:42:28.000000000 +0000
@@ -31,6 +31,8 @@ struct ax_disp {
 	/* SLIP interface statistics. */
 	unsigned long      rx_packets;		/* inbound frames counter	*/
 	unsigned long      tx_packets;		/* outbound frames counter      */
+	unsigned long      rx_bytes;		/* inbound bytes counter        */
+	unsigned long      tx_bytes;		/* outbound bytes counter       */
 	unsigned long      rx_errors;		/* Parity, etc. errors          */
 	unsigned long      tx_errors;		/* Planned stuff                */
 	unsigned long      rx_dropped;		/* No memory for skb            */
