Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUHICYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUHICYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 22:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUHICYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 22:24:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48343 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265817AbUHICXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 22:23:39 -0400
Date: Mon, 9 Aug 2004 04:23:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-net@vger.kernel.org, Netdev <netdev@oss.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix net/hamradio/dmascc with gcc 3.4 (fwd)
Message-ID: <20040809022335.GM26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
The patch forwarded below is still required in 2.6.8-rc3-mm2.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Tue, 3 Aug 2004 00:33:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, Netdev <netdev@oss.sgi.com>,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix net/hamradio/dmascc with gcc 3.4

Trying to compile net/hamradio/dmascc.c in 2.6.8-rc2-mm2 with gcc 3.4  
results in compile errors starting with the following:


<--  snip  -->

...
  CC      drivers/net/hamradio/dmascc.o
drivers/net/hamradio/dmascc.c: In function `scc_isr':
drivers/net/hamradio/dmascc.c:250: sorry, unimplemented: inlining 
failed in call to 'z8530_isr': function body not available
drivers/net/hamradio/dmascc.c:969: sorry, unimplemented: called from 
here
drivers/net/hamradio/dmascc.c:250: sorry, unimplemented: inlining 
failed in call to 'z8530_isr': function body not available
drivers/net/hamradio/dmascc.c:978: sorry, unimplemented: called from 
here
make[3]: *** [drivers/net/hamradio/dmascc.o] Error 1

<--  snip  -->


The patch below moves all inline functions above their first caller.


diffstat output:
 drivers/net/hamradio/dmascc.c |  290 ++++++++++++++++------------------
 1 files changed, 144 insertions(+), 146 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full-gcc3.4/drivers/net/hamradio/dmascc.c.old	2004-07-13 00:55:54.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/drivers/net/hamradio/dmascc.c	2004-07-13 01:01:06.000000000 +0200
@@ -246,8 +246,14 @@
 static struct net_device_stats *scc_get_stats(struct net_device *dev);
 static int scc_set_mac_address(struct net_device *dev, void *sa);
 
-static irqreturn_t scc_isr(int irq, void *dev_id, struct pt_regs * regs);
+static inline void tx_on(struct scc_priv *priv);
+static inline void rx_on(struct scc_priv *priv);
+static inline void rx_off(struct scc_priv *priv);
+static void start_timer(struct scc_priv *priv, int t, int r15);
+static inline unsigned char random(void);
+
 static inline void z8530_isr(struct scc_info *info);
+static irqreturn_t scc_isr(int irq, void *dev_id, struct pt_regs * regs);
 static void rx_isr(struct scc_priv *priv);
 static void special_condition(struct scc_priv *priv, int rc);
 static void rx_bh(void *arg);
@@ -255,12 +261,6 @@
 static void es_isr(struct scc_priv *priv);
 static void tm_isr(struct scc_priv *priv);
 
-static inline void tx_on(struct scc_priv *priv);
-static inline void rx_on(struct scc_priv *priv);
-static inline void rx_off(struct scc_priv *priv);
-static void start_timer(struct scc_priv *priv, int t, int r15);
-static inline unsigned char random(void);
-
 
 /* Initialization variables */
 
@@ -945,42 +945,115 @@
 }
 
 
-static irqreturn_t scc_isr(int irq, void *dev_id, struct pt_regs * regs) {
-  struct scc_info *info = dev_id;
+static inline void tx_on(struct scc_priv *priv) {
+  int i, n;
+  unsigned long flags;
 
-  spin_lock(info->priv[0].register_lock);
-  /* At this point interrupts are enabled, and the interrupt under service
-     is already acknowledged, but masked off.
+  if (priv->param.dma >= 0) {
+    n = (priv->chip == Z85230) ? 3 : 1;
+    /* Program DMA controller */
+    flags = claim_dma_lock();
+    set_dma_mode(priv->param.dma, DMA_MODE_WRITE);
+    set_dma_addr(priv->param.dma, (int) priv->tx_buf[priv->tx_tail]+n);
+    set_dma_count(priv->param.dma, priv->tx_len[priv->tx_tail]-n);
+    release_dma_lock(flags);
+    /* Enable TX underrun interrupt */
+    write_scc(priv, R15, TxUIE);
+    /* Configure DREQ */
+    if (priv->type == TYPE_TWIN)
+      outb((priv->param.dma == 1) ? TWIN_DMA_HDX_T1 : TWIN_DMA_HDX_T3,
+	   priv->card_base + TWIN_DMA_CFG);
+    else
+      write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN | WT_RDY_ENAB);
+    /* Write first byte(s) */
+    spin_lock_irqsave(priv->register_lock, flags);
+    for (i = 0; i < n; i++)
+      write_scc_data(priv, priv->tx_buf[priv->tx_tail][i], 1);
+    enable_dma(priv->param.dma);
+    spin_unlock_irqrestore(priv->register_lock, flags);
+  } else {
+    write_scc(priv, R15, TxUIE);
+    write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN | TxINT_ENAB);
+    tx_isr(priv);
+  }
+  /* Reset EOM latch if we do not have the AUTOEOM feature */
+  if (priv->chip == Z8530) write_scc(priv, R0, RES_EOM_L);
+}
 
-     Interrupt processing: We loop until we know that the IRQ line is
-     low. If another positive edge occurs afterwards during the ISR,
-     another interrupt will be triggered by the interrupt controller
-     as soon as the IRQ level is enabled again (see asm/irq.h).
 
-     Bottom-half handlers will be processed after scc_isr(). This is
-     important, since we only have small ringbuffers and want new data
-     to be fetched/delivered immediately. */
+static inline void rx_on(struct scc_priv *priv) {
+  unsigned long flags;
 
-  if (info->priv[0].type == TYPE_TWIN) {
-    int is, card_base = info->priv[0].card_base;
-    while ((is = ~inb(card_base + TWIN_INT_REG)) &
-	   TWIN_INT_MSK) {
-      if (is & TWIN_SCC_MSK) {
-	z8530_isr(info);
-      } else if (is & TWIN_TMR1_MSK) {
-	inb(card_base + TWIN_CLR_TMR1);
-	tm_isr(&info->priv[0]);
-      } else {
-	inb(card_base + TWIN_CLR_TMR2);
-	tm_isr(&info->priv[1]);
-      }
+  /* Clear RX FIFO */
+  while (read_scc(priv, R0) & Rx_CH_AV) read_scc_data(priv);
+  priv->rx_over = 0;
+  if (priv->param.dma >= 0) {
+    /* Program DMA controller */
+    flags = claim_dma_lock();
+    set_dma_mode(priv->param.dma, DMA_MODE_READ);
+    set_dma_addr(priv->param.dma, (int) priv->rx_buf[priv->rx_head]);
+    set_dma_count(priv->param.dma, BUF_SIZE);
+    release_dma_lock(flags);
+    enable_dma(priv->param.dma);
+    /* Configure PackeTwin DMA */
+    if (priv->type == TYPE_TWIN) {
+      outb((priv->param.dma == 1) ? TWIN_DMA_HDX_R1 : TWIN_DMA_HDX_R3,
+	   priv->card_base + TWIN_DMA_CFG);
     }
-  } else z8530_isr(info);
-  spin_unlock(info->priv[0].register_lock);
-  return IRQ_HANDLED;
+    /* Sp. cond. intr. only, ext int enable, RX DMA enable */
+    write_scc(priv, R1, EXT_INT_ENAB | INT_ERR_Rx |
+	      WT_RDY_RT | WT_FN_RDYFN | WT_RDY_ENAB);
+  } else {
+    /* Reset current frame */
+    priv->rx_ptr = 0;
+    /* Intr. on all Rx characters and Sp. cond., ext int enable */
+    write_scc(priv, R1, EXT_INT_ENAB | INT_ALL_Rx | WT_RDY_RT |
+	      WT_FN_RDYFN);
+  }
+  write_scc(priv, R0, ERR_RES);
+  write_scc(priv, R3, RxENABLE | Rx8 | RxCRC_ENAB);
+}
+
+
+static inline void rx_off(struct scc_priv *priv) {
+  /* Disable receiver */
+  write_scc(priv, R3, Rx8);
+  /* Disable DREQ / RX interrupt */
+  if (priv->param.dma >= 0 && priv->type == TYPE_TWIN)
+    outb(0, priv->card_base + TWIN_DMA_CFG);
+  else
+    write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN);
+  /* Disable DMA */
+  if (priv->param.dma >= 0) disable_dma(priv->param.dma);
+}
+
+
+static void start_timer(struct scc_priv *priv, int t, int r15) {
+  unsigned long flags;
+
+  outb(priv->tmr_mode, priv->tmr_ctrl);
+  if (t == 0) {
+    tm_isr(priv);
+  } else if (t > 0) {
+    save_flags(flags);
+    cli();
+    outb(t & 0xFF, priv->tmr_cnt);
+    outb((t >> 8) & 0xFF, priv->tmr_cnt);
+    if (priv->type != TYPE_TWIN) {
+      write_scc(priv, R15, r15 | CTSIE);
+      priv->rr0 |= CTS;
+    }
+    restore_flags(flags);
+  }
 }
 
 
+static inline unsigned char random(void) {
+  /* See "Numerical Recipes in C", second edition, p. 284 */
+  rand = rand * 1664525L + 1013904223L;
+  return (unsigned char) (rand >> 24);
+}
+
 static inline void z8530_isr(struct scc_info *info) {
   int is, i = 100;
 
@@ -1009,6 +1082,42 @@
 }
 
 
+static irqreturn_t scc_isr(int irq, void *dev_id, struct pt_regs * regs) {
+  struct scc_info *info = dev_id;
+
+  spin_lock(info->priv[0].register_lock);
+  /* At this point interrupts are enabled, and the interrupt under service
+     is already acknowledged, but masked off.
+
+     Interrupt processing: We loop until we know that the IRQ line is
+     low. If another positive edge occurs afterwards during the ISR,
+     another interrupt will be triggered by the interrupt controller
+     as soon as the IRQ level is enabled again (see asm/irq.h).
+
+     Bottom-half handlers will be processed after scc_isr(). This is
+     important, since we only have small ringbuffers and want new data
+     to be fetched/delivered immediately. */
+
+  if (info->priv[0].type == TYPE_TWIN) {
+    int is, card_base = info->priv[0].card_base;
+    while ((is = ~inb(card_base + TWIN_INT_REG)) &
+	   TWIN_INT_MSK) {
+      if (is & TWIN_SCC_MSK) {
+	z8530_isr(info);
+      } else if (is & TWIN_TMR1_MSK) {
+	inb(card_base + TWIN_CLR_TMR1);
+	tm_isr(&info->priv[0]);
+      } else {
+	inb(card_base + TWIN_CLR_TMR2);
+	tm_isr(&info->priv[1]);
+      }
+    }
+  } else z8530_isr(info);
+  spin_unlock(info->priv[0].register_lock);
+  return IRQ_HANDLED;
+}
+
+
 static void rx_isr(struct scc_priv *priv) {
   if (priv->param.dma >= 0) {
     /* Check special condition and perform error reset. See 2.4.7.5. */
@@ -1292,114 +1401,3 @@
     break;
   }
 }
-
-
-static inline void tx_on(struct scc_priv *priv) {
-  int i, n;
-  unsigned long flags;
-
-  if (priv->param.dma >= 0) {
-    n = (priv->chip == Z85230) ? 3 : 1;
-    /* Program DMA controller */
-    flags = claim_dma_lock();
-    set_dma_mode(priv->param.dma, DMA_MODE_WRITE);
-    set_dma_addr(priv->param.dma, (int) priv->tx_buf[priv->tx_tail]+n);
-    set_dma_count(priv->param.dma, priv->tx_len[priv->tx_tail]-n);
-    release_dma_lock(flags);
-    /* Enable TX underrun interrupt */
-    write_scc(priv, R15, TxUIE);
-    /* Configure DREQ */
-    if (priv->type == TYPE_TWIN)
-      outb((priv->param.dma == 1) ? TWIN_DMA_HDX_T1 : TWIN_DMA_HDX_T3,
-	   priv->card_base + TWIN_DMA_CFG);
-    else
-      write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN | WT_RDY_ENAB);
-    /* Write first byte(s) */
-    spin_lock_irqsave(priv->register_lock, flags);
-    for (i = 0; i < n; i++)
-      write_scc_data(priv, priv->tx_buf[priv->tx_tail][i], 1);
-    enable_dma(priv->param.dma);
-    spin_unlock_irqrestore(priv->register_lock, flags);
-  } else {
-    write_scc(priv, R15, TxUIE);
-    write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN | TxINT_ENAB);
-    tx_isr(priv);
-  }
-  /* Reset EOM latch if we do not have the AUTOEOM feature */
-  if (priv->chip == Z8530) write_scc(priv, R0, RES_EOM_L);
-}
-
-
-static inline void rx_on(struct scc_priv *priv) {
-  unsigned long flags;
-
-  /* Clear RX FIFO */
-  while (read_scc(priv, R0) & Rx_CH_AV) read_scc_data(priv);
-  priv->rx_over = 0;
-  if (priv->param.dma >= 0) {
-    /* Program DMA controller */
-    flags = claim_dma_lock();
-    set_dma_mode(priv->param.dma, DMA_MODE_READ);
-    set_dma_addr(priv->param.dma, (int) priv->rx_buf[priv->rx_head]);
-    set_dma_count(priv->param.dma, BUF_SIZE);
-    release_dma_lock(flags);
-    enable_dma(priv->param.dma);
-    /* Configure PackeTwin DMA */
-    if (priv->type == TYPE_TWIN) {
-      outb((priv->param.dma == 1) ? TWIN_DMA_HDX_R1 : TWIN_DMA_HDX_R3,
-	   priv->card_base + TWIN_DMA_CFG);
-    }
-    /* Sp. cond. intr. only, ext int enable, RX DMA enable */
-    write_scc(priv, R1, EXT_INT_ENAB | INT_ERR_Rx |
-	      WT_RDY_RT | WT_FN_RDYFN | WT_RDY_ENAB);
-  } else {
-    /* Reset current frame */
-    priv->rx_ptr = 0;
-    /* Intr. on all Rx characters and Sp. cond., ext int enable */
-    write_scc(priv, R1, EXT_INT_ENAB | INT_ALL_Rx | WT_RDY_RT |
-	      WT_FN_RDYFN);
-  }
-  write_scc(priv, R0, ERR_RES);
-  write_scc(priv, R3, RxENABLE | Rx8 | RxCRC_ENAB);
-}
-
-
-static inline void rx_off(struct scc_priv *priv) {
-  /* Disable receiver */
-  write_scc(priv, R3, Rx8);
-  /* Disable DREQ / RX interrupt */
-  if (priv->param.dma >= 0 && priv->type == TYPE_TWIN)
-    outb(0, priv->card_base + TWIN_DMA_CFG);
-  else
-    write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN);
-  /* Disable DMA */
-  if (priv->param.dma >= 0) disable_dma(priv->param.dma);
-}
-
-
-static void start_timer(struct scc_priv *priv, int t, int r15) {
-  unsigned long flags;
-
-  outb(priv->tmr_mode, priv->tmr_ctrl);
-  if (t == 0) {
-    tm_isr(priv);
-  } else if (t > 0) {
-    save_flags(flags);
-    cli();
-    outb(t & 0xFF, priv->tmr_cnt);
-    outb((t >> 8) & 0xFF, priv->tmr_cnt);
-    if (priv->type != TYPE_TWIN) {
-      write_scc(priv, R15, r15 | CTSIE);
-      priv->rr0 |= CTS;
-    }
-    restore_flags(flags);
-  }
-}
-
-
-static inline unsigned char random(void) {
-  /* See "Numerical Recipes in C", second edition, p. 284 */
-  rand = rand * 1664525L + 1013904223L;
-  return (unsigned char) (rand >> 24);
-}
-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

