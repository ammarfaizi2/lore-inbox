Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVBXEUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVBXEUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVBXETN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:19:13 -0500
Received: from ozlabs.org ([203.10.76.45]:16310 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261787AbVBXENY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:24 -0500
Date: Thu, 24 Feb 2005 15:00:52 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [8/14] Orinoco driver updates - PCMCIA initialization cleanups
Message-ID: <20050224040052.GJ32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224040024.GI32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the various bits of initialization code for PCMCIA / PC-Card
orinoco devices.  This includes one important bugfix where we could
fail to take the lock in some circumstances.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco_cs.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_cs.c	2005-02-18 12:04:03.157157240 +1100
+++ working-2.6/drivers/net/wireless/orinoco_cs.c	2005-02-18 12:11:49.000000000 +1100
@@ -57,8 +57,8 @@
 /* Some D-Link cards have buggy CIS. They do work at 5v properly, but
  * don't have any CIS entry for it. This workaround it... */
 static int ignore_cis_vcc; /* = 0 */
-
 module_param(ignore_cis_vcc, int, 0);
+MODULE_PARM_DESC(ignore_cis_vcc, "Allow voltage mismatch between card and socket");
 
 /********************************************************************/
 /* Magic constants						    */
@@ -128,6 +128,7 @@
 	if (err)
 		return err;
 
+	msleep(100);
 	clear_bit(0, &card->hard_reset_in_progress);
 
 	return 0;
@@ -166,9 +167,10 @@
 	link->priv = dev;
 
 	/* Interrupt setup */
-	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
+	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
 	link->irq.IRQInfo1 = IRQ_LEVEL_ID;
-	link->irq.Handler = NULL;
+	link->irq.Handler = orinoco_interrupt;
+	link->irq.Instance = dev; 
 
 	/* General socket configuration defaults can go here.  In this
 	 * client, we assume very little, and rely on the CIS for
@@ -184,6 +186,7 @@
 	dev_list = link;
 
 	client_reg.dev_info = &dev_info;
+	client_reg.Attributes = INFO_IO_CLIENT | INFO_CARD_SHARE;
 	client_reg.EventMask =
 		CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
 		CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
@@ -309,8 +312,8 @@
 		cistpl_cftable_entry_t *cfg = &(parse.cftable_entry);
 		cistpl_cftable_entry_t dflt = { .index = 0 };
 
-		if (pcmcia_get_tuple_data(handle, &tuple) != 0 ||
-				pcmcia_parse_tuple(handle, &tuple, &parse) != 0)
+		if ( (pcmcia_get_tuple_data(handle, &tuple) != 0)
+		    || (pcmcia_parse_tuple(handle, &tuple, &parse) != 0))
 			goto next_entry;
 
 		if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
@@ -349,8 +352,7 @@
 			    dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
 		
 		/* Do we need to allocate an interrupt? */
-		if (cfg->irq.IRQInfo1 || dflt.irq.IRQInfo1)
-			link->conf.Attributes |= CONF_ENABLE_IRQ;
+		link->conf.Attributes |= CONF_ENABLE_IRQ;
 
 		/* IO window settings */
 		link->io.NumPorts1 = link->io.NumPorts2 = 0;
@@ -402,14 +404,7 @@
 	 * a handler to the interrupt, unless the 'Handler' member of
 	 * the irq structure is initialized.
 	 */
-	if (link->conf.Attributes & CONF_ENABLE_IRQ) {
-		link->irq.Attributes = IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
-		link->irq.IRQInfo1 = IRQ_LEVEL_ID;
-  		link->irq.Handler = orinoco_interrupt; 
-  		link->irq.Instance = dev; 
-		
-		CS_CHECK(RequestIRQ, pcmcia_request_irq(link->handle, &link->irq));
-	}
+	CS_CHECK(RequestIRQ, pcmcia_request_irq(link->handle, &link->irq));
 
 	/* We initialize the hermes structure before completing PCMCIA
 	 * configuration just in case the interrupt handler gets
@@ -434,8 +429,6 @@
 	SET_MODULE_OWNER(dev);
 	card->node.major = card->node.minor = 0;
 
-	/* register_netdev will give us an ethX name */
-	dev->name[0] = '\0';
 	SET_NETDEV_DEV(dev, &handle_to_dev(handle));
 	/* Tell the stack we exist */
 	if (register_netdev(dev) != 0) {
@@ -458,8 +451,7 @@
 	if (link->conf.Vpp1)
 		printk(", Vpp %d.%d", link->conf.Vpp1 / 10,
 		       link->conf.Vpp1 % 10);
-	if (link->conf.Attributes & CONF_ENABLE_IRQ)
-		printk(", irq %d", link->irq.AssignedIRQ);
+	printk(", irq %d", link->irq.AssignedIRQ);
 	if (link->io.NumPorts1)
 		printk(", io 0x%04x-0x%04x", link->io.BasePort1,
 		       link->io.BasePort1 + link->io.NumPorts1 - 1);
@@ -525,12 +517,12 @@
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
