Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUHWTEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUHWTEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHWTBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:01:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:11204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267304AbUHWShD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:03 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860874161@kroah.com>
Date: Mon, 23 Aug 2004 11:34:48 -0700
Message-Id: <10932860881362@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.31, 2004/08/06 15:46:04-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Added  w1_smem.c - driver for simple 64bit ROM devices.

Added w1_smem.c - driver for simple 64bit ROM devices.
Simple iButtons with ds2401/ds2411/ds1990* are handled by this driver.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/Kconfig   |    7 +++
 drivers/w1/Makefile  |    1 
 drivers/w1/w1_smem.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)


diff -Nru a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- a/drivers/w1/Kconfig	2004-08-23 11:03:40 -07:00
+++ b/drivers/w1/Kconfig	2004-08-23 11:03:40 -07:00
@@ -28,4 +28,11 @@
 	  Say Y here if you want to connect 1-wire thermal sensors to you
 	  wire.
 
+config W1_SMEM
+	tristate "Simple 64bit memory family implementation"
+	depends on W1
+	help
+	  Say Y here if you want to connect 1-wire 
+	  simple 64bit memory rom(ds2401/ds2411/ds1990*) to you wire.
+
 endmenu
diff -Nru a/drivers/w1/Makefile b/drivers/w1/Makefile
--- a/drivers/w1/Makefile	2004-08-23 11:03:40 -07:00
+++ b/drivers/w1/Makefile	2004-08-23 11:03:40 -07:00
@@ -7,3 +7,4 @@
 
 obj-$(CONFIG_W1_MATROX)		+= matrox_w1.o
 obj-$(CONFIG_W1_THERM)		+= w1_therm.o
+obj-$(CONFIG_W1_SMEM)		+= w1_smem.o
diff -Nru a/drivers/w1/w1_smem.c b/drivers/w1/w1_smem.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_smem.c	2004-08-23 11:03:40 -07:00
@@ -0,0 +1,118 @@
+/*
+ * 	w1_smem.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the smems of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/types.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include "w1.h"
+#include "w1_io.h"
+#include "w1_int.h"
+#include "w1_family.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit memory family.");
+
+static ssize_t w1_smem_read_name(struct device *, char *);
+static ssize_t w1_smem_read_val(struct device *, char *);
+static ssize_t w1_smem_read_bin(struct kobject *, char *, loff_t, size_t);
+
+static struct w1_family_ops w1_smem_fops = {
+	.rname = &w1_smem_read_name,
+	.rbin = &w1_smem_read_bin,
+	.rval = &w1_smem_read_val,
+	.rvalname = "id",
+};
+
+static ssize_t w1_smem_read_name(struct device *dev, char *buf)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+
+	return sprintf(buf, "%s\n", sl->name);
+}
+
+static ssize_t w1_smem_read_val(struct device *dev, char *buf)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	int i;
+	ssize_t count = 0;
+	
+	for (i = 0; i < 9; ++i)
+		count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
+	count += sprintf(buf + count, "\n");
+
+	return count;
+}
+
+static ssize_t w1_smem_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
+			      			struct w1_slave, dev);
+	int i;
+
+	atomic_inc(&sl->refcnt);
+	if (down_interruptible(&sl->master->mutex)) {
+		count = 0;
+		goto out_dec;
+	}
+
+	if (off > W1_SLAVE_DATA_SIZE) {
+		count = 0;
+		goto out;
+	}
+	if (off + count > W1_SLAVE_DATA_SIZE) {
+		count = 0;
+		goto out;
+	}
+	for (i = 0; i < 9; ++i)
+		count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
+	count += sprintf(buf + count, "\n");
+	
+out:
+	up(&sl->master->mutex);
+out_dec:
+	atomic_dec(&sl->refcnt);
+
+	return count;
+}
+
+static struct w1_family w1_smem_family = {
+	.fid = W1_FAMILY_SMEM,
+	.fops = &w1_smem_fops,
+};
+
+int __init w1_smem_init(void)
+{
+	return w1_register_family(&w1_smem_family);
+}
+
+void __exit w1_smem_fini(void)
+{
+	w1_unregister_family(&w1_smem_family);
+}
+
+module_init(w1_smem_init);
+module_exit(w1_smem_fini);

