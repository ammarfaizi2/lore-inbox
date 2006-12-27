Return-Path: <linux-kernel-owner+w=401wt.eu-S932947AbWL0OeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947AbWL0OeT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 09:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932945AbWL0OeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 09:34:19 -0500
Received: from rubidium.solidboot.com ([81.22.244.175]:52094 "EHLO
	mail.solidboot.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932947AbWL0OeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 09:34:18 -0500
X-Greylist: delayed 1186 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Dec 2006 09:34:18 EST
Date: Wed, 27 Dec 2006 16:14:30 +0200
From: Imre Deak <imre.deak@solidboot.com>
To: David Brownell <david-b@pacbell.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, nicolas.ferre@rfo.atmel.com,
       linux-kernel@vger.kernel.org, tony@atomide.com
Subject: Re: [patch 2.6.20-rc1 6/6] input: ads7846 directly senses PENUP state
Message-ID: <20061227141430.GB9009@mammoth.research.nokia.com>
References: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <d120d5000612221235g3df0167bx9b1e6664dadf138d@mail.gmail.com> <200612221240.20768.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <200612221240.20768.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 22, 2006 at 12:40:20PM -0800, David Brownell wrote:
> On Friday 22 December 2006 12:35 pm, Dmitry Torokhov wrote:
> > On 12/22/06, David Brownell <david-b@pacbell.net> wrote:
> > >
> > > +static void ads7846_report_pen_state(struct ads7846 *ts, int down)
> > > +{
> > > +       struct input_dev        *input_dev = ts->input;
> > > +
> > > +       input_report_key(input_dev, BTN_TOUCH, down);
> > > +       if (!down)
> > > +               input_report_abs(input_dev, ABS_PRESSURE, 0);
> > > +#ifdef VERBOSE
> > > +       pr_debug("%s: %s\n", ts->spi->dev.bus_id, down ? "DOWN" : "UP");
> > > +#endif
> > > +}
> > > +
> > > +static void ads7846_report_pen_position(struct ads7846 *ts, int x, int y,
> > > +                                       int pressure)
> > > +{
> > > +       struct input_dev        *input_dev = ts->input;
> > > +
> > > +       input_report_abs(input_dev, ABS_X, x);
> > > +       input_report_abs(input_dev, ABS_Y, y);
> > > +       input_report_abs(input_dev, ABS_PRESSURE, pressure);
> > > +
> > > +#ifdef VERBOSE
> > > +       pr_debug("%s: %d/%d/%d\n", ts->spi->dev.bus_id, x, y, pressure);
> > > +#endif
> > > +}
> > > +
> > > +static void ads7846_sync_events(struct ads7846 *ts)
> > > +{
> > > +       struct input_dev        *input_dev = ts->input;
> > > +
> > > +       input_sync(input_dev);
> > > +}
> > 
> > I think these helpers just obfuscate the code, just call
> > input_report_*() and input_sync() drectly like you used to do.
> 
> Fair enough, I had a similar thought.  Imre, could you do that update?

Yes, the patch is against the OMAP tree.

--Imre

--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Input-ads7846-call-input-layer-functions-directly.txt"

>From 34c26895c2cfb2bcc1a1d7994ad695e26b8eaeef Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Wed, 27 Dec 2006 16:07:32 +0200
Subject: [PATCH] Input: ads7846: call input layer functions directly

This reverts an earlier abstraction of these calls, which only
obfuscated the code.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/input/touchscreen/ads7846.c |   56 +++++++++++-----------------------
 1 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index a47c95e..d6251ef 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -375,39 +375,6 @@ static DEVICE_ATTR(disable, 0664, ads7846_disable_show, ads7846_disable_store);
 
 /*--------------------------------------------------------------------------*/
 
-static void ads7846_report_pen_state(struct ads7846 *ts, int down)
-{
-	struct input_dev	*input_dev = ts->input;
-
-	input_report_key(input_dev, BTN_TOUCH, down);
-	if (!down)
-		input_report_abs(input_dev, ABS_PRESSURE, 0);
-#ifdef VERBOSE
-	pr_debug("%s: %s\n", ts->spi->dev.bus_id, down ? "DOWN" : "UP");
-#endif
-}
-
-static void ads7846_report_pen_position(struct ads7846 *ts, int x, int y,
-					int pressure)
-{
-	struct input_dev	*input_dev = ts->input;
-
-	input_report_abs(input_dev, ABS_X, x);
-	input_report_abs(input_dev, ABS_Y, y);
-	input_report_abs(input_dev, ABS_PRESSURE, pressure);
-
-#ifdef VERBOSE
-	pr_debug("%s: %d/%d/%d\n", ts->spi->dev.bus_id, x, y, pressure);
-#endif
-}
-
-static void ads7846_sync_events(struct ads7846 *ts)
-{
-	struct input_dev	*input_dev = ts->input;
-
-	input_sync(input_dev);
-}
-
 /*
  * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
  * to retrieve touchscreen status.
@@ -466,11 +433,20 @@ static void ads7846_rx(void *ads)
 	 */
 	if (Rt) {
 		if (!ts->pendown) {
-			ads7846_report_pen_state(ts, 1);
+			input_report_key(ts->input, BTN_TOUCH, 1);
 			ts->pendown = 1;
+#ifdef VERBOSE
+			dev_dbg(&ts->spi->dev, "DOWN\n");
+#endif
 		}
-		ads7846_report_pen_position(ts, x, y, Rt);
-		ads7846_sync_events(ts);
+		input_report_abs(ts->input, ABS_X, x);
+		input_report_abs(ts->input, ABS_Y, y);
+		input_report_abs(ts->input, ABS_PRESSURE, Rt);
+
+		input_sync(ts->input);
+#ifdef VERBOSE
+		dev_dbg(&ts->spi->dev, "%4d/%4d/%4d\n", x, y, Rt);
+#endif
 	}
 
 	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD), HRTIMER_REL);
@@ -568,9 +544,13 @@ static int ads7846_timer(struct hrtimer *handle)
 	if (unlikely(!ts->get_pendown_state() ||
 		     device_suspended(&ts->spi->dev))) {
 		if (ts->pendown) {
-			ads7846_report_pen_state(ts, 0);
-			ads7846_sync_events(ts);
+			input_report_key(ts->input, BTN_TOUCH, 0);
+			input_report_abs(ts->input, ABS_PRESSURE, 0);
+			input_sync(ts->input);
 			ts->pendown = 0;
+#ifdef VERBOSE
+			dev_dbg(&ts->spi->dev, "UP\n");
+#endif
 		}
 
 		/* measurment cycle ended */
-- 
1.4.4.2


--MfFXiAuoTsnnDAfZ--
