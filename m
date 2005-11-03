Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbVKCUXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbVKCUXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 15:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbVKCUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 15:23:36 -0500
Received: from s14.s14avahost.net ([66.98.146.55]:50331 "EHLO
	s14.s14avahost.net") by vger.kernel.org with ESMTP id S1030445AbVKCUXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 15:23:35 -0500
Message-ID: <436A71B9.6060205@katalix.com>
Date: Thu, 03 Nov 2005 20:23:21 +0000
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Michael Burian <dynmail1@gassner-waagen.at>
Subject: [PATCH: 2.6.14] i2c chips: ds1337 1/2
Content-Type: multipart/mixed;
 boundary="------------020903080208060909030409"
X-PopBeforeSMTPSenders: jchapman@katalix.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s14.s14avahost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - katalix.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020903080208060909030409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch for ds1337 i2c driver:

Add code to handle case where board firmware does not start the
RTC.

This patch was contributed by Michael Burian.

Signed-off-by: Michael Burian <dynmail1@gassner-waagen.at>
Signed-off-by: James Chapman <jchapman@katalix.com>

-- 
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development




--------------020903080208060909030409
Content-Type: text/plain;
 name="ds1337-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ds1337-init.patch"

Add code to handle case where board firmware does not start the
RTC.

This patch was contributed by Michael Burian.

Signed-off-by: Michael Burian <dynmail1@gassner-waagen.at>
Signed-off-by: James Chapman <jchapman@katalix.com>

Index: linux-2.6.14/drivers/i2c/chips/ds1337.c
===================================================================
--- linux-2.6.14.orig/drivers/i2c/chips/ds1337.c	2005-11-02 19:30:17.000000000 +0000
+++ linux-2.6.14/drivers/i2c/chips/ds1337.c	2005-11-03 20:14:58.981735046 +0000
@@ -149,12 +149,25 @@
 	u8 buf[8];
 	u8 val;
 	struct i2c_msg msg[1];
+	u8 status, control;
+	int i;
 
 	if (!dt) {
 		dev_dbg(&client->dev, "%s: EINVAL: dt=NULL\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
+	status  = i2c_smbus_read_byte_data(client, DS1337_REG_STATUS);
+	control = i2c_smbus_read_byte_data(client, DS1337_REG_CONTROL);
+	
+	/* On some boards, the RTC isn't configured by boot firmware. 
+	 * Handle that case by starting/configuring the RTC now.
+	 */
+	if ((status & 0x80) || (control & 0x80))
+		/* Initialize all, including STATUS and CONTROL to zero */
+		for (i = 0; i < 16; i++)
+			i2c_smbus_write_byte_data(client, i, 0);
+
 	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n", __FUNCTION__,
 		dt->tm_sec, dt->tm_min, dt->tm_hour,

--------------020903080208060909030409--
