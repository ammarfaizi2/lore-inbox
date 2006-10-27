Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752437AbWJ0TdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWJ0TdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 15:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbWJ0TdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 15:33:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:48311 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752432AbWJ0TdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 15:33:22 -0400
Date: Fri, 27 Oct 2006 14:32:31 -0500
To: Ananda Raju <Ananda.Raju@neterion.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] s2io: add PCI error recovery support
Message-ID: <20061027193231.GI6360@austin.ibm.com>
References: <78C9135A3D2ECE4B8162EBDCE82CAD77DC20B7@nekter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78C9135A3D2ECE4B8162EBDCE82CAD77DC20B7@nekter>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 07:35:18AM -0400, Ananda Raju wrote:
> Looking at all scenarios I feel the first patch is OK. Can you add the
> watchdog timer fix to first initial patch and resubmit. 

Appended below.

> So -- just for grins, I thought to myself, "Maybe I can make 
> s2io be the first adapter ever to fully recover without 
> a hard reset of the card."

... I couldn't quite make this work. Since the patch below
already works, I didn't see much point exterting myself further.

--linas

This patch adds PCI error recovery support to the 
s2io 10-Gigabit ethernet device driver. Third revision,
blocks interrupts and the watchdog.

Tested, seems to work well.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Raghavendra Koushik <raghavendra.koushik@neterion.com>
Cc: Ananda Raju <Ananda.Raju@neterion.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>

----
 drivers/net/s2io.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/s2io.h |    5 ++
 2 files changed, 126 insertions(+)

Index: linux-2.6.19-rc1-git11/drivers/net/s2io.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/net/s2io.c	2006-10-27 10:49:07.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/s2io.c	2006-10-27 13:55:01.000000000 -0500
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
@@ -3159,6 +3166,11 @@ static void alarm_intr_handler(struct s2
 	register u64 val64 = 0, err_reg = 0;
 	u64 cnt;
 	int i;
+
+	if ((nic->pdev->error_state != pci_channel_io_normal) &&
+		 (nic->pdev->error_state != 0))
+		return;
+
 	nic->mac_control.stats_info->sw_stat.ring_full_cnt = 0;
 	/* Handling the XPAK counters update */
 	if(nic->mac_control.stats_info->xpak_stat.xpak_timer_count < 72000) {
@@ -4171,6 +4183,11 @@ static irqreturn_t s2io_isr(int irq, voi
 	mac_info_t *mac_control;
 	struct config_param *config;
 
+	/* Pretend we handled any irq's from a disconnected card */
+	if ((sp->pdev->error_state != pci_channel_io_normal) &&
+		 (sp->pdev->error_state != 0))
+		return IRQ_HANDLED;
+
 	atomic_inc(&sp->isr_cnt);
 	mac_control = &sp->mac_control;
 	config = &sp->config;
@@ -7564,3 +7581,107 @@ static void lro_append_pkt(nic_t *sp, lr
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
+static pci_ers_result_t s2io_io_error_detected(struct pci_dev *pdev,
+                                               pci_channel_state_t state)
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
+ * At this point, the card has exprienced a hard reset,
+ * followed by fixups by BIOS, and has its config space
+ * set up identically to what it was at cold boot.
+ */
+static pci_ers_result_t s2io_io_slot_reset(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	nic_t *sp = netdev->priv;
+
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "s2io: "
+		       "Cannot re-enable PCI device after reset.\n");
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
+ * This callback is called when the error recovery driver tells
+ * us that its OK to resume normal operation.
+ */
+static void s2io_io_resume(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	nic_t *sp = netdev->priv;
+
+	if (netif_running(netdev)) {
+		if (s2io_card_up(sp)) {
+			printk(KERN_ERR "s2io: "
+			       "Can't bring device back up after reset.\n");
+			return;
+		}
+
+		if (s2io_set_mac_addr(netdev, netdev->dev_addr) == FAILURE) {
+			s2io_card_down(sp);
+			printk(KERN_ERR "s2io: "
+			       "Can't resetore mac addr after reset.\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+	netif_wake_queue(netdev);
+}
Index: linux-2.6.19-rc1-git11/drivers/net/s2io.h
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/net/s2io.h	2006-10-27 10:49:07.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/s2io.h	2006-10-27 10:50:53.000000000 -0500
@@ -1013,6 +1013,11 @@ static void queue_rx_frame(struct sk_buf
 static void update_L3L4_header(nic_t *sp, lro_t *lro);
 static void lro_append_pkt(nic_t *sp, lro_t *lro, struct sk_buff *skb, u32 tcp_len);
 
+static pci_ers_result_t s2io_io_error_detected(struct pci_dev *pdev,
+					                      pci_channel_state_t state);
+static pci_ers_result_t s2io_io_slot_reset(struct pci_dev *pdev);
+static void s2io_io_resume(struct pci_dev *pdev);
+
 #define s2io_tcp_mss(skb) skb_shinfo(skb)->gso_size
 #define s2io_udp_mss(skb) skb_shinfo(skb)->gso_size
 #define s2io_offload_type(skb) skb_shinfo(skb)->gso_type

