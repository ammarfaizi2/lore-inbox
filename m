Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWCVMVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWCVMVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 07:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWCVMVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 07:21:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2974 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750853AbWCVMVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 07:21:21 -0500
Date: Wed, 22 Mar 2006 13:20:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: ucb1x00 audio & zaurus touchscreen
Message-ID: <20060322122052.GN14075@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

First, I'd like to ask: what is status of ucb1x00 audio in 2.6? I do
have .c file here, but do not have corresponding header files...

Then, I'd like to announce that I finally got touchscreen to somehow
work. Patch is very ugly and adds filtering into kernel (no-no), but
does the trick, and can even coexist with battery reading code. [Don't
bother commenting on style of this patch, it is for ilustration, I'd
not be crazy enough to try to push it.]
								Pavel

diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index 79fd062..31d3258 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -55,20 +55,34 @@ struct ucb1x00_ts {
 };
 
 static int adcsync;
+static int counter;
 
+static int minx, miny, minpress;
 static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
 {
 	struct input_dev *idev = ts->idev;
-	input_report_abs(idev, ABS_X, x);
-	input_report_abs(idev, ABS_Y, y);
-	input_report_abs(idev, ABS_PRESSURE, pressure);
+	if (x < minx) minx = x;
+	if (y < miny) miny = y;
+	if (pressure < minpress) minpress = pressure;
+
+	if (++counter < 3) {
+		return;
+	}
+	counter = 0;
+
+	input_report_abs(idev, ABS_X, minx);
+	input_report_abs(idev, ABS_Y, miny);
+	input_report_abs(idev, ABS_PRESSURE, minpress);
+        input_report_key(idev, BTN_TOUCH, 1);
 	input_sync(idev);
+	minx = 1000; miny = 1000; minpress = 1000;
 }
 
 static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
 {
 	struct input_dev *idev = ts->idev;
 	input_report_abs(idev, ABS_PRESSURE, 0);
+        input_report_key(idev, BTN_TOUCH, 0);
 	input_sync(idev);
 }
 
@@ -87,6 +101,7 @@ static inline void ucb1x00_ts_mode_int(s
  * Switch to pressure mode, and read pressure.  We don't need to wait
  * here, since both plates are being driven.
  */
+/* set_read_pressure() in sharp code */
 static inline unsigned int ucb1x00_ts_read_pressure(struct ucb1x00_ts *ts)
 {
 	if (machine_is_collie()) {
@@ -256,7 +271,9 @@ static int ucb1x00_thread(void *_ts)
 				valid = 0;
 			}
 
-			timeout = MAX_SCHEDULE_TIMEOUT;
+			/* With battery sensing on collie enabled, interrupts do not work quite well.
+			   This works around it */
+			timeout = HZ/10;
 		} else {
 			ucb1x00_disable(ts->ucb);
 
@@ -317,6 +334,10 @@ static int ucb1x00_ts_open(struct input_
 	ts->y_res = ucb1x00_ts_read_yres(ts);
 	ucb1x00_adc_disable(ts->ucb);
 
+	if (machine_is_collie()) {
+		ucb1x00_io_set_dir(ts->ucb, 0, COLLIE_TC35143_GPIO_TBL_CHK);
+	}
+
 	ts->rtask = kthread_run(ucb1x00_thread, ts, "ktsd");
 	if (!IS_ERR(ts->rtask)) {
 		ret = 0;
@@ -397,6 +418,10 @@ static int ucb1x00_ts_add(struct ucb1x00
 	__set_bit(ABS_X, ts->idev->absbit);
 	__set_bit(ABS_Y, ts->idev->absbit);
 	__set_bit(ABS_PRESSURE, ts->idev->absbit);
+        input_set_abs_params(ts->idev, ABS_X, 0, 450, 0, 0);
+        input_set_abs_params(ts->idev, ABS_Y, 200, 800, 0, 0);
+        input_set_abs_params(ts->idev, ABS_PRESSURE, 400, 800, 0, 0);
+
 
 	input_register_device(ts->idev);
 

-- 
Picture of sleeping (Linux) penguin wanted...
