Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVFVKRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVFVKRT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVFVHhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:37:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:54939 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262758AbVFVFVs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:48 -0400
Cc: rvinson@mvista.com
Subject: [PATCH] I2C: Add support for Maxim/Dallas DS1374 Real-Time Clock Chip (1/2)
In-Reply-To: <1119417468250@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:48 -0700
Message-Id: <11194174683773@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Add support for Maxim/Dallas DS1374 Real-Time Clock Chip (1/2)

Add support for Maxim/Dallas DS1374 Real-Time Clock Chip

This change adds support for the Maxim/Dallas DS1374 RTC chip. This chip
is an I2C-based RTC that maintains a simple 32-bit binary seconds count
with battery backup support.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c124a78d8c7475ecc43f385f34112b638c4228d9
tree 46de795c5e2da258a54501658f74e9619c271527
parent 69dd204b6b45987dbf9ce7058cd238d355865281
author Randy Vinson <rvinson@mvista.com> Fri, 03 Jun 2005 14:36:06 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:06 -0700

 drivers/i2c/chips/Kconfig  |   11 ++
 drivers/i2c/chips/Makefile |    1 
 drivers/i2c/chips/ds1374.c |  266 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h     |    1 
 4 files changed, 279 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -417,6 +417,17 @@ config SENSORS_DS1337
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1337.
 
+config SENSORS_DS1374
+	tristate "Maxim/Dallas Semiconductor DS1374 Real Time Clock"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Dallas Semiconductor
+	  DS1374 real-time clock chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ds1374.
+
 config SENSORS_EEPROM
 	tristate "EEPROM reader"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031
 obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_DS1337)	+= ds1337.o
+obj-$(CONFIG_SENSORS_DS1374)	+= ds1374.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
new file mode 100644
--- /dev/null
+++ b/drivers/i2c/chips/ds1374.c
@@ -0,0 +1,266 @@
+/*
+ * drivers/i2c/chips/ds1374.c
+ *
+ * I2C client/driver for the Maxim/Dallas DS1374 Real-Time Clock
+ *
+ * Author: Randy Vinson <rvinson@mvista.com>
+ *
+ * Based on the m41t00.c by Mark Greer <mgreer@mvista.com>
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
+#define DS1374_REG_TOD0		0x00
+#define DS1374_REG_TOD1		0x01
+#define DS1374_REG_TOD2		0x02
+#define DS1374_REG_TOD3		0x03
+#define DS1374_REG_WDALM0	0x04
+#define DS1374_REG_WDALM1	0x05
+#define DS1374_REG_WDALM2	0x06
+#define DS1374_REG_CR		0x07
+#define DS1374_REG_SR		0x08
+#define DS1374_REG_SR_OSF	0x80
+#define DS1374_REG_TCR		0x09
+
+#define	DS1374_DRV_NAME		"ds1374"
+
+static DECLARE_MUTEX(ds1374_mutex);
+
+static struct i2c_driver ds1374_driver;
+static struct i2c_client *save_client;
+
+static unsigned short ignore[] = { I2C_CLIENT_END };
+static unsigned short normal_addr[] = { 0x68, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+	.normal_i2c = normal_addr,
+	.normal_i2c_range = ignore,
+	.probe = ignore,
+	.probe_range = ignore,
+	.ignore = ignore,
+	.ignore_range = ignore,
+	.force = ignore,
+};
+
+static ulong ds1374_read_rtc(void)
+{
+	ulong time = 0;
+	int reg = DS1374_REG_WDALM0;
+
+	while (reg--) {
+		s32 tmp;
+		if ((tmp = i2c_smbus_read_byte_data(save_client, reg)) < 0) {
+			dev_warn(&save_client->dev,
+				 "can't read from rtc chip\n");
+			return 0;
+		}
+		time = (time << 8) | (tmp & 0xff);
+	}
+	return time;
+}
+
+static void ds1374_write_rtc(ulong time)
+{
+	int reg;
+
+	for (reg = DS1374_REG_TOD0; reg < DS1374_REG_WDALM0; reg++) {
+		if (i2c_smbus_write_byte_data(save_client, reg, time & 0xff)
+		    < 0) {
+			dev_warn(&save_client->dev,
+				 "can't write to rtc chip\n");
+			break;
+		}
+		time = time >> 8;
+	}
+}
+
+static void ds1374_check_rtc_status(void)
+{
+	s32 tmp;
+
+	tmp = i2c_smbus_read_byte_data(save_client, DS1374_REG_SR);
+	if (tmp < 0) {
+		dev_warn(&save_client->dev,
+			 "can't read status from rtc chip\n");
+		return;
+	}
+	if (tmp & DS1374_REG_SR_OSF) {
+		dev_warn(&save_client->dev,
+			 "oscillator discontinuity flagged, time unreliable\n");
+		tmp &= ~DS1374_REG_SR_OSF;
+		tmp = i2c_smbus_write_byte_data(save_client, DS1374_REG_SR,
+						tmp & 0xff);
+		if (tmp < 0)
+			dev_warn(&save_client->dev,
+				 "can't clear discontinuity notification\n");
+	}
+}
+
+ulong ds1374_get_rtc_time(void)
+{
+	ulong t1, t2;
+	int limit = 10;		/* arbitrary retry limit */
+
+	down(&ds1374_mutex);
+
+	/*
+	 * Since the reads are being performed one byte at a time using
+	 * the SMBus vs a 4-byte i2c transfer, there is a chance that a
+	 * carry will occur during the read. To detect this, 2 reads are
+	 * performed and compared.
+	 */
+	do {
+		t1 = ds1374_read_rtc();
+		t2 = ds1374_read_rtc();
+	} while (t1 != t2 && limit--);
+
+	up(&ds1374_mutex);
+
+	if (t1 != t2) {
+		dev_warn(&save_client->dev,
+			 "can't get consistent time from rtc chip\n");
+		t1 = 0;
+	}
+
+	return t1;
+}
+
+static void ds1374_set_tlet(ulong arg)
+{
+	ulong t1, t2;
+	int limit = 10;		/* arbitrary retry limit */
+
+	t1 = *(ulong *) arg;
+
+	down(&ds1374_mutex);
+
+	/*
+	 * Since the writes are being performed one byte at a time using
+	 * the SMBus vs a 4-byte i2c transfer, there is a chance that a
+	 * carry will occur during the write. To detect this, the write
+	 * value is read back and compared.
+	 */
+	do {
+		ds1374_write_rtc(t1);
+		t2 = ds1374_read_rtc();
+	} while (t1 != t2 && limit--);
+
+	up(&ds1374_mutex);
+
+	if (t1 != t2)
+		dev_warn(&save_client->dev,
+			 "can't confirm time set from rtc chip\n");
+}
+
+ulong new_time;
+
+DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet, (ulong) & new_time);
+
+int ds1374_set_rtc_time(ulong nowtime)
+{
+	new_time = nowtime;
+
+	if (in_interrupt())
+		tasklet_schedule(&ds1374_tasklet);
+	else
+		ds1374_set_tlet((ulong) & new_time);
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
+static int ds1374_probe(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct i2c_client *client;
+	int rc;
+
+	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	memset(client, 0, sizeof(struct i2c_client));
+	strncpy(client->name, DS1374_DRV_NAME, I2C_NAME_SIZE);
+	client->flags = I2C_DF_NOTIFY;
+	client->addr = addr;
+	client->adapter = adap;
+	client->driver = &ds1374_driver;
+
+	if ((rc = i2c_attach_client(client)) != 0) {
+		kfree(client);
+		return rc;
+	}
+
+	save_client = client;
+
+	ds1374_check_rtc_status();
+
+	return 0;
+}
+
+static int ds1374_attach(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, ds1374_probe);
+}
+
+static int ds1374_detach(struct i2c_client *client)
+{
+	int rc;
+
+	if ((rc = i2c_detach_client(client)) == 0) {
+		kfree(i2c_get_clientdata(client));
+		tasklet_kill(&ds1374_tasklet);
+	}
+	return rc;
+}
+
+static struct i2c_driver ds1374_driver = {
+	.owner = THIS_MODULE,
+	.name = DS1374_DRV_NAME,
+	.id = I2C_DRIVERID_DS1374,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = ds1374_attach,
+	.detach_client = ds1374_detach,
+};
+
+static int __init ds1374_init(void)
+{
+	return i2c_add_driver(&ds1374_driver);
+}
+
+static void __exit ds1374_exit(void)
+{
+	i2c_del_driver(&ds1374_driver);
+}
+
+module_init(ds1374_init);
+module_exit(ds1374_exit);
+
+MODULE_AUTHOR("Randy Vinson <rvinson@mvista.com>");
+MODULE_DESCRIPTION("Maxim/Dallas DS1374 RTC I2C Client Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -108,6 +108,7 @@
 #define I2C_DRIVERID_TDA7313	62	/* TDA7313 audio processor	*/
 #define I2C_DRIVERID_MAX6900	63	/* MAX6900 real-time clock	*/
 #define I2C_DRIVERID_SAA7114H	64	/* video decoder		*/
+#define I2C_DRIVERID_DS1374	65	/* DS1374 real time clock	*/
 
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/

