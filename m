Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268709AbUJDXAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbUJDXAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268697AbUJDW7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:59:31 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:49928 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268685AbUJDWzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:55:44 -0400
Date: Mon, 4 Oct 2004 23:55:43 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.8.1: Fix struct fddi_statistics for 64-bit
Message-ID: <Pine.LNX.4.58L.0410040127280.22545@blysk.ds.pg.gda.pl>
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

 This is the updated patch for 2.6.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-2.6.8.1-fddi-stats-1
diff -up --recursive --new-file linux-2.6.8.1.macro/drivers/net/defxx.c linux-2.6.8.1/drivers/net/defxx.c
--- linux-2.6.8.1.macro/drivers/net/defxx.c	2004-08-14 10:54:46.000000000 +0000
+++ linux-2.6.8.1/drivers/net/defxx.c	2004-10-03 22:24:12.000000000 +0000
@@ -1814,16 +1814,18 @@ static struct net_device_stats *dfx_ctl_
 
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
 
diff -up --recursive --new-file linux-2.6.8.1.macro/drivers/net/skfp/skfddi.c linux-2.6.8.1/drivers/net/skfp/skfddi.c
--- linux-2.6.8.1.macro/drivers/net/skfp/skfddi.c	2004-08-14 10:54:48.000000000 +0000
+++ linux-2.6.8.1/drivers/net/skfp/skfddi.c	2004-10-03 22:24:12.000000000 +0000
@@ -1095,7 +1095,7 @@ static int skfp_send_pkt(struct sk_buff 
 	 */
 
 	if (!(skb->len >= FDDI_K_LLC_ZLEN && skb->len <= FDDI_K_LLC_LEN)) {
-		bp->MacStat.tx_errors++;	/* bump error counter */
+		bp->MacStat.gen.tx_errors++;	/* bump error counter */
 		// dequeue packets from xmt queue and send them
 		netif_start_queue(dev);
 		dev_kfree_skb(skb);
@@ -1546,8 +1546,8 @@ void mac_drv_tx_complete(struct s_smc *s
 			 skb->len, PCI_DMA_TODEVICE);
 	txd->txd_os.dma_addr = 0;
 
-	smc->os.MacStat.tx_packets++;	// Count transmitted packets.
-	smc->os.MacStat.tx_bytes+=skb->len;	// Count bytes
+	smc->os.MacStat.gen.tx_packets++;	// Count transmitted packets.
+	smc->os.MacStat.gen.tx_bytes+=skb->len;	// Count bytes
 
 	// free the skb
 	dev_kfree_skb_irq(skb);
@@ -1629,7 +1629,7 @@ void mac_drv_rx_complete(struct s_smc *s
 	skb = rxd->rxd_os.skb;
 	if (!skb) {
 		PRINTK(KERN_INFO "No skb in rxd\n");
-		smc->os.MacStat.rx_errors++;
+		smc->os.MacStat.gen.rx_errors++;
 		goto RequeueRxd;
 	}
 	virt = skb->data;
@@ -1682,13 +1682,14 @@ void mac_drv_rx_complete(struct s_smc *s
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
@@ -1706,7 +1707,8 @@ void mac_drv_rx_complete(struct s_smc *s
       RequeueRxd:
 	PRINTK(KERN_INFO "Rx: re-queue RXD.\n");
 	mac_drv_requeue_rxd(smc, rxd, frag_count);
-	smc->os.MacStat.rx_errors++;	// Count receive packets not indicated.
+	smc->os.MacStat.gen.rx_errors++;	// Count receive packets
+						// not indicated.
 
 }				// mac_drv_rx_complete
 
@@ -2081,7 +2083,7 @@ void smt_stat_counter(struct s_smc *smc,
 		break;
 	case 1:
 		PRINTK(KERN_INFO "Receive fifo overflow.\n");
-		smc->os.MacStat.rx_errors++;
+		smc->os.MacStat.gen.rx_errors++;
 		break;
 	default:
 		PRINTK(KERN_INFO "Unknown status (%d).\n", stat);
diff -up --recursive --new-file linux-2.6.8.1.macro/include/linux/if_fddi.h linux-2.6.8.1/include/linux/if_fddi.h
--- linux-2.6.8.1.macro/include/linux/if_fddi.h	2004-08-14 10:55:32.000000000 +0000
+++ linux-2.6.8.1/include/linux/if_fddi.h	2004-10-03 22:24:12.000000000 +0000
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
