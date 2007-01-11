Return-Path: <linux-kernel-owner+w=401wt.eu-S1030299AbXAKMPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbXAKMPv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 07:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbXAKMPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 07:15:51 -0500
Received: from birgitte.twibble.org ([202.173.155.195]:57807 "EHLO
	birgitte.twibble.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030299AbXAKMPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 07:15:50 -0500
Date: Thu, 11 Jan 2007 22:41:40 +1100
From: Jamie Lenehan <lenehan@twibble.org>
To: David Brownell <david-b@pacbell.net>,
       Alessandro Zummo <alessandro.zummo@towertech.it>,
       Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       rtc-linux@googlegroups.com
Subject: [patch] rtc-sh: act on rtc_wkalrm.enabled when setting an alarm
Message-ID: <20070111114140.GB6333@twibble.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the SH rtc driver correctly act on the "enabled" flag when
setting an alarm.

Signed-off-by: Jamie Lenehan <lenehan@twibble.org>

--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -492,10 +492,10 @@ static int sh_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 
 	spin_lock_irq(&rtc->lock);
 
-	/* disable alarm interrupt and clear flag */
+	/* disable alarm interrupt and clear the alarm flag */
 	rcr1 = readb(rtc->regbase + RCR1);
-	rcr1 &= ~RCR1_AF;
-	writeb(rcr1 & ~RCR1_AIE, rtc->regbase + RCR1);
+	rcr1 &= ~(RCR1_AF|RCR1_AIE);
+	writeb(rcr1, rtc->regbase + RCR1);
 
 	rtc->rearm_aie = 0;
 
@@ -510,8 +510,10 @@ static int sh_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 		mon += 1;
 	sh_rtc_write_alarm_value(rtc, mon, RMONAR);
 
-	/* Restore interrupt activation status */
-	writeb(rcr1, rtc->regbase + RCR1);
+	if (wkalrm->enabled) {
+		rcr1 |= RCR1_AIE;
+		writeb(rcr1, rtc->regbase + RCR1);
+	}
 
 	spin_unlock_irq(&rtc->lock);
 

-- 
 Jamie Lenehan <lenehan@twibble.org>
