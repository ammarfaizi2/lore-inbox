Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWGEEdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWGEEdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 00:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWGEEds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 00:33:48 -0400
Received: from mail.gmx.net ([213.165.64.21]:47283 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932452AbWGEEds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 00:33:48 -0400
X-Authenticated: #420190
Message-ID: <44AB40FD.10006@gmx.net>
Date: Wed, 05 Jul 2006 06:33:01 +0200
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] drivers/usb/input/ati_remote.c: autorepeat fix
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When HZ is set to 250 (new default) or 100, the time span during which repeated
events from the device are ignored could be too small due to ms->jiffies rounding. 
This causes the auto repeat to kick in early making it impossible for the user 
to generate individual press/release events. Increate the timeout to compensate.

Signed-off-by: marko.macek@gmx.net	

---

--- linux-2.6.17.orig/drivers/usb/input/ati_remote.c	2006-06-29 21:18:15.000000000 +0200
+++ linux-2.6.17/drivers/usb/input/ati_remote.c	2006-07-02 21:36:14.000000000 +0200
@@ -155,9 +155,8 @@
  * events. The hardware generates 5 events for the first keypress
  * and we have to take this into account for an accurate repeat
  * behaviour.
- * (HZ / 20) == 50 ms and works well for me.
  */
-#define FILTER_TIME (HZ / 20)
+#define FILTER_TIME 60 /* msec */
 
 struct ati_remote {
 	struct input_dev *idev;
@@ -470,7 +469,7 @@
 		/* Filter duplicate events which happen "too close" together. */
 		if ((ati_remote->old_data[0] == data[1]) &&
 			(ati_remote->old_data[1] == data[2]) &&
-			time_before(jiffies, ati_remote->old_jiffies + FILTER_TIME)) {
+			time_before(jiffies, ati_remote->old_jiffies + msecs_to_jiffies(FILTER_TIME))) {
 			ati_remote->repeat_count++;
 		} else {
 			ati_remote->repeat_count = 0;


