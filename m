Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293388AbSCEPjk>; Tue, 5 Mar 2002 10:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSCEPjW>; Tue, 5 Mar 2002 10:39:22 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:26008 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S293388AbSCEPjL>; Tue, 5 Mar 2002 10:39:11 -0500
Date: Tue, 5 Mar 2002 09:37:39 -0600 (CST)
From: Kent Yoder <key@austin.ibm.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
In-Reply-To: <3C83C698.25D28157@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203050931490.415-100000@janetreno.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Ok, below is the current patch including the MWI changes as well as adding
printk log levels (as suggested by someone).

*fingers crossed* :-)

Kent

diff -urN linux-2.4.17.vanilla/drivers/net/tokenring/lanstreamer.c linux-2.4.17/drivers/net/tokenring/lanstreamer.c
--- linux-2.4.17.vanilla/drivers/net/tokenring/lanstreamer.c	Mon Feb  4 11:09:30 2002
+++ linux-2.4.17/drivers/net/tokenring/lanstreamer.c	Mon Mar  4 17:40:16 2002
@@ -60,6 +60,11 @@
  *		malloc free checks, reviewed code. <alan@redhat.com>
  *  03/13/00 - Added spinlocks for smp
  *  03/08/01 - Added support for module_init() and module_exit()
+ *  08/15/01 - Added ioctl() functionality for debugging, changed netif_*_queue
+ *             calls and other incorrectness - Kent Yoder <yoder1@us.ibm.com>
+ *  11/05/01 - Restructured the interrupt function, added delays, reduced the 
+ *             the number of TX descriptors to 1, which together can prevent 
+ *             the card from locking up the box - <yoder1@us.ibm.com>
  *  
  *  To Do:
  *
@@ -84,6 +89,14 @@
 
 #define STREAMER_NETWORK_MONITOR 0
 
+/* #define CONFIG_PROC_FS */
+
+/*
+ *  Allow or disallow ioctl's for debugging
+ */
+
+#define STREAMER_IOCTL 0
+
 #include <linux/config.h>
 #include <linux/module.h>
 
@@ -105,6 +118,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
+#include <linux/version.h>
 #include <net/checksum.h>
 
 #include <asm/io.h>
@@ -121,7 +135,8 @@
  * Official releases will only have an a.b.c version number format.
  */
 
-static char version[] = "LanStreamer.c v0.4.0 03/08/01 - Mike Sullivan";
+static char version[] = "LanStreamer.c v0.4.0 03/08/01 - Mike Sullivan\n"
+                        "              v0.5.1 03/04/02 - Kent Yoder";
 
 static struct pci_device_id streamer_pci_tbl[] __initdata = {
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR, PCI_ANY_ID, PCI_ANY_ID,},
@@ -175,6 +190,10 @@
 MODULE_PARM(message_level,
 	    "1-" __MODULE_STRING(STREAMER_MAX_ADAPTERS) "i");
 
+#if STREAMER_IOCTL
+static int streamer_ioctl(struct net_device *, struct ifreq *, int);
+#endif
+
 static int streamer_reset(struct net_device *dev);
 static int streamer_open(struct net_device *dev);
 static int streamer_xmit(struct sk_buff *skb, struct net_device *dev);
@@ -206,6 +225,8 @@
   __u32 mmio_start, mmio_end, mmio_flags, mmio_len;
   int rc=0;
   static int card_no=-1;
+  u16 pcr;
+  u8 cls = 0;
 
 #if STREAMER_DEBUG
   printk("lanstreamer::streamer_init_one, entry pdev %p\n",pdev);
@@ -281,7 +302,11 @@
 			dev->hard_start_xmit = &streamer_xmit;
 			dev->change_mtu = &streamer_change_mtu;
 			dev->stop = &streamer_close;
+#if STREAMER_IOCTL
+			dev->do_ioctl = &streamer_ioctl;
+#else
 			dev->do_ioctl = NULL;
+#endif
 			dev->set_multicast_list = &streamer_set_rx_mode;
 			dev->get_stats = &streamer_get_stats;
 			dev->set_mac_address = &streamer_set_mac_address;
@@ -303,6 +328,27 @@
 
   spin_lock_init(&streamer_priv->streamer_lock);
   
+  pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cls);
+  cls <<= 2;
+  if (cls != SMP_CACHE_BYTES) {
+         printk(KERN_INFO "  PCI cache line size set incorrectly "
+                "(%i bytes) by BIOS/FW, ", cls);
+         if (cls > SMP_CACHE_BYTES)
+                printk("expecting %i\n", SMP_CACHE_BYTES);
+         else {
+                printk("correcting to %i\n", SMP_CACHE_BYTES);
+                pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE,
+                                      SMP_CACHE_BYTES >> 2);
+         }
+  }
+
+  pci_read_config_word (pdev, PCI_COMMAND, &pcr);
+
+  pcr |= (PCI_COMMAND_INVALIDATE | PCI_COMMAND_SERR);
+
+  pci_write_config_word (pdev, PCI_COMMAND, pcr);
+  pci_read_config_word (pdev, PCI_COMMAND, &pcr);
+
   printk("%s \n", version);
   printk("%s: %s. I/O at %hx, MMIO at %p, using irq %d\n",dev->name,
 	 streamer_priv->streamer_card_name,
@@ -403,6 +449,7 @@
 	printk("GPR: %x\n", readw(streamer_mmio + GPR));
 	printk("SISRMASK: %x\n", readw(streamer_mmio + SISR_MASK));
 #endif
+	writew(readw(streamer_mmio + BCTL) | (BCTL_RX_FIFO_8 | BCTL_TX_FIFO_8), streamer_mmio + BCTL );
 
 	if (streamer_priv->streamer_ring_speed == 0) {	/* Autosense */
 		writew(readw(streamer_mmio + GPR) | GPR_AUTOSENSE,
@@ -558,8 +605,6 @@
 	do {
 		int i;
 
-		save_flags(flags);
-		cli();
 		for (i = 0; i < SRB_COMMAND_SIZE; i += 2) {
 			writew(0, streamer_mmio + LAPDINC);
 		}
@@ -599,11 +644,12 @@
 		}
 		printk("\n");
 #endif
-
+		spin_lock_irqsave(&streamer_priv->streamer_lock, flags);
 		streamer_priv->srb_queued = 1;
 
 		/* signal solo that SRB command has been issued */
 		writew(LISR_SRB_CMD, streamer_mmio + LISR_SUM);
+		spin_unlock_irqrestore(&streamer_priv->streamer_lock, flags);
 
 		while (streamer_priv->srb_queued) {
 			interruptible_sleep_on_timeout(&streamer_priv->srb_wait, 5 * HZ);
@@ -617,7 +663,6 @@
 				break;
 			}
 		}
-		restore_flags(flags);
 
 #if STREAMER_DEBUG
 		printk("SISR_MASK: %x\n", readw(streamer_mmio + SISR_MASK));
@@ -767,9 +812,12 @@
 		streamer_priv->streamer_tx_ring[i].bufcnt_framelen = 0;
 		streamer_priv->streamer_tx_ring[i].buffer = 0;
 		streamer_priv->streamer_tx_ring[i].buflen = 0;
+		streamer_priv->streamer_tx_ring[i].rsvd1 = 0;
+		streamer_priv->streamer_tx_ring[i].rsvd2 = 0;
+		streamer_priv->streamer_tx_ring[i].rsvd3 = 0;
 	}
 	streamer_priv->streamer_tx_ring[STREAMER_TX_RING_SIZE - 1].forward =
-					virt_to_bus(&streamer_priv->streamer_tx_ring[0]);;
+					virt_to_bus(&streamer_priv->streamer_tx_ring[0]);
 
 	streamer_priv->free_tx_ring_entries = STREAMER_TX_RING_SIZE;
 	streamer_priv->tx_ring_free = 0;	/* next entry in tx ring to use */
@@ -941,37 +989,30 @@
 	__u8 *streamer_mmio = streamer_priv->streamer_mmio;
 	__u16 sisr;
 	__u16 misr;
-	__u16 sisrmask;
+	u8 max_intr = MAX_INTR;
 
-	sisrmask = SISR_MI;
-	writew(~sisrmask, streamer_mmio + SISR_MASK_RUM);
+	spin_lock(&streamer_priv->streamer_lock);
 	sisr = readw(streamer_mmio + SISR);
-	writew(~sisr, streamer_mmio + SISR_RUM);
-	misr = readw(streamer_mmio + MISR_RUM);
-	writew(~misr, streamer_mmio + MISR_RUM);
 
-	if (!sisr) 
-	{		/* Interrupt isn't for us */
-  	        writew(~misr,streamer_mmio+MISR_RUM);
-		return;
-	}
+	while((sisr & (SISR_MI | SISR_SRB_REPLY | SISR_ADAPTER_CHECK | SISR_ASB_FREE | 
+		       SISR_ARB_CMD | SISR_TRB_REPLY | SISR_PAR_ERR | SISR_SERR_ERR))
+               && (max_intr > 0)) {
 
-	spin_lock(&streamer_priv->streamer_lock);
+		if(sisr & SISR_PAR_ERR) {
+			writew(~SISR_PAR_ERR, streamer_mmio + SISR_RUM);
+			(void)readw(streamer_mmio + SISR_RUM);
+		}
 
-	if ((sisr & (SISR_SRB_REPLY | SISR_ADAPTER_CHECK | SISR_ASB_FREE | SISR_ARB_CMD | SISR_TRB_REPLY))
-	    || (misr & (MISR_TX2_EOF | MISR_RX_NOBUF | MISR_RX_EOF))) {
-		if (sisr & SISR_SRB_REPLY) {
-			if (streamer_priv->srb_queued == 1) {
-				wake_up_interruptible(&streamer_priv->srb_wait);
-			} else if (streamer_priv->srb_queued == 2) {
-				streamer_srb_bh(dev);
-			}
-			streamer_priv->srb_queued = 0;
+		else if(sisr & SISR_SERR_ERR) {
+			writew(~SISR_SERR_ERR, streamer_mmio + SISR_RUM);
+			(void)readw(streamer_mmio + SISR_RUM);
 		}
-		/* SISR_SRB_REPLY */
+
+		else if(sisr & SISR_MI) {
+			misr = readw(streamer_mmio + MISR_RUM);
+
 		if (misr & MISR_TX2_EOF) {
-			while (streamer_priv->streamer_tx_ring[(streamer_priv->tx_ring_last_status + 1) & (STREAMER_TX_RING_SIZE - 1)].status) 
-			{
+				while(streamer_priv->streamer_tx_ring[(streamer_priv->tx_ring_last_status + 1) & (STREAMER_TX_RING_SIZE - 1)].status) {
 				streamer_priv->tx_ring_last_status = (streamer_priv->tx_ring_last_status + 1) & (STREAMER_TX_RING_SIZE - 1);
 				streamer_priv->free_tx_ring_entries++;
 				streamer_priv->streamer_stats.tx_bytes += streamer_priv->tx_ring_skb[streamer_priv->tx_ring_last_status]->len;
@@ -981,6 +1022,9 @@
 				streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_last_status].status = 0;
 				streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_last_status].bufcnt_framelen = 0;
 				streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_last_status].buflen = 0;
+				streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_last_status].rsvd1 = 0;
+				streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_last_status].rsvd2 = 0;
+				streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_last_status].rsvd3 = 0;
 			}
 			netif_wake_queue(dev);
 		}
@@ -989,7 +1033,30 @@
 			streamer_rx(dev);
 		}
 		/* MISR_RX_EOF */
-		if (sisr & SISR_ADAPTER_CHECK) {
+
+			if (misr & MISR_RX_NOBUF) {
+				/* According to the documentation, we don't have to do anything,  
+                                 * but trapping it keeps it out of /var/log/messages.  
+                                 */
+			}		/* SISR_RX_NOBUF */
+
+			writew(~misr, streamer_mmio + MISR_RUM);
+			(void)readw(streamer_mmio + MISR_RUM);
+		}
+
+		else if (sisr & SISR_SRB_REPLY) {
+			if (streamer_priv->srb_queued == 1) {
+				wake_up_interruptible(&streamer_priv->srb_wait);
+			} else if (streamer_priv->srb_queued == 2) {
+				streamer_srb_bh(dev);
+			}
+			streamer_priv->srb_queued = 0;
+
+			writew(~SISR_SRB_REPLY, streamer_mmio + SISR_RUM);
+			(void)readw(streamer_mmio + SISR_RUM);
+		}
+
+		else if (sisr & SISR_ADAPTER_CHECK) {
 			printk(KERN_WARNING "%s: Adapter Check Interrupt Raised, 8 bytes of information follow:\n", dev->name);
 			writel(readl(streamer_mmio + LAPWWO), streamer_mmio + LAPA);
 			printk(KERN_WARNING "%s: Words %x:%x:%x:%x:\n",
@@ -1001,38 +1068,37 @@
 		}
 
 		/* SISR_ADAPTER_CHECK */
-		if (sisr & SISR_ASB_FREE) {
+		else if (sisr & SISR_ASB_FREE) {
 			/* Wake up anything that is waiting for the asb response */
 			if (streamer_priv->asb_queued) {
 				streamer_asb_bh(dev);
 			}
+			writew(~SISR_ASB_FREE, streamer_mmio + SISR_RUM);
+			(void)readw(streamer_mmio + SISR_RUM);
 		}
 		/* SISR_ASB_FREE */
-		if (sisr & SISR_ARB_CMD) {
+		else if (sisr & SISR_ARB_CMD) {
 			streamer_arb_cmd(dev);
+			writew(~SISR_ARB_CMD, streamer_mmio + SISR_RUM);
+			(void)readw(streamer_mmio + SISR_RUM);
 		}
 		/* SISR_ARB_CMD */
-		if (sisr & SISR_TRB_REPLY) {
+		else if (sisr & SISR_TRB_REPLY) {
 			/* Wake up anything that is waiting for the trb response */
 			if (streamer_priv->trb_queued) {
 				wake_up_interruptible(&streamer_priv->
 						      trb_wait);
 			}
 			streamer_priv->trb_queued = 0;
+			writew(~SISR_TRB_REPLY, streamer_mmio + SISR_RUM);
+			(void)readw(streamer_mmio + SISR_RUM);
 		}
 		/* SISR_TRB_REPLY */
-		if (misr & MISR_RX_NOBUF) {
-			/* According to the documentation, we don't have to do anything, but trapping it keeps it out of
-			   /var/log/messages.  */
-		}		/* SISR_RX_NOBUF */
-	} else {
-		printk(KERN_WARNING "%s: Unexpected interrupt: %x\n",
-		       dev->name, sisr);
-		printk(KERN_WARNING "%s: SISR_MASK: %x\n", dev->name,
-		       readw(streamer_mmio + SISR_MASK));
-	}			/* One if the interrupts we want */
 
-	writew(SISR_MI, streamer_mmio + SISR_MASK_SUM);
+		sisr = readw(streamer_mmio + SISR);
+		max_intr--;
+	} /* while() */		
+
 	spin_unlock(&streamer_priv->streamer_lock) ; 
 }
 
@@ -1044,13 +1110,16 @@
 	unsigned long flags ;
 
 	spin_lock_irqsave(&streamer_priv->streamer_lock, flags);
-	netif_stop_queue(dev);
 
 	if (streamer_priv->free_tx_ring_entries) {
 		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].status = 0;
-		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].bufcnt_framelen = 0x00010000 | skb->len;
+		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].bufcnt_framelen = 0x00020000 | skb->len;
 		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].buffer = virt_to_bus(skb->data);
+		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].rsvd1 = skb->len;
+		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].rsvd2 = 0;
+		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].rsvd3 = 0;
 		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].buflen = skb->len;
+
 		streamer_priv->tx_ring_skb[streamer_priv->tx_ring_free] = skb;
 		streamer_priv->free_tx_ring_entries--;
 #if STREAMER_DEBUG_PACKETS
@@ -1067,12 +1136,13 @@
 #endif
 
 		writel(virt_to_bus (&streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free]),streamer_mmio + TX2LFDA);
+		(void)readl(streamer_mmio + TX2LFDA);
 
 		streamer_priv->tx_ring_free = (streamer_priv->tx_ring_free + 1) & (STREAMER_TX_RING_SIZE - 1);
-		netif_wake_queue(dev);
 		spin_unlock_irqrestore(&streamer_priv->streamer_lock,flags);
 		return 0;
 	} else {
+	        netif_stop_queue(dev);
 	        spin_unlock_irqrestore(&streamer_priv->streamer_lock,flags);
 		return 1;
 	}
@@ -1092,12 +1162,13 @@
 	writew(htons(SRB_CLOSE_ADAPTER << 8),streamer_mmio+LAPDINC);
 	writew(htons(STREAMER_CLEAR_RET_CODE << 8), streamer_mmio+LAPDINC);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&streamer_priv->streamer_lock, flags);
 
 	streamer_priv->srb_queued = 1;
 	writew(LISR_SRB_CMD, streamer_mmio + LISR_SUM);
 
+	spin_unlock_irqrestore(&streamer_priv->streamer_lock, flags);
+
 	while (streamer_priv->srb_queued) 
 	{
 		interruptible_sleep_on_timeout(&streamer_priv->srb_wait,
@@ -1114,7 +1185,6 @@
 		}
 	}
 
-	restore_flags(flags);
 	streamer_priv->rx_ring_last_received = (streamer_priv->rx_ring_last_received + 1) & (STREAMER_RX_RING_SIZE - 1);
 
 	for (i = 0; i < STREAMER_RX_RING_SIZE; i++) {
@@ -1808,6 +1878,64 @@
 #endif
 #endif
 
+#if STREAMER_IOCTL && (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+static int streamer_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+        int i;
+	struct streamer_private *streamer_priv = (struct streamer_private *) dev->priv;
+	u8 *streamer_mmio = streamer_priv->streamer_mmio;
+
+	switch(cmd) {
+	case IOCTL_SISR_MASK:
+		writew(SISR_MI, streamer_mmio + SISR_MASK_SUM);
+		break;
+	case IOCTL_SPIN_LOCK_TEST:
+	        printk(KERN_INFO "spin_lock() called.\n");
+		spin_lock(&streamer_priv->streamer_lock);
+		spin_unlock(&streamer_priv->streamer_lock);
+		printk(KERN_INFO "spin_unlock() finished.\n");
+		break;
+	case IOCTL_PRINT_BDAS:
+	        printk(KERN_INFO "bdas: RXBDA: %x RXLBDA: %x TX2FDA: %x TX2LFDA: %x\n",
+		       readw(streamer_mmio + RXBDA),
+		       readw(streamer_mmio + RXLBDA),
+		       readw(streamer_mmio + TX2FDA),
+		       readw(streamer_mmio + TX2LFDA));
+		break;
+	case IOCTL_PRINT_REGISTERS:
+	        printk(KERN_INFO "registers:\n");
+		printk(KERN_INFO "SISR: %04x MISR: %04x LISR: %04x BCTL: %04x BMCTL: %04x\nmask  %04x mask  %04x\n", 
+		       readw(streamer_mmio + SISR),
+		       readw(streamer_mmio + MISR_RUM),
+		       readw(streamer_mmio + LISR),
+		       readw(streamer_mmio + BCTL),
+		       readw(streamer_mmio + BMCTL_SUM),
+		       readw(streamer_mmio + SISR_MASK),
+		       readw(streamer_mmio + MISR_MASK));
+		break;
+	case IOCTL_PRINT_RX_BUFS:
+	        printk(KERN_INFO "Print rx bufs:\n");
+		for(i=0; i<STREAMER_RX_RING_SIZE; i++)
+		        printk(KERN_INFO "rx_ring %d status: 0x%x\n", i, 
+			       streamer_priv->streamer_rx_ring[i].status);
+		break;
+	case IOCTL_PRINT_TX_BUFS:
+	        printk(KERN_INFO "Print tx bufs:\n");
+		for(i=0; i<STREAMER_TX_RING_SIZE; i++)
+		        printk(KERN_INFO "tx_ring %d status: 0x%x\n", i, 
+			       streamer_priv->streamer_tx_ring[i].status);
+		break;
+	case IOCTL_RX_CMD:
+	        streamer_rx(dev);
+		printk(KERN_INFO "Sent rx command.\n");
+		break;
+	default:
+	        printk(KERN_INFO "Bad ioctl!\n");
+	}
+	return 0;
+}
+#endif
+
 static struct pci_driver streamer_pci_driver = {
   name:       "lanstreamer",
   id_table:   streamer_pci_tbl,
diff -urN linux-2.4.17.vanilla/drivers/net/tokenring/lanstreamer.h linux-2.4.17/drivers/net/tokenring/lanstreamer.h
--- linux-2.4.17.vanilla/drivers/net/tokenring/lanstreamer.h	Mon Feb  4 11:09:30 2002
+++ linux-2.4.17/drivers/net/tokenring/lanstreamer.h	Mon Feb  4 10:21:42 2002
@@ -56,11 +56,36 @@
  * 
  *  12/10/99 - Alpha Release 0.1.0
  *            First release to the public
+ *  08/15/01 - Added ioctl() definitions and others - Kent Yoder <yoder1@us.ibm.com>
  *
  */
 
+#if STREAMER_IOCTL && (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+#include <asm/ioctl.h>
+#define IOCTL_PRINT_RX_BUFS   SIOCDEVPRIVATE
+#define IOCTL_PRINT_TX_BUFS   SIOCDEVPRIVATE+1
+#define IOCTL_RX_CMD          SIOCDEVPRIVATE+2
+#define IOCTL_TX_CMD          SIOCDEVPRIVATE+3
+#define IOCTL_PRINT_REGISTERS SIOCDEVPRIVATE+4
+#define IOCTL_PRINT_BDAS      SIOCDEVPRIVATE+5
+#define IOCTL_SPIN_LOCK_TEST  SIOCDEVPRIVATE+6
+#define IOCTL_SISR_MASK       SIOCDEVPRIVATE+7
+#endif
+
+/* MAX_INTR - the maximum number of times we can loop
+ * inside the interrupt function before returning
+ * control to the OS (maximum value is 256)
+ */
+#define MAX_INTR 5
+
+#define CLS 0x0C
+#define MLR 0x86
+#define LTR 0x0D
+
 #define BCTL 0x60
 #define BCTL_SOFTRESET (1<<15)
+#define BCTL_RX_FIFO_8 (1<<1)
+#define BCTL_TX_FIFO_8 (1<<3)
 
 #define GPR 0x4a
 #define GPR_AUTOSENSE (1<<2)
@@ -89,6 +114,7 @@
 #define SISR_MASK_RUM 0x58
 
 #define SISR_MI (1<<15)
+#define SISR_SERR_ERR (1<<14)
 #define SISR_TIMER (1<<11)
 #define SISR_LAP_PAR_ERR (1<<10)
 #define SISR_LAP_ACC_ERR (1<<9)
@@ -218,7 +244,13 @@
 /* Streamer defaults for buffers */
 
 #define STREAMER_RX_RING_SIZE 16	/* should be a power of 2 */
-#define STREAMER_TX_RING_SIZE 8	/* should be a power of 2 */
+/* Setting the number of TX descriptors to 1 is a workaround for an
+ * undocumented hardware problem with the lanstreamer board. Setting
+ * this to something higher may slightly increase the throughput you
+ * can get from the card, but at the risk of locking up the box. - 
+ * <yoder1@us.ibm.com>
+ */
+#define STREAMER_TX_RING_SIZE 1	/* should be a power of 2 */
 
 #define PKT_BUF_SZ 4096		/* Default packet size */
 

