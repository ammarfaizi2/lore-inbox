Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263103AbVALFgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbVALFgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbVALFfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:35:51 -0500
Received: from ozlabs.org ([203.10.76.45]:2961 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263103AbVALF3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:29:47 -0500
Date: Wed, 12 Jan 2005 16:28:14 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, orinoco-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [6/8] orinoco: Cleanup PCMCIA/PC-Card code
Message-ID: <20050112052814.GG30426@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20050112052352.GA30426@localhost.localdomain> <20050112052434.GB30426@localhost.localdomain> <20050112052543.GC30426@localhost.localdomain> <20050112052630.GD30426@localhost.localdomain> <20050112052711.GE30426@localhost.localdomain> <20050112052741.GF30426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112052741.GF30426@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the various bits of initialization code for PCMCIA / PC-Card
orinoco devices.  This includes one important bugfix where we could
fail to take the lock in some circumstances.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco_cs.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_cs.c	2005-01-12 15:34:50.847655792 +1100
+++ working-2.6/drivers/net/wireless/orinoco_cs.c	2004-11-05 14:31:07.000000000 +1100
@@ -54,19 +54,11 @@
 
 /* Module parameters */
 
-/* The old way: bit map of interrupts to choose from */
-/* This means pick from 15, 14, 12, 11, 10, 9, 7, 5, 4, and 3 */
-static uint irq_mask = 0xdeb8;
-/* Newer, simpler way of listing specific interrupts */
-static int irq_list[4] = { -1 };
-
 /* Some D-Link cards have buggy CIS. They do work at 5v properly, but
  * don't have any CIS entry for it. This workaround it... */
 static int ignore_cis_vcc; /* = 0 */
-
-MODULE_PARM(irq_mask, "i");
-MODULE_PARM(irq_list, "1-4i");
-MODULE_PARM(ignore_cis_vcc, "i");
+module_param(ignore_cis_vcc, int, 0644);
+MODULE_PARM_DESC(ignore_cis_vcc, "Allow voltage mismatch between card and socket");
 
 /********************************************************************/
 /* Magic constants						    */
@@ -136,6 +128,7 @@
 	if (err)
 		return err;
 
+	msleep(100);
 	clear_bit(0, &card->hard_reset_in_progress);
 
 	return 0;
@@ -161,7 +154,7 @@
 	struct orinoco_pccard *card;
 	dev_link_t *link;
 	client_reg_t client_reg;
-	int ret, i;
+	int ret;
 
 	dev = alloc_orinocodev(sizeof(*card), orinoco_cs_hard_reset);
 	if (! dev)
@@ -174,14 +167,11 @@
 	link->priv = dev;
 
 	/* Interrupt setup */
-	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
+	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
 	link->irq.IRQInfo1 = IRQ_INFO2_VALID | IRQ_LEVEL_ID;
-	if (irq_list[0] == -1)
-		link->irq.IRQInfo2 = irq_mask;
-	else
-		for (i = 0; i < 4; i++)
-			link->irq.IRQInfo2 |= 1 << irq_list[i];
-	link->irq.Handler = NULL;
+	link->irq.IRQInfo2 = 0xffffffff;	/* Any ISA IRQ */
+	link->irq.Handler = orinoco_interrupt;
+	link->irq.Instance = dev; 
 
 	/* General socket configuration defaults can go here.  In this
 	 * client, we assume very little, and rely on the CIS for
@@ -262,6 +252,9 @@
 		last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; \
 	} while (0)
 
+#define CFG_CHECK(fn, ret) \
+	if (ret != 0) goto next_entry
+
 static void
 orinoco_cs_config(dev_link_t *link)
 {
@@ -323,9 +316,8 @@
 		cistpl_cftable_entry_t *cfg = &(parse.cftable_entry);
 		cistpl_cftable_entry_t dflt = { .index = 0 };
 
-		if (pcmcia_get_tuple_data(handle, &tuple) != 0 ||
-				pcmcia_parse_tuple(handle, &tuple, &parse) != 0)
-			goto next_entry;
+		CFG_CHECK(GetTupleData, pcmcia_get_tuple_data(handle, &tuple));
+		CFG_CHECK(ParseTuple, pcmcia_parse_tuple(handle, &tuple, &parse));
 
 		if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
 			dflt = *cfg;
@@ -363,8 +355,7 @@
 			    dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
 		
 		/* Do we need to allocate an interrupt? */
-		if (cfg->irq.IRQInfo1 || dflt.irq.IRQInfo1)
-			link->conf.Attributes |= CONF_ENABLE_IRQ;
+		link->conf.Attributes |= CONF_ENABLE_IRQ;
 
 		/* IO window settings */
 		link->io.NumPorts1 = link->io.NumPorts2 = 0;
@@ -390,8 +381,8 @@
 			}
 
 			/* This reserves IO space but doesn't actually enable it */
-			if (pcmcia_request_io(link->handle, &link->io) != 0)
-				goto next_entry;
+			CFG_CHECK(RequestIO,
+				  pcmcia_request_io(link->handle, &link->io));
 		}
 
 
@@ -416,22 +407,7 @@
 	 * a handler to the interrupt, unless the 'Handler' member of
 	 * the irq structure is initialized.
 	 */
-	if (link->conf.Attributes & CONF_ENABLE_IRQ) {
-		int i;
-
-		link->irq.Attributes = IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
-		link->irq.IRQInfo1 = IRQ_INFO2_VALID | IRQ_LEVEL_ID;
-		if (irq_list[0] == -1)
-			link->irq.IRQInfo2 = irq_mask;
-		else
-			for (i=0; i<4; i++)
-				link->irq.IRQInfo2 |= 1 << irq_list[i];
-		
-  		link->irq.Handler = orinoco_interrupt; 
-  		link->irq.Instance = dev; 
-		
-		CS_CHECK(RequestIRQ, pcmcia_request_irq(link->handle, &link->irq));
-	}
+	CS_CHECK(RequestIRQ, pcmcia_request_irq(link->handle, &link->irq));
 
 	/* We initialize the hermes structure before completing PCMCIA
 	 * configuration just in case the interrupt handler gets
@@ -456,8 +432,6 @@
 	SET_MODULE_OWNER(dev);
 	card->node.major = card->node.minor = 0;
 
-	/* register_netdev will give us an ethX name */
-	dev->name[0] = '\0';
 	/* Tell the stack we exist */
 	if (register_netdev(dev) != 0) {
 		printk(KERN_ERR PFX "register_netdev() failed\n");
@@ -479,8 +453,7 @@
 	if (link->conf.Vpp1)
 		printk(", Vpp %d.%d", link->conf.Vpp1 / 10,
 		       link->conf.Vpp1 % 10);
-	if (link->conf.Attributes & CONF_ENABLE_IRQ)
-		printk(", irq %d", link->irq.AssignedIRQ);
+	printk(", irq %d", link->irq.AssignedIRQ);
 	if (link->io.NumPorts1)
 		printk(", io 0x%04x-0x%04x", link->io.BasePort1,
 		       link->io.BasePort1 + link->io.NumPorts1 - 1);
@@ -546,12 +519,12 @@
 	case CS_EVENT_CARD_REMOVAL:
 		link->state &= ~DEV_PRESENT;
 		if (link->state & DEV_CONFIG) {
-			orinoco_lock(priv, &flags);
+			unsigned long flags;
 
+			spin_lock_irqsave(&priv->lock, flags);
 			netif_device_detach(dev);
 			priv->hw_unavailable++;
-
-			orinoco_unlock(priv, &flags);
+			spin_unlock_irqrestore(&priv->lock, flags);
 		}
 		break;
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
