Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030626AbVIBBXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbVIBBXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbVIBBXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:23:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28176 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030626AbVIBBXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:23:45 -0400
Date: Fri, 2 Sep 2005 03:23:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] drivers/net/wan/: possible cleanups
Message-ID: <20050902012343.GJ3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains possible cleanups including the following:
- make needlessly global code static
- #if 0 the following unused global function:
  - sdladrv.c: sdla_intde
- remove the following unused global variable:
  - lmc_media.c: lmc_t1_cables
- remove the following unneeded EXPORT_SYMBOL's:
  - cycx_drv.c: cycx_inten
  - sdladrv.c: sdla_inten
  - sdladrv.c: sdla_intde
  - sdladrv.c: sdla_intack
  - sdladrv.c: sdla_intr
  - syncppp.c: sppp_input
  - syncppp.c: sppp_change_mtu

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 31 May 2005
- 18 Apr 2005

 drivers/net/wan/cycx_drv.c      |    7 +-
 drivers/net/wan/cycx_main.c     |    2 
 drivers/net/wan/dscc4.c         |   14 ++---
 drivers/net/wan/farsync.c       |   24 ++++----
 drivers/net/wan/hdlc_fr.c       |    2 
 drivers/net/wan/lmc/lmc_debug.c |   10 +--
 drivers/net/wan/lmc/lmc_media.c |    8 --
 drivers/net/wan/pc300.h         |   16 -----
 drivers/net/wan/pc300_drv.c     |   87 ++++++++++++++++----------------
 drivers/net/wan/pc300_tty.c     |   18 +++---
 drivers/net/wan/sdla.c          |   20 +++----
 drivers/net/wan/sdladrv.c       |   16 ++---
 drivers/net/wan/syncppp.c       |   10 +--
 include/linux/cycx_drv.h        |    1 
 include/linux/sdladrv.h         |    4 -
 include/net/syncppp.h           |    1 
 16 files changed, 101 insertions(+), 139 deletions(-)

--- linux-2.6.11-rc3-mm2-full/include/linux/cycx_drv.h.old	2005-02-16 19:14:39.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/include/linux/cycx_drv.h	2005-02-16 19:14:46.000000000 +0100
@@ -60,6 +60,5 @@
 extern int cycx_poke(struct cycx_hw *hw, u32 addr, void *buf, u32 len);
 extern int cycx_exec(void __iomem *addr);
 
-extern void cycx_inten(struct cycx_hw *hw);
 extern void cycx_intr(struct cycx_hw *hw);
 #endif	/* _CYCX_DRV_H */
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/cycx_drv.c.old	2005-02-16 19:14:55.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/cycx_drv.c	2005-02-16 19:15:35.000000000 +0100
@@ -110,7 +110,7 @@
  *		< 0	error.
  * Context:	process */
 
-int __init cycx_drv_init(void)
+static int __init cycx_drv_init(void)
 {
 	printk(KERN_INFO "%s v%u.%u %s\n", fullname, MOD_VERSION, MOD_RELEASE,
 			 copyright);
@@ -120,7 +120,7 @@
 
 /* Module 'remove' entry point.
  * o release all remaining system resources */
-void cycx_drv_cleanup(void)
+static void cycx_drv_cleanup(void)
 {
 }
 
@@ -185,8 +185,7 @@
 }
 
 /* Enable interrupt generation.  */
-EXPORT_SYMBOL(cycx_inten);
-void cycx_inten(struct cycx_hw *hw)
+static void cycx_inten(struct cycx_hw *hw)
 {
 	writeb(0, hw->dpmbase);
 }
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/cycx_main.c.old	2005-02-16 19:46:47.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/cycx_main.c	2005-02-16 19:47:00.000000000 +0100
@@ -103,7 +103,7 @@
  *		< 0	error.
  * Context:	process
  */
-int __init cycx_init(void)
+static int __init cycx_init(void)
 {
 	int cnt, err = -ENOMEM;
 
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/farsync.c.old	2005-02-16 23:57:37.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/farsync.c	2005-02-17 00:00:26.000000000 +0100
@@ -74,11 +74,11 @@
 /*
  * Modules parameters and associated varaibles
  */
-int fst_txq_low = FST_LOW_WATER_MARK;
-int fst_txq_high = FST_HIGH_WATER_MARK;
-int fst_max_reads = 7;
-int fst_excluded_cards = 0;
-int fst_excluded_list[FST_MAX_CARDS];
+static int fst_txq_low = FST_LOW_WATER_MARK;
+static int fst_txq_high = FST_HIGH_WATER_MARK;
+static int fst_max_reads = 7;
+static int fst_excluded_cards = 0;
+static int fst_excluded_list[FST_MAX_CARDS];
 
 module_param(fst_txq_low, int, 0);
 module_param(fst_txq_high, int, 0);
@@ -572,13 +572,13 @@
 static void fst_process_tx_work_q(unsigned long work_q);
 static void fst_process_int_work_q(unsigned long work_q);
 
-DECLARE_TASKLET(fst_tx_task, fst_process_tx_work_q, 0);
-DECLARE_TASKLET(fst_int_task, fst_process_int_work_q, 0);
+static DECLARE_TASKLET(fst_tx_task, fst_process_tx_work_q, 0);
+static DECLARE_TASKLET(fst_int_task, fst_process_int_work_q, 0);
 
-struct fst_card_info *fst_card_array[FST_MAX_CARDS];
-spinlock_t fst_work_q_lock;
-u64 fst_work_txq;
-u64 fst_work_intq;
+static struct fst_card_info *fst_card_array[FST_MAX_CARDS];
+static spinlock_t fst_work_q_lock;
+static u64 fst_work_txq;
+static u64 fst_work_intq;
 
 static void
 fst_q_work_item(u64 * queue, int card_index)
@@ -1498,7 +1498,7 @@
  *      The interrupt service routine
  *      Dev_id is our fst_card_info pointer
  */
-irqreturn_t
+static irqreturn_t
 fst_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct fst_card_info *card;
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/hdlc_fr.c.old	2005-02-17 00:00:38.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/hdlc_fr.c	2005-02-17 00:00:46.000000000 +0100
@@ -347,7 +347,7 @@
 
 
 
-int pvc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+static int pvc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	pvc_device *pvc = dev_to_pvc(dev);
 	fr_proto_pvc_info info;
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/lmc/lmc_media.c.old	2005-02-17 00:02:29.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/lmc/lmc_media.c	2005-02-17 00:02:47.000000000 +0100
@@ -48,14 +48,6 @@
   */
 
 /*
- * For lack of a better place, put the SSI cable stuff here.
- */
-char *lmc_t1_cables[] = {
-  "V.10/RS423", "EIA530A", "reserved", "X.21", "V.35",
-  "EIA449/EIA530/V.36", "V.28/EIA232", "none", NULL
-};
-
-/*
  * protocol independent method.
  */
 static void lmc_set_protocol (lmc_softc_t * const, lmc_ctl_t *);
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/pc300.h.old	2005-02-17 00:03:07.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/pc300.h	2005-02-17 00:55:23.000000000 +0100
@@ -472,24 +472,8 @@
 
 #ifdef __KERNEL__
 /* Function Prototypes */
-int dma_buf_write(pc300_t *, int, ucchar *, int);
-int dma_buf_read(pc300_t *, int, struct sk_buff *);
 void tx_dma_start(pc300_t *, int);
-void rx_dma_start(pc300_t *, int);
-void tx_dma_stop(pc300_t *, int);
-void rx_dma_stop(pc300_t *, int);
-int cpc_queue_xmit(struct sk_buff *, struct net_device *);
-void cpc_net_rx(struct net_device *);
-void cpc_sca_status(pc300_t *, int);
-int cpc_change_mtu(struct net_device *, int);
-int cpc_ioctl(struct net_device *, struct ifreq *, int);
-int ch_config(pc300dev_t *);
-int rx_config(pc300dev_t *);
-int tx_config(pc300dev_t *);
-void cpc_opench(pc300dev_t *);
-void cpc_closech(pc300dev_t *);
 int cpc_open(struct net_device *dev);
-int cpc_close(struct net_device *dev);
 int cpc_set_media(hdlc_device *, int);
 #endif /* __KERNEL__ */
 
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/pc300_drv.c.old	2005-02-17 00:03:20.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/pc300_drv.c	2005-02-17 00:14:10.000000000 +0100
@@ -291,6 +291,7 @@
 static void plx_init(pc300_t *);
 static void cpc_trace(struct net_device *, struct sk_buff *, char);
 static int cpc_attach(struct net_device *, unsigned short, unsigned short);
+static int cpc_close(struct net_device *dev);
 
 #ifdef CONFIG_PC300_MLPPP
 void cpc_tty_init(pc300dev_t * dev);
@@ -437,7 +438,7 @@
 	printk("\n");
 }
 
-int dma_get_rx_frame_size(pc300_t * card, int ch)
+static int dma_get_rx_frame_size(pc300_t * card, int ch)
 {
 	volatile pcsca_bd_t __iomem *ptdescr;
 	ucshort first_bd = card->chan[ch].rx_first_bd;
@@ -462,7 +463,7 @@
  * dma_buf_write: writes a frame to the Tx DMA buffers
  * NOTE: this function writes one frame at a time.
  */
-int dma_buf_write(pc300_t * card, int ch, ucchar * ptdata, int len)
+static int dma_buf_write(pc300_t * card, int ch, ucchar * ptdata, int len)
 {
 	int i, nchar;
 	volatile pcsca_bd_t __iomem *ptdescr;
@@ -503,7 +504,7 @@
  * dma_buf_read: reads a frame from the Rx DMA buffers
  * NOTE: this function reads one frame at a time.
  */
-int dma_buf_read(pc300_t * card, int ch, struct sk_buff *skb)
+static int dma_buf_read(pc300_t * card, int ch, struct sk_buff *skb)
 {
 	int nchar;
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
@@ -560,7 +561,7 @@
 	return (rcvd);
 }
 
-void tx_dma_stop(pc300_t * card, int ch)
+static void tx_dma_stop(pc300_t * card, int ch)
 {
 	void __iomem *scabase = card->hw.scabase;
 	ucchar drr_ena_bit = 1 << (5 + 2 * ch);
@@ -571,7 +572,7 @@
 	cpc_writeb(scabase + DRR, drr_rst_bit & ~drr_ena_bit);
 }
 
-void rx_dma_stop(pc300_t * card, int ch)
+static void rx_dma_stop(pc300_t * card, int ch)
 {
 	void __iomem *scabase = card->hw.scabase;
 	ucchar drr_ena_bit = 1 << (4 + 2 * ch);
@@ -582,7 +583,7 @@
 	cpc_writeb(scabase + DRR, drr_rst_bit & ~drr_ena_bit);
 }
 
-void rx_dma_start(pc300_t * card, int ch)
+static void rx_dma_start(pc300_t * card, int ch)
 {
 	void __iomem *scabase = card->hw.scabase;
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
@@ -607,7 +608,7 @@
 /*************************/
 /***   FALC Routines   ***/
 /*************************/
-void falc_issue_cmd(pc300_t * card, int ch, ucchar cmd)
+static void falc_issue_cmd(pc300_t * card, int ch, ucchar cmd)
 {
 	void __iomem *falcbase = card->hw.falcbase;
 	unsigned long i = 0;
@@ -622,7 +623,7 @@
 	cpc_writeb(falcbase + F_REG(CMDR, ch), cmd);
 }
 
-void falc_intr_enable(pc300_t * card, int ch)
+static void falc_intr_enable(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -672,7 +673,7 @@
 	}
 }
 
-void falc_open_timeslot(pc300_t * card, int ch, int timeslot)
+static void falc_open_timeslot(pc300_t * card, int ch, int timeslot)
 {
 	void __iomem *falcbase = card->hw.falcbase;
 	ucchar tshf = card->chan[ch].falc.offset;
@@ -688,7 +689,7 @@
 			(0x80 >> (timeslot & 0x07)));
 }
 
-void falc_close_timeslot(pc300_t * card, int ch, int timeslot)
+static void falc_close_timeslot(pc300_t * card, int ch, int timeslot)
 {
 	void __iomem *falcbase = card->hw.falcbase;
 	ucchar tshf = card->chan[ch].falc.offset;
@@ -704,7 +705,7 @@
 		   ~(0x80 >> (timeslot & 0x07)));
 }
 
-void falc_close_all_timeslots(pc300_t * card, int ch)
+static void falc_close_all_timeslots(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -726,7 +727,7 @@
 	}
 }
 
-void falc_open_all_timeslots(pc300_t * card, int ch)
+static void falc_open_all_timeslots(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -758,7 +759,7 @@
 	}
 }
 
-void falc_init_timeslot(pc300_t * card, int ch)
+static void falc_init_timeslot(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -776,7 +777,7 @@
 	}
 }
 
-void falc_enable_comm(pc300_t * card, int ch)
+static void falc_enable_comm(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	falc_t *pfalc = (falc_t *) & chan->falc;
@@ -792,7 +793,7 @@
 		   ~((CPLD_REG1_FALC_DCD | CPLD_REG1_FALC_CTS) << (2 * ch)));
 }
 
-void falc_disable_comm(pc300_t * card, int ch)
+static void falc_disable_comm(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	falc_t *pfalc = (falc_t *) & chan->falc;
@@ -806,7 +807,7 @@
 		   ((CPLD_REG1_FALC_DCD | CPLD_REG1_FALC_CTS) << (2 * ch)));
 }
 
-void falc_init_t1(pc300_t * card, int ch)
+static void falc_init_t1(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -975,7 +976,7 @@
 	falc_close_all_timeslots(card, ch);
 }
 
-void falc_init_e1(pc300_t * card, int ch)
+static void falc_init_e1(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1155,7 +1156,7 @@
 	falc_close_all_timeslots(card, ch);
 }
 
-void falc_init_hdlc(pc300_t * card, int ch)
+static void falc_init_hdlc(pc300_t * card, int ch)
 {
 	void __iomem *falcbase = card->hw.falcbase;
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
@@ -1181,7 +1182,7 @@
 	falc_intr_enable(card, ch);
 }
 
-void te_config(pc300_t * card, int ch)
+static void te_config(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1241,7 +1242,7 @@
 	CPC_UNLOCK(card, flags);
 }
 
-void falc_check_status(pc300_t * card, int ch, unsigned char frs0)
+static void falc_check_status(pc300_t * card, int ch, unsigned char frs0)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1397,7 +1398,7 @@
 	}
 }
 
-void falc_update_stats(pc300_t * card, int ch)
+static void falc_update_stats(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1450,7 +1451,7 @@
  *		the synchronizer and then sent to the system interface.
  *----------------------------------------------------------------------------
  */
-void falc_remote_loop(pc300_t * card, int ch, int loop_on)
+static void falc_remote_loop(pc300_t * card, int ch, int loop_on)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1495,7 +1496,7 @@
  *		coding must be identical.
  *----------------------------------------------------------------------------
  */
-void falc_local_loop(pc300_t * card, int ch, int loop_on)
+static void falc_local_loop(pc300_t * card, int ch, int loop_on)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	falc_t *pfalc = (falc_t *) & chan->falc;
@@ -1522,7 +1523,7 @@
  *		looped. They are originated by the FALC-LH transmitter.
  *----------------------------------------------------------------------------
  */
-void falc_payload_loop(pc300_t * card, int ch, int loop_on)
+static void falc_payload_loop(pc300_t * card, int ch, int loop_on)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1576,7 +1577,7 @@
  * Description:	Turns XLU bit off in the proper register
  *----------------------------------------------------------------------------
  */
-void turn_off_xlu(pc300_t * card, int ch)
+static void turn_off_xlu(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1597,7 +1598,7 @@
  * Description: Turns XLD bit off in the proper register
  *----------------------------------------------------------------------------
  */
-void turn_off_xld(pc300_t * card, int ch)
+static void turn_off_xld(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1619,7 +1620,7 @@
  *		to generate a LOOP activation code over a T1/E1 line.
  *----------------------------------------------------------------------------
  */
-void falc_generate_loop_up_code(pc300_t * card, int ch)
+static void falc_generate_loop_up_code(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1652,7 +1653,7 @@
  *		to generate a LOOP deactivation code over a T1/E1 line.
  *----------------------------------------------------------------------------
  */
-void falc_generate_loop_down_code(pc300_t * card, int ch)
+static void falc_generate_loop_down_code(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1682,7 +1683,7 @@
  *		it on the reception side.
  *----------------------------------------------------------------------------
  */
-void falc_pattern_test(pc300_t * card, int ch, unsigned int activate)
+static void falc_pattern_test(pc300_t * card, int ch, unsigned int activate)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -1729,7 +1730,7 @@
  * Description:	This routine returns the bit error counter value
  *----------------------------------------------------------------------------
  */
-ucshort falc_pattern_test_error(pc300_t * card, int ch)
+static ucshort falc_pattern_test_error(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = (pc300ch_t *) & card->chan[ch];
 	falc_t *pfalc = (falc_t *) & chan->falc;
@@ -1769,7 +1770,7 @@
 	netif_rx(skb);
 }
 
-void cpc_tx_timeout(struct net_device *dev)
+static void cpc_tx_timeout(struct net_device *dev)
 {
 	pc300dev_t *d = (pc300dev_t *) dev->priv;
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
@@ -1797,7 +1798,7 @@
 	netif_wake_queue(dev);
 }
 
-int cpc_queue_xmit(struct sk_buff *skb, struct net_device *dev)
+static int cpc_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	pc300dev_t *d = (pc300dev_t *) dev->priv;
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
@@ -1880,7 +1881,7 @@
 	return 0;
 }
 
-void cpc_net_rx(struct net_device *dev)
+static void cpc_net_rx(struct net_device *dev)
 {
 	pc300dev_t *d = (pc300dev_t *) dev->priv;
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
@@ -2403,7 +2404,7 @@
 	return IRQ_HANDLED;
 }
 
-void cpc_sca_status(pc300_t * card, int ch)
+static void cpc_sca_status(pc300_t * card, int ch)
 {
 	ucchar ilar;
 	void __iomem *scabase = card->hw.scabase;
@@ -2495,7 +2496,7 @@
 	}
 }
 
-void cpc_falc_status(pc300_t * card, int ch)
+static void cpc_falc_status(pc300_t * card, int ch)
 {
 	pc300ch_t *chan = &card->chan[ch];
 	falc_t *pfalc = (falc_t *) & chan->falc;
@@ -2523,7 +2524,7 @@
 	CPC_UNLOCK(card, flags);
 }
 
-int cpc_change_mtu(struct net_device *dev, int new_mtu)
+static int cpc_change_mtu(struct net_device *dev, int new_mtu)
 {
 	if ((new_mtu < 128) || (new_mtu > PC300_DEF_MTU))
 		return -EINVAL;
@@ -2531,7 +2532,7 @@
 	return 0;
 }
 
-int cpc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+static int cpc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	pc300dev_t *d = (pc300dev_t *) dev->priv;
@@ -2856,7 +2857,7 @@
 	}
 }
 
-int ch_config(pc300dev_t * d)
+static int ch_config(pc300dev_t * d)
 {
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
@@ -3004,7 +3005,7 @@
 	return 0;
 }
 
-int rx_config(pc300dev_t * d)
+static int rx_config(pc300dev_t * d)
 {
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
 	pc300_t *card = (pc300_t *) chan->card;
@@ -3035,7 +3036,7 @@
 	return 0;
 }
 
-int tx_config(pc300dev_t * d)
+static int tx_config(pc300dev_t * d)
 {
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
 	pc300_t *card = (pc300_t *) chan->card;
@@ -3098,7 +3099,7 @@
 	return 0;
 }
 
-void cpc_opench(pc300dev_t * d)
+static void cpc_opench(pc300dev_t * d)
 {
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
 	pc300_t *card = (pc300_t *) chan->card;
@@ -3116,7 +3117,7 @@
 		   cpc_readb(scabase + M_REG(CTL, ch)) & ~(CTL_RTS | CTL_DTR));
 }
 
-void cpc_closech(pc300dev_t * d)
+static void cpc_closech(pc300dev_t * d)
 {
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
 	pc300_t *card = (pc300_t *) chan->card;
@@ -3173,7 +3174,7 @@
 	return 0;
 }
 
-int cpc_close(struct net_device *dev)
+static int cpc_close(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	pc300dev_t *d = (pc300dev_t *) dev->priv;
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/sdla.c.old	2005-02-17 00:15:50.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/sdla.c	2005-02-17 00:17:56.000000000 +0100
@@ -182,7 +182,7 @@
 	return(byte);
 }
 
-void sdla_stop(struct net_device *dev)
+static void sdla_stop(struct net_device *dev)
 {
 	struct frad_local *flp;
 
@@ -209,7 +209,7 @@
 	}
 }
 
-void sdla_start(struct net_device *dev)
+static void sdla_start(struct net_device *dev)
 {
 	struct frad_local *flp;
 
@@ -247,7 +247,7 @@
  *
  ***************************************************/
 
-int sdla_z80_poll(struct net_device *dev, int z80_addr, int jiffs, char resp1, char resp2)
+static int sdla_z80_poll(struct net_device *dev, int z80_addr, int jiffs, char resp1, char resp2)
 {
 	unsigned long start, done, now;
 	char          resp, *temp;
@@ -505,7 +505,7 @@
 
 static int sdla_reconfig(struct net_device *dev);
 
-int sdla_activate(struct net_device *slave, struct net_device *master)
+static int sdla_activate(struct net_device *slave, struct net_device *master)
 {
 	struct frad_local *flp;
 	int i;
@@ -527,7 +527,7 @@
 	return(0);
 }
 
-int sdla_deactivate(struct net_device *slave, struct net_device *master)
+static int sdla_deactivate(struct net_device *slave, struct net_device *master)
 {
 	struct frad_local *flp;
 	int               i;
@@ -549,7 +549,7 @@
 	return(0);
 }
 
-int sdla_assoc(struct net_device *slave, struct net_device *master)
+static int sdla_assoc(struct net_device *slave, struct net_device *master)
 {
 	struct frad_local *flp;
 	int               i;
@@ -585,7 +585,7 @@
 	return(0);
 }
 
-int sdla_deassoc(struct net_device *slave, struct net_device *master)
+static int sdla_deassoc(struct net_device *slave, struct net_device *master)
 {
 	struct frad_local *flp;
 	int               i;
@@ -613,7 +613,7 @@
 	return(0);
 }
 
-int sdla_dlci_conf(struct net_device *slave, struct net_device *master, int get)
+static int sdla_dlci_conf(struct net_device *slave, struct net_device *master, int get)
 {
 	struct frad_local *flp;
 	struct dlci_local *dlp;
@@ -1324,7 +1324,7 @@
 	return(0);
 }
 
-int sdla_change_mtu(struct net_device *dev, int new_mtu)
+static int sdla_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct frad_local *flp;
 
@@ -1337,7 +1337,7 @@
 	return(-EOPNOTSUPP);
 }
 
-int sdla_set_config(struct net_device *dev, struct ifmap *map)
+static int sdla_set_config(struct net_device *dev, struct ifmap *map)
 {
 	struct frad_local *flp;
 	int               i;
--- linux-2.6.11-rc3-mm2-full/include/linux/sdladrv.h.old	2005-02-17 00:18:15.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/include/linux/sdladrv.h	2005-02-17 00:19:47.000000000 +0100
@@ -52,12 +52,8 @@
 
 extern int sdla_setup	(sdlahw_t* hw, void* sfm, unsigned len);
 extern int sdla_down	(sdlahw_t* hw);
-extern int sdla_inten	(sdlahw_t* hw);
-extern int sdla_intde	(sdlahw_t* hw);
-extern int sdla_intack	(sdlahw_t* hw);
 extern void S514_intack  (sdlahw_t* hw, u32 int_status);
 extern void read_S514_int_stat (sdlahw_t* hw, u32* int_status);
-extern int sdla_intr	(sdlahw_t* hw);
 extern int sdla_mapmem	(sdlahw_t* hw, unsigned long addr);
 extern int sdla_peek	(sdlahw_t* hw, unsigned long addr, void* buf,
 			 unsigned len);
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/sdladrv.c.old	2005-02-17 00:18:30.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/sdladrv.c	2005-02-17 00:20:04.000000000 +0100
@@ -642,9 +642,7 @@
  * Enable interrupt generation.
  */
 
-EXPORT_SYMBOL(sdla_inten);
-
-int sdla_inten (sdlahw_t* hw)
+static int sdla_inten (sdlahw_t* hw)
 {
 	unsigned port = hw->port;
 	int tmp, i;
@@ -698,8 +696,7 @@
  * Disable interrupt generation.
  */
 
-EXPORT_SYMBOL(sdla_intde);
-
+#if 0
 int sdla_intde (sdlahw_t* hw)
 {
 	unsigned port = hw->port;
@@ -748,14 +745,13 @@
 	}
 	return 0;
 }
+#endif  /*  0  */
 
 /*============================================================================
  * Acknowledge SDLA hardware interrupt.
  */
 
-EXPORT_SYMBOL(sdla_intack);
-
-int sdla_intack (sdlahw_t* hw)
+static int sdla_intack (sdlahw_t* hw)
 {
 	unsigned port = hw->port;
 	int tmp;
@@ -827,8 +823,7 @@
  * Generate an interrupt to adapter's CPU.
  */
 
-EXPORT_SYMBOL(sdla_intr);
-
+#if 0
 int sdla_intr (sdlahw_t* hw)
 {
 	unsigned port = hw->port;
@@ -863,6 +858,7 @@
 	}
 	return 0;
 }
+#endif  /*  0  */
 
 /*============================================================================
  * Execute Adapter Command.
--- linux-2.6.11-rc3-mm2-full/include/net/syncppp.h.old	2005-02-17 00:20:19.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/include/net/syncppp.h	2005-02-17 00:20:25.000000000 +0100
@@ -86,7 +86,6 @@
 
 void sppp_attach (struct ppp_device *pd);
 void sppp_detach (struct net_device *dev);
-void sppp_input (struct net_device *dev, struct sk_buff *m);
 int sppp_do_ioctl (struct net_device *dev, struct ifreq *ifr, int cmd);
 struct sk_buff *sppp_dequeue (struct net_device *dev);
 int sppp_isempty (struct net_device *dev);
--- linux-2.6.11-rc3-mm2-full/drivers/net/wan/syncppp.c.old	2005-02-17 00:20:36.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wan/syncppp.c	2005-02-17 00:21:37.000000000 +0100
@@ -221,7 +221,7 @@
  *	here.
  */
  
-void sppp_input (struct net_device *dev, struct sk_buff *skb)
+static void sppp_input (struct net_device *dev, struct sk_buff *skb)
 {
 	struct ppp_header *h;
 	struct sppp *sp = (struct sppp *)sppp_of(dev);
@@ -355,8 +355,6 @@
 	return;
 }
 
-EXPORT_SYMBOL(sppp_input);
-
 /*
  *	Handle transmit packets.
  */
@@ -990,7 +988,7 @@
  *	the mtu is out of range.
  */
  
-int sppp_change_mtu(struct net_device *dev, int new_mtu)
+static int sppp_change_mtu(struct net_device *dev, int new_mtu)
 {
 	if(new_mtu<128||new_mtu>PPP_MTU||(dev->flags&IFF_UP))
 		return -EINVAL;
@@ -998,8 +996,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(sppp_change_mtu);
-
 /**
  *	sppp_do_ioctl - Ioctl handler for ppp/hdlc
  *	@dev: Device subject to ioctl
@@ -1455,7 +1451,7 @@
 	return 0;
 }
 
-struct packet_type sppp_packet_type = {
+static struct packet_type sppp_packet_type = {
 	.type	= __constant_htons(ETH_P_WAN_PPP),
 	.func	= sppp_rcv,
 };
--- linux-2.6.12-rc2-mm3-full/drivers/net/wan/lmc/lmc_debug.c.old	2005-04-18 22:42:50.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/wan/lmc/lmc_debug.c	2005-04-18 22:44:32.000000000 +0200
@@ -8,10 +8,10 @@
 /*
  * Prints out len, max to 80 octets using printk, 20 per line
  */
-void lmcConsoleLog(char *type, unsigned char *ucData, int iLen)
-{
 #ifdef DEBUG
 #ifdef LMC_PACKET_LOG
+void lmcConsoleLog(char *type, unsigned char *ucData, int iLen)
+{
   int iNewLine = 1;
   char str[80], *pstr;
   
@@ -43,26 +43,24 @@
     }
   sprintf(pstr, "\n");
   printk(str);
+}
 #endif
 #endif
-}
 
 #ifdef DEBUG
 u_int32_t lmcEventLogIndex = 0;
 u_int32_t lmcEventLogBuf[LMC_EVENTLOGSIZE * LMC_EVENTLOGARGS];
-#endif
 
 void lmcEventLog (u_int32_t EventNum, u_int32_t arg2, u_int32_t arg3)
 {
-#ifdef DEBUG
   lmcEventLogBuf[lmcEventLogIndex++] = EventNum;
   lmcEventLogBuf[lmcEventLogIndex++] = arg2;
   lmcEventLogBuf[lmcEventLogIndex++] = arg3;
   lmcEventLogBuf[lmcEventLogIndex++] = jiffies;
 
   lmcEventLogIndex &= (LMC_EVENTLOGSIZE * LMC_EVENTLOGARGS) - 1;
-#endif
 }
+#endif  /*  DEBUG  */
 
 void lmc_trace(struct net_device *dev, char *msg){
 #ifdef LMC_TRACE
--- linux-2.6.12-rc2-mm3-full/drivers/net/wan/pc300_tty.c.old	2005-04-18 22:45:21.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/wan/pc300_tty.c	2005-04-18 22:46:51.000000000 +0200
@@ -112,10 +112,10 @@
 static struct tty_driver serial_drv;
 
 /* local variables */
-st_cpc_tty_area	cpc_tty_area[CPC_TTY_NPORTS];
+static st_cpc_tty_area	cpc_tty_area[CPC_TTY_NPORTS];
 
-int cpc_tty_cnt=0;	/* number of intrfaces configured with MLPPP */
-int cpc_tty_unreg_flag = 0;
+static int cpc_tty_cnt = 0;	/* number of intrfaces configured with MLPPP */
+static int cpc_tty_unreg_flag = 0;
 
 /* TTY functions prototype */
 static int cpc_tty_open(struct tty_struct *tty, struct file *flip);
@@ -132,9 +132,9 @@
 static void cpc_tty_signal_off(pc300dev_t *pc300dev, unsigned char);
 static void cpc_tty_signal_on(pc300dev_t *pc300dev, unsigned char);
 
-int pc300_tiocmset(struct tty_struct *, struct file *,
-			unsigned int, unsigned int);
-int pc300_tiocmget(struct tty_struct *, struct file *);
+static int pc300_tiocmset(struct tty_struct *, struct file *,
+			  unsigned int, unsigned int);
+static int pc300_tiocmget(struct tty_struct *, struct file *);
 
 /* functions called by PC300 driver */
 void cpc_tty_init(pc300dev_t *dev);
@@ -540,8 +540,8 @@
 	return(0); 
 } 
 
-int pc300_tiocmset(struct tty_struct *tty, struct file *file,
-			unsigned int set, unsigned int clear)
+static int pc300_tiocmset(struct tty_struct *tty, struct file *file,
+			  unsigned int set, unsigned int clear)
 {
 	st_cpc_tty_area    *cpc_tty; 
 
@@ -567,7 +567,7 @@
 	return 0;
 }
 
-int pc300_tiocmget(struct tty_struct *tty, struct file *file)
+static int pc300_tiocmget(struct tty_struct *tty, struct file *file)
 {
 	unsigned int result;
 	unsigned char status;
--- linux-2.6.12-rc2-mm3-full/drivers/net/wan/dscc4.c.old	2005-04-18 23:16:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/wan/dscc4.c	2005-04-18 23:18:21.000000000 +0200
@@ -446,8 +446,8 @@
 	return readl(dpriv->base_addr + CH0FTDA + dpriv->dev_id*4) == dpriv->ltda;
 }
 
-int state_check(u32 state, struct dscc4_dev_priv *dpriv, struct net_device *dev,
-		const char *msg)
+static int state_check(u32 state, struct dscc4_dev_priv *dpriv,
+		       struct net_device *dev, const char *msg)
 {
 	int ret = 0;
 
@@ -466,8 +466,9 @@
 	return ret;
 }
 
-void dscc4_tx_print(struct net_device *dev, struct dscc4_dev_priv *dpriv,
-		    char *msg)
+static void dscc4_tx_print(struct net_device *dev,
+			   struct dscc4_dev_priv *dpriv,
+			   char *msg)
 {
 	printk(KERN_DEBUG "%s: tx_current=%02d tx_dirty=%02d (%s)\n",
 	       dev->name, dpriv->tx_current, dpriv->tx_dirty, msg);
@@ -507,7 +508,8 @@
 	}
 }
 
-inline int try_get_rx_skb(struct dscc4_dev_priv *dpriv, struct net_device *dev)
+static inline int try_get_rx_skb(struct dscc4_dev_priv *dpriv,
+				 struct net_device *dev)
 {
 	unsigned int dirty = dpriv->rx_dirty%RX_RING_SIZE;
 	struct RxFD *rx_fd = dpriv->rx_fd + dirty;
@@ -1894,7 +1896,7 @@
  * It failed and locked solid. Thus the introduction of a dummy skb.
  * Problem is acknowledged in errata sheet DS5. Joy :o/
  */
-struct sk_buff *dscc4_init_dummy_skb(struct dscc4_dev_priv *dpriv)
+static struct sk_buff *dscc4_init_dummy_skb(struct dscc4_dev_priv *dpriv)
 {
 	struct sk_buff *skb;
 

