Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbTJYWPP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 18:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTJYWPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 18:15:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:4756 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262708AbTJYWPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 18:15:07 -0400
Date: Sat, 25 Oct 2003 18:14:35 -0400
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, jgarzik@pobox.com, shemminger@osdl.org,
       netdev@oss.sgi.com
Subject: [PATCH] ibmtr_cs/ibmtr on 2.6.0-test9 - get working again
Message-ID: <20031025221435.GA18782@siasl.dyndns.org>
Mail-Followup-To: phillim2, linux-kernel@vger.kernel.org, torvalds@osdl.org,
	jgarzik@pobox.com, shemminger@osdl.org, netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mike Phillips <phillim2@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to get ibmtr_cs / ibmtr working again in 2.6.0-test9. A change
went in a while back I missed that killed it. Also fixed the timer to
elimitate the uninitialized timer error on close. 

Please apply so we have a working driver for 2.6. I'll start right on
updates to the new net-2.5 probes interface. 

Thanks
Mike Phillips


diff -urN -X dontdiff linux-2.6.0-test9.vanilla/drivers/net/pcmcia/ibmtr_cs.c linux-2.6.0-test9/drivers/net/pcmcia/ibmtr_cs.c
--- linux-2.6.0-test9.vanilla/drivers/net/pcmcia/ibmtr_cs.c	2003-10-25 14:43:42.000000000 -0400
+++ linux-2.6.0-test9/drivers/net/pcmcia/ibmtr_cs.c	2003-10-25 17:23:35.000000000 -0400
@@ -136,7 +136,7 @@
     struct net_device	*dev;
     dev_node_t          node;
     window_handle_t     sram_win_handle;
-    struct tok_info	ti;
+    struct tok_info	*ti;
 } ibmtr_dev_t;
 
 static void netdev_get_drvinfo(struct net_device *dev,
@@ -168,14 +168,17 @@
     DEBUG(0, "ibmtr_attach()\n");
 
     /* Create new token-ring device */
-    dev = alloc_trdev(sizeof(*info));
+    info = kmalloc(sizeof(*info), GFP_KERNEL); 
+    if (!info) return NULL;
+    memset(info,0,sizeof(*info));
+    dev = alloc_trdev(sizeof(struct tok_info));
     if (!dev)
 	    return NULL;
-    info = dev->priv;
 
     link = &info->link;
     link->priv = info;
-
+    info->ti = dev->priv; 
+    
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
     link->io.NumPorts1 = 4;
     link->io.IOAddrLines = 16;
@@ -265,6 +268,7 @@
     *linkp = link->next;
     unregister_netdev(dev);
     free_netdev(dev);
+    kfree(info); 
 } /* ibmtr_detach */
 
 /*======================================================================
diff -urN -X dontdiff linux-2.6.0-test9.vanilla/drivers/net/tokenring/ibmtr.c linux-2.6.0-test9/drivers/net/tokenring/ibmtr.c
--- linux-2.6.0-test9.vanilla/drivers/net/tokenring/ibmtr.c	2003-10-25 14:43:58.000000000 -0400
+++ linux-2.6.0-test9/drivers/net/tokenring/ibmtr.c	2003-10-25 17:26:38.000000000 -0400
@@ -152,7 +152,7 @@
 
 /* this allows displaying full adapter information */
 
-char *channel_def[] __initdata = { "ISA", "MCA", "ISA P&P" };
+char *channel_def[] __devinitdata = { "ISA", "MCA", "ISA P&P" };
 
 static char pcchannelid[] __devinitdata = {
 	0x05, 0x00, 0x04, 0x09,
@@ -864,7 +864,8 @@
 	ti->sram_virt &= ~1; /* to reverse what we do in tok_close */
 	/* init the spinlock */
 	ti->lock = (spinlock_t) SPIN_LOCK_UNLOCKED;
-
+	init_timer(&ti->tr_timer);
+	
 	i = tok_init_card(dev);
 	if (i) return i;
 
@@ -1033,7 +1034,7 @@
 
 	/* Important for PCMCIA hot unplug, otherwise, we'll pull the card, */
 	/* unloading the module from memory, and then if a timer pops, ouch */
-	del_timer(&ti->tr_timer);
+	del_timer_sync(&ti->tr_timer);
 	outb(0, dev->base_addr + ADAPTRESET);
 	ti->sram_virt |= 1;
 	ti->open_status = CLOSED;
