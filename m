Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263988AbTCUW2M>; Fri, 21 Mar 2003 17:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263985AbTCUW1v>; Fri, 21 Mar 2003 17:27:51 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39811
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263678AbTCUSLI>; Fri, 21 Mar 2003 13:11:08 -0500
Date: Fri, 21 Mar 2003 19:26:23 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211926.h2LJQNBg025759@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix all the other watchdogs Dave's changes broke the same
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/ib700wdt.c linux-2.5.65-ac2/drivers/char/watchdog/ib700wdt.c
--- linux-2.5.65/drivers/char/watchdog/ib700wdt.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/ib700wdt.c	2003-03-06 17:19:52.000000000 +0000
@@ -228,6 +228,8 @@
 			spin_unlock(&ibwdt_lock);
 			return -EBUSY;
 		}
+		if (nowayout)
+			MOD_INC_USE_COUNT;
 
 		/* Activate */
 		ibwdt_is_open = 1;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/indydog.c linux-2.5.65-ac2/drivers/char/watchdog/indydog.c
--- linux-2.5.65/drivers/char/watchdog/indydog.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/indydog.c	2003-02-14 18:03:27.000000000 +0000
@@ -53,6 +53,9 @@
 	if( test_and_set_bit(0,&indydog_alive) )
 		return -EBUSY;
 
+	if (nowayout)
+		MOD_INC_USE_COUNT;
+
 	/*
 	 *	Activate timer
 	 */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/machzwd.c linux-2.5.65-ac2/drivers/char/watchdog/machzwd.c
--- linux-2.5.65/drivers/char/watchdog/machzwd.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/machzwd.c	2003-02-14 18:07:43.000000000 +0000
@@ -390,6 +390,9 @@
 				return -EBUSY;
 			}
 
+			if (nowayout)
+				MOD_INC_USE_COUNT;
+
 			zf_is_open = 1;
 
 			spin_unlock(&zf_lock);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/mixcomwd.c linux-2.5.65-ac2/drivers/char/watchdog/mixcomwd.c
--- linux-2.5.65/drivers/char/watchdog/mixcomwd.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/mixcomwd.c	2003-02-14 18:03:27.000000000 +0000
@@ -93,7 +93,9 @@
 	}
 	mixcomwd_ping();
 	
-	if (!nowayout) {
+	if (nowayout) {
+		MOD_INC_USE_COUNT;
+	} else {
 		if(mixcomwd_timer_alive) {
 			del_timer(&mixcomwd_timer);
 			mixcomwd_timer_alive=0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/pcwd.c linux-2.5.65-ac2/drivers/char/watchdog/pcwd.c
--- linux-2.5.65/drivers/char/watchdog/pcwd.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/pcwd.c	2003-02-14 18:07:43.000000000 +0000
@@ -430,7 +430,7 @@
 			atomic_inc( &open_allowed );
 			return -EBUSY;
 		}
-
+		MOD_INC_USE_COUNT;
 		/*  Enable the port  */
 		if (revision == PCWD_REVISION_C) {
 			spin_lock(&io_lock);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/sbc60xxwdt.c linux-2.5.65-ac2/drivers/char/watchdog/sbc60xxwdt.c
--- linux-2.5.65/drivers/char/watchdog/sbc60xxwdt.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/sbc60xxwdt.c	2003-03-06 17:20:38.000000000 +0000
@@ -206,7 +206,9 @@
 			/* Just in case we're already talking to someone... */
 			if(wdt_is_open)
 				return -EBUSY;
-
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			/* Good, fire up the show */
 			wdt_is_open = 1;
 			wdt_startup();
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/sc520_wdt.c linux-2.5.65-ac2/drivers/char/watchdog/sc520_wdt.c
--- linux-2.5.65/drivers/char/watchdog/sc520_wdt.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/sc520_wdt.c	2003-03-06 17:21:14.000000000 +0000
@@ -229,6 +229,8 @@
 				return -EBUSY;
 			/* Good, fire up the show */
 			wdt_startup();
+			if (nowayout)
+				MOD_INC_USE_COUNT;
 
 			return 0;
 		default:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/shwdt.c linux-2.5.65-ac2/drivers/char/watchdog/shwdt.c
--- linux-2.5.65/drivers/char/watchdog/shwdt.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/shwdt.c	2003-03-06 17:21:14.000000000 +0000
@@ -189,6 +189,10 @@
 			if (test_and_set_bit(0, &sh_is_open))
 				return -EBUSY;
 
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
+
 			sh_wdt_start();
 
 			break;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/softdog.c linux-2.5.65-ac2/drivers/char/watchdog/softdog.c
--- linux-2.5.65/drivers/char/watchdog/softdog.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/softdog.c	2003-02-14 18:03:27.000000000 +0000
@@ -103,7 +103,9 @@
 {
 	if(test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
-
+	if (nowayout) {
+		MOD_INC_USE_COUNT;
+	}
 	/*
 	 *	Activate timer
 	 */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/wdt977.c linux-2.5.65-ac2/drivers/char/watchdog/wdt977.c
--- linux-2.5.65/drivers/char/watchdog/wdt977.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/wdt977.c	2003-02-19 15:26:28.000000000 +0000
@@ -99,6 +99,8 @@
 
 	if (nowayout)
 	{
+		MOD_INC_USE_COUNT;
+
 		/* do not permit disabling the watchdog by writing 0 to reg. 0xF2 */
 		if (!timeoutM) timeoutM = DEFAULT_TIMEOUT;
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/wdt_pci.c linux-2.5.65-ac2/drivers/char/watchdog/wdt_pci.c
--- linux-2.5.65/drivers/char/watchdog/wdt_pci.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/wdt_pci.c	2003-03-06 17:21:14.000000000 +0000
@@ -365,6 +365,9 @@
 			if (down_trylock(&open_sem))
 				return -EBUSY;
 
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			/*
 			 *	Activate 
 			 */
