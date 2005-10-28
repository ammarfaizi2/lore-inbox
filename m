Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbVJ1Gfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVJ1Gfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVJ1Gbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:46058 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965147AbVJ1GbZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:25 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Input: convert ucb1x00-ts to dynamic input_dev allocation
In-Reply-To: <11304810243087@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:24 -0700
Message-Id: <1130481024363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: convert ucb1x00-ts to dynamic input_dev allocation

Input: convert ucb1x00-ts to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 61ae45fa4a9d1637a430965ee3743c1c42f07268
tree 95ecb6c67d8ebcbab9f2f8113472d7a6b0483c9d
parent b991fee057c50e098677f57b49c848f81b697b14
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:48 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:04 -0700

 drivers/mfd/ucb1x00-ts.c |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index a260f83..585cded 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
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
 

