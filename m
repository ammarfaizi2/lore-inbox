Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274833AbTHPPjw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274838AbTHPPjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:39:51 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:9737 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S274833AbTHPPjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:39:42 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Date: Sat, 16 Aug 2003 19:38:47 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307152214.38825.arvidjaar@mail.ru> <200307262200.51781.arvidjaar@mail.ru> <20030815205158.GB4760@kroah.com>
In-Reply-To: <20030815205158.GB4760@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HAlP/XMfoo/6M+l"
Message-Id: <200308161938.47935.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_HAlP/XMfoo/6M+l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 16 August 2003 00:51, Greg KH wrote:
> On Sat, Jul 26, 2003 at 10:00:51PM +0400, Andrey Borzenkov wrote:
> > Attached is patch against 2.6.0-test1 that adds type_name to all in-tree
> > sensors; it sets it to the same values as corr. 2.4 senors and (in one
> > case) changes client name to match that of 2.4.
> >
> > Assuming this patch (or variant thereof) is accepted I can then produce
> > libsensors patch that will easily reuse current sensors.conf. I have
> > already done it for gkrellm and as Mandrake is going to include 2.6 in
> > next release sensors support becomes more of an issue.
>
> I like this idea, but now that the name logic has changed in the i2c
> code, care to re-do this patch?  Just set the name field instead of
> creating a new file in sysfs.
>

something like attached patch? I like it as well :)

note that in 2.6.0-test3 name in sysfs is empty. I had to add a chunk to 
i2c-core to at least test my patch. or may be I misunderstood how 
client->name is used.

regards

-andrey


--Boundary-00=_HAlP/XMfoo/6M+l
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.0-test3-sensors_type_name-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test3-sensors_type_name-2.patch"

--- ../tmp/linux-2.6.0-test3/drivers/i2c/i2c-core.c	2003-08-09 13:10:05.000000000 +0400
+++ linux-2.6.0-test3-smp/drivers/i2c/i2c-core.c	2003-08-16 19:19:17.000000000 +0400
@@ -347,7 +347,7 @@ int i2c_attach_client(struct i2c_client 
 	}
 
 	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter\n",
-			client->dev.name));
+			client->name));
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;
@@ -356,6 +356,7 @@ int i2c_attach_client(struct i2c_client 
 	client->dev.driver = &client->driver->driver;
 	client->dev.bus = &i2c_bus_type;
 	client->dev.release = &i2c_client_release;
+	strcpy(client->dev.name, client->name);
 	
 	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
 		"%d-%04x", i2c_adapter_id(adapter), client->addr);
--- ../tmp/linux-2.6.0-test3/drivers/i2c/chips/adm1021.c	2003-08-09 13:10:04.000000000 +0400
+++ linux-2.6.0-test3-smp/drivers/i2c/chips/adm1021.c	2003-08-16 18:45:16.000000000 +0400
@@ -225,7 +225,6 @@ static int adm1021_detect(struct i2c_ada
 	struct adm1021_data *data;
 	int err = 0;
 	const char *type_name = "";
-	const char *client_name = "";
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
 	   at this moment; i2c_detect really won't call us. */
@@ -291,28 +290,20 @@ static int adm1021_detect(struct i2c_ada
 
 	if (kind == max1617) {
 		type_name = "max1617";
-		client_name = "MAX1617 chip";
 	} else if (kind == max1617a) {
 		type_name = "max1617a";
-		client_name = "MAX1617A chip";
 	} else if (kind == adm1021) {
 		type_name = "adm1021";
-		client_name = "ADM1021 chip";
 	} else if (kind == adm1023) {
 		type_name = "adm1023";
-		client_name = "ADM1023 chip";
 	} else if (kind == thmc10) {
 		type_name = "thmc10";
-		client_name = "THMC10 chip";
 	} else if (kind == lm84) {
 		type_name = "lm84";
-		client_name = "LM84 chip";
 	} else if (kind == gl523sm) {
 		type_name = "gl523sm";
-		client_name = "GL523SM chip";
 	} else if (kind == mc1066) {
 		type_name = "mc1066";
-		client_name = "MC1066 chip";
 	} else {
 		dev_err(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
@@ -320,7 +311,7 @@ static int adm1021_detect(struct i2c_ada
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, type_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	new_client->id = adm1021_id++;
--- ../tmp/linux-2.6.0-test3/drivers/i2c/chips/it87.c	2003-08-09 13:10:04.000000000 +0400
+++ linux-2.6.0-test3-smp/drivers/i2c/chips/it87.c	2003-08-16 18:59:14.000000000 +0400
@@ -591,8 +591,7 @@ int it87_detect(struct i2c_adapter *adap
 	struct i2c_client *new_client = NULL;
 	struct it87_data *data;
 	int err = 0;
-	const char *name = "";
-	const char *client_name = "";
+	const char *type_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 
 	if (!is_isa && 
@@ -601,7 +600,7 @@ int it87_detect(struct i2c_adapter *adap
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, IT87_EXTENT, name))
+		if (!request_region(address, IT87_EXTENT, type_name))
 			goto ERROR0;
 
 	/* Probe whether there is anything available on this address. Already
@@ -680,11 +679,9 @@ int it87_detect(struct i2c_adapter *adap
 	}
 
 	if (kind == it87) {
-		name = "it87";
-		client_name = "IT87 chip";
+		type_name = "it87";
 	} /* else if (kind == it8712) {
-		name = "it8712";
-		client_name = "IT87-J chip";
+		type_name = "it8712";
 	} */ else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
@@ -692,7 +689,7 @@ int it87_detect(struct i2c_adapter *adap
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, type_name, DEVICE_NAME_SIZE);
 
 	data->type = kind;
 
--- ../tmp/linux-2.6.0-test3/drivers/i2c/chips/lm75.c	2003-08-09 13:10:04.000000000 +0400
+++ linux-2.6.0-test3-smp/drivers/i2c/chips/lm75.c	2003-08-16 18:47:13.000000000 +0400
@@ -133,7 +133,7 @@ static int lm75_detect(struct i2c_adapte
 	struct i2c_client *new_client;
 	struct lm75_data *data;
 	int err = 0;
-	const char *name;
+	const char *type_name;
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
 	   at this moment; i2c_detect really won't call us. */
@@ -186,7 +186,7 @@ static int lm75_detect(struct i2c_adapte
 		kind = lm75;
 
 	if (kind == lm75) {
-		name = "lm75";
+		type_name = "lm75";
 	} else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
@@ -194,7 +194,7 @@ static int lm75_detect(struct i2c_adapte
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, type_name, DEVICE_NAME_SIZE);
 
 	new_client->id = lm75_id++;
 	data->valid = 0;
--- ../tmp/linux-2.6.0-test3/drivers/i2c/chips/lm78.c	2003-08-09 13:10:04.000000000 +0400
+++ linux-2.6.0-test3-smp/drivers/i2c/chips/lm78.c	2003-08-16 18:48:09.000000000 +0400
@@ -519,7 +519,7 @@ int lm78_detect(struct i2c_adapter *adap
 	int i, err;
 	struct i2c_client *new_client;
 	struct lm78_data *data;
-	const char *client_name = "";
+	const char *type_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 
 	if (!is_isa &&
@@ -625,11 +625,11 @@ int lm78_detect(struct i2c_adapter *adap
 	}
 
 	if (kind == lm78) {
-		client_name = "LM78 chip";
+		type_name = "lm78";
 	} else if (kind == lm78j) {
-		client_name = "LM78-J chip";
+		type_name = "lm78-j";
 	} else if (kind == lm79) {
-		client_name = "LM79 chip";
+		type_name = "lm79";
 	} else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
@@ -638,7 +638,7 @@ int lm78_detect(struct i2c_adapter *adap
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, type_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	data->valid = 0;
--- ../tmp/linux-2.6.0-test3/drivers/i2c/chips/lm85.c	2003-08-09 13:10:04.000000000 +0400
+++ linux-2.6.0-test3-smp/drivers/i2c/chips/lm85.c	2003-08-16 18:49:17.000000000 +0400
@@ -853,24 +853,20 @@ int lm85_detect(struct i2c_adapter *adap
 	/* Fill in the chip specific driver values */
 	if ( kind == any_chip ) {
 		type_name = "lm85";
-		strlcpy(new_client->name, "Generic LM85", DEVICE_NAME_SIZE);
 	} else if ( kind == lm85b ) {
 		type_name = "lm85b";
-		strlcpy(new_client->name, "National LM85-B", DEVICE_NAME_SIZE);
 	} else if ( kind == lm85c ) {
 		type_name = "lm85c";
-		strlcpy(new_client->name, "National LM85-C", DEVICE_NAME_SIZE);
 	} else if ( kind == adm1027 ) {
 		type_name = "adm1027";
-		strlcpy(new_client->name, "Analog Devices ADM1027", DEVICE_NAME_SIZE);
 	} else if ( kind == adt7463 ) {
 		type_name = "adt7463";
-		strlcpy(new_client->name, "Analog Devices ADT7463", DEVICE_NAME_SIZE);
 	} else {
 		dev_dbg(&adapter->dev, "Internal error, invalid kind (%d)!", kind);
 		err = -EFAULT ;
 		goto ERROR1;
 	}
+	strlcpy(new_client->name, type_name, DEVICE_NAME_SIZE);
 
 	/* Fill in the remaining client fields */
 	new_client->id = lm85_id++;
--- ../tmp/linux-2.6.0-test3/drivers/i2c/chips/via686a.c	2003-08-09 13:10:05.000000000 +0400
+++ linux-2.6.0-test3-smp/drivers/i2c/chips/via686a.c	2003-08-16 18:51:18.000000000 +0400
@@ -671,7 +671,7 @@ static int via686a_detect(struct i2c_ada
 	struct i2c_client *new_client;
 	struct via686a_data *data;
 	int err = 0;
-	const char client_name[] = "via686a chip";
+	const char type_name[] = "via686a";
 	u16 val;
 
 	/* Make sure we are probing the ISA bus!!  */
@@ -727,7 +727,7 @@ static int via686a_detect(struct i2c_ada
 	new_client->dev.parent = &adapter->dev;
 
 	/* Fill in the remaining client fields and put into the global list */
-	snprintf(new_client->name, DEVICE_NAME_SIZE, client_name);
+	strlcpy(new_client->name, type_name, DEVICE_NAME_SIZE);
 
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
--- ../tmp/linux-2.6.0-test3/drivers/i2c/chips/w83781d.c	2003-08-09 13:10:05.000000000 +0400
+++ linux-2.6.0-test3-smp/drivers/i2c/chips/w83781d.c	2003-08-16 19:21:27.000000000 +0400
@@ -1041,7 +1041,7 @@ w83781d_detect_subclients(struct i2c_ada
 {
 	int i, val1 = 0, id;
 	int err;
-	const char *client_name;
+	const char *type_name;
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 
 	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
@@ -1098,17 +1098,17 @@ w83781d_detect_subclients(struct i2c_ada
 	}
 
 	if (kind == w83781d)
-		client_name = "W83781D subclient";
+		type_name = "w83781d";
 	else if (kind == w83782d)
-		client_name = "W83782D subclient";
+		type_name = "w83782d";
 	else if (kind == w83783s)
-		client_name = "W83783S subclient";
+		type_name = "w83783s";
 	else if (kind == w83627hf)
-		client_name = "W83627HF subclient";
+		type_name = "w83627hf";
 	else if (kind == as99127f)
-		client_name = "AS99127F subclient";
+		type_name = "as99127f";
 	else
-		client_name = "unknown subclient?";
+		type_name = "unknown subclient?";
 
 	for (i = 0; i <= 1; i++) {
 		/* store all data in w83781d */
@@ -1116,7 +1116,7 @@ w83781d_detect_subclients(struct i2c_ada
 		data->lm75[i]->adapter = adapter;
 		data->lm75[i]->driver = &w83781d_driver;
 		data->lm75[i]->flags = 0;
-		strlcpy(data->lm75[i]->name, client_name,
+		strlcpy(data->lm75[i]->name, type_name,
 			DEVICE_NAME_SIZE);
 		if ((err = i2c_attach_client(data->lm75[i]))) {
 			dev_err(&new_client->dev, "Subclient %d "
@@ -1152,7 +1152,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	struct i2c_client *new_client;
 	struct w83781d_data *data;
 	int err;
-	const char *client_name = "";
+	const char *type_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 	enum vendor { winbond, asus } vendid;
 
@@ -1304,20 +1304,20 @@ w83781d_detect(struct i2c_adapter *adapt
 	}
 
 	if (kind == w83781d) {
-		client_name = "W83781D chip";
+		type_name = "w83781d";
 	} else if (kind == w83782d) {
-		client_name = "W83782D chip";
+		type_name = "w83782d";
 	} else if (kind == w83783s) {
-		client_name = "W83783S chip";
+		type_name = "w83783s";
 	} else if (kind == w83627hf) {
 		if (val1 == 0x90)
-			client_name = "W83627THF chip";
+			type_name = "w83627thf";
 		else
-			client_name = "W83627HF chip";
+			type_name = "w83627hf";
 	} else if (kind == as99127f) {
-		client_name = "AS99127F chip";
+		type_name = "as99127f";
 	} else if (kind == w83697hf) {
-		client_name = "W83697HF chip";
+		type_name = "w83697hf";
 	} else {
 		dev_err(&new_client->dev, "Internal error: unknown "
 						"kind (%d)?!?", kind);
@@ -1326,7 +1326,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, type_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	data->valid = 0;

--Boundary-00=_HAlP/XMfoo/6M+l--

