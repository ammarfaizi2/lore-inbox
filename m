Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTJMNPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 09:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTJMNPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 09:15:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29192 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261746AbTJMNPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 09:15:04 -0400
Date: Mon, 13 Oct 2003 14:14:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Subject: [PATCH] Fix pcnet_cs network hotplug
Message-ID: <20031013141458.A347@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcnet_cs registers the network device too early.  The effect of this
is that the networking hotplug scripts are unable to bring the device
up automatically.

There are two issues:
- we were registering the net device before we finished setting up
  the device (eg, reading the MAC address.)
- we were using DEV_CONFIG_PENDING to block the net device "open"
  callback, and as we know the other methods may be called prior
  to open.

My only concern with this patch is that we set info->node.dev_name
after we register the net device, so use of cardctl during the
hotplug scripts may give unexpected results.  However, I am not
aware of anyone using cardctl to read the device name in network
hotplug scripts.

Please review and merge.  Thanks.

--- orig/drivers/net/pcmcia/pcnet_cs.c	Sun Sep 28 09:54:43 2003
+++ linux/drivers/net/pcmcia/pcnet_cs.c	Mon Oct 13 14:06:59 2003
@@ -681,10 +681,6 @@
     } else {
 	dev->if_port = 0;
     }
-    if (register_netdev(dev) != 0) {
-	printk(KERN_NOTICE "pcnet_cs: register_netdev() failed\n");
-	goto failed;
-    }
 
     hw_info = get_hwinfo(link);
     if (hw_info == NULL)
@@ -699,7 +695,6 @@
     if (hw_info == NULL) {
 	printk(KERN_NOTICE "pcnet_cs: unable to read hardware net"
 	       " address for io base %#3lx\n", dev->base_addr);
-	unregister_netdev(dev);
 	goto failed;
     }
 
@@ -733,8 +728,6 @@
     ei_status.word16 = 1;
     ei_status.reset_8390 = &pcnet_reset_8390;
 
-    strcpy(info->node.dev_name, dev->name);
-    link->dev = &info->node;
     SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
 
     if (info->flags & (IS_DL10019|IS_DL10022)) {
@@ -743,6 +736,21 @@
 	mii_phy_probe(dev);
 	if ((id == 0x30) && !info->pna_phy && (info->eth_phy == 4))
 	    info->eth_phy = 0;
+    }
+
+    link->dev = &info->node;
+    link->state &= ~DEV_CONFIG_PENDING;
+
+    if (register_netdev(dev) != 0) {
+	printk(KERN_NOTICE "pcnet_cs: register_netdev() failed\n");
+	link->dev = NULL;
+	goto failed;
+    }
+
+    strcpy(info->node.dev_name, dev->name);
+
+    if (info->flags & (IS_DL10019|IS_DL10022)) {
+	u_char id = inb(dev->base_addr + 0x1a);
 	printk(KERN_INFO "%s: NE2000 (DL100%d rev %02x): ",
 	       dev->name, ((info->flags & IS_DL10022) ? 22 : 19), id);
 	if (info->pna_phy)
@@ -758,7 +766,6 @@
     printk(" hw_addr ");
     for (i = 0; i < 6; i++)
 	printk("%02X%s", dev->dev_addr[i], ((i<5) ? ":" : "\n"));
-    link->state &= ~DEV_CONFIG_PENDING;
     return;
 
 cs_failed:

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
