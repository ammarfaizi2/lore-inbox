Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVAaSH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVAaSH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVAaSH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:07:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:9465 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261290AbVAaSFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:05:35 -0500
Message-ID: <41FE7368.1000307@mvista.com>
Date: Mon, 31 Jan 2005 11:05:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: LM Sensors <sensors@stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH][I2C] ST M41T00 I2C RTC chip driver
Content-Type: multipart/mixed;
 boundary="------------050909060501030201070001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------050909060501030201070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for the ST M41T00 RTC chip.

You will likely notice that it implements a PPC-specific interface 
(/dev/rtc->drivers/char/genrtc.h->include/asm-ppc/rtc.h->this file).  
This was necessary to support a subset of ppc platforms that need to 
hook up the rtc support at runtime.  If I implemented /dev/rtc directly 
or interfaced to genrtc.c directly, those platforms couldn't use this 
driver.  Eventually, I hope to work on more uniform rtc support across 
all the processor architectures.

Also, on ppc at least, the hw clock can be set from a timer interrupt if 
STA_UNSYNC is not set (e.g., ntpd is running).  To handle this, a 
tasklet is used to set the clock if in_interrupt() is true.

I'd appreciate an comments or to have it pushed into the kernel.org tree 
if its acceptable.

Thanks,

Mark

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------050909060501030201070001
Content-Type: text/plain;
 name="m41t00.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="m41t00.patch"

diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-01-31 10:33:34 -07:00
+++ b/drivers/i2c/chips/Kconfig	2005-01-31 10:33:34 -07:00
@@ -371,4 +371,13 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called isp1301_omap.
 
+config SENSORS_M41T00
+	tristate "ST M41T00 RTC chip"
+	depends on I2C && PPC32
+	help
+	  If you say yes here you get support for the ST M41T00 RTC chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-m41t00.
+
 endmenu
diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	2005-01-31 10:33:34 -07:00
+++ b/drivers/i2c/chips/Makefile	2005-01-31 10:33:34 -07:00
@@ -26,6 +26,7 @@
 obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
+obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
diff -Nru a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/chips/m41t00.c	2005-01-31 10:33:34 -07:00
@@ -0,0 +1,224 @@
+/*
+ * drivers/i2c/chips/m41t00.c
+ *
+ * I2C client/driver for the ST M41T00 Real-Time Clock chip.
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
+ * It would be more efficient to use i2c msgs/i2c_transfer directly but, as
+ * recommened in .../Documentation/i2c/writing-clients section
+ * "Sending and receiving", using SMBus level communication is preferred.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+
+#include <asm/time.h>
+#include <asm/rtc.h>
+
+static DECLARE_MUTEX(m41t00_mutex);
+
+struct m41t00_data {
+	struct i2c_client client;
+};
+
+static struct i2c_driver m41t00_driver;
+static struct i2c_client *save_client;
+
+static unsigned short ignore[] = { I2C_CLIENT_END };
+static unsigned short normal_addr[] = { 0x68, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+	.normal_i2c		= normal_addr,
+	.normal_i2c_range	= ignore,
+	.probe			= ignore,
+	.probe_range		= ignore,
+	.ignore			= ignore,
+	.ignore_range		= ignore,
+	.force			= ignore,
+};
+
+ulong
+m41t00_get_rtc_time(void)
+{
+	s32	sec, min, hour, day, mon, year;
+
+	down(&m41t00_mutex);
+	if (((sec = i2c_smbus_read_byte_data(save_client, 0)) < 0)
+		|| ((min  = i2c_smbus_read_byte_data(save_client, 1)) < 0)
+		|| ((hour = i2c_smbus_read_byte_data(save_client, 2)) < 0)
+		|| ((day  = i2c_smbus_read_byte_data(save_client, 4)) < 0)
+		|| ((mon  = i2c_smbus_read_byte_data(save_client, 5)) < 0)
+		|| ((year = i2c_smbus_read_byte_data(save_client, 6)) < 0)) {
+
+		dev_warn(&save_client->dev, "m41t00: can't read rtc chip\n");
+		sec = min = hour = day = mon = year = 0;
+	}
+	up(&m41t00_mutex);
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
+m41t00_set_tlet(ulong arg)
+{
+	struct rtc_time	tm;
+	ulong	nowtime = *(ulong *)arg;
+
+	to_tm(nowtime, &tm);
+	tm.tm_year = (tm.tm_year - 1900) % 100;
+
+	BIN_TO_BCD(tm.tm_sec);
+	BIN_TO_BCD(tm.tm_min);
+	BIN_TO_BCD(tm.tm_hour);
+	BIN_TO_BCD(tm.tm_mon);
+	BIN_TO_BCD(tm.tm_mday);
+	BIN_TO_BCD(tm.tm_year);
+
+	down(&m41t00_mutex);
+	if ((i2c_smbus_write_byte_data(save_client, 0, tm.tm_sec & 0x7f) < 0)
+		|| (i2c_smbus_write_byte_data(save_client, 1, tm.tm_min & 0x7f)
+			< 0)
+		|| (i2c_smbus_write_byte_data(save_client, 2, tm.tm_hour & 0x7f)
+			< 0)
+		|| (i2c_smbus_write_byte_data(save_client, 4, tm.tm_mday & 0x7f)
+			< 0)
+		|| (i2c_smbus_write_byte_data(save_client, 5, tm.tm_mon & 0x7f)
+			< 0)
+		|| (i2c_smbus_write_byte_data(save_client, 6, tm.tm_year & 0x7f)
+			< 0))
+
+		dev_warn(&save_client->dev,"m41t00: can't write to rtc chip\n");
+
+	up(&m41t00_mutex);
+	return;
+}
+
+ulong	new_time;
+
+DECLARE_TASKLET_DISABLED(m41t00_tasklet, m41t00_set_tlet, (ulong)&new_time);
+
+int
+m41t00_set_rtc_time(ulong nowtime)
+{
+	new_time = nowtime;
+
+	if (in_interrupt())
+		tasklet_schedule(&m41t00_tasklet);
+	else
+		m41t00_set_tlet((ulong)&new_time);
+
+	return 0;
+}
+
+/*
+ *****************************************************************************
+ *
+ *	Driver Interface
+ *
+ *****************************************************************************
+ */
+static int __devinit
+m41t00_probe(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct i2c_client *new_client;
+	struct m41t00_data *drv_data;
+	int rc;
+
+	drv_data = kmalloc(sizeof(struct m41t00_data), GFP_KERNEL);
+	if (!drv_data)
+		return -ENOMEM;
+
+	memset(drv_data, 0, sizeof(struct m41t00_data));
+	new_client = &drv_data->client;
+
+	strncpy(new_client->name, "m41t00", I2C_NAME_SIZE);
+	i2c_set_clientdata(new_client, drv_data);
+	new_client->id = m41t00_driver.id;
+	new_client->flags = I2C_DF_NOTIFY;
+	new_client->addr = addr;
+	new_client->adapter = adap;
+	new_client->driver = &m41t00_driver;
+
+	if ((rc = i2c_attach_client(new_client)) != 0) {
+		kfree(drv_data);
+		return rc;
+	}
+
+	save_client = new_client;
+	return 0;
+}
+
+static int __devinit
+m41t00_attach(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, m41t00_probe);
+}
+
+static int __devexit
+m41t00_detach(struct i2c_client *client)
+{
+	i2c_detach_client(client);
+	kfree(i2c_get_clientdata(client));
+	tasklet_kill(&m41t00_tasklet);
+	return 0;
+}
+
+static struct i2c_driver m41t00_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "M41T00",
+	.id		= I2C_DRIVERID_STM41T00,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= m41t00_attach,
+	.detach_client	= m41t00_detach,
+};
+
+static int __devinit
+m41t00_init(void)
+{
+	return i2c_add_driver(&m41t00_driver);
+}
+
+static void __devexit
+m41t00_exit(void)
+{
+	i2c_del_driver(&m41t00_driver);
+	return;
+}
+
+module_init(m41t00_init);
+module_exit(m41t00_exit);
+
+MODULE_AUTHOR("Mark A. Greer <mgreer@mvista.com>");
+MODULE_DESCRIPTION("ST Microelectronics M41T00 RTC I2C Client Driver");
+MODULE_LICENSE("GPL");

--------------050909060501030201070001--

