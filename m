Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWGDJJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWGDJJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGDJJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:09:53 -0400
Received: from [81.2.110.250] ([81.2.110.250]:41446 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751051AbWGDJJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:09:52 -0400
Subject: Re: 2.6.17-mm5 + pcmcia/hostap/8139too patches -- inconsistent
	{hardirq-on-W} -> {in-hardirq-W} usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miles Lane <miles.lane@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0607031614y2055828as6e0bbe2ce0d52ff1@mail.gmail.com>
References: <a44ae5cd0607031431q8dcc698j1c447b1d51c7cc75@mail.gmail.com>
	 <1151963034.3108.59.camel@laptopd505.fenrus.org>
	 <1151965557.16528.36.camel@localhost.localdomain>
	 <a44ae5cd0607031614y2055828as6e0bbe2ce0d52ff1@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 10:26:41 +0100
Message-Id: <1152005201.28597.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-03 am 16:14 -0700, ysgrifennodd Miles Lane:
> eth2: NE2000 (DL10022 rev 30): io 0x300, irq 11, hw_addr 00:50:BA:73:92:3D
> Which seems to indicate I need to tweak the PCMCIA settings to get this card
> working.  I wonder if anyone is going to follow up on enabling shared IRQ
> support.


Try this. Note the SMP locking in this driver appears iffy and looks
like it was never SMP sane.

--- linux.vanilla-2.6.17/drivers/net/pcmcia/pcnet_cs.c	2006-06-19 17:29:46.000000000 +0100
+++ linux-2.6.17/drivers/net/pcmcia/pcnet_cs.c	2006-07-04 09:55:07.695012656 +0100
@@ -25,6 +25,8 @@
     Based also on Keith Moore's changes to Don Becker's code, for IBM
     CCAE support.  Drivers merged back together, and shared-memory
     Socket EA support added, by Ken Raeburn, September 1995.
+    
+    FIXME: Not SMP safe
 
 ======================================================================*/
 
@@ -254,7 +256,7 @@
     info->p_dev = link;
     link->priv = dev;
 
-    link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
+    link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
     link->irq.IRQInfo1 = IRQ_LEVEL_ID;
     link->conf.Attributes = CONF_ENABLE_IRQ;
     link->conf.IntType = INT_MEMORY_AND_IO;
@@ -998,7 +1000,8 @@
     link->open++;
 
     set_misc_reg(dev);
-    request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, dev_info, dev);
+    if (request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, dev_info, dev) < 0)
+        return -EBUSY;
 
     info->phy_id = info->eth_phy;
     info->link_status = 0x00;

