Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRFMKFU>; Wed, 13 Jun 2001 06:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbRFMKFL>; Wed, 13 Jun 2001 06:05:11 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:59102 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262715AbRFMKE7> convert rfc822-to-8bit; Wed, 13 Jun 2001 06:04:59 -0400
From: DJBARROW@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: alan@lxorguk.ukuu.org.uk, "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A6A.0037540A.00@d12mta09.de.ibm.com>
Date: Wed, 13 Jun 2001 12:03:34 +0200
Subject: Re: bug in /net/core/dev.c
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

Here is the patch again for the benefit of those who are allergic to
opening enclosures.
I believe it will only take about 30 seconds of "real thinking" for those
familiar with dev.c to make
an evaluation of the patch.

Those already familiar with the bug can skip this paragraph,
The bug fixes a problem that occurs if register_netdev gets called before
net_dev_init the dev->refcnt gets incremented to 2 after net_dev_init is
called
& unregister_netdev will loop forever.


The  following additional lines at the top of register_netdev will call
net_dev_init
if it hasn't already been called & by doing this I'm able to remove about
20 lines of special
case code in this function.
+    if (dev_boot_phase)
+         net_dev_init();

The following additional lines in net_dev_init will do a quick exit if this
routine
as already been called ( as may be done from register_netdev ).
+    if(!dev_boot_phase)
+         return 0;





--- net/core/dev.old.c   Wed May 30 14:24:47 2001
+++ net/core/dev.c  Tue Jun 12 15:37:58 2001
@@ -20,6 +20,10 @@
  *              Pekka Riikonen <priikone@poesidon.pspt.fi>
  *
  *  Changes:
+ *              D.J. Barrow     :       Fixed bug where dev->refcnt gets
set to 2
+ *                                      if register_netdev gets called
before
+ *                                      net_dev_init & also removed a few
lines
+ *                                      of code in the process.
  *       Alan Cox  :    device private ioctl copies fields back.
  *       Alan Cox  :    Transmit queue code does relevant stunts to
  *                      keep the queue safe.
@@ -2382,6 +2386,7 @@
  *  will not get the same name.
  */

+int net_dev_init(void);
 int register_netdevice(struct net_device *dev)
 {
     struct net_device *d, **dp;
@@ -2396,48 +2401,8 @@
     dev->fastpath_lock=RW_LOCK_UNLOCKED;
 #endif

-    if (dev_boot_phase) {
-#ifdef CONFIG_NET_DIVERT
-         ret = alloc_divert_blk(dev);
-         if (ret)
-              return ret;
-#endif /* CONFIG_NET_DIVERT */
-
-         /* This is NOT bug, but I am not sure, that all the
-            devices, initialized before netdev module is started
-            are sane.
-
-            Now they are chained to device boot list
-            and probed later. If a module is initialized
-            before netdev, but assumes that dev->init
-            is really called by register_netdev(), it will fail.
-
-            So that this message should be printed for a while.
-          */
-         printk(KERN_INFO "early initialization of device %s is
deferred\n", dev->name);
-
-         /* Check for existence, and append to tail of chain */
-         for (dp=&dev_base; (d=*dp) != NULL; dp=&d->next) {
-              if (d == dev || strcmp(d->name, dev->name) == 0) {
-                   return -EEXIST;
-              }
-         }
-         dev->next = NULL;
-         write_lock_bh(&dev_base_lock);
-         *dp = dev;
-         dev_hold(dev);
-         write_unlock_bh(&dev_base_lock);
-
-         /*
-          *   Default initial state at registry is that the
-          *   device is present.
-          */
-
-         set_bit(__LINK_STATE_PRESENT, &dev->state);
-
-         return 0;
-    }
-
+    if (dev_boot_phase)
+         net_dev_init();
 #ifdef CONFIG_NET_DIVERT
     ret = alloc_divert_blk(dev);
     if (ret)
@@ -2679,7 +2644,9 @@
 {
     struct net_device *dev, **dp;
     int i;
-
+
+    if(!dev_boot_phase)
+         return 0;
 #ifdef CONFIG_NET_SCHED
     pktsched_init();
 #endif


D.J. Barrow Gnu/Linux for S/390 kernel developer
eMail: djbarrow@de.ibm.com,barrow_dj@yahoo.com
Phone: +49-(0)7031-16-2583
IBM Germany Lab, Schönaicherstr. 220, 71032 Böblingen


