Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSLGW7T>; Sat, 7 Dec 2002 17:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbSLGW7T>; Sat, 7 Dec 2002 17:59:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10760 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264863AbSLGW7Q>;
	Sat, 7 Dec 2002 17:59:16 -0500
Message-ID: <3DF27EE7.4010508@pobox.com>
Date: Sat, 07 Dec 2002 18:06:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Andrew Morton <akpm@digeo.com>
Subject: [RFC][PATCH] net drivers and cache alignment
References: <3DF2781D.3030209@pobox.com> <20021207.144004.45605764.davem@redhat.com>
In-Reply-To: <20021207.144004.45605764.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------080805080000030003020904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080805080000030003020904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> Can't the cacheline_aligned attribute be applied to individual
> struct members?  I remember doing this for thread_struct on
> sparc ages ago.


Looks like it from the 2.4 processor.h code.

Attached is cut #2.  Thanks for all the near-instant feedback so far :) 
  Andrew, does the attached still need padding on SMP?

--------------080805080000030003020904
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/tg3.c 1.41 vs edited =====
--- 1.41/drivers/net/tg3.c	Wed Nov 20 00:49:23 2002
+++ edited/drivers/net/tg3.c	Sat Dec  7 17:12:38 2002
@@ -25,6 +25,7 @@
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
+#include <linux/cache.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
===== drivers/net/tg3.h 1.19 vs edited =====
--- 1.19/drivers/net/tg3.h	Mon Nov 11 05:27:52 2002
+++ edited/drivers/net/tg3.h	Sat Dec  7 18:01:08 2002
@@ -1728,6 +1728,8 @@
 };
 
 struct tg3 {
+	/* begin "general, frequently-used members" cacheline section */
+
 	/* SMP locking strategy:
 	 *
 	 * lock: Held during all operations except TX packet
@@ -1740,20 +1742,63 @@
 	 * be disabled to take 'lock' but only softirq disabling is
 	 * necessary for acquisition of 'tx_lock'.
 	 */
-	spinlock_t			lock;
-	spinlock_t			tx_lock;
+	spinlock_t			lock ____cacheline_aligned;
+	spinlock_t			indirect_lock;
 
-	u32				tx_prod;
+	unsigned long			regs;
+	struct net_device		*dev;
+	struct pci_dev			*pdev;
+
+	struct tg3_hw_status		*hw_status;
+	dma_addr_t			status_mapping;
+
+	u32				msg_enable;
+
+	/* begin "tx thread" cacheline section */
+	u32				tx_prod ____cacheline_aligned;
 	u32				tx_cons;
-	u32				rx_rcb_ptr;
+	u32				tx_pending;
+
+	spinlock_t			tx_lock;
+
+	/* TX descs are only used if TG3_FLAG_HOST_TXDS is set. */
+	struct tg3_tx_buffer_desc	*tx_ring;
+	struct tx_ring_info		*tx_buffers;
+	dma_addr_t			tx_desc_mapping;
+
+	/* begin "rx thread" cacheline section */
+	u32				rx_rcb_ptr ____cacheline_aligned;
 	u32				rx_std_ptr;
 	u32				rx_jumbo_ptr;
 #if TG3_MINI_RING_WORKS
 	u32				rx_mini_ptr;
 #endif
-	spinlock_t			indirect_lock;
+	u32				rx_pending;
+#if TG3_MINI_RING_WORKS
+	u32				rx_mini_pending;
+#endif
+	u32				rx_jumbo_pending;
+#if TG3_VLAN_TAG_USED
+	struct vlan_group		*vlgrp;
+#endif
+
+	struct tg3_rx_buffer_desc	*rx_std;
+	struct ring_info		*rx_std_buffers;
+	dma_addr_t			rx_std_mapping;
+#if TG3_MINI_RING_WORKS
+	struct tg3_rx_buffer_desc	*rx_mini;
+	struct ring_info		*rx_mini_buffers;
+	dma_addr_t			rx_mini_mapping;
+#endif
+	struct tg3_rx_buffer_desc	*rx_jumbo;
+	struct ring_info		*rx_jumbo_buffers;
+	dma_addr_t			rx_jumbo_mapping;
 
-	struct net_device_stats		net_stats;
+	struct tg3_rx_buffer_desc	*rx_rcb;
+	dma_addr_t			rx_rcb_mapping;
+
+	/* begin "everything else" cacheline(s) section */
+	struct net_device_stats		net_stats ____cacheline_aligned;
 	struct net_device_stats		net_stats_prev;
 	unsigned long			phy_crc_errors;
 
@@ -1791,8 +1836,6 @@
 #define TG3_FLAG_SPLIT_MODE		0x40000000
 #define TG3_FLAG_INIT_COMPLETE		0x80000000
 
-	u32				msg_enable;
-
 	u32				split_mode_max_reqs;
 #define SPLIT_MODE_5704_MAX_REQ		3
 
@@ -1806,13 +1849,6 @@
 	struct tg3_link_config		link_config;
 	struct tg3_bufmgr_config	bufmgr_config;
 
-	u32				rx_pending;
-#if TG3_MINI_RING_WORKS
-	u32				rx_mini_pending;
-#endif
-	u32				rx_jumbo_pending;
-	u32				tx_pending;
-
 	/* cache h/w values, often passed straight to h/w */
 	u32				rx_mode;
 	u32				tx_mode;
@@ -1864,36 +1900,6 @@
 	 (X) == PHY_ID_BCM5411 || (X) == PHY_ID_BCM5701 || \
 	 (X) == PHY_ID_BCM5703 || (X) == PHY_ID_BCM5704 || \
 	 (X) == PHY_ID_BCM8002 || (X) == PHY_ID_SERDES)
-
-	unsigned long			regs;
-	struct pci_dev			*pdev;
-	struct net_device		*dev;
-#if TG3_VLAN_TAG_USED
-	struct vlan_group		*vlgrp;
-#endif
-
-	struct tg3_rx_buffer_desc	*rx_std;
-	struct ring_info		*rx_std_buffers;
-	dma_addr_t			rx_std_mapping;
-#if TG3_MINI_RING_WORKS
-	struct tg3_rx_buffer_desc	*rx_mini;
-	struct ring_info		*rx_mini_buffers;
-	dma_addr_t			rx_mini_mapping;
-#endif
-	struct tg3_rx_buffer_desc	*rx_jumbo;
-	struct ring_info		*rx_jumbo_buffers;
-	dma_addr_t			rx_jumbo_mapping;
-
-	struct tg3_rx_buffer_desc	*rx_rcb;
-	dma_addr_t			rx_rcb_mapping;
-
-	/* TX descs are only used if TG3_FLAG_HOST_TXDS is set. */
-	struct tg3_tx_buffer_desc	*tx_ring;
-	struct tx_ring_info		*tx_buffers;
-	dma_addr_t			tx_desc_mapping;
-
-	struct tg3_hw_status		*hw_status;
-	dma_addr_t			status_mapping;
 
 	struct tg3_hw_stats		*hw_stats;
 	dma_addr_t			stats_mapping;

--------------080805080000030003020904--

