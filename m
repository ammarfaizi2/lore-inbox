Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbSIZCmm>; Wed, 25 Sep 2002 22:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262149AbSIZCmm>; Wed, 25 Sep 2002 22:42:42 -0400
Received: from m-net.arbornet.org ([209.142.209.161]:56076 "EHLO arbornet.org")
	by vger.kernel.org with ESMTP id <S262148AbSIZCmk>;
	Wed, 25 Sep 2002 22:42:40 -0400
Date: Wed, 25 Sep 2002 22:49:08 -0400 (EDT)
From: Eric Blade <eblade@m-net.arbornet.org>
Message-Id: <200209260249.g8Q2n8nO006813@m-net.arbornet.org>
To: linux-kernel@vger.kernel.org
Subject: small patch for power.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!
 
 Just a small patch to FIX the FIXME at the top of linux/drivers/base/power.c
 
 Sending this from here, as apparently Evolution does not operate properly under
2.5.38!  ( i am eblade@blackmagik.dynup.net )
 
--- linux/drivers/base/power.orig	Wed Sep 25 07:17:29 2002
+++ linux/drivers/base/power.c	Wed Sep 25 22:36:23 2002
@@ -6,9 +6,6 @@
  * 
  *  Kai Germaschewski contributed to the list walking routines.
  *
- * FIXME: The suspend and shutdown walks are identical. The resume walk
- * is simply walking the list backward. Anyway we can combine these (cleanly)?
- *
  */
 
 #include <linux/device.h>
@@ -18,13 +15,15 @@
 #define to_dev(node) container_of(node,struct device,g_list)
 
 /**
- * device_suspend - suspend all devices on the device tree
+ * device_suspend - suspend/remove all devices on the device ree
  * @state:	state we're entering
- * @level:	what stage of the suspend process we're at 
- * 
- * The entries in the global device list are inserted such that they're in a 
- * depth-first ordering. So, simply iterate over the list, and call the driver's
- * suspend callback for each device.
+ * @level:	what stage of the suspend process we're at
+ *    (emb: it seems that these two arguments are described backwards of what
+ *          they actually mean .. is this correct?)
+ *
+ * The entries in the global device list are inserted such that they're in a
+ * depth-first ordering.  So, simply interate over the list, and call the 
+ * driver's suspend or remove callback for each device.
  */
 int device_suspend(u32 state, u32 level)
 {
@@ -32,15 +31,23 @@
 	struct device * prev = NULL;
 	int error = 0;
 
-	printk(KERN_EMERG "Suspending Devices\n");
+	if(level == SUSPEND_SHUT_DOWN)
+		printk(KERN_EMERG "Shutting down devices\n");
+	else
+		printk(KERN_EMERG "Suspending devices\n");
 
 	spin_lock(&device_lock);
 	list_for_each(node,&global_device_list) {
 		struct device * dev = get_device_locked(to_dev(node));
 		if (dev) {
 			spin_unlock(&device_lock);
-			if (dev->driver && dev->driver->suspend)
-				error = dev->driver->suspend(dev,state,level);
+			if(dev->driver) {
+				if(level == SUSPEND_SHUT_DOWN) {
+				       	if(dev->driver->remove)
+						dev->driver->remove(dev);
+				} else if(dev->driver->suspend) 
+					error = dev->driver->suspend(dev,state,level);
+			}
 			if (prev)
 				put_device(prev);
 			prev = dev;
@@ -84,36 +91,12 @@
 }
 
 /**
- * device_shutdown - queisce all the devices before reboot/shutdown
- *
- * Do depth first iteration over device tree, calling ->remove() for each
- * device. This should ensure the devices are put into a sane state before
- * we reboot the system.
- *
+ * device_shutdown - call device_suspend with status set to shutdown, to 
+ * cause all devices to remove themselves cleanly 
  */
 void device_shutdown(void)
 {
-	struct list_head * node, * next;
-	struct device * prev = NULL;
-
-	printk(KERN_EMERG "Shutting down devices\n");
-
-	spin_lock(&device_lock);
-	list_for_each_safe(node,next,&global_device_list) {
-		struct device * dev = get_device_locked(to_dev(node));
-		if (dev) {
-			spin_unlock(&device_lock);
-			if (dev->driver && dev->driver->remove)
-				dev->driver->remove(dev);
-			if (prev)
-				put_device(prev);
-			prev = dev;
-			spin_lock(&device_lock);
-		}
-	}
-	spin_unlock(&device_lock);
-	if (prev)
-		put_device(prev);
+	device_suspend(4, SUSPEND_SHUT_DOWN);
 }
 
 EXPORT_SYMBOL(device_suspend);

