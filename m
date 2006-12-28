Return-Path: <linux-kernel-owner+w=401wt.eu-S965023AbWL1WiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWL1WiA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWL1WiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:38:00 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:34464 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965023AbWL1Wh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:37:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Ew22N/RvDXaZFKtGxyIkDTt8g1KLDwdIa+89jwFZnWuz+bBsDXa/+o3Om1nNJPKHG7wVVjfQiDrmicfIRohybtzpaGsPeW5uWPG7MfvgmoSlZkOf/86CU1F8b45WpAUaU2pDz/SJ5ildW13Bvd7VdzRQmKrv+UMRaznUeYrXmNY=  ;
X-YMail-OSG: NHSAlpkVM1l.IjrIRhGuAwTwQ8MONsS.QGI.LTAFwAT68hoxarhLJOiV8lhVnsIa2n2hdsYu2If97BTzYdyRxv3cBEGdcNFi.RY.Z78NX5Chthaby3hfhvO88uoq4DROKsax8dtXhb0poRs-
From: David Brownell <david-b@pacbell.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Imre Deak <imre.deak@solidboot.com>
Subject: Re: [patch 2.6.20-rc1 6/6] input: ads7846 directly senses PENUP state
Date: Thu, 28 Dec 2006 14:37:56 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, nicolas.ferre@rfo.atmel.com,
       tony@atomide.com
References: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200612221240.20768.david-b@pacbell.net> <20061227141430.GB9009@mammoth.research.nokia.com>
In-Reply-To: <20061227141430.GB9009@mammoth.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612281437.56888.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I think these helpers just obfuscate the code, just call
> > > input_report_*() and input_sync() drectly like you used to do.
> > 
> > Fair enough, I had a similar thought.  Imre, could you do that update?
> 
> Yes, the patch is against the OMAP tree.

Thanks ... still hoping that the OMAP tree will just be able
to pull down the kernel.org version of this driver soon!!

OK, here's an updated patch 6/6 that merges Imre's update.

Dmitry, that makes six patches you should have ... I updated
the hwmon patch (#3), and now this one (#6); #4 and #5 will
thus apply with some offsets.

If you don't have other issues, I'd like to see these get into
the 2.6.20 release ... except for that version of the hwmon patch,
everything has been in use for some time through the OMAP tree,
which AFAICT is right now the main user of this driver.  (That'll
change a bit once Atmel's patches merge.)

- Dave

==========	CUT HERE
From: imre.deak@solidboot.com <imre.deak@solidboot.com>
Date: Wed Jul 5 19:18:32 2006 +0300

Input: ads7846: detect pen up from GPIO state

We can't depend on the pressure value to determine when the pen was
lifted, so use the GPIO line state instead.  This also helps with
chips (like ads7843) that don't have pressure sensors.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: at91/drivers/input/touchscreen/ads7846.c
===================================================================
--- at91.orig/drivers/input/touchscreen/ads7846.c	2006-12-22 12:13:27.000000000 -0800
+++ at91/drivers/input/touchscreen/ads7846.c	2006-12-28 14:19:51.000000000 -0800
@@ -441,11 +441,8 @@ static struct attribute_group ads7845_at
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
@@ -459,7 +456,7 @@ static void ads7846_rx(void *ads)
 	if (x == MAX_12BIT)
 		x = 0;
 
-	if (likely(x && z1 && !device_suspended(&ts->spi->dev))) {
+	if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
 		Rt -= z1;
@@ -475,52 +472,42 @@ static void ads7846_rx(void *ads)
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
-	}
-
-#ifdef	VERBOSE
-	if (Rt || ts->pendown)
-		pr_debug("%s: %d/%d/%d%s\n", ts->spi->dev.bus_id,
-			x, y, Rt, Rt ? "" : " UP");
+		if (!ts->pendown) {
+			input_report_key(ts->input, BTN_TOUCH, 1);
+			ts->pendown = 1;
+#ifdef VERBOSE
+			dev_dbg(&ts->spi->dev, "DOWN\n");
 #endif
+		}
+		input_report_abs(ts->input, ABS_X, x);
+		input_report_abs(ts->input, ABS_Y, y);
+		input_report_abs(ts->input, ABS_PRESSURE, Rt);
+
+		input_sync(ts->input);
+#ifdef VERBOSE
+		dev_dbg(&ts->spi->dev, "%4d/%4d/%4d\n", x, y, Rt);
+#endif
+	}
 
-	spin_lock_irqsave(&ts->lock, flags);
-
-	ts->pendown = (Rt != 0);
 	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD), HRTIMER_REL);
-
-	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
 static int ads7846_debounce(void *ads, int data_idx, int *val)
@@ -616,14 +603,24 @@ static int ads7846_timer(struct hrtimer 
 
 	spin_lock_irq(&ts->lock);
 
-	if (unlikely(ts->msg_idx && !ts->pendown)) {
+	if (unlikely(!ts->get_pendown_state()
+			|| device_suspended(&ts->spi->dev))) {
+		if (ts->pendown) {
+			input_report_key(ts->input, BTN_TOUCH, 0);
+			input_report_abs(ts->input, ABS_PRESSURE, 0);
+			input_sync(ts->input);
+			ts->pendown = 0;
+#ifdef VERBOSE
+			dev_dbg(&ts->spi->dev, "UP\n");
+#endif
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
