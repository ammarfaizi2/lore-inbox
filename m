Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbTGLWAH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268597AbTGLWAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:00:07 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:12512 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S268589AbTGLV77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 17:59:59 -0400
Message-ID: <3F108837.8060604@portrix.net>
Date: Sun, 13 Jul 2003 00:14:15 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Replace mod_inc_use_count with __module_get for watchdog drivers
Content-Type: multipart/mixed;
 boundary="------------040900000801080102020501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040900000801080102020501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I found this comment in mixcomwd.c and proceeded accordingly.
This prevents the watchdog drivers from being unloaded after initialized and 
gets rid of the warnings. This doesn't just remove any occurance of 
MOD_INC_USE_COUNT, but replaces it with __module_get().
Is this correct?

Jan

/** fops_get() code via open() has already done
* a try_module_get() so it is safe to do the
* __module_get().
*/

--
Linux rubicon 2.5.75-mm1-jd10 #1 SMP Sat Jul 12 19:40:28 CEST 2003 i686

--------------040900000801080102020501
Content-Type: text/plain;
 name="watchdogs_replace_mod_inc_with_mod_get"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="watchdogs_replace_mod_inc_with_mod_get"

The watchdog drivers use MOD_INC_USE_COUNT for not being unloaded accidently.
Therefore this call cannot be removed totally, but instead I replaced it 
with __module_get(THIS_MODULE) as other watchdog drivers seem to do it.

Jan

diff -urN -X exclude linux-bk/drivers/char/watchdog/acquirewdt.c 2.5.75-bk1/drivers/char/watchdog/acquirewdt.c
--- linux-bk/drivers/char/watchdog/acquirewdt.c	Mon May  5 01:53:32 2003
+++ 2.5.75-bk1/drivers/char/watchdog/acquirewdt.c	Sat Jul 12 10:51:30 2003
@@ -143,7 +143,7 @@
 			return -EBUSY;
 		}
 		if (nowayout)
-			MOD_INC_USE_COUNT;
+			__module_get(THIS_MODULE);
 
 		/* Activate */
 		acq_is_open=1;
diff -urN -X exclude linux-bk/drivers/char/watchdog/ib700wdt.c 2.5.75-bk1/drivers/char/watchdog/ib700wdt.c
--- linux-bk/drivers/char/watchdog/ib700wdt.c	Mon May  5 01:53:41 2003
+++ 2.5.75-bk1/drivers/char/watchdog/ib700wdt.c	Sat Jul 12 10:51:46 2003
@@ -230,7 +230,7 @@
 			return -EBUSY;
 		}
 		if (nowayout)
-			MOD_INC_USE_COUNT;
+			__module_get(THIS_MODULE);
 
 		/* Activate */
 		ibwdt_is_open = 1;
diff -urN -X exclude linux-bk/drivers/char/watchdog/indydog.c 2.5.75-bk1/drivers/char/watchdog/indydog.c
--- linux-bk/drivers/char/watchdog/indydog.c	Mon May  5 01:53:41 2003
+++ 2.5.75-bk1/drivers/char/watchdog/indydog.c	Sat Jul 12 10:52:03 2003
@@ -54,7 +54,7 @@
 		return -EBUSY;
 
 	if (nowayout)
-		MOD_INC_USE_COUNT;
+		__module_get(THIS_MODULE);
 
 	/*
 	 *	Activate timer
diff -urN -X exclude linux-bk/drivers/char/watchdog/machzwd.c 2.5.75-bk1/drivers/char/watchdog/machzwd.c
--- linux-bk/drivers/char/watchdog/machzwd.c	Mon May  5 01:53:03 2003
+++ 2.5.75-bk1/drivers/char/watchdog/machzwd.c	Sat Jul 12 10:52:22 2003
@@ -392,7 +392,7 @@
 			}
 
 			if (nowayout)
-				MOD_INC_USE_COUNT;
+				__module_get(THIS_MODULE);
 
 			zf_is_open = 1;
 
diff -urN -X exclude linux-bk/drivers/char/watchdog/pcwd.c 2.5.75-bk1/drivers/char/watchdog/pcwd.c
--- linux-bk/drivers/char/watchdog/pcwd.c	Fri May 30 20:29:33 2003
+++ 2.5.75-bk1/drivers/char/watchdog/pcwd.c	Sat Jul 12 10:52:37 2003
@@ -431,7 +431,7 @@
 			atomic_inc( &open_allowed );
 			return -EBUSY;
 		}
-		MOD_INC_USE_COUNT;
+		__module_get(THIS_MODULE);
 		/*  Enable the port  */
 		if (revision == PCWD_REVISION_C) {
 			spin_lock(&io_lock);
diff -urN -X exclude linux-bk/drivers/char/watchdog/sbc60xxwdt.c 2.5.75-bk1/drivers/char/watchdog/sbc60xxwdt.c
--- linux-bk/drivers/char/watchdog/sbc60xxwdt.c	Mon May  5 01:53:35 2003
+++ 2.5.75-bk1/drivers/char/watchdog/sbc60xxwdt.c	Sat Jul 12 10:52:53 2003
@@ -207,9 +207,8 @@
 			/* Just in case we're already talking to someone... */
 			if(wdt_is_open)
 				return -EBUSY;
-			if (nowayout) {
-				MOD_INC_USE_COUNT;
-			}
+			if (nowayout) 
+				__module_get(THIS_MODULE);
 			/* Good, fire up the show */
 			wdt_is_open = 1;
 			wdt_startup();
diff -urN -X exclude linux-bk/drivers/char/watchdog/sc520_wdt.c 2.5.75-bk1/drivers/char/watchdog/sc520_wdt.c
--- linux-bk/drivers/char/watchdog/sc520_wdt.c	Mon May  5 01:53:14 2003
+++ 2.5.75-bk1/drivers/char/watchdog/sc520_wdt.c	Sat Jul 12 10:53:12 2003
@@ -231,7 +231,7 @@
 			/* Good, fire up the show */
 			wdt_startup();
 			if (nowayout)
-				MOD_INC_USE_COUNT;
+				__module_get(THIS_MODULE);
 
 			return 0;
 		default:
diff -urN -X exclude linux-bk/drivers/char/watchdog/shwdt.c 2.5.75-bk1/drivers/char/watchdog/shwdt.c
--- linux-bk/drivers/char/watchdog/shwdt.c	Mon May  5 01:53:09 2003
+++ 2.5.75-bk1/drivers/char/watchdog/shwdt.c	Sat Jul 12 10:53:28 2003
@@ -189,9 +189,8 @@
 			if (test_and_set_bit(0, &sh_is_open))
 				return -EBUSY;
 
-			if (nowayout) {
-				MOD_INC_USE_COUNT;
-			}
+			if (nowayout) 
+				__module_get(THIS_MODULE);
 
 			sh_wdt_start();
 
diff -urN -X exclude linux-bk/drivers/char/watchdog/softdog.c 2.5.75-bk1/drivers/char/watchdog/softdog.c
--- linux-bk/drivers/char/watchdog/softdog.c	Mon May  5 01:53:13 2003
+++ 2.5.75-bk1/drivers/char/watchdog/softdog.c	Sat Jul 12 10:53:42 2003
@@ -104,9 +104,8 @@
 {
 	if(test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
-	if (nowayout) {
-		MOD_INC_USE_COUNT;
-	}
+	if (nowayout) 
+		__module_get(THIS_MODULE);
 	/*
 	 *	Activate timer
 	 */
diff -urN -X exclude linux-bk/drivers/char/watchdog/wdt977.c 2.5.75-bk1/drivers/char/watchdog/wdt977.c
--- linux-bk/drivers/char/watchdog/wdt977.c	Mon May  5 01:53:37 2003
+++ 2.5.75-bk1/drivers/char/watchdog/wdt977.c	Sat Jul 12 10:53:55 2003
@@ -99,7 +99,7 @@
 
 	if (nowayout)
 	{
-		MOD_INC_USE_COUNT;
+		__module_get(THIS_MODULE);
 
 		/* do not permit disabling the watchdog by writing 0 to reg. 0xF2 */
 		if (!timeoutM) timeoutM = DEFAULT_TIMEOUT;
diff -urN -X exclude linux-bk/drivers/char/watchdog/wdt_pci.c 2.5.75-bk1/drivers/char/watchdog/wdt_pci.c
--- linux-bk/drivers/char/watchdog/wdt_pci.c	Mon May  5 01:53:32 2003
+++ 2.5.75-bk1/drivers/char/watchdog/wdt_pci.c	Sat Jul 12 10:54:10 2003
@@ -367,7 +367,7 @@
 				return -EBUSY;
 
 			if (nowayout) {
-				MOD_INC_USE_COUNT;
+				__module_get(THIS_MODULE);
 			}
 			/*
 			 *	Activate 

--------------040900000801080102020501--

