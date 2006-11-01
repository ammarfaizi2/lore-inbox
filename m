Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946548AbWKAFtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946548AbWKAFtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946535AbWKAFnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:53 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:15324 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946523AbWKAFne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:43:34 -0500
Message-Id: <20061101054320.861225000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:24 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, "Clemens Ladisch" <clemens@ladisch.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 44/61] ALSA: snd_rtctimer: handle RTC interrupts with a tasklet
Content-Disposition: inline; filename=alsa-snd_rtctimer-handle-rtc-interrupts-with-a-tasklet.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From:  <clemens@ladisch.de>

The calls to rtc_control() from inside the interrupt handler can
deadlock the RTC code, so move our interrupt handling code to a tasklet.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 sound/core/rtctimer.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- linux-2.6.18.1.orig/sound/core/rtctimer.c
+++ linux-2.6.18.1/sound/core/rtctimer.c
@@ -50,7 +50,9 @@ static int rtctimer_stop(struct snd_time
  * The hardware dependent description for this timer.
  */
 static struct snd_timer_hardware rtc_hw = {
-	.flags =	SNDRV_TIMER_HW_FIRST|SNDRV_TIMER_HW_AUTO,
+	.flags =	SNDRV_TIMER_HW_AUTO |
+			SNDRV_TIMER_HW_FIRST |
+			SNDRV_TIMER_HW_TASKLET,
 	.ticks =	100000000L,		/* FIXME: XXX */
 	.open =		rtctimer_open,
 	.close =	rtctimer_close,
@@ -60,6 +62,7 @@ static struct snd_timer_hardware rtc_hw 
 
 static int rtctimer_freq = RTC_FREQ;		/* frequency */
 static struct snd_timer *rtctimer;
+static struct tasklet_struct rtc_tasklet;
 static rtc_task_t rtc_task;
 
 
@@ -81,6 +84,7 @@ rtctimer_close(struct snd_timer *t)
 	rtc_task_t *rtc = t->private_data;
 	if (rtc) {
 		rtc_unregister(rtc);
+		tasklet_kill(&rtc_tasklet);
 		t->private_data = NULL;
 	}
 	return 0;
@@ -105,12 +109,17 @@ rtctimer_stop(struct snd_timer *timer)
 	return 0;
 }
 
+static void rtctimer_tasklet(unsigned long data)
+{
+	snd_timer_interrupt((struct snd_timer *)data, 1);
+}
+
 /*
  * interrupt
  */
 static void rtctimer_interrupt(void *private_data)
 {
-	snd_timer_interrupt(private_data, 1);
+	tasklet_hi_schedule(private_data);
 }
 
 
@@ -139,9 +148,11 @@ static int __init rtctimer_init(void)
 	timer->hw = rtc_hw;
 	timer->hw.resolution = NANO_SEC / rtctimer_freq;
 
+	tasklet_init(&rtc_tasklet, rtctimer_tasklet, (unsigned long)timer);
+
 	/* set up RTC callback */
 	rtc_task.func = rtctimer_interrupt;
-	rtc_task.private_data = timer;
+	rtc_task.private_data = &rtc_tasklet;
 
 	err = snd_timer_global_register(timer);
 	if (err < 0) {

--
