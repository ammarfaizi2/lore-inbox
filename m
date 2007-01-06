Return-Path: <linux-kernel-owner+w=401wt.eu-S1751191AbXAFGtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbXAFGtO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 01:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbXAFGtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 01:49:14 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:34433 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751191AbXAFGtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 01:49:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=S9moOS5kNY7M5S5kUKWxfT1cjPXDUmyENF3ju/JAJjKz4mQgS9Ll/G13XPZt7lpVvfIDXwHNrAMqnSZrVchUODe28GUYPJyDixw56b9GTHAafT/0viQOAJWBl86Lt4dvyIkI5dx9x2dh/kIUoDVVC7dsg9i7nJxBOMZ6CGTKAJo=  ;
X-YMail-OSG: .tVN3DQVM1nX7z5ky8oVSOr8oM265LUw4r2B3rq08ILTRqK.ZXNkGkaybSF4IkgWNmzhwEqMZfPawBkaC5ZAbAfX.wBEAk_vTljWI19eVDRVvgftm9ClNLkHA2ILJt93EYjYC8M4h3ACqpn9C1isPQCuIwgYWUQ4Ikz4cgCqLgXtpn0czZGDCWFks2LF7Pf6yAbS5gj2Wr0bXbU-
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Paul Mundt <lethal@linux-sh.org>, lenehan@twibble.org
Subject: [patch 2.6.20-rc3] rtc-sh correctly reports rtc_wkalrm.enabled
Date: Fri, 5 Jan 2007 20:55:05 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       rtc-linux@googlegroups.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701052055.06264.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the SH rtc driver to
  (a) correctly report 'enabled' status with other alarm status;
  (b) not duplicate that status in its procfs dump

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
An audit of the RTC driver treatment of the "enabled" flag turned
up a handful of clear bugs; most drivers handle it the same now
(assuming they support alarms).

This driver has another issue:  sh_rtc_set_alarm() ignores the
"enabled" flag, rather than using it to tell whether the alarm
should be enabled on exit from that routine.  One at a time.  :)

Index: at91/drivers/rtc/rtc-sh.c
===================================================================
--- at91.orig/drivers/rtc/rtc-sh.c	2006-12-18 23:32:22.000000000 -0800
+++ at91/drivers/rtc/rtc-sh.c	2006-12-18 23:34:37.000000000 -0800
@@ -264,8 +264,6 @@ static int sh_rtc_proc(struct device *de
 	unsigned int tmp;
 
 	tmp = readb(rtc->regbase + RCR1);
-	seq_printf(seq, "alarm_IRQ\t: %s\n",
-		   (tmp & RCR1_AIE) ? "yes" : "no");
 	seq_printf(seq, "carry_IRQ\t: %s\n",
 		   (tmp & RCR1_CIE) ? "yes" : "no");
 
@@ -428,6 +426,8 @@ static int sh_rtc_read_alarm(struct devi
 		tm->tm_mon -= 1; /* RTC is 1-12, tm_mon is 0-11 */
 	tm->tm_year     = 0xffff;
 
+	wkalrm->enabled = (readb(rtc->regbase + RCR1) & RCR1_AIE) ? 1 : 0;
+
 	spin_unlock_irq(&rtc->lock);
 
 	return 0;
