Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262162AbSJJTJE>; Thu, 10 Oct 2002 15:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262163AbSJJTJE>; Thu, 10 Oct 2002 15:09:04 -0400
Received: from www.microgate.com ([216.30.46.105]:27914 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262162AbSJJTI5>; Thu, 10 Oct 2002 15:08:57 -0400
Subject: [PATCH] synclink_cs.c 2.5.41
From: Paul Fulghum <paulkf@microgate.com>
To: "davej@suse.de" <davej@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 10 Oct 2002 14:14:46 -0500
Message-Id: <1034277287.785.10.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove cli()/restore()
* Use time_after() macro for jiffie wrap

Please apply

Paul Fulghum
paulkf@microgate.com


--- linux-2.5.41/drivers/char/pcmcia/synclink_cs.c	Thu Oct 10 09:56:24 2002
+++ linux-2.5.41-mg/drivers/char/pcmcia/synclink_cs.c	Thu Oct 10 09:56:11 2002
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/pcmcia/synclink_cs.c
  *
- * $Id: synclink_cs.c,v 4.2 2002/04/22 14:36:43 paulkf Exp $
+ * $Id: synclink_cs.c,v 4.4 2002/10/10 14:53:37 paulkf Exp $
  *
  * Device driver for Microgate SyncLink PC Card
  * multiprotocol serial adapter.
@@ -498,7 +498,7 @@
 MODULE_LICENSE("GPL");
 
 static char *driver_name = "SyncLink PC Card driver";
-static char *driver_version = "$Revision: 4.2 $";
+static char *driver_version = "$Revision: 4.4 $";
 
 static struct tty_driver serial_driver, callout_driver;
 static int serial_refcount;
@@ -2741,7 +2741,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	} else {
@@ -2751,7 +2751,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	}
@@ -2849,12 +2849,12 @@
 		printk("%s(%d):block_til_ready before block on %s count=%d\n",
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
@@ -3319,7 +3319,6 @@
 
 static void __exit synclink_cs_exit(void) 
 {
-	unsigned long flags;
 	int rc;
 
 	printk("Unloading %s: version %s\n", driver_name, driver_version);
@@ -3327,15 +3326,12 @@
 	while(mgslpc_device_list)
 		mgslpc_remove_device(mgslpc_device_list);
 
-	save_flags(flags);
-	cli();
 	if ((rc = tty_unregister_driver(&serial_driver)))
 		printk("%s(%d) failed to unregister tty driver err=%d\n",
 		       __FILE__,__LINE__,rc);
 	if ((rc = tty_unregister_driver(&callout_driver)))
 		printk("%s(%d) failed to unregister callout driver err=%d\n",
 		       __FILE__,__LINE__,rc);
-	restore_flags(flags);
 
 	unregister_pccard_driver(&dev_info);
 	while (dev_list != NULL) {



