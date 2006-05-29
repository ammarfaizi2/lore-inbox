Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWE2VW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWE2VW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWE2VW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:22:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12498 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751318AbWE2VWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:22:55 -0400
Date: Mon, 29 May 2006 23:23:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 02/61] lock validator: forcedeth.c fix
Message-ID: <20060529212313.GB3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

nv_do_nic_poll() is called from timer softirqs, which has interrupts
enabled, but np->lock might also be taken by some other interrupt
context.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/net/forcedeth.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux/drivers/net/forcedeth.c
===================================================================
--- linux.orig/drivers/net/forcedeth.c
+++ linux/drivers/net/forcedeth.c
@@ -2869,6 +2869,7 @@ static void nv_do_nic_poll(unsigned long
 	struct net_device *dev = (struct net_device *) data;
 	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);
+	unsigned long flags;
 	u32 mask = 0;
 
 	/*
@@ -2897,10 +2898,9 @@ static void nv_do_nic_poll(unsigned long
 			mask |= NVREG_IRQ_OTHER;
 		}
 	}
+	local_irq_save(flags);
 	np->nic_poll_irq = 0;
 
-	/* FIXME: Do we need synchronize_irq(dev->irq) here? */
-
 	writel(mask, base + NvRegIrqMask);
 	pci_push(base);
 
@@ -2924,6 +2924,7 @@ static void nv_do_nic_poll(unsigned long
 			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector);
 		}
 	}
+	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
