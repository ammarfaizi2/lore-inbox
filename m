Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVBPFqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVBPFqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 00:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVBPFqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 00:46:12 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:8597 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261994AbVBPFqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 00:46:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RCF/RFT] Fix race timer race in gameport-based joystick drivers
Date: Wed, 16 Feb 2005 00:45:59 -0500
User-Agent: KMail/1.7.2
Cc: InputML <linux-input@atrey.karlin.mff.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>
References: <200502150042.32564.dtor_core@ameritech.net> <d120d500050215065115706773@mail.gmail.com> <20050215150606.GA8560@ucw.cz>
In-Reply-To: <20050215150606.GA8560@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502160046.00311.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow missed sidewinder driver...

======================================================================

Input: fix timer handling race in sidewinder joystick driver by
       switching to gameport's polling facilities.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

===== drivers/input/joystick/sidewinder.c 1.19 vs edited =====
--- 1.19/drivers/input/joystick/sidewinder.c	2005-02-10 19:00:00 -05:00
+++ edited/drivers/input/joystick/sidewinder.c	2005-02-14 21:36:26 -05:00
@@ -58,7 +58,6 @@
 #define SW_BAD		2	/* Number of packet read errors to switch off 3d Pro optimization */
 #define SW_OK		64	/* Number of packet read successes to switch optimization back on */
 #define SW_LENGTH	512	/* Max number of bits in a packet */
-#define SW_REFRESH	HZ/50	/* Time to wait between updates of joystick data [20 ms] */
 
 #ifdef SW_DEBUG
 #define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ": " format "\n" , ## arg)
@@ -115,7 +114,6 @@
 
 struct sw {
 	struct gameport *gameport;
-	struct timer_list timer;
 	struct input_dev dev[4];
 	char name[64];
 	char phys[4][32];
@@ -127,7 +125,6 @@
 	int ok;
 	int reads;
 	int bads;
-	int used;
 };
 
 /*
@@ -496,22 +493,20 @@
 	return -1;
 }
 
-static void sw_timer(unsigned long private)
+static void sw_poll(struct gameport *gameport)
 {
-	struct sw *sw = (void *) private;
+	struct sw *sw = gameport_get_drvdata(gameport);
 
 	sw->reads++;
 	if (sw_read(sw))
 		sw->bads++;
-	mod_timer(&sw->timer, jiffies + SW_REFRESH);
 }
 
 static int sw_open(struct input_dev *dev)
 {
 	struct sw *sw = dev->private;
 
-	if (!sw->used++)
-		mod_timer(&sw->timer, jiffies + SW_REFRESH);
+	gameport_start_polling(sw->gameport);
 	return 0;
 }
 
@@ -519,8 +514,7 @@
 {
 	struct sw *sw = dev->private;
 
-	if (!--sw->used)
-		del_timer(&sw->timer);
+	gameport_stop_polling(sw->gameport);
 }
 
 /*
@@ -606,9 +600,6 @@
 	}
 
 	sw->gameport = gameport;
-	init_timer(&sw->timer);
-	sw->timer.data = (long) sw;
-	sw->timer.function = sw_timer;
 
 	gameport_set_drvdata(gameport, sw);
 
@@ -725,6 +716,9 @@
 	sw_print_packet("ID", j * 3, idbuf, 3);
 	sw_print_packet("Data", i * m, buf, m);
 #endif
+
+	gameport_set_poll_handler(gameport, sw_poll);
+	gameport_set_poll_interval(gameport, 20);
 
 	k = i;
 	l = j;
