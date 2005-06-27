Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVF0KRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVF0KRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 06:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVF0KRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 06:17:06 -0400
Received: from relay.rost.ru ([80.254.111.11]:62150 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S261421AbVF0KQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 06:16:11 -0400
Subject: [PATCH] 2.6.12-mm2, consolidate CONFIG_WATCHDOG_NOWAYOUT handling
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 27 Jun 2005 14:16:08 +0400
Message-Id: <1119867368540@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

attached trivial patch removes #ifdef CONFIG_WATCHDOG_NOWAYOUT mess
duplicated in almost every watchdog driver and replaces it with common
define in linux/watchdog.h.

Please take a look.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 include/linux/watchdog.h             |   10 ++++++++++
 drivers/char/ipmi/ipmi_watchdog.c    |    6 +-----
 drivers/char/watchdog/acquirewdt.c   |    7 +------
 drivers/char/watchdog/advantechwdt.c |    7 +------
 drivers/char/watchdog/alim1535_wdt.c |    7 +------
 drivers/char/watchdog/alim7101_wdt.c |    7 +------
 drivers/char/watchdog/eurotechwdt.c  |    7 +------
 drivers/char/watchdog/i8xx_tco.c     |    7 +------
 drivers/char/watchdog/ib700wdt.c     |    7 +------
 drivers/char/watchdog/indydog.c      |    7 +------
 drivers/char/watchdog/ixp2000_wdt.c  |    6 +-----
 drivers/char/watchdog/ixp4xx_wdt.c   |    6 +-----
 drivers/char/watchdog/machzwd.c      |    7 +------
 drivers/char/watchdog/mixcomwd.c     |    7 +------
 drivers/char/watchdog/pcwd.c         |    7 +------
 drivers/char/watchdog/pcwd_pci.c     |    7 +------
 drivers/char/watchdog/pcwd_usb.c     |    7 +------
 drivers/char/watchdog/s3c2410_wdt.c  |    7 +------
 drivers/char/watchdog/sa1100_wdt.c   |    6 +-----
 drivers/char/watchdog/sbc60xxwdt.c   |    7 +------
 drivers/char/watchdog/sc1200wdt.c    |    7 +------
 drivers/char/watchdog/sc520_wdt.c    |    7 +------
 drivers/char/watchdog/scx200_wdt.c   |    6 +-----
 drivers/char/watchdog/shwdt.c        |    6 +-----
 drivers/char/watchdog/softdog.c      |    7 +------
 drivers/char/watchdog/w83627hf_wdt.c |    7 +------
 drivers/char/watchdog/w83877f_wdt.c  |    7 +------
 drivers/char/watchdog/wafer5823wdt.c |    7 +------
 drivers/char/watchdog/wdt.c          |    7 +------
 drivers/char/watchdog/wdt977.c       |    7 +------
 drivers/char/watchdog/wdt_pci.c      |    7 +------
 drivers/s390/char/vmwatchdog.c       |    6 +-----
 32 files changed, 41 insertions(+), 179 deletions(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/include/linux/watchdog.h linux-2.6.12-mm2/include/linux/watchdog.h
--- linux-2.6.12-mm2.vanilla/include/linux/watchdog.h	2005-06-27 13:33:16.000000000 +0400
+++ linux-2.6.12-mm2/include/linux/watchdog.h	2005-06-27 13:35:00.000000000 +0400
@@ -47,4 +47,14 @@ struct watchdog_info {
 #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
 #define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
 
+#ifdef __KERNEL__
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+#define WATCHDOG_NOWAYOUT	1
+#else
+#define WATCHDOG_NOWAYOUT	0
+#endif
+
+#endif	/* __KERNEL__ */
+
 #endif  /* ifndef _LINUX_WATCHDOG_H */
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/ipmi/ipmi_watchdog.c linux-2.6.12-mm2/drivers/char/ipmi/ipmi_watchdog.c
--- linux-2.6.12-mm2.vanilla/drivers/char/ipmi/ipmi_watchdog.c	2005-06-27 13:30:45.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/ipmi/ipmi_watchdog.c	2005-06-27 13:34:59.000000000 +0400
@@ -131,11 +131,7 @@
 #define	WDIOC_GET_PRETIMEOUT     _IOW(WATCHDOG_IOCTL_BASE, 22, int)
 #endif
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout;
-#endif
+static int nowayout = WATCHDOG_NOWAYOUT;
 
 static ipmi_user_t watchdog_user = NULL;
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/acquirewdt.c linux-2.6.12-mm2/drivers/char/watchdog/acquirewdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/acquirewdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/acquirewdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -82,12 +82,7 @@ static int wdt_start = 0x443;
 module_param(wdt_start, int, 0);
 MODULE_PARM_DESC(wdt_start, "Acquire WDT 'start' io port (default 0x443)");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/advantechwdt.c linux-2.6.12-mm2/drivers/char/watchdog/advantechwdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/advantechwdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/advantechwdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -73,12 +73,7 @@ static int timeout = WATCHDOG_TIMEOUT;	/
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. 1<= timeout <=63, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/alim1535_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/alim1535_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/alim1535_wdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/alim1535_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -38,12 +38,7 @@ static int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (0<timeout<18000, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/alim7101_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/alim7101_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/alim7101_wdt.c	2005-06-27 13:30:44.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/alim7101_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -75,12 +75,7 @@ static unsigned long wdt_is_open;
 static char wdt_expect_close;
 static struct pci_dev *alim7101_pmu;
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/eurotechwdt.c linux-2.6.12-mm2/drivers/char/watchdog/eurotechwdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/eurotechwdt.c	2005-06-27 13:30:42.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/eurotechwdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -72,12 +72,7 @@ static char *ev = "int";
 
 #define WDT_TIMEOUT		60                /* 1 minute */
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/i8xx_tco.c linux-2.6.12-mm2/drivers/char/watchdog/i8xx_tco.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/i8xx_tco.c	2005-06-27 13:30:42.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/i8xx_tco.c	2005-06-27 13:35:00.000000000 +0400
@@ -105,12 +105,7 @@ static int heartbeat = WATCHDOG_HEARTBEA
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (2<heartbeat<39, default=" __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/ib700wdt.c linux-2.6.12-mm2/drivers/char/watchdog/ib700wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/ib700wdt.c	2005-06-27 13:30:44.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/ib700wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -117,12 +117,7 @@ static int wd_times[] = {
 
 static int wd_margin = WD_TIMO;
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/indydog.c linux-2.6.12-mm2/drivers/char/watchdog/indydog.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/indydog.c	2005-06-27 13:30:44.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/indydog.c	2005-06-27 13:35:00.000000000 +0400
@@ -29,14 +29,9 @@
 #define PFX "indydog: "
 static int indydog_alive;
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
 #define WATCHDOG_TIMEOUT 30		/* 30 sec default timeout */
 
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/ixp2000_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/ixp2000_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/ixp2000_wdt.c	2005-06-27 13:30:42.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/ixp2000_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -30,11 +30,7 @@
 #include <asm/hardware.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
+static int nowayout = WATCHDOG_NOWAYOUT;
 static unsigned int heartbeat = 60;	/* (secs) Default is 1 minute */
 static unsigned long wdt_status;
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/ixp4xx_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/ixp4xx_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/ixp4xx_wdt.c	2005-06-27 13:30:44.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/ixp4xx_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -27,11 +27,7 @@
 #include <asm/hardware.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
+static int nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = 60;	/* (secs) Default is 1 minute */
 static unsigned long wdt_status;
 static unsigned long boot_status;
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/machzwd.c linux-2.6.12-mm2/drivers/char/watchdog/machzwd.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/machzwd.c	2005-06-27 13:30:42.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/machzwd.c	2005-06-27 13:35:00.000000000 +0400
@@ -94,12 +94,7 @@ MODULE_DESCRIPTION("MachZ ZF-Logic Watch
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/mixcomwd.c linux-2.6.12-mm2/drivers/char/watchdog/mixcomwd.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/mixcomwd.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/mixcomwd.c	2005-06-27 13:35:00.000000000 +0400
@@ -62,12 +62,7 @@ static int mixcomwd_timer_alive;
 static DEFINE_TIMER(mixcomwd_timer, NULL, 0, 0);
 static char expect_close;
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/pcwd.c linux-2.6.12-mm2/drivers/char/watchdog/pcwd.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/pcwd.c	2005-06-27 13:30:42.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/pcwd.c	2005-06-27 13:35:00.000000000 +0400
@@ -146,12 +146,7 @@ static int heartbeat = WATCHDOG_HEARTBEA
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (2<=heartbeat<=7200, default=" __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/pcwd_pci.c linux-2.6.12-mm2/drivers/char/watchdog/pcwd_pci.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/pcwd_pci.c	2005-06-27 13:30:42.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/pcwd_pci.c	2005-06-27 13:35:00.000000000 +0400
@@ -103,12 +103,7 @@ static int heartbeat = WATCHDOG_HEARTBEA
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (0<heartbeat<65536, default=" __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/pcwd_usb.c linux-2.6.12-mm2/drivers/char/watchdog/pcwd_usb.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/pcwd_usb.c	2005-06-27 13:30:42.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/pcwd_usb.c	2005-06-27 13:35:00.000000000 +0400
@@ -79,12 +79,7 @@ static int heartbeat = WATCHDOG_HEARTBEA
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (0<heartbeat<65536, default=" __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/s3c2410_wdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/s3c2410_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -63,12 +63,7 @@
 #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
 #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 static int tmr_margin	= CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME;
 static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
 static int soft_noboot	= 0;
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/sa1100_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/sa1100_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/sa1100_wdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/sa1100_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -42,11 +42,7 @@ static unsigned long sa1100wdt_users;
 static int expect_close;
 static int pre_margin;
 static int boot_status;
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
+static int nowayout = WATCHDOG_NOWAYOUT;
 
 /*
  *	Allow only one person to hold it open
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/sbc60xxwdt.c linux-2.6.12-mm2/drivers/char/watchdog/sbc60xxwdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/sbc60xxwdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/sbc60xxwdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -98,12 +98,7 @@ static int timeout = WATCHDOG_TIMEOUT;	/
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (1<=timeout<=3600, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/sc1200wdt.c linux-2.6.12-mm2/drivers/char/watchdog/sc1200wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/sc1200wdt.c	2005-06-27 13:30:42.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/sc1200wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -91,12 +91,7 @@ MODULE_PARM_DESC(io, "io port");
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "range is 0-255 minutes, default is 1");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/sc520_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/sc520_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/sc520_wdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/sc520_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -94,12 +94,7 @@ static int timeout = WATCHDOG_TIMEOUT;	/
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (1<=timeout<=3600, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/scx200_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/scx200_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/scx200_wdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/scx200_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -39,15 +39,11 @@ MODULE_DESCRIPTION("NatSemi SCx200 Watch
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-#define CONFIG_WATCHDOG_NOWAYOUT 0
-#endif
-
 static int margin = 60;		/* in seconds */
 module_param(margin, int, 0);
 MODULE_PARM_DESC(margin, "Watchdog margin in seconds");
 
-static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/shwdt.c linux-2.6.12-mm2/drivers/char/watchdog/shwdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/shwdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/shwdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -75,11 +75,7 @@ static unsigned long next_heartbeat;
 #define WATCHDOG_HEARTBEAT 30			/* 30 sec default heartbeat */
 static int heartbeat = WATCHDOG_HEARTBEAT;	/* in seconds */
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
+static int nowayout = WATCHDOG_NOWAYOUT;
 
 /**
  * 	sh_wdt_start - Start the Watchdog
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/softdog.c linux-2.6.12-mm2/drivers/char/watchdog/softdog.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/softdog.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/softdog.c	2005-06-27 13:35:00.000000000 +0400
@@ -56,12 +56,7 @@ static int soft_margin = TIMER_MARGIN;	/
 module_param(soft_margin, int, 0);
 MODULE_PARM_DESC(soft_margin, "Watchdog soft_margin in seconds. (0<soft_margin<65536, default=" __MODULE_STRING(TIMER_MARGIN) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/w83627hf_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/w83627hf_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/w83627hf_wdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/w83627hf_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -54,12 +54,7 @@ static int timeout = WATCHDOG_TIMEOUT;	/
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. 1<= timeout <=63, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/w83877f_wdt.c linux-2.6.12-mm2/drivers/char/watchdog/w83877f_wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/w83877f_wdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/w83877f_wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -85,12 +85,7 @@ module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (1<=timeout<=3600, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/wafer5823wdt.c linux-2.6.12-mm2/drivers/char/watchdog/wafer5823wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/wafer5823wdt.c	2005-06-27 13:30:44.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/wafer5823wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -63,12 +63,7 @@ static int timeout = WD_TIMO;  /* in sec
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. 1<= timeout <=255, default=" __MODULE_STRING(WD_TIMO) ".");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/wdt977.c linux-2.6.12-mm2/drivers/char/watchdog/wdt977.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/wdt977.c	2005-06-27 13:30:44.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/wdt977.c	2005-06-27 13:35:00.000000000 +0400
@@ -53,12 +53,7 @@ MODULE_PARM_DESC(timeout,"Watchdog timeo
 module_param(testmode, int, 0);
 MODULE_PARM_DESC(testmode,"Watchdog testmode (1 = no reboot), default=0");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/wdt.c linux-2.6.12-mm2/drivers/char/watchdog/wdt.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/wdt.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/wdt.c	2005-06-27 13:35:00.000000000 +0400
@@ -63,12 +63,7 @@ static int wd_heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (0<heartbeat<65536, default=" __MODULE_STRING(WD_TIMO) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/char/watchdog/wdt_pci.c linux-2.6.12-mm2/drivers/char/watchdog/wdt_pci.c
--- linux-2.6.12-mm2.vanilla/drivers/char/watchdog/wdt_pci.c	2005-06-27 13:30:43.000000000 +0400
+++ linux-2.6.12-mm2/drivers/char/watchdog/wdt_pci.c	2005-06-27 13:35:00.000000000 +0400
@@ -89,12 +89,7 @@ static int wd_heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (0<heartbeat<65536, default=" __MODULE_STRING(WD_TIMO) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
+static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
diff -urdpNX /usr/share/dontdiff linux-2.6.12-mm2.vanilla/drivers/s390/char/vmwatchdog.c linux-2.6.12-mm2/drivers/s390/char/vmwatchdog.c
--- linux-2.6.12-mm2.vanilla/drivers/s390/char/vmwatchdog.c	2005-06-27 13:29:58.000000000 +0400
+++ linux-2.6.12-mm2/drivers/s390/char/vmwatchdog.c	2005-06-27 13:35:00.000000000 +0400
@@ -23,11 +23,7 @@
 static char vmwdt_cmd[MAX_CMDLEN] = "IPL";
 static int vmwdt_conceal;
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int vmwdt_nowayout = 1;
-#else
-static int vmwdt_nowayout = 0;
-#endif
+static int vmwdt_nowayout = WATCHDOG_NOWAYOUT;
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Arnd Bergmann <arndb@de.ibm.com>");

