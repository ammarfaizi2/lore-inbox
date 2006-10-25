Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423058AbWJYGdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423058AbWJYGdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 02:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423059AbWJYGdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 02:33:00 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:62138 "EHLO
	barracuda.s2io.com") by vger.kernel.org with ESMTP id S1423058AbWJYGc7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 02:32:59 -0400
X-ASG-Debug-ID: 1161757976-7056-21-2
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-ASG-Orig-Subj: RE: [PATCH] s2io: add PCI error recovery support
Subject: RE: [PATCH] s2io: add PCI error recovery support
Date: Wed, 25 Oct 2006 02:29:33 -0400
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD77DC1C9B@nekter>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] s2io: add PCI error recovery support
Thread-Index: Acb3tp6/mVnjeIhpQ1yyC1P8KxLJ8wAOGpaQ
From: "Ananda Raju" <Ananda.Raju@neterion.com>
To: "Linas Vepstas" <linas@austin.ibm.com>, "Wen Xiong" <wenxiong@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <netdev@vger.kernel.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Andrew Morton" <akpm@osdl.org>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

s2io_card_down() will do few BAR0 read/write. As per
pci-error-recovery.txt Documentation we are not supposed to do any new
IO in error_detected(). 

Can you try using 

atomic_set(&sp->card_state, CARD_DOWN); 

instead of s2io_card_down().

Also we have to add following if statement in beginning of s2io_isr().

if (atomic_read(&nic->card_state) == CARD_DOWN)
	return IRQ_NOTHANDLED.

If it is ok to do BAR0 read/write in error_detected() then patch is OK. 

Ananda 
-----Original Message-----
From: Linas Vepstas [mailto:linas@austin.ibm.com] 
Sent: Tuesday, October 24, 2006 2:55 PM
To: Raghavendra Koushik; Ananda Raju; Wen Xiong
Cc: linux-kernel@vger.kernel.org; linux-pci@atrey.karlin.mff.cuni.cz;
netdev@vger.kernel.org; Jeff Garzik; Andrew Morton
Subject: [PATCH] s2io: add PCI error recovery support


Koushik, Raju,
Please review, comment, and if you find this acceptable, 
please forward upstream.

--linas

This patch adds PCI error recovery support to the 
s2io 10-Gigabit ethernet device driver.

Tested, seems to work well.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Raghavendra Koushik <raghavendra.koushik@neterion.com>
Cc: Ananda Raju <Ananda.Raju@neterion.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>

----
 drivers/net/s2io.c |   77
+++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/s2io.h |    5 +++
 2 files changed, 82 insertions(+)

Index: linux-2.6.19-rc1-git11/drivers/net/s2io.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/net/s2io.c	2006-10-20
12:24:17.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/s2io.c	2006-10-24
16:19:49.000000000 -0500
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
@@ -7564,3 +7571,73 @@ static void lro_append_pkt(nic_t *sp, lr
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
pci_channel_state_t state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	nic_t *sp = netdev->priv;
+
+	netif_device_detach(netdev);
+
+	if (netif_running(netdev)) {
+		/* Reset card */
+		s2io_card_down(sp);
+		sp->device_close_flag = TRUE;	/* Device is shut down.
*/
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
+		printk(KERN_ERR "s2io: Cannot re-enable PCI device after
reset.\n");
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
+			printk(KERN_ERR "s2io: can't bring device back
up after reset\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+	netif_wake_queue(netdev);
+}
Index: linux-2.6.19-rc1-git11/drivers/net/s2io.h
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/net/s2io.h	2006-10-20
12:24:17.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/s2io.h	2006-10-20
12:41:39.000000000 -0500
@@ -1013,6 +1013,11 @@ static void queue_rx_frame(struct sk_buf
 static void update_L3L4_header(nic_t *sp, lro_t *lro);
 static void lro_append_pkt(nic_t *sp, lro_t *lro, struct sk_buff *skb,
u32 tcp_len);
 
+static pci_ers_result_t s2io_io_error_detected(struct pci_dev *pdev,
+
pci_channel_state_t state);
+static pci_ers_result_t s2io_io_slot_reset(struct pci_dev *pdev);
+static void s2io_io_resume(struct pci_dev *pdev);
+
 #define s2io_tcp_mss(skb) skb_shinfo(skb)->gso_size
 #define s2io_udp_mss(skb) skb_shinfo(skb)->gso_size
 #define s2io_offload_type(skb) skb_shinfo(skb)->gso_type

