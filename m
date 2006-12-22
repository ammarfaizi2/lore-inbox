Return-Path: <linux-kernel-owner+w=401wt.eu-S1752327AbWLVTZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbWLVTZk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbWLVTZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:25:40 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:42709 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752165AbWLVTZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:25:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=IiFCLWX/qWFQAnds/WFtrKFhrvpNlqFdR46BODt52noXdSEUIpih9l2T9zv8T3Hgh+2bNYyQ/4usmofGncg7IAWwuJtslaMeqkdj/tvyd0x7OGEQ0kric+SsxqhXs5RVFNuVkGDcR3DWjvdP/S+0j5Uu4kgt4tNmjUsZjCkvrE4=  ;
X-YMail-OSG: 9VPNuRUVM1kdOkSoyp6Rb71JbA3kjQfc0in49qEQyhN0nXBZD1GjGxSDHGsBWJ79t00aeatzsdP5zHZlPdoW43xt7LOmmT.M9whmt5qyFvDKu_NCfw4Q0Gc5Y8somNV36ZJCQNVbVNwheyc-
Date: Fri, 22 Dec 2006 11:25:36 -0800
From: David Brownell <david-b@pacbell.net>
To: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: [patch 2.6.20-rc1 6/6] input: ads7846 directly senses PENUP state
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: imre.deak@solidboot.com <imre.deak@solidboot.com>
Date:  Wed Jul 5 19:18:32 2006 +0300

Input: ads7846: detect pen up from GPIO state

We can't depend on the pressure value to determine when the pen was
lifted, so use the GPIO line state instead.  This also helps with
chips (like ads7843) that don't have pressure sensors.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- osk.orig/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:46.000000000 -0800
+++ osk/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:47.000000000 -0800
@@ -430,6 +430,39 @@ static struct attribute_group ads7845_at
 
 /*--------------------------------------------------------------------------*/
 
+static void ads7846_report_pen_state(struct ads7846 *ts, int down)
+{
+	struct input_dev	*input_dev = ts->input;
+
+	input_report_key(input_dev, BTN_TOUCH, down);
+	if (!down)
+		input_report_abs(input_dev, ABS_PRESSURE, 0);
+#ifdef VERBOSE
+	pr_debug("%s: %s\n", ts->spi->dev.bus_id, down ? "DOWN" : "UP");
+#endif
+}
+
+static void ads7846_report_pen_position(struct ads7846 *ts, int x, int y,
+					int pressure)
+{
+	struct input_dev	*input_dev = ts->input;
+
+	input_report_abs(input_dev, ABS_X, x);
+	input_report_abs(input_dev, ABS_Y, y);
+	input_report_abs(input_dev, ABS_PRESSURE, pressure);
+
+#ifdef VERBOSE
+	pr_debug("%s: %d/%d/%d\n", ts->spi->dev.bus_id, x, y, pressure);
+#endif
+}
+
+static void ads7846_sync_events(struct ads7846 *ts)
+{
+	struct input_dev	*input_dev = ts->input;
+
+	input_sync(input_dev);
+}
+
 /*
  * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
  * to retrieve touchscreen status.
@@ -441,11 +474,8 @@ static struct attribute_group ads7845_at
 static void ads7846_rx(void *ads)
 {
 	struct ads7846		*ts = ads;
-	struct input_dev	*input_dev = ts->input;
 	unsigned		Rt;
-	unsigned		sync = 0;
 	u16			x, y, z1, z2;
-	unsigned long		flags;
 
 	/* ads7846_rx_val() did in-place conversion (including byteswap) from
 	 * on-the-wire format as part of debouncing to get stable readings.
@@ -459,7 +489,7 @@ static void ads7846_rx(void *ads)
 	if (x == MAX_12BIT)
 		x = 0;
 
-	if (likely(x && z1 && !device_suspended(&ts->spi->dev))) {
+	if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
 		Rt -= z1;
@@ -475,52 +505,33 @@ static void ads7846_rx(void *ads)
 	 * once more the measurement
 	 */
 	if (ts->tc.ignore || Rt > ts->pressure_max) {
+#ifdef VERBOSE
+		pr_debug("%s: ignored %d pressure %d\n",
+			ts->spi->dev.bus_id, ts->tc.ignore, Rt);
+#endif
 		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
 			      HRTIMER_REL);
 		return;
 	}
 
-	/* NOTE:  "pendown" is inferred from pressure; we don't rely on
-	 * being able to check nPENIRQ status, or "friendly" trigger modes
-	 * (both-edges is much better than just-falling or low-level).
-	 *
-	 * REVISIT:  some boards may require reading nPENIRQ; it's
-	 * needed on 7843.  and 7845 reads pressure differently...
+	/* NOTE: We can't rely on the pressure to determine the pen down
+	 * state, even this controller has a pressure sensor.  The pressure
+	 * value can fluctuate for quite a while after lifting the pen and
+	 * in some cases may not even settle at the expected value.
 	 *
-	 * REVISIT:  the touchscreen might not be connected; this code
-	 * won't notice that, even if nPENIRQ never fires ...
+	 * The only safe way to check for the pen up condition is in the
+	 * timer by reading the pen signal state (it's a GPIO _and_ IRQ).
 	 */
-	if (!ts->pendown && Rt != 0) {
-		input_report_key(input_dev, BTN_TOUCH, 1);
-		sync = 1;
-	} else if (ts->pendown && Rt == 0) {
-		input_report_key(input_dev, BTN_TOUCH, 0);
-		sync = 1;
-	}
-
 	if (Rt) {
-		input_report_abs(input_dev, ABS_X, x);
-		input_report_abs(input_dev, ABS_Y, y);
-		sync = 1;
-	}
-
-	if (sync) {
-		input_report_abs(input_dev, ABS_PRESSURE, Rt);
-		input_sync(input_dev);
+		if (!ts->pendown) {
+			ads7846_report_pen_state(ts, 1);
+			ts->pendown = 1;
+		}
+		ads7846_report_pen_position(ts, x, y, Rt);
+		ads7846_sync_events(ts);
 	}
 
-#ifdef	VERBOSE
-	if (Rt || ts->pendown)
-		pr_debug("%s: %d/%d/%d%s\n", ts->spi->dev.bus_id,
-			x, y, Rt, Rt ? "" : " UP");
-#endif
-
-	spin_lock_irqsave(&ts->lock, flags);
-
-	ts->pendown = (Rt != 0);
 	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD), HRTIMER_REL);
-
-	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
 static int ads7846_debounce(void *ads, int data_idx, int *val)
@@ -616,14 +627,20 @@ static int ads7846_timer(struct hrtimer 
 
 	spin_lock_irq(&ts->lock);
 
-	if (unlikely(ts->msg_idx && !ts->pendown)) {
+	if (unlikely(!ts->get_pendown_state()
+			|| device_suspended(&ts->spi->dev))) {
+		if (ts->pendown) {
+			ads7846_report_pen_state(ts, 0);
+			ads7846_sync_events(ts);
+			ts->pendown = 0;
+		}
+
 		/* measurement cycle ended */
 		if (!device_suspended(&ts->spi->dev)) {
 			ts->irq_disabled = 0;
 			enable_irq(ts->spi->irq);
 		}
 		ts->pending = 0;
-		ts->msg_idx = 0;
 	} else {
 		/* pen is still down, continue with the measurement */
 		ts->msg_idx = 0;
