Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756890AbWK1NBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbWK1NBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 08:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756992AbWK1NBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 08:01:20 -0500
Received: from parabel.levigo.net ([62.206.214.16]:51903 "EHLO
	parabel.matrix.de") by vger.kernel.org with ESMTP id S1756991AbWK1NBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 08:01:19 -0500
Message-ID: <456C3317.4090403@gdsys.de>
Date: Tue, 28 Nov 2006 14:01:11 +0100
From: Dirk Eibach <eibach@gdsys.de>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: fix broken ds1337 initialization
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-5; AVE: 7.2.0.46; VDF: 6.36.1.97; host: mailrelay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a custom board with ds1337 RTC I found that upgrade from 2.6.15 to 
2.6.18 broke RTC support.

The main problem are changes to ds1337_init_client().
When a ds1337 recognizes a problem (e.g. power or clock failure) bit 7 
in status register is set. This has to be reset by writing 0 to status 
register. But since there are only 16 byte written to the chip and the 
first byte is interpreted as an address, the status register (which is 
the 16th) is never written.
The other problem is, that initializing all registers to zero is not 
valid for day, date and month register. Funny enough this is checked by 
ds1337_detect(), which depends on this values not being zero. So then 
treated by ds1337_init_client() the ds1337 is not detected anymore, 
whereas the failure bit in the status register is still set.

This patch applies to kernel 2.6.18.

Signed-off-by: Dirk Stieler <stieler@gdsys.de>
Signed-off-by: Dirk Eibach <eibach@gdsys.de>
---
--- linux-2.6.18-denx-git.new/drivers/i2c/chips/ds1337.c	2006-10-03 
20:15:48.000000000 +0200
+++ linux-2.6.18-denx-git/drivers/i2c/chips/ds1337.c	2006-11-28 
12:53:31.210765674 +0100
@@ -385,13 +385,19 @@ static void ds1337_init_client(struct i2

  	if ((status & 0x80) || (control & 0x80)) {
  		/* RTC not running */
-		u8 buf[16];
+		u8 buf[17]; /* First byte is interpreted as address */
  		struct i2c_msg msg[1];

  		dev_dbg(&client->dev, "%s: RTC not running!\n", __FUNCTION__);

  		/* Initialize all, including STATUS and CONTROL to zero */
  		memset(buf, 0, sizeof(buf));
+
+		/* Write valid values in the date/time registers */
+		buf[4] = 1; /* Day */
+		buf[5] = 1; /* Date */
+		buf[6] = 1; /* Month */
+
  		msg[0].addr = client->addr;
  		msg[0].flags = 0;
  		msg[0].len = sizeof(buf);



