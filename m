Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUJDW6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUJDW6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUJDW6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:58:11 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40968 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268683AbUJDWze
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:55:34 -0400
Date: Mon, 4 Oct 2004 23:55:33 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.27: Fix struct fddi_statistics for 64-bit
Message-ID: <Pine.LNX.4.58L.0410032238410.22545@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 There is a problem with "struct fddi_statistics" for 64-bit systems.  
The starting members of the struct are expected to correspond to the
respective members of "struct net_device_stats" (drivers for FDDI devices
return "struct fddi_statistics" in the response to the get_stats() call of
"struct net_device").  Unfortunately, due to using different types (u32 vs
ulong) they do not.  "struct net_device_stats" is a public interface and
as a result, bogus results are retrieved, e.g. for /proc/net/dev.

 Here is my proposal to address the problem.  I think there is no point in
duplicating the layout of "struct net_device_stats" in "struct
fddi_statistics" as the former can simply be included as a member avoiding
this problem and actually any possible discrepancy in the future.  This 
also preserves the layout of the structure for 32-bit systems.

 This was run-time tested with 2.4.26 using the defxx driver in a 64-bit 
MIPSel system.  All affected drivers were compiled successfully with 
2.4.27 and 2.6.8.1.

 The patch applies both to 2.4 and 2.6, but one of the affected drivers
has been removed from 2.6 leading to a reject.  Therefore I'll send an 
updated patch for 2.6 separately.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-2.4.27-fddi-stats-1
diff -up --recursive --new-file linux-2.4.27.macro/drivers/message/i2o/i2o_lan.c linux-2.4.27/drivers/message/i2o/i2o_lan.c
--- linux-2.4.27.macro/drivers/message/i2o/i2o_lan.c	2002-08-12 18:55:51.000000000 +0000
+++ linux-2.4.27/drivers/message/i2o/i2o_lan.c	2004-10-03 21:12:32.000000000 +0000
@@ -1043,13 +1043,13 @@ static struct net_device_stats *i2o_lan_
 		printk(KERN_INFO "%s: Unable to query LAN_HISTORICAL_STATS.\n", dev->name);
 	else {
 		dprintk(KERN_DEBUG "%s: LAN_HISTORICAL_STATS queried.\n", dev->name);
-		priv->stats.tx_packets = val64[0];
-		priv->stats.tx_bytes   = val64[1];
-		priv->stats.rx_packets = val64[2];
-		priv->stats.rx_bytes   = val64[3];
-		priv->stats.tx_errors  = val64[4];
-		priv->stats.rx_errors  = val64[5];
-		priv->stats.rx_dropped = val64[6];
+		priv->stats.gen.tx_packets = val64[0];
+		priv->stats.gen.tx_bytes   = val64[1];
+		priv->stats.gen.rx_packets = val64[2];
+		priv->stats.gen.rx_bytes   = val64[3];
+		priv->stats.gen.tx_errors  = val64[4];
+		priv->stats.gen.rx_errors  = val64[5];
+		priv->stats.gen.rx_dropped = val64[6];
 	}
 
 	if (i2o_query_scalar(iop, i2o_dev->lct_data.tid, 0x0180, -1,
@@ -1062,9 +1062,9 @@ static struct net_device_stats *i2o_lan_
 			printk(KERN_INFO "%s: Unable to query LAN_OPTIONAL_RX_HISTORICAL_STATS.\n", dev->name);
 		else {
 			dprintk(KERN_DEBUG "%s: LAN_OPTIONAL_RX_HISTORICAL_STATS queried.\n", dev->name);
-			priv->stats.multicast	     = val64[4];
-			priv->stats.rx_length_errors = val64[10];
-			priv->stats.rx_crc_errors    = val64[0];
+			priv->stats.gen.multicast        = val64[4];
+			priv->stats.gen.rx_length_errors = val64[10];
+			priv->stats.gen.rx_crc_errors    = val64[0];
 		}
 	}
 
@@ -1075,9 +1075,9 @@ static struct net_device_stats *i2o_lan_
 			printk(KERN_INFO "%s: Unable to query LAN_802_3_HISTORICAL_STATS.\n", dev->name);
 		else {
 			dprintk(KERN_DEBUG "%s: LAN_802_3_HISTORICAL_STATS queried.\n", dev->name);
-	 		priv->stats.transmit_collision = val64[1] + val64[2];
-			priv->stats.rx_frame_errors    = val64[0];
-			priv->stats.tx_carrier_errors  = val64[6];
+	 		priv->stats.gen.collisions        = val64[1] + val64[2];
+			priv->stats.gen.rx_frame_errors   = val64[0];
+			priv->stats.gen.tx_carrier_errors = val64[6];
 		}
 
 		if (i2o_query_scalar(iop, i2o_dev->lct_data.tid, 0x0280, -1,
@@ -1091,9 +1091,11 @@ static struct net_device_stats *i2o_lan_
 			else {
 				dprintk(KERN_DEBUG "%s: LAN_OPTIONAL_802_3_HISTORICAL_STATS queried.\n", dev->name);
 				if (supported_stats & 0x1)
-					priv->stats.rx_over_errors = val64[0];
+					priv->stats.gen.rx_over_errors =
+								val64[0];
 				if (supported_stats & 0x4)
-					priv->stats.tx_heartbeat_errors = val64[2];
+					priv->stats.gen.tx_heartbeat_errors =
+								val64[2];
 			}
 		}
 	}
diff -up --recursive --new-file linux-2.4.27.macro/drivers/net/defxx.c linux-2.4.27/drivers/net/defxx.c
--- linux-2.4.27.macro/drivers/net/defxx.c	2004-09-29 00:03:33.000000000 +0000
+++ linux-2.4.27/drivers/net/defxx.c	2004-10-03 21:31:16.000000000 +0000
@@ -1809,16 +1809,18 @@ static struct net_device_stats *dfx_ctl_
 
 	/* Fill the bp->stats structure with driver-maintained counters */
 
-	bp->stats.rx_packets			= bp->rcv_total_frames;
-	bp->stats.tx_packets			= bp->xmt_total_frames;
-	bp->stats.rx_bytes			= bp->rcv_total_bytes;
-	bp->stats.tx_bytes			= bp->xmt_total_bytes;
-	bp->stats.rx_errors				= (u32)(bp->rcv_crc_errors + bp->rcv_frame_status_errors + bp->rcv_length_errors);
-	bp->stats.tx_errors				= bp->xmt_length_errors;
-	bp->stats.rx_dropped			= bp->rcv_discards;
-	bp->stats.tx_dropped			= bp->xmt_discards;
-	bp->stats.multicast				= bp->rcv_multicast_frames;
-	bp->stats.transmit_collision	= 0;	/* always zero (0) for FDDI */
+	bp->stats.gen.rx_packets = bp->rcv_total_frames;
+	bp->stats.gen.tx_packets = bp->xmt_total_frames;
+	bp->stats.gen.rx_bytes   = bp->rcv_total_bytes;
+	bp->stats.gen.tx_bytes   = bp->xmt_total_bytes;
+	bp->stats.gen.rx_errors  = bp->rcv_crc_errors +
+				   bp->rcv_frame_status_errors +
+				   bp->rcv_length_errors;
+	bp->stats.gen.tx_errors  = bp->xmt_length_errors;
+	bp->stats.gen.rx_dropped = bp->rcv_discards;
+	bp->stats.gen.tx_dropped = bp->xmt_discards;
+	bp->stats.gen.multicast  = bp->rcv_multicast_frames;
+	bp->stats.gen.collisions = 0;		/* always zero (0) for FDDI */
 
 	/* Get FDDI SMT MIB objects */
 
diff -up --recursive --new-file linux-2.4.27.macro/drivers/net/skfp/skfddi.c linux-2.4.27/drivers/net/skfp/skfddi.c
--- linux-2.4.27.macro/drivers/net/skfp/skfddi.c	2002-08-12 18:55:55.000000000 +0000
+++ linux-2.4.27/drivers/net/skfp/skfddi.c	2004-10-03 21:04:51.000000000 +0000
@@ -1363,7 +1363,7 @@ static int skfp_send_pkt(struct sk_buff 
 	 */
 
 	if (!(skb->len >= FDDI_K_LLC_ZLEN && skb->len <= FDDI_K_LLC_LEN)) {
-		bp->MacStat.tx_errors++;	/* bump error counter */
+		bp->MacStat.gen.tx_errors++;	/* bump error counter */
 		// dequeue packets from xmt queue and send them
 		netif_start_queue(dev);
 		dev_kfree_skb(skb);
@@ -1814,8 +1814,8 @@ void mac_drv_tx_complete(struct s_smc *s
 			 skb->len, PCI_DMA_TODEVICE);
 	txd->txd_os.dma_addr = 0;
 
-	smc->os.MacStat.tx_packets++;	// Count transmitted packets.
-	smc->os.MacStat.tx_bytes+=skb->len;	// Count bytes
+	smc->os.MacStat.gen.tx_packets++;	// Count transmitted packets.
+	smc->os.MacStat.gen.tx_bytes+=skb->len;	// Count bytes
 
 	// free the skb
 	dev_kfree_skb_irq(skb);
@@ -1897,7 +1897,7 @@ void mac_drv_rx_complete(struct s_smc *s
 	skb = rxd->rxd_os.skb;
 	if (!skb) {
 		PRINTK(KERN_INFO "No skb in rxd\n");
-		smc->os.MacStat.rx_errors++;
+		smc->os.MacStat.gen.rx_errors++;
 		goto RequeueRxd;
 	}
 	virt = skb->data;
@@ -1950,13 +1950,14 @@ void mac_drv_rx_complete(struct s_smc *s
 	}
 
 	// Count statistics.
-	smc->os.MacStat.rx_packets++;	// Count indicated receive packets.
-	smc->os.MacStat.rx_bytes+=len;	// Count bytes
+	smc->os.MacStat.gen.rx_packets++;	// Count indicated receive
+						// packets.
+	smc->os.MacStat.gen.rx_bytes+=len;	// Count bytes.
 
 	// virt points to header again
 	if (virt[1] & 0x01) {	// Check group (multicast) bit.
 
-		smc->os.MacStat.multicast++;
+		smc->os.MacStat.gen.multicast++;
 	}
 
 	// deliver frame to system
@@ -1974,7 +1975,8 @@ void mac_drv_rx_complete(struct s_smc *s
       RequeueRxd:
 	PRINTK(KERN_INFO "Rx: re-queue RXD.\n");
 	mac_drv_requeue_rxd(smc, rxd, frag_count);
-	smc->os.MacStat.rx_errors++;	// Count receive packets not indicated.
+	smc->os.MacStat.gen.rx_errors++;	// Count receive packets
+						// not indicated.
 
 }				// mac_drv_rx_complete
 
@@ -2349,7 +2351,7 @@ void smt_stat_counter(struct s_smc *smc,
 		break;
 	case 1:
 		PRINTK(KERN_INFO "Receive fifo overflow.\n");
-		smc->os.MacStat.rx_errors++;
+		smc->os.MacStat.gen.rx_errors++;
 		break;
 	default:
 		PRINTK(KERN_INFO "Unknown status (%d).\n", stat);
diff -up --recursive --new-file linux-2.4.27.macro/include/linux/if_fddi.h linux-2.4.27/include/linux/if_fddi.h
--- linux-2.4.27.macro/include/linux/if_fddi.h	1999-06-02 19:29:13.000000000 +0000
+++ linux-2.4.27/include/linux/if_fddi.h	2004-10-03 21:01:28.000000000 +0000
@@ -5,7 +5,7 @@
  *
  *		Global definitions for the ANSI FDDI interface.
  *
- * Version:	@(#)if_fddi.h	1.0.1	09/16/96
+ * Version:	@(#)if_fddi.h	1.0.2	Sep 29 2004
  *
  * Author:	Lawrence V. Stefani, <stefani@lkg.dec.com>
  *
@@ -103,38 +103,12 @@ struct fddihdr
 	} __attribute__ ((packed));
 
 /* Define FDDI statistics structure */
-struct fddi_statistics
-	{
-	__u32	rx_packets;				/* total packets received */
-	__u32	tx_packets;				/* total packets transmitted */
-	__u32	rx_bytes;				/* total bytes received	*/
-	__u32	tx_bytes;				/* total bytes transmitted */
-	__u32	rx_errors;				/* bad packets received	*/
-	__u32	tx_errors;				/* packet transmit problems	*/
-	__u32	rx_dropped;				/* no space in linux buffers */
-	__u32	tx_dropped;				/* no space available in linux */
-	__u32	multicast;				/* multicast packets received */
-	__u32	transmit_collision;		/* always 0 for FDDI */
-
-	/* detailed rx_errors */
-	__u32	rx_length_errors;
-	__u32	rx_over_errors;		/* receiver ring buff overflow	*/
-	__u32	rx_crc_errors;		/* recved pkt with crc error	*/
-	__u32	rx_frame_errors;	/* recv'd frame alignment error */
-	__u32	rx_fifo_errors;		/* recv'r fifo overrun		*/
-	__u32	rx_missed_errors;	/* receiver missed packet	*/
-
-	/* detailed tx_errors */
-	__u32	tx_aborted_errors;
-	__u32	tx_carrier_errors;
-	__u32	tx_fifo_errors;
-	__u32	tx_heartbeat_errors;
-	__u32	tx_window_errors;
-	
-	/* for cslip etc */
-	__u32	rx_compressed;
-	__u32	tx_compressed;
-   
+struct fddi_statistics {
+
+	/* Generic statistics. */
+
+	struct net_device_stats gen;
+
 	/* Detailed FDDI statistics.  Adopted from RFC 1512 */
 
 	__u8	smt_station_id[8];
