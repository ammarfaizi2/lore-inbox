Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262086AbSJJTGB>; Thu, 10 Oct 2002 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbSJJTGB>; Thu, 10 Oct 2002 15:06:01 -0400
Received: from www.microgate.com ([216.30.46.105]:24586 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262086AbSJJTEe>; Thu, 10 Oct 2002 15:04:34 -0400
Subject: [PATCH] synclink.c 2.5.41
From: Paul Fulghum <paulkf@microgate.com>
To: "davej@suse.de" <davej@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 10 Oct 2002 14:10:21 -0500
Message-Id: <1034277022.785.3.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Remove cli()/restore()
* Use time_after() macro for jiffie wrap
* Remove unecessary printk

Please apply

Paul Fulghum
paulkf@microgate.com


--- linux-2.5.41/drivers/char/synclink.c	Thu Oct 10 09:56:24 2002
+++ linux-2.5.41-mg/drivers/char/synclink.c	Thu Oct 10 09:56:05 2002
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.2 2002/04/10 20:45:13 paulkf Exp $
+ * $Id: synclink.c,v 4.4 2002/10/10 14:53:36 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -917,7 +917,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.2 $";
+static char *driver_version = "$Revision: 4.4 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -3387,7 +3387,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	} else {
@@ -3397,7 +3397,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	}
@@ -3512,12 +3512,12 @@
 		printk("%s(%d):block_til_ready before block on %s count=%d\n",
 			 __FILE__,__LINE__, tty->driver.name, info->count );
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->irq_spinlock, flags);
 	if (!tty_hung_up_p(filp)) {
 		extra_count = 1;
 		info->count--;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->irq_spinlock, flags);
 	info->blocked_open++;
 	
 	while (1) {
@@ -4728,21 +4728,18 @@
 
 static void __exit synclink_exit(void) 
 {
-	unsigned long flags;
 	int rc;
 	struct mgsl_struct *info;
 	struct mgsl_struct *tmp;
 
 	printk("Unloading %s: %s\n", driver_name, driver_version);
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
 
 	info = mgsl_device_list;
 	while(info) {
@@ -7486,7 +7483,7 @@
 	EndTime = jiffies + jiffies_from_ms(100);
 
 	for(;;) {
-		if ( jiffies > EndTime ) {
+		if (time_after(jiffies, EndTime)) {
 			rc = FALSE;
 			break;
 		}
@@ -7542,7 +7539,7 @@
 	EndTime = jiffies + jiffies_from_ms(100);
 
 	for(;;) {
-		if ( jiffies > EndTime ) {
+		if (time_after(jiffies, EndTime)) {
 			rc = FALSE;
 			break;
 		}
@@ -7590,7 +7587,7 @@
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
 		while ( !(status & (BIT6+BIT5+BIT4+BIT2+BIT1)) ) {
-			if ( jiffies > EndTime ) {
+			if (time_after(jiffies, EndTime)) {
 				rc = FALSE;
 				break;
 			}
@@ -7617,8 +7614,7 @@
 		/* Wait for 16C32 to write receive status to buffer entry. */
 		status=info->rx_buffer_list[0].status;
 		while ( status == 0 ) {
-			if ( jiffies > EndTime ) {
-			printk(KERN_ERR"mark 4\n");
+			if (time_after(jiffies, EndTime)) {
 				rc = FALSE;
 				break;
 			}



