Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVDGXYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVDGXYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVDGXWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:22:08 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:49835 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262596AbVDGXTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:19:14 -0400
Date: Fri, 8 Apr 2005 01:19:04 +0200
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: [PATCH] ds1337 4/4
Message-ID: <20050407231904.GE27226@orphique>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407211839.GA5357@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407211839.GA5357@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DS1339. The only difference against DS1337 is Trickle
Charge register at address 10h, which is used to enable battery or gold
cap charging. Please note that value may vary for different batteries,
so it should be made module parameter. 0xaa is sane default and also
matches my board ;-)

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-04-08 00:47:15.655878832 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-04-08 01:10:41.662133392 +0200
@@ -31,6 +31,7 @@
 #define DS1337_REG_MONTH	5
 #define DS1337_REG_CONTROL	14
 #define DS1337_REG_STATUS	15
+#define DS1339_REG_CHARGE	16
 
 /* FIXME - how do we export these interface constants? */
 #define DS1337_GET_DATE		0
@@ -42,7 +43,7 @@
 static unsigned short normal_i2c[] = { 0x68, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
-SENSORS_INSMOD_1(ds1337);
+SENSORS_INSMOD_2(ds1337, ds1339);
 
 static int ds1337_attach_adapter(struct i2c_adapter *adapter);
 static int ds1337_detect(struct i2c_adapter *adapter, int address, int kind);
@@ -78,6 +79,8 @@ struct ds1337_data {
 static int ds1337_id;
 static LIST_HEAD(ds1337_clients);
 
+static int ds1339_charge = 0xaa;
+
 static inline int ds1337_read(struct i2c_client *client, u8 reg, u8 *value)
 {
 	s32 tmp = i2c_smbus_read_byte_data(client, reg);
@@ -90,6 +93,37 @@ static inline int ds1337_read(struct i2c
 	return 0;
 }
 
+/* 
+ * DS1339 has Trickle Charge register at address 10h. During a multibyte
+ * access, when the address pointer reaches the end of the register space,
+ * it wraps around to location 00h.
+ * We read 17 bytes from device and compare first and last one. If they are
+ * same it is most likely DS1337 chip.
+ */
+static int ds1337_is_ds1339(struct i2c_client *client)
+{
+	char buf[17], addr = 0;
+	struct i2c_msg msg[2];
+	int result;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = &addr;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = sizeof(buf);
+	msg[1].buf = buf;
+
+	result = i2c_transfer(client->adapter, msg, 2);
+	if (result < 0) {
+		dev_err(&client->dev, "error reading data! %d\n", result);
+		return 0;
+	} else
+		return (buf[0] == buf[16]) ? 0 : 1;
+}
+
 /*
  * Chip access functions
  */
@@ -246,7 +280,7 @@ static int ds1337_detect(struct i2c_adap
 	struct i2c_client *new_client;
 	struct ds1337_data *data;
 	int err = 0;
-	const char *name = "";
+	const char *name;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_I2C))
@@ -318,11 +352,24 @@ static int ds1337_detect(struct i2c_adap
 		    (data & 0x60))
 			goto exit_free;
 
-		kind = ds1337;
+		/* Check whenever we have DS1339 */
+		if (ds1337_is_ds1339(new_client))
+			kind = ds1339;
+		else
+			kind = ds1337;
+
 	}
 
-	if (kind == ds1337)
+	switch (kind) {
+	case ds1337:
 		name = "ds1337";
+		break;
+	case ds1339:
+		name = "ds1339";
+		break;
+	default:
+		name = "";
+	}
 
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
@@ -334,6 +381,15 @@ static int ds1337_detect(struct i2c_adap
 	/* Initialize the DS1337 chip */
 	ds1337_init_client(new_client);
 
+	/* Be nice to battery */
+	if (kind == ds1339 && ds1339_charge) {
+		char buf[] = { DS1339_REG_CHARGE, ds1339_charge };
+
+		if (i2c_master_send(new_client, buf, 2) != 2)
+			dev_err(&new_client->dev,
+				"failed to enable trickle charge.\n");
+	}
+
 	/* Add client to local list */
 	data->id = ds1337_id++;
 	list_add(&data->list, &ds1337_clients);
