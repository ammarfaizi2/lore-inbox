Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUA0ACP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265653AbUA0ACP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:02:15 -0500
Received: from fmr99.intel.com ([192.55.52.32]:37783 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S265654AbUA0ACE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:02:04 -0500
Date: Mon, 26 Jan 2004 16:37:46 -0800 (PST)
From: "Feldman, Scott" <scott.feldman@intel.com>
X-X-Sender: scott.feldman@localhost.localdomain
Reply-To: "Feldman, Scott" <scott.feldman@intel.com>
To: Petr Sebor <petr@scssoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.x] e1000: NETDEV WATCHDOG: eth0: transmit timed out
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E01036EA9DA@orsmsx402.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0401261625210.3324-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jan 2004, Petr Sebor wrote:

> after a weekend and half of working day (with extra torturing of the
> network card)
> the NETDEV WATCHDOG's are not barking anymore with the tso's disabled.
> 
> Do you want me to do more testing or will you tell me what _the_ next
> step is ? :-)

Petr, sorry for the suspense.  Here's a patch against 2.6.2-rc2 that fixes 
a race in the Tx path of e1000 that you may be exposing with TSO on.  The 
race is:

Tx queue		Tx clean (interrupt context)

...
if(h/w Q full)         | clean h/w Q
        ...        <---| if(s/w Q stopped) 
        stop s/w Q     |       wake s/w Q


So let's try this patch with TSO back on.

--- linux-2.6.2-rc2/drivers/net/e1000/e1000.h.orig	2004-01-26 15:38:40.000000000 -0800
+++ linux-2.6.2-rc2/drivers/net/e1000/e1000.h	2004-01-26 15:35:37.000000000 -0800
@@ -192,6 +192,7 @@
 
 	/* TX */
 	struct e1000_desc_ring tx_ring;
+	spinlock_t tx_lock;
 	uint32_t txd_cmd;
 	uint32_t tx_int_delay;
 	uint32_t tx_abs_int_delay;
--- linux-2.6.2-rc2/drivers/net/e1000/e1000_main.c.orig	2004-01-26 15:38:33.000000000 -0800
+++ linux-2.6.2-rc2/drivers/net/e1000/e1000_main.c	2004-01-26 15:33:25.000000000 -0800
@@ -669,6 +669,7 @@
 
 	atomic_set(&adapter->irq_sem, 1);
 	spin_lock_init(&adapter->stats_lock);
+	spin_lock_init(&adapter->tx_lock);
 
 	return 0;
 }
@@ -1783,6 +1784,7 @@
 	struct e1000_adapter *adapter = netdev->priv;
 	unsigned int first;
 	unsigned int tx_flags = 0;
+	unsigned long flags;
 	int count;
 
 	if(skb->len <= 0) {
@@ -1790,10 +1792,13 @@
 		return 0;
 	}
 
+	spin_lock_irqsave(&adapter->tx_lock, flags);
+
 	if(adapter->hw.mac_type == e1000_82547) {
 		if(e1000_82547_fifo_workaround(adapter, skb)) {
 			netif_stop_queue(netdev);
 			mod_timer(&adapter->tx_fifo_stall_timer, jiffies);
+			spin_unlock_irqrestore(&adapter->tx_lock, flags);
 			return 1;
 		}
 	}
@@ -1814,11 +1819,14 @@
 		e1000_tx_queue(adapter, count, tx_flags);
 	else {
 		netif_stop_queue(netdev);
+		spin_unlock_irqrestore(&adapter->tx_lock, flags);
 		return 1;
 	}
 
 	netdev->trans_start = jiffies;
 
+	spin_unlock_irqrestore(&adapter->tx_lock, flags);
+	
 	return 0;
 }
 
@@ -2171,6 +2179,8 @@
 	unsigned int i, eop;
 	boolean_t cleaned = FALSE;
 
+	spin_lock(&adapter->tx_lock);
+
 	i = tx_ring->next_to_clean;
 	eop = tx_ring->buffer_info[i].next_to_watch;
 	eop_desc = E1000_TX_DESC(*tx_ring, eop);
@@ -2215,6 +2225,8 @@
 	if(cleaned && netif_queue_stopped(netdev) && netif_carrier_ok(netdev))
 		netif_wake_queue(netdev);
 
+	spin_unlock(&adapter->tx_lock);
+
 	return cleaned;
 }
 

