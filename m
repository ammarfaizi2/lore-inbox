Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSLGWbR>; Sat, 7 Dec 2002 17:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbSLGWbQ>; Sat, 7 Dec 2002 17:31:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54279 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264839AbSLGWaT>;
	Sat, 7 Dec 2002 17:30:19 -0500
Message-ID: <3DF2781D.3030209@pobox.com>
Date: Sat, 07 Dec 2002 17:37:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
CC: "David S. Miller" <davem@redhat.com>
Subject: [RFC][PATCH] net drivers and cache alignment
Content-Type: multipart/mixed;
 boundary="------------070601080505050708040803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070601080505050708040803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

One of the [many] nice properties of the traditional Don Becker drivers 
has been that often the driver-private structures are arranged such that 
  the structure is broken up on cacheline boundaries.  The RX thread has 
a cacheline, the TX thread has a cacheline, etc.  Jes Sorensen also 
independently, in his review of 8139cp.c, suggested that the 
driver-private struct be update with attention to cacheline boundaries.

Early next year, I would like to start cleaning up some of the net 
drivers along these lines (no pun intended).  To make it easier for 
vendors and random coders to cacheline-align struct members, I would 
like to make more explicit these cacheline boundaries, in a manner that 
is portable between 32-bit and 64-bit systems.

I attach a sample implementation, and request feedback on this approach. 
   The general idea is to make implementing this sort of concept "harder 
to screw up."

--------------070601080505050708040803
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
+++ edited/drivers/net/tg3.h	Sat Dec  7 17:20:25 2002
@@ -1741,17 +1741,66 @@
 	 * necessary for acquisition of 'tx_lock'.
 	 */
 	spinlock_t			lock;
-	spinlock_t			tx_lock;
+	spinlock_t			indirect_lock;
+
+	unsigned long			regs;
+	struct net_device		*dev;
+	struct pci_dev			*pdev;
+
+	struct tg3_hw_status		*hw_status;
+	dma_addr_t			status_mapping;
+
+	u32				msg_enable;
+
+	/* end "general, frequently-used members" cacheline section */
+	ALIGNED_PAD(_pad1_)
 
 	u32				tx_prod;
 	u32				tx_cons;
+	u32				tx_pending;
+
+	spinlock_t			tx_lock;
+
+	/* TX descs are only used if TG3_FLAG_HOST_TXDS is set. */
+	struct tg3_tx_buffer_desc	*tx_ring;
+	struct tx_ring_info		*tx_buffers;
+	dma_addr_t			tx_desc_mapping;
+
+	/* end "tx thread" cacheline section */
+	ALIGNED_PAD(_pad2_)
+
 	u32				rx_rcb_ptr;
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
+
+	struct tg3_rx_buffer_desc	*rx_rcb;
+	dma_addr_t			rx_rcb_mapping;
+
+	/* end "rx thread" cacheline section */
+	ALIGNED_PAD(_pad3_)
 
 	struct net_device_stats		net_stats;
 	struct net_device_stats		net_stats_prev;
@@ -1791,8 +1840,6 @@
 #define TG3_FLAG_SPLIT_MODE		0x40000000
 #define TG3_FLAG_INIT_COMPLETE		0x80000000
 
-	u32				msg_enable;
-
 	u32				split_mode_max_reqs;
 #define SPLIT_MODE_5704_MAX_REQ		3
 
@@ -1806,13 +1853,6 @@
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
@@ -1865,38 +1905,10 @@
 	 (X) == PHY_ID_BCM5703 || (X) == PHY_ID_BCM5704 || \
 	 (X) == PHY_ID_BCM8002 || (X) == PHY_ID_SERDES)
 
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
-
 	struct tg3_hw_stats		*hw_stats;
 	dma_addr_t			stats_mapping;
+
+	/* end "everything else" cacheline(s) section */
 };
 
 #endif /* !(_T3_H) */
===== include/linux/cache.h 1.5 vs edited =====
--- 1.5/include/linux/cache.h	Tue Aug 27 16:04:10 2002
+++ edited/include/linux/cache.h	Sat Dec  7 17:12:13 2002
@@ -53,4 +53,14 @@
 #endif
 #endif
 
+/* helper used inside struct definitions to break up struct at
+ * cacheline boundaries.
+ * Note: do not add a semi-colon (';') after an ALIGNED_PAD use.
+ */
+struct dummy_cacheline_struct {
+	int x;
+} ____cacheline_aligned;
+#define ALIGNED_PAD(name) \
+	struct dummy_cacheline_struct name;
+
 #endif /* __LINUX_CACHE_H */

--------------070601080505050708040803--

