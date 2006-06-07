Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWFGQw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWFGQw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWFGQw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:52:28 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:39821 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932327AbWFGQw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:52:26 -0400
Date: Wed, 7 Jun 2006 12:52:25 -0400
To: linux-kernel@vger.kernel.org
Cc: Len Sorensen <lsorense@csclub.uwaterloo.ca>, linux-net@vger.kernel.org
Subject: [PATCH] pcnet32 driver NAPI support
Message-ID: <20060607165225.GB7859@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have added NAPI support to the pcnet32 driver.  This has greatly
improved the responsiveness on my systems (geode GX1 266MHz) when under
heavy network load.  Without this change the system would become
unresponsive due to interrupts when flooded with traffic, and eventually
the watchdog would reboot the system due to the watchdog daemon being
starved for cpu time.  With the patch the system is still useable on a
serial console, although very slow.  Network throughput is also higher
since more time is spend processing packets and getting them sent out,
instead of only spending time acknowledging interrupts from incoming
packets.

Now having never actually done a patch submission to the kernel before,
I will try and see if I can do it right.

The patch adds a PCNET32_NAPI config option to drivers/net/Kconfig, and
the appropriate code to support the option to drivers/net/pcnet32.c and
has been tested on many of my systems (allthough they are allmost all
identical, and require some extra patches to pcnet32 due to not having
an EEPROM installed), and on an AT-2700TX.

I have made a diff against 2.6.16.20 and 2.6.17-rc6.

Comments would be very welcome.

Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>

Len Sorensen

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcnet32napi.2.6.16.20.diff"

diff -ruN linux-2.6.16.20/drivers/net/Kconfig linux-2.6.16.20.pcnet32napi/drivers/net/Kconfig
--- linux-2.6.16.20/drivers/net/Kconfig	2006-06-05 13:18:23.000000000 -0400
+++ linux-2.6.16.20.pcnet32napi/drivers/net/Kconfig	2006-06-07 11:19:54.000000000 -0400
@@ -1272,6 +1272,23 @@
 	  <file:Documentation/networking/net-modules.txt>. The module
 	  will be called pcnet32.
 
+config PCNET32_NAPI
+	bool "Use NAPI RX polling "
+	depends on PCNET32
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
+
 config AMD8111_ETH
 	tristate "AMD 8111 (new PCI lance) support"
 	depends on NET_PCI && PCI
diff -ruN linux-2.6.16.20/drivers/net/pcnet32.c linux-2.6.16.20.pcnet32napi/drivers/net/pcnet32.c
--- linux-2.6.16.20/drivers/net/pcnet32.c	2006-06-05 13:18:23.000000000 -0400
+++ linux-2.6.16.20.pcnet32napi/drivers/net/pcnet32.c	2006-06-07 12:00:36.000000000 -0400
@@ -21,9 +21,15 @@
  *
  *************************************************************************/
 
+#include <linux/config.h>
+
+#ifdef CONFIG_PCNET32_NAPI
+#define DRV_NAME	"pcnet32napi"
+#else
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.31c"
-#define DRV_RELDATE	"01.Nov.2005"
+#endif
+#define DRV_VERSION	"1.31d"
+#define DRV_RELDATE	"06.Jun.2006"
 #define PFX		DRV_NAME ": "
 
 static const char *version =
@@ -265,6 +271,7 @@
  * v1.31c  01 Nov 2005 Don Fry Allied Telesyn 2700/2701 FX are 100Mbit only.
  *	   Force 100Mbit FD if Auto (ASEL) is selected.
  *	   See Bugzilla 2669 and 4551.
+ * v1.31d  06 Jun 2006 Len Sorensen added NAPI support.
  */
 
 
@@ -383,6 +390,7 @@
     struct mii_if_info	mii_if;
     struct timer_list	watchdog_timer;
     struct timer_list	blink_timer;
+    struct timer_list	oom_timer;
     u32			msg_enable;	/* debug message level */
 };
 
@@ -392,7 +400,13 @@
 static int  pcnet32_open(struct net_device *);
 static int  pcnet32_init_ring(struct net_device *);
 static int  pcnet32_start_xmit(struct sk_buff *, struct net_device *);
+#ifdef CONFIG_PCNET32_NAPI
+void disable_rx_and_norxbuff_ints(struct net_device *dev);
+void enable_rx_and_norxbuff_ints(struct net_device *dev);
+static int  pcnet32_poll(struct net_device *, int *budget);
+#else
 static int  pcnet32_rx(struct net_device *);
+#endif
 static void pcnet32_tx_timeout (struct net_device *dev);
 static irqreturn_t pcnet32_interrupt(int, void *, struct pt_regs *);
 static int  pcnet32_close(struct net_device *);
@@ -422,6 +436,174 @@
     PCI_ADDR0=0x10<<0, PCI_ADDR1=0x10<<1, PCI_ADDR2=0x10<<2, PCI_ADDR3=0x10<<3,
 };
 
+#ifdef CONFIG_PCNET32_NAPI
+void oom_timer(unsigned long data)
+{
+    struct net_device *dev = (struct net_device *)data;
+    struct pcnet32_private *lp = dev->priv;
+    lp->rl_active = 0;
+    netif_rx_schedule(dev);
+}
+
+static
+int pcnet32_poll(struct net_device *dev, int *budget)
+{
+    struct pcnet32_private *lp = dev->priv;
+    ulong ioaddr = dev->base_addr;
+
+    int entry = lp->cur_rx & lp->rx_mod_mask;
+    int rx_work_limit = dev->quota;
+    int received = 0;
+
+    if (!netif_running(dev))
+	goto done;
+
+    do {
+	// Clear RX interrupts
+	lp->a.write_csr (ioaddr, 0, 0x1400);
+
+	/* If we own the next entry, it's a new packet. Send it up. */
+	while ((short)le16_to_cpu(lp->rx_ring[entry].status) >= 0) {
+	    int status = (short)le16_to_cpu(lp->rx_ring[entry].status) >> 8;
+    
+	    if (status != 0x03) {			/* There was an error. */
+	        /*
+	         * There is a tricky error noted by John Murphy,
+	         * <murf@perftech.com> to Russ Nelson: Even with full-sized
+	         * buffers it's possible for a jabber packet to use two
+	         * buffers, with only the last correctly noting the error.
+	         */
+	        if (status & 0x01)	/* Only count a general error at the */
+		    lp->stats.rx_errors++; /* end of a packet.*/
+	        if (status & 0x20) lp->stats.rx_frame_errors++;
+	        if (status & 0x10) lp->stats.rx_over_errors++;
+	        if (status & 0x08) lp->stats.rx_crc_errors++;
+	        if (status & 0x04) lp->stats.rx_fifo_errors++;
+	        lp->rx_ring[entry].status &= le16_to_cpu(0x03ff);
+	    } else {
+	        /* Malloc up new buffer, compatible with net-2e. */
+	        short pkt_len = (le32_to_cpu(lp->rx_ring[entry].msg_length) & 0xfff)-4;
+	        struct sk_buff *skb;
+    
+	        /* Discard oversize frames. */
+	        if (unlikely(pkt_len > PKT_BUF_SZ - 2)) {
+		    if (netif_msg_drv(lp))
+		        printk(KERN_ERR "%s: Impossible packet size %d!\n",
+			        dev->name, pkt_len);
+		    lp->stats.rx_errors++;
+	        } else if (pkt_len < 60) {
+		    if (netif_msg_rx_err(lp))
+		        printk(KERN_ERR "%s: Runt packet!\n", dev->name);
+		    lp->stats.rx_errors++;
+	        } else {
+		    int rx_in_place = 0;
+		    if (--rx_work_limit < 0) {
+		        goto not_done;
+		    }
+		    if (pkt_len > rx_copybreak) {
+		        struct sk_buff *newskb;
+		        if ((newskb = dev_alloc_skb(PKT_BUF_SZ))) {
+			    skb_reserve (newskb, 2);
+			    skb = lp->rx_skbuff[entry];
+			    pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[entry],
+				    PKT_BUF_SZ-2, PCI_DMA_FROMDEVICE);
+			    skb_put (skb, pkt_len);
+			    lp->rx_skbuff[entry] = newskb;
+			    newskb->dev = dev;
+			    lp->rx_dma_addr[entry] =
+			        pci_map_single(lp->pci_dev, newskb->data,
+				        PKT_BUF_SZ-2, PCI_DMA_FROMDEVICE);
+			    lp->rx_ring[entry].base = le32_to_cpu(lp->rx_dma_addr[entry]);
+			    rx_in_place = 1;
+		        } else
+			    skb = NULL;
+		    } else {
+		        skb = dev_alloc_skb(pkt_len+2);
+		    }
+		    if (skb == NULL) {
+		        int i;
+		        if (netif_msg_drv(lp))
+			    printk(KERN_ERR "%s: Memory squeeze, deferring packet.\n",
+				    dev->name);
+		        for (i = 0; i < lp->rx_ring_size; i++)
+			    if ((short)le16_to_cpu(lp->rx_ring[(entry+i)
+				        & lp->rx_mod_mask].status) < 0)
+			        break;
+    
+		        if (i > lp->rx_ring_size -2) {
+			    lp->stats.rx_dropped++;
+			    lp->rx_ring[entry].status |= le16_to_cpu(0x8000);
+			    wmb();	/* Make sure adapter sees owner change */
+			    lp->cur_rx++;
+		        }
+		        goto oom;
+		    }
+		    skb->dev = dev;
+		    if (!rx_in_place) {
+		        skb_reserve(skb,2); /* 16 byte align */
+		        skb_put(skb,pkt_len);	/* Make room */
+		        pci_dma_sync_single_for_cpu(lp->pci_dev,
+						    lp->rx_dma_addr[entry],
+						    PKT_BUF_SZ-2,
+						    PCI_DMA_FROMDEVICE);
+		        eth_copy_and_sum(skb,
+			        (unsigned char *)(lp->rx_skbuff[entry]->data),
+			        pkt_len,0);
+		        pci_dma_sync_single_for_device(lp->pci_dev,
+						       lp->rx_dma_addr[entry],
+						       PKT_BUF_SZ-2,
+						       PCI_DMA_FROMDEVICE);
+		    }
+		    lp->stats.rx_bytes += skb->len;
+		    skb->protocol=eth_type_trans(skb,dev);
+		    dev->last_rx = jiffies;
+		    netif_receive_skb(skb);
+		    lp->stats.rx_packets++;
+	        }
+	    }
+	    /*
+	     * The docs say that the buffer length isn't touched, but Andrew Boyd
+	     * of QNX reports that some revs of the 79C965 clear it.
+	     */
+	    lp->rx_ring[entry].buf_length = le16_to_cpu(2-PKT_BUF_SZ);
+	    wmb(); /* Make sure owner changes after all others are visible */
+	    lp->rx_ring[entry].status |= le16_to_cpu(0x8000);
+	    entry = (++lp->cur_rx) & lp->rx_mod_mask;
+	    received++;
+	}
+    } while(lp->a.read_csr (ioaddr, 0) & 0x1400);
+
+done:
+ 
+	dev->quota -= received;
+	*budget -= received;
+
+	/* Remove us from polling list and enable RX intr. */
+	netif_rx_complete(dev);
+	enable_rx_and_norxbuff_ints(dev);
+
+	return 0;
+ 
+not_done:
+	if (!received) {
+	        received = dev->quota; /* Not to happen */
+	}
+	dev->quota -= received;
+	*budget -= received;
+
+	return 1;
+
+oom: /* Executed with RX ints disabled */
+
+    /* Start timer, stop polling, but do not enable rx interrupts. */
+    mod_timer(&lp->oom_timer, jiffies+1);
+      
+    /* remove ourselves from the polling list */
+    netif_rx_complete(dev);
+ 
+    return 0;
+}
+#endif
 
 static u16 pcnet32_wio_read_csr (unsigned long addr, int index)
 {
@@ -775,7 +957,7 @@
 	    lp->tx_ring[x].length = le16_to_cpu(-skb->len);
 	    lp->tx_ring[x].misc = 0;
 
-            /* put DA and SA into the skb */
+	    /* put DA and SA into the skb */
 	    for (i=0; i<6; i++)
 		*packet++ = dev->dev_addr[i];
 	    for (i=0; i<6; i++)
@@ -1334,6 +1516,12 @@
     lp->mii_if.mdio_read = mdio_read;
     lp->mii_if.mdio_write = mdio_write;
 
+#ifdef CONFIG_PCNET32_NAPI
+    init_timer(&lp->oom_timer);
+    lp->oom_timer.data = (unsigned long)dev;
+    lp->oom_timer.function = oom_timer;
+#endif
+
     if (fdx && !(lp->options & PCNET32_PORT_ASEL) &&
 		((cards_found>=MAX_UNITS) || full_duplex[cards_found]))
 	lp->options |= PCNET32_PORT_FD;
@@ -1418,6 +1606,10 @@
     dev->ethtool_ops = &pcnet32_ethtool_ops;
     dev->tx_timeout = pcnet32_tx_timeout;
     dev->watchdog_timeo = (5*HZ);
+#ifdef CONFIG_PCNET32_NAPI
+    dev->poll = pcnet32_poll;
+    dev->weight = 16;
+#endif
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
     dev->poll_controller = pcnet32_poll_controller;
@@ -1949,6 +2141,38 @@
     return 0;
 }
 
+void
+disable_rx_and_norxbuff_ints(struct net_device *dev)
+{
+    u16 csr3,rap;
+    unsigned long ioaddr;
+    struct pcnet32_private *lp;
+
+    ioaddr = dev->base_addr;
+    lp = dev->priv;
+    rap = lp->a.read_rap(ioaddr);
+    csr3 = lp->a.read_csr (ioaddr, 3);
+    lp->a.write_csr (ioaddr, 3, csr3 | 0x1400); // Set the MISSM and RINTM bits
+    lp->a.write_rap (ioaddr,rap);
+}
+
+void
+enable_rx_and_norxbuff_ints(struct net_device *dev)
+{
+    u16 csr3,rap;
+    unsigned long ioaddr;
+    struct pcnet32_private *lp;
+
+    ioaddr = dev->base_addr;
+    lp = dev->priv;
+    rap = lp->a.read_rap(ioaddr);
+    csr3 = lp->a.read_csr (ioaddr, 3);
+    lp->a.write_csr (ioaddr, 3, csr3 & ~0x1400); // Clear the MISSM and RINTM bits
+    /* Set interrupt enable. */
+    lp->a.write_csr (ioaddr, 0, 0x0040);
+    lp->a.write_rap (ioaddr,rap);
+}
+
 /* The PCNET32 interrupt handler. */
 static irqreturn_t
 pcnet32_interrupt(int irq, void *dev_id, struct pt_regs * regs)
@@ -1978,7 +2202,11 @@
 	    break;			/* PCMCIA remove happened */
 	}
 	/* Acknowledge all of the current interrupt sources ASAP. */
+#ifdef CONFIG_PCNET32_NAPI
+	lp->a.write_csr (ioaddr, 0, csr0 & ~0x144f);
+#else
 	lp->a.write_csr (ioaddr, 0, csr0 & ~0x004f);
+#endif
 
 	must_restart = 0;
 
@@ -1986,8 +2214,18 @@
 	    printk(KERN_DEBUG "%s: interrupt  csr0=%#2.2x new csr=%#2.2x.\n",
 		   dev->name, csr0, lp->a.read_csr (ioaddr, 0));
 
-	if (csr0 & 0x0400)		/* Rx interrupt */
+	if (csr0 & 0x0400) {		/* Rx interrupt */
+#ifdef CONFIG_PCNET32_NAPI
+	    if(!lp->rl_active) {
+		disable_rx_and_norxbuff_ints(dev);
+		netif_rx_schedule(dev);
+	    } else {
+		lp->a.write_csr (ioaddr, 0, 0x0400);
+	    }
+#else
 	    pcnet32_rx(dev);
+#endif
+	}
 
 	if (csr0 & 0x0200) {		/* Tx-done interrupt */
 	    unsigned int dirty_tx = lp->dirty_tx;
@@ -2084,7 +2322,16 @@
 	     * interrupt, but a missed frame interrupt sooner or later.
 	     * So we try to clean up our receive ring here.
 	     */
+#ifdef CONFIG_PCNET32_NAPI
+	    if(!lp->rl_active) {
+		disable_rx_and_norxbuff_ints(dev);
+		netif_rx_schedule(dev);
+	    } else {
+		lp->a.write_csr (ioaddr, 0, 0x1000);
+	    }
+#else
 	    pcnet32_rx(dev);
+#endif
 	    lp->stats.rx_errors++; /* Missed a Rx frame. */
 	}
 	if (csr0 & 0x0800) {
@@ -2116,6 +2363,7 @@
     return IRQ_HANDLED;
 }
 
+#ifndef CONFIG_PCNET32_NAPI
 static int
 pcnet32_rx(struct net_device *dev)
 {
@@ -2235,6 +2483,7 @@
 
     return 0;
 }
+#endif
 
 static int
 pcnet32_close(struct net_device *dev)
@@ -2245,6 +2494,9 @@
     unsigned long flags;
 
     del_timer_sync(&lp->watchdog_timer);
+#ifdef CONFIG_PCNET32_NAPI
+    del_timer_sync(&lp->oom_timer);
+#endif
 
     netif_stop_queue(dev);
 

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcnet32napi.2.6.17-rc6.diff"

diff -ruN linux-2.6.17-rc6/drivers/net/Kconfig linux-2.6.17-rc6.pcnet32napi/drivers/net/Kconfig
--- linux-2.6.17-rc6/drivers/net/Kconfig	2006-06-05 13:18:23.000000000 -0400
+++ linux-2.6.17-rc6.pcnet32napi/drivers/net/Kconfig	2006-06-07 11:19:54.000000000 -0400
@@ -1272,6 +1272,23 @@
 	  <file:Documentation/networking/net-modules.txt>. The module
 	  will be called pcnet32.
 
+config PCNET32_NAPI
+	bool "Use NAPI RX polling "
+	depends on PCNET32
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
+
 config AMD8111_ETH
 	tristate "AMD 8111 (new PCI lance) support"
 	depends on NET_PCI && PCI
diff -ruN linux-2.6.17-rc6/drivers/net/pcnet32.c linux-2.6.17-rc6.pcnet32napi/drivers/net/pcnet32.c
--- linux-2.6.17-rc6/drivers/net/pcnet32.c	2006-06-05 13:18:23.000000000 -0400
+++ linux-2.6.17-rc6.pcnet32napi/drivers/net/pcnet32.c	2006-06-07 12:00:36.000000000 -0400
@@ -21,9 +21,15 @@
  *
  *************************************************************************/
 
+#include <linux/config.h>
+
+#ifdef CONFIG_PCNET32_NAPI
+#define DRV_NAME	"pcnet32napi"
+#else
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.32"
-#define DRV_RELDATE	"18.Mar.2006"
+#endif
+#define DRV_VERSION	"1.32a"
+#define DRV_RELDATE	"06.Jun.2006"
 #define PFX		DRV_NAME ": "
 
 static const char *const version =
@@ -271,6 +277,7 @@
 	struct mii_if_info	mii_if;
 	struct timer_list	watchdog_timer;
 	struct timer_list	blink_timer;
+	struct timer_list	oom_timer;
 	u32			msg_enable;	/* debug message level */
 
 	/* each bit indicates an available PHY */
@@ -283,7 +290,13 @@
 static int pcnet32_open(struct net_device *);
 static int pcnet32_init_ring(struct net_device *);
 static int pcnet32_start_xmit(struct sk_buff *, struct net_device *);
+#ifdef CONFIG_PCNET32_NAPI
+void disable_rx_and_norxbuff_ints(struct net_device *dev);
+void enable_rx_and_norxbuff_ints(struct net_device *dev);
+static int  pcnet32_poll(struct net_device *, int *budget);
+#else
 static int pcnet32_rx(struct net_device *);
+#endif
 static void pcnet32_tx_timeout(struct net_device *dev);
 static irqreturn_t pcnet32_interrupt(int, void *, struct pt_regs *);
 static int pcnet32_close(struct net_device *);
@@ -315,6 +328,213 @@
 	    0x10 << 2, PCI_ADDR3 = 0x10 << 3,
 };
 
+#ifdef CONFIG_PCNET32_NAPI
+void oom_timer(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct pcnet32_private *lp = dev->priv;
+	lp->rl_active = 0;
+	netif_rx_schedule(dev);
+}
+
+static
+int pcnet32_poll(struct net_device *dev, int *budget)
+{
+	struct pcnet32_private *lp = dev->priv;
+	ulong ioaddr = dev->base_addr;
+
+	int entry = lp->cur_rx & lp->rx_mod_mask;
+	int rx_work_limit = dev->quota;
+	int received = 0;
+
+	if (!netif_running(dev))
+		goto done;
+
+	do {
+		// Clear RX interrupts
+		lp->a.write_csr (ioaddr, 0, 0x1400);
+
+		/* If we own the next entry, it's a new packet. Send it up. */
+		while ((short)le16_to_cpu(lp->rx_ring[entry].status) >= 0) {
+			int status = (short)le16_to_cpu(lp->rx_ring[entry].status) >> 8;
+
+			if (status != 0x03) {			/* There was an error. */
+				/*
+				 * There is a tricky error noted by John Murphy,
+				 * <murf@perftech.com> to Russ Nelson: Even with full-sized
+				 * buffers it's possible for a jabber packet to use two
+				 * buffers, with only the last correctly noting the error.
+				 */
+				if (status & 0x01)	/* Only count a general error at the */
+					lp->stats.rx_errors++; /* end of a packet.*/
+				if (status & 0x20)
+					lp->stats.rx_frame_errors++;
+				if (status & 0x10)
+					lp->stats.rx_over_errors++;
+				if (status & 0x08)
+					lp->stats.rx_crc_errors++;
+				if (status & 0x04)
+					lp->stats.rx_fifo_errors++;
+				lp->rx_ring[entry].status &= le16_to_cpu(0x03ff);
+			} else {
+				/* Malloc up new buffer, compatible with net-2e. */
+				short pkt_len =
+				    (le32_to_cpu(lp->rx_ring[entry].msg_length) & 0xfff)
+				    - 4;
+				struct sk_buff *skb;
+    
+				/* Discard oversize frames. */
+				if (unlikely(pkt_len > PKT_BUF_SZ - 2)) {
+					if (netif_msg_drv(lp))
+						printk(KERN_ERR 
+							"%s: Impossible packet size %d!\n",
+							dev->name, pkt_len);
+					lp->stats.rx_errors++;
+				} else if (pkt_len < 60) {
+					if (netif_msg_rx_err(lp))
+						printk(KERN_ERR "%s: Runt packet!\n",
+							dev->name);
+					lp->stats.rx_errors++;
+				} else {
+					int rx_in_place = 0;
+					if (--rx_work_limit < 0) {
+						goto not_done;
+					}
+					if (pkt_len > rx_copybreak) {
+						struct sk_buff *newskb;
+
+						if ((newskb = 
+						    dev_alloc_skb(PKT_BUF_SZ))) {
+							skb_reserve (newskb, 2);
+							skb = lp->rx_skbuff[entry];
+							pci_unmap_single(lp->pci_dev, 
+									lp->
+									rx_dma_addr
+									[entry],
+									PKT_BUF_SZ-2,
+									PCI_DMA_FROMDEVICE);
+							skb_put (skb, pkt_len);
+							lp->rx_skbuff[entry] = newskb;
+							newskb->dev = dev;
+							lp->rx_dma_addr[entry] =
+							    pci_map_single(lp->pci_dev,
+									    newskb->data,
+									    PKT_BUF_SZ -
+									    2,
+									    PCI_DMA_FROMDEVICE);
+							lp->rx_ring[entry].base =
+							    le32_to_cpu(lp->
+									rx_dma_addr
+									[entry]);
+							rx_in_place = 1;
+						} else
+							skb = NULL;
+					} else {
+						skb = dev_alloc_skb(pkt_len+2);
+					}
+
+					if (skb == NULL) {
+						int i;
+						if (netif_msg_drv(lp))
+							printk(KERN_ERR
+								"%s: Memory squeeze, deferring packet.\n",
+								dev->name);
+						for (i = 0; i < lp->rx_ring_size; i++)
+							if ((short)
+							    le16_to_cpu(lp->
+									rx_ring[(entry + 
+										 i)
+										& lp->
+										rx_mod_mask].
+									status) < 0)
+								break;
+
+						if (i > lp->rx_ring_size -2) {
+							lp->stats.rx_dropped++;
+							lp->rx_ring[entry].status |=
+							    le16_to_cpu(0x8000);
+							wmb();	/* Make sure adapter sees owner change */
+							lp->cur_rx++;
+						}
+						goto oom;
+					}
+					skb->dev = dev;
+					if (!rx_in_place) {
+						skb_reserve(skb,2); /* 16 byte align */
+						skb_put(skb,pkt_len);	/* Make room */
+						pci_dma_sync_single_for_cpu(lp->pci_dev,
+									    lp->
+									    rx_dma_addr
+									    [entry],
+									    PKT_BUF_SZ -
+									    2,
+									    PCI_DMA_FROMDEVICE);
+						eth_copy_and_sum(skb,
+								(unsigned char *)(lp->
+										  rx_skbuff
+										  [entry]->
+										  data),
+								pkt_len,0);
+						pci_dma_sync_single_for_device(lp->
+									       pci_dev,
+									       lp->
+									       rx_dma_addr
+									       [entry],
+									       PKT_BUF_SZ
+									       - 2,
+									       PCI_DMA_FROMDEVICE);
+					}
+					lp->stats.rx_bytes += skb->len;
+					skb->protocol=eth_type_trans(skb,dev);
+					dev->last_rx = jiffies;
+					netif_receive_skb(skb);
+					lp->stats.rx_packets++;
+				}
+			}
+			/*
+			 * The docs say that the buffer length isn't touched, but Andrew Boyd
+			 * of QNX reports that some revs of the 79C965 clear it.
+			 */
+			lp->rx_ring[entry].buf_length = le16_to_cpu(2-PKT_BUF_SZ);
+			wmb(); /* Make sure owner changes after all others are visible */
+			lp->rx_ring[entry].status |= le16_to_cpu(0x8000);
+			entry = (++lp->cur_rx) & lp->rx_mod_mask;
+			received++;
+		}
+	} while(lp->a.read_csr (ioaddr, 0) & 0x1400);
+
+done:
+ 
+	dev->quota -= received;
+	*budget -= received;
+
+	/* Remove us from polling list and enable RX intr. */
+	netif_rx_complete(dev);
+	enable_rx_and_norxbuff_ints(dev);
+
+	return 0;
+ 
+not_done:
+	if (!received) {
+	 	received = dev->quota; /* Not to happen */
+	}
+	dev->quota -= received;
+	*budget -= received;
+
+	return 1;
+
+oom: /* Executed with RX ints disabled */
+
+	/* Start timer, stop polling, but do not enable rx interrupts. */
+	mod_timer(&lp->oom_timer, jiffies+1);
+      
+	/* remove ourselves from the polling list */
+	netif_rx_complete(dev);
+ 
+	return 0;
+}
+#endif
+
 static u16 pcnet32_wio_read_csr(unsigned long addr, int index)
 {
 	outw(index, addr + PCNET32_WIO_RAP);
@@ -1284,6 +1504,12 @@
 	lp->mii_if.mdio_read = mdio_read;
 	lp->mii_if.mdio_write = mdio_write;
 
+#ifdef CONFIG_PCNET32_NAPI
+	init_timer(&lp->oom_timer);
+	lp->oom_timer.data = (unsigned long)dev;
+	lp->oom_timer.function = oom_timer;
+#endif
+
 	if (fdx && !(lp->options & PCNET32_PORT_ASEL) &&
 	    ((cards_found >= MAX_UNITS) || full_duplex[cards_found]))
 		lp->options |= PCNET32_PORT_FD;
@@ -1396,6 +1622,10 @@
 	dev->ethtool_ops = &pcnet32_ethtool_ops;
 	dev->tx_timeout = pcnet32_tx_timeout;
 	dev->watchdog_timeo = (5 * HZ);
+#ifdef CONFIG_PCNET32_NAPI
+	dev->poll = pcnet32_poll;
+	dev->weight = 16;
+#endif
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	dev->poll_controller = pcnet32_poll_controller;
@@ -2004,6 +2234,38 @@
 	return 0;
 }
 
+void
+disable_rx_and_norxbuff_ints(struct net_device *dev)
+{
+	u16 csr3,rap;
+	unsigned long ioaddr;
+	struct pcnet32_private *lp;
+
+	ioaddr = dev->base_addr;
+	lp = dev->priv;
+	rap = lp->a.read_rap(ioaddr);
+	csr3 = lp->a.read_csr (ioaddr, 3);
+	lp->a.write_csr (ioaddr, 3, csr3 | 0x1400); // Set the MISSM and RINTM bits
+	lp->a.write_rap (ioaddr,rap);
+}
+
+void
+enable_rx_and_norxbuff_ints(struct net_device *dev)
+{
+	u16 csr3,rap;
+	unsigned long ioaddr;
+	struct pcnet32_private *lp;
+
+	ioaddr = dev->base_addr;
+	lp = dev->priv;
+	rap = lp->a.read_rap(ioaddr);
+	csr3 = lp->a.read_csr (ioaddr, 3);
+	lp->a.write_csr (ioaddr, 3, csr3 & ~0x1400); // Clear the MISSM and RINTM bits
+	/* Set interrupt enable. */
+	lp->a.write_csr (ioaddr, 0, 0x0040);
+	lp->a.write_rap (ioaddr,rap);
+}
+
 /* The PCNET32 interrupt handler. */
 static irqreturn_t
 pcnet32_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -2033,7 +2295,11 @@
 			break;	/* PCMCIA remove happened */
 		}
 		/* Acknowledge all of the current interrupt sources ASAP. */
+#ifdef CONFIG_PCNET32_NAPI
+		lp->a.write_csr (ioaddr, 0, csr0 & ~0x144f);
+#else
 		lp->a.write_csr(ioaddr, 0, csr0 & ~0x004f);
+#endif
 
 		must_restart = 0;
 
@@ -2042,8 +2308,18 @@
 			       "%s: interrupt  csr0=%#2.2x new csr=%#2.2x.\n",
 			       dev->name, csr0, lp->a.read_csr(ioaddr, 0));
 
-		if (csr0 & 0x0400)	/* Rx interrupt */
+		if (csr0 & 0x0400) {	/* Rx interrupt */
+#ifdef CONFIG_PCNET32_NAPI
+	    		if(!lp->rl_active) {
+				disable_rx_and_norxbuff_ints(dev);
+				netif_rx_schedule(dev);
+			} else {
+				lp->a.write_csr (ioaddr, 0, 0x0400);
+			}
+#else
 			pcnet32_rx(dev);
+#endif
+		}
 
 		if (csr0 & 0x0200) {	/* Tx-done interrupt */
 			unsigned int dirty_tx = lp->dirty_tx;
@@ -2161,7 +2437,16 @@
 			 * interrupt, but a missed frame interrupt sooner or later.
 			 * So we try to clean up our receive ring here.
 			 */
+#ifdef CONFIG_PCNET32_NAPI
+	    		if(!lp->rl_active) {
+				disable_rx_and_norxbuff_ints(dev);
+				netif_rx_schedule(dev);
+			} else {
+				lp->a.write_csr (ioaddr, 0, 0x1000);
+			}
+#else
 			pcnet32_rx(dev);
+#endif
 			lp->stats.rx_errors++;	/* Missed a Rx frame. */
 		}
 		if (csr0 & 0x0800) {
@@ -2194,6 +2479,7 @@
 	return IRQ_HANDLED;
 }
 
+#ifndef CONFIG_PCNET32_NAPI
 static int pcnet32_rx(struct net_device *dev)
 {
 	struct pcnet32_private *lp = dev->priv;
@@ -2349,6 +2635,7 @@
 
 	return 0;
 }
+#endif
 
 static int pcnet32_close(struct net_device *dev)
 {
@@ -2358,6 +2645,9 @@
 	unsigned long flags;
 
 	del_timer_sync(&lp->watchdog_timer);
+#ifdef CONFIG_PCNET32_NAPI
+    	del_timer_sync(&lp->oom_timer);
+#endif
 
 	netif_stop_queue(dev);
 

--IJpNTDwzlM2Ie8A6--
