Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUJTAmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUJTAmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270211AbUJTAjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:39:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:17588 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268036AbUJTATf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:35 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315034183@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:23 -0700
Message-Id: <10982315032767@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.73.3, 2004/09/08 12:34:34-07:00, mhoffman@lightlink.com

[PATCH] I2C/SMBus stub for driver testing

* Greg KH <greg@kroah.com> [2004-08-24 16:44:32 -0700]:
> > > Why not?  It looks useful to me.  Care to send me a patch adding
> > > this to the main kernel tree?

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-08-25 10:25:02 -0400]:
> Later today, sure.

Well here it is, one day later because I really didn't want to do this
with printk.  I spent some time looking around and relayfs seems like
a good fit.  Do you think relayfs will ever get merged?  Meanwhile...

* * * * *

This patch, applied to 2.6.9-rc1, adds an I2C/SMBus test stub that is useful
for developing sensors drivers.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/i2c-stub    |   33 +++++++++++
 drivers/i2c/busses/Kconfig    |   13 ++++
 drivers/i2c/busses/Makefile   |    1 
 drivers/i2c/busses/i2c-stub.c |  125 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)


diff -Nru a/Documentation/i2c/i2c-stub b/Documentation/i2c/i2c-stub
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/i2c-stub	2004-10-19 16:55:52 -07:00
@@ -0,0 +1,33 @@
+MODULE: i2c-stub
+
+DESCRIPTION:
+
+This module is a very simple fake I2C/SMBus driver.  It implements three
+types of SMBus commands: write quick, (r/w) byte data, and (r/w) word data.
+
+No hardware is needed nor associated with this module.  It will accept write
+quick commands to all addresses; it will respond to the other commands (also
+to all addresses) by reading from or writing to an array in memory.  It will
+also spam the kernel logs for every command it handles.
+
+The typical use-case is like this:
+	1. load this module
+	2. use i2cset (from lm_sensors project) to pre-load some data
+	3. load the target sensors chip driver module
+	4. observe its behavior in the kernel log
+
+CAVEATS:
+
+There are independent arrays for byte/data and word/data commands.  Depending
+on if/how a target driver mixes them, you'll need to be careful.
+
+If your target driver polls some byte or word waiting for it to change, the
+stub could lock it up.  Use i2cset to unlock it.
+
+If the hardware for your driver has banked registers (e.g. Winbond sensors
+chips) this module will not work well - although it could be extended to
+support that pretty easily.
+
+If you spam it hard enough, printk can be lossy.  This module really wants
+something like relayfs.
+
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2004-10-19 16:55:52 -07:00
+++ b/drivers/i2c/busses/Kconfig	2004-10-19 16:55:52 -07:00
@@ -376,6 +376,19 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-sis96x.
 
+config I2C_STUB
+	tristate "I2C/SMBus Test Stub"
+	depends on I2C && EXPERIMENTAL && 'm'
+	default 'n'
+	help
+	  This module may be useful to developers of SMBus client drivers,
+	  especially for certain kinds of sensor chips.
+
+	  If you do build this module, be sure to read the notes and warnings
+	  in Documentation/i2c/i2c-stub.
+
+	  If you don't know what to do here, definitely say N.
+
 config I2C_VIA
 	tristate "VIA 82C586B"
 	depends on I2C && PCI && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	2004-10-19 16:55:52 -07:00
+++ b/drivers/i2c/busses/Makefile	2004-10-19 16:55:52 -07:00
@@ -30,6 +30,7 @@
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
 obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
+obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
diff -Nru a/drivers/i2c/busses/i2c-stub.c b/drivers/i2c/busses/i2c-stub.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/busses/i2c-stub.c	2004-10-19 16:55:52 -07:00
@@ -0,0 +1,125 @@
+/*
+    i2c-stub.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+
+    Copyright (c) 2004 Mark M. Hoffman <mhoffman@lightlink.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#define DEBUG 1
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+
+static u8  stub_bytes[256];
+static u16 stub_words[256];
+
+/* Return -1 on error. */
+static s32 stub_xfer(struct i2c_adapter * adap, u16 addr, unsigned short flags,
+	char read_write, u8 command, int size, union i2c_smbus_data * data)
+{
+	s32 ret;
+
+	switch (size) {
+
+	case I2C_SMBUS_QUICK:
+		dev_dbg(&adap->dev, "smbus quick - addr 0x%02x\n", addr);
+		ret = 0;
+		break;
+
+	case I2C_SMBUS_BYTE_DATA:
+		if (read_write == I2C_SMBUS_WRITE) {
+			stub_bytes[command] = data->byte;
+			dev_dbg(&adap->dev, "smbus byte data - addr 0x%02x, "
+					"wrote 0x%02x at 0x%02x.\n",
+					addr, data->byte, command);
+		} else {
+			data->byte = stub_bytes[command];
+			dev_dbg(&adap->dev, "smbus byte data - addr 0x%02x, "
+					"read  0x%02x at 0x%02x.\n",
+					addr, data->byte, command);
+		}
+
+		ret = 0;
+		break;
+
+	case I2C_SMBUS_WORD_DATA:
+		if (read_write == I2C_SMBUS_WRITE) {
+			stub_words[command] = data->word;
+			dev_dbg(&adap->dev, "smbus word data - addr 0x%02x, "
+					"wrote 0x%04x at 0x%02x.\n",
+					addr, data->word, command);
+		} else {
+			data->word = stub_words[command];
+			dev_dbg(&adap->dev, "smbus word data - addr 0x%02x, "
+					"read  0x%04x at 0x%02x.\n",
+					addr, data->word, command);
+		}
+
+		ret = 0;
+		break;
+
+	default:
+		dev_dbg(&adap->dev, "Unsupported I2C/SMBus command\n");
+		ret = -1;
+		break;
+	} /* switch (size) */
+
+	return ret;
+}
+
+static u32 stub_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA;
+}
+
+static struct i2c_algorithm smbus_algorithm = {
+	.name		= "Non-I2C SMBus adapter",
+	.id		= I2C_ALGO_SMBUS,
+	.functionality	= stub_func,
+	.smbus_xfer	= stub_xfer,
+};
+
+static struct i2c_adapter stub_adapter = {
+	.owner		= THIS_MODULE,
+	.class		= I2C_CLASS_HWMON,
+	.algo		= &smbus_algorithm,
+	.name		= "SMBus stub driver",
+};
+
+static int __init i2c_stub_init(void)
+{
+	printk(KERN_INFO "i2c-stub loaded\n");
+	return i2c_add_adapter(&stub_adapter);
+}
+
+static void __exit i2c_stub_exit(void)
+{
+	i2c_del_adapter(&stub_adapter);
+}
+
+MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
+MODULE_DESCRIPTION("I2C stub driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_stub_init);
+module_exit(i2c_stub_exit);
+

