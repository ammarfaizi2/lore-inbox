Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTJMPPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJMPPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:15:33 -0400
Received: from mail.cyberdeck.net ([213.30.142.148]:32197 "EHLO
	mail.cyberdeck.com") by vger.kernel.org with ESMTP id S261799AbTJMPPO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:15:14 -0400
From: Patrice Bouchand <PBouchand@cyberdeck.com>
Organization: Cyberdeck
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ib700wdt watchdog driver for 2.4.22
Date: Mon, 13 Oct 2003 17:16:37 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310131716.37782.PBouchand@cyberdeck.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

        The following is a patch for the ib700wdt watchdog driver. I tried to mail 
Charles Howes, but his address seems to be out.

- ibwdt_ping() : a bug remove ,port value must be written not the timeout in 
second

- Add the new parameter "loading_enable" usefull to prevent hang between 
loading and opening

- Driver is a bit more verbose ( init, open, close)

- Watchdog of IB790/IB795 industrial motherboard by IBASE is also supported 
(strictly the same behaviour,  www.ibase.com.tw )

        Comments are welcome,

        Best regards

        Patrice BOUCHAND 

------------------------------------------------------------------------------------------------------------------------

diff -urN -X dontdiff linux-vanilla/Documentation/Configure.help 
linux-2.4.22.modif/Documentation/Configure.help
--- linux-vanilla/Documentation/Configure.help  2003-08-25 13:44:39.000000000 
+0200
+++ linux-2.4.22.modif/Documentation/Configure.help     2003-10-13 
15:15:32.000000000 +0200
@@ -19389,6 +19389,12 @@
   simply watches your kernel to make sure it doesn't freeze, and if
   it does, it reboots your computer after a certain amount of time.
 
+  This driver also works with IB790/IB795 industrial motherboard by IBASE
+  Technology ( www.ibase.com.tw ).
+
+  The new parameter "loading_enable" allows the watchdog to be started as
+  soon as the module is loaded. It prevents hang between loading and opening.
+
   This driver is like the WDT501 driver but for slightly different hardware.
 
   This driver is also available as a module ( = code which can be
diff -urN -X dontdiff linux-vanilla/drivers/char/ib700wdt.c 
linux-2.4.22.modif/drivers/char/ib700wdt.c
--- linux-vanilla/drivers/char/ib700wdt.c       2002-11-29 00:53:12.000000000 +0100
+++ linux-2.4.22.modif/drivers/char/ib700wdt.c  2003-10-13 15:52:25.000000000 
+0200
@@ -1,5 +1,5 @@
 /*
- *     IB700 Single Board Computer WDT driver for Linux 2.4.x
+ *     IB700/IB79X Single Board Computer WDT driver for Linux 2.4.x
  *
  *     (c) Copyright 2001 Charles Howes <chowes@vsol.net>
  *
@@ -25,6 +25,16 @@
  *
  *     (c) Copyright 1995    Alan Cox <alan@redhat.com>
  *
+ *     08 october 2003 : Patrice Bouchand <PBouchand@wanadoo.fr>
+ *                     - ibwdt_ping() : port value must be written not the 
+ *                     timeout
+ *                     - ibwdt_notify_sys() : take care about nowayout...                              
+ *                     - Add the new parameter "loading_enable" usefull to 
+ *                     prevent hang between loading and opening
+ *                     - Driver is a bit more verbose ( init, open, close)
+ *                     - Watchdog of IB790/IB795 industrial motherboard by 
+ *                     IBASE is also supported ( strictly the same behaviour)
+ *                      ( www.ibase.com.tw )
  */
 
 #include <linux/config.h>
@@ -124,6 +134,10 @@
 MODULE_PARM(nowayout,"i");
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started 
(default=CONFIG_WATCHDOG_NOWAYOUT)");
 
+int loading_enable=0;
+MODULE_PARM(loading_enable,"i");
+MODULE_PARM_DESC(loading_enable, "Watchdog is started as soon as module is 
loaded ( default=0 )");
+
 
 /*
  *     Kernel methods.
@@ -133,7 +147,7 @@
 ibwdt_ping(void)
 {
        /* Write a watchdog value */
-       outb_p(wd_times[wd_margin], WDT_START);
+       outb_p(wd_margin, WDT_START);
 }
 
 static ssize_t
@@ -180,7 +194,7 @@
                WDIOF_KEEPALIVEPING |
                WDIOF_SETTIMEOUT |
                WDIOF_MAGICCLOSE,
-               1, "IB700 WDT"
+               1, "IB700,IB79X WDT"
        };
 
        switch (cmd) {
@@ -235,6 +249,7 @@
                         */
 
                        ibwdt_is_open = 1;
+                       printk("ib700wdt: Watchdog is started\n");                      
                        ibwdt_ping();
                        spin_unlock(&ibwdt_lock);
                        return 0;
@@ -250,7 +265,9 @@
        if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
                spin_lock(&ibwdt_lock);
                if (expect_close) {
-                       outb_p(wd_times[wd_margin], WDT_STOP);
+                       outb_p(wd_margin, WDT_STOP);
+                       printk("ib700wdt: Watchdog is stopped\n");                      
+
                } else {
                        printk(KERN_CRIT "WDT device closed unexpectedly.  WDT will not stop!\n");
                }
@@ -269,9 +286,19 @@
 ibwdt_notify_sys(struct notifier_block *this, unsigned long code,
        void *unused)
 {
+
        if (code == SYS_DOWN || code == SYS_HALT) {
-               /* Turn the WDT off */
-               outb_p(wd_times[wd_margin], WDT_STOP);
+               
+               if (nowayout == 1) {
+                   outb_p(0, WDT_START);/* ping a last time with maximum timeout*/
+                   printk("ib700wdt: Watchdog keep on running...\n");                  
+               } else {
+                   /* Turn the WDT off */
+                   outb_p(wd_margin, WDT_STOP);
+                   printk("ib700wdt: Watchdog is stopped\n");                  
+               };
+               
+               
        }
        return NOTIFY_DONE;
 }
@@ -309,15 +336,26 @@
 static int __init
 ibwdt_init(void)
 {
-       printk("WDT driver for IB700 single board computer initialising.\n");
+       printk("WDT driver for IB700/IB79X single board computer initialising.\n");
+       printk("ib700wdt: timeout=%ds  nowayout=%d \n",
+       wd_times[wd_margin],
+       nowayout);
 
        spin_lock_init(&ibwdt_lock);
        misc_register(&ibwdt_miscdev);
 #if WDT_START != WDT_STOP
-       request_region(WDT_STOP, 1, "IB700 WDT");
+       request_region(WDT_STOP, 1, "IB700/IB79X WDT");
 #endif
-       request_region(WDT_START, 1, "IB700 WDT");
+       request_region(WDT_START, 1, "IB700/IB79X WDT");
        register_reboot_notifier(&ibwdt_notifier);
+       
+       if ( loading_enable == 1 ) { /* start timer when module is loaded, usefull 
to prevent hang between loading and opening */
+           spin_lock(&ibwdt_lock);
+           ibwdt_ping();
+           spin_unlock(&ibwdt_lock);
+           printk("ib700wdt: Watchdog is started !");
+        }
+       
        return 0;
 }
 
@@ -336,7 +374,7 @@
 module_exit(ibwdt_exit);
 
 MODULE_AUTHOR("Charles Howes <chowes@vsol.net>");
-MODULE_DESCRIPTION("IB700 SBC watchdog driver");
+MODULE_DESCRIPTION("IB700/IB79X SBC watchdog driver");
 MODULE_LICENSE("GPL");
 
 /* end of ib700wdt.c */
