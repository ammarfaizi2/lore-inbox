Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUCZD3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263910AbUCZD3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:29:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:60296 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263784AbUCZD3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:29:23 -0500
Subject: [PATCH] adbhid preempt/smp races
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080271623.1198.16.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 14:27:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a few races in the LED code of the adbhid driver
that would affect SMP or preempt.

Please apply,
Ben.

diff -urN linux-2.5/drivers/macintosh/adbhid.c linuxppc-2.5-benh/drivers/macintosh/adbhid.c
--- linux-2.5/drivers/macintosh/adbhid.c	2004-03-01 18:11:44.000000000 +1100
+++ linuxppc-2.5-benh/drivers/macintosh/adbhid.c	2004-03-25 16:16:56.000000000 +1100
@@ -107,7 +107,6 @@
 static void adbhid_probe(void);
 
 static void adbhid_input_keycode(int, int, int, struct pt_regs *);
-static void leds_done(struct adb_request *);
 
 static void init_trackpad(int id);
 static void init_trackball(int id);
@@ -446,24 +445,54 @@
 
 static struct adb_request led_request;
 static int leds_pending[16];
+static int leds_req_pending;
 static int pending_devs[16];
 static int pending_led_start=0;
 static int pending_led_end=0;
+static spinlock_t leds_lock  = SPIN_LOCK_UNLOCKED;
+
+static void leds_done(struct adb_request *req)
+{
+	int leds, device;
+	unsigned long flags;
+
+	spin_lock_irqsave(&leds_lock, flags);
+
+	if (pending_led_start != pending_led_end) {
+		device = pending_devs[pending_led_start];
+		leds = leds_pending[device] & 0xff;
+		leds_pending[device] = 0;
+		pending_led_start++;
+		pending_led_start = (pending_led_start < 16) ? pending_led_start : 0;
+	} else
+		leds_req_pending = 0;
+
+	spin_unlock_irqrestore(&leds_lock, flags);
+	if (leds_req_pending)
+		adb_request(&led_request, leds_done, 0, 3,
+			    ADB_WRITEREG(device, KEYB_LEDREG), 0xff, ~leds);
+}
 
 static void real_leds(unsigned char leds, int device)
 {
-    if (led_request.complete) {
-	adb_request(&led_request, leds_done, 0, 3,
-		    ADB_WRITEREG(device, KEYB_LEDREG), 0xff,
-		    ~leds);
-    } else {
-	if (!(leds_pending[device] & 0x100)) {
-	    pending_devs[pending_led_end] = device;
-	    pending_led_end++;
-	    pending_led_end = (pending_led_end < 16) ? pending_led_end : 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&leds_lock, flags);
+	if (!leds_req_pending) {
+		leds_req_pending = 1;
+		spin_unlock_irqrestore(&leds_lock, flags);	       
+		adb_request(&led_request, leds_done, 0, 3,
+			    ADB_WRITEREG(device, KEYB_LEDREG), 0xff, ~leds);
+		return;
+	} else {
+		if (!(leds_pending[device] & 0x100)) {
+			pending_devs[pending_led_end] = device;
+			pending_led_end++;
+			pending_led_end = (pending_led_end < 16) ? pending_led_end : 0;
+		}
+		leds_pending[device] = leds | 0x100;
 	}
-	leds_pending[device] = leds | 0x100;
-    }
+	spin_unlock_irqrestore(&leds_lock, flags);	       
 }
 
 /*
@@ -487,21 +516,6 @@
 	return -1;
 }
 
-static void leds_done(struct adb_request *req)
-{
-    int leds,device;
-
-    if (pending_led_start != pending_led_end) {
-	device = pending_devs[pending_led_start];
-	leds = leds_pending[device] & 0xff;
-	leds_pending[device] = 0;
-	pending_led_start++;
-	pending_led_start = (pending_led_start < 16) ? pending_led_start : 0;
-	real_leds(leds,device);
-    }
-
-}
-
 static int
 adb_message_handler(struct notifier_block *this, unsigned long code, void *x)
 {
@@ -518,7 +532,7 @@
 		}
 
 		/* Stop pending led requests */
-		while(!led_request.complete)
+		while(leds_req_pending)
 			adb_poll();
 		break;
 


