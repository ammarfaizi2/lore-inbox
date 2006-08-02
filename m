Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWHBDBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWHBDBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWHBDBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:01:16 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:34567 "EHLO
	asav14.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751089AbWHBDBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:01:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KANKxz0SBUg
From: Dmitry Torokhov <dtor@insightbb.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ucb1x00-ts: handle errors from input_register_device()
Date: Tue, 1 Aug 2006 23:01:11 -0400
User-Agent: KMail/1.9.3
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, rmk@arm.linux.org.uk,
       Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608012301.13155.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not tested this (no hardware)

-- 
Dmitry

Subject: ucb1x00-ts - handle errors from input_register_device()

ucb1x00-ts: handle errors from input_register_device()

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/mfd/ucb1x00-ts.c |   49 ++++++++++++++++++++++++++++-------------------
 1 files changed, 30 insertions(+), 19 deletions(-)

Index: work/drivers/mfd/ucb1x00-ts.c
===================================================================
--- work.orig/drivers/mfd/ucb1x00-ts.c
+++ work/drivers/mfd/ucb1x00-ts.c
@@ -58,6 +58,7 @@ static int adcsync;
 static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
 {
 	struct input_dev *idev = ts->idev;
+
 	input_report_abs(idev, ABS_X, x);
 	input_report_abs(idev, ABS_Y, y);
 	input_report_abs(idev, ABS_PRESSURE, pressure);
@@ -67,6 +68,7 @@ static inline void ucb1x00_ts_evt_add(st
 static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
 {
 	struct input_dev *idev = ts->idev;
+
 	input_report_abs(idev, ABS_PRESSURE, 0);
 	input_sync(idev);
 }
@@ -189,6 +191,7 @@ static inline unsigned int ucb1x00_ts_re
 static inline int ucb1x00_ts_pen_down(struct ucb1x00_ts *ts)
 {
 	unsigned int val = ucb1x00_reg_read(ts->ucb, UCB_TS_CR);
+
 	if (machine_is_collie())
 		return (!(val & (UCB_TS_CR_TSPX_LOW)));
 	else
@@ -291,6 +294,7 @@ static int ucb1x00_thread(void *_ts)
 static void ucb1x00_ts_irq(int idx, void *id)
 {
 	struct ucb1x00_ts *ts = id;
+
 	ucb1x00_disable_irq(ts->ucb, UCB_IRQ_TSPX, UCB_FALLING);
 	wake_up(&ts->irq_wait);
 }
@@ -372,36 +376,43 @@ static int ucb1x00_ts_resume(struct ucb1
 static int ucb1x00_ts_add(struct ucb1x00_dev *dev)
 {
 	struct ucb1x00_ts *ts;
+	struct input_dev *idev;
+	int err;
 
 	ts = kzalloc(sizeof(struct ucb1x00_ts), GFP_KERNEL);
-	if (!ts)
-		return -ENOMEM;
-
-	ts->idev = input_allocate_device();
-	if (!ts->idev) {
-		kfree(ts);
-		return -ENOMEM;
+	idev = input_allocate_device();
+	if (!ts || !idev) {
+		err = -ENOMEM;
+		goto fail;
 	}
 
 	ts->ucb = dev->ucb;
+	ts->idev = idev;
 	ts->adcsync = adcsync ? UCB_SYNC : UCB_NOSYNC;
 
-	ts->idev->private = ts;
-	ts->idev->name       = "Touchscreen panel";
-	ts->idev->id.product = ts->ucb->id;
-	ts->idev->open       = ucb1x00_ts_open;
-	ts->idev->close      = ucb1x00_ts_close;
-
-	__set_bit(EV_ABS, ts->idev->evbit);
-	__set_bit(ABS_X, ts->idev->absbit);
-	__set_bit(ABS_Y, ts->idev->absbit);
-	__set_bit(ABS_PRESSURE, ts->idev->absbit);
-
-	input_register_device(ts->idev);
+	idev->private    = ts;
+	idev->name       = "Touchscreen panel";
+	idev->id.product = ts->ucb->id;
+	idev->open       = ucb1x00_ts_open;
+	idev->close      = ucb1x00_ts_close;
+
+	__set_bit(EV_ABS, idev->evbit);
+	__set_bit(ABS_X, idev->absbit);
+	__set_bit(ABS_Y, idev->absbit);
+	__set_bit(ABS_PRESSURE, idev->absbit);
+
+	err = input_register_device(idev);
+	if (err)
+		goto fail;
 
 	dev->priv = ts;
 
 	return 0;
+
+ fail:
+	input_free_device(idev);
+	kfree(ts);
+	return err;
 }
 
 static void ucb1x00_ts_remove(struct ucb1x00_dev *dev)

