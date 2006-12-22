Return-Path: <linux-kernel-owner+w=401wt.eu-S1752301AbWLVTYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbWLVTYB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbWLVTYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:24:01 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:48928 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752301AbWLVTYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:24:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=1pRQLj9ffNgip60eIAZP7SevAO6h0dy5QTuQoDFx2CI4xzRpUsMRvliV4/Sc3bTy2Vhb/BY3ZM6YD2Knbtk0+wGOX9xukSdLaEHIZLkxownA7MwWICCJecpuVVdivRLXrd9y2b76JiPF1LRcm+83Y2WKKmVpbp8KU13P4A/E7hE=  ;
X-YMail-OSG: OOZ.678VM1kXFr9vxa4QHLoFvAoa2lHPDud_N_CLXgsVHd9nGrapazbWGj6LadkTuTprwtCwmjxH1or5Z1CldOUrR93rQcwFi1p27AKMLiz3QPHwJc5G4WnnanwTzqCDkpPRUmLpcFQfODw-
Date: Fri, 22 Dec 2006 11:23:58 -0800
From: David Brownell <david-b@pacbell.net>
To: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: [patch 2.6.20-rc1 4/6] input: ads7836 users hrtimer
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061222192358.6A3E71F0D22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: imre.deak@solidboot.com <imre.deak@solidboot.com>
Date: Mon Jul 3 21:34:16 2006 +0300

Input: ads7846: switch to hrtimer

Use hrtimer instead of the normal timer, since it provides better
sampling resolution. This will:

 - avoid a problem where we have a 1 jiffy poll period and
   dynamic tick on
 - utilize high resolution HW clocks when they are added to
   the hrtimer framework

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- osk.orig/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:44.000000000 -0800
+++ osk/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:45.000000000 -0800
@@ -55,7 +55,8 @@
  * files.
  */
 
-#define	TS_POLL_PERIOD	msecs_to_jiffies(10)
+#define TS_POLL_DELAY	(1 * 1000000)	/* ns delay before the first sample */
+#define TS_POLL_PERIOD	(5 * 1000000)	/* ns delay between samples */
 
 /* this driver doesn't aim at the peak continuous sample rate */
 #define	SAMPLE_BITS	(8 /*cmd*/ + 16 /*sample*/ + 2 /* before, after */)
@@ -101,7 +102,7 @@ struct ads7846 {
 	u16			debounce_rep;
 
 	spinlock_t		lock;
-	struct timer_list	timer;		/* P: lock */
+	struct hrtimer		timer;
 	unsigned		pendown:1;	/* P: lock */
 	unsigned		pending:1;	/* P: lock */
 // FIXME remove "irq_disabled"
@@ -470,10 +471,12 @@ static void ads7846_rx(void *ads)
 		Rt = 0;
 
 	/* Sample found inconsistent by debouncing or pressure is beyond
-	* the maximum. Don't report it to user space, repeat at least
-	* once more the measurement */
+	 * the maximum. Don't report it to user space, repeat at least
+	 * once more the measurement
+	 */
 	if (ts->tc.ignore || Rt > ts->pressure_max) {
-		mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
+		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
+			      HRTIMER_REL);
 		return;
 	}
 
@@ -515,7 +518,7 @@ static void ads7846_rx(void *ads)
 	spin_lock_irqsave(&ts->lock, flags);
 
 	ts->pendown = (Rt != 0);
-	mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
+	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD), HRTIMER_REL);
 
 	spin_unlock_irqrestore(&ts->lock, flags);
 }
@@ -606,9 +609,9 @@ static void ads7846_rx_val(void *ads)
 				status);
 }
 
-static void ads7846_timer(unsigned long handle)
+static int ads7846_timer(struct hrtimer *handle)
 {
-	struct ads7846	*ts = (void *)handle;
+	struct ads7846	*ts = container_of(handle, struct ads7846, timer);
 	int		status = 0;
 
 	spin_lock_irq(&ts->lock);
@@ -630,6 +633,7 @@ static void ads7846_timer(unsigned long 
 	}
 
 	spin_unlock_irq(&ts->lock);
+	return HRTIMER_NORESTART;
 }
 
 static irqreturn_t ads7846_irq(int irq, void *handle)
@@ -648,7 +652,8 @@ static irqreturn_t ads7846_irq(int irq, 
 			ts->irq_disabled = 1;
 			disable_irq(ts->spi->irq);
 			ts->pending = 1;
-			mod_timer(&ts->timer, jiffies);
+			hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
+					HRTIMER_REL);
 		}
 	}
 	spin_unlock_irqrestore(&ts->lock, flags);
@@ -790,8 +795,7 @@ static int __devinit ads7846_probe(struc
 	ts->spi = spi;
 	ts->input = input_dev;
 
-	init_timer(&ts->timer);
-	ts->timer.data = (unsigned long) ts;
+	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_REL);
 	ts->timer.function = ads7846_timer;
 
 	spin_lock_init(&ts->lock);
