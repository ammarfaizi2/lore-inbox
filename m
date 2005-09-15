Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbVIOHdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbVIOHdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbVIOHdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:33:05 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:31335 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030461AbVIOHcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:32:41 -0400
Message-Id: <20050915070304.210476000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 17/28] Input: convert ucb1x00-ts to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-ucb1x00-ts.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: convert ucb1x00-ts to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/mfd/ucb1x00-ts.c |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

Index: work/drivers/mfd/ucb1x00-ts.c
===================================================================
--- work.orig/drivers/mfd/ucb1x00-ts.c
+++ work/drivers/mfd/ucb1x00-ts.c
@@ -40,7 +40,7 @@
 
 
 struct ucb1x00_ts {
-	struct input_dev	idev;
+	struct input_dev	*idev;
 	struct ucb1x00		*ucb;
 
 	wait_queue_head_t	irq_wait;
@@ -56,16 +56,16 @@ static int adcsync;
 
 static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
 {
-	input_report_abs(&ts->idev, ABS_X, x);
-	input_report_abs(&ts->idev, ABS_Y, y);
-	input_report_abs(&ts->idev, ABS_PRESSURE, pressure);
-	input_sync(&ts->idev);
+	input_report_abs(ts->idev, ABS_X, x);
+	input_report_abs(ts->idev, ABS_Y, y);
+	input_report_abs(ts->idev, ABS_PRESSURE, pressure);
+	input_sync(ts->idev);
 }
 
 static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
 {
-	input_report_abs(&ts->idev, ABS_PRESSURE, 0);
-	input_sync(&ts->idev);
+	input_report_abs(ts->idev, ABS_PRESSURE, 0);
+	input_sync(ts->idev);
 }
 
 /*
@@ -341,26 +341,30 @@ static int ucb1x00_ts_add(struct ucb1x00
 {
 	struct ucb1x00_ts *ts;
 
-	ts = kmalloc(sizeof(struct ucb1x00_ts), GFP_KERNEL);
+	ts = kzalloc(sizeof(struct ucb1x00_ts), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
 
-	memset(ts, 0, sizeof(struct ucb1x00_ts));
+	ts->idev = input_allocate_device();
+	if (!ts->idev) {
+		kfree(ts);
+		return -ENOMEM;
+	}
 
 	ts->ucb = dev->ucb;
 	ts->adcsync = adcsync ? UCB_SYNC : UCB_NOSYNC;
 
-	ts->idev.name       = "Touchscreen panel";
-	ts->idev.id.product = ts->ucb->id;
-	ts->idev.open       = ucb1x00_ts_open;
-	ts->idev.close      = ucb1x00_ts_close;
-
-	__set_bit(EV_ABS, ts->idev.evbit);
-	__set_bit(ABS_X, ts->idev.absbit);
-	__set_bit(ABS_Y, ts->idev.absbit);
-	__set_bit(ABS_PRESSURE, ts->idev.absbit);
+	ts->idev->name       = "Touchscreen panel";
+	ts->idev->id.product = ts->ucb->id;
+	ts->idev->open       = ucb1x00_ts_open;
+	ts->idev->close      = ucb1x00_ts_close;
+
+	__set_bit(EV_ABS, ts->idev->evbit);
+	__set_bit(ABS_X, ts->idev->absbit);
+	__set_bit(ABS_Y, ts->idev->absbit);
+	__set_bit(ABS_PRESSURE, ts->idev->absbit);
 
-	input_register_device(&ts->idev);
+	input_register_device(ts->idev);
 
 	dev->priv = ts;
 
@@ -370,7 +374,8 @@ static int ucb1x00_ts_add(struct ucb1x00
 static void ucb1x00_ts_remove(struct ucb1x00_dev *dev)
 {
 	struct ucb1x00_ts *ts = dev->priv;
-	input_unregister_device(&ts->idev);
+
+	input_unregister_device(ts->idev);
 	kfree(ts);
 }
 

