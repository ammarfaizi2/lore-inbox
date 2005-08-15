Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVHORyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVHORyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVHORyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:54:41 -0400
Received: from kent.litech.org ([72.9.242.215]:15370 "EHLO kent.litech.org")
	by vger.kernel.org with ESMTP id S964868AbVHORyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:54:40 -0400
Date: Mon, 15 Aug 2005 13:54:38 -0400
From: Nathan Lutchansky <lutchann@litech.org>
To: LKML <linux-kernel@vger.kernel.org>,
       lm-sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 4/5] add i2c_probe_device and i2c_remove_device
Message-ID: <20050815175438.GE24959@litech.org>
References: <20050815175106.GA24959@litech.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815175106.GA24959@litech.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new i2c_probe_device and i2c_remove_device functions to explicitly
instantiate new i2c clients by adapter, driver id and bus address.

These functions can be used for special-purpose adapters, such as those
on TV tuner cards, where we generally know in advance what devices are
attached.  This is important in cases where the adapter does not support
probing or when probing is potentially dangerous to the connected
devices.

Signed-off-by: Nathan Lutchansky <lutchann@litech.org>

 drivers/i2c/i2c-core.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |    6 ++++
 2 files changed, 77 insertions(+)

Index: linux-2.6.13-rc6+gregkh/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/i2c-core.c
@@ -671,6 +671,75 @@ int i2c_control(struct i2c_client *clien
 }
 
 /* ----------------------------------------------------
+ * direct add/remove functions to avoid probing
+ * ----------------------------------------------------
+ */
+
+int i2c_probe_device(struct i2c_adapter *adapter, int driver_id,
+		     int addr, int kind)
+{
+	struct list_head   *item;
+	struct i2c_driver  *driver = NULL;
+
+	/* There's no way to probe addresses on this adapter... */
+	if (kind < 0 && !i2c_check_functionality(adapter,I2C_FUNC_SMBUS_QUICK))
+		return -EINVAL;
+
+	down(&core_lists);
+	list_for_each(item,&drivers) {
+		driver = list_entry(item, struct i2c_driver, list);
+		if (driver->id == driver_id)
+			break;
+	}
+	up(&core_lists);
+	if (!item)
+		return -ENOENT;
+
+	/* Already in use? */
+	if (i2c_check_addr(adapter, addr))
+		return -EBUSY;
+
+	/* Make sure there is something at this address, unless forced */
+	if (kind < 0) {
+		if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
+				   I2C_SMBUS_QUICK, NULL) < 0)
+			return -ENODEV;
+
+		/* prevent 24RF08 corruption */
+		if ((addr & ~0x0f) == 0x50)
+			i2c_smbus_xfer(adapter, addr, 0, 0, 0,
+				       I2C_SMBUS_QUICK, NULL);
+	}
+
+	return driver->detect_client(adapter, addr, kind);
+}
+
+int i2c_remove_device(struct i2c_adapter *adapter, int driver_id, int addr)
+{
+	struct list_head  *item, *_n;
+	struct i2c_client *client;
+	int res = 0;
+
+	down(&core_lists);
+
+	list_for_each_safe(item, _n, &adapter->clients) {
+		client = list_entry(item, struct i2c_client, list);
+		if (client->addr != addr || client->driver->id != driver_id)
+			continue;
+		if ((res=client->driver->detach_client(client)))
+			dev_err(&adapter->dev, "detach_client failed for "
+				"client [%s] at address 0x%02x\n",
+				client->name, client->addr);
+		goto out_unlock;
+	}
+	res = -ENOENT;
+
+ out_unlock:
+	up(&core_lists);
+	return res;
+}
+
+/* ----------------------------------------------------
  * the i2c address scanning function
  * Will not work for 10-bit addresses!
  * ----------------------------------------------------
@@ -1230,6 +1299,8 @@ EXPORT_SYMBOL(i2c_control);
 EXPORT_SYMBOL(i2c_transfer);
 EXPORT_SYMBOL(i2c_get_adapter);
 EXPORT_SYMBOL(i2c_put_adapter);
+EXPORT_SYMBOL(i2c_probe_device);
+EXPORT_SYMBOL(i2c_remove_device);
 EXPORT_SYMBOL(i2c_probe);
 
 EXPORT_SYMBOL(i2c_smbus_xfer);
Index: linux-2.6.13-rc6+gregkh/include/linux/i2c.h
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/include/linux/i2c.h
+++ linux-2.6.13-rc6+gregkh/include/linux/i2c.h
@@ -359,6 +359,12 @@ extern void i2c_clients_command(struct i
    you can cheat by simply not registering. Not recommended, of course! */
 extern int i2c_check_addr (struct i2c_adapter *adapter, int addr);
 
+/* Direct add/remove functions to create or remove clients by address. */
+extern int i2c_probe_device(struct i2c_adapter *adapter, int driver_id,
+			    int addr, int kind);
+extern int i2c_remove_device(struct i2c_adapter *adapter, int driver_id,
+			     int addr);
+
 /* Detect function. It iterates over all possible addresses itself.
  * It will only call found_proc if some client is connected at the
  * specific address (unless a 'force' matched);
