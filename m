Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261830AbSJNFws>; Mon, 14 Oct 2002 01:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSJNFws>; Mon, 14 Oct 2002 01:52:48 -0400
Received: from bgp01116664bgs.westln01.mi.comcast.net ([68.42.104.18]:62546
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id <S261830AbSJNFwr>; Mon, 14 Oct 2002 01:52:47 -0400
Subject: Patch: linux-2.5.42/drivers/base/power.c - add state for SHUT_DOWN
From: Eric Blade <eblade@blackmagik.dynup.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 14 Oct 2002 01:53:17 -0400
Message-Id: <1034574797.2683.60.camel@cpq>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I tested this against a fresh kernel tree, not once but 4 times. 
I'm not sure why people have had problems applying this.

This also fixes some slight spacing issues  -  if(x)  vs if (x) ...

This doesn't fix the problem with IDE spinning down on reboot, but it
does fix what could potentially be problems with very low power suspend
levels in the ACPI code.

--- a/include/linux/device.h    Sat Oct 12 00:22:19 2002
+++ linux/include/linux/device.h        Mon Oct 14 01:48:47 2002
@@ -40,6 +40,7 @@
        SUSPEND_SAVE_STATE,
        SUSPEND_DISABLE,
        SUSPEND_POWER_DOWN,
+       SUSPEND_SHUT_DOWN,
 };

 enum {
--- a/drivers/base/power.c      Sat Oct 12 00:22:11 2002
+++ linux/drivers/base/power.c  Mon Oct 14 01:49:22 2002
@@ -31,7 +31,7 @@
        struct device * prev = NULL;
        int error = 0;

-       if(level == SUSPEND_POWER_DOWN)
+       if (level == SUSPEND_SHUT_DOWN)
                printk(KERN_EMERG "Shutting down devices\n");
        else
                printk(KERN_EMERG "Suspending devices\n");
@@ -41,11 +41,11 @@
                struct device * dev = get_device_locked(to_dev(node));
                if (dev) {
                        spin_unlock(&device_lock);
-                       if(dev->driver) {
-                               if(level == SUSPEND_POWER_DOWN) {
-                                       if(dev->driver->remove)
+                       if (dev->driver) {
+                               if (level == SUSPEND_SHUT_DOWN) {
+                                       if (dev->driver->remove)
                                               
dev->driver->remove(dev);
-                               } else if(dev->driver->suspend) 
+                               } else if (dev->driver->suspend) 
                                        error =
dev->driver->suspend(dev,state,level);
                        }
                        if (prev)
@@ -96,7 +96,7 @@
  */
 void device_shutdown(void)
 {
-       device_suspend(4, SUSPEND_POWER_DOWN);
+       device_suspend(4, SUSPEND_SHUT_DOWN);
 }

 EXPORT_SYMBOL(device_suspend);



