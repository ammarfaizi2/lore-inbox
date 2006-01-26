Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWAZCCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWAZCCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWAZCCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:02:19 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:39421 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751281AbWAZCCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:02:18 -0500
Date: Wed, 25 Jan 2006 19:01:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>, Andrey Volkov <avolkov@varma-el.com>,
       adi@hexapodia.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] i2c: Combined ST m41txx i2c rtc chip driver
Message-ID: <20060126020133.GA11566@mag.az.mvista.com>
References: <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com> <20051219210325.GA21696@mag.az.mvista.com> <43A7D76E.5050008@varma-el.com> <20060111000912.GA11471@mag.az.mvista.com> <43C4D275.2070505@varma-el.com> <20060111161954.GB6405@mag.az.mvista.com> <43C5567C.8070106@varma-el.com> <20060118220600.GF15714@mag.az.mvista.com> <20060119082541.17aff81f.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119082541.17aff81f.khali@linux-fr.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 08:25:41AM +0100, Jean Delvare wrote:
> Hi Mark, Andrey,
> 
> > On Wed, Jan 11, 2006 at 10:03:24PM +0300, Andrey Volkov wrote:
> > <snip>
> > > P.S. Jean, "i2c_master_send vs i2c_smbus_write_byte_data"
> > > problem still open.
> > > Could you made executive decision about it?
> > 
> > I'm taking the roaring silence to mean nobody really cares so I don't
> > really have a problem going your way.  I'll submit a patch and if it
> > gets pooh-pooh'd, we can always change it back.
> 
> Sorry for the very late answer, I hadn't realized you were waiting for
> me.
> 
> The I2C vs. SMBus interface choice is yours (as long as the device
> supports both). I2C brings performance, SMBus gives you compatibility.
> Depending on the device you are writing a driver for, compatibility may
> or may not matter. For example, for a hardware monitoring chip driver,
> we always go for SMBus, because these chips are almost always connected
> to non-I2C SMBus masters. But RTC drivers are typically not used on
> mainstream PC motherboards so the compatibility may not be needed.
> 
> So, as Mark says, you should just go with the code you have right now.
> If it is SMBus and someone finds it too slow, that person can always
> add I2C access afterwards. OTOH if it is I2C and someone ever needs
> compatibility with a non-I2C master, that person gets to add the code.
> Note that it is perfectly acceptable to have *both* I2C and SMBus
> access methods in the same driver, if compatibility is wanted but the
> performance gain using I2C is significant. Of course it means more code
> in the driver, but as long as both access methods work and are properly
> maintained, it's fine with me.

Hi Jean.  Thanks for the feedback.

I decided to go with i2c b/c it is quite a bit more efficient and it
eliminates the need to worry about values rolling over while reading
the m41t8x's chips (still need to retry on the m41t00).

Andrey, et. al., how does this look & work?
Diff'd against linux-2.6.16-rc1-mm2.

Mark
---

diff -Nurp linux-2.6.16-rc1-mm2/drivers/i2c/chips/Kconfig linux-2.6.16-rc1-mm2-m41txx/drivers/i2c/chips/Kconfig
--- linux-2.6.16-rc1-mm2/drivers/i2c/chips/Kconfig	2006-01-17 00:44:47.000000000 -0700
+++ linux-2.6.16-rc1-mm2-m41txx/drivers/i2c/chips/Kconfig	2006-01-23 18:35:36.000000000 -0700
@@ -102,15 +102,6 @@ config TPS65010
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps65010.
 
-config SENSORS_M41T00
-	tristate "ST M41T00 RTC chip"
-	depends on I2C && PPC32
-	help
-	  If you say yes here you get support for the ST M41T00 RTC chip.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called m41t00.
-
 config SENSORS_MAX6875
 	tristate "Maxim MAX6875 Power supply supervisor"
 	depends on I2C && EXPERIMENTAL
@@ -135,4 +126,14 @@ config RTC_X1205_I2C
 	  This driver can also be built as a module. If so, the module
 	  will be called x1205.
 
+config RTC_M41TXX_I2C
+	tristate "ST M41TXX Family of I2C RTC chips"
+	depends on I2C
+	help
+	  If you say yes here you get support for the ST M41TXX family
+	  of I2C RTC chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called m41txx.
+
 endmenu
diff -Nurp linux-2.6.16-rc1-mm2/drivers/i2c/chips/m41t00.c linux-2.6.16-rc1-mm2-m41txx/drivers/i2c/chips/m41t00.c
--- linux-2.6.16-rc1-mm2/drivers/i2c/chips/m41t00.c	2006-01-23 15:02:47.000000000 -0700
+++ linux-2.6.16-rc1-mm2-m41txx/drivers/i2c/chips/m41t00.c	1969-12-31 17:00:00.000000000 -0700
@@ -1,241 +0,0 @@
-/*
- * drivers/i2c/chips/m41t00.c
- *
- * I2C client/driver for the ST M41T00 Real-Time Clock chip.
- *
- * Author: Mark A. Greer <mgreer@mvista.com>
- *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-/*
- * This i2c client/driver wedges between the drivers/char/genrtc.c RTC
- * interface and the SMBus interface of the i2c subsystem.
- * It would be more efficient to use i2c msgs/i2c_transfer directly but, as
- * recommened in .../Documentation/i2c/writing-clients section
- * "Sending and receiving", using SMBus level communication is preferred.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/rtc.h>
-#include <linux/bcd.h>
-#include <linux/mutex.h>
-
-#include <asm/time.h>
-#include <asm/rtc.h>
-
-#define	M41T00_DRV_NAME		"m41t00"
-
-static DEFINE_MUTEX(m41t00_mutex);
-
-static struct i2c_driver m41t00_driver;
-static struct i2c_client *save_client;
-
-static unsigned short ignore[] = { I2C_CLIENT_END };
-static unsigned short normal_addr[] = { 0x68, I2C_CLIENT_END };
-
-static struct i2c_client_address_data addr_data = {
-	.normal_i2c		= normal_addr,
-	.probe			= ignore,
-	.ignore			= ignore,
-};
-
-ulong
-m41t00_get_rtc_time(void)
-{
-	s32	sec, min, hour, day, mon, year;
-	s32	sec1, min1, hour1, day1, mon1, year1;
-	ulong	limit = 10;
-
-	sec = min = hour = day = mon = year = 0;
-	sec1 = min1 = hour1 = day1 = mon1 = year1 = 0;
-
-	mutex_lock(&m41t00_mutex);
-	do {
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
-
-		sec1 = sec;
-		min1 = min;
-		hour1 = hour;
-		day1 = day;
-		mon1 = mon;
-		year1 = year;
-	} while (--limit > 0);
-	mutex_unlock(&m41t00_mutex);
-
-	if (limit == 0) {
-		dev_warn(&save_client->dev,
-			"m41t00: can't read rtc chip\n");
-		sec = min = hour = day = mon = year = 0;
-	}
-
-	sec &= 0x7f;
-	min &= 0x7f;
-	hour &= 0x3f;
-	day &= 0x3f;
-	mon &= 0x1f;
-	year &= 0xff;
-
-	BCD_TO_BIN(sec);
-	BCD_TO_BIN(min);
-	BCD_TO_BIN(hour);
-	BCD_TO_BIN(day);
-	BCD_TO_BIN(mon);
-	BCD_TO_BIN(year);
-
-	year += 1900;
-	if (year < 1970)
-		year += 100;
-
-	return mktime(year, mon, day, hour, min, sec);
-}
-
-static void
-m41t00_set_tlet(ulong arg)
-{
-	struct rtc_time	tm;
-	ulong	nowtime = *(ulong *)arg;
-
-	to_tm(nowtime, &tm);
-	tm.tm_year = (tm.tm_year - 1900) % 100;
-
-	BIN_TO_BCD(tm.tm_sec);
-	BIN_TO_BCD(tm.tm_min);
-	BIN_TO_BCD(tm.tm_hour);
-	BIN_TO_BCD(tm.tm_mon);
-	BIN_TO_BCD(tm.tm_mday);
-	BIN_TO_BCD(tm.tm_year);
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
-
-		dev_warn(&save_client->dev,"m41t00: can't write to rtc chip\n");
-
-	mutex_unlock(&m41t00_mutex);
-	return;
-}
-
-static ulong	new_time;
-
-DECLARE_TASKLET_DISABLED(m41t00_tasklet, m41t00_set_tlet, (ulong)&new_time);
-
-int
-m41t00_set_rtc_time(ulong nowtime)
-{
-	new_time = nowtime;
-
-	if (in_interrupt())
-		tasklet_schedule(&m41t00_tasklet);
-	else
-		m41t00_set_tlet((ulong)&new_time);
-
-	return 0;
-}
-
-/*
- *****************************************************************************
- *
- *	Driver Interface
- *
- *****************************************************************************
- */
-static int
-m41t00_probe(struct i2c_adapter *adap, int addr, int kind)
-{
-	struct i2c_client *client;
-	int rc;
-
-	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (!client)
-		return -ENOMEM;
-
-	strncpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
-	client->addr = addr;
-	client->adapter = adap;
-	client->driver = &m41t00_driver;
-
-	if ((rc = i2c_attach_client(client)) != 0) {
-		kfree(client);
-		return rc;
-	}
-
-	save_client = client;
-	return 0;
-}
-
-static int
-m41t00_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, m41t00_probe);
-}
-
-static int
-m41t00_detach(struct i2c_client *client)
-{
-	int	rc;
-
-	if ((rc = i2c_detach_client(client)) == 0) {
-		kfree(client);
-		tasklet_kill(&m41t00_tasklet);
-	}
-	return rc;
-}
-
-static struct i2c_driver m41t00_driver = {
-	.driver = {
-		.name	= M41T00_DRV_NAME,
-	},
-	.id		= I2C_DRIVERID_STM41T00,
-	.attach_adapter	= m41t00_attach,
-	.detach_client	= m41t00_detach,
-};
-
-static int __init
-m41t00_init(void)
-{
-	return i2c_add_driver(&m41t00_driver);
-}
-
-static void __exit
-m41t00_exit(void)
-{
-	i2c_del_driver(&m41t00_driver);
-	return;
-}
-
-module_init(m41t00_init);
-module_exit(m41t00_exit);
-
-MODULE_AUTHOR("Mark A. Greer <mgreer@mvista.com>");
-MODULE_DESCRIPTION("ST Microelectronics M41T00 RTC I2C Client Driver");
-MODULE_LICENSE("GPL");
diff -Nurp linux-2.6.16-rc1-mm2/drivers/i2c/chips/m41txx.c linux-2.6.16-rc1-mm2-m41txx/drivers/i2c/chips/m41txx.c
--- linux-2.6.16-rc1-mm2/drivers/i2c/chips/m41txx.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-rc1-mm2-m41txx/drivers/i2c/chips/m41txx.c	2006-01-25 18:59:13.000000000 -0700
@@ -0,0 +1,365 @@
+/*
+ * I2C client/driver for the ST M41Txx family of i2c rtc chips.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+/*
+ * This i2c client/driver wedges between the drivers/char/genrtc.c RTC
+ * interface and the SMBus interface of the i2c subsystem.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/rtc.h>
+#include <linux/m41txx.h>
+#include <linux/bcd.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+
+#include <asm/time.h>
+#include <asm/rtc.h>
+
+static struct work_struct set_rtc_time_task;
+
+static struct i2c_driver m41txx_driver;
+static struct i2c_client *save_client;
+
+static unsigned short ignore[] = { I2C_CLIENT_END };
+static unsigned short normal_addr[] = { 0, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+	.normal_i2c	= normal_addr,
+	.probe		= ignore,
+	.ignore		= ignore,
+};
+
+struct m41txx_chip_info {
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
+static struct m41txx_chip_info m41txx_chip_info_tbl[] = {
+	{ M41TXX_TYPE_M41T00, 5, 0, 1, 2, 4, 5, 6,   0,   0,    0, 0 },
+	{ M41TXX_TYPE_M41T81, 1, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
+	{ M41TXX_TYPE_M41T85, 1, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
+};
+static struct m41txx_chip_info *m41txx_chip;
+
+unsigned long
+m41txx_get_rtc_time(void)
+{
+	s32 sec, min, hour, day, mon, year;
+	s32 sec1, min1, hour1, day1, mon1, year1;
+	u16 reads = 0;
+	u8 buf[8], msgbuf[1] = { 0 }; /* offset into rtc's regs */
+	struct i2c_msg msgs[] = {
+		{ save_client->addr, 0, 1, msgbuf },
+		{ save_client->addr, I2C_M_RD, 8, buf }
+	};
+
+	sec = min = hour = day = mon = year = 0;
+
+	do {
+		if (i2c_transfer(save_client->adapter, msgs, 2) < 0)
+			goto read_err;
+
+		sec1  = sec;
+		min1  = min;
+		hour1 = hour;
+		day1  = day;
+		mon1  = mon;
+		year1 = year;
+
+		sec  =  buf[m41txx_chip->sec]  & 0x7f;
+		min  =  buf[m41txx_chip->min]  & 0x7f;
+		hour =  buf[m41txx_chip->hour] & 0x3f;
+		day  =  buf[m41txx_chip->day]  & 0x3f;
+		mon  =  buf[m41txx_chip->mon]  & 0x1f;
+		year =  buf[m41txx_chip->year] & 0xff;
+	} while ((++reads < m41txx_chip->read_limit) && ((sec != sec1)
+			|| (min != min1) || (hour != hour1) || (day != day1)
+			|| (mon != mon1) || (year != year1)));
+
+	if ((m41txx_chip->read_limit > 1) && ((sec != sec1) || (min != min1)
+			|| (hour != hour1) || (day != day1) || (mon != mon1)
+			|| (year != year1)))
+		goto read_err;
+
+	sec  = BCD2BIN(sec);
+	min  = BCD2BIN(min);
+	hour = BCD2BIN(hour);
+	day  = BCD2BIN(day);
+	mon  = BCD2BIN(mon);
+	year = BCD2BIN(year);
+
+	year += 1900;
+	if (year < 1970)
+		year += 100;
+
+	return mktime(year, mon, day, hour, min, sec);
+
+read_err:
+	dev_err(&save_client->dev, "m41txx_get_rtc_time: Read error\n");
+	return 0;
+}
+
+static void
+m41txx_set(void *arg)
+{
+	struct rtc_time	tm;
+	int nowtime = *(int *)arg;
+	s32 sec, min, hour, day, mon, year;
+	u8 wbuf[9], *buf = &wbuf[1], msgbuf[1] = { 0 };
+	struct i2c_msg msgs[] = {
+		{ save_client->addr, 0, 1, msgbuf },
+		{ save_client->addr, I2C_M_RD, 8, buf }
+	};
+
+	to_tm(nowtime, &tm);
+	tm.tm_year = (tm.tm_year - 1900) % 100;
+
+	sec  = BIN2BCD(tm.tm_sec);
+	min  = BIN2BCD(tm.tm_min);
+	hour = BIN2BCD(tm.tm_hour);
+	day  = BIN2BCD(tm.tm_mday);
+	mon  = BIN2BCD(tm.tm_mon);
+	year = BIN2BCD(tm.tm_year);
+
+	/* Read reg values into buf[0..7]/wbuf[1..8] */
+	if (i2c_transfer(save_client->adapter, msgs, 2) < 0) {
+		dev_err(&save_client->dev, "m41txx_set: Read error\n");
+		return;
+	}
+
+	wbuf[0] = 0; /* offset into rtc's regs */
+	buf[m41txx_chip->sec]  = (buf[m41txx_chip->sec] & ~0x7f) | (sec & 0x7f);
+	buf[m41txx_chip->min]  = (buf[m41txx_chip->min] & ~0x7f) | (min & 0x7f);
+	buf[m41txx_chip->hour] = (buf[m41txx_chip->hour]& ~0x3f) | (hour& 0x3f);
+	buf[m41txx_chip->day]  = (buf[m41txx_chip->day] & ~0x3f) | (day & 0x3f);
+	buf[m41txx_chip->mon]  = (buf[m41txx_chip->mon] & ~0x1f) | (mon & 0x1f);
+
+	if (i2c_master_send(save_client, wbuf, 9) < 0)
+		dev_err(&save_client->dev, "m41txx_set: Write error\n");
+}
+
+static u32	new_time;
+
+int
+m41txx_set_rtc_time(unsigned long nowtime)
+{
+	new_time = nowtime;
+
+	if (in_interrupt())
+		schedule_work(&set_rtc_time_task);
+	else
+		m41txx_set((void *)&new_time);
+	return 0;
+}
+
+/*
+ *****************************************************************************
+ *
+ *	platform_data Driver Interface
+ *
+ *****************************************************************************
+ */
+static int __init
+m41txx_platform_probe(struct platform_device *pdev)
+{
+	struct m41txx_platform_data *pdata;
+	int i;
+
+	if (pdev && (pdata = pdev->dev.platform_data)) {
+		normal_addr[0] = pdata->i2c_addr;
+
+		for (i=0; i<ARRAY_SIZE(m41txx_chip_info_tbl); i++)
+			if (m41txx_chip_info_tbl[i].type == pdata->type) {
+				m41txx_chip = &m41txx_chip_info_tbl[i];
+				m41txx_chip->sqw_freq = pdata->sqw_freq;
+				return 0;
+			}
+	}
+	return -ENODEV;
+}
+
+static int __exit
+m41txx_platform_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver m41txx_platform_driver = {
+	.probe  = m41txx_platform_probe,
+	.remove = m41txx_platform_remove,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name  = M41TXX_DRV_NAME,
+	},
+};
+
+/*
+ *****************************************************************************
+ *
+ *	Driver Interface
+ *
+ *****************************************************************************
+ */
+static int
+m41txx_probe(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct i2c_client *client;
+	int rc;
+	u8 rbuf[1], wbuf[2], msgbuf[1] = { 0 }; /* offset into rtc's regs */
+	struct i2c_msg msgs[] = {
+		{ 0, 0, 1, msgbuf },
+		{ 0, I2C_M_RD, 1, rbuf }
+	};
+
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	strlcpy(client->name, m41txx_driver.driver.name, I2C_NAME_SIZE);
+	client->addr = addr;
+	client->adapter = adap;
+	client->driver = &m41txx_driver;
+
+	if ((rc = i2c_attach_client(client)) != 0)
+		goto attach_err;
+
+	msgs[0].addr = addr;
+	msgs[1].addr = addr;
+
+	if (m41txx_chip->type != M41TXX_TYPE_M41T00) {
+		/* If asked, set SQW frequency & enable */
+		if (m41txx_chip->sqw_freq) {
+			msgbuf[0] = m41txx_chip->alarm_mon;
+			if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
+				goto sqw_err;
+
+			wbuf[0] = m41txx_chip->alarm_mon;
+			wbuf[1] = rbuf[0] & ~0x40;
+			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
+				goto sqw_err;
+
+			wbuf[0] = m41txx_chip->sqw;
+			wbuf[1] = m41txx_chip->sqw_freq;
+			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
+				goto sqw_err;
+
+			wbuf[0] = m41txx_chip->alarm_mon;
+			wbuf[1] = rbuf[0] | 0x40;
+			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
+				goto sqw_err;
+		}
+
+		/* Make sure HT (Halt Update) bit is cleared */
+		msgbuf[0] = m41txx_chip->alarm_hour;
+		if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
+			goto ht_err;
+
+		if (rbuf[0] & 0x40) {
+			wbuf[0] = m41txx_chip->alarm_hour;
+			wbuf[1] = rbuf[0] & ~0x40;
+			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
+				goto ht_err;
+		}
+	}
+
+	/* Make sure ST (stop) bit is cleared */
+	msgbuf[0] = m41txx_chip->sec;
+	if (i2c_transfer(client->adapter, msgs, 2) < 0)
+		goto st_err;
+
+	if (rbuf[0] & 0x80) {
+		wbuf[0] = m41txx_chip->sec;
+		wbuf[1] = rbuf[0] & ~0x80;
+		if (i2c_master_send(client, wbuf, 2) < 0)
+			goto st_err;
+	}
+
+	INIT_WORK(&set_rtc_time_task, &m41txx_set, &new_time);
+	save_client = client;
+	return 0;
+
+st_err:
+	dev_err(&client->dev, "m41txx_probe: Can't clear ST bit\n");
+	goto attach_err;
+ht_err:
+	dev_err(&client->dev, "m41txx_probe: Can't clear HT bit\n");
+	goto attach_err;
+sqw_err:
+	dev_err(&client->dev, "m41txx_probe: Can't set SQW Frequency\n");
+attach_err:
+	kfree(client);
+	return rc;
+}
+
+static int
+m41txx_attach(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, m41txx_probe);
+}
+
+static int
+m41txx_detach(struct i2c_client *client)
+{
+	int	rc;
+
+	if ((rc = i2c_detach_client(client)) == 0) {
+		kfree(client);
+		flush_scheduled_work();
+	}
+	return rc;
+}
+
+static struct i2c_driver m41txx_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= M41TXX_DRV_NAME,
+	},
+	.id		= I2C_DRIVERID_STM41TXX,
+	.attach_adapter	= m41txx_attach,
+	.detach_client	= m41txx_detach,
+};
+
+static int __init
+m41txx_init(void)
+{
+	int rc;
+
+	if (!(rc = platform_driver_register(&m41txx_platform_driver)))
+		rc = i2c_add_driver(&m41txx_driver);
+	return rc;
+}
+
+static void __exit
+m41txx_exit(void)
+{
+	i2c_del_driver(&m41txx_driver);
+	platform_driver_unregister(&m41txx_platform_driver);
+}
+
+module_init(m41txx_init);
+module_exit(m41txx_exit);
+
+MODULE_AUTHOR("Mark A. Greer <mgreer@mvista.com>");
+MODULE_DESCRIPTION("ST Microelectronics M41TXX RTC I2C Client Driver");
+MODULE_LICENSE("GPL");
diff -Nurp linux-2.6.16-rc1-mm2/drivers/i2c/chips/Makefile linux-2.6.16-rc1-mm2-m41txx/drivers/i2c/chips/Makefile
--- linux-2.6.16-rc1-mm2/drivers/i2c/chips/Makefile	2006-01-17 00:44:47.000000000 -0700
+++ linux-2.6.16-rc1-mm2-m41txx/drivers/i2c/chips/Makefile	2006-01-23 18:18:26.000000000 -0700
@@ -6,7 +6,6 @@ obj-$(CONFIG_SENSORS_DS1337)	+= ds1337.o
 obj-$(CONFIG_SENSORS_DS1374)	+= ds1374.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
-obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
@@ -14,6 +13,7 @@ obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
+obj-$(CONFIG_RTC_M41TXX_I2C)	+= m41txx.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nurp linux-2.6.16-rc1-mm2/include/linux/i2c-id.h linux-2.6.16-rc1-mm2-m41txx/include/linux/i2c-id.h
--- linux-2.6.16-rc1-mm2/include/linux/i2c-id.h	2006-01-17 00:44:47.000000000 -0700
+++ linux-2.6.16-rc1-mm2-m41txx/include/linux/i2c-id.h	2006-01-23 18:18:26.000000000 -0700
@@ -79,7 +79,7 @@
 #define I2C_DRIVERID_SAA7114	49	/* video decoder		*/
 #define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
 #define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
-#define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
+#define I2C_DRIVERID_STM41TXX	52	/* real time clock		*/
 #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
 #define I2C_DRIVERID_ADV7170	54	/* video encoder		*/
 #define I2C_DRIVERID_RADEON	55	/* I2C bus on Radeon boards	*/
diff -Nurp linux-2.6.16-rc1-mm2/include/linux/m41txx.h linux-2.6.16-rc1-mm2-m41txx/include/linux/m41txx.h
--- linux-2.6.16-rc1-mm2/include/linux/m41txx.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-rc1-mm2-m41txx/include/linux/m41txx.h	2006-01-23 18:39:56.000000000 -0700
@@ -0,0 +1,47 @@
+/*
+ * Definitions for the ST M41Txx family of i2c rtc chips.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef _M41TXX_H
+#define _M41TXX_H
+
+#define	M41TXX_DRV_NAME		"m41txx rtc"
+#define	M41TXX_I2C_ADDR		0x68
+
+#define	M41TXX_TYPE_M41T00	0
+#define	M41TXX_TYPE_M41T81	81
+#define	M41TXX_TYPE_M41T85	85
+
+struct m41txx_platform_data {
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
+#endif /* _M41TXX_H */
