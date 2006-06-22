Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWFVSa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWFVSa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWFVSa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:30:28 -0400
Received: from ns.suse.de ([195.135.220.2]:1162 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030189AbWFVSaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:30:23 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/14] [PATCH] w1: Added default generic read/write operations.
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:05 -0700
Message-Id: <11510008381000-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <20060622182645.GB5668@kroah.com>
References: <20060622182645.GB5668@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

Special file in each w1 slave device's directory called "rw" is created
each time new slave and no appropriate w1 family is registered.
"rw" file supports read and write operations, which allows to perform
almost any kind of operations. Each logical operation is a transaction
in nature, which can contain several (two or one) low-level operations.
Let's see how one can read EEPROM context:
1. one must write control buffer, i.e. buffer containing command byte
and two byte address. At this step bus is reset and appropriate device
is selected using either W1_SKIP_ROM or W1_MATCH_ROM command.
Then provided control buffer is being written to the wire.
2. reading. This will issue reading eeprom response.

It is possible that between 1. and 2. w1 master thread will reset bus for
searching and slave device will be even removed, but in this case 0xff will
be read, since no device was selected.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/w1/w1.generic |   18 +++++++++--
 drivers/w1/w1.c             |   69 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/w1/w1.h             |    2 +
 3 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/Documentation/w1/w1.generic b/Documentation/w1/w1.generic
index f937fbe..4c6509d 100644
--- a/Documentation/w1/w1.generic
+++ b/Documentation/w1/w1.generic
@@ -27,8 +27,19 @@ When a w1 master driver registers with t
 
 When a device is found on the bus, w1 core checks if driver for it's family is
 loaded. If so, the family driver is attached to the slave.
-If there is no driver for the family, a simple sysfs entry is created
-for the slave device.
+If there is no driver for the family, default one is assigned, which allows to perform
+almost any kind of operations. Each logical operation is a transaction
+in nature, which can contain several (two or one) low-level operations.
+Let's see how one can read EEPROM context:
+1. one must write control buffer, i.e. buffer containing command byte
+and two byte address. At this step bus is reset and appropriate device
+is selected using either W1_SKIP_ROM or W1_MATCH_ROM command.
+Then provided control buffer is being written to the wire.
+2. reading. This will issue reading eeprom response.
+
+It is possible that between 1. and 2. w1 master thread will reset bus for searching
+and slave device will be even removed, but in this case 0xff will
+be read, since no device was selected.
 
 
 W1 device families
@@ -89,4 +100,5 @@ driver             - (standard) symlink 
 name               - the device name, usually the same as the directory name
 w1_slave           - (optional) a binary file whose meaning depends on the
                      family driver
-
+rw		   - (optional) created for slave devices which do not have
+		     appropriate family driver. Allows to read/write binary data.
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index a698b51..c9486c1 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -139,7 +139,74 @@ static struct bin_attribute w1_slave_att
 };
 
 /* Default family */
-static struct w1_family w1_default_family;
+
+static ssize_t w1_default_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+
+	if (down_interruptible(&sl->master->mutex)) {
+		count = 0;
+		goto out;
+	}
+
+	if (w1_reset_select_slave(sl)) {
+		count = 0;
+		goto out_up;
+	}
+
+	w1_write_block(sl->master, buf, count);
+
+out_up:
+	up(&sl->master->mutex);
+out:
+	return count;
+}
+
+static ssize_t w1_default_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+
+	if (down_interruptible(&sl->master->mutex)) {
+		count = 0;
+		goto out;
+	}
+
+	w1_read_block(sl->master, buf, count);
+
+	up(&sl->master->mutex);
+out:
+	return count;
+}
+
+static struct bin_attribute w1_default_attr = {
+      .attr = {
+              .name = "rw",
+              .mode = S_IRUGO | S_IWUSR,
+              .owner = THIS_MODULE,
+      },
+      .size = PAGE_SIZE,
+      .read = w1_default_read,
+      .write = w1_default_write,
+};
+
+static int w1_default_add_slave(struct w1_slave *sl)
+{
+	return sysfs_create_bin_file(&sl->dev.kobj, &w1_default_attr);
+}
+
+static void w1_default_remove_slave(struct w1_slave *sl)
+{
+	sysfs_remove_bin_file(&sl->dev.kobj, &w1_default_attr);
+}
+
+static struct w1_family_ops w1_default_fops = {
+	.add_slave	= w1_default_add_slave,
+	.remove_slave	= w1_default_remove_slave,
+};
+
+static struct w1_family w1_default_family = {
+	.fops = &w1_default_fops,
+};
 
 static int w1_uevent(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size);
 
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index 5698050..02e8cad 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -60,7 +60,7 @@ #define W1_READ_ROM		0x33
 #define W1_READ_PSUPPLY		0xB4
 #define W1_MATCH_ROM		0x55
 
-#define W1_SLAVE_ACTIVE		(1<<0)
+#define W1_SLAVE_ACTIVE		0
 
 struct w1_slave
 {
-- 
1.4.0

