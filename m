Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWFUUNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWFUUNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWFUUNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:13:47 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:54185 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1751559AbWFUUNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:13:44 -0400
X-ASG-Debug-ID: 1150919451-14551-8-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
Date: Wed, 21 Jun 2006 15:50:49 -0400 (EDT)
From: Ananda Raju <Ananda.Raju@neterion.com>
To: netdev@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
cc: dgc@sgi.com, balbir@in.ibm.com, viro@zeniv.linux.org.uk, neilb@suse.de,
       jblunck@suse.de, tglx@linutronix.de, ananda.raju@neterion.com,
       leonid.grossman@neterion.com, ravinandan.arakali@neterion.com,
       alicia.pena@neterion.com
X-ASG-Orig-Subj: [patch 2.6.17] s2io driver irq fix
Subject: [patch 2.6.17] s2io driver irq fix
Message-ID: <Pine.GSO.4.10.10606211537540.23949-100000@guinness>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
	This patch contains the modification and bug fixes with respect to 
	irq registration. Following is brief description of the changes.

	1. Enable interrupts after request_irq
	2. Restored MSI data register value at driver unload time

Signed-off-by: Ananda Raju <ananda.raju@neterion.com>
---
diff -upNr netdev/drivers/net/s2io.c irq_fix/drivers/net/s2io.c
--- netdev/drivers/net/s2io.c	2006-06-20 04:27:54.000000000 -0700
+++ irq_fix/drivers/net/s2io.c	2006-06-20 05:11:49.000000000 -0700
@@ -1977,7 +1977,6 @@ static int start_nic(struct s2io_nic *ni
 	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	struct net_device *dev = nic->dev;
 	register u64 val64 = 0;
-	u16 interruptible;
 	u16 subid, i;
 	mac_info_t *mac_control;
 	struct config_param *config;
@@ -2048,16 +2047,6 @@ static int start_nic(struct s2io_nic *ni
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
@@ -3706,101 +3695,19 @@ static int s2io_open(struct net_device *
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
-			SA_SHIRQ, sp->name, dev);
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
-		err = request_irq((int) sp->pdev->irq, s2io_isr, SA_SHIRQ,
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
@@ -3831,7 +3738,7 @@ static int s2io_close(struct net_device 
 	flush_scheduled_work();
 	netif_stop_queue(dev);
 	/* Reset card, kill tasklet and free Tx and Rx buffers. */
-	s2io_card_down(sp, 1);
+	s2io_card_down(sp);
 
 	sp->device_close_flag = TRUE;	/* Device is shut down. */
 	return 0;
@@ -5876,7 +5783,7 @@ static int s2io_change_mtu(struct net_de
 
 	dev->mtu = new_mtu;
 	if (netif_running(dev)) {
-		s2io_card_down(sp, 0);
+		s2io_card_down(sp);
 		netif_stop_queue(dev);
 		if (s2io_card_up(sp)) {
 			DBG_PRINT(ERR_DBG, "%s: Device bring up failed\n",
@@ -6173,43 +6080,106 @@ static  int rxd_owner_bit_reset(nic_t *s
 
 }
 
-static void s2io_card_down(nic_t * sp, int flag)
+static int s2io_add_isr(nic_t * sp)
 {
-	int cnt = 0;
-	XENA_dev_config_t __iomem *bar0 = sp->bar0;
-	unsigned long flags;
-	register u64 val64 = 0;
-	struct net_device *dev = sp->dev;
+	int ret = 0;
+	struct net_device *dev = (struct net_device *) sp->dev;
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
-
-			for (i=1; (sp->s2io_entries[i].in_use ==
-				MSIX_REGISTERED_SUCCESS); i++) {
-				int vector = sp->entries[i].vector;
-				void *arg = sp->s2io_entries[i].arg;
+	/* Store the values of the MSIX table in the nic_t structure */
+	store_xmsi_data(sp);
+
+	/* After proper initialization of H/W, register ISR */
+	if (sp->intr_type == MSI) {
+		err = request_irq((int) sp->pdev->irq, s2io_msi_handle,
+			SA_SHIRQ, sp->name, dev);
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
+		err = request_irq((int) sp->pdev->irq, s2io_isr, SA_SHIRQ,
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
@@ -6220,6 +6190,26 @@ static void s2io_card_down(nic_t * sp, i
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
@@ -6271,23 +6261,16 @@ static int s2io_card_up(nic_t * sp)
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
@@ -6318,21 +6301,39 @@ static int s2io_card_up(nic_t * sp)
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
@@ -6352,7 +6353,7 @@ static void s2io_restart_nic(unsigned lo
 	struct net_device *dev = (struct net_device *) data;
 	nic_t *sp = dev->priv;
 
-	s2io_card_down(sp, 0);
+	s2io_card_down(sp);
 	if (s2io_card_up(sp)) {
 		DBG_PRINT(ERR_DBG, "%s: Device bring up failed\n",
 			  dev->name);
diff -upNr netdev/drivers/net/s2io.h irq_fix/drivers/net/s2io.h
--- netdev/drivers/net/s2io.h	2006-06-20 04:27:54.000000000 -0700
+++ irq_fix/drivers/net/s2io.h	2006-06-20 05:51:07.000000000 -0700
@@ -829,8 +829,7 @@ struct s2io_nic {
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

