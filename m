Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbULMWNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbULMWNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbULMWNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:13:31 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:32408 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S261200AbULMWMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:12:41 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 13 Dec 2004 15:12:40 -0700
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: [PATCH 1/6] mv643xx_eth: remove redundant/useless code
Message-ID: <20041213221240.GA19951@xyzzy>
References: <20041213220949.GA19609@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213220949.GA19609@xyzzy>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes code that is redundant or useless.
The biggest area is in pre-initializing the RX and TX descriptor
rings, which only obfuscates the driver since the ring data is
overwritten without being used.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.c	2004-12-10 15:24:13.000000000 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c	2004-12-13 14:29:54.292321344 -0700
@@ -24,31 +24,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
-#include <linux/config.h>
-#include <linux/version.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/config.h>
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <linux/fcntl.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/ip.h>
 #include <linux/init.h>
-#include <linux/in.h>
-#include <linux/pci.h>
-#include <linux/workqueue.h>
-#include <asm/smp.h>
-#include <linux/skbuff.h>
 #include <linux/tcp.h>
-#include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <net/ip.h>
-
 #include <linux/bitops.h>
 #include <asm/io.h>
 #include <asm/types.h>
@@ -387,10 +365,9 @@
  * Output : number of served packets
  */
 #ifdef MV64340_NAPI
-static int mv64340_eth_receive_queue(struct net_device *dev, unsigned int max,
-								int budget)
+static int mv64340_eth_receive_queue(struct net_device *dev, int budget)
 #else
-static int mv64340_eth_receive_queue(struct net_device *dev, unsigned int max)
+static int mv64340_eth_receive_queue(struct net_device *dev)
 #endif
 {
 	struct mv64340_private *mp = netdev_priv(dev);
@@ -402,7 +379,7 @@
 #ifdef MV64340_NAPI
 	while (eth_port_receive(mp, &pkt_info) == ETH_OK && budget > 0) {
 #else
-	while ((--max) && eth_port_receive(mp, &pkt_info) == ETH_OK) {
+	while (eth_port_receive(mp, &pkt_info) == ETH_OK) {
 #endif
 		mp->rx_ring_skbs--;
 		received_packets++;
@@ -661,7 +638,7 @@
 {
 	struct mv64340_private *mp = netdev_priv(dev);
 	unsigned int port_num = mp->port_num;
-	int err = err;
+	int err;
 
 	spin_lock_irq(&mp->lock);
 
@@ -708,56 +685,25 @@
  *
  * INPUT:
  *	struct mv64340_private   *mp   Ethernet Port Control srtuct. 
- *      int 			rx_desc_num       Number of Rx descriptors
- *      int 			rx_buff_size      Size of Rx buffer
- *      unsigned int    rx_desc_base_addr  Rx descriptors memory area base addr.
- *      unsigned int    rx_buff_base_addr  Rx buffer memory area base addr.
  *
  * OUTPUT:
  *      The routine updates the Ethernet port control struct with information 
  *      regarding the Rx descriptors and buffers.
  *
  * RETURN:
- *      false if the given descriptors memory area is not aligned according to
- *      Ethernet SDMA specifications.
- *      true otherwise.
+ *      None.
  */
-static int ether_init_rx_desc_ring(struct mv64340_private * mp,
-	unsigned long rx_buff_base_addr)
+static void ether_init_rx_desc_ring(struct mv64340_private * mp)
 {
-	unsigned long buffer_addr = rx_buff_base_addr;
 	volatile struct eth_rx_desc *p_rx_desc;
 	int rx_desc_num = mp->rx_ring_size;
-	unsigned long rx_desc_base_addr = (unsigned long) mp->p_rx_desc_area;
-	int rx_buff_size = 1536;	/* Dummy, will be replaced later */
 	int i;
 
-	p_rx_desc = (struct eth_rx_desc *) rx_desc_base_addr;
-
-	/* Rx desc Must be 4LW aligned (i.e. Descriptor_Address[3:0]=0000). */
-	if (rx_buff_base_addr & 0xf)
-		return 0;
-
-	/* Rx buffers are limited to 64K bytes and Minimum size is 8 bytes  */
-	if ((rx_buff_size < 8) || (rx_buff_size > RX_BUFFER_MAX_SIZE))
-		return 0;
-
-	/* Rx buffers must be 64-bit aligned.       */
-	if ((rx_buff_base_addr + rx_buff_size) & 0x7)
-		return 0;
-
-	/* initialize the Rx descriptors ring */
+	/* initialize the next_desc_ptr links in the Rx descriptors ring */
+	p_rx_desc = (struct eth_rx_desc *) mp->p_rx_desc_area;
 	for (i = 0; i < rx_desc_num; i++) {
-		p_rx_desc[i].buf_size = rx_buff_size;
-		p_rx_desc[i].byte_cnt = 0x0000;
-		p_rx_desc[i].cmd_sts =
-			ETH_BUFFER_OWNED_BY_DMA | ETH_RX_ENABLE_INTERRUPT;
 		p_rx_desc[i].next_desc_ptr = mp->rx_desc_dma +
 			((i + 1) % rx_desc_num) * sizeof(struct eth_rx_desc);
-		p_rx_desc[i].buf_ptr = buffer_addr;
-
-		mp->rx_skb[i] = NULL;
-		buffer_addr += rx_buff_size;
 	}
 
 	/* Save Rx desc pointer to driver struct. */
@@ -766,9 +712,8 @@
 
 	mp->rx_desc_area_size = rx_desc_num * sizeof(struct eth_rx_desc);
 
+	/* Add the queue to the list of RX queues of this port */
 	mp->port_rx_queue_command |= 1;
-
-	return 1;
 }
 
 /*
@@ -785,57 +730,37 @@
  *
  * INPUT:
  *	struct mv64340_private   *mp   Ethernet Port Control srtuct. 
- *      int 		tx_desc_num        Number of Tx descriptors
- *      int 		tx_buff_size	   Size of Tx buffer
- *      unsigned int    tx_desc_base_addr  Tx descriptors memory area base addr.
  *
  * OUTPUT:
  *      The routine updates the Ethernet port control struct with information 
  *      regarding the Tx descriptors and buffers.
  *
  * RETURN:
- *      false if the given descriptors memory area is not aligned according to
- *      Ethernet SDMA specifications.
- *      true otherwise.
+ *      None.
  */
-static int ether_init_tx_desc_ring(struct mv64340_private *mp)
+static void ether_init_tx_desc_ring(struct mv64340_private *mp)
 {
-	unsigned long tx_desc_base_addr = (unsigned long) mp->p_tx_desc_area;
 	int tx_desc_num = mp->tx_ring_size;
 	struct eth_tx_desc *p_tx_desc;
 	int i;
 
-	/* Tx desc Must be 4LW aligned (i.e. Descriptor_Address[3:0]=0000). */
-	if (tx_desc_base_addr & 0xf)
-		return 0;
-
-	/* save the first desc pointer to link with the last descriptor */
-	p_tx_desc = (struct eth_tx_desc *) tx_desc_base_addr;
-
-	/* Initialize the Tx descriptors ring */
+	/* Initialize the next_desc_ptr links in the Tx descriptors ring */
+	p_tx_desc = (struct eth_tx_desc *) mp->p_tx_desc_area;
 	for (i = 0; i < tx_desc_num; i++) {
-		p_tx_desc[i].byte_cnt	= 0x0000;
-		p_tx_desc[i].l4i_chk	= 0x0000;
-		p_tx_desc[i].cmd_sts	= 0x00000000;
 		p_tx_desc[i].next_desc_ptr = mp->tx_desc_dma +
 			((i + 1) % tx_desc_num) * sizeof(struct eth_tx_desc);
-		p_tx_desc[i].buf_ptr	= 0x00000000;
-		mp->tx_skb[i]		= NULL;
 	}
 
-	/* Set Tx desc pointer in driver struct. */
 	mp->tx_curr_desc_q = 0;
 	mp->tx_used_desc_q = 0;
 #ifdef MV64340_CHECKSUM_OFFLOAD_TX
         mp->tx_first_desc_q = 0;
 #endif
-	/* Init Tx ring base and size parameters */
+
 	mp->tx_desc_area_size	= tx_desc_num * sizeof(struct eth_tx_desc);
 
 	/* Add the queue to the list of Tx queues of this port */
 	mp->port_tx_queue_command |= 1;
-
-	return 1;
 }
 
 /* Helper function for mv64340_eth_open */
@@ -917,8 +842,7 @@
 	}
 	memset(mp->p_rx_desc_area, 0, size);
 
-	if (!(ether_init_rx_desc_ring(mp, 0)))
-		panic("%s: Error initializing RX Ring", dev->name);
+	ether_init_rx_desc_ring(mp);
 
 	mv64340_eth_rx_task(dev);	/* Fill RX ring with skb's */
 
@@ -1112,7 +1036,7 @@
 		orig_budget = *budget;
 		if (orig_budget > dev->quota)
 			orig_budget = dev->quota;
-		work_done = mv64340_eth_receive_queue(dev, 0, orig_budget);
+		work_done = mv64340_eth_receive_queue(dev, orig_budget);
 		mp->rx_task.func(dev);
 		*budget -= work_done;
 		dev->quota -= work_done;
@@ -1403,8 +1327,6 @@
 
 static void mv64340_eth_remove(struct net_device *dev)
 {
-	struct mv64340_private *mp = netdev_priv(dev);
-
 	unregister_netdev(dev);
 	flush_scheduled_work();
 	free_netdev(dev);
@@ -1627,18 +1549,6 @@
 #define ETH_ENABLE_TX_QUEUE(eth_port) \
 	MV_WRITE(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(eth_port), 1)
 
-#define ETH_DISABLE_TX_QUEUE(eth_port) \
-	MV_WRITE(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(eth_port),	\
-	         (1 << 8))
-
-#define ETH_ENABLE_RX_QUEUE(rx_queue, eth_port) \
-	MV_WRITE(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(eth_port),	\
-	         (1 << rx_queue))
-
-#define ETH_DISABLE_RX_QUEUE(rx_queue, eth_port) \
-	MV_WRITE(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(eth_port),	\
-	         (1 << (8 + rx_queue)))
-
 #define LINK_UP_TIMEOUT		100000
 #define PHY_BUSY_TIMEOUT	10000000
 
