Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132543AbRBECd2>; Sun, 4 Feb 2001 21:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRBECdS>; Sun, 4 Feb 2001 21:33:18 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:38879 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S132543AbRBECdJ>; Sun, 4 Feb 2001 21:33:09 -0500
Date: Mon, 5 Feb 2001 03:29:27 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [BUGFIX] [RESEND, goddammit!] important fixes for ieee1394 subsystem
Message-ID: <20010205032927.C4450@storm.local>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have sent the following patch three times to you during 2.4.1 prepatch
time and you seem to have missed all of them (Jan 15, 19 and 25).  I
hope we can manage that for 2.4.2 and get the known bugs with fixes out
of the ieee1394 subsystem.  Finally.

Please, either show some sign of life by replying or making a 2.4.2-pre
patch with this included this week.  Thanks to the subsystem not being
modified the same patch from 2.4.0 times applies to 2.4.2-pre1.

* It completes the adaption to the new task queue structure.  Instead of
  plain INIT_LIST_HEAD internal macros are used to make backporting to
  2.2 easy (fixes 1 oops, the rest makes initialization just clean).   

* PCILynx bus reset handling was modified to make it much more robust
  with multiple bus resets in quick succession (fixes possible driver
  hangs).

* The definition of ohci_csr_rom was moved from ohci1394.h to
  ohci1394.c.  The header file is also included in video1394.c (fixes
  build failure when neither ohci1394 nor video1394 are configured as
  module or not built).  There is apparantly a different patch for this
  in Alan's tree.

* Five symbols in pcilynx.h were renamed to something more descriptive.
  Not a bug fix, but it's so small...



diff -ruN linux-2.4.orig/drivers/ieee1394/guid.c linux-2.4.linus/drivers/ieee1394/guid.c
--- linux-2.4.orig/drivers/ieee1394/guid.c	Mon Jan  1 23:17:36 2001
+++ linux-2.4.linus/drivers/ieee1394/guid.c	Mon Feb  5 02:59:17 2001
@@ -163,7 +163,7 @@
                         return;
                 }
 
-                INIT_LIST_HEAD(&greq->tq.list);
+                INIT_TQ_LINK(greq->tq);
                 greq->tq.sync = 0;
                 greq->tq.routine = (void (*)(void*))pkt_complete;
                 greq->tq.data = greq;
diff -ruN linux-2.4.orig/drivers/ieee1394/hosts.c linux-2.4.linus/drivers/ieee1394/hosts.c
--- linux-2.4.orig/drivers/ieee1394/hosts.c	Mon Jan  1 23:15:56 2001
+++ linux-2.4.linus/drivers/ieee1394/hosts.c	Mon Feb  5 02:59:17 2001
@@ -106,6 +106,7 @@
         sema_init(&h->tlabel_count, 64);
         spin_lock_init(&h->tlabel_lock);
 
+        INIT_TQ_LINK(h->timeout_tq);
         h->timeout_tq.routine = (void (*)(void*))abort_timedouts;
         h->timeout_tq.data = h;
 
diff -ruN linux-2.4.orig/drivers/ieee1394/ieee1394_core.c linux-2.4.linus/drivers/ieee1394/ieee1394_core.c
--- linux-2.4.orig/drivers/ieee1394/ieee1394_core.c	Mon Jan  1 23:15:56 2001
+++ linux-2.4.linus/drivers/ieee1394/ieee1394_core.c	Mon Feb  5 02:59:17 2001
@@ -98,6 +98,7 @@
                 packet->data_size = data_size;
         }
 
+        INIT_TQ_HEAD(packet->complete_tq);
         INIT_LIST_HEAD(&packet->list);
         sema_init(&packet->state_change, 0);
         packet->state = unused;
diff -ruN linux-2.4.orig/drivers/ieee1394/ieee1394_types.h linux-2.4.linus/drivers/ieee1394/ieee1394_types.h
--- linux-2.4.orig/drivers/ieee1394/ieee1394_types.h	Tue Jan  2 05:53:39 2001
+++ linux-2.4.linus/drivers/ieee1394/ieee1394_types.h	Mon Feb  5 02:59:17 2001
@@ -15,6 +15,9 @@
 #define V22_COMPAT_MOD_INC_USE_COUNT do {} while (0)
 #define V22_COMPAT_MOD_DEC_USE_COUNT do {} while (0)
 #define OWNER_THIS_MODULE owner: THIS_MODULE,
+
+#define INIT_TQ_LINK(tq) INIT_LIST_HEAD(&(tq).list)
+#define INIT_TQ_HEAD(tq) INIT_LIST_HEAD(&(tq))
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,18)
diff -ruN linux-2.4.orig/drivers/ieee1394/ohci1394.c linux-2.4.linus/drivers/ieee1394/ohci1394.c
--- linux-2.4.orig/drivers/ieee1394/ohci1394.c	Thu Jan 11 01:34:32 2001
+++ linux-2.4.linus/drivers/ieee1394/ohci1394.c	Mon Feb  5 02:59:17 2001
@@ -97,6 +97,81 @@
 #include "ieee1394_core.h"
 #include "ohci1394.h"
 
+
+/* This structure is not properly initialized ... it is taken from
+   the lynx_csr_rom written by Andreas ... Some fields in the root
+   directory and the module dependent info needs to be modified
+   I do not have the proper doc */
+quadlet_t ohci_csr_rom[] = {
+        /* bus info block */
+        0x04040000, /* info/CRC length, CRC */
+        0x31333934, /* 1394 magic number */
+        0xf07da002, /* cyc_clk_acc = 125us, max_rec = 1024 */
+        0x00000000, /* vendor ID, chip ID high (written from card info) */
+        0x00000000, /* chip ID low (written from card info) */
+        /* root directory - FIXME */
+        0x00090000, /* CRC length, CRC */
+        0x03080028, /* vendor ID (Texas Instr.) */
+        0x81000009, /* offset to textual ID */
+        0x0c000200, /* node capabilities */
+        0x8d00000e, /* offset to unique ID */
+        0xc7000010, /* offset to module independent info */
+        0x04000000, /* module hardware version */
+        0x81000026, /* offset to textual ID */
+        0x09000000, /* node hardware version */
+        0x81000026, /* offset to textual ID */
+        /* module vendor ID textual */
+        0x00080000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x54455841, /* "Texas Instruments" */
+        0x5320494e,
+        0x53545255,
+        0x4d454e54,
+        0x53000000,
+        /* node unique ID leaf */
+        0x00020000, /* CRC length, CRC */
+        0x08002856, /* vendor ID, chip ID high */
+        0x0000083E, /* chip ID low */
+        /* module dependent info - FIXME */
+        0x00060000, /* CRC length, CRC */
+        0xb8000006, /* ??? offset to module textual ID */
+        0x81000004, /* ??? textual descriptor */
+        0x00000000, /* SRAM size */
+        0x00000000, /* AUXRAM size */
+        0x00000000, /* AUX device */
+        /* module textual ID */
+        0x00050000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x54534231, /* "TSB12LV22" */
+        0x324c5632,
+        0x32000000,
+        /* part number */
+        0x00060000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x39383036, /* "9806000-0001" */
+        0x3030342d,
+        0x30303431,
+        0x20000001,
+        /* module hardware version textual */
+        0x00050000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x5453424b, /* "TSBKOHCI403" */
+        0x4f484349,
+        0x34303300,
+        /* node hardware version textual */
+        0x00050000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x54534234, /* "TSB41LV03" */
+        0x314c5630,
+        0x33000000
+};
+
+
 #ifdef CONFIG_IEEE1394_VERBOSEDEBUG
 #define OHCI1394_DEBUG
 #endif
@@ -1641,7 +1716,7 @@
 
         /* initialize bottom handler */
         d->task.sync = 0;
-        INIT_LIST_HEAD(&d->task.list);
+        INIT_TQ_LINK(d->task);
         d->task.routine = dma_rcv_bh;
         d->task.data = (void*)d;
 
@@ -1730,6 +1805,7 @@
         spin_lock_init(&d->lock);
 
         /* initialize bottom handler */
+        INIT_TQ_LINK(d->task);
         d->task.routine = dma_trm_bh;
         d->task.data = (void*)d;
 
diff -ruN linux-2.4.orig/drivers/ieee1394/ohci1394.h linux-2.4.linus/drivers/ieee1394/ohci1394.h
--- linux-2.4.orig/drivers/ieee1394/ohci1394.h	Sun Jan 14 03:50:51 2001
+++ linux-2.4.linus/drivers/ieee1394/ohci1394.h	Mon Feb  5 02:59:17 2001
@@ -276,79 +276,6 @@
         return readl(ohci->registers + offset);
 }
 
-/* This structure is not properly initialized ... it is taken from
-   the lynx_csr_rom written by Andreas ... Some fields in the root
-   directory and the module dependent info needs to be modified
-   I do not have the proper doc */
-quadlet_t ohci_csr_rom[] = {
-        /* bus info block */
-        0x04040000, /* info/CRC length, CRC */
-        0x31333934, /* 1394 magic number */
-        0xf07da002, /* cyc_clk_acc = 125us, max_rec = 1024 */
-        0x00000000, /* vendor ID, chip ID high (written from card info) */
-        0x00000000, /* chip ID low (written from card info) */
-        /* root directory - FIXME */
-        0x00090000, /* CRC length, CRC */
-        0x03080028, /* vendor ID (Texas Instr.) */
-        0x81000009, /* offset to textual ID */
-        0x0c000200, /* node capabilities */
-        0x8d00000e, /* offset to unique ID */
-        0xc7000010, /* offset to module independent info */
-        0x04000000, /* module hardware version */
-        0x81000026, /* offset to textual ID */
-        0x09000000, /* node hardware version */
-        0x81000026, /* offset to textual ID */
-        /* module vendor ID textual */
-        0x00080000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x54455841, /* "Texas Instruments" */
-        0x5320494e,
-        0x53545255,
-        0x4d454e54,
-        0x53000000,
-        /* node unique ID leaf */
-        0x00020000, /* CRC length, CRC */
-        0x08002856, /* vendor ID, chip ID high */
-        0x0000083E, /* chip ID low */
-        /* module dependent info - FIXME */
-        0x00060000, /* CRC length, CRC */
-        0xb8000006, /* ??? offset to module textual ID */
-        0x81000004, /* ??? textual descriptor */
-        0x00000000, /* SRAM size */
-        0x00000000, /* AUXRAM size */
-        0x00000000, /* AUX device */
-        /* module textual ID */
-        0x00050000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x54534231, /* "TSB12LV22" */
-        0x324c5632,
-        0x32000000,
-        /* part number */
-        0x00060000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x39383036, /* "9806000-0001" */
-        0x3030342d,
-        0x30303431,
-        0x20000001,
-        /* module hardware version textual */
-        0x00050000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x5453424b, /* "TSBKOHCI403" */
-        0x4f484349,
-        0x34303300,
-        /* node hardware version textual */
-        0x00050000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x54534234, /* "TSB41LV03" */
-        0x314c5630,
-        0x33000000
-};
-
 
 /* 2 KiloBytes of register space */
 #define OHCI1394_REGISTER_SIZE                0x800       
diff -ruN linux-2.4.orig/drivers/ieee1394/pcilynx.c linux-2.4.linus/drivers/ieee1394/pcilynx.c
--- linux-2.4.orig/drivers/ieee1394/pcilynx.c	Mon Jan  1 23:17:36 2001
+++ linux-2.4.linus/drivers/ieee1394/pcilynx.c	Mon Feb  5 02:59:17 2001
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
diff -ruN linux-2.4.orig/drivers/ieee1394/pcilynx.h linux-2.4.linus/drivers/ieee1394/pcilynx.h
--- linux-2.4.orig/drivers/ieee1394/pcilynx.h	Tue Jan  2 05:53:53 2001
+++ linux-2.4.linus/drivers/ieee1394/pcilynx.h	Mon Feb  5 02:59:17 2001
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
 
diff -ruN linux-2.4.orig/drivers/ieee1394/raw1394.c linux-2.4.linus/drivers/ieee1394/raw1394.c
--- linux-2.4.orig/drivers/ieee1394/raw1394.c	Mon Jan  1 23:17:36 2001
+++ linux-2.4.linus/drivers/ieee1394/raw1394.c	Mon Feb  5 02:59:17 2001
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
