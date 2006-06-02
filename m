Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWFBVXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWFBVXR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWFBVXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:23:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:32417 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030290AbWFBVXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:23:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:cc:subject:message-id:references:mime-version:content-type;
        b=nbb8h8N/dvbEY2Aq9bzfHIf3nXFCX2c7Jdcppbjgjxy228sCrrHpa6dYhTZjbvqeoql9ABQ9Vfxp8bTd5gQOCM5t946pyoqG2PV3rKKwPfEvLLpACPEUmk8VWkKV5JeoiB4IvxeGdshGJIH1A6/mLL9VRlF0ob+/6Aa0TIbHzuQ=
Date: Fri, 2 Jun 2006 23:23:27 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost
To: linux-kernel@vger.kernel.org
cc: Ingo Molnar <mingo@elte.hu>
Subject: [patch 3/5] [PREEMPT_RT] Changing interrupt handlers from running
 in thread to hardirq and back runtime.
Message-ID: <Pine.LNX.4.64.0606022322010.9307@localhost>
References: <20060602165336.147812000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makes it possible for the e100 ethernet driver to have it's interrupt handler
in both hard-irq and threaded context under PREEMPT_RT.

Index: linux-2.6.16-rt23.spin_mutex/drivers/net/e100.c
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/drivers/net/e100.c
+++ linux-2.6.16-rt23.spin_mutex/drivers/net/e100.c
@@ -530,7 +530,7 @@ struct nic {
  	enum ru_state ru_running;

  	spinlock_t cb_lock			____cacheline_aligned;
-	spinlock_t cmd_lock;
+	spin_mutex_t cmd_lock;
  	struct csr __iomem *csr;
  	enum scb_cmd_lo cuc_cmd;
  	unsigned int cbs_avail;
@@ -1950,6 +1950,30 @@ static int e100_rx_alloc_list(struct nic
  	return 0;
  }

+static int e100_change_context(int irq, void *dev_id,
+			       enum change_context_cmd cmd)
+{
+	struct net_device *netdev = dev_id;
+	struct nic *nic = netdev_priv(netdev);
+
+	switch(cmd)
+	{
+	case IRQ_TO_HARDIRQ:
+		if(!spin_mutexes_can_spin())
+			return -ENOSYS;
+
+		spin_mutex_to_spin(&nic->cmd_lock);
+		break;
+	case IRQ_CAN_THREAD:
+		/* Ok - return 0 */
+		break;
+	case IRQ_TO_THREADED:
+		spin_mutex_to_mutex(&nic->cmd_lock);
+		break;
+	}
+	return 0; /* Ok */
+}
+
  static irqreturn_t e100_intr(int irq, void *dev_id, struct pt_regs *regs)
  {
  	struct net_device *netdev = dev_id;
@@ -2064,9 +2088,12 @@ static int e100_up(struct nic *nic)
  	e100_set_multicast_list(nic->netdev);
  	e100_start_receiver(nic, NULL);
  	mod_timer(&nic->watchdog, jiffies);
-	if((err = request_irq(nic->pdev->irq, e100_intr, SA_SHIRQ,
-		nic->netdev->name, nic->netdev)))
+	if((err = request_irq2(nic->pdev->irq, e100_intr,
+			       SA_SHIRQ|SA_MUST_THREAD_RT,
+			       nic->netdev->name, nic->netdev,
+			       e100_change_context)))
  		goto err_no_irq;
+
  	netif_wake_queue(nic->netdev);
  	netif_poll_enable(nic->netdev);
  	/* enable ints _after_ enabling poll, preventing a race between

--
