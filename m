Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTEMSCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTEMSBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:01:44 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:15911 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263376AbTEMSBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:01:05 -0400
Subject: [PATCH] 2.5.69 synclink_cs.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052849546.1992.6.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 May 2003 13:12:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove PCMCIA release from timer context
* Add irqreturn_t to ISR
* Add dosyncppp module parameter

Please apply.



--- linux-2.5.69/drivers/char/pcmcia/synclink_cs.c	2003-05-06 14:16:19.000000000 -0500
+++ linux-2.5.69-mg/drivers/char/pcmcia/synclink_cs.c	2003-05-13 13:08:55.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/pcmcia/synclink_cs.c
  *
- * $Id: synclink_cs.c,v 4.6 2003/04/21 17:46:55 paulkf Exp $
+ * $Id: synclink_cs.c,v 4.10 2003/05/13 16:06:03 paulkf Exp $
  *
  * Device driver for Microgate SyncLink PC Card
  * multiprotocol serial adapter.
@@ -430,7 +430,7 @@
 static int  rx_alloc_buffers(MGSLPC_INFO *info);
 static void rx_free_buffers(MGSLPC_INFO *info);
 
-static void mgslpc_isr(int irq, void *dev_id, struct pt_regs * regs);
+static irqreturn_t mgslpc_isr(int irq, void *dev_id, struct pt_regs * regs);
 
 /*
  * Bottom half interrupt handlers
@@ -476,6 +476,7 @@
 
 static int debug_level = 0;
 static int maxframe[MAX_DEVICE_COUNT] = {0,};
+static int dosyncppp[MAX_DEVICE_COUNT] = {1,1,1,1};
 
 /* The old way: bit map of interrupts to choose from */
 /* This means pick from 15, 14, 12, 11, 10, 9, 7, 5, 4, and 3 */
@@ -492,11 +493,12 @@
 MODULE_PARM(cuamajor,"i");
 MODULE_PARM(debug_level,"i");
 MODULE_PARM(maxframe,"1-" __MODULE_STRING(MAX_DEVICE_COUNT) "i");
+MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICE_COUNT) "i");
 
 MODULE_LICENSE("GPL");
 
 static char *driver_name = "SyncLink PC Card driver";
-static char *driver_version = "$Revision: 4.6 $";
+static char *driver_version = "$Revision: 4.10 $";
 
 static struct tty_driver serial_driver, callout_driver;
 static int serial_refcount;
@@ -574,9 +576,6 @@
     link->priv = info;
     
     /* Initialize the dev_link_t structure */
-    init_timer(&link->release);
-    link->release.function = &mgslpc_release;
-    link->release.data = (u_long)link;
 
     /* Interrupt setup */
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
@@ -813,7 +812,7 @@
 	    link->state &= ~DEV_PRESENT;
 	    if (link->state & DEV_CONFIG) {
 		    ((MGSLPC_INFO *)link->priv)->stop = 1;
-		    mod_timer(&link->release, jiffies + HZ/20);
+		    mgslpc_release((u_long)link);
 	    }
 	    break;
     case CS_EVENT_CARD_INSERTION:
@@ -1356,7 +1355,7 @@
  * dev_id  device ID supplied during interrupt registration
  * regs    interrupted processor context
  */
-static void mgslpc_isr(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t mgslpc_isr(int irq, void *dev_id, struct pt_regs * regs)
 {
 	MGSLPC_INFO * info = (MGSLPC_INFO *)dev_id;
 	unsigned short isr;
@@ -1366,10 +1365,10 @@
 	if (debug_level >= DEBUG_LEVEL_ISR)	
 		printk("mgslpc_isr(%d) entry.\n", irq);
 	if (!info)
-		return;
+		return IRQ_NONE;
 		
 	if (!(info->link.state & DEV_CONFIG))
-		return;
+		return IRQ_HANDLED;
 
 	spin_lock(&info->lock);
 
@@ -1459,6 +1458,8 @@
 	if (debug_level >= DEBUG_LEVEL_ISR)	
 		printk("%s(%d):mgslpc_isr(%d)exit.\n",
 		       __FILE__,__LINE__,irq);
+
+	return IRQ_HANDLED;
 }
 
 /* Initialize and start device.
@@ -3113,8 +3114,7 @@
 	if (info->line < MAX_DEVICE_COUNT) {
 		if (maxframe[info->line])
 			info->max_frame_size = maxframe[info->line];
-//		info->dosyncppp = dosyncppp[info->line];
-		info->dosyncppp = 1;
+		info->dosyncppp = dosyncppp[info->line];
 	}
 
 	mgslpc_device_count++;
@@ -3276,7 +3276,6 @@
 
 	unregister_pccard_driver(&dev_info);
 	while (dev_list != NULL) {
-		del_timer(&dev_list->release);
 		if (dev_list->state & DEV_CONFIG)
 			mgslpc_release((u_long)dev_list);
 		mgslpc_detach(dev_list);


-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


