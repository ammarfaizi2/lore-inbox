Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130281AbRAOBwC>; Sun, 14 Jan 2001 20:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131417AbRAOBvx>; Sun, 14 Jan 2001 20:51:53 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:60900 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S130281AbRAOBvm>; Sun, 14 Jan 2001 20:51:42 -0500
Date: Mon, 15 Jan 2001 02:51:55 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] important fixes for ieee1394 subsystem
Message-ID: <20010115025155.A3945@storm.local>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does the missing conversions for the new task queue code, one
of which fixes an oops (the others are there for cleanliness).  I use
some internal macros for easy compatibility to Linux 2.2.

The other change incorporated fixes some issues in the PCILynx driver
with bus resets being initiated before the completion of the first one
and makes it much more robust in this case.

Patch is against 2.4.0.  And yes, this really should be in 2.4.1.



diff -ruN linux-2.4.orig/drivers/ieee1394/guid.c linux-2.4/drivers/ieee1394/guid.c
--- linux-2.4.orig/drivers/ieee1394/guid.c	Mon Jan  1 23:17:36 2001
+++ linux-2.4/drivers/ieee1394/guid.c	Thu Jan 11 02:03:04 2001
@@ -163,7 +163,7 @@
                         return;
                 }
 
-                INIT_LIST_HEAD(&greq->tq.list);
+                INIT_TQ_LINK(greq->tq);
                 greq->tq.sync = 0;
                 greq->tq.routine = (void (*)(void*))pkt_complete;
                 greq->tq.data = greq;
diff -ruN linux-2.4.orig/drivers/ieee1394/hosts.c linux-2.4/drivers/ieee1394/hosts.c
--- linux-2.4.orig/drivers/ieee1394/hosts.c	Mon Jan  1 23:15:56 2001
+++ linux-2.4/drivers/ieee1394/hosts.c	Thu Jan 11 01:55:50 2001
@@ -106,6 +106,7 @@
         sema_init(&h->tlabel_count, 64);
         spin_lock_init(&h->tlabel_lock);
 
+        INIT_TQ_LINK(h->timeout_tq);
         h->timeout_tq.routine = (void (*)(void*))abort_timedouts;
         h->timeout_tq.data = h;
 
diff -ruN linux-2.4.orig/drivers/ieee1394/ieee1394_core.c linux-2.4/drivers/ieee1394/ieee1394_core.c
--- linux-2.4.orig/drivers/ieee1394/ieee1394_core.c	Mon Jan  1 23:15:56 2001
+++ linux-2.4/drivers/ieee1394/ieee1394_core.c	Thu Jan 11 01:52:21 2001
@@ -98,6 +98,7 @@
                 packet->data_size = data_size;
         }
 
+        INIT_TQ_HEAD(packet->complete_tq);
         INIT_LIST_HEAD(&packet->list);
         sema_init(&packet->state_change, 0);
         packet->state = unused;
diff -ruN linux-2.4.orig/drivers/ieee1394/ieee1394_types.h linux-2.4/drivers/ieee1394/ieee1394_types.h
--- linux-2.4.orig/drivers/ieee1394/ieee1394_types.h	Tue Jan  2 05:53:39 2001
+++ linux-2.4/drivers/ieee1394/ieee1394_types.h	Thu Jan 11 02:25:53 2001
@@ -15,6 +15,9 @@
 #define V22_COMPAT_MOD_INC_USE_COUNT do {} while (0)
 #define V22_COMPAT_MOD_DEC_USE_COUNT do {} while (0)
 #define OWNER_THIS_MODULE owner: THIS_MODULE,
+
+#define INIT_TQ_LINK(tq) INIT_LIST_HEAD(&(tq).list)
+#define INIT_TQ_HEAD(tq) INIT_LIST_HEAD(&(tq))
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,18)
diff -ruN linux-2.4.orig/drivers/ieee1394/ohci1394.c linux-2.4/drivers/ieee1394/ohci1394.c
--- linux-2.4.orig/drivers/ieee1394/ohci1394.c	Thu Jan 11 01:34:32 2001
+++ linux-2.4/drivers/ieee1394/ohci1394.c	Thu Jan 11 02:04:48 2001
@@ -1641,7 +1641,7 @@
 
         /* initialize bottom handler */
         d->task.sync = 0;
-        INIT_LIST_HEAD(&d->task.list);
+        INIT_TQ_LINK(d->task);
         d->task.routine = dma_rcv_bh;
         d->task.data = (void*)d;
 
@@ -1730,6 +1730,7 @@
         spin_lock_init(&d->lock);
 
         /* initialize bottom handler */
+        INIT_TQ_LINK(d->task);
         d->task.routine = dma_trm_bh;
         d->task.data = (void*)d;
 
diff -ruN linux-2.4.orig/drivers/ieee1394/pcilynx.c linux-2.4/drivers/ieee1394/pcilynx.c
--- linux-2.4.orig/drivers/ieee1394/pcilynx.c	Mon Jan  1 23:17:36 2001
+++ linux-2.4/drivers/ieee1394/pcilynx.c	Thu Jan 11 02:00:27 2001
@@ -289,7 +289,8 @@
         char phyreg[7];
         int i;
 
-        for (i = 0; i < 7; i++) {
+        phyreg[0] = lynx->phy_reg0;
+        for (i = 1; i < 7; i++) {
                 phyreg[i] = get_phy_reg(lynx, i);
         }
 
@@ -317,13 +318,18 @@
         return lsid;
 }
 
-static void handle_selfid(struct ti_lynx *lynx, struct hpsb_host *host, size_t size)
+static void handle_selfid(struct ti_lynx *lynx, struct hpsb_host *host)
 {
         quadlet_t *q = lynx->rcv_page;
-        int phyid, isroot;
+        int phyid, isroot, size;
         quadlet_t lsid = 0;
         int i;
 
+        if (lynx->phy_reg0 == -1 || lynx->selfid_size == -1) return;
+
+        size = lynx->selfid_size;
+        phyid = lynx->phy_reg0;
+
         i = (size > 16 ? 16 : size) / 4 - 1;
         while (i >= 0) {
                 cpu_to_be32s(&q[i]);
@@ -334,7 +340,6 @@
                 lsid = generate_own_selfid(lynx, host);
         }
 
-        phyid = get_phy_reg(lynx, 0);
         isroot = (phyid & 2) != 0;
         phyid >>= 2;
         PRINT(KERN_INFO, lynx->id, "SelfID process finished (phyid %d, %s)",
@@ -369,9 +374,14 @@
                 hpsb_selfid_received(host, lsid);
         }
 
-        if (isroot) reg_set_bits(lynx, LINK_CONTROL, LINK_CONTROL_CYCMASTER);
-
         hpsb_selfid_complete(host, phyid, isroot);
+
+        if (host->in_bus_reset) return;
+
+        if (isroot) reg_set_bits(lynx, LINK_CONTROL, LINK_CONTROL_CYCMASTER);
+        reg_set_bits(lynx, LINK_CONTROL,
+                     LINK_CONTROL_RCV_CMP_VALID | LINK_CONTROL_TX_ASYNC_EN
+                     | LINK_CONTROL_RX_ASYNC_EN | LINK_CONTROL_CYCTIMEREN);
 }
 
 
@@ -456,6 +466,9 @@
         int i;
         u32 *pcli;
 
+        lynx->selfid_size = -1;
+        lynx->phy_reg0 = -1;
+
         lynx->async.queue = NULL;
         spin_lock_init(&lynx->async.queue_lock);
         spin_lock_init(&lynx->phy_reg_lock);
@@ -531,8 +544,8 @@
         reg_write(lynx, DMA_WORD0_CMP_ENABLE(CHANNEL_ASYNC_RCV), 0xa<<4);
         reg_write(lynx, DMA_WORD1_CMP_VALUE(CHANNEL_ASYNC_RCV), 0);
         reg_write(lynx, DMA_WORD1_CMP_ENABLE(CHANNEL_ASYNC_RCV),
-                  DMA_WORD1_CMP_MATCH_NODE_BCAST | DMA_WORD1_CMP_MATCH_BROADCAST
-                  | DMA_WORD1_CMP_MATCH_LOCAL    | DMA_WORD1_CMP_MATCH_BUS_BCAST
+                  DMA_WORD1_CMP_MATCH_LOCAL_NODE | DMA_WORD1_CMP_MATCH_BROADCAST
+                  | DMA_WORD1_CMP_MATCH_EXACT    | DMA_WORD1_CMP_MATCH_BUS_BCAST
                   | DMA_WORD1_CMP_ENABLE_SELF_ID | DMA_WORD1_CMP_ENABLE_MASTER);
 
         run_pcl(lynx, lynx->rcv_pcl_start, CHANNEL_ASYNC_RCV);
@@ -547,12 +560,21 @@
         reg_write(lynx, LINK_CONTROL, LINK_CONTROL_RCV_CMP_VALID
                   | LINK_CONTROL_TX_ISO_EN   | LINK_CONTROL_RX_ISO_EN
                   | LINK_CONTROL_TX_ASYNC_EN | LINK_CONTROL_RX_ASYNC_EN
-                  | LINK_CONTROL_RESET_TX    | LINK_CONTROL_RESET_RX
-                  | LINK_CONTROL_CYCTIMEREN);
-        
-        /* attempt to enable contender bit -FIXME- would this work elsewhere? */
-        reg_set_bits(lynx, GPIO_CTRL_A, 0x1);
-        reg_write(lynx, GPIO_DATA_BASE + 0x3c, 0x1); 
+                  | LINK_CONTROL_RESET_TX    | LINK_CONTROL_RESET_RX);
+
+        if (!lynx->phyic.reg_1394a) {
+                /* attempt to enable contender bit -FIXME- would this work
+                 * elsewhere? */
+                reg_set_bits(lynx, GPIO_CTRL_A, 0x1);
+                reg_write(lynx, GPIO_DATA_BASE + 0x3c, 0x1); 
+        } else {
+                /* set the contender bit in the extended PHY register
+                 * set. (Should check that bis 0,1,2 (=0xE0) is set
+                 * in register 2?)
+                 */
+                i = get_phy_reg(lynx, 4);
+                if (i != -1) set_phy_reg(lynx, 4, i | 0x40);
+        }
 
         return 1;
 }
@@ -628,6 +650,11 @@
 
         switch (cmd) {
         case RESET_BUS:
+                if (reg_read(lynx, LINK_INT_STATUS) & LINK_INT_PHY_BUSRESET) {
+                        retval = 0;
+                        break;
+                }
+
                 if (arg) {
                         arg = 3 << 6;
                 } else {
@@ -642,6 +669,8 @@
                       (host->attempt_root ? " and attempting to become root"
                        : ""));
 
+                lynx->selfid_size = -1;
+                lynx->phy_reg0 = -1;
                 set_phy_reg(lynx, 1, arg);
                 break;
 
@@ -1102,14 +1131,28 @@
                 }
                 if (linkint & LINK_INT_PHY_BUSRESET) {
                         PRINT(KERN_INFO, lynx->id, "bus reset interrupt");
-                        if (!host->in_bus_reset) {
+                        lynx->selfid_size = -1;
+                        lynx->phy_reg0 = -1;
+                        if (!host->in_bus_reset)
                                 hpsb_bus_reset(host);
-                        }
                 }
                 if (linkint & LINK_INT_PHY_REG_RCVD) {
+                        u32 reg;
+
+                        spin_lock(&lynx->phy_reg_lock);
+                        reg = reg_read(lynx, LINK_PHY);
+                        spin_unlock(&lynx->phy_reg_lock);
+
                         if (!host->in_bus_reset) {
                                 PRINT(KERN_INFO, lynx->id,
                                       "phy reg received without reset");
+                        } else if (reg & 0xf00) {
+                                PRINT(KERN_INFO, lynx->id,
+                                      "unsolicited phy reg %d received",
+                                      (reg >> 8) & 0xf);
+                        } else {
+                                lynx->phy_reg0 = reg & 0xff;
+                                handle_selfid(lynx, host);
                         }
                 }
                 if (linkint & LINK_INT_ISO_STUCK) {
@@ -1125,6 +1168,10 @@
                         PRINT(KERN_INFO, lynx->id, "invalid transaction code");
                 }
                 if (linkint & LINK_INT_GRF_OVERFLOW) {
+                        /* flush FIFO if overflow happens during reset */
+                        if (host->in_bus_reset)
+                                reg_write(lynx, FIFO_CONTROL,
+                                          FIFO_CONTROL_GRF_FLUSH);
                         PRINT(KERN_INFO, lynx->id, "GRF overflow");
                 }
                 if (linkint & LINK_INT_ITF_UNDERFLOW) {
@@ -1227,11 +1274,8 @@
                        stat & 0x1fff); 
 
                 if (stat & DMA_CHAN_STAT_SELFID) {
-                        handle_selfid(lynx, host, stat & 0x1fff);
-                        reg_set_bits(lynx, LINK_CONTROL,
-                                     LINK_CONTROL_RCV_CMP_VALID
-                                     | LINK_CONTROL_TX_ASYNC_EN
-                                     | LINK_CONTROL_RX_ASYNC_EN);
+                        lynx->selfid_size = stat & 0x1fff;
+                        handle_selfid(lynx, host);
                 } else {
                         quadlet_t *q_data = lynx->rcv_page;
                         if ((*q_data >> 4 & 0xf) == TCODE_READQ_RESPONSE
@@ -1415,13 +1459,15 @@
 
         lynx->lock = SPIN_LOCK_UNLOCKED;
 
-        reg_write(lynx, PCI_INT_ENABLE, PCI_INT_AUX_INT | PCI_INT_DMA_ALL);
+        reg_write(lynx, PCI_INT_ENABLE, PCI_INT_DMA_ALL);
 
 #ifdef CONFIG_IEEE1394_PCILYNX_PORTS
+        reg_set_bits(lynx, PCI_INT_ENABLE, PCI_INT_AUX_INT);
         init_waitqueue_head(&lynx->mem_dma_intr_wait);
         init_waitqueue_head(&lynx->aux_intr_wait);
 #endif
 
+        INIT_TQ_LINK(lynx->iso_rcv.tq);
         lynx->iso_rcv.tq.routine = (void (*)(void*))iso_rcv_bh;
         lynx->iso_rcv.tq.data = lynx;
         lynx->iso_rcv.lock = SPIN_LOCK_UNLOCKED;
diff -ruN linux-2.4.orig/drivers/ieee1394/pcilynx.h linux-2.4/drivers/ieee1394/pcilynx.h
--- linux-2.4.orig/drivers/ieee1394/pcilynx.h	Tue Jan  2 05:53:53 2001
+++ linux-2.4/drivers/ieee1394/pcilynx.h	Sun Jan 14 03:50:46 2001
@@ -80,6 +80,8 @@
         struct hpsb_host *host;
 
         int phyid, isroot;
+        int selfid_size;
+        int phy_reg0;
 
         spinlock_t phy_reg_lock;
 
@@ -248,9 +250,9 @@
 #define FIFO_SIZES                        0xa00
 
 #define FIFO_CONTROL                      0xa10
-#define GRF_FLUSH                         (1<<4)
-#define ITF_FLUSH                         (1<<3)
-#define ATF_FLUSH                         (1<<2)
+#define FIFO_CONTROL_GRF_FLUSH            (1<<4)
+#define FIFO_CONTROL_ITF_FLUSH            (1<<3)
+#define FIFO_CONTROL_ATF_FLUSH            (1<<2)
 
 #define FIFO_XMIT_THRESHOLD               0xa14
 
@@ -285,8 +287,8 @@
 #define DMA_WORD1_CMP_MATCH_OTHERBUS      (1<<15)
 #define DMA_WORD1_CMP_MATCH_BROADCAST     (1<<14)
 #define DMA_WORD1_CMP_MATCH_BUS_BCAST     (1<<13)
-#define DMA_WORD1_CMP_MATCH_NODE_BCAST    (1<<12)
-#define DMA_WORD1_CMP_MATCH_LOCAL         (1<<11)
+#define DMA_WORD1_CMP_MATCH_LOCAL_NODE    (1<<12)
+#define DMA_WORD1_CMP_MATCH_EXACT         (1<<11)
 #define DMA_WORD1_CMP_ENABLE_SELF_ID      (1<<10)
 #define DMA_WORD1_CMP_ENABLE_MASTER       (1<<8)
 
diff -ruN linux-2.4.orig/drivers/ieee1394/raw1394.c linux-2.4/drivers/ieee1394/raw1394.c
--- linux-2.4.orig/drivers/ieee1394/raw1394.c	Mon Jan  1 23:17:36 2001
+++ linux-2.4/drivers/ieee1394/raw1394.c	Thu Jan 11 02:01:49 2001
@@ -64,6 +64,7 @@
         if (req != NULL) {
                 memset(req, 0, sizeof(struct pending_request));
                 INIT_LIST_HEAD(&req->list);
+                INIT_TQ_LINK(req->tq);
                 req->tq.routine = (void(*)(void*))queue_complete_cb;
         }
 


-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
