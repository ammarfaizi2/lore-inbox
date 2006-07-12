Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWGLXSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWGLXSU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWGLXSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:18:20 -0400
Received: from havoc.gtf.org ([69.61.125.42]:2232 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751023AbWGLXSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:18:18 -0400
Date: Wed, 12 Jul 2006 19:18:13 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060712231813.GA5879@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/8139cp.c                        |    2 
 drivers/net/e1000/e1000_main.c              |    2 
 drivers/net/forcedeth.c                     |   49 +++-
 drivers/net/irda/smsc-ircc2.c               |    2 
 drivers/net/ixgb/ixgb_main.c                |    4 
 drivers/net/myri10ge/myri10ge.c             |   13 -
 drivers/net/s2io.c                          |  285 ++++++++++++++--------------
 drivers/net/s2io.h                          |    5 
 drivers/net/sk98lin/h/xmac_ii.h             |    2 
 drivers/net/skge.h                          |    4 
 drivers/net/sky2.c                          |   43 ++--
 drivers/net/sky2.h                          |    2 
 drivers/net/smc91x.h                        |   18 +
 drivers/net/wireless/bcm43xx/bcm43xx_main.c |    2 
 drivers/net/wireless/zd1211rw/zd_usb.c      |   12 -
 15 files changed, 253 insertions(+), 192 deletions(-)

Ananda Raju:
      s2io driver irq fix

Andrew Morton:
      e1000: irq naming update
      8139cp.c printk fix

Auke Kok:
      ixgb: fix tx unit hang - properly calculate desciptor count

Ayaz Abdulla:
      forcedeth: deferral fixup
      forcedeth: watermark fixup

Brice Goglin:
      myri10ge return value fix

Daniel Drake:
      zd1211rw: usb_clear_halt not allowed in IRQ context

Deepak Saxena:
      Update smc91x driver with ARM Versatile board info

Dmitry Torokhov:
      smsc-ircc2: fix section reference mismatches

Larry Finger:
      bcm43xx-softmac: Fix an off-by-one condition in handle_irq_noise

Stephen Hemminger:
      sky2: fix truncated collision threshold mask
      skge: fix truncated collision threshold mask
      sk98lin: fix truncated collision threshold mask
      sky2: sky2_reset section mismatch
      sky2: NAPI suspend/resume of dual port cards
      sky2: PHY power on delays
      sky2: optimize receive restart

diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
index d2150ba..1428bb7 100644
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -1916,7 +1916,7 @@ #endif
 	regs = ioremap(pciaddr, CP_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
-		dev_err(&pdev->dev, "Cannot map PCI MMIO (%lx@%lx)\n",
+		dev_err(&pdev->dev, "Cannot map PCI MMIO (%Lx@%Lx)\n",
 		       (unsigned long long)pci_resource_len(pdev, 1),
 		       (unsigned long long)pciaddr);
 		goto err_out_res;
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 6e7d31b..6d3d419 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -283,7 +283,7 @@ #ifdef CONFIG_PCI_MSI
 		}
 	}
 	if (adapter->have_msi)
-		flags &= ~SA_SHIRQ;
+		flags &= ~IRQF_SHARED;
 #endif
 	if ((err = request_irq(adapter->pdev->irq, &e1000_intr, flags,
 	                       netdev->name, netdev)))
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index ad81ec6..11b8f1b 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -240,10 +240,12 @@ #define NVREG_RNDSEED_FORCE	0x7f00
 #define NVREG_RNDSEED_FORCE2	0x2d00
 #define NVREG_RNDSEED_FORCE3	0x7400
 
-	NvRegUnknownSetupReg1 = 0xA0,
-#define NVREG_UNKSETUP1_VAL	0x16070f
-	NvRegUnknownSetupReg2 = 0xA4,
-#define NVREG_UNKSETUP2_VAL	0x16
+	NvRegTxDeferral = 0xA0,
+#define NVREG_TX_DEFERRAL_DEFAULT	0x15050f
+#define NVREG_TX_DEFERRAL_RGMII_10_100	0x16070f
+#define NVREG_TX_DEFERRAL_RGMII_1000	0x14050f
+	NvRegRxDeferral = 0xA4,
+#define NVREG_RX_DEFERRAL_DEFAULT	0x16
 	NvRegMacAddrA = 0xA8,
 	NvRegMacAddrB = 0xAC,
 	NvRegMulticastAddrA = 0xB0,
@@ -269,8 +271,10 @@ #define NVREG_LINKSPEED_1000	50
 #define NVREG_LINKSPEED_MASK	(0xFFF)
 	NvRegUnknownSetupReg5 = 0x130,
 #define NVREG_UNKSETUP5_BIT31	(1<<31)
-	NvRegUnknownSetupReg3 = 0x13c,
-#define NVREG_UNKSETUP3_VAL1	0x200010
+	NvRegTxWatermark = 0x13c,
+#define NVREG_TX_WM_DESC1_DEFAULT	0x0200010
+#define NVREG_TX_WM_DESC2_3_DEFAULT	0x1e08000
+#define NVREG_TX_WM_DESC2_3_1000	0xfe08000
 	NvRegTxRxControl = 0x144,
 #define NVREG_TXRXCTL_KICK	0x0001
 #define NVREG_TXRXCTL_BIT1	0x0002
@@ -658,7 +662,7 @@ static const struct register_test nv_reg
 	{ NvRegMisc1, 0x03c },
 	{ NvRegOffloadConfig, 0x03ff },
 	{ NvRegMulticastAddrA, 0xffffffff },
-	{ NvRegUnknownSetupReg3, 0x0ff },
+	{ NvRegTxWatermark, 0x0ff },
 	{ NvRegWakeUpFlags, 0x07777 },
 	{ 0,0 }
 };
@@ -2127,7 +2131,7 @@ static int nv_update_linkspeed(struct ne
 	int newdup = np->duplex;
 	int mii_status;
 	int retval = 0;
-	u32 control_1000, status_1000, phyreg, pause_flags;
+	u32 control_1000, status_1000, phyreg, pause_flags, txreg;
 
 	/* BMSR_LSTATUS is latched, read it twice:
 	 * we want the current value.
@@ -2245,6 +2249,26 @@ set_speed:
 		phyreg |= PHY_1000;
 	writel(phyreg, base + NvRegPhyInterface);
 
+	if (phyreg & PHY_RGMII) {
+		if ((np->linkspeed & NVREG_LINKSPEED_MASK) == NVREG_LINKSPEED_1000)
+			txreg = NVREG_TX_DEFERRAL_RGMII_1000;
+		else
+			txreg = NVREG_TX_DEFERRAL_RGMII_10_100;
+	} else {
+		txreg = NVREG_TX_DEFERRAL_DEFAULT;
+	}
+	writel(txreg, base + NvRegTxDeferral);
+
+	if (np->desc_ver == DESC_VER_1) {
+		txreg = NVREG_TX_WM_DESC1_DEFAULT;
+	} else {
+		if ((np->linkspeed & NVREG_LINKSPEED_MASK) == NVREG_LINKSPEED_1000)
+			txreg = NVREG_TX_WM_DESC2_3_1000;
+		else
+			txreg = NVREG_TX_WM_DESC2_3_DEFAULT;
+	}
+	writel(txreg, base + NvRegTxWatermark);
+
 	writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
 		base + NvRegMisc1);
 	pci_push(base);
@@ -3910,7 +3934,10 @@ static int nv_open(struct net_device *de
 
 	/* 5) continue setup */
 	writel(np->linkspeed, base + NvRegLinkSpeed);
-	writel(NVREG_UNKSETUP3_VAL1, base + NvRegUnknownSetupReg3);
+	if (np->desc_ver == DESC_VER_1)
+		writel(NVREG_TX_WM_DESC1_DEFAULT, base + NvRegTxWatermark);
+	else
+		writel(NVREG_TX_WM_DESC2_3_DEFAULT, base + NvRegTxWatermark);
 	writel(np->txrxctl_bits, base + NvRegTxRxControl);
 	writel(np->vlanctl_bits, base + NvRegVlanControl);
 	pci_push(base);
@@ -3932,8 +3959,8 @@ static int nv_open(struct net_device *de
 	writel(readl(base + NvRegReceiverStatus), base + NvRegReceiverStatus);
 	get_random_bytes(&i, sizeof(i));
 	writel(NVREG_RNDSEED_FORCE | (i&NVREG_RNDSEED_MASK), base + NvRegRandomSeed);
-	writel(NVREG_UNKSETUP1_VAL, base + NvRegUnknownSetupReg1);
-	writel(NVREG_UNKSETUP2_VAL, base + NvRegUnknownSetupReg2);
+	writel(NVREG_TX_DEFERRAL_DEFAULT, base + NvRegTxDeferral);
+	writel(NVREG_RX_DEFERRAL_DEFAULT, base + NvRegRxDeferral);
 	if (poll_interval == -1) {
 		if (optimization_mode == NV_OPTIMIZATION_MODE_THROUGHPUT)
 			writel(NVREG_POLL_DEFAULT_THROUGHPUT, base + NvRegPollingInterval);
diff --git a/drivers/net/irda/smsc-ircc2.c b/drivers/net/irda/smsc-ircc2.c
index a467404..2eff45b 100644
--- a/drivers/net/irda/smsc-ircc2.c
+++ b/drivers/net/irda/smsc-ircc2.c
@@ -2353,7 +2353,7 @@ static int __init smsc_superio_lpc(unsig
 #ifdef CONFIG_PCI
 #define PCIID_VENDOR_INTEL 0x8086
 #define PCIID_VENDOR_ALI 0x10b9
-static struct smsc_ircc_subsystem_configuration subsystem_configurations[] __devinitdata = {
+static struct smsc_ircc_subsystem_configuration subsystem_configurations[] __initdata = {
 	{
 		.vendor = PCIID_VENDOR_INTEL, /* Intel 82801DBM LPC bridge */
 		.device = 0x24cc,
diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
index 7eb08d9..7bbd447 100644
--- a/drivers/net/ixgb/ixgb_main.c
+++ b/drivers/net/ixgb/ixgb_main.c
@@ -1281,7 +1281,7 @@ ixgb_tx_map(struct ixgb_adapter *adapter
 
 	while(len) {
 		buffer_info = &tx_ring->buffer_info[i];
-		size = min(len, IXGB_MAX_JUMBO_FRAME_SIZE);
+		size = min(len, IXGB_MAX_DATA_PER_TXD);
 		buffer_info->length = size;
 		buffer_info->dma =
 			pci_map_single(adapter->pdev,
@@ -1306,7 +1306,7 @@ ixgb_tx_map(struct ixgb_adapter *adapter
 
 		while(len) {
 			buffer_info = &tx_ring->buffer_info[i];
-			size = min(len, IXGB_MAX_JUMBO_FRAME_SIZE);
+			size = min(len, IXGB_MAX_DATA_PER_TXD);
 			buffer_info->length = size;
 			buffer_info->dma =
 				pci_map_page(adapter->pdev,
diff --git a/drivers/net/myri10ge/myri10ge.c b/drivers/net/myri10ge/myri10ge.c
index ee1de97..07ca948 100644
--- a/drivers/net/myri10ge/myri10ge.c
+++ b/drivers/net/myri10ge/myri10ge.c
@@ -2412,14 +2412,20 @@ static int myri10ge_resume(struct pci_de
 		return -EIO;
 	}
 	myri10ge_restore_state(mgp);
-	pci_enable_device(pdev);
+
+	status = pci_enable_device(pdev);
+	if (status < 0) {
+		dev_err(&pdev->dev, "failed to enable device\n");
+		return -EIO;
+	}
+
 	pci_set_master(pdev);
 
 	status = request_irq(pdev->irq, myri10ge_intr, IRQF_SHARED,
 			     netdev->name, mgp);
 	if (status != 0) {
 		dev_err(&pdev->dev, "failed to allocate IRQ\n");
-		goto abort_with_msi;
+		goto abort_with_enabled;
 	}
 
 	myri10ge_reset(mgp);
@@ -2438,7 +2444,8 @@ static int myri10ge_resume(struct pci_de
 
 	return 0;
 
-abort_with_msi:
+abort_with_enabled:
+	pci_disable_device(pdev);
 	return -EIO;
 
 }
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index c6b77ac..e1fe3a0 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -1976,7 +1976,6 @@ static int start_nic(struct s2io_nic *ni
 	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	struct net_device *dev = nic->dev;
 	register u64 val64 = 0;
-	u16 interruptible;
 	u16 subid, i;
 	mac_info_t *mac_control;
 	struct config_param *config;
@@ -2047,16 +2046,6 @@ static int start_nic(struct s2io_nic *ni
 		return FAILURE;
 	}
 
-	/*  Enable select interrupts */
-	if (nic->intr_type != INTA)
-		en_dis_able_nic_intrs(nic, ENA_ALL_INTRS, DISABLE_INTRS);
-	else {
-		interruptible = TX_TRAFFIC_INTR | RX_TRAFFIC_INTR;
-		interruptible |= TX_PIC_INTR | RX_PIC_INTR;
-		interruptible |= TX_MAC_INTR | RX_MAC_INTR;
-		en_dis_able_nic_intrs(nic, interruptible, ENABLE_INTRS);
-	}
-
 	/*
 	 * With some switches, link might be already up at this point.
 	 * Because of this weird behavior, when we enable laser,
@@ -3749,101 +3738,19 @@ static int s2io_open(struct net_device *
 	if (err) {
 		DBG_PRINT(ERR_DBG, "%s: H/W initialization failed\n",
 			  dev->name);
-		if (err == -ENODEV)
-			goto hw_init_failed;
-		else
-			goto hw_enable_failed;
-	}
-
-	/* Store the values of the MSIX table in the nic_t structure */
-	store_xmsi_data(sp);
-
-	/* After proper initialization of H/W, register ISR */
-	if (sp->intr_type == MSI) {
-		err = request_irq((int) sp->pdev->irq, s2io_msi_handle, 
-			IRQF_SHARED, sp->name, dev);
-		if (err) {
-			DBG_PRINT(ERR_DBG, "%s: MSI registration \
-failed\n", dev->name);
-			goto isr_registration_failed;
-		}
-	}
-	if (sp->intr_type == MSI_X) {
-		int i;
-
-		for (i=1; (sp->s2io_entries[i].in_use == MSIX_FLG); i++) {
-			if (sp->s2io_entries[i].type == MSIX_FIFO_TYPE) {
-				sprintf(sp->desc1, "%s:MSI-X-%d-TX",
-					dev->name, i);
-				err = request_irq(sp->entries[i].vector,
-					  s2io_msix_fifo_handle, 0, sp->desc1,
-					  sp->s2io_entries[i].arg);
-				DBG_PRINT(ERR_DBG, "%s @ 0x%llx\n", sp->desc1, 
-				    (unsigned long long)sp->msix_info[i].addr);
-			} else {
-				sprintf(sp->desc2, "%s:MSI-X-%d-RX",
-					dev->name, i);
-				err = request_irq(sp->entries[i].vector,
-					  s2io_msix_ring_handle, 0, sp->desc2,
-					  sp->s2io_entries[i].arg);
-				DBG_PRINT(ERR_DBG, "%s @ 0x%llx\n", sp->desc2, 
-				     (unsigned long long)sp->msix_info[i].addr);
-			}
-			if (err) {
-				DBG_PRINT(ERR_DBG, "%s: MSI-X-%d registration \
-failed\n", dev->name, i);
-				DBG_PRINT(ERR_DBG, "Returned: %d\n", err);
-				goto isr_registration_failed;
-			}
-			sp->s2io_entries[i].in_use = MSIX_REGISTERED_SUCCESS;
-		}
-	}
-	if (sp->intr_type == INTA) {
-		err = request_irq((int) sp->pdev->irq, s2io_isr, IRQF_SHARED,
-				sp->name, dev);
-		if (err) {
-			DBG_PRINT(ERR_DBG, "%s: ISR registration failed\n",
-				  dev->name);
-			goto isr_registration_failed;
-		}
+		goto hw_init_failed;
 	}
 
 	if (s2io_set_mac_addr(dev, dev->dev_addr) == FAILURE) {
 		DBG_PRINT(ERR_DBG, "Set Mac Address Failed\n");
+		s2io_card_down(sp);
 		err = -ENODEV;
-		goto setting_mac_address_failed;
+		goto hw_init_failed;
 	}
 
 	netif_start_queue(dev);
 	return 0;
 
-setting_mac_address_failed:
-	if (sp->intr_type != MSI_X)
-		free_irq(sp->pdev->irq, dev);
-isr_registration_failed:
-	del_timer_sync(&sp->alarm_timer);
-	if (sp->intr_type == MSI_X) {
-		int i;
-		u16 msi_control; /* Temp variable */
-
-		for (i=1; (sp->s2io_entries[i].in_use == 
-				MSIX_REGISTERED_SUCCESS); i++) {
-			int vector = sp->entries[i].vector;
-			void *arg = sp->s2io_entries[i].arg;
-
-			free_irq(vector, arg);
-		}
-		pci_disable_msix(sp->pdev);
-
-		/* Temp */
-		pci_read_config_word(sp->pdev, 0x42, &msi_control);
-		msi_control &= 0xFFFE; /* Disable MSI */
-		pci_write_config_word(sp->pdev, 0x42, msi_control);
-	}
-	else if (sp->intr_type == MSI)
-		pci_disable_msi(sp->pdev);
-hw_enable_failed:
-	s2io_reset(sp);
 hw_init_failed:
 	if (sp->intr_type == MSI_X) {
 		if (sp->entries)
@@ -3874,7 +3781,7 @@ static int s2io_close(struct net_device 
 	flush_scheduled_work();
 	netif_stop_queue(dev);
 	/* Reset card, kill tasklet and free Tx and Rx buffers. */
-	s2io_card_down(sp, 1);
+	s2io_card_down(sp);
 
 	sp->device_close_flag = TRUE;	/* Device is shut down. */
 	return 0;
@@ -5919,7 +5826,7 @@ static int s2io_change_mtu(struct net_de
 
 	dev->mtu = new_mtu;
 	if (netif_running(dev)) {
-		s2io_card_down(sp, 0);
+		s2io_card_down(sp);
 		netif_stop_queue(dev);
 		if (s2io_card_up(sp)) {
 			DBG_PRINT(ERR_DBG, "%s: Device bring up failed\n",
@@ -6216,43 +6123,106 @@ static  int rxd_owner_bit_reset(nic_t *s
 
 }
 
-static void s2io_card_down(nic_t * sp, int flag)
+static int s2io_add_isr(nic_t * sp)
 {
-	int cnt = 0;
-	XENA_dev_config_t __iomem *bar0 = sp->bar0;
-	unsigned long flags;
-	register u64 val64 = 0;
+	int ret = 0;
 	struct net_device *dev = sp->dev;
+	int err = 0;
 
-	del_timer_sync(&sp->alarm_timer);
-	/* If s2io_set_link task is executing, wait till it completes. */
-	while (test_and_set_bit(0, &(sp->link_state))) {
-		msleep(50);
+	if (sp->intr_type == MSI)
+		ret = s2io_enable_msi(sp);
+	else if (sp->intr_type == MSI_X)
+		ret = s2io_enable_msi_x(sp);
+	if (ret) {
+		DBG_PRINT(ERR_DBG, "%s: Defaulting to INTA\n", dev->name);
+		sp->intr_type = INTA;
 	}
-	atomic_set(&sp->card_state, CARD_DOWN);
 
-	/* disable Tx and Rx traffic on the NIC */
-	stop_nic(sp);
-	if (flag) {
-		if (sp->intr_type == MSI_X) {
-			int i;
-			u16 msi_control;
+	/* Store the values of the MSIX table in the nic_t structure */
+	store_xmsi_data(sp);
 
-			for (i=1; (sp->s2io_entries[i].in_use ==
-				MSIX_REGISTERED_SUCCESS); i++) {
-				int vector = sp->entries[i].vector;
-				void *arg = sp->s2io_entries[i].arg;
+	/* After proper initialization of H/W, register ISR */
+	if (sp->intr_type == MSI) {
+		err = request_irq((int) sp->pdev->irq, s2io_msi_handle,
+			IRQF_SHARED, sp->name, dev);
+		if (err) {
+			pci_disable_msi(sp->pdev);
+			DBG_PRINT(ERR_DBG, "%s: MSI registration failed\n",
+				  dev->name);
+			return -1;
+		}
+	}
+	if (sp->intr_type == MSI_X) {
+		int i;
 
-				free_irq(vector, arg);
+		for (i=1; (sp->s2io_entries[i].in_use == MSIX_FLG); i++) {
+			if (sp->s2io_entries[i].type == MSIX_FIFO_TYPE) {
+				sprintf(sp->desc[i], "%s:MSI-X-%d-TX",
+					dev->name, i);
+				err = request_irq(sp->entries[i].vector,
+					  s2io_msix_fifo_handle, 0, sp->desc[i],
+						  sp->s2io_entries[i].arg);
+				DBG_PRINT(ERR_DBG, "%s @ 0x%llx\n", sp->desc[i],
+				(unsigned long long)sp->msix_info[i].addr);
+			} else {
+				sprintf(sp->desc[i], "%s:MSI-X-%d-RX",
+					dev->name, i);
+				err = request_irq(sp->entries[i].vector,
+					  s2io_msix_ring_handle, 0, sp->desc[i],
+						  sp->s2io_entries[i].arg);
+				DBG_PRINT(ERR_DBG, "%s @ 0x%llx\n", sp->desc[i],
+				(unsigned long long)sp->msix_info[i].addr);
 			}
-			pci_read_config_word(sp->pdev, 0x42, &msi_control);
-			msi_control &= 0xFFFE; /* Disable MSI */
-			pci_write_config_word(sp->pdev, 0x42, msi_control);
-			pci_disable_msix(sp->pdev);
-		} else {
-			free_irq(sp->pdev->irq, dev);
-			if (sp->intr_type == MSI)
-				pci_disable_msi(sp->pdev);
+			if (err) {
+				DBG_PRINT(ERR_DBG,"%s:MSI-X-%d registration "
+					  "failed\n", dev->name, i);
+				DBG_PRINT(ERR_DBG, "Returned: %d\n", err);
+				return -1;
+			}
+			sp->s2io_entries[i].in_use = MSIX_REGISTERED_SUCCESS;
+		}
+	}
+	if (sp->intr_type == INTA) {
+		err = request_irq((int) sp->pdev->irq, s2io_isr, IRQF_SHARED,
+				sp->name, dev);
+		if (err) {
+			DBG_PRINT(ERR_DBG, "%s: ISR registration failed\n",
+				  dev->name);
+			return -1;
+		}
+	}
+	return 0;
+}
+static void s2io_rem_isr(nic_t * sp)
+{
+	int cnt = 0;
+	struct net_device *dev = sp->dev;
+
+	if (sp->intr_type == MSI_X) {
+		int i;
+		u16 msi_control;
+
+		for (i=1; (sp->s2io_entries[i].in_use ==
+			MSIX_REGISTERED_SUCCESS); i++) {
+			int vector = sp->entries[i].vector;
+			void *arg = sp->s2io_entries[i].arg;
+
+			free_irq(vector, arg);
+		}
+		pci_read_config_word(sp->pdev, 0x42, &msi_control);
+		msi_control &= 0xFFFE; /* Disable MSI */
+		pci_write_config_word(sp->pdev, 0x42, msi_control);
+
+		pci_disable_msix(sp->pdev);
+	} else {
+		free_irq(sp->pdev->irq, dev);
+		if (sp->intr_type == MSI) {
+			u16 val;
+
+			pci_disable_msi(sp->pdev);
+			pci_read_config_word(sp->pdev, 0x4c, &val);
+			val ^= 0x1;
+			pci_write_config_word(sp->pdev, 0x4c, val);
 		}
 	}
 	/* Waiting till all Interrupt handlers are complete */
@@ -6263,6 +6233,26 @@ static void s2io_card_down(nic_t * sp, i
 			break;
 		cnt++;
 	} while(cnt < 5);
+}
+
+static void s2io_card_down(nic_t * sp)
+{
+	int cnt = 0;
+	XENA_dev_config_t __iomem *bar0 = sp->bar0;
+	unsigned long flags;
+	register u64 val64 = 0;
+
+	del_timer_sync(&sp->alarm_timer);
+	/* If s2io_set_link task is executing, wait till it completes. */
+	while (test_and_set_bit(0, &(sp->link_state))) {
+		msleep(50);
+	}
+	atomic_set(&sp->card_state, CARD_DOWN);
+
+	/* disable Tx and Rx traffic on the NIC */
+	stop_nic(sp);
+
+	s2io_rem_isr(sp);
 
 	/* Kill tasklet. */
 	tasklet_kill(&sp->task);
@@ -6314,23 +6304,16 @@ static int s2io_card_up(nic_t * sp)
 	mac_info_t *mac_control;
 	struct config_param *config;
 	struct net_device *dev = (struct net_device *) sp->dev;
+	u16 interruptible;
 
 	/* Initialize the H/W I/O registers */
 	if (init_nic(sp) != 0) {
 		DBG_PRINT(ERR_DBG, "%s: H/W initialization failed\n",
 			  dev->name);
+		s2io_reset(sp);
 		return -ENODEV;
 	}
 
-	if (sp->intr_type == MSI)
-		ret = s2io_enable_msi(sp);
-	else if (sp->intr_type == MSI_X)
-		ret = s2io_enable_msi_x(sp);
-	if (ret) {
-		DBG_PRINT(ERR_DBG, "%s: Defaulting to INTA\n", dev->name);
-		sp->intr_type = INTA;
-	}
-
 	/*
 	 * Initializing the Rx buffers. For now we are considering only 1
 	 * Rx ring and initializing buffers into 30 Rx blocks
@@ -6361,21 +6344,39 @@ static int s2io_card_up(nic_t * sp)
 			sp->lro_max_aggr_per_sess = lro_max_pkts;
 	}
 
-	/* Enable tasklet for the device */
-	tasklet_init(&sp->task, s2io_tasklet, (unsigned long) dev);
-
 	/* Enable Rx Traffic and interrupts on the NIC */
 	if (start_nic(sp)) {
 		DBG_PRINT(ERR_DBG, "%s: Starting NIC failed\n", dev->name);
-		tasklet_kill(&sp->task);
 		s2io_reset(sp);
-		free_irq(dev->irq, dev);
+		free_rx_buffers(sp);
+		return -ENODEV;
+	}
+
+	/* Add interrupt service routine */
+	if (s2io_add_isr(sp) != 0) {
+		if (sp->intr_type == MSI_X)
+			s2io_rem_isr(sp);
+		s2io_reset(sp);
 		free_rx_buffers(sp);
 		return -ENODEV;
 	}
 
 	S2IO_TIMER_CONF(sp->alarm_timer, s2io_alarm_handle, sp, (HZ/2));
 
+	/* Enable tasklet for the device */
+	tasklet_init(&sp->task, s2io_tasklet, (unsigned long) dev);
+
+	/*  Enable select interrupts */
+	if (sp->intr_type != INTA)
+		en_dis_able_nic_intrs(sp, ENA_ALL_INTRS, DISABLE_INTRS);
+	else {
+		interruptible = TX_TRAFFIC_INTR | RX_TRAFFIC_INTR;
+		interruptible |= TX_PIC_INTR | RX_PIC_INTR;
+		interruptible |= TX_MAC_INTR | RX_MAC_INTR;
+		en_dis_able_nic_intrs(sp, interruptible, ENABLE_INTRS);
+	}
+
+
 	atomic_set(&sp->card_state, CARD_UP);
 	return 0;
 }
@@ -6395,7 +6396,7 @@ static void s2io_restart_nic(unsigned lo
 	struct net_device *dev = (struct net_device *) data;
 	nic_t *sp = dev->priv;
 
-	s2io_card_down(sp, 0);
+	s2io_card_down(sp);
 	if (s2io_card_up(sp)) {
 		DBG_PRINT(ERR_DBG, "%s: Device bring up failed\n",
 			  dev->name);
diff --git a/drivers/net/s2io.h b/drivers/net/s2io.h
index c43f521..217097b 100644
--- a/drivers/net/s2io.h
+++ b/drivers/net/s2io.h
@@ -829,8 +829,7 @@ #define CARD_UP 2
 #define MSIX_FLG                0xA5
 	struct msix_entry *entries;
 	struct s2io_msix_entry *s2io_entries;
-	char desc1[35];
-	char desc2[35];
+	char desc[MAX_REQUESTED_MSI_X][25];
 
 	int avail_msix_vectors; /* No. of MSI-X vectors granted by system */
 
@@ -1002,7 +1001,7 @@ static int verify_xena_quiescence(nic_t 
 static struct ethtool_ops netdev_ethtool_ops;
 static void s2io_set_link(unsigned long data);
 static int s2io_set_swapper(nic_t * sp);
-static void s2io_card_down(nic_t *nic, int flag);
+static void s2io_card_down(nic_t *nic);
 static int s2io_card_up(nic_t *nic);
 static int get_xena_rev_id(struct pci_dev *pdev);
 static void restore_xmsi_data(nic_t *nic);
diff --git a/drivers/net/sk98lin/h/xmac_ii.h b/drivers/net/sk98lin/h/xmac_ii.h
index 2b19f8a..7f8e6d0 100644
--- a/drivers/net/sk98lin/h/xmac_ii.h
+++ b/drivers/net/sk98lin/h/xmac_ii.h
@@ -1473,7 +1473,7 @@ #define GM_GPCR_AU_ALL_DIS	(GM_GPCR_AU_D
 #define GM_TXCR_FORCE_JAM	(1<<15)	/* Bit 15:	Force Jam / Flow-Control */
 #define GM_TXCR_CRC_DIS		(1<<14)	/* Bit 14:	Disable insertion of CRC */
 #define GM_TXCR_PAD_DIS		(1<<13)	/* Bit 13:	Disable padding of packets */
-#define GM_TXCR_COL_THR_MSK	(1<<10)	/* Bit 12..10:	Collision Threshold */
+#define GM_TXCR_COL_THR_MSK	(7<<10)	/* Bit 12..10:	Collision Threshold */
 
 #define TX_COL_THR(x)		(SHIFT10(x) & GM_TXCR_COL_THR_MSK)
 
diff --git a/drivers/net/skge.h b/drivers/net/skge.h
index ed19ff4..593387b 100644
--- a/drivers/net/skge.h
+++ b/drivers/net/skge.h
@@ -1734,11 +1734,11 @@ enum {
 	GM_TXCR_FORCE_JAM	= 1<<15, /* Bit 15:	Force Jam / Flow-Control */
 	GM_TXCR_CRC_DIS		= 1<<14, /* Bit 14:	Disable insertion of CRC */
 	GM_TXCR_PAD_DIS		= 1<<13, /* Bit 13:	Disable padding of packets */
-	GM_TXCR_COL_THR_MSK	= 1<<10, /* Bit 12..10:	Collision Threshold */
+	GM_TXCR_COL_THR_MSK	= 7<<10, /* Bit 12..10:	Collision Threshold */
 };
 
 #define TX_COL_THR(x)		(((x)<<10) & GM_TXCR_COL_THR_MSK)
-#define TX_COL_DEF		0x04
+#define TX_COL_DEF		0x04	/* late collision after 64 byte */
 
 /*	GM_RX_CTRL			16 bit r/w	Receive Control Register */
 enum {
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index 3109376..d98f28c 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -65,6 +65,7 @@ #define RX_LE_BYTES		(RX_LE_SIZE*sizeof(
 #define RX_MAX_PENDING		(RX_LE_SIZE/2 - 2)
 #define RX_DEF_PENDING		RX_MAX_PENDING
 #define RX_SKB_ALIGN		8
+#define RX_BUF_WRITE		16
 
 #define TX_RING_SIZE		512
 #define TX_DEF_PENDING		(TX_RING_SIZE - 1)
@@ -234,7 +235,6 @@ static void sky2_set_power_state(struct 
 		}
 
 		if (hw->chip_id == CHIP_ID_YUKON_EC_U) {
-			sky2_write16(hw, B0_CTST, Y2_HW_WOL_ON);
 			sky2_pci_write32(hw, PCI_DEV_REG3, 0);
 			reg1 = sky2_pci_read32(hw, PCI_DEV_REG4);
 			reg1 &= P_ASPM_CONTROL_MSK;
@@ -243,6 +243,7 @@ static void sky2_set_power_state(struct 
 		}
 
 		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
+		udelay(100);
 
 		break;
 
@@ -255,6 +256,7 @@ static void sky2_set_power_state(struct 
 		else
 			reg1 |= (PCI_Y2_PHY1_POWD | PCI_Y2_PHY2_POWD);
 		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
+		udelay(100);
 
 		if (hw->chip_id == CHIP_ID_YUKON_XL && hw->chip_rev > 1)
 			sky2_write8(hw, B2_Y2_CLK_GATE, 0);
@@ -1389,7 +1391,7 @@ static void sky2_tx_complete(struct sky2
 	}
 
 	sky2->tx_cons = put;
-	if (tx_avail(sky2) > MAX_SKB_TX_LE)
+	if (tx_avail(sky2) > MAX_SKB_TX_LE + 4)
 		netif_wake_queue(dev);
 }
 
@@ -1888,9 +1890,6 @@ resubmit:
 	re->skb->ip_summed = CHECKSUM_NONE;
 	sky2_rx_add(sky2, re->mapaddr);
 
-	/* Tell receiver about new buffers. */
-	sky2_put_idx(sky2->hw, rxqaddr[sky2->port], sky2->rx_put);
-
 	return skb;
 
 oversize:
@@ -1937,7 +1936,9 @@ static inline int sky2_more_work(const s
 /* Process status response ring */
 static int sky2_status_intr(struct sky2_hw *hw, int to_do)
 {
+	struct sky2_port *sky2;
 	int work_done = 0;
+	unsigned buf_write[2] = { 0, 0 };
 	u16 hwidx = sky2_read16(hw, STAT_PUT_IDX);
 
 	rmb();
@@ -1945,7 +1946,6 @@ static int sky2_status_intr(struct sky2_
 	while (hw->st_idx != hwidx) {
 		struct sky2_status_le *le  = hw->st_le + hw->st_idx;
 		struct net_device *dev;
-		struct sky2_port *sky2;
 		struct sk_buff *skb;
 		u32 status;
 		u16 length;
@@ -1978,6 +1978,14 @@ #ifdef SKY2_VLAN_TAG_USED
 #endif
 				netif_receive_skb(skb);
 
+			/* Update receiver after 16 frames */
+			if (++buf_write[le->link] == RX_BUF_WRITE) {
+				sky2_put_idx(hw, rxqaddr[le->link],
+					     sky2->rx_put);
+				buf_write[le->link] = 0;
+			}
+
+			/* Stop after net poll weight */
 			if (++work_done >= to_do)
 				goto exit_loop;
 			break;
@@ -2016,6 +2024,16 @@ #endif
 	}
 
 exit_loop:
+	if (buf_write[0]) {
+		sky2 = netdev_priv(hw->dev[0]);
+		sky2_put_idx(hw, Q_R1, sky2->rx_put);
+	}
+
+	if (buf_write[1]) {
+		sky2 = netdev_priv(hw->dev[1]);
+		sky2_put_idx(hw, Q_R2, sky2->rx_put);
+	}
+
 	return work_done;
 }
 
@@ -2286,7 +2304,7 @@ static inline u32 sky2_clk2us(const stru
 }
 
 
-static int __devinit sky2_reset(struct sky2_hw *hw)
+static int sky2_reset(struct sky2_hw *hw)
 {
 	u16 status;
 	u8 t8, pmd_type;
@@ -3437,17 +3455,14 @@ static int sky2_suspend(struct pci_dev *
 		return -EINVAL;
 
 	del_timer_sync(&hw->idle_timer);
+	netif_poll_disable(hw->dev[0]);
 
 	for (i = 0; i < hw->ports; i++) {
 		struct net_device *dev = hw->dev[i];
 
-		if (dev) {
-			if (!netif_running(dev))
-				continue;
-
+		if (netif_running(dev)) {
 			sky2_down(dev);
 			netif_device_detach(dev);
-			netif_poll_disable(dev);
 		}
 	}
 
@@ -3474,9 +3489,8 @@ static int sky2_resume(struct pci_dev *p
 
 	for (i = 0; i < hw->ports; i++) {
 		struct net_device *dev = hw->dev[i];
-		if (dev && netif_running(dev)) {
+		if (netif_running(dev)) {
 			netif_device_attach(dev);
-			netif_poll_enable(dev);
 
 			err = sky2_up(dev);
 			if (err) {
@@ -3488,6 +3502,7 @@ static int sky2_resume(struct pci_dev *p
 		}
 	}
 
+	netif_poll_enable(hw->dev[0]);
 	sky2_idle_start(hw);
 out:
 	return err;
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index 8a0bc55..2db8d19 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -1480,7 +1480,7 @@ enum {
 	GM_TXCR_FORCE_JAM	= 1<<15, /* Bit 15:	Force Jam / Flow-Control */
 	GM_TXCR_CRC_DIS		= 1<<14, /* Bit 14:	Disable insertion of CRC */
 	GM_TXCR_PAD_DIS		= 1<<13, /* Bit 13:	Disable padding of packets */
-	GM_TXCR_COL_THR_MSK	= 1<<10, /* Bit 12..10:	Collision Threshold */
+	GM_TXCR_COL_THR_MSK	= 7<<10, /* Bit 12..10:	Collision Threshold */
 };
 
 #define TX_COL_THR(x)		(((x)<<10) & GM_TXCR_COL_THR_MSK)
diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index b402804..4ec4b4d 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -354,6 +354,24 @@ #define SMC_outsw(a, r, p, l)	\
 
 #define SMC_IRQ_FLAGS		(0)
 
+#elif	defined(CONFIG_ARCH_VERSATILE)
+
+#define SMC_CAN_USE_8BIT	1
+#define SMC_CAN_USE_16BIT	1
+#define SMC_CAN_USE_32BIT	1
+#define SMC_NOWAIT		1
+
+#define SMC_inb(a, r)		readb((a) + (r))
+#define SMC_inw(a, r)		readw((a) + (r))
+#define SMC_inl(a, r)		readl((a) + (r))
+#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
+#define SMC_outw(v, a, r)	writew(v, (a) + (r))
+#define SMC_outl(v, a, r)	writel(v, (a) + (r))
+#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
+#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
+
+#define SMC_IRQ_FLAGS		(0)
+
 #else
 
 #define SMC_CAN_USE_8BIT	1
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
index e1c5a93..3889f79 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -1547,7 +1547,7 @@ static void handle_irq_noise(struct bcm4
 		goto generate_new;
 
 	/* Get the noise samples. */
-	assert(bcm->noisecalc.nr_samples <= 8);
+	assert(bcm->noisecalc.nr_samples < 8);
 	i = bcm->noisecalc.nr_samples;
 	noise[0] = limit_value(noise[0], 0, ARRAY_SIZE(radio->nrssi_lt) - 1);
 	noise[1] = limit_value(noise[1], 0, ARRAY_SIZE(radio->nrssi_lt) - 1);
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.c b/drivers/net/wireless/zd1211rw/zd_usb.c
index ce1cb2c..72f9052 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zd1211rw/zd_usb.c
@@ -375,10 +375,8 @@ static void int_urb_complete(struct urb 
 	case -ENODEV:
 	case -ENOENT:
 	case -ECONNRESET:
-		goto kfree;
 	case -EPIPE:
-		usb_clear_halt(urb->dev, EP_INT_IN);
-		/* FALL-THROUGH */
+		goto kfree;
 	default:
 		goto resubmit;
 	}
@@ -580,10 +578,8 @@ static void rx_urb_complete(struct urb *
 	case -ENODEV:
 	case -ENOENT:
 	case -ECONNRESET:
-		return;
 	case -EPIPE:
-		usb_clear_halt(urb->dev, EP_DATA_IN);
-		/* FALL-THROUGH */
+		return;
 	default:
 		dev_dbg_f(urb_dev(urb), "urb %p error %d\n", urb, urb->status);
 		goto resubmit;
@@ -749,11 +745,9 @@ static void tx_urb_complete(struct urb *
 	case -ENODEV:
 	case -ENOENT:
 	case -ECONNRESET:
+	case -EPIPE:
 		dev_dbg_f(urb_dev(urb), "urb %p error %d\n", urb, urb->status);
 		break;
-	case -EPIPE:
-		usb_clear_halt(urb->dev, EP_DATA_OUT);
-		/* FALL-THROUGH */
 	default:
 		dev_dbg_f(urb_dev(urb), "urb %p error %d\n", urb, urb->status);
 		goto resubmit;
