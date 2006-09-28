Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWI1OUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWI1OUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWI1OUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:20:10 -0400
Received: from smtp-grenoble1.teamlog.com ([194.2.68.40]:16138 "EHLO
	me-ml2.teamlog.fr") by vger.kernel.org with ESMTP id S1161147AbWI1OUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:20:09 -0400
Subject: [PATCH] rtc driver rtc-pcf8563 century bit inversed
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
To: linux-kernel@vger.kernel.org
Cc: a.zummo@towertech.it
Content-Type: multipart/mixed; boundary="=-sn+qvW9A302glWg+f6Ml"
Date: Thu, 28 Sep 2006 16:19:49 +0200
Message-Id: <1159453190.8837.6.camel@jb-portable>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sn+qvW9A302glWg+f6Ml
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The century bit PCF8563_MO_C in the month register is misinterpreted. It
is set to 1 for the 20th century and 0 for 21th, and the driver is
expecting the opposite behavior.

Here is a small patch to address this issue.
Thanks for all the good work!


Jean-Baptiste Maneyrol
Teamlog - France


--=-sn+qvW9A302glWg+f6Ml
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.18/drivers/rtc/rtc-pcf8563.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18_tlgate/drivers/rtc/rtc-pcf8563.c	2006-09-28 15:59:28.000000000 +0200
@@ -95,7 +95,7 @@
 	tm->tm_wday = buf[PCF8563_REG_DW] & 0x07;
 	tm->tm_mon = BCD2BIN(buf[PCF8563_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
 	tm->tm_year = BCD2BIN(buf[PCF8563_REG_YR])
-		+ (buf[PCF8563_REG_MO] & PCF8563_MO_C ? 100 : 0);
+		+ (buf[PCF8563_REG_MO] & PCF8563_MO_C ? 0 : 100);
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -135,7 +135,7 @@
 
 	/* year and century */
 	buf[PCF8563_REG_YR] = BIN2BCD(tm->tm_year % 100);
-	if (tm->tm_year / 100)
+	if (tm->tm_year < 100)
 		buf[PCF8563_REG_MO] |= PCF8563_MO_C;
 
 	buf[PCF8563_REG_DW] = tm->tm_wday & 0x07;

--=-sn+qvW9A302glWg+f6Ml--

