Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935692AbWK1InR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935692AbWK1InR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935706AbWK1Imx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:42:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35003 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935692AbWK1ImR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:42:17 -0500
Date: Mon, 27 Nov 2006 12:06:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [patch] IRQ handler type mismatch for IRQ 14
Message-ID: <20061127110607.GA22050@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00,DATE_IN_PAST_12_24 autolearn=no SpamAssassin version=3.0.3
	0.7 DATE_IN_PAST_12_24     Date: is 12 to 24 hours before Received: date
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] IRQ handler type mismatch for IRQ 14

got this with all SATA/PATA drivers enabled:

 Calling initcall 0xc05aceed: legacy_init+0x0/0x5b3()
 ata5: PATA max PIO4 cmd 0x170 ctl 0x376 bmdma 0x0 irq 14
 IRQ handler type mismatch for IRQ 14
 current handler: ide0
  [<c010501e>] dump_trace+0x64/0x1cc
  [<c010519f>] show_trace_log_lvl+0x19/0x2e
  [<c0105511>] show_trace+0x12/0x14
  [<c010552a>] dump_stack+0x17/0x19
  [<c016078f>] setup_irq+0x1c2/0x1dc
  [<c0160830>] request_irq+0x87/0xa7
  [<c02cc7c6>] ata_device_add+0x296/0x4dc
  [<c05ad3e0>] legacy_init+0x4f3/0x5b3
  [<c01004f9>] init+0x135/0x3c0
  [<c0104d67>] kernel_thread_helper+0x7/0x10

the patch below solves it, although i suspect the irq_flags field could 
be eliminated altogether now - all drivers must be prepared to handle 
shared interrupts.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/drivers/ata/libata-core.c
===================================================================
--- linux.orig/drivers/ata/libata-core.c
+++ linux/drivers/ata/libata-core.c
@@ -5526,8 +5526,8 @@ int ata_device_add(const struct ata_prob
 	}
 
 	/* obtain irq, that may be shared between channels */
-	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host);
+	rc = request_irq(ent->irq, ent->port_ops->irq_handler,
+			 ent->irq_flags | SA_SHIRQ, DRV_NAME, host);
 	if (rc) {
 		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
 			   ent->irq, rc);
@@ -5540,8 +5540,8 @@ int ata_device_add(const struct ata_prob
 		   so trap it now */
 		BUG_ON(ent->irq == ent->irq2);
 
-		rc = request_irq(ent->irq2, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host);
+		rc = request_irq(ent->irq2, ent->port_ops->irq_handler,
+				 ent->irq_flags | SA_SHIRQ, DRV_NAME, host);
 		if (rc) {
 			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
 				   ent->irq2, rc);
