Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSJJTH3>; Thu, 10 Oct 2002 15:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSJJTH3>; Thu, 10 Oct 2002 15:07:29 -0400
Received: from www.microgate.com ([216.30.46.105]:26634 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262129AbSJJTHQ>; Thu, 10 Oct 2002 15:07:16 -0400
Subject: [PATCH] synclinkmp.c 2.5.41
From: Paul Fulghum <paulkf@microgate.com>
To: "davej@suse.de" <davej@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 10 Oct 2002 14:13:04 -0500
Message-Id: <1034277185.785.7.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove cli()/restore()
* Use time_after() macro for jiffie wrap
* call timer_init() before actual timer usage

Please apply

Paul Fulghum
paulkf@microgate.com


--- linux-2.5.41/drivers/char/synclinkmp.c	Thu Oct 10 09:56:24 2002
+++ linux-2.5.41-mg/drivers/char/synclinkmp.c	Thu Oct 10 09:56:06 2002
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.4 2002/04/22 16:05:41 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.6 2002/10/10 14:50:47 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -503,7 +503,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.4 $";
+static char *driver_version = "$Revision: 4.6 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -1204,7 +1204,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	} else {
@@ -1215,7 +1215,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	}
@@ -2605,18 +2605,11 @@
 
 	info->pending_bh = 0;
 
-	init_timer(&info->tx_timer);
-	info->tx_timer.data = (unsigned long)info;
-	info->tx_timer.function = tx_timeout;
-
 	/* program hardware for current parameters */
 	reset_port(info);
 
 	change_params(info);
 
-	init_timer(&info->status_timer);
-	info->status_timer.data = (unsigned long)info;
-	info->status_timer.function = status_timeout;
 	info->status_timer.expires = jiffies + jiffies_from_ms(10);
 	add_timer(&info->status_timer);
 
@@ -3304,12 +3297,12 @@
 		printk("%s(%d):%s block_til_ready() before block, count=%d\n",
 			 __FILE__,__LINE__, tty->driver.name, info->count );
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	if (!tty_hung_up_p(filp)) {
 		extra_count = 1;
 		info->count--;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 	info->blocked_open++;
 
 	while (1) {
@@ -3772,6 +3765,14 @@
 		info->bus_type = MGSL_BUS_TYPE_PCI;
 		info->irq_flags = SA_SHIRQ;
 
+		init_timer(&info->tx_timer);
+		info->tx_timer.data = (unsigned long)info;
+		info->tx_timer.function = tx_timeout;
+
+		init_timer(&info->status_timer);
+		info->status_timer.data = (unsigned long)info;
+		info->status_timer.function = status_timeout;
+
 		/* Store the PCI9050 misc control register value because a flaw
 		 * in the PCI9050 prevents LCR registers from being read if
 		 * BIOS assigns an LCR base address with bit 7 set.
@@ -3959,15 +3960,13 @@
 	SLMP_INFO *tmp;
 
 	printk("Unloading %s %s\n", driver_name, driver_version);
-	save_flags(flags);
-	cli();
+
 	if ((rc = tty_unregister_driver(&serial_driver)))
 		printk("%s(%d) failed to unregister tty driver err=%d\n",
 		       __FILE__,__LINE__,rc);
 	if ((rc = tty_unregister_driver(&callout_driver)))
 		printk("%s(%d) failed to unregister callout driver err=%d\n",
 		       __FILE__,__LINE__,rc);
-	restore_flags(flags);
 
 	info = synclinkmp_device_list;
 	while(info) {



