Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313727AbSDZIzp>; Fri, 26 Apr 2002 04:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313730AbSDZIzp>; Fri, 26 Apr 2002 04:55:45 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:61704 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313727AbSDZIzm>;
	Fri, 26 Apr 2002 04:55:42 -0400
Date: Fri, 26 Apr 2002 04:55:40 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/char/eurotechwdt.c
Message-ID: <Pine.LNX.4.33.0204260452400.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
The attached patch against 2.4.19-pre7 updates drivers/char/eurotechwdt.c in
the following ways:
	-clean up #includes
	-clean up locking
	-make __setup param unique
	-proper options in watchdog_info
	-add expect close support
	-add ioctls

This patch has been approved by the maintainer, Rodolfo Giometti.

Regards,
Rob Radez

--- linux-2.4.19-pre7/drivers/char/eurotechwdt.c	Tue Apr 16 13:18:17 2002
+++ watchdog-tree/drivers/char/eurotechwdt.c	Thu Apr 25 02:07:08 2002
@@ -3,6 +3,7 @@
  *
  *	(c) Copyright 2001 Ascensit <support@ascensit.com>
  *	(c) Copyright 2001 Rodolfo Giometti <giometti@ascensit.com>
+ *	(c) Copyright 2002 Rob Radez <rob@osinvestor.com>
  *
  *	Based on wdt.c.
  *	Original copyright messages:
@@ -22,17 +23,27 @@
  *      (c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>*
  */

+/* Changelog:
+ *
+ * 2002/04/25 - Rob Radez
+ *	clean up #includes
+ *	clean up locking
+ *	make __setup param unique
+ *	proper options in watchdog_info
+ *	add WDIOC_GETSTATUS and WDIOC_SETOPTIONS ioctls
+ *	add expect_close support
+ *
+ * 2001 - Rodolfo Giometti
+ *	Initial release
+ */
+
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
-#include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <asm/io.h>
@@ -41,12 +52,10 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/smp_lock.h>

-static int eurwdt_is_open;
+static unsigned long eurwdt_is_open;
 static int eurwdt_timeout;
-static spinlock_t eurwdt_lock;
+static char eur_expect_close;

 /*
  *      You must set these - there is no sane way to probe for this board.
@@ -100,7 +109,7 @@
    return 1;
 }

-__setup("wdt=", eurwdt_setup);
+__setup("eurwdt=", eurwdt_setup);

 #endif /* !MODULE */

@@ -109,7 +118,7 @@
 MODULE_PARM(irq, "i");
 MODULE_PARM_DESC(irq, "Eurotech WDT irq (default=10)");
 MODULE_PARM(ev, "s");
-MODULE_PARM_DESC(ev, "Eurotech WDT event type (default is `reboot')");
+MODULE_PARM_DESC(ev, "Eurotech WDT event type (default is `int')");


 /*
@@ -211,11 +220,20 @@
       return -ESPIPE;

    if (count) {
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+      size_t i;
+
+      eur_expect_close = 0;
+
+      for (i = 0; i != count; i++) {
+         if (buf[i] == 'V')
+            eur_expect_close = 42;
+      }
+#endif
       eurwdt_ping();   /* the default timeout */
-      return 1;
    }

-   return 0;
+   return count;
 }

 /**
@@ -233,8 +251,8 @@
         unsigned int cmd, unsigned long arg)
 {
    static struct watchdog_info ident = {
-      options		: WDIOF_CARDRESET | WDIOF_SETTIMEOUT,
-      firmware_version	: 1,
+      options		: WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+      firmware_version	: 0,
       identity		: "WDT Eurotech CPU-1220/1410"
    };

@@ -248,6 +266,7 @@
          return copy_to_user((struct watchdog_info *)arg, &ident,
                sizeof(ident)) ? -EFAULT : 0;

+      case WDIOC_GETSTATUS:
       case WDIOC_GETBOOTSTATUS:
          return put_user(0, (int *) arg);

@@ -269,6 +288,27 @@

       case WDIOC_GETTIMEOUT:
 	 return put_user(eurwdt_timeout, (int *)arg);
+
+      case WDIOC_SETOPTIONS:
+      {
+	 int options, retval = -EINVAL;
+
+	 if (get_user(options, (int *)arg))
+	    return -EFAULT;
+
+	 if (options & WDIOS_DISABLECARD) {
+	    eurwdt_disable_timer();
+	    retval = 0;
+	 }
+
+	 if (options & WDIOS_ENABLECARD) {
+	    eurwdt_activate_timer();
+	    eurwdt_ping();
+	    retval = 0;
+	 }
+
+	 return retval;
+      }
    }
 }

@@ -283,32 +323,15 @@

 static int eurwdt_open(struct inode *inode, struct file *file)
 {
-   switch (MINOR(inode->i_rdev)) {
-      case WATCHDOG_MINOR:
-         spin_lock(&eurwdt_lock);
-         if (eurwdt_is_open) {
-            spin_unlock(&eurwdt_lock);
-            return -EBUSY;
-         }
-
-         eurwdt_is_open = 1;
-         eurwdt_timeout = WDT_TIMEOUT;   /* initial timeout */
-
-         /* Activate the WDT */
-         eurwdt_activate_timer();
-
-         spin_unlock(&eurwdt_lock);
-
-         MOD_INC_USE_COUNT;
+   if (test_and_set_bit(0, &eurwdt_is_open))
+      return -EBUSY;

-         return 0;
+   eurwdt_timeout = WDT_TIMEOUT;   /* initial timeout */

-         case TEMP_MINOR:
-            return 0;
+   /* Activate the WDT */
+   eurwdt_activate_timer();

-         default:
-            return -ENODEV;
-   }
+   return 0;
 }

 /**
@@ -325,14 +348,14 @@

 static int eurwdt_release(struct inode *inode, struct file *file)
 {
-   if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+   if (eur_expect_close == 42) {
       eurwdt_disable_timer();
-#endif
-      eurwdt_is_open = 0;
-
-      MOD_DEC_USE_COUNT;
+   } else {
+      printk(KERN_CRIT "eurwdt: Unexpected close, not stopping watchdog!\n");
+      eurwdt_ping();
    }
+   clear_bit(0, &eurwdt_is_open);
+   eur_expect_close = 0;

    return 0;
 }
@@ -376,9 +399,9 @@

 static struct miscdevice eurwdt_miscdev =
 {
-        WATCHDOG_MINOR,
-        "watchdog",
-        &eurwdt_fops
+        minor:		WATCHDOG_MINOR,
+        name:		"watchdog",
+        fops:		&eurwdt_fops,
 };

 /*
@@ -457,8 +480,6 @@
    printk(KERN_INFO "Eurotech WDT driver 0.01 at %X (Interrupt %d)"
                     " - timeout event: %s\n",
          io, irq, (!strcmp("int", ev) ? "int" : "reboot"));
-
-   spin_lock_init(&eurwdt_lock);

    out:
       return ret;

