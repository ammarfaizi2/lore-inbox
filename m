Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275254AbTHGJvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275257AbTHGJvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:51:35 -0400
Received: from verein.lst.de ([212.34.189.10]:58066 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S275254AbTHGJug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:50:36 -0400
Date: Thu, 7 Aug 2003 11:50:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove the release timer from all pcmcia net drivers
Message-ID: <20030807095014.GA25763@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Jeff Garzik <jgarzik@pobox.com>, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20030724085839.GA9748@lst.de> <3F305212.5090200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F305212.5090200@pobox.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5.5 () EMAIL_ATTRIBUTION,IN_REP_TO,PATCH_UNIFIED_DIFF,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 08:55:46PM -0400, Jeff Garzik wrote:
> Everybody is now happy with the patch... would you mind rediffing and 
> resending?

Here it is, one reject fixes and acme's new wireless driver converted
aswell.


--- 1.20/drivers/net/pcmcia/3c574_cs.c	Sat Jul 12 05:50:10 2003
+++ edited/drivers/net/pcmcia/3c574_cs.c	Thu Aug  7 09:58:48 2003
@@ -232,7 +232,7 @@
 /* Index of functions. */
 
 static void tc574_config(dev_link_t *link);
-static void tc574_release(unsigned long arg);
+static void tc574_release(dev_link_t *link);
 static int tc574_event(event_t event, int priority,
 					   event_callback_args_t *args);
 
@@ -298,9 +298,6 @@
 	link->priv = dev;
 
 	spin_lock_init(&lp->window_lock);
-	init_timer(&link->release);
-	link->release.function = &tc574_release;
-	link->release.data = (unsigned long)link;
 	link->io.NumPorts1 = 32;
 	link->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
 	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
@@ -374,9 +371,8 @@
 	if (*linkp == NULL)
 	return;
 
-	del_timer_sync(&link->release);
 	if (link->state & DEV_CONFIG) {
-		tc574_release((unsigned long)link);
+		tc574_release(link);
 		if (link->state & DEV_STALE_CONFIG) {
 			link->state |= DEV_STALE_LINK;
 			return;
@@ -555,7 +551,7 @@
 cs_failed:
 	cs_error(link->handle, last_fn, last_ret);
 failed:
-	tc574_release((unsigned long)link);
+	tc574_release(link);
 	return;
 
 } /* tc574_config */
@@ -566,10 +562,8 @@
 	still open, this will be postponed until it is closed.
 */
 
-static void tc574_release(unsigned long arg)
+static void tc574_release(dev_link_t *link)
 {
-	dev_link_t *link = (dev_link_t *)arg;
-
 	DEBUG(0, "3c574_release(0x%p)\n", link);
 
 	if (link->open) {
@@ -607,7 +601,7 @@
 		link->state &= ~DEV_PRESENT;
 		if (link->state & DEV_CONFIG) {
 			netif_device_detach(dev);
-			mod_timer(&link->release, jiffies + HZ/20);
+			tc574_release(link);
 		}
 		break;
 	case CS_EVENT_CARD_INSERTION:
@@ -1323,7 +1317,7 @@
 	netif_stop_queue(dev);
 	del_timer_sync(&lp->media);
 	if (link->state & DEV_STALE_CONFIG)
-		mod_timer(&link->release, jiffies + HZ/20);
+		tc574_release(link);
 	return 0;
 }
 
===== drivers/net/pcmcia/3c589_cs.c 1.19 vs edited =====
--- 1.19/drivers/net/pcmcia/3c589_cs.c	Mon Jun 30 17:43:04 2003
+++ edited/drivers/net/pcmcia/3c589_cs.c	Thu Aug  7 09:58:07 2003
@@ -148,7 +148,7 @@
 /*====================================================================*/
 
 static void tc589_config(dev_link_t *link);
-static void tc589_release(unsigned long arg);
+static void tc589_release(dev_link_t *link);
 static int tc589_event(event_t event, int priority,
 		       event_callback_args_t *args);
 
@@ -220,9 +220,6 @@
     link->priv = dev;
 
     spin_lock_init(&lp->lock);
-    init_timer(&link->release);
-    link->release.function = &tc589_release;
-    link->release.data = (unsigned long)link;
     link->io.NumPorts1 = 16;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
@@ -298,9 +295,8 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
-	tc589_release((unsigned long)link);
+	tc589_release(link);
 	if (link->state & DEV_STALE_CONFIG) {
 	    link->state |= DEV_STALE_LINK;
 	    return;
@@ -439,7 +435,7 @@
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    tc589_release((unsigned long)link);
+    tc589_release(link);
     return;
     
 } /* tc589_config */
@@ -452,10 +448,8 @@
     
 ======================================================================*/
 
-static void tc589_release(unsigned long arg)
+static void tc589_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *)arg;
-
     DEBUG(0, "3c589_release(0x%p)\n", link);
     
     if (link->open) {
@@ -495,7 +489,7 @@
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
 	    netif_device_detach(dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    tc589_release(link);
 	}
 	break;
     case CS_EVENT_CARD_INSERTION:
@@ -1137,7 +1131,7 @@
     netif_stop_queue(dev);
     del_timer_sync(&lp->media);
     if (link->state & DEV_STALE_CONFIG)
-	mod_timer(&link->release, jiffies + HZ/20);
+	     tc589_release(link);
     
     return 0;
 }
===== drivers/net/pcmcia/axnet_cs.c 1.14 vs edited =====
--- 1.14/drivers/net/pcmcia/axnet_cs.c	Fri Jul 11 10:21:39 2003
+++ edited/drivers/net/pcmcia/axnet_cs.c	Thu Aug  7 09:58:07 2003
@@ -92,7 +92,7 @@
 /*====================================================================*/
 
 static void axnet_config(dev_link_t *link);
-static void axnet_release(u_long arg);
+static void axnet_release(dev_link_t *link);
 static int axnet_event(event_t event, int priority,
 		       event_callback_args_t *args);
 static int axnet_open(struct net_device *dev);
@@ -194,10 +194,6 @@
     memset(info, 0, sizeof(*info));
     link = &info->link; dev = &info->dev;
     link->priv = info;
-    
-    init_timer(&link->release);
-    link->release.function = &axnet_release;
-    link->release.data = (u_long)link;
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
     link->irq.IRQInfo1 = IRQ_INFO2_VALID|IRQ_LEVEL_ID;
     if (irq_list[0] == -1)
@@ -258,9 +254,8 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
-	axnet_release((u_long)link);
+	axnet_release(link);
 	if (link->state & DEV_STALE_CONFIG) {
 	    link->state |= DEV_STALE_LINK;
 	    return;
@@ -518,7 +513,7 @@
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    axnet_release((u_long)link);
+    axnet_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
     return;
 } /* axnet_config */
@@ -531,10 +526,8 @@
 
 ======================================================================*/
 
-static void axnet_release(u_long arg)
+static void axnet_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *)arg;
-
     DEBUG(0, "axnet_release(0x%p)\n", link);
 
     if (link->open) {
@@ -574,7 +567,7 @@
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
 	    netif_device_detach(&info->dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    axnet_release(link);
 	}
 	break;
     case CS_EVENT_CARD_INSERTION:
@@ -708,7 +701,7 @@
     netif_stop_queue(dev);
     del_timer_sync(&info->watchdog);
     if (link->state & DEV_STALE_CONFIG)
-	mod_timer(&link->release, jiffies + HZ/20);
+	axnet_release(link);
 
     return 0;
 } /* axnet_close */
===== drivers/net/pcmcia/com20020_cs.c 1.9 vs edited =====
--- 1.9/drivers/net/pcmcia/com20020_cs.c	Fri Aug  1 06:02:23 2003
+++ edited/drivers/net/pcmcia/com20020_cs.c	Thu Aug  7 09:58:08 2003
@@ -126,7 +126,7 @@
 /*====================================================================*/
 
 static void com20020_config(dev_link_t *link);
-static void com20020_release(u_long arg);
+static void com20020_release(dev_link_t *link);
 static int com20020_event(event_t event, int priority,
                        event_callback_args_t *args);
 
@@ -205,9 +205,6 @@
     memset(link, 0, sizeof(struct dev_link_t));
     dev->priv = lp;
 
-    init_timer(&link->release);
-    link->release.function = &com20020_release;
-    link->release.data = (u_long)link;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
     link->io.NumPorts1 = 16;
     link->io.IOAddrLines = 16;
@@ -292,7 +289,7 @@
     dev = info->dev;
 
     if (link->state & DEV_CONFIG) {
-        com20020_release((u_long)link);
+        com20020_release(link);
         if (link->state & DEV_STALE_CONFIG) {
             link->state |= DEV_STALE_LINK;
             return;
@@ -456,7 +453,7 @@
     cs_error(link->handle, last_fn, last_ret);
 failed:
     DEBUG(1,"com20020_config failed...\n");
-    com20020_release((u_long)link);
+    com20020_release(link);
 } /* com20020_config */
 
 /*======================================================================
@@ -467,9 +464,8 @@
 
 ======================================================================*/
 
-static void com20020_release(u_long arg)
+static void com20020_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *)arg;
 
     DEBUG(1,"release...\n");
 
@@ -513,9 +509,7 @@
         link->state &= ~DEV_PRESENT;
         if (link->state & DEV_CONFIG) {
             netif_device_detach(dev);
-            link->release.expires = jiffies + HZ/20;
             link->state |= DEV_RELEASE_PENDING;
-            add_timer(&link->release);
         }
         break;
     case CS_EVENT_CARD_INSERTION:
===== drivers/net/pcmcia/fmvj18x_cs.c 1.22 vs edited =====
--- 1.22/drivers/net/pcmcia/fmvj18x_cs.c	Tue Jun 24 16:24:32 2003
+++ edited/drivers/net/pcmcia/fmvj18x_cs.c	Thu Aug  7 09:58:08 2003
@@ -94,7 +94,7 @@
 static void fmvj18x_config(dev_link_t *link);
 static int fmvj18x_get_hwinfo(dev_link_t *link, u_char *node_id);
 static int fmvj18x_setup_mfc(dev_link_t *link);
-static void fmvj18x_release(u_long arg);
+static void fmvj18x_release(dev_link_t *link);
 static int fmvj18x_event(event_t event, int priority,
 			  event_callback_args_t *args);
 static dev_link_t *fmvj18x_attach(void);
@@ -279,10 +279,6 @@
     link = &lp->link;
     link->priv = dev;
 
-    init_timer(&link->release);
-    link->release.function = &fmvj18x_release;
-    link->release.data = (u_long)link;
-
     /* The io structure describes IO port mapping */
     link->io.NumPorts1 = 32;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
@@ -355,9 +351,8 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
-	fmvj18x_release((u_long)link);
+	fmvj18x_release(link);
 	if (link->state & DEV_STALE_CONFIG) {
 	    link->state |= DEV_STALE_LINK;
 	    return;
@@ -638,7 +633,7 @@
     /* All Card Services errors end up here */
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    fmvj18x_release((u_long)link);
+    fmvj18x_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
 
 } /* fmvj18x_config */
@@ -742,9 +737,8 @@
 }
 /*====================================================================*/
 
-static void fmvj18x_release(u_long arg)
+static void fmvj18x_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *)arg;
 
     DEBUG(0, "fmvj18x_release(0x%p)\n", link);
 
@@ -784,7 +778,7 @@
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
 	    netif_device_detach(dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    fmvj18x_release(link);
 	}
 	break;
     case CS_EVENT_CARD_INSERTION:
@@ -1306,7 +1300,7 @@
 
     link->open--;
     if (link->state & DEV_STALE_CONFIG)
-	mod_timer(&link->release, jiffies + HZ/20);
+	    fmvj18x_release(link);
 
     return 0;
 } /* fjn_close */
===== drivers/net/pcmcia/ibmtr_cs.c 1.15 vs edited =====
--- 1.15/drivers/net/pcmcia/ibmtr_cs.c	Fri Jul 11 10:22:01 2003
+++ edited/drivers/net/pcmcia/ibmtr_cs.c	Thu Aug  7 09:58:09 2003
@@ -114,7 +114,7 @@
 
 static void ibmtr_config(dev_link_t *link);
 static void ibmtr_hw_setup(struct net_device *dev, u_int mmiobase);
-static void ibmtr_release(u_long arg);
+static void ibmtr_release(dev_link_t *link);
 static int ibmtr_event(event_t event, int priority,
                        event_callback_args_t *args);
 
@@ -216,9 +216,6 @@
     link = &info->link;
     link->priv = info;
 
-    init_timer(&link->release);
-    link->release.function = &ibmtr_release;
-    link->release.data = (u_long)link;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
     link->io.NumPorts1 = 4;
     link->io.IOAddrLines = 16;
@@ -295,9 +292,8 @@
 	struct tok_info *ti = (struct tok_info *)dev->priv;
 	del_timer_sync(&(ti->tr_timer));
     }
-    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
-        ibmtr_release((u_long)link);
+        ibmtr_release(link);
         if (link->state & DEV_STALE_CONFIG) {
             link->state |= DEV_STALE_LINK;
             return;
@@ -434,7 +430,7 @@
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    ibmtr_release((u_long)link);
+    ibmtr_release(link);
 } /* ibmtr_config */
 
 /*======================================================================
@@ -445,9 +441,8 @@
 
 ======================================================================*/
 
-static void ibmtr_release(u_long arg)
+static void ibmtr_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *)arg;
     ibmtr_dev_t *info = link->priv;
     struct net_device *dev = info->dev;
 
@@ -499,7 +494,7 @@
 	    /* set flag to bypass normal interrupt code */
 	    ((struct tok_info *)dev->priv)->sram_virt |= 1;
 	    netif_device_detach(dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    ibmtr_release(link);
         }
         break;
     case CS_EVENT_CARD_INSERTION:
===== drivers/net/pcmcia/nmclan_cs.c 1.17 vs edited =====
--- 1.17/drivers/net/pcmcia/nmclan_cs.c	Fri Jul 11 10:58:34 2003
+++ edited/drivers/net/pcmcia/nmclan_cs.c	Thu Aug  7 09:58:09 2003
@@ -427,7 +427,7 @@
 ---------------------------------------------------------------------------- */
 
 static void nmclan_config(dev_link_t *link);
-static void nmclan_release(u_long arg);
+static void nmclan_release(dev_link_t *link);
 static int nmclan_event(event_t event, int priority,
 			event_callback_args_t *args);
 
@@ -490,9 +490,6 @@
     link->priv = dev;
     
     spin_lock_init(&lp->bank_lock);
-    init_timer(&link->release);
-    link->release.function = &nmclan_release;
-    link->release.data = (u_long)link;
     link->io.NumPorts1 = 32;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
     link->io.IOAddrLines = 5;
@@ -569,9 +566,8 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
-	nmclan_release((u_long)link);
+	nmclan_release(link);
 	if (link->state & DEV_STALE_CONFIG) {
 	    link->state |= DEV_STALE_LINK;
 	    return;
@@ -815,7 +811,7 @@
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    nmclan_release((u_long)link);
+    nmclan_release(link);
     return;
 
 } /* nmclan_config */
@@ -826,9 +822,8 @@
 	net device, and release the PCMCIA configuration.  If the device
 	is still open, this will be postponed until it is closed.
 ---------------------------------------------------------------------------- */
-static void nmclan_release(u_long arg)
+static void nmclan_release(dev_link_t *link)
 {
-  dev_link_t *link = (dev_link_t *)arg;
 
   DEBUG(0, "nmclan_release(0x%p)\n", link);
 
@@ -867,7 +862,7 @@
       link->state &= ~DEV_PRESENT;
       if (link->state & DEV_CONFIG) {
 	netif_device_detach(dev);
-	mod_timer(&link->release, jiffies + HZ/20);
+	nmclan_release(link);
       }
       break;
     case CS_EVENT_CARD_INSERTION:
@@ -1012,7 +1007,7 @@
   link->open--;
   netif_stop_queue(dev);
   if (link->state & DEV_STALE_CONFIG)
-    mod_timer(&link->release, jiffies + HZ/20);
+	  nmclan_release(link);
 
   return 0;
 } /* mace_close */
===== drivers/net/pcmcia/pcnet_cs.c 1.20 vs edited =====
--- 1.20/drivers/net/pcmcia/pcnet_cs.c	Fri Jul 11 10:22:26 2003
+++ edited/drivers/net/pcmcia/pcnet_cs.c	Thu Aug  7 09:58:10 2003
@@ -110,7 +110,7 @@
 
 static void mii_phy_probe(struct net_device *dev);
 static void pcnet_config(dev_link_t *link);
-static void pcnet_release(u_long arg);
+static void pcnet_release(dev_link_t *link);
 static int pcnet_event(event_t event, int priority,
 		       event_callback_args_t *args);
 static int pcnet_open(struct net_device *dev);
@@ -293,9 +293,6 @@
     link = &info->link; dev = &info->dev;
     link->priv = info;
 
-    init_timer(&link->release);
-    link->release.function = &pcnet_release;
-    link->release.data = (u_long)link;
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
     link->irq.IRQInfo1 = IRQ_INFO2_VALID|IRQ_LEVEL_ID;
     if (irq_list[0] == -1)
@@ -357,9 +354,8 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
-	pcnet_release((u_long)link);
+	pcnet_release(link);
 	if (link->state & DEV_STALE_CONFIG) {
 	    link->state |= DEV_STALE_LINK;
 	    return;
@@ -787,7 +783,7 @@
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    pcnet_release((u_long)link);
+    pcnet_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
     return;
 } /* pcnet_config */
@@ -800,9 +796,8 @@
 
 ======================================================================*/
 
-static void pcnet_release(u_long arg)
+static void pcnet_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *)arg;
     pcnet_dev_t *info = link->priv;
 
     DEBUG(0, "pcnet_release(0x%p)\n", link);
@@ -848,7 +843,7 @@
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
 	    netif_device_detach(&info->dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    pcnet_release(link);
 	}
 	break;
     case CS_EVENT_CARD_INSERTION:
@@ -1054,7 +1049,7 @@
     netif_stop_queue(dev);
     del_timer_sync(&info->watchdog);
     if (link->state & DEV_STALE_CONFIG)
-	mod_timer(&link->release, jiffies + HZ/20);
+	    pcnet_release(link);
 
     return 0;
 } /* pcnet_close */
===== drivers/net/pcmcia/smc91c92_cs.c 1.21 vs edited =====
--- 1.21/drivers/net/pcmcia/smc91c92_cs.c	Fri Jul 11 10:22:40 2003
+++ edited/drivers/net/pcmcia/smc91c92_cs.c	Thu Aug  7 09:58:10 2003
@@ -283,7 +283,7 @@
 static dev_link_t *smc91c92_attach(void);
 static void smc91c92_detach(dev_link_t *);
 static void smc91c92_config(dev_link_t *link);
-static void smc91c92_release(u_long arg);
+static void smc91c92_release(dev_link_t *link);
 static int smc91c92_event(event_t event, int priority,
 			  event_callback_args_t *args);
 
@@ -351,9 +351,6 @@
     link->priv = dev;
 
     spin_lock_init(&smc->lock);
-    init_timer(&link->release);
-    link->release.function = &smc91c92_release;
-    link->release.data = (u_long)link;
     link->io.NumPorts1 = 16;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
     link->io.IOAddrLines = 4;
@@ -433,9 +430,8 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
-	smc91c92_release((u_long)link);
+	smc91c92_release(link);
 	if (link->state & DEV_STALE_CONFIG) {
 	    link->state |= DEV_STALE_LINK;
 	    return;
@@ -1068,7 +1064,7 @@
 config_undo:
     unregister_netdev(dev);
 config_failed:			/* CS_EXIT_TEST() calls jump to here... */
-    smc91c92_release((u_long)link);
+    smc91c92_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
 
 } /* smc91c92_config */
@@ -1081,9 +1077,8 @@
 
 ======================================================================*/
 
-static void smc91c92_release(u_long arg)
+static void smc91c92_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *)arg;
 
     DEBUG(0, "smc91c92_release(0x%p)\n", link);
 
@@ -1132,7 +1127,7 @@
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
 	    netif_device_detach(dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    smc91c92_release(link);
 	}
 	break;
     case CS_EVENT_CARD_INSERTION:
@@ -1332,7 +1327,7 @@
     link->open--;
     del_timer_sync(&smc->media);
     if (link->state & DEV_STALE_CONFIG)
-	mod_timer(&link->release, jiffies + HZ/20);
+	    smc91c92_release(link);
 
     return 0;
 } /* smc_close */
===== drivers/net/pcmcia/xirc2ps_cs.c 1.23 vs edited =====
--- 1.23/drivers/net/pcmcia/xirc2ps_cs.c	Fri Jul 11 10:22:49 2003
+++ edited/drivers/net/pcmcia/xirc2ps_cs.c	Thu Aug  7 09:58:11 2003
@@ -295,7 +295,7 @@
 
 static int has_ce2_string(dev_link_t * link);
 static void xirc2ps_config(dev_link_t * link);
-static void xirc2ps_release(u_long arg);
+static void xirc2ps_release(dev_link_t * link);
 static int xirc2ps_event(event_t event, int priority,
 			 event_callback_args_t * args);
 
@@ -611,10 +611,6 @@
     link = &local->link;
     link->priv = dev;
 
-    init_timer(&link->release);
-    link->release.function = &xirc2ps_release;
-    link->release.data = (u_long) link;
-
     /* General socket configuration */
     link->conf.Attributes = CONF_ENABLE_IRQ;
     link->conf.Vcc = 50;
@@ -689,9 +685,8 @@
      * the release() function is called, that will trigger a proper
      * detach().
      */
-    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
-	xirc2ps_release((unsigned long)link);
+	xirc2ps_release(link);
 	if (link->state & DEV_STALE_CONFIG) {
 		link->state |= DEV_STALE_LINK;
 		return;
@@ -1164,7 +1159,7 @@
 
   config_error:
     link->state &= ~DEV_CONFIG_PENDING;
-    xirc2ps_release((u_long)link);
+    xirc2ps_release(link);
     return;
 
   cis_error:
@@ -1179,9 +1174,8 @@
  * still open, this will be postponed until it is closed.
  */
 static void
-xirc2ps_release(u_long arg)
+xirc2ps_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *) arg;
 
     DEBUG(0, "release(0x%p)\n", link);
 
@@ -1243,7 +1237,7 @@
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
 	    netif_device_detach(dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    xirc2ps_release(link);
 	}
 	break;
     case CS_EVENT_CARD_INSERTION:
@@ -2045,7 +2039,7 @@
 
     link->open--;
     if (link->state & DEV_STALE_CONFIG)
-	mod_timer(&link->release, jiffies + HZ/20);
+	    xirc2ps_release(link);
 
     return 0;
 }
===== drivers/net/wireless/airo_cs.c 1.8 vs edited =====
--- 1.8/drivers/net/wireless/airo_cs.c	Sat Apr 26 12:16:23 2003
+++ edited/drivers/net/wireless/airo_cs.c	Thu Aug  7 09:58:11 2003
@@ -94,7 +94,7 @@
 int reset_airo_card( struct net_device * );
 
 static void airo_config(dev_link_t *link);
-static void airo_release(u_long arg);
+static void airo_release(dev_link_t *link);
 static int airo_event(event_t event, int priority,
 		       event_callback_args_t *args);
 
@@ -208,9 +208,6 @@
 		return NULL;
 	}
 	memset(link, 0, sizeof(struct dev_link_t));
-	init_timer(&link->release);
-	link->release.function = &airo_release;
-	link->release.data = (u_long)link;
 	
 	/* Interrupt setup */
 	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
@@ -286,10 +283,9 @@
 	if (*linkp == NULL)
 		return;
 	
-	del_timer(&link->release);
-	if ( link->state & DEV_CONFIG ) {
-		airo_release( (int)link );
-		if ( link->state & DEV_STALE_CONFIG ) {
+	if (link->state & DEV_CONFIG) {
+		airo_release(link);
+		if (link->state & DEV_STALE_CONFIG) {
 			link->state |= DEV_STALE_LINK;
 			return;
 		}
@@ -513,7 +509,7 @@
 	
  cs_failed:
 	cs_error(link->handle, last_fn, last_ret);
-	airo_release((u_long)link);
+	airo_release(link);
 	
 } /* airo_config */
 
@@ -525,10 +521,8 @@
   
   ======================================================================*/
 
-static void airo_release(u_long arg)
+static void airo_release(dev_link_t *link)
 {
-	dev_link_t *link = (dev_link_t *)arg;
-	
 	DEBUG(0, "airo_release(0x%p)\n", link);
 	
 	/*
@@ -588,7 +582,7 @@
 		link->state &= ~DEV_PRESENT;
 		if (link->state & DEV_CONFIG) {
 			netif_device_detach(local->eth_dev);
-			mod_timer(&link->release, jiffies + HZ/20);
+			airo_release(link);
 		}
 		break;
 	case CS_EVENT_CARD_INSERTION:
@@ -639,7 +633,7 @@
 	/* XXX: this really needs to move into generic code.. */
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG)
-			airo_release((u_long)dev_list);
+			airo_release(dev_list);
 		airo_detach(dev_list);
 	}
 }
===== drivers/net/wireless/netwave_cs.c 1.19 vs edited =====
--- 1.19/drivers/net/wireless/netwave_cs.c	Fri Jun 27 21:15:32 2003
+++ edited/drivers/net/wireless/netwave_cs.c	Thu Aug  7 09:58:12 2003
@@ -204,7 +204,7 @@
 /*====================================================================*/
 
 /* PCMCIA (Card Services) related functions */
-static void netwave_release(u_long arg);     /* Card removal */
+static void netwave_release(dev_link_t *link);     /* Card removal */
 static int  netwave_event(event_t event, int priority, 
 					      event_callback_args_t *args);
 static void netwave_pcmcia_config(dev_link_t *arg); /* Runs after card 
@@ -455,10 +455,6 @@
     link = &priv->link;
     link->priv = dev;
 
-    init_timer(&link->release);
-    link->release.function = &netwave_release;
-    link->release.data = (u_long)link;
-	
     /* The io structure describes IO port mapping */
     link->io.NumPorts1 = 16;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
@@ -552,9 +548,8 @@
 	  the release() function is called, that will trigger a proper
 	  detach().
 	*/
-    del_timer(&link->release);
     if (link->state & DEV_CONFIG) {
-	netwave_release((u_long) link);
+	netwave_release(link);
 	if (link->state & DEV_STALE_CONFIG) {
 	    DEBUG(1, "netwave_cs: detach postponed, '%s' still "
 		  "locked\n", link->dev->dev_name);
@@ -1149,7 +1144,7 @@
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    netwave_release((u_long)link);
+    netwave_release(link);
 } /* netwave_pcmcia_config */
 
 /*
@@ -1159,8 +1154,8 @@
  *    device, and release the PCMCIA configuration.  If the device is
  *    still open, this will be postponed until it is closed.
  */
-static void netwave_release(u_long arg) {
-    dev_link_t *link = (dev_link_t *)arg;
+static void netwave_release(dev_link_t *link)
+{
     struct net_device *dev = link->priv;
     netwave_private *priv = dev->priv;
 
@@ -1220,7 +1215,7 @@
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
 	    netif_device_detach(dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    netwave_release(link);
 	}
 	break;
     case CS_EVENT_CARD_INSERTION:
@@ -1738,8 +1733,7 @@
     link->open--;
     netif_stop_queue(dev);
     if (link->state & DEV_STALE_CONFIG)
-	mod_timer(&link->release, jiffies + HZ/20);
-	
+	    netwave_release(link);
     return 0;
 }
 
===== drivers/net/wireless/orinoco_cs.c 1.22 vs edited =====
--- 1.22/drivers/net/wireless/orinoco_cs.c	Tue May 27 03:30:00 2003
+++ edited/drivers/net/wireless/orinoco_cs.c	Thu Aug  7 09:58:12 2003
@@ -110,7 +110,7 @@
 
 /* PCMCIA gumpf */
 static void orinoco_cs_config(dev_link_t * link);
-static void orinoco_cs_release(u_long arg);
+static void orinoco_cs_release(dev_link_t * link);
 static int orinoco_cs_event(event_t event, int priority,
 			    event_callback_args_t * args);
 
@@ -202,11 +202,6 @@
 	link = &card->link;
 	link->priv = dev;
 
-	/* Initialize the dev_link_t structure */
-	init_timer(&link->release);
-	link->release.function = &orinoco_cs_release;
-	link->release.data = (u_long) link;
-
 	/* Interrupt setup */
 	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
 	link->irq.IRQInfo1 = IRQ_INFO2_VALID | IRQ_LEVEL_ID;
@@ -272,7 +267,7 @@
 	}
 
 	if (link->state & DEV_CONFIG) {
-		orinoco_cs_release((u_long)link);
+		orinoco_cs_release(link);
 		if (link->state & DEV_CONFIG) {
 			link->state |= DEV_STALE_LINK;
 			return;
@@ -530,7 +525,7 @@
 	orinoco_cs_error(link->handle, last_fn, last_ret);
 
  failed:
-	orinoco_cs_release((u_long) link);
+	orinoco_cs_release(link);
 }				/* orinoco_cs_config */
 
 /*
@@ -539,9 +534,8 @@
  * still open, this will be postponed until it is closed.
  */
 static void
-orinoco_cs_release(u_long arg)
+orinoco_cs_release(dev_link_t *link)
 {
-	dev_link_t *link = (dev_link_t *) arg;
 	struct net_device *dev = link->priv;
 	struct orinoco_private *priv = dev->priv;
 	unsigned long flags;
@@ -697,7 +691,7 @@
 		DEBUG(0, "orinoco_cs: Removing leftover devices.\n");
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG)
-			orinoco_cs_release((u_long) dev_list);
+			orinoco_cs_release(dev_list);
 		orinoco_cs_detach(dev_list);
 	}
 }
===== drivers/net/wireless/ray_cs.c 1.19 vs edited =====
--- 1.19/drivers/net/wireless/ray_cs.c	Thu Jul 10 18:49:09 2003
+++ edited/drivers/net/wireless/ray_cs.c	Thu Aug  7 09:58:13 2003
@@ -94,7 +94,7 @@
 #endif
 /** Prototypes based on PCMCIA skeleton driver *******************************/
 static void ray_config(dev_link_t *link);
-static void ray_release(u_long arg);
+static void ray_release(dev_link_t *link);
 static int ray_event(event_t event, int priority, event_callback_args_t *args);
 static dev_link_t *ray_attach(void);
 static void ray_detach(dev_link_t *);
@@ -374,10 +374,6 @@
     memset(dev, 0, sizeof(struct net_device));
     memset(local, 0, sizeof(ray_dev_t));
 
-    init_timer(&link->release);
-    link->release.function = &ray_release;
-    link->release.data = (u_long)link;
-
     /* The io structure describes IO port mapping. None used here */
     link->io.NumPorts1 = 0;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
@@ -482,9 +478,8 @@
       the release() function is called, that will trigger a proper
       detach().
     */
-    del_timer(&link->release);
     if (link->state & DEV_CONFIG) {
-        ray_release((u_long)link);
+        ray_release(link);
         if(link->state & DEV_STALE_CONFIG) {
             link->state |= DEV_STALE_LINK;
             return;
@@ -602,14 +597,14 @@
     DEBUG(3,"ray_config rmem=%p\n",local->rmem);
     DEBUG(3,"ray_config amem=%p\n",local->amem);
     if (ray_init(dev) < 0) {
-        ray_release((u_long)link);
+        ray_release(link);
         return;
     }
 
     i = register_netdev(dev);
     if (i != 0) {
         printk("ray_config register_netdev() failed\n");
-        ray_release((u_long)link);
+        ray_release(link);
         return;
     }
 
@@ -627,7 +622,7 @@
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 
-    ray_release((u_long)link);
+    ray_release(link);
 } /* ray_config */
 /*===========================================================================*/
 static int ray_init(struct net_device *dev)
@@ -898,9 +893,8 @@
     device, and release the PCMCIA configuration.  If the device is
     still open, this will be postponed until it is closed.
 =============================================================================*/
-static void ray_release(u_long arg)
+static void ray_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *)arg;
     struct net_device *dev = link->priv; 
     ray_dev_t *local = dev->priv;
     int i;
@@ -959,7 +953,7 @@
         link->state &= ~DEV_PRESENT;
         netif_device_detach(dev);
         if (link->state & DEV_CONFIG) {
-            mod_timer(&link->release, jiffies + HZ/20);
+	    ray_release(link);
             del_timer(&local->timer);
         }
         break;
@@ -1769,7 +1763,7 @@
     link->open--;
     netif_stop_queue(dev);
     if (link->state & DEV_STALE_CONFIG)
-	mod_timer(&link->release, jiffies + HZ/20);
+	    ray_release(link);
 
     /* In here, we should stop the hardware (stop card from beeing active)
      * and set local->card_status to CARD_AWAITING_PARAM, so that while the
===== drivers/net/wireless/wavelan_cs.c 1.24 vs edited =====
--- 1.24/drivers/net/wireless/wavelan_cs.c	Wed May 28 11:01:09 2003
+++ edited/drivers/net/wireless/wavelan_cs.c	Thu Aug  7 09:58:13 2003
@@ -4128,7 +4128,7 @@
   /* If any step failed, release any partially configured state */
   if(i != 0)
     {
-      wv_pcmcia_release((u_long) link);
+      wv_pcmcia_release(link);
       return FALSE;
     }
 
@@ -4148,9 +4148,8 @@
  * still open, this will be postponed until it is closed.
  */
 static void
-wv_pcmcia_release(u_long	arg)	/* Address of the interface struct */
+wv_pcmcia_release(dev_link_t *link)
 {
-  dev_link_t *	link = (dev_link_t *) arg;
   device *	dev = (device *) link->priv;
 
 #ifdef DEBUG_CONFIG_TRACE
@@ -4675,7 +4674,7 @@
   else
     /* The card is no more there (flag is activated in wv_pcmcia_release) */
     if(link->state & DEV_STALE_CONFIG)
-      wv_pcmcia_release((u_long)link);
+      wv_pcmcia_release(link);
 
 #ifdef DEBUG_CALLBACK_TRACE
   printk(KERN_DEBUG "%s: <-wavelan_close()\n", dev->name);
@@ -4714,10 +4713,6 @@
   if (!link) return NULL;
   memset(link, 0, sizeof(struct dev_link_t));
 
-  /* Unused for the Wavelan */
-  link->release.function = &wv_pcmcia_release;
-  link->release.data = (u_long) link;
-
   /* The io structure describes IO port mapping */
   link->io.NumPorts1 = 8;
   link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
@@ -4857,7 +4852,7 @@
   if(link->state & DEV_CONFIG)
     {
       /* Some others haven't done their job : give them another chance */
-      wv_pcmcia_release((u_long) link);
+      wv_pcmcia_release(link);
       if(link->state & DEV_STALE_CONFIG)
 	{
 #ifdef DEBUG_CONFIG_INFO
@@ -4965,7 +4960,7 @@
 	    netif_device_detach(dev);
 
 	    /* Release the card */
-	    wv_pcmcia_release((u_long) link);
+	    wv_pcmcia_release(link);
 	  }
 	break;
 
===== drivers/net/wireless/wavelan_cs.p.h 1.8 vs edited =====
--- 1.8/drivers/net/wireless/wavelan_cs.p.h	Thu May  1 14:32:19 2003
+++ edited/drivers/net/wireless/wavelan_cs.p.h	Thu Aug  7 09:58:14 2003
@@ -761,7 +761,7 @@
 static inline int
 	wv_pcmcia_config(dev_link_t *);	/* Configure the pcmcia interface */
 static void
-	wv_pcmcia_release(u_long),	/* Remove a device */
+	wv_pcmcia_release(dev_link_t *),/* Remove a device */
 	wv_flush_stale_links(void);	/* "detach" all possible devices */
 /* ---------------------- INTERRUPT HANDLING ---------------------- */
 static irqreturn_t
===== drivers/net/wireless/wl3501_cs.c 1.60 vs edited =====
--- 1.60/drivers/net/wireless/wl3501_cs.c	Fri Jul 18 22:46:44 2003
+++ edited/drivers/net/wireless/wl3501_cs.c	Thu Aug  7 10:01:26 2003
@@ -45,7 +45,6 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/timer.h>
 #include <linux/wireless.h>
 
 #include <net/iw_handler.h>
@@ -112,7 +111,7 @@
  * are invoked from the wl24 event handler.
  */
 static void wl3501_config(dev_link_t *link);
-static void wl3501_release(unsigned long arg);
+static void wl3501_release(dev_link_t *link);
 static int wl3501_event(event_t event, int pri, event_callback_args_t *args);
 
 /*
@@ -1262,9 +1261,8 @@
 	wl3501_block_interrupt(this);
 
 	if (link->state & DEV_STALE_CONFIG) {
-		link->release.expires = jiffies + WL3501_RELEASE_TIMEOUT;
 		link->state |= DEV_RELEASE_PENDING;
-		add_timer(&link->release);
+		wl3501_release(link);
 	}
 	rc = 0;
 	printk(KERN_INFO "%s: WL3501 closed\n", dev->name);
@@ -1944,9 +1942,6 @@
 	if (!link)
 		goto out;
 	memset(link, 0, sizeof(struct dev_link_t));
-	init_timer(&link->release);
-	link->release.function	= wl3501_release;
-	link->release.data	= (unsigned long)link;
 
 	/* The io structure describes IO port mapping */
 	link->io.NumPorts1	= 16;
@@ -2135,7 +2130,7 @@
 cs_failed:
 	cs_error(link->handle, last_fn, last_ret);
 failed:
-	wl3501_release((unsigned long)link);
+	wl3501_release(link);
 out:
 	return;
 }
@@ -2148,9 +2143,8 @@
  * and release the PCMCIA configuration.  If the device is still open, this
  * will be postponed until it is closed.
  */
-static void wl3501_release(unsigned long arg)
+static void wl3501_release(dev_link_t *link)
 {
-	dev_link_t *link = (dev_link_t *)arg;
 	struct net_device *dev = link->priv;
 
 	/* If the device is currently in use, we won't release until it is
@@ -2206,9 +2200,7 @@
 			while (link->open > 0)
 				wl3501_close(dev);
 			netif_device_detach(dev);
-			link->release.expires = jiffies +
-						WL3501_RELEASE_TIMEOUT;
-			add_timer(&link->release);
+			wl3501_release(link);
 		}
 		break;
 	case CS_EVENT_CARD_INSERTION:
@@ -2275,11 +2267,10 @@
 	dprintk(0, ": unloading");
 	pcmcia_unregister_driver(&wl3501_driver);
 	while (wl3501_dev_list) {
-		del_timer(&wl3501_dev_list->release);
 		/* Mark the device as non-existing to minimize calls to card */
 		wl3501_dev_list->state &= ~DEV_PRESENT;
 		if (wl3501_dev_list->state & DEV_CONFIG)
-			wl3501_release((unsigned long)wl3501_dev_list);
+			wl3501_release(wl3501_dev_list);
 		wl3501_detach(wl3501_dev_list);
 	}
 }
