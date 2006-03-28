Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWC1AWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWC1AWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWC1AWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:22:41 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:27062 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751175AbWC1AWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:22:40 -0500
Date: Mon, 27 Mar 2006 17:23:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-mm1 2/3] rtc: m41t00 driver cleanup
Message-ID: <20060328002320.GD21077@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz> <zt2d4LqL.1141645514.2993990.khali@localhost> <20060307170107.GA5250@mag.az.mvista.com> <20060318001254.GA14079@mag.az.mvista.com> <20060323210856.f1bfd02b.khali@linux-fr.org> <20060323203843.GA18912@mag.az.mvista.com> <20060324012137.GD9560@mag.az.mvista.com> <20060327191111.f7b057cb.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327191111.f7b057cb.khali@linux-fr.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend...
---

This patch does some cleanup to the m41t00 i2c/rtc driver including:
- use BCD2BIN/BIN2BCD instead of BCD_TO_BIN/BIN_TO_BCD
- use strlcpy instead of strncpy
- some whitespace cleanup

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 m41t00.c |   49 +++++++++++++++++++++----------------------------
 1 files changed, 21 insertions(+), 28 deletions(-)
---

diff -Nurp linux-2.6.16-mm1-wq/drivers/i2c/chips/m41t00.c linux-2.6.16-mm1-cleanup/drivers/i2c/chips/m41t00.c
--- linux-2.6.16-mm1-wq/drivers/i2c/chips/m41t00.c	2006-03-27 15:29:35.000000000 -0700
+++ linux-2.6.16-mm1-cleanup/drivers/i2c/chips/m41t00.c	2006-03-27 16:00:35.000000000 -0700
@@ -1,6 +1,4 @@
 /*
- * drivers/i2c/chips/m41t00.c
- *
  * I2C client/driver for the ST M41T00 Real-Time Clock chip.
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
@@ -13,9 +11,6 @@
 /*
  * This i2c client/driver wedges between the drivers/char/genrtc.c RTC
  * interface and the SMBus interface of the i2c subsystem.
- * It would be more efficient to use i2c msgs/i2c_transfer directly but, as
- * recommened in .../Documentation/i2c/writing-clients section
- * "Sending and receiving", using SMBus level communication is preferred.
  */
 
 #include <linux/kernel.h>
@@ -41,17 +36,17 @@ static unsigned short ignore[] = { I2C_C
 static unsigned short normal_addr[] = { 0x68, I2C_CLIENT_END };
 
 static struct i2c_client_address_data addr_data = {
-	.normal_i2c		= normal_addr,
-	.probe			= ignore,
-	.ignore			= ignore,
+	.normal_i2c	= normal_addr,
+	.probe		= ignore,
+	.ignore		= ignore,
 };
 
 ulong
 m41t00_get_rtc_time(void)
 {
-	s32	sec, min, hour, day, mon, year;
-	s32	sec1, min1, hour1, day1, mon1, year1;
-	ulong	limit = 10;
+	s32 sec, min, hour, day, mon, year;
+	s32 sec1, min1, hour1, day1, mon1, year1;
+	ulong limit = 10;
 
 	sec = min = hour = day = mon = year = 0;
 	sec1 = min1 = hour1 = day1 = mon1 = year1 = 0;
@@ -97,12 +92,12 @@ m41t00_get_rtc_time(void)
 	mon &= 0x1f;
 	year &= 0xff;
 
-	BCD_TO_BIN(sec);
-	BCD_TO_BIN(min);
-	BCD_TO_BIN(hour);
-	BCD_TO_BIN(day);
-	BCD_TO_BIN(mon);
-	BCD_TO_BIN(year);
+	sec = BCD2BIN(sec);
+	min = BCD2BIN(min);
+	hour = BCD2BIN(hour);
+	day = BCD2BIN(day);
+	mon = BCD2BIN(mon);
+	year = BCD2BIN(year);
 
 	year += 1900;
 	if (year < 1970)
@@ -115,17 +110,17 @@ static void
 m41t00_set(void *arg)
 {
 	struct rtc_time	tm;
-	ulong	nowtime = *(ulong *)arg;
+	ulong nowtime = *(ulong *)arg;
 
 	to_tm(nowtime, &tm);
 	tm.tm_year = (tm.tm_year - 1900) % 100;
 
-	BIN_TO_BCD(tm.tm_sec);
-	BIN_TO_BCD(tm.tm_min);
-	BIN_TO_BCD(tm.tm_hour);
-	BIN_TO_BCD(tm.tm_mon);
-	BIN_TO_BCD(tm.tm_mday);
-	BIN_TO_BCD(tm.tm_year);
+	tm.tm_sec = BIN2BCD(tm.tm_sec);
+	tm.tm_min = BIN2BCD(tm.tm_min);
+	tm.tm_hour = BIN2BCD(tm.tm_hour);
+	tm.tm_mon = BIN2BCD(tm.tm_mon);
+	tm.tm_mday = BIN2BCD(tm.tm_mday);
+	tm.tm_year = BIN2BCD(tm.tm_year);
 
 	mutex_lock(&m41t00_mutex);
 	if ((i2c_smbus_write_byte_data(save_client, 0, tm.tm_sec & 0x7f) < 0)
@@ -143,7 +138,6 @@ m41t00_set(void *arg)
 		dev_warn(&save_client->dev,"m41t00: can't write to rtc chip\n");
 
 	mutex_unlock(&m41t00_mutex);
-	return;
 }
 
 static ulong new_time;
@@ -180,7 +174,7 @@ m41t00_probe(struct i2c_adapter *adap, i
 	if (!client)
 		return -ENOMEM;
 
-	strncpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
+	strlcpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
 	client->addr = addr;
 	client->adapter = adap;
 	client->driver = &m41t00_driver;
@@ -204,7 +198,7 @@ m41t00_attach(struct i2c_adapter *adap)
 static int
 m41t00_detach(struct i2c_client *client)
 {
-	int	rc;
+	int rc;
 
 	if ((rc = i2c_detach_client(client)) == 0) {
 		kfree(client);
@@ -232,7 +226,6 @@ static void __exit
 m41t00_exit(void)
 {
 	i2c_del_driver(&m41t00_driver);
-	return;
 }
 
 module_init(m41t00_init);
