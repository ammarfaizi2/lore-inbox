Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264624AbTFAOZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbTFAOZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:25:05 -0400
Received: from charger.oldcity.dca.net ([207.245.82.76]:904 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id S264624AbTFAOY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:24:56 -0400
Date: Sun, 1 Jun 2003 10:38:08 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Cc: "Mark D. Studebaker" <mds@paradyne.com>, Greg KH <greg@kroah.com>
Subject: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
Message-ID: <20030601143808.GA30177@earth.solarsys.private>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Sensors <sensors@stimpy.netroedge.com>,
	"Mark D. Studebaker" <mds@paradyne.com>, Greg KH <greg@kroah.com>
References: <20030524183748.GA3097@earth.solarsys.private> <3ED8067E.1050503@paradyne.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <3ED8067E.1050503@paradyne.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Mark D. Studebaker <mds@paradyne.com> [2003-05-30 21:33:50 -0400]:
> Mark M. Hoffman wrote:
> >This applies to all kernel versions since w83781d was brought in from 
> >the lm_sensors project.
> >
> >The subclients of w83781d are never registered with i2c_attach_client().
> >But, w83781d_detach_client() tries to i2c_detach_client() them anyway.
> >This was harmless, until i2c-core was "listified"... because the old
> >array method silently ignored the attempt to detach a non-existent client.
> >
> >The latest lm_sensors CVS of w83781d has the necessary i2c_attach_client()
> >calls - not sure why they were removed during conversion to 2.5.x.  Do we
> >intend to attach these subclients or not?
>
> Good catch.
> Greg, this needs to be fixed.
> Winbond chips take up 3 addresses on the i2c bus.
> In the original code we registered two "subclients" with the i2c layer.
> Somehow the 3-address chips need to be handled.

This fixes the oops during w83781d module removal by putting the
subclient registration back in.  While I was in there, I split
w83781d_detect in half in an attempt to reduce the goto madness.

So, the /sys tree looks like this, where 48 & 49 are the subclients.
There are no entries (besides name & power) for the subclients.

/sys/bus/i2c/
|-- devices
|   |-- 0-002d -> ../../../devices/pci0/00:02.1/i2c-0/0-002d
|   |-- 0-0048 -> ../../../devices/pci0/00:02.1/i2c-0/0-0048
|   `-- 0-0049 -> ../../../devices/pci0/00:02.1/i2c-0/0-0049
`-- drivers
    |-- i2c_adapter
    `-- w83781d
        |-- 0-002d -> ../../../../devices/pci0/00:02.1/i2c-0/0-002d
        |-- 0-0048 -> ../../../../devices/pci0/00:02.1/i2c-0/0-0048
        `-- 0-0049 -> ../../../../devices/pci0/00:02.1/i2c-0/0-0049

Also, I fixed a bug where this driver would request and release an
ISA region, then poke around in that region, then finally request
it again.

This patch against 2.5.70 works for me vs. an SMBus adapter.  It needs
re-testing against an ISA adapter since my particular chip is SMBus only.

Please CC me w/ comments.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-w83781d.txt"

--- linux-2.5.70/drivers/i2c/chips/w83781d.c.orig	2003-06-01 10:08:56.000000000 -0400
+++ linux-2.5.70/drivers/i2c/chips/w83781d.c	2003-06-01 10:13:19.000000000 -0400
@@ -1031,14 +1031,112 @@
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
 
+/* Assumes that adapter is of I2C, not ISA variety.
+ * OTHERWISE DON'T CALL THIS
+ */
+static int
+w83781d_detect_subclients(struct i2c_adapter *adapter, int address, int kind,
+		struct i2c_client *new_client)
+{
+	int i, val1 = 0, id;
+	int err = 0;
+	const char *client_name;
+	struct w83781d_data *data = i2c_get_clientdata(new_client);
+
+	if (!(data->lm75 = kmalloc(2 * sizeof (struct i2c_client),
+			GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR_SC_0;
+	}
+	memset(data->lm75, 0x00, 2 * sizeof (struct i2c_client));
+
+	id = i2c_adapter_id(adapter);
+
+	if (force_subclients[0] == id && force_subclients[1] == address) {
+		for (i = 2; i <= 3; i++) {
+			if (force_subclients[i] < 0x48 ||
+			    force_subclients[i] > 0x4f) {
+				dev_err(&new_client->dev, "Invalid subclient "
+					"address %d; must be 0x48-0x4f\n",
+			       force_subclients[i]);
+				goto ERROR_SC_1;
+			}
+		}
+		w83781d_write_value(new_client, W83781D_REG_I2C_SUBADDR,
+				(force_subclients[2] & 0x07) |
+				((force_subclients[3] & 0x07) << 4));
+		data->lm75[0].addr = force_subclients[2];
+	} else {
+		val1 = w83781d_read_value(new_client, W83781D_REG_I2C_SUBADDR);
+		data->lm75[0].addr = 0x48 + (val1 & 0x07);
+	}
+
+	if (kind != w83783s) {
+		if (force_subclients[0] == id &&
+		    force_subclients[1] == address) {
+			data->lm75[1].addr = force_subclients[3];
+		} else {
+			data->lm75[1].addr = 0x48 + ((val1 >> 4) & 0x07);
+		}
+		if (data->lm75[0].addr == data->lm75[1].addr) {
+			dev_err(&new_client->dev,
+			       "Duplicate addresses 0x%x for subclients.\n",
+			       data->lm75[0].addr);
+			goto ERROR_SC_1;
+		}
+	}
+
+	if (kind == w83781d)
+		client_name = "W83781D subclient";
+	else if (kind == w83782d)
+		client_name = "W83782D subclient";
+	else if (kind == w83783s)
+		client_name = "W83783S subclient";
+	else if (kind == w83627hf)
+		client_name = "W83627HF subclient";
+	else if (kind == as99127f)
+		client_name = "AS99127F subclient";
+	else
+		client_name = "unknown subclient?";
+
+	for (i = 0; i <= 1; i++) {
+		/* store all data in w83781d */
+		i2c_set_clientdata(&data->lm75[i], NULL);
+		data->lm75[i].adapter = adapter;
+		data->lm75[i].driver = &w83781d_driver;
+		data->lm75[i].flags = 0;
+		strlcpy(data->lm75[i].dev.name, client_name,
+			DEVICE_NAME_SIZE);
+		if ((err = i2c_attach_client(&(data->lm75[i])))) {
+			dev_err(&new_client->dev, "Subclient %d "
+				"registration at address 0x%x "
+				"failed.\n", i, data->lm75[i].addr);
+			if (i == 1)
+				goto ERROR_SC_2;
+			goto ERROR_SC_1;
+		}
+		if (kind == w83783s)
+			break;
+	}
+
+	return err;
+
+/* Undo inits in case of errors */
+ERROR_SC_2:
+	i2c_detach_client(&(data->lm75[0]));
+ERROR_SC_1:
+	kfree(data->lm75);
+ERROR_SC_0:
+	return err;
+}
+
 static int
 w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	int i = 0, val1 = 0, val2, id;
+	int i = 0, val1 = 0, val2;
 	struct i2c_client *new_client;
 	struct w83781d_data *data;
 	int err = 0;
-	const char *type_name = "";
 	const char *client_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 	enum vendor { winbond, asus } vendid;
@@ -1047,11 +1145,9 @@
 	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto ERROR0;
 
-	if (is_isa) {
+	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT, "w83781d"))
 			goto ERROR0;
-		release_region(address, W83781D_EXTENT);
-	}
 
 	/* Probe whether there is anything available on this address. Already
 	   done for SMBus clients */
@@ -1063,11 +1159,11 @@
 			   if we read 'undefined' registers. */
 			i = inb_p(address + 1);
 			if (inb_p(address + 2) != i)
-				goto ERROR0;
+				goto ERROR1;
 			if (inb_p(address + 3) != i)
-				goto ERROR0;
+				goto ERROR1;
 			if (inb_p(address + 7) != i)
-				goto ERROR0;
+				goto ERROR1;
 #undef REALLY_SLOW_IO
 
 			/* Let's just hope nothing breaks here */
@@ -1087,7 +1183,7 @@
 	if (!(new_client = kmalloc(sizeof (struct i2c_client) +
 				   sizeof (struct w83781d_data), GFP_KERNEL))) {
 		err = -ENOMEM;
-		goto ERROR0;
+		goto ERROR1;
 	}
 
 	memset(new_client, 0x00, sizeof (struct i2c_client) +
@@ -1109,7 +1205,7 @@
 	   bank. */
 	if (kind < 0) {
 		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80)
-			goto ERROR1;
+			goto ERROR2;
 		val1 = w83781d_read_value(new_client, W83781D_REG_BANK);
 		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
 		/* Check for Winbond or Asus ID if in bank 0 */
@@ -1118,13 +1214,13 @@
 		      && (val2 != 0x94))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)
 			 && (val2 != 0x06))))
-			goto ERROR1;
+			goto ERROR2;
 		/* If Winbond SMBus, check address at 0x48. Asus doesn't support */
 		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 == 0xa3)) ||
 				  ((val1 & 0x80) && (val2 == 0x5c)))) {
 			if (w83781d_read_value
 			    (new_client, W83781D_REG_I2C_ADDR) != address)
-				goto ERROR1;
+				goto ERROR2;
 		}
 	}
 
@@ -1144,7 +1240,7 @@
 		else if ((val2 == 0x12) || (val2 == 0x06))
 			vendid = asus;
 		else
-			goto ERROR1;
+			goto ERROR2;
 		/* mask off lower bit, not reliable */
 		val1 =
 		    w83781d_read_value(new_client, W83781D_REG_WCHIPID) & 0xfe;
@@ -1166,38 +1262,28 @@
 				       "Ignoring 'force' parameter for unknown chip at"
 				       "adapter %d, address 0x%02x\n",
 				       i2c_adapter_id(adapter), address);
-			goto ERROR1;
+			goto ERROR2;
 		}
 	}
 
 	if (kind == w83781d) {
-		type_name = "w83781d";
 		client_name = "W83781D chip";
 	} else if (kind == w83782d) {
-		type_name = "w83782d";
 		client_name = "W83782D chip";
 	} else if (kind == w83783s) {
-		type_name = "w83783s";
 		client_name = "W83783S chip";
 	} else if (kind == w83627hf) {
-		type_name = "w83627hf";
 		client_name = "W83627HF chip";
 	} else if (kind == as99127f) {
-		type_name = "as99127f";
 		client_name = "AS99127F chip";
 	} else if (kind == w83697hf) {
-		type_name = "w83697hf";
 		client_name = "W83697HF chip";
 	} else {
 		dev_err(&new_client->dev, "Internal error: unknown kind (%d)?!?", kind);
-		goto ERROR1;
+		goto ERROR2;
 	}
 
-	/* Reserve the ISA region */
-	if (is_isa)
-		request_region(address, W83781D_EXTENT, type_name);
-
-	/* Fill in the remaining client fields and put it into the global list */
+	/* Fill in the remaining client fields and put into the global list */
 	strlcpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
@@ -1206,76 +1292,13 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto ERROR3;
+		goto ERROR2;
 
 	/* attach secondary i2c lm75-like clients */
 	if (!is_isa) {
-		if (!(data->lm75 = kmalloc(2 * sizeof (struct i2c_client),
-					   GFP_KERNEL))) {
-			err = -ENOMEM;
-			goto ERROR4;
-		}
-
-		memset(data->lm75, 0x00, 2 * sizeof (struct i2c_client));
-
-		id = i2c_adapter_id(adapter);
-		if (force_subclients[0] == id && force_subclients[1] == address) {
-			for (i = 2; i <= 3; i++) {
-				if (force_subclients[i] < 0x48 ||
-				    force_subclients[i] > 0x4f) {
-					dev_err(&new_client->dev,
-					       "Invalid subclient address %d; must be 0x48-0x4f\n",
-					       force_subclients[i]);
-					goto ERROR5;
-				}
-			}
-			w83781d_write_value(new_client,
-					    W83781D_REG_I2C_SUBADDR,
-					    (force_subclients[2] & 0x07) |
-					    ((force_subclients[3] & 0x07) <<
-					     4));
-			data->lm75[0].addr = force_subclients[2];
-		} else {
-			val1 = w83781d_read_value(new_client,
-						  W83781D_REG_I2C_SUBADDR);
-			data->lm75[0].addr = 0x48 + (val1 & 0x07);
-		}
-		if (kind != w83783s) {
-			if (force_subclients[0] == id &&
-			    force_subclients[1] == address) {
-				data->lm75[1].addr = force_subclients[3];
-			} else {
-				data->lm75[1].addr =
-				    0x48 + ((val1 >> 4) & 0x07);
-			}
-			if (data->lm75[0].addr == data->lm75[1].addr) {
-				dev_err(&new_client->dev,
-				       "Duplicate addresses 0x%x for subclients.\n",
-				       data->lm75[0].addr);
-				goto ERROR5;
-			}
-		}
-		if (kind == w83781d)
-			client_name = "W83781D subclient";
-		else if (kind == w83782d)
-			client_name = "W83782D subclient";
-		else if (kind == w83783s)
-			client_name = "W83783S subclient";
-		else if (kind == w83627hf)
-			client_name = "W83627HF subclient";
-		else if (kind == as99127f)
-			client_name = "AS99127F subclient";
-
-		for (i = 0; i <= 1; i++) {
-			i2c_set_clientdata(&data->lm75[i], NULL);	/* store all data in w83781d */
-			data->lm75[i].adapter = adapter;
-			data->lm75[i].driver = &w83781d_driver;
-			data->lm75[i].flags = 0;
-			strlcpy(data->lm75[i].dev.name, client_name,
-				DEVICE_NAME_SIZE);
-			if (kind == w83783s)
-				break;
-		}
+		if ((err = w83781d_detect_subclients(adapter, address,
+				kind, new_client)))
+			goto ERROR3;
 	} else {
 		data->lm75 = NULL;
 	}
@@ -1346,24 +1369,14 @@
 	w83781d_init_client(new_client);
 	return 0;
 
-/* OK, this is not exactly good programming practice, usually. But it is
-   very code-efficient in this case. */
-
-      ERROR5:
-	if (!is_isa) {
-		i2c_detach_client(&data->lm75[0]);
-		if (data->type != w83783s)
-			i2c_detach_client(&data->lm75[1]);
-		kfree(data->lm75);
-	}
-      ERROR4:
+ERROR3:
 	i2c_detach_client(new_client);
-      ERROR3:
+ERROR2:
+	kfree(new_client);
+ERROR1:
 	if (is_isa)
 		release_region(address, W83781D_EXTENT);
-      ERROR1:
-	kfree(new_client);
-      ERROR0:
+ERROR0:
 	return err;
 }
 
@@ -1373,12 +1386,7 @@
 	struct w83781d_data *data = i2c_get_clientdata(client);
 	int err;
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		       "Client deregistration failed, client not detached.\n");
-		return err;
-	}
-
+	/* release ISA region or I2C subclients first */
 	if (i2c_is_isa_client(client)) {
 		release_region(client->addr, W83781D_EXTENT);
 	} else {
@@ -1387,6 +1395,14 @@
 			i2c_detach_client(&data->lm75[1]);
 		kfree(data->lm75);
 	}
+
+	/* now it's safe to scrap the rest */
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+		       "Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
 	kfree(client);
 
 	return 0;

--VS++wcV0S1rZb1Fb--
