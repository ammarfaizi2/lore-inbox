Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbTBLLEJ>; Wed, 12 Feb 2003 06:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTBLK5d>; Wed, 12 Feb 2003 05:57:33 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:41609 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267089AbTBLK40>;
	Wed, 12 Feb 2003 05:56:26 -0500
Date: Wed, 12 Feb 2003 12:06:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: PowerMate driver update [11/14]
Message-ID: <20030212120605.J1563@ucw.cz>
References: <20030212115954.A1268@ucw.cz> <20030212120038.A1563@ucw.cz> <20030212120119.B1563@ucw.cz> <20030212120154.C1563@ucw.cz> <20030212120242.D1563@ucw.cz> <20030212120321.E1563@ucw.cz> <20030212120359.F1563@ucw.cz> <20030212120427.G1563@ucw.cz> <20030212120454.H1563@ucw.cz> <20030212120530.I1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120530.I1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:05:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1014, 2003-02-12 11:06:34+01:00, will@sowerbutts.com
  input: PowerMate driver update
  	- work around an undocumented firmware bug
  	- fix handling of LED brightness


 powermate.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/powermate.c b/drivers/usb/input/powermate.c
--- a/drivers/usb/input/powermate.c	Wed Feb 12 11:56:37 2003
+++ b/drivers/usb/input/powermate.c	Wed Feb 12 11:56:37 2003
@@ -1,9 +1,9 @@
 /*
  * A driver for the Griffin Technology, Inc. "PowerMate" USB controller dial.
  *
- * v1.0, (c)2002 William R Sowerbutts <will@sowerbutts.com>
+ * v1.1, (c)2002 William R Sowerbutts <will@sowerbutts.com>
  *
- * This device is a stainless steel knob which connects over USB. It can measure
+ * This device is a anodised aluminium knob which connects over USB. It can measure
  * clockwise and anticlockwise rotation. The dial also acts as a pushbutton with
  * a spring for automatic release. The base contains a pair of LEDs which illuminate
  * the translucent base. It rotates without limit and reports its relative rotation
@@ -15,13 +15,17 @@
  * speeds of up to 7 clicks either clockwise or anticlockwise between pollings from
  * the host. If it counts more than 7 clicks before it is polled, it will wrap back
  * to zero and start counting again. This was at quite high speed, however, almost
- * certainly faster than the human hand could turn it.
+ * certainly faster than the human hand could turn it. Griffin say that it loses a
+ * pulse or two on a direction change; the granularity is so fine that I never
+ * noticed this in practice.
  *
  * The device's microcontroller can be programmed to set the LED to either a constant
  * intensity, or to a rhythmic pulsing. Several patterns and speeds are available.
  *
  * Griffin were very happy to provide documentation and free hardware for development.
  *
+ * Some userspace tools are available on the web: http://sowerbutts.com/powermate/
+ *
  */
 
 #include <linux/kernel.h>
@@ -116,11 +120,7 @@
 	if (pm->config->status == -EINPROGRESS) 
 		return; /* an update is already in progress; it'll issue this update when it completes */
 
-	if (pm->requires_update & UPDATE_STATIC_BRIGHTNESS){
-		pm->configcr->wValue = cpu_to_le16( SET_STATIC_BRIGHTNESS );
-		pm->configcr->wIndex = cpu_to_le16( pm->static_brightness );
-		pm->requires_update &= ~UPDATE_STATIC_BRIGHTNESS;
-	}else if (pm->requires_update & UPDATE_PULSE_ASLEEP){
+	if (pm->requires_update & UPDATE_PULSE_ASLEEP){
 		pm->configcr->wValue = cpu_to_le16( SET_PULSE_ASLEEP );
 		pm->configcr->wIndex = cpu_to_le16( pm->pulse_asleep ? 1 : 0 );
 		pm->requires_update &= ~UPDATE_PULSE_ASLEEP;
@@ -160,6 +160,10 @@
 		pm->configcr->wValue = cpu_to_le16( (pm->pulse_table << 8) | SET_PULSE_MODE );
 		pm->configcr->wIndex = cpu_to_le16( (arg << 8) | op );
 		pm->requires_update &= ~UPDATE_PULSE_MODE;
+	}else if (pm->requires_update & UPDATE_STATIC_BRIGHTNESS){
+		pm->configcr->wValue = cpu_to_le16( SET_STATIC_BRIGHTNESS );
+		pm->configcr->wIndex = cpu_to_le16( pm->static_brightness );
+		pm->requires_update &= ~UPDATE_STATIC_BRIGHTNESS;
 	}else{
 		printk(KERN_ERR "powermate: unknown update required");
 		pm->requires_update = 0; /* fudge the bug */
@@ -220,11 +224,11 @@
 	}
 	if (pulse_asleep != pm->pulse_asleep){
 		pm->pulse_asleep = pulse_asleep;
-		pm->requires_update |= UPDATE_PULSE_ASLEEP;
+		pm->requires_update |= (UPDATE_PULSE_ASLEEP | UPDATE_STATIC_BRIGHTNESS);
 	}
 	if (pulse_awake != pm->pulse_awake){
 		pm->pulse_awake = pulse_awake;
-		pm->requires_update |= UPDATE_PULSE_AWAKE;
+		pm->requires_update |= (UPDATE_PULSE_AWAKE | UPDATE_STATIC_BRIGHTNESS);
 	}
 	if (pulse_speed != pm->pulse_speed || pulse_table != pm->pulse_table){
 		pm->pulse_speed = pulse_speed;
