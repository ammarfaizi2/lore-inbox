Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031258AbWKVESv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031258AbWKVESv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031089AbWKVESG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:18:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20237 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031177AbWKVERt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:17:49 -0500
Date: Wed, 22 Nov 2006 05:17:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Larry.Finger@lwfinger.net, st3@riseup.net
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] bcm43xx: possible cleanups
Message-ID: <20061122041749.GE5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global functions static:
  - bcm43xx_dma.c: bcm43xx_dmacontroller_base()
  - bcm43xx_phy.c: bcm43xx_phy_lo_b_measure()
  - bcm43xx_radio: bcm43xx_radio_aci_detect()
  - bcm43xx_radio: bcm43xx_nrssi_hw_read()
  - bcm43xx_radio: bcm43xx_nrssi_mem_update()
- #if 0 the following unused global functions:
  - bcm43xx_debugfs.c: bcm43xx_printk_dump()
  - bcm43xx_debugfs.c: bcm43xx_printk_bitdump()
  - bcm43xx_dma.c: bcm43xx_dma_tx_suspend()
  - bcm43xx_dma.c: bcm43xx_dma_tx_resume()
  - bcm43xx_pio.c: bcm43xx_pio_tx_suspend()
  - bcm43xx_pio.c: bcm43xx_pio_tx_resume()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c |    4 ++
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.h |   29 ----------------
 drivers/net/wireless/bcm43xx/bcm43xx_dma.c     |   22 +++++++++++-
 drivers/net/wireless/bcm43xx/bcm43xx_dma.h     |   30 -----------------
 drivers/net/wireless/bcm43xx/bcm43xx_phy.c     |    3 +
 drivers/net/wireless/bcm43xx/bcm43xx_phy.h     |    1 
 drivers/net/wireless/bcm43xx/bcm43xx_pio.c     |    4 ++
 drivers/net/wireless/bcm43xx/bcm43xx_pio.h     |   11 ------
 drivers/net/wireless/bcm43xx/bcm43xx_radio.c   |    6 +--
 drivers/net/wireless/bcm43xx/bcm43xx_radio.h   |    3 -
 10 files changed, 34 insertions(+), 79 deletions(-)

--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.h.old	2006-11-22 03:21:45.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.h	2006-11-22 03:22:07.000000000 +0100
@@ -50,21 +50,6 @@
 void bcm43xx_debugfs_log_txstat(struct bcm43xx_private *bcm,
 				struct bcm43xx_xmitstatus *status);
 
-/* Debug helper: Dump binary data through printk. */
-void bcm43xx_printk_dump(const char *data,
-			 size_t size,
-			 const char *description);
-/* Debug helper: Dump bitwise binary data through printk. */
-void bcm43xx_printk_bitdump(const unsigned char *data,
-			    size_t bytes, int msb_to_lsb,
-			    const char *description);
-#define bcm43xx_printk_bitdumpt(pointer, msb_to_lsb, description) \
-	do {									\
-		bcm43xx_printk_bitdump((const unsigned char *)(pointer),	\
-				       sizeof(*(pointer)),			\
-				       (msb_to_lsb),				\
-				       (description));				\
-	} while (0)
 
 #else /* CONFIG_BCM43XX_DEBUG*/
 
@@ -80,20 +65,6 @@
 void bcm43xx_debugfs_log_txstat(struct bcm43xx_private *bcm,
 				struct bcm43xx_xmitstatus *status) { }
 
-static inline
-void bcm43xx_printk_dump(const char *data,
-			 size_t size,
-			 const char *description)
-{
-}
-static inline
-void bcm43xx_printk_bitdump(const unsigned char *data,
-			    size_t bytes, int msb_to_lsb,
-			    const char *description)
-{
-}
-#define bcm43xx_printk_bitdumpt(pointer, msb_to_lsb, description)  do { /* nothing */ } while (0)
-
 #endif /* CONFIG_BCM43XX_DEBUG*/
 
 /* Ugly helper macros to make incomplete code more verbose on runtime */
--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c.old	2006-11-22 03:15:40.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c	2006-11-22 03:16:01.000000000 +0100
@@ -502,6 +502,8 @@
 	debugfs_remove(fs.root);
 }
 
+#if 0
+
 void bcm43xx_printk_dump(const char *data,
 			 size_t size,
 			 const char *description)
@@ -554,3 +556,5 @@
 	}
 	printk("\n");
 }
+
+#endif  /*  0  */
--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_dma.h.old	2006-11-22 03:22:29.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_dma.h	2006-11-22 03:28:15.000000000 +0100
@@ -303,11 +303,6 @@
 				   u16 dmacontroller_mmio_base,
 				   int dma64);
 
-u16 bcm43xx_dmacontroller_base(int dma64bit, int dmacontroller_idx);
-
-void bcm43xx_dma_tx_suspend(struct bcm43xx_dmaring *ring);
-void bcm43xx_dma_tx_resume(struct bcm43xx_dmaring *ring);
-
 void bcm43xx_dma_handle_xmitstatus(struct bcm43xx_private *bcm,
 				   struct bcm43xx_xmitstatus *status);
 
@@ -315,23 +310,6 @@
 		   struct ieee80211_txb *txb);
 void bcm43xx_dma_rx(struct bcm43xx_dmaring *ring);
 
-/* Helper function that returns the dma mask for this device. */
-static inline
-u64 bcm43xx_get_supported_dma_mask(struct bcm43xx_private *bcm)
-{
-	int dma64 = bcm43xx_read32(bcm, BCM43xx_CIR_SBTMSTATEHIGH) &
-				   BCM43xx_SBTMSTATEHIGH_DMA64BIT;
-	u16 mmio_base = bcm43xx_dmacontroller_base(dma64, 0);
-	u32 mask = BCM43xx_DMA32_TXADDREXT_MASK;
-
-	if (dma64)
-		return DMA_64BIT_MASK;
-	bcm43xx_write32(bcm, mmio_base + BCM43xx_DMA32_TXCTL, mask);
-	if (bcm43xx_read32(bcm, mmio_base + BCM43xx_DMA32_TXCTL) & mask)
-		return DMA_32BIT_MASK;
-	return DMA_30BIT_MASK;
-}
-
 #else /* CONFIG_BCM43XX_DMA */
 
 
@@ -373,14 +351,6 @@
 void bcm43xx_dma_rx(struct bcm43xx_dmaring *ring)
 {
 }
-static inline
-void bcm43xx_dma_tx_suspend(struct bcm43xx_dmaring *ring)
-{
-}
-static inline
-void bcm43xx_dma_tx_resume(struct bcm43xx_dmaring *ring)
-{
-}
 
 #endif /* CONFIG_BCM43XX_DMA */
 #endif /* BCM43xx_DMA_H_ */
--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_dma.c.old	2006-11-22 03:20:52.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_dma.c	2006-11-22 03:28:21.000000000 +0100
@@ -109,7 +109,7 @@
 	}
 }
 
-u16 bcm43xx_dmacontroller_base(int dma64bit, int controller_idx)
+static u16 bcm43xx_dmacontroller_base(int dma64bit, int controller_idx)
 {
 	static const u16 map64[] = {
 		BCM43xx_MMIO_DMA64_BASE0,
@@ -138,6 +138,22 @@
 	return map32[controller_idx];
 }
 
+/* Helper function that returns the dma mask for this device. */
+static u64 bcm43xx_get_supported_dma_mask(struct bcm43xx_private *bcm)
+{
+	int dma64 = bcm43xx_read32(bcm, BCM43xx_CIR_SBTMSTATEHIGH) &
+				   BCM43xx_SBTMSTATEHIGH_DMA64BIT;
+	u16 mmio_base = bcm43xx_dmacontroller_base(dma64, 0);
+	u32 mask = BCM43xx_DMA32_TXADDREXT_MASK;
+
+	if (dma64)
+		return DMA_64BIT_MASK;
+	bcm43xx_write32(bcm, mmio_base + BCM43xx_DMA32_TXCTL, mask);
+	if (bcm43xx_read32(bcm, mmio_base + BCM43xx_DMA32_TXCTL) & mask)
+		return DMA_32BIT_MASK;
+	return DMA_30BIT_MASK;
+}
+
 static inline
 dma_addr_t map_descbuffer(struct bcm43xx_dmaring *ring,
 			  unsigned char *buf,
@@ -1158,6 +1174,8 @@
 	ring->current_slot = slot;
 }
 
+#if 0
+
 void bcm43xx_dma_tx_suspend(struct bcm43xx_dmaring *ring)
 {
 	assert(ring->tx);
@@ -1187,3 +1205,5 @@
 	}
 	bcm43xx_power_saving_ctl_bits(ring->bcm, -1, -1);
 }
+
+#endif  /*  0  */
--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_phy.h.old	2006-11-22 03:29:10.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_phy.h	2006-11-22 03:29:16.000000000 +0100
@@ -58,7 +58,6 @@
 void bcm43xx_phy_calibrate(struct bcm43xx_private *bcm);
 int bcm43xx_phy_connect(struct bcm43xx_private *bcm, int connect);
 
-void bcm43xx_phy_lo_b_measure(struct bcm43xx_private *bcm);
 void bcm43xx_phy_lo_g_measure(struct bcm43xx_private *bcm);
 void bcm43xx_phy_xmitpower(struct bcm43xx_private *bcm);
 
--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_phy.c.old	2006-11-22 03:29:24.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_phy.c	2006-11-22 03:29:42.000000000 +0100
@@ -79,6 +79,7 @@
 };
 
 static void bcm43xx_phy_initg(struct bcm43xx_private *bcm);
+static void bcm43xx_phy_lo_b_measure(struct bcm43xx_private *bcm);
 
 
 static inline
@@ -1318,7 +1319,7 @@
 	return ret;
 }
 
-void bcm43xx_phy_lo_b_measure(struct bcm43xx_private *bcm)
+static void bcm43xx_phy_lo_b_measure(struct bcm43xx_private *bcm)
 {
 	struct bcm43xx_radioinfo *radio = bcm43xx_current_radio(bcm);
 	struct bcm43xx_phyinfo *phy = bcm43xx_current_phy(bcm);
--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_pio.h.old	2006-11-22 03:30:04.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_pio.h	2006-11-22 03:30:18.000000000 +0100
@@ -109,9 +109,6 @@
 				   struct bcm43xx_xmitstatus *status);
 void bcm43xx_pio_rx(struct bcm43xx_pioqueue *queue);
 
-/* Suspend a TX queue on hardware level. */
-void bcm43xx_pio_tx_suspend(struct bcm43xx_pioqueue *queue);
-void bcm43xx_pio_tx_resume(struct bcm43xx_pioqueue *queue);
 /* Suspend (freeze) the TX tasklet (software level). */
 void bcm43xx_pio_freeze_txqueues(struct bcm43xx_private *bcm);
 void bcm43xx_pio_thaw_txqueues(struct bcm43xx_private *bcm);
@@ -143,14 +140,6 @@
 {
 }
 static inline
-void bcm43xx_pio_tx_suspend(struct bcm43xx_pioqueue *queue)
-{
-}
-static inline
-void bcm43xx_pio_tx_resume(struct bcm43xx_pioqueue *queue)
-{
-}
-static inline
 void bcm43xx_pio_freeze_txqueues(struct bcm43xx_private *bcm)
 {
 }
--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_pio.c.old	2006-11-22 03:30:26.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_pio.c	2006-11-22 03:30:42.000000000 +0100
@@ -621,6 +621,8 @@
 	bcm43xx_rx(queue->bcm, skb, rxhdr);
 }
 
+#if 0
+
 void bcm43xx_pio_tx_suspend(struct bcm43xx_pioqueue *queue)
 {
 	bcm43xx_power_saving_ctl_bits(queue->bcm, -1, 1);
@@ -639,6 +641,8 @@
 		tasklet_schedule(&queue->txtask);
 }
 
+#endif  /*  0  */
+
 void bcm43xx_pio_freeze_txqueues(struct bcm43xx_private *bcm)
 {
 	struct bcm43xx_pio *pio;
--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_radio.h.old	2006-11-22 03:31:06.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_radio.h	2006-11-22 04:09:25.000000000 +0100
@@ -81,17 +81,14 @@
 
 void bcm43xx_radio_clear_tssi(struct bcm43xx_private *bcm);
 
-u8 bcm43xx_radio_aci_detect(struct bcm43xx_private *bcm, u8 channel);
 u8 bcm43xx_radio_aci_scan(struct bcm43xx_private *bcm);
 
 int bcm43xx_radio_set_interference_mitigation(struct bcm43xx_private *bcm, int mode);
 
 void bcm43xx_calc_nrssi_slope(struct bcm43xx_private *bcm);
 void bcm43xx_calc_nrssi_threshold(struct bcm43xx_private *bcm);
-s16 bcm43xx_nrssi_hw_read(struct bcm43xx_private *bcm, u16 offset);
 void bcm43xx_nrssi_hw_write(struct bcm43xx_private *bcm, u16 offset, s16 val);
 void bcm43xx_nrssi_hw_update(struct bcm43xx_private *bcm, u16 val);
-void bcm43xx_nrssi_mem_update(struct bcm43xx_private *bcm);
 
 void bcm43xx_radio_set_tx_iq(struct bcm43xx_private *bcm);
 u16 bcm43xx_radio_calibrationvalue(struct bcm43xx_private *bcm);
--- linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_radio.c.old	2006-11-22 03:31:20.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/net/wireless/bcm43xx/bcm43xx_radio.c	2006-11-22 04:09:11.000000000 +0100
@@ -236,7 +236,7 @@
 			channel2freq_bg(channel));
 }
 
-u8 bcm43xx_radio_aci_detect(struct bcm43xx_private *bcm, u8 channel)
+static u8 bcm43xx_radio_aci_detect(struct bcm43xx_private *bcm, u8 channel)
 {
 	struct bcm43xx_radioinfo *radio = bcm43xx_current_radio(bcm);
 	u8 ret = 0;
@@ -324,7 +324,7 @@
 }
 
 /* http://bcm-specs.sipsolutions.net/NRSSILookupTable */
-s16 bcm43xx_nrssi_hw_read(struct bcm43xx_private *bcm, u16 offset)
+static s16 bcm43xx_nrssi_hw_read(struct bcm43xx_private *bcm, u16 offset)
 {
 	u16 val;
 
@@ -349,7 +349,7 @@
 }
 
 /* http://bcm-specs.sipsolutions.net/NRSSILookupTable */
-void bcm43xx_nrssi_mem_update(struct bcm43xx_private *bcm)
+static void bcm43xx_nrssi_mem_update(struct bcm43xx_private *bcm)
 {
 	struct bcm43xx_radioinfo *radio = bcm43xx_current_radio(bcm);
 	s16 i, delta;

