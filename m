Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUF2Iwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUF2Iwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 04:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUF2Iwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 04:52:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10246 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265654AbUF2Iv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 04:51:59 -0400
Date: Tue, 29 Jun 2004 09:51:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PCMCIA net device unplugging ordering fix
Message-ID: <20040629095152.B19610@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rather old patch which re-orders the teardown of PCMCIA
network devices.  Current device drivers remove the IO mappings,
interrupts, and free any PCMCIA windows before they unregister
themselves from the network layer.

This patch ensures that we first unregister from the network layer
before performing any teardown of resources or windows.

Note: the only card which has been tested in this patch is pcnet_cs.

diff -urpN orig/drivers/net/pcmcia/3c574_cs.c linux/drivers/net/pcmcia/3c574_cs.c
--- orig/drivers/net/pcmcia/3c574_cs.c	Fri Mar 19 11:25:39 2004
+++ linux/drivers/net/pcmcia/3c574_cs.c	Mon Mar  8 13:59:50 2004
@@ -360,7 +360,10 @@ static void tc574_detach(dev_link_t *lin
 	for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
 		if (*linkp == link) break;
 	if (*linkp == NULL)
-	return;
+		return;
+
+	if (link->dev)
+		unregister_netdev(dev);
 
 	if (link->state & DEV_CONFIG)
 		tc574_release(link);
@@ -370,8 +373,6 @@ static void tc574_detach(dev_link_t *lin
 
 	/* Unlink device structure, free bits */
 	*linkp = link->next;
-	if (link->dev)
-		unregister_netdev(dev);
 	free_netdev(dev);
 } /* tc574_detach */
 
@@ -580,10 +581,8 @@ static int tc574_event(event_t event, in
 	switch (event) {
 	case CS_EVENT_CARD_REMOVAL:
 		link->state &= ~DEV_PRESENT;
-		if (link->state & DEV_CONFIG) {
+		if (link->state & DEV_CONFIG)
 			netif_device_detach(dev);
-			tc574_release(link);
-		}
 		break;
 	case CS_EVENT_CARD_INSERTION:
 		link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
diff -urpN orig/drivers/net/pcmcia/3c589_cs.c linux/drivers/net/pcmcia/3c589_cs.c
--- orig/drivers/net/pcmcia/3c589_cs.c	Fri Mar 19 11:25:40 2004
+++ linux/drivers/net/pcmcia/3c589_cs.c	Mon Mar  8 13:59:50 2004
@@ -276,6 +276,9 @@ static void tc589_detach(dev_link_t *lin
     if (*linkp == NULL)
 	return;
 
+    if (link->dev)
+	unregister_netdev(dev);
+
     if (link->state & DEV_CONFIG)
 	tc589_release(link);
     
@@ -284,8 +287,6 @@ static void tc589_detach(dev_link_t *lin
     
     /* Unlink device structure, free bits */
     *linkp = link->next;
-    if (link->dev)
-	unregister_netdev(dev);
     free_netdev(dev);
 } /* tc589_detach */
 
@@ -456,10 +457,8 @@ static int tc589_event(event_t event, in
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
-	if (link->state & DEV_CONFIG) {
+	if (link->state & DEV_CONFIG)
 	    netif_device_detach(dev);
-	    tc589_release(link);
-	}
 	break;
     case CS_EVENT_CARD_INSERTION:
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
diff -urpN orig/drivers/net/pcmcia/axnet_cs.c linux/drivers/net/pcmcia/axnet_cs.c
--- orig/drivers/net/pcmcia/axnet_cs.c	Fri Mar 19 11:25:41 2004
+++ linux/drivers/net/pcmcia/axnet_cs.c	Mon Mar  8 13:59:50 2004
@@ -231,6 +231,9 @@ static void axnet_detach(dev_link_t *lin
     if (*linkp == NULL)
 	return;
 
+    if (link->dev)
+	unregister_netdev(dev);
+
     if (link->state & DEV_CONFIG)
 	axnet_release(link);
 
@@ -239,8 +242,6 @@ static void axnet_detach(dev_link_t *lin
 
     /* Unlink device structure, free bits */
     *linkp = link->next;
-    if (link->dev)
-	unregister_netdev(dev);
     free_netdev(dev);
 } /* axnet_detach */
 
@@ -525,10 +526,8 @@ static int axnet_event(event_t event, in
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
-	if (link->state & DEV_CONFIG) {
+	if (link->state & DEV_CONFIG)
 	    netif_device_detach(dev);
-	    axnet_release(link);
-	}
 	break;
     case CS_EVENT_CARD_INSERTION:
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
diff -urpN orig/drivers/net/pcmcia/com20020_cs.c linux/drivers/net/pcmcia/com20020_cs.c
--- orig/drivers/net/pcmcia/com20020_cs.c	Fri Mar 19 11:25:41 2004
+++ linux/drivers/net/pcmcia/com20020_cs.c	Mon Mar  8 13:59:50 2004
@@ -262,6 +262,19 @@ static void com20020_detach(dev_link_t *
 
     dev = info->dev;
 
+    if (link->dev) {
+	DEBUG(1,"unregister...\n");
+
+	unregister_netdev(dev);
+	    
+	/*
+	 * this is necessary because we register our IRQ separately
+	 * from card services.
+	 */
+	if (dev->irq)
+	    free_irq(dev->irq, dev);
+    }
+
     if (link->state & DEV_CONFIG)
         com20020_release(link);
 
@@ -276,21 +289,6 @@ static void com20020_detach(dev_link_t *
 	dev = info->dev;
 	if (dev)
 	{
-	    if (link->dev)
-	    {
-		DEBUG(1,"unregister...\n");
-
-		unregister_netdev(dev);
-	    
-		/*
-		 * this is necessary because we register our IRQ separately
-		 * from card services.
-		 */
-		if (dev->irq)
-		    free_irq(dev->irq, dev);
-		/* ...but I/O ports are done automatically by card services */
-	    }
-	    
 	    DEBUG(1,"kfree...\n");
 	    free_netdev(dev);
 	}
@@ -461,10 +459,8 @@ static int com20020_event(event_t event,
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
         link->state &= ~DEV_PRESENT;
-        if (link->state & DEV_CONFIG) {
+        if (link->state & DEV_CONFIG)
             netif_device_detach(dev);
-            link->state |= DEV_RELEASE_PENDING;
-        }
         break;
     case CS_EVENT_CARD_INSERTION:
         link->state |= DEV_PRESENT;
diff -urpN orig/drivers/net/pcmcia/fmvj18x_cs.c linux/drivers/net/pcmcia/fmvj18x_cs.c
--- orig/drivers/net/pcmcia/fmvj18x_cs.c	Fri Mar 19 11:25:42 2004
+++ linux/drivers/net/pcmcia/fmvj18x_cs.c	Mon Mar  8 13:59:50 2004
@@ -332,6 +332,9 @@ static void fmvj18x_detach(dev_link_t *l
     if (*linkp == NULL)
 	return;
 
+    if (link->dev)
+	unregister_netdev(dev);
+
     if (link->state & DEV_CONFIG)
 	fmvj18x_release(link);
 
@@ -341,8 +344,6 @@ static void fmvj18x_detach(dev_link_t *l
     
     /* Unlink device structure, free pieces */
     *linkp = link->next;
-    if (link->dev)
-	unregister_netdev(dev);
     free_netdev(dev);
 } /* fmvj18x_detach */
 
@@ -741,10 +742,8 @@ static int fmvj18x_event(event_t event, 
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
-	if (link->state & DEV_CONFIG) {
+	if (link->state & DEV_CONFIG)
 	    netif_device_detach(dev);
-	    fmvj18x_release(link);
-	}
 	break;
     case CS_EVENT_CARD_INSERTION:
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
diff -urpN orig/drivers/net/pcmcia/ibmtr_cs.c linux/drivers/net/pcmcia/ibmtr_cs.c
--- orig/drivers/net/pcmcia/ibmtr_cs.c	Fri Mar 19 11:25:42 2004
+++ linux/drivers/net/pcmcia/ibmtr_cs.c	Mon Mar  8 13:59:50 2004
@@ -446,7 +446,6 @@ static int ibmtr_event(event_t event, in
 	    struct tok_info *priv = netdev_priv(dev);
 	    priv->sram_virt |= 1;
 	    netif_device_detach(dev);
-	    ibmtr_release(link);
         }
         break;
     case CS_EVENT_CARD_INSERTION:
diff -urpN orig/drivers/net/pcmcia/nmclan_cs.c linux/drivers/net/pcmcia/nmclan_cs.c
--- orig/drivers/net/pcmcia/nmclan_cs.c	Fri Mar 19 11:25:43 2004
+++ linux/drivers/net/pcmcia/nmclan_cs.c	Mon Mar  8 13:59:50 2004
@@ -551,6 +551,9 @@ static void nmclan_detach(dev_link_t *li
     if (*linkp == NULL)
 	return;
 
+    if (link->dev)
+	unregister_netdev(dev);
+
     if (link->state & DEV_CONFIG)
 	nmclan_release(link);
 
@@ -559,8 +562,6 @@ static void nmclan_detach(dev_link_t *li
 
     /* Unlink device structure, free bits */
     *linkp = link->next;
-    if (link->dev)
-	unregister_netdev(dev);
     free_netdev(dev);
 } /* nmclan_detach */
 
@@ -834,10 +835,8 @@ static int nmclan_event(event_t event, i
   switch (event) {
     case CS_EVENT_CARD_REMOVAL:
       link->state &= ~DEV_PRESENT;
-      if (link->state & DEV_CONFIG) {
+      if (link->state & DEV_CONFIG)
 	netif_device_detach(dev);
-	nmclan_release(link);
-      }
       break;
     case CS_EVENT_CARD_INSERTION:
       link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
diff -urpN orig/drivers/net/pcmcia/pcnet_cs.c linux/drivers/net/pcmcia/pcnet_cs.c
--- orig/drivers/net/pcmcia/pcnet_cs.c	Sat Feb 28 10:09:33 2004
+++ linux/drivers/net/pcmcia/pcnet_cs.c	Fri Mar 19 11:18:03 2004
@@ -326,6 +326,9 @@ static void pcnet_detach(dev_link_t *lin
     if (*linkp == NULL)
 	return;
 
+    if (link->dev)
+	unregister_netdev(dev);
+
     if (link->state & DEV_CONFIG)
 	pcnet_release(link);
 
@@ -334,8 +337,6 @@ static void pcnet_detach(dev_link_t *lin
 
     /* Unlink device structure, free bits */
     *linkp = link->next;
-    if (link->dev)
-	unregister_netdev(dev);
     free_netdev(dev);
 } /* pcnet_detach */
 
@@ -806,10 +807,8 @@ static int pcnet_event(event_t event, in
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
-	if (link->state & DEV_CONFIG) {
+	if (link->state & DEV_CONFIG)
 	    netif_device_detach(dev);
-	    pcnet_release(link);
-	}
 	break;
     case CS_EVENT_CARD_INSERTION:
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
diff -urpN orig/drivers/net/pcmcia/smc91c92_cs.c linux/drivers/net/pcmcia/smc91c92_cs.c
--- orig/drivers/net/pcmcia/smc91c92_cs.c	Fri Mar 19 11:25:44 2004
+++ linux/drivers/net/pcmcia/smc91c92_cs.c	Mon Mar  8 13:59:50 2004
@@ -411,6 +411,9 @@ static void smc91c92_detach(dev_link_t *
     if (*linkp == NULL)
 	return;
 
+    if (link->dev)
+	unregister_netdev(dev);
+
     if (link->state & DEV_CONFIG)
 	smc91c92_release(link);
 
@@ -419,8 +422,6 @@ static void smc91c92_detach(dev_link_t *
 
     /* Unlink device structure, free bits */
     *linkp = link->next;
-    if (link->dev)
-	unregister_netdev(dev);
     free_netdev(dev);
 } /* smc91c92_detach */
 
@@ -1112,10 +1113,8 @@ static int smc91c92_event(event_t event,
     switch (event) {
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
-	if (link->state & DEV_CONFIG) {
+	if (link->state & DEV_CONFIG)
 	    netif_device_detach(dev);
-	    smc91c92_release(link);
-	}
 	break;
     case CS_EVENT_CARD_INSERTION:
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
diff -urpN orig/drivers/net/pcmcia/xirc2ps_cs.c linux/drivers/net/pcmcia/xirc2ps_cs.c
--- orig/drivers/net/pcmcia/xirc2ps_cs.c	Fri Mar 19 11:25:44 2004
+++ linux/drivers/net/pcmcia/xirc2ps_cs.c	Mon Mar  8 13:59:50 2004
@@ -668,6 +668,9 @@ xirc2ps_detach(dev_link_t * link)
 	return;
     }
 
+    if (link->dev)
+	unregister_netdev(dev);
+
     /*
      * If the device is currently configured and active, we won't
      * actually delete it yet.	Instead, it is marked so that when
@@ -683,8 +686,6 @@ xirc2ps_detach(dev_link_t * link)
 
     /* Unlink device structure, free it */
     *linkp = link->next;
-    if (link->dev)
-	unregister_netdev(dev);
     free_netdev(dev);
 } /* xirc2ps_detach */
 
@@ -1203,10 +1204,8 @@ xirc2ps_event(event_t event, int priorit
 	break;
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
-	if (link->state & DEV_CONFIG) {
+	if (link->state & DEV_CONFIG)
 	    netif_device_detach(dev);
-	    xirc2ps_release(link);
-	}
 	break;
     case CS_EVENT_CARD_INSERTION:
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
