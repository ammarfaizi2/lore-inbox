Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWC1AZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWC1AZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWC1AZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:25:43 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:31673 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751177AbWC1AZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:25:42 -0500
Date: Mon, 27 Mar 2006 17:26:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>, lm-sensors@lm-sensors.org,
       r.marek@sh.cvut.cz, khali@linux-fr.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81 & m41t85 chips to m41t00 driver
Message-ID: <20060328002625.GE21077@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz> <zt2d4LqL.1141645514.2993990.khali@localhost> <20060307170107.GA5250@mag.az.mvista.com> <20060318001254.GA14079@mag.az.mvista.com> <20060323210856.f1bfd02b.khali@linux-fr.org> <20060323203843.GA18912@mag.az.mvista.com> <20060324012406.GE9560@mag.az.mvista.com> <20060326145840.5e578fa4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326145840.5e578fa4.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend...
---

 drivers/i2c/chips/m41t00.c |  294 ++++++++++++++++++++++++++++++++++-----------
 include/linux/m41t00.h     |   50 +++++++
 2 files changed, 276 insertions(+), 68 deletions(-)
---

diff -Nurp linux-2.6.16-mm1-cleanup/drivers/i2c/chips/m41t00.c linux-2.6.16-mm1-newsupp/drivers/i2c/chips/m41t00.c
--- linux-2.6.16-mm1-cleanup/drivers/i2c/chips/m41t00.c	2006-03-27 16:00:35.000000000 -0700
+++ linux-2.6.16-mm1-newsupp/drivers/i2c/chips/m41t00.c	2006-03-27 16:49:35.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * I2C client/driver for the ST M41T00 Real-Time Clock chip.
+ * I2C client/driver for the ST M41T00 family of i2c rtc chips.
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
@@ -19,21 +19,17 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
-#include <linux/mutex.h>
 #include <linux/workqueue.h>
-
+#include <linux/platform_device.h>
+#include <linux/m41t00.h>
 #include <asm/time.h>
 #include <asm/rtc.h>
 
-#define	M41T00_DRV_NAME		"m41t00"
-
-static DEFINE_MUTEX(m41t00_mutex);
-
 static struct i2c_driver m41t00_driver;
 static struct i2c_client *save_client;
 
 static unsigned short ignore[] = { I2C_CLIENT_END };
-static unsigned short normal_addr[] = { 0x68, I2C_CLIENT_END };
+static unsigned short normal_addr[] = { 0, I2C_CLIENT_END };
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c	= normal_addr,
@@ -41,34 +37,55 @@ static struct i2c_client_address_data ad
 	.ignore		= ignore,
 };
 
+struct m41t00_chip_info {
+	u16	type;
+	u16	read_limit;
+	u8	sec;		/* Offsets for chip regs */
+	u8	min;
+	u8	hour;
+	u8	day;
+	u8	mon;
+	u8	year;
+	u8	alarm_mon;
+	u8	alarm_hour;
+	u8	sqw;
+	u32	sqw_freq;
+};
+
+static struct m41t00_chip_info m41t00_chip_info_tbl[] = {
+	{ M41T00_TYPE_M41T00, 5, 0, 1, 2, 4, 5, 6, 0, 0, 0, 0 },
+	{ M41T00_TYPE_M41T81, 1, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
+	{ M41T00_TYPE_M41T85, 1, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
+};
+static struct m41t00_chip_info *m41t00_chip;
+
 ulong
 m41t00_get_rtc_time(void)
 {
 	s32 sec, min, hour, day, mon, year;
 	s32 sec1, min1, hour1, day1, mon1, year1;
-	ulong limit = 10;
+	u16 reads = 0;
+	u8 buf[8], msgbuf[1] = { 0 }; /* offset into rtc's regs */
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= save_client->addr,
+			.flags	= 0,
+			.len	= 1,
+			.buf	= msgbuf,
+		},
+		{
+			.addr	= save_client->addr,
+			.flags	= I2C_M_RD,
+			.len	= 8,
+			.buf	= buf,
+		},
+	};
 
 	sec = min = hour = day = mon = year = 0;
-	sec1 = min1 = hour1 = day1 = mon1 = year1 = 0;
 
-	mutex_lock(&m41t00_mutex);
 	do {
-		if (((sec = i2c_smbus_read_byte_data(save_client, 0)) >= 0)
-			&& ((min = i2c_smbus_read_byte_data(save_client, 1))
-				>= 0)
-			&& ((hour = i2c_smbus_read_byte_data(save_client, 2))
-				>= 0)
-			&& ((day = i2c_smbus_read_byte_data(save_client, 4))
-				>= 0)
-			&& ((mon = i2c_smbus_read_byte_data(save_client, 5))
-				>= 0)
-			&& ((year = i2c_smbus_read_byte_data(save_client, 6))
-				>= 0)
-			&& ((sec == sec1) && (min == min1) && (hour == hour1)
-				&& (day == day1) && (mon == mon1)
-				&& (year == year1)))
-
-				break;
+		if (i2c_transfer(save_client->adapter, msgs, 2) < 0)
+			goto read_err;
 
 		sec1 = sec;
 		min1 = min;
@@ -76,21 +93,21 @@ m41t00_get_rtc_time(void)
 		day1 = day;
 		mon1 = mon;
 		year1 = year;
-	} while (--limit > 0);
-	mutex_unlock(&m41t00_mutex);
-
-	if (limit == 0) {
-		dev_warn(&save_client->dev,
-			"m41t00: can't read rtc chip\n");
-		sec = min = hour = day = mon = year = 0;
-	}
 
-	sec &= 0x7f;
-	min &= 0x7f;
-	hour &= 0x3f;
-	day &= 0x3f;
-	mon &= 0x1f;
-	year &= 0xff;
+		sec = buf[m41t00_chip->sec] & 0x7f;
+		min = buf[m41t00_chip->min] & 0x7f;
+		hour = buf[m41t00_chip->hour] & 0x3f;
+		day = buf[m41t00_chip->day] & 0x3f;
+		mon = buf[m41t00_chip->mon] & 0x1f;
+		year = buf[m41t00_chip->year] & 0xff;
+	} while ((++reads < m41t00_chip->read_limit) && ((sec != sec1)
+			|| (min != min1) || (hour != hour1) || (day != day1)
+			|| (mon != mon1) || (year != year1)));
+
+	if ((m41t00_chip->read_limit > 1) && ((sec != sec1) || (min != min1)
+			|| (hour != hour1) || (day != day1) || (mon != mon1)
+			|| (year != year1)))
+		goto read_err;
 
 	sec = BCD2BIN(sec);
 	min = BCD2BIN(min);
@@ -104,40 +121,59 @@ m41t00_get_rtc_time(void)
 		year += 100;
 
 	return mktime(year, mon, day, hour, min, sec);
+
+read_err:
+	dev_err(&save_client->dev, "m41t00_get_rtc_time: Read error\n");
+	return 0;
 }
 
 static void
 m41t00_set(void *arg)
 {
 	struct rtc_time	tm;
-	ulong nowtime = *(ulong *)arg;
+	int nowtime = *(int *)arg;
+	s32 sec, min, hour, day, mon, year;
+	u8 wbuf[9], *buf = &wbuf[1], msgbuf[1] = { 0 };
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= save_client->addr,
+			.flags	= 0,
+			.len	= 1,
+			.buf	= msgbuf,
+		},
+		{
+			.addr	= save_client->addr,
+			.flags	= I2C_M_RD,
+			.len	= 8,
+			.buf	= buf,
+		},
+	};
 
 	to_tm(nowtime, &tm);
 	tm.tm_year = (tm.tm_year - 1900) % 100;
 
-	tm.tm_sec = BIN2BCD(tm.tm_sec);
-	tm.tm_min = BIN2BCD(tm.tm_min);
-	tm.tm_hour = BIN2BCD(tm.tm_hour);
-	tm.tm_mon = BIN2BCD(tm.tm_mon);
-	tm.tm_mday = BIN2BCD(tm.tm_mday);
-	tm.tm_year = BIN2BCD(tm.tm_year);
-
-	mutex_lock(&m41t00_mutex);
-	if ((i2c_smbus_write_byte_data(save_client, 0, tm.tm_sec & 0x7f) < 0)
-		|| (i2c_smbus_write_byte_data(save_client, 1, tm.tm_min & 0x7f)
-			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 2, tm.tm_hour & 0x7f)
-			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 4, tm.tm_mday & 0x7f)
-			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 5, tm.tm_mon & 0x7f)
-			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 6, tm.tm_year & 0x7f)
-			< 0))
+	sec = BIN2BCD(tm.tm_sec);
+	min = BIN2BCD(tm.tm_min);
+	hour = BIN2BCD(tm.tm_hour);
+	day = BIN2BCD(tm.tm_mday);
+	mon = BIN2BCD(tm.tm_mon);
+	year = BIN2BCD(tm.tm_year);
+
+	/* Read reg values into buf[0..7]/wbuf[1..8] */
+	if (i2c_transfer(save_client->adapter, msgs, 2) < 0) {
+		dev_err(&save_client->dev, "m41t00_set: Read error\n");
+		return;
+	}
 
-		dev_warn(&save_client->dev,"m41t00: can't write to rtc chip\n");
+	wbuf[0] = 0; /* offset into rtc's regs */
+	buf[m41t00_chip->sec] = (buf[m41t00_chip->sec] & ~0x7f) | (sec & 0x7f);
+	buf[m41t00_chip->min] = (buf[m41t00_chip->min] & ~0x7f) | (min & 0x7f);
+	buf[m41t00_chip->hour] = (buf[m41t00_chip->hour]& ~0x3f) | (hour& 0x3f);
+	buf[m41t00_chip->day] = (buf[m41t00_chip->day] & ~0x3f) | (day & 0x3f);
+	buf[m41t00_chip->mon] = (buf[m41t00_chip->mon] & ~0x1f) | (mon & 0x1f);
 
-	mutex_unlock(&m41t00_mutex);
+	if (i2c_master_send(save_client, wbuf, 9) < 0)
+		dev_err(&save_client->dev, "m41t00_set: Write error\n");
 }
 
 static ulong new_time;
@@ -160,6 +196,47 @@ m41t00_set_rtc_time(ulong nowtime)
 /*
  *****************************************************************************
  *
+ *	platform_data Driver Interface
+ *
+ *****************************************************************************
+ */
+static int __init
+m41t00_platform_probe(struct platform_device *pdev)
+{
+	struct m41t00_platform_data *pdata;
+	int i;
+
+	if (pdev && (pdata = pdev->dev.platform_data)) {
+		normal_addr[0] = pdata->i2c_addr;
+
+		for (i=0; i<ARRAY_SIZE(m41t00_chip_info_tbl); i++)
+			if (m41t00_chip_info_tbl[i].type == pdata->type) {
+				m41t00_chip = &m41t00_chip_info_tbl[i];
+				m41t00_chip->sqw_freq = pdata->sqw_freq;
+				return 0;
+			}
+	}
+	return -ENODEV;
+}
+
+static int __exit
+m41t00_platform_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver m41t00_platform_driver = {
+	.probe  = m41t00_platform_probe,
+	.remove = m41t00_platform_remove,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name  = M41T00_DRV_NAME,
+	},
+};
+
+/*
+ *****************************************************************************
+ *
  *	Driver Interface
  *
  *****************************************************************************
@@ -169,24 +246,100 @@ m41t00_probe(struct i2c_adapter *adap, i
 {
 	struct i2c_client *client;
 	int rc;
+	u8 rbuf[1], wbuf[2], msgbuf[1] = { 0 }; /* offset into rtc's regs */
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= 0,
+			.flags	= 0,
+			.len	= 1,
+			.buf	= msgbuf,
+		},
+		{
+			.addr	= 0,
+			.flags	= I2C_M_RD,
+			.len	= 1,
+			.buf	= rbuf,
+		},
+	};
 
 	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 
-	strlcpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
+	strlcpy(client->name, m41t00_driver.driver.name, I2C_NAME_SIZE);
 	client->addr = addr;
 	client->adapter = adap;
 	client->driver = &m41t00_driver;
 
-	if ((rc = i2c_attach_client(client)) != 0) {
-		kfree(client);
-		return rc;
+	if ((rc = i2c_attach_client(client)) != 0)
+		goto attach_err;
+
+	msgs[0].addr = addr;
+	msgs[1].addr = addr;
+
+	if (m41t00_chip->type != M41T00_TYPE_M41T00) {
+		/* If asked, set SQW frequency & enable */
+		if (m41t00_chip->sqw_freq) {
+			msgbuf[0] = m41t00_chip->alarm_mon;
+			if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
+				goto sqw_err;
+
+			wbuf[0] = m41t00_chip->alarm_mon;
+			wbuf[1] = rbuf[0] & ~0x40;
+			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
+				goto sqw_err;
+
+			wbuf[0] = m41t00_chip->sqw;
+			wbuf[1] = m41t00_chip->sqw_freq;
+			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
+				goto sqw_err;
+
+			wbuf[0] = m41t00_chip->alarm_mon;
+			wbuf[1] = rbuf[0] | 0x40;
+			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
+				goto sqw_err;
+		}
+
+		/* Make sure HT (Halt Update) bit is cleared */
+		msgbuf[0] = m41t00_chip->alarm_hour;
+		if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
+			goto ht_err;
+
+		if (rbuf[0] & 0x40) {
+			wbuf[0] = m41t00_chip->alarm_hour;
+			wbuf[1] = rbuf[0] & ~0x40;
+			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
+				goto ht_err;
+		}
+	}
+
+	/* Make sure ST (stop) bit is cleared */
+	msgbuf[0] = m41t00_chip->sec;
+	if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
+		goto st_err;
+
+	if (rbuf[0] & 0x80) {
+		wbuf[0] = m41t00_chip->sec;
+		wbuf[1] = rbuf[0] & ~0x80;
+		if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
+			goto st_err;
 	}
 
 	m41t00_wq = create_singlethread_workqueue("m41t00");
 	save_client = client;
 	return 0;
+
+st_err:
+	dev_err(&client->dev, "m41t00_probe: Can't clear ST bit\n");
+	goto attach_err;
+ht_err:
+	dev_err(&client->dev, "m41t00_probe: Can't clear HT bit\n");
+	goto attach_err;
+sqw_err:
+	dev_err(&client->dev, "m41t00_probe: Can't set SQW Frequency\n");
+attach_err:
+	kfree(client);
+	return rc;
 }
 
 static int
@@ -219,13 +372,18 @@ static struct i2c_driver m41t00_driver =
 static int __init
 m41t00_init(void)
 {
-	return i2c_add_driver(&m41t00_driver);
+	int rc;
+
+	if (!(rc = platform_driver_register(&m41t00_platform_driver)))
+		rc = i2c_add_driver(&m41t00_driver);
+	return rc;
 }
 
 static void __exit
 m41t00_exit(void)
 {
 	i2c_del_driver(&m41t00_driver);
+	platform_driver_unregister(&m41t00_platform_driver);
 }
 
 module_init(m41t00_init);
diff -Nurp linux-2.6.16-mm1-cleanup/include/linux/m41t00.h linux-2.6.16-mm1-newsupp/include/linux/m41t00.h
--- linux-2.6.16-mm1-cleanup/include/linux/m41t00.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-mm1-newsupp/include/linux/m41t00.h	2006-03-27 16:25:51.000000000 -0700
@@ -0,0 +1,50 @@
+/*
+ * Definitions for the ST M41T00 family of i2c rtc chips.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef _M41T00_H
+#define _M41T00_H
+
+#define	M41T00_DRV_NAME		"m41t00"
+#define	M41T00_I2C_ADDR		0x68
+
+#define	M41T00_TYPE_M41T00	0
+#define	M41T00_TYPE_M41T81	81
+#define	M41T00_TYPE_M41T85	85
+
+struct m41t00_platform_data {
+	u16	type;
+	u16	i2c_addr;
+	u32	sqw_freq;
+};
+
+/* SQW output disabled, this is default value by power on*/
+#define SQW_FREQ_DISABLE	(0)
+
+#define SQW_FREQ_32KHZ	(1<<4)		/* 32.768 KHz */
+#define SQW_FREQ_8KHZ	(2<<4)		/* 8.192 KHz */
+#define SQW_FREQ_4KHZ	(3<<4)		/* 4.096 KHz */
+#define SQW_FREQ_2KHZ	(4<<4)		/* 2.048 KHz */
+#define SQW_FREQ_1KHZ	(5<<4)		/* 1.024 KHz */
+#define SQW_FREQ_512HZ	(6<<4)		/* 512 Hz */
+#define SQW_FREQ_256HZ	(7<<4)		/* 256 Hz */
+#define SQW_FREQ_128HZ	(8<<4)		/* 128 Hz */
+#define SQW_FREQ_64HZ	(9<<4)		/* 64 Hz */
+#define SQW_FREQ_32HZ	(10<<4)		/* 32 Hz */
+#define SQW_FREQ_16HZ	(11<<4)		/* 16 Hz */
+#define SQW_FREQ_8HZ	(12<<4)		/* 8 Hz */
+#define SQW_FREQ_4HZ	(13<<4)		/* 4 Hz */
+#define SQW_FREQ_2HZ	(14<<4)		/* 2 Hz */
+#define SQW_FREQ_1HZ	(15<<4)		/* 1 Hz */
+
+extern ulong m41t00_get_rtc_time(void);
+extern int m41t00_set_rtc_time(ulong nowtime);
+
+#endif /* _M41T00_H */
