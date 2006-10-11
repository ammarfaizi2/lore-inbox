Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161445AbWJKVJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161445AbWJKVJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161459AbWJKVJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:09:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:29603 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161445AbWJKVJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:14 -0400
Date: Wed, 11 Oct 2006 14:08:46 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jean-baptiste.maneyrol@teamlog.com,
       Alessandro Zummo <a.zummo@towertech.it>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 60/67] rtc driver rtc-pcf8563 century bit inversed
Message-ID: <20061011210846.GI16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="rtc-driver-rtc-pcf8563-century-bit-inversed.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>

The century bit PCF8563_MO_C in the month register is misinterpreted.  It
is set to 1 for the 20th century and 0 for 21th, and the driver is
expecting the opposite behavior.

Acked-by: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/rtc/rtc-pcf8563.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/drivers/rtc/rtc-pcf8563.c
+++ linux-2.6.18/drivers/rtc/rtc-pcf8563.c
@@ -95,7 +95,7 @@ static int pcf8563_get_datetime(struct i
 	tm->tm_wday = buf[PCF8563_REG_DW] & 0x07;
 	tm->tm_mon = BCD2BIN(buf[PCF8563_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
 	tm->tm_year = BCD2BIN(buf[PCF8563_REG_YR])
-		+ (buf[PCF8563_REG_MO] & PCF8563_MO_C ? 100 : 0);
+		+ (buf[PCF8563_REG_MO] & PCF8563_MO_C ? 0 : 100);
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -135,7 +135,7 @@ static int pcf8563_set_datetime(struct i
 
 	/* year and century */
 	buf[PCF8563_REG_YR] = BIN2BCD(tm->tm_year % 100);
-	if (tm->tm_year / 100)
+	if (tm->tm_year < 100)
 		buf[PCF8563_REG_MO] |= PCF8563_MO_C;
 
 	buf[PCF8563_REG_DW] = tm->tm_wday & 0x07;

--
