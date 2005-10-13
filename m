Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVJMUIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVJMUIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVJMUIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:08:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11223 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932442AbVJMUIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:08:53 -0400
Date: Thu, 13 Oct 2005 22:07:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Sharp sl-5500 touchscreen support
Message-ID: <20051013200742.GA12757@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds support for sharp zaurus sl-5500 touchscreen. It introduces
some not-too-nice ifs, but I guess copying whole ucb1x00-ts.c
would be bad idea...

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -32,9 +32,12 @@
 #include <linux/suspend.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 
 #include <asm/dma.h>
 #include <asm/semaphore.h>
+#include <asm/arch/collie.h>
+#include <asm/mach-types.h>
 
 #include "ucb1x00.h"
 
@@ -85,12 +90,23 @@ static inline void ucb1x00_ts_mode_int(s
  */
 static inline unsigned int ucb1x00_ts_read_pressure(struct ucb1x00_ts *ts)
 {
-	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
-			UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
-			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
-			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	if (machine_is_collie()) {
+		ucb1x00_io_write(ts->ucb, COLLIE_TC35143_GPIO_TBL_CHK, 0);
+		ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+				  UCB_TS_CR_TSPX_POW | UCB_TS_CR_TSMX_POW | 
+				  UCB_TS_CR_MODE_POS | UCB_TS_CR_BIAS_ENA);
 
-	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPY, ts->adcsync);
+		udelay(55);
+
+		return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_AD2, ts->adcsync);
+	} else {
+		ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+				  UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
+				  UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
+				  UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+
+		return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPY, ts->adcsync);
+	}
 }
 
 /*
@@ -101,12 +117,16 @@ static inline unsigned int ucb1x00_ts_re
  */
 static inline unsigned int ucb1x00_ts_read_xpos(struct ucb1x00_ts *ts)
 {
-	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
-			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
-			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
-	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
-			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
-			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	if (machine_is_collie())
+		ucb1x00_io_write(ts->ucb, 0, COLLIE_TC35143_GPIO_TBL_CHK);
+	else {
+		ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+				  UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+				  UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+		ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+				  UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+				  UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	}
 	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
 			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
 			UCB_TS_CR_MODE_POS | UCB_TS_CR_BIAS_ENA);
@@ -124,12 +144,17 @@ static inline unsigned int ucb1x00_ts_re
  */
 static inline unsigned int ucb1x00_ts_read_ypos(struct ucb1x00_ts *ts)
 {
-	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
-			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
-			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
-	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
-			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
-			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	if (machine_is_collie())
+		ucb1x00_io_write(ts->ucb, 0, COLLIE_TC35143_GPIO_TBL_CHK);
+	else {
+		ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+				  UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+				  UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+		ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+				  UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+				  UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	}
+
 	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
 			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
 			UCB_TS_CR_MODE_POS | UCB_TS_CR_BIAS_ENA);
@@ -163,6 +188,15 @@ static inline unsigned int ucb1x00_ts_re
 	return ucb1x00_adc_read(ts->ucb, 0, ts->adcsync);
 }
 
+static inline int ucb1x00_ts_pen_down(struct ucb1x00_ts *ts)
+{
+	unsigned int val = ucb1x00_reg_read(ts->ucb, UCB_TS_CR);
+	if (machine_is_collie())
+		return (!(val & (UCB_TS_CR_TSPX_LOW)));
+	else
+		return (val & (UCB_TS_CR_TSPX_LOW | UCB_TS_CR_TSMX_LOW));
+}
+
 /*
  * This is a RT kernel thread that handles the ADC accesses
  * (mainly so we can use semaphores in the UCB1200 core code
@@ -186,7 +220,7 @@ static int ucb1x00_thread(void *_ts)
 
 	add_wait_queue(&ts->irq_wait, &wait);
 	while (!kthread_should_stop()) {
-		unsigned int x, y, p, val;
+		unsigned int x, y, p;
 		signed long timeout;
 
 		ts->restart = 0;
@@ -206,12 +240,12 @@ static int ucb1x00_thread(void *_ts)
 		msleep(10);
 
 		ucb1x00_enable(ts->ucb);
-		val = ucb1x00_reg_read(ts->ucb, UCB_TS_CR);
 
-		if (val & (UCB_TS_CR_TSPX_LOW | UCB_TS_CR_TSMX_LOW)) {
+
+		if (ucb1x00_ts_pen_down(ts)) {
 			set_task_state(tsk, TASK_INTERRUPTIBLE);
 
-			ucb1x00_enable_irq(ts->ucb, UCB_IRQ_TSPX, UCB_FALLING);
+			ucb1x00_enable_irq(ts->ucb, UCB_IRQ_TSPX, machine_is_collie() ? UCB_RISING : UCB_FALLING);
 			ucb1x00_disable(ts->ucb);
 
 			/*

-- 
Thanks, Sharp!
