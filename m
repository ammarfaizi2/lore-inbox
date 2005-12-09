Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVLIUcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVLIUcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 15:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVLIUcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 15:32:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18600 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932449AbVLIUct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 15:32:49 -0500
Date: Fri, 09 Dec 2005 15:32:46 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] input: fix ucb1x00-ts breakage after conversion to dynamic
 input_dev allocation
X-X-Sender: nico@localhost.localdomain
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: Russell King <rmk@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0512091520000.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bd622663192e8ebebb27dc1d9397f352a82d2495 commit broke the UCB1x00 
touchscreen driver since the idev structure was assumed to be into the 
ts structure, simply casting the former to the later in a couple places.

This patch fixes those, and also cache the idev pointer between multiple 
calls to input_report_abs() to avoid growing the compiled code 
needlessly.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index a984c0e..e0794c2 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -59,16 +59,18 @@ static int adcsync;
 
 static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
 {
-	input_report_abs(ts->idev, ABS_X, x);
-	input_report_abs(ts->idev, ABS_Y, y);
-	input_report_abs(ts->idev, ABS_PRESSURE, pressure);
-	input_sync(ts->idev);
+	struct input_dev *idev = ts->idev;
+	input_report_abs(idev, ABS_X, x);
+	input_report_abs(idev, ABS_Y, y);
+	input_report_abs(idev, ABS_PRESSURE, pressure);
+	input_sync(idev);
 }
 
 static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
 {
-	input_report_abs(ts->idev, ABS_PRESSURE, 0);
-	input_sync(ts->idev);
+	struct input_dev *idev = ts->idev;
+	input_report_abs(idev, ABS_PRESSURE, 0);
+	input_sync(idev);
 }
 
 /*
@@ -297,7 +299,7 @@ static void ucb1x00_ts_irq(int idx, void
 
 static int ucb1x00_ts_open(struct input_dev *idev)
 {
-	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
+	struct ucb1x00_ts *ts = idev->private;
 	int ret = 0;
 
 	BUG_ON(ts->rtask);
@@ -334,7 +336,7 @@ static int ucb1x00_ts_open(struct input_
  */
 static void ucb1x00_ts_close(struct input_dev *idev)
 {
-	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
+	struct ucb1x00_ts *ts = idev->private;
 
 	if (ts->rtask)
 		kthread_stop(ts->rtask);
@@ -386,6 +388,7 @@ static int ucb1x00_ts_add(struct ucb1x00
 	ts->ucb = dev->ucb;
 	ts->adcsync = adcsync ? UCB_SYNC : UCB_NOSYNC;
 
+	ts->idev->private = ts;
 	ts->idev->name       = "Touchscreen panel";
 	ts->idev->id.product = ts->ucb->id;
 	ts->idev->open       = ucb1x00_ts_open;
