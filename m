Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422780AbWJYU4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWJYU4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422781AbWJYUz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:55:58 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34715 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161387AbWJYUzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:55:55 -0400
Date: Wed, 25 Oct 2006 15:55:29 -0500
To: Ananda Raju <Ananda.Raju@neterion.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] s2io: add PCI error recovery support
Message-ID: <20061025205529.GG6360@austin.ibm.com>
References: <78C9135A3D2ECE4B8162EBDCE82CAD77DC1C9B@nekter> <20061025151123.GF6360@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025151123.GF6360@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 10:11:24AM -0500, Linas Vepstas wrote:
> 
> > Also we have to add following if statement in beginning of s2io_isr().

Done, below,

> > If it is ok to do BAR0 read/write in error_detected() then patch is OK. 

I re-wrote that section to avoid doing I/O. It seems to work well,
and generates a few less messages in the process.  New, improved patch
below, please ack and send upstream if you like it.

--linas

This patch adds PCI error recovery support to the 
s2io 10-Gigabit ethernet device driver.

Tested, seems to work well.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Raghavendra Koushik <raghavendra.koushik@neterion.com>
Cc: Ananda Raju <Ananda.Raju@neterion.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>

----
 drivers/net/s2io.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/s2io.h |    5 ++
 2 files changed, 108 insertions(+)

Index: linux-2.6.19-rc1-git11/drivers/net/s2io.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/net/s2io.c	2006-10-25 14:09:47.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/s2io.c	2006-10-25 15:18:25.000000000 -0500
@@ -434,11 +434,18 @@ static struct pci_device_id s2io_tbl[] _
 
 MODULE_DEVICE_TABLE(pci, s2io_tbl);
 
+static struct pci_error_handlers s2io_err_handler = {
+	.error_detected = s2io_io_error_detected,
+	.slot_reset = s2io_io_slot_reset,
+	.resume = s2io_io_resume,
+};
+
 static struct pci_driver s2io_driver = {
       .name = "S2IO",
       .id_table = s2io_tbl,
       .probe = s2io_init_nic,
       .remove = __devexit_p(s2io_rem_nic),
+      .err_handler = &s2io_err_handler,
 };
 
 /* A simplifier macro used both by init and free shared_mem Fns(). */
@@ -4171,6 +4178,11 @@ static irqreturn_t s2io_isr(int irq, voi
 	mac_info_t *mac_control;
 	struct config_param *config;
 
+	if ((sp->pdev->error_state != pci_channel_io_normal) &&
+		 (sp->pdev->error_state != 0)) {
+		return IRQ_HANDLED;
+	}
+
 	atomic_inc(&sp->isr_cnt);
 	mac_control = &sp->mac_control;
 	config = &sp->config;
@@ -7564,3 +7576,94 @@ static void lro_append_pkt(nic_t *sp, lr
 	sp->mac_control.stats_info->sw_stat.clubbed_frms_cnt++;
 	return;
 }
+
+/**
+ * s2io_io_error_detected - called when PCI error is detected
+ * @pdev: Pointer to PCI device
+ * @state: The current pci conneection state
+ *
+ * This function is called after a PCI bus error affecting
+ * this device has been detected.
+ */
+static pci_ers_result_t s2io_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	nic_t *sp = netdev->priv;
+
+	netif_device_detach(netdev);
+
+	if (netif_running(netdev)) {
+		unsigned long flags;
+
+		/* The folowing is an abreviated subset of the
+		 * steps taken by s2io_card_down(), avoiding
+		 * steps that touch the card itself.
+		 */
+		del_timer_sync(&sp->alarm_timer);
+		atomic_set(&sp->card_state, CARD_DOWN);
+
+		/* Kill tasklet. */
+		tasklet_kill(&sp->task);
+
+		/* Free all Tx buffers */
+		spin_lock_irqsave(&sp->tx_lock, flags);
+		free_tx_buffers(sp);
+		spin_unlock_irqrestore(&sp->tx_lock, flags);
+
+		/* Free all Rx buffers */
+		spin_lock_irqsave(&sp->rx_lock, flags);
+		free_rx_buffers(sp);
+		spin_unlock_irqrestore(&sp->rx_lock, flags);
+	
+		clear_bit(0, &(sp->link_state));
+		sp->device_close_flag = TRUE;	/* Device is shut down. */
+	}
+	pci_disable_device(pdev);
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * s2io_io_slot_reset - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Restart the card from scratch, as if from a cold-boot.
+ */
+static pci_ers_result_t s2io_io_slot_reset(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	nic_t *sp = netdev->priv;
+
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "s2io: Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_set_master(pdev);
+	s2io_reset(sp);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * s2io_io_resume - called when traffic can start flowing again.
+ * @pdev: Pointer to PCI device
+ *
+ * This callback is called when the error recovery driver tells us that
+ * its OK to resume normal operation.
+ */
+static void s2io_io_resume(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	nic_t *sp = netdev->priv;
+
+	if (netif_running(netdev)) {
+		if (s2io_card_up(sp)) {
+			printk(KERN_ERR "s2io: can't bring device back up after reset\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+	netif_wake_queue(netdev);
+}
Index: linux-2.6.19-rc1-git11/drivers/net/s2io.h
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/net/s2io.h	2006-10-25 14:09:47.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/s2io.h	2006-10-25 14:11:05.000000000 -0500
@@ -1013,6 +1013,11 @@ static void queue_rx_frame(struct sk_buf
 static void update_L3L4_header(nic_t *sp, lro_t *lro);
 static void lro_append_pkt(nic_t *sp, lro_t *lro, struct sk_buff *skb, u32 tcp_len);
 
+static pci_ers_result_t s2io_io_error_detected(struct pci_dev *pdev,
+                                               pci_channel_state_t state);
+static pci_ers_result_t s2io_io_slot_reset(struct pci_dev *pdev);
+static void s2io_io_resume(struct pci_dev *pdev);
+
 #define s2io_tcp_mss(skb) skb_shinfo(skb)->gso_size
 #define s2io_udp_mss(skb) skb_shinfo(skb)->gso_size
 #define s2io_offload_type(skb) skb_shinfo(skb)->gso_type

