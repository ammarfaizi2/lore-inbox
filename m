Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbTCVAx7>; Fri, 21 Mar 2003 19:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261702AbTCVAx6>; Fri, 21 Mar 2003 19:53:58 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:52232 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261684AbTCVAxl>;
	Fri, 21 Mar 2003 19:53:41 -0500
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
In-reply-to: <1048295084971@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Fri, 21 Mar 2003 17:04 -0800
Message-id: <10482950852454@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1190, 2003/03/21 14:38:21-08:00, greg@kroah.com

[PATCH] i2c: remove *data from i2c_adapter, as dev->data should be used instead.


 drivers/i2c/i2c-elv.c    |    2 +-
 drivers/i2c/scx200_acb.c |    4 ++--
 include/linux/i2c.h      |   17 +++++++++++------
 3 files changed, 14 insertions(+), 9 deletions(-)


diff -Nru a/drivers/i2c/i2c-elv.c b/drivers/i2c/i2c-elv.c
--- a/drivers/i2c/i2c-elv.c	Fri Mar 21 16:53:26 2003
+++ b/drivers/i2c/i2c-elv.c	Fri Mar 21 16:53:26 2003
@@ -150,7 +150,7 @@
 			return -ENODEV;
 		}
 	} else {
-		bit_elv_ops.data=(void*)base;
+		i2c_set_adapdata(&bit_elv_ops, (void *)base);
 		if (bit_elv_init()==0) {
 			if(i2c_bit_add_bus(&bit_elv_ops) < 0)
 				return -ENODEV;
diff -Nru a/drivers/i2c/scx200_acb.c b/drivers/i2c/scx200_acb.c
--- a/drivers/i2c/scx200_acb.c	Fri Mar 21 16:53:26 2003
+++ b/drivers/i2c/scx200_acb.c	Fri Mar 21 16:53:26 2003
@@ -289,7 +289,7 @@
 				char rw, u8 command, int size, 
 				union i2c_smbus_data *data)
 {
-	struct scx200_acb_iface *iface = adapter->data;
+	struct scx200_acb_iface *iface = i2c_get_adapdata(adapter);
 	int len;
 	u8 *buffer;
 	u16 cur_word;
@@ -455,7 +455,7 @@
 
 	memset(iface, 0, sizeof(*iface));
 	adapter = &iface->adapter;
-	adapter->data = iface;
+	i2c_set_adapdata(adapter, iface);
 	snprintf(adapter->dev.name, DEVICE_NAME_SIZE, "SCx200 ACB%d", index);
 	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_ALGO_SMBUS;
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri Mar 21 16:53:26 2003
+++ b/include/linux/i2c.h	Fri Mar 21 16:53:26 2003
@@ -219,12 +219,7 @@
 	int (*client_register)(struct i2c_client *);
 	int (*client_unregister)(struct i2c_client *);
 
-	void *data;	/* private data for the adapter			*/
-			/* some data fields that are used by all types	*/
-			/* these data fields are readonly to the public	*/
-			/* and can be set via the i2c_ioctl call	*/
-
-			/* data fields that are valid for all devices	*/
+	/* data fields that are valid for all devices	*/
 	struct semaphore bus;
 	struct semaphore list;  
 	unsigned int flags;/* flags specifying div. data		*/
@@ -241,6 +236,16 @@
 #endif /* def CONFIG_PROC_FS */
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
+
+static inline void *i2c_get_adapdata (struct i2c_adapter *dev)
+{
+	return dev_get_drvdata (&dev->dev);
+}
+
+static inline void i2c_set_adapdata (struct i2c_adapter *dev, void *data)
+{
+	return dev_set_drvdata (&dev->dev, data);
+}
 
 /*flags for the driver struct: */
 #define I2C_DF_NOTIFY	0x01		/* notify on bus (de/a)ttaches 	*/

