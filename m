Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUCEQt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbUCEQt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:49:59 -0500
Received: from adicia.telenet-ops.be ([195.130.132.56]:8378 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262644AbUCEQto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:49:44 -0500
Date: Fri, 5 Mar 2004 17:49:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.3 moduleparam-patches
Message-ID: <20040305174904.O30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/amd7xx_tco.c  |   19 -----------------
 drivers/char/watchdog/cpu5wdt.c     |    7 +++---
 drivers/char/watchdog/eurotechwdt.c |   39 ++++--------------------------------
 drivers/char/watchdog/sc1200wdt.c   |   35 ++++----------------------------
 drivers/char/watchdog/wdt.c         |   38 +++--------------------------------
 5 files changed, 18 insertions(+), 120 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/03/05 1.1649)
   [WATCHDOG] v2.6.3 moduleparam-patch
   
   Convert last set of watchdog drivers to new moduleparam system.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/amd7xx_tco.c b/drivers/char/watchdog/amd7xx_tco.c
--- a/drivers/char/watchdog/amd7xx_tco.c	Fri Mar  5 17:41:42 2004
+++ b/drivers/char/watchdog/amd7xx_tco.c	Fri Mar  5 17:41:42 2004
@@ -365,25 +365,6 @@
 	unregister_reboot_notifier(&amdtco_notifier);
 }
 
-
-#ifndef MODULE
-static int __init amdtco_setup(char *str)
-{
-	int ints[4];
-
-	str = get_options (str, ARRAY_SIZE(ints), ints);
-	if (ints[0] > 0)
-		timeout = ints[1];
-
-	if (!timeout || timeout > MAX_TIMEOUT)
-		timeout = MAX_TIMEOUT;
-
-	return 1;
-}
-
-__setup("amd7xx_tco=", amdtco_setup);
-#endif
-
 module_init(amdtco_init);
 module_exit(amdtco_exit);
 
diff -Nru a/drivers/char/watchdog/cpu5wdt.c b/drivers/char/watchdog/cpu5wdt.c
--- a/drivers/char/watchdog/cpu5wdt.c	Fri Mar  5 17:41:42 2004
+++ b/drivers/char/watchdog/cpu5wdt.c	Fri Mar  5 17:41:42 2004
@@ -20,6 +20,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/miscdevice.h>
@@ -295,11 +296,11 @@
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 
-MODULE_PARM(port, "i");
+module_param(port, int, 0);
 MODULE_PARM_DESC(port, "base address of watchdog card, default is 0x91");
 
-MODULE_PARM(verbose, "i");
+module_param(verbose, int, 0);
 MODULE_PARM_DESC(verbose, "be verbose, default is 0 (no)");
 
-MODULE_PARM(ticks, "i");
+module_param(ticks, int, 0);
 MODULE_PARM_DESC(ticks, "count down ticks, default is 10000");
diff -Nru a/drivers/char/watchdog/eurotechwdt.c b/drivers/char/watchdog/eurotechwdt.c
--- a/drivers/char/watchdog/eurotechwdt.c	Fri Mar  5 17:41:42 2004
+++ b/drivers/char/watchdog/eurotechwdt.c	Fri Mar  5 17:41:42 2004
@@ -43,6 +43,7 @@
 #include <linux/config.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
@@ -77,7 +78,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
@@ -94,41 +95,11 @@
 #define WDT_TIMER_CFG		0xf3
 
 
-#ifndef MODULE
-
-/**
- * eurwdt_setup:
- * @str: command line string
- *
- * Setup options. The board isn't really probe-able so we have to
- * get the user to tell us the configuration. Sane people build it
- * modular but the others come here.
- */
-
-static int __init eurwdt_setup(char *str)
-{
-	int ints[4];
-
-str = get_options (str, ARRAY_SIZE(ints), ints);
-
-	if (ints[0] > 0) {
-		io = ints[1];
-		if (ints[0] > 1)
-			irq = ints[2];
-	}
-
-	return 1;
-}
-
-__setup("eurwdt=", eurwdt_setup);
-
-#endif /* !MODULE */
-
-MODULE_PARM(io, "i");
+module_param(io, int, 0);
 MODULE_PARM_DESC(io, "Eurotech WDT io port (default=0x3f0)");
-MODULE_PARM(irq, "i");
+module_param(irq, int, 0);
 MODULE_PARM_DESC(irq, "Eurotech WDT irq (default=10)");
-MODULE_PARM(ev, "s");
+module_param(ev, charp, 0);
 MODULE_PARM_DESC(ev, "Eurotech WDT event type (default is `int')");
 
 
diff -Nru a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
--- a/drivers/char/watchdog/sc1200wdt.c	Fri Mar  5 17:41:42 2004
+++ b/drivers/char/watchdog/sc1200wdt.c	Fri Mar  5 17:41:42 2004
@@ -29,6 +29,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/ioport.h>
@@ -80,13 +81,13 @@
 static int isapnp = 1;
 static struct pnp_dev *wdt_dev;
 
-MODULE_PARM(isapnp, "i");
+module_param(isapnp, int, 0);
 MODULE_PARM_DESC(isapnp, "When set to 0 driver ISA PnP support will be disabled");
 #endif
 
-MODULE_PARM(io, "i");
+module_param(io, int, 0);
 MODULE_PARM_DESC(io, "io port");
-MODULE_PARM(timeout, "i");
+module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "range is 0-255 minutes, default is 1");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -95,7 +96,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 
@@ -453,32 +454,6 @@
 #endif
 	release_region(io, io_len);
 }
-
-
-#ifndef MODULE
-static int __init sc1200wdt_setup(char *str)
-{
-	int ints[4];
-
-	str = get_options (str, ARRAY_SIZE(ints), ints);
-
-	if (ints[0] > 0) {
-		io = ints[1];
-		if (ints[0] > 1)
-			timeout = ints[2];
-
-#if defined CONFIG_PNP
-		if (ints[0] > 2)
-			isapnp = ints[3];
-#endif
-	}
-
-	return 1;
-}
-
-__setup("sc1200wdt=", sc1200wdt_setup);
-#endif /* MODULE */
-
 
 module_init(sc1200wdt_init);
 module_exit(sc1200wdt_exit);
diff -Nru a/drivers/char/watchdog/wdt.c b/drivers/char/watchdog/wdt.c
--- a/drivers/char/watchdog/wdt.c	Fri Mar  5 17:41:42 2004
+++ b/drivers/char/watchdog/wdt.c	Fri Mar  5 17:41:42 2004
@@ -34,6 +34,7 @@
 #include <linux/config.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
@@ -70,43 +71,12 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
-#ifndef MODULE
-
-/**
- *	wdt_setup:
- *	@str: command line string
- *
- *	Setup options. The board isn't really probe-able so we have to
- *	get the user to tell us the configuration. Sane people build it
- *	modular but the others come here.
- */
-
-static int __init wdt_setup(char *str)
-{
-	int ints[4];
-
-	str = get_options (str, ARRAY_SIZE(ints), ints);
-
-	if (ints[0] > 0)
-	{
-		io = ints[1];
-		if(ints[0] > 1)
-			irq = ints[2];
-	}
-
-	return 1;
-}
-
-__setup("wdt=", wdt_setup);
-
-#endif /* !MODULE */
-
-MODULE_PARM(io, "i");
+module_param(io, int, 0);
 MODULE_PARM_DESC(io, "WDT io port (default=0x240)");
-MODULE_PARM(irq, "i");
+module_param(irq, int, 0);
 MODULE_PARM_DESC(irq, "WDT irq (default=11)");
 
 /*
