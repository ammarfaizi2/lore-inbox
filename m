Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVLSVFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVLSVFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVLSVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:05:05 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41209 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964974AbVLSVFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:05:03 -0500
Date: Mon, 19 Dec 2005 14:03:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andrey Volkov <avolkov@varma-el.com>,
       adi@hexapodia.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: [RFC] i2c: Combined ST m41txx i2c rtc chip driver (was: [PATCH 1/1] Added support of ST m41t85 rtc chip)
Message-ID: <20051219210325.GA21696@mag.az.mvista.com>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116025714.GK5546@mag.az.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 07:57:14PM -0700, Mark A. Greer wrote:
> I think we can combine the two into an m41txx.c and pass the exact type
> in via platform_data--that would be the correct mechanism, right?
> The platform_data could also be used to seed the correct SQW freq and
> eliminate all the Kconfig noise.
> 
> Comments?
> 
> As for Jean's and Andrew's comments about the driver, they seem valid
> to me and should be addressed.  In Andrey's defense, many of them are my
> fault.  Once there is a consensus on the merging m41t00 & m41t85
> question, I'll try to get a fixed up patch within a couple weeks.

I've made what I think should be close to an acceptable driver that
supports the m41t00, m41t81, and m41t85 i2c rtc chips.  I only have hw
to test the m41t00 on a ppc platform, though.

It was suggested to me a while back to add retries when reading &
writing the rtc regs.  Personally, I think its overkill but I added the
code anyway.  You will see in m41txx_get_rtc_time() that 3 tries are
made to get a good read of all the regs then up to 10 tries are made to
make sure that the time didn't change while we were doing the reads.
Something similar is done in m41txx_set().

Andrey, would you please apply and test this patch on your 5200?

Andy, I apologize but I didn't take the time to look at the mips tree in
depth.  I did do a quick scan and I think that you should be able to set
'rtc_get_time' to 'm41txx_get_rtc_time' and 'rtc_set_time' to
'm41txx_set_rtc_time', and it'll work.  You'll have to hook up the proper
driver for your host i2c ctlr, though.

Jean, Andrew, I think I addressed your coding style, etc. issues with
the driver.  If not, just point out the problems an I'll fix them.

The patch is against the 2.6.15-rc5-mm3 tree.  Comments welcome.

[I will send a second patch that contains the changes I made to the ppc
katana platform that has the m41t00 that I tested with.]

Thanks,

Mark
---
 drivers/i2c/chips/Kconfig  |   19 +-
 drivers/i2c/chips/Makefile |    2 
 drivers/i2c/chips/m41t00.c |  240 --------------------------------
 drivers/i2c/chips/m41txx.c |  336 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h     |    2 
 include/linux/m41txx.h     |   28 +++
 6 files changed, 376 insertions(+), 251 deletions(-)
---
diff -Nurp linux-2.6.15-rc5-mm3.orig/drivers/i2c/chips/Kconfig linux-2.6.15-rc5-mm3-m41txx/drivers/i2c/chips/Kconfig
--- linux-2.6.15-rc5-mm3.orig/drivers/i2c/chips/Kconfig	2005-12-03 22:10:42.000000000 -0700
+++ linux-2.6.15-rc5-mm3-m41txx/drivers/i2c/chips/Kconfig	2005-12-19 13:16:25.000000000 -0700
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
+	  will be called m41t00.
+
 endmenu
diff -Nurp linux-2.6.15-rc5-mm3.orig/drivers/i2c/chips/m41t00.c linux-2.6.15-rc5-mm3-m41txx/drivers/i2c/chips/m41t00.c
--- linux-2.6.15-rc5-mm3.orig/drivers/i2c/chips/m41t00.c	2005-12-19 13:04:07.000000000 -0700
+++ linux-2.6.15-rc5-mm3-m41txx/drivers/i2c/chips/m41t00.c	1969-12-31 17:00:00.000000000 -0700
@@ -1,240 +0,0 @@
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
-
-#include <asm/time.h>
-#include <asm/rtc.h>
-
-#define	M41T00_DRV_NAME		"m41t00"
-
-static DECLARE_MUTEX(m41t00_mutex);
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
-	down(&m41t00_mutex);
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
-	up(&m41t00_mutex);
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
-	down(&m41t00_mutex);
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
-	up(&m41t00_mutex);
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
diff -Nurp linux-2.6.15-rc5-mm3.orig/drivers/i2c/chips/m41txx.c linux-2.6.15-rc5-mm3-m41txx/drivers/i2c/chips/m41txx.c
--- linux-2.6.15-rc5-mm3.orig/drivers/i2c/chips/m41txx.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.15-rc5-mm3-m41txx/drivers/i2c/chips/m41txx.c	2005-12-19 13:16:26.000000000 -0700
@@ -0,0 +1,336 @@
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
+static DECLARE_MUTEX(m41txx_mutex);
+
+static struct work_struct set_rtc_time_task;
+
+static struct i2c_driver m41txx_driver;
+static struct i2c_client *save_client;
+
+static unsigned short ignore[] = { I2C_CLIENT_END };
+static unsigned short normal_addr[] = { 0, /* replaced w/ platform_data */
+	I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+	.normal_i2c	= normal_addr,
+	.probe		= ignore,
+	.ignore		= ignore,
+};
+
+struct m41txx_chip_info {
+	u16	type;
+	u8	sec;	/* Offsets for chip regs */
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
+	{ M41TXX_TYPE_M41T00, 0, 1, 2, 4, 5, 6, 0, 0, 0, 0 },
+	{ M41TXX_TYPE_M41T81, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
+	{ M41TXX_TYPE_M41T85, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
+};
+static struct m41txx_chip_info *m41txx_chip;
+
+#define	M41TXX_MAX_RETRIES	3 /* Really 1 try + 2 retries */
+
+unsigned long
+m41txx_get_rtc_time(void)
+{
+	s32	sec, min, hour, day, mon, year;
+	s32	sec1, min1, hour1, day1, mon1, year1;
+	u32	retries, limit = 10;
+
+	sec = min = hour = day = mon = year = 0;
+	sec1 = min1 = hour1 = day1 = mon1 = year1 = 0;
+
+	down(&m41txx_mutex);
+	do {
+		retries = M41TXX_MAX_RETRIES;
+
+		do {
+			if (((sec = i2c_smbus_read_byte_data(save_client,
+						m41txx_chip->sec)) >= 0)
+				&& ((min = i2c_smbus_read_byte_data(save_client,
+						m41txx_chip->min)) >= 0)
+				&& ((hour= i2c_smbus_read_byte_data(save_client,
+						m41txx_chip->hour)) >= 0)
+				&& ((day = i2c_smbus_read_byte_data(save_client,
+						m41txx_chip->day)) >= 0)
+				&& ((mon = i2c_smbus_read_byte_data(save_client,
+						m41txx_chip->mon)) >= 0)
+				&& ((year= i2c_smbus_read_byte_data(save_client,
+						m41txx_chip->year)) >= 0))
+				break;
+		} while (--retries > 0);
+
+		if ((retries == 0) || ((sec == sec1) && (min == min1)
+				&& (hour == hour1) && (day == day1)
+				&& (mon == mon1) && (year == year1)))
+			break;
+
+		sec1 = sec;
+		min1 = min;
+		hour1 = hour;
+		day1 = day;
+		mon1 = mon;
+		year1 = year;
+	} while (--limit > 0);
+	up(&m41txx_mutex);
+
+	if ((limit == 0) || (retries == 0)) {
+		if (limit == 0)
+			dev_warn(&save_client->dev,
+				"m41txx: can't read rtc chip\n");
+		sec = min = hour = day = mon = year = 0;
+	}
+
+	sec &= 0x7f;
+	min &= 0x7f;
+	hour &= 0x3f;
+	day &= 0x3f;
+	mon &= 0x1f;
+	year &= 0xff;
+
+	BCD_TO_BIN(sec);
+	BCD_TO_BIN(min);
+	BCD_TO_BIN(hour);
+	BCD_TO_BIN(day);
+	BCD_TO_BIN(mon);
+	BCD_TO_BIN(year);
+
+	year += 1900;
+	if (year < 1970)
+		year += 100;
+
+	return mktime(year, mon, day, hour, min, sec);
+}
+
+static void
+m41txx_set(void *arg)
+{
+	struct rtc_time	tm;
+	int	nowtime = *(int *)arg;
+	u32	retries = M41TXX_MAX_RETRIES;
+
+	to_tm(nowtime, &tm);
+	tm.tm_year = (tm.tm_year - 1900) % 100;
+
+	BIN_TO_BCD(tm.tm_sec);
+	BIN_TO_BCD(tm.tm_min);
+	BIN_TO_BCD(tm.tm_hour);
+	BIN_TO_BCD(tm.tm_mday);
+	BIN_TO_BCD(tm.tm_mon);
+	BIN_TO_BCD(tm.tm_year);
+
+	down(&m41txx_mutex);
+
+	do {
+		if ((i2c_smbus_write_byte_data(save_client,
+				m41txx_chip->sec, tm.tm_sec   & 0x7f) == 0)
+			&& (i2c_smbus_write_byte_data(save_client,
+				m41txx_chip->min, tm.tm_min   & 0x7f) == 0)
+			&& (i2c_smbus_write_byte_data(save_client,
+				m41txx_chip->hour, tm.tm_hour & 0x3f) == 0)
+			&& (i2c_smbus_write_byte_data(save_client,
+				m41txx_chip->day, tm.tm_mday  & 0x3f) == 0)
+			&& (i2c_smbus_write_byte_data(save_client,
+				m41txx_chip->mon, tm.tm_mon   & 0x1f) == 0)
+			&& (i2c_smbus_write_byte_data(save_client,
+				m41txx_chip->year, tm.tm_year & 0xff) == 0))
+			break;
+	} while (--retries > 0);
+
+	if (retries == 0)
+		dev_warn(&save_client->dev,"m41txx: can't write to rtc chip\n");
+
+	up(&m41txx_mutex);
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
+		goto probe_err;
+
+	/* Sst SQW frequency & enable */
+	if ((m41txx_chip->type != M41TXX_TYPE_M41T00) && m41txx_chip->sqw_freq
+			&& ((rc = i2c_smbus_read_byte_data(client,
+				m41txx_chip->alarm_mon)) >= 0)
+			&& !(rc & 0x40) && !(i2c_smbus_write_byte_data(
+				client,m41txx_chip->sqw,m41txx_chip->sqw_freq)))
+		i2c_smbus_write_byte_data(client, m41txx_chip->alarm_mon,
+			rc | 0x40);
+
+	/* Make sure oscillator is running (i.e., clear 'ST' bit in sec reg) */
+	if (((rc = i2c_smbus_read_byte_data(client, m41txx_chip->sec)) < 0)
+			|| ((rc & 0x80) && ((rc = i2c_smbus_write_byte_data(
+				client, m41txx_chip->sec, rc & 0x7f)) < 0)))
+		goto probe_err;
+
+	INIT_WORK(&set_rtc_time_task, &m41txx_set, &new_time);
+	save_client = client;
+	return 0;
+
+probe_err:
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
diff -Nurp linux-2.6.15-rc5-mm3.orig/drivers/i2c/chips/Makefile linux-2.6.15-rc5-mm3-m41txx/drivers/i2c/chips/Makefile
--- linux-2.6.15-rc5-mm3.orig/drivers/i2c/chips/Makefile	2005-12-03 22:10:42.000000000 -0700
+++ linux-2.6.15-rc5-mm3-m41txx/drivers/i2c/chips/Makefile	2005-12-19 13:16:26.000000000 -0700
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
diff -Nurp linux-2.6.15-rc5-mm3.orig/include/linux/i2c-id.h linux-2.6.15-rc5-mm3-m41txx/include/linux/i2c-id.h
--- linux-2.6.15-rc5-mm3.orig/include/linux/i2c-id.h	2005-12-19 13:04:29.000000000 -0700
+++ linux-2.6.15-rc5-mm3-m41txx/include/linux/i2c-id.h	2005-12-19 13:16:26.000000000 -0700
@@ -85,7 +85,7 @@
 #define I2C_DRIVERID_SAA7114	49	/* video decoder		*/
 #define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
 #define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
-#define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
+#define I2C_DRIVERID_STM41TXX	52	/* real time clock		*/
 #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
 #define I2C_DRIVERID_ADV7170	54	/* video encoder		*/
 #define I2C_DRIVERID_RADEON	55	/* I2C bus on Radeon boards	*/
diff -Nurp linux-2.6.15-rc5-mm3.orig/include/linux/m41txx.h linux-2.6.15-rc5-mm3-m41txx/include/linux/m41txx.h
--- linux-2.6.15-rc5-mm3.orig/include/linux/m41txx.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.15-rc5-mm3-m41txx/include/linux/m41txx.h	2005-12-19 13:16:26.000000000 -0700
@@ -0,0 +1,28 @@
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
+#endif /* _M41TXX_H */
