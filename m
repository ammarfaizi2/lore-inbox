Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTFAD0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 23:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTFAD0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 23:26:43 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:52096
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261168AbTFAD0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 23:26:42 -0400
Date: Sat, 31 May 2003 23:29:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH][2.5] cli/sti cleanup for fmvj18x
Message-ID: <Pine.LNX.4.50.0305312251010.2614-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one should be safe as we're protected by the xmit_lock in all instances

	Zwane

Index: linux-2.5.70-mm3/drivers/net/pcmcia/fmvj18x_cs.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/drivers/net/pcmcia/fmvj18x_cs.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fmvj18x_cs.c
--- linux-2.5.70-mm3/drivers/net/pcmcia/fmvj18x_cs.c	27 May 2003 02:19:20 -0000	1.1.1.1
+++ linux-2.5.70-mm3/drivers/net/pcmcia/fmvj18x_cs.c	31 May 2003 10:50:47 -0000
@@ -923,8 +923,7 @@ static void fjn_tx_timeout(struct net_de
 	   htons(inw(ioaddr +14)));
     lp->stats.tx_errors++;
     /* ToDo: We should try to restart the adaptor... */
-    cli();
-
+    local_irq_disable();
     fjn_reset(dev);
 
     lp->tx_started = 0;
@@ -932,7 +931,7 @@ static void fjn_tx_timeout(struct net_de
     lp->tx_queue_len = 0;
     lp->sent = 0;
     lp->open_time = jiffies;
-    sti();
+    local_irq_enable();
     netif_wake_queue(dev);
 }
 
@@ -1361,9 +1360,8 @@ static void set_rx_mode(struct net_devic
 	    mc_filter[bit >> 3] |= (1 << bit);
 	}
     }
-    
-    save_flags(flags);
-    cli();
+
+    local_irq_save(flags); 
     if (memcmp(mc_filter, lp->mc_filter, sizeof(mc_filter))) {
 	int saved_bank = inb(ioaddr + CONFIG_1);
 	/* Switch to bank 1 and set the multicast table. */
@@ -1373,5 +1371,5 @@ static void set_rx_mode(struct net_devic
 	memcpy(lp->mc_filter, mc_filter, sizeof(mc_filter));
 	outb(saved_bank, ioaddr + CONFIG_1);
     }
-    restore_flags(flags);
+    local_irq_restore(flags);
 }
