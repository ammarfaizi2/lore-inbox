Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270525AbTGZRqp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270526AbTGZRqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:46:45 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:51719 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270525AbTGZRqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:46:35 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Date: Sat, 26 Jul 2003 22:00:51 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307152214.38825.arvidjaar@mail.ru> <20030715201822.GA5040@kroah.com>
In-Reply-To: <20030715201822.GA5040@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_THsI/1Ki7+A+4fd"
Message-Id: <200307262200.51781.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_THsI/1Ki7+A+4fd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 16 July 2003 00:18, Greg KH wrote:
[...]
> The "translation layer" is libsensors.  libsensors needs to be rewritten
> for 2.6.  The sensors people know this, and it's even detailed on their
> web page.  Any help with this is greatly appreciated.
>

I do mean libsensors. Also gkrellm does not use libsensors (it interfaces with 
proc/sys directly) and I already have user reports about naming problems.

> > If there are serious reasons to keep current names in "name" - what about
> > adding extra type_name property that will hold type_name compatible with
> > 2.4, at least for those drivers that are also available there. This would
> > allow easily reuse existing sensors configuration.
>
> Patches to help do this are always welcome :)
>

Attached is patch against 2.6.0-test1 that adds type_name to all in-tree 
sensors; it sets it to the same values as corr. 2.4 senors and (in one case) 
changes client name to match that of 2.4.

Assuming this patch (or variant thereof) is accepted I can then produce 
libsensors patch that will easily reuse current sensors.conf. I have already 
done it for gkrellm and as Mandrake is going to include 2.6 in next release 
sensors support becomes more of an issue.

It compiles and w83781d works. Comments appreciated.

regards

-andrey
--Boundary-00=_THsI/1Ki7+A+4fd
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.0-test1-sensors_type_name.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test1-sensors_type_name.patch"

--- linux-2.6.0-test1-smp/drivers/i2c/chips/adm1021.c.type_name	2003-06-26 21:41:22.000000000 +0400
+++ linux-2.6.0-test1-smp/drivers/i2c/chips/adm1021.c	2003-07-26 20:47:19.000000000 +0400
@@ -139,7 +139,6 @@ static void adm1021_update_client(struct
 /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
 static int read_only = 0;
 
-
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1021_driver = {
 	.owner		= THIS_MODULE,
@@ -150,6 +149,13 @@ static struct i2c_driver adm1021_driver 
 	.detach_client	= adm1021_detach_client,
 };
 
+static const char *type_name = "";
+static ssize_t show_type_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", type_name);			
+}
+static DEVICE_ATTR(type_name, S_IRUGO, show_type_name, NULL);
+
 /* I choose here for semi-static allocation. Complete dynamic
    allocation could also be used; the code needed for this would probably
    take more memory than the datastructure takes now. */
@@ -224,7 +230,6 @@ static int adm1021_detect(struct i2c_ada
 	struct i2c_client *new_client;
 	struct adm1021_data *data;
 	int err = 0;
-	const char *type_name = "";
 	const char *client_name = "";
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
@@ -331,6 +336,7 @@ static int adm1021_detect(struct i2c_ada
 	if ((err = i2c_attach_client(new_client)))
 		goto error3;
 
+	device_create_file(&new_client->dev, &dev_attr_type_name);
 	device_create_file(&new_client->dev, &dev_attr_temp_max1);
 	device_create_file(&new_client->dev, &dev_attr_temp_min1);
 	device_create_file(&new_client->dev, &dev_attr_temp_input1);
--- linux-2.6.0-test1-smp/drivers/i2c/chips/it87.c.type_name	2003-06-26 21:39:34.000000000 +0400
+++ linux-2.6.0-test1-smp/drivers/i2c/chips/it87.c	2003-07-26 21:13:52.000000000 +0400
@@ -236,6 +236,13 @@ static struct i2c_driver it87_driver = {
 
 static int it87_id = 0;
 
+static const char *type_name = "";
+static ssize_t show_type_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", type_name);			
+}
+static DEVICE_ATTR(type_name, S_IRUGO, show_type_name, NULL);
+
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -591,7 +598,6 @@ int it87_detect(struct i2c_adapter *adap
 	struct i2c_client *new_client = NULL;
 	struct it87_data *data;
 	int err = 0;
-	const char *name = "";
 	const char *client_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 
@@ -601,7 +607,7 @@ int it87_detect(struct i2c_adapter *adap
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, IT87_EXTENT, name))
+		if (!request_region(address, IT87_EXTENT, type_name))
 			goto ERROR0;
 
 	/* Probe whether there is anything available on this address. Already
@@ -680,10 +686,10 @@ int it87_detect(struct i2c_adapter *adap
 	}
 
 	if (kind == it87) {
-		name = "it87";
+		type_name = "it87";
 		client_name = "IT87 chip";
 	} /* else if (kind == it8712) {
-		name = "it8712";
+		type_name = "it8712";
 		client_name = "IT87-J chip";
 	} */ else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
@@ -692,7 +698,7 @@ int it87_detect(struct i2c_adapter *adap
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 
 	data->type = kind;
 
@@ -705,6 +711,7 @@ int it87_detect(struct i2c_adapter *adap
 		goto ERROR1;
 
 	/* register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_type_name);
 	device_create_file(&new_client->dev, &dev_attr_in_input0);
 	device_create_file(&new_client->dev, &dev_attr_in_input1);
 	device_create_file(&new_client->dev, &dev_attr_in_input2);
--- linux-2.6.0-test1-smp/drivers/i2c/chips/lm75.c.type_name	2003-06-26 21:39:34.000000000 +0400
+++ linux-2.6.0-test1-smp/drivers/i2c/chips/lm75.c	2003-07-26 20:52:45.000000000 +0400
@@ -86,6 +86,13 @@ static struct i2c_driver lm75_driver = {
 
 static int lm75_id = 0;
 
+static const char *type_name = "";
+static ssize_t show_type_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", type_name);			
+}
+static DEVICE_ATTR(type_name, S_IRUGO, show_type_name, NULL);
+
 #define show(value)	\
 static ssize_t show_##value(struct device *dev, char *buf)	\
 {								\
@@ -133,7 +140,7 @@ static int lm75_detect(struct i2c_adapte
 	struct i2c_client *new_client;
 	struct lm75_data *data;
 	int err = 0;
-	const char *name;
+	const char *client_name;
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
 	   at this moment; i2c_detect really won't call us. */
@@ -186,7 +193,8 @@ static int lm75_detect(struct i2c_adapte
 		kind = lm75;
 
 	if (kind == lm75) {
-		name = "lm75";
+		type_name = "lm75";
+		client_name = "LM75 chip";
 	} else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
@@ -194,7 +202,7 @@ static int lm75_detect(struct i2c_adapte
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 
 	new_client->id = lm75_id++;
 	data->valid = 0;
@@ -204,6 +212,7 @@ static int lm75_detect(struct i2c_adapte
 	if ((err = i2c_attach_client(new_client)))
 		goto exit_free;
 
+	device_create_file(&new_client->dev, &dev_attr_type_name);
 	device_create_file(&new_client->dev, &dev_attr_temp_max);
 	device_create_file(&new_client->dev, &dev_attr_temp_min);
 	device_create_file(&new_client->dev, &dev_attr_temp_input);
--- linux-2.6.0-test1-smp/drivers/i2c/chips/lm78.c.type_name	2003-06-26 21:41:22.000000000 +0400
+++ linux-2.6.0-test1-smp/drivers/i2c/chips/lm78.c	2003-07-26 20:54:14.000000000 +0400
@@ -231,6 +231,13 @@ static struct i2c_driver lm78_driver = {
 	.detach_client	= lm78_detach_client,
 };
 
+static const char *type_name = "";
+static ssize_t show_type_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", type_name);			
+}
+static DEVICE_ATTR(type_name, S_IRUGO, show_type_name, NULL);
+
 /* 7 Voltages */
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
@@ -625,10 +632,13 @@ int lm78_detect(struct i2c_adapter *adap
 	}
 
 	if (kind == lm78) {
+		type_name = "lm78";
 		client_name = "LM78 chip";
 	} else if (kind == lm78j) {
+		type_name = "lm78-j";
 		client_name = "LM78-J chip";
 	} else if (kind == lm79) {
+		type_name = "lm79";
 		client_name = "LM79 chip";
 	} else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
@@ -649,6 +659,7 @@ int lm78_detect(struct i2c_adapter *adap
 		goto ERROR2;
 
 	/* register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_type_name);
 	device_create_file(&new_client->dev, &dev_attr_in_input0);
 	device_create_file(&new_client->dev, &dev_attr_in_min0);
 	device_create_file(&new_client->dev, &dev_attr_in_max0);
--- linux-2.6.0-test1-smp/drivers/i2c/chips/lm85.c.type_name	2003-06-26 21:41:22.000000000 +0400
+++ linux-2.6.0-test1-smp/drivers/i2c/chips/lm85.c	2003-07-26 20:54:42.000000000 +0400
@@ -411,6 +411,13 @@ static struct i2c_driver lm85_driver = {
 /* Unique ID assigned to each LM85 detected */
 static int lm85_id = 0;
 
+static const char *type_name = "";
+static ssize_t show_type_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", type_name);			
+}
+static DEVICE_ATTR(type_name, S_IRUGO, show_type_name, NULL);
+
 
 /* 4 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
@@ -759,7 +766,6 @@ int lm85_detect(struct i2c_adapter *adap
 	struct i2c_client *new_client = NULL;
 	struct lm85_data *data;
 	int err = 0;
-	const char *type_name = "";
 
 	if (i2c_is_isa_adapter(adapter)) {
 		/* This chip has no ISA interface */
@@ -892,6 +898,7 @@ int lm85_detect(struct i2c_adapter *adap
 	/* Set the VRM version */
 	data->vrm = LM85_INIT_VRM ;
 
+	device_create_file(&new_client->dev, &dev_attr_type_name);
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_input2);
 	device_create_file(&new_client->dev, &dev_attr_fan_input3);
--- linux-2.6.0-test1-smp/drivers/i2c/chips/via686a.c.type_name	2003-06-26 21:39:34.000000000 +0400
+++ linux-2.6.0-test1-smp/drivers/i2c/chips/via686a.c	2003-07-26 20:57:01.000000000 +0400
@@ -409,6 +409,13 @@ static void via686a_init_client(struct i
 
 /* following are the sysfs callback functions */
 
+static const char *type_name = "via686a";
+static ssize_t show_type_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", type_name);			
+}
+static DEVICE_ATTR(type_name, S_IRUGO, show_type_name, NULL);
+
 /* 7 voltage sensors */
 static ssize_t show_in(struct device *dev, char *buf, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -671,7 +678,7 @@ static int via686a_detect(struct i2c_ada
 	struct i2c_client *new_client;
 	struct via686a_data *data;
 	int err = 0;
-	const char client_name[] = "via686a chip";
+	const char client_name[] = "Via 686A Integrated Sensors";
 	u16 val;
 
 	/* Make sure we are probing the ISA bus!!  */
@@ -736,6 +743,7 @@ static int via686a_detect(struct i2c_ada
 		goto ERROR3;
 	
 	/* register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_type_name);
 	device_create_file(&new_client->dev, &dev_attr_in_input0);
 	device_create_file(&new_client->dev, &dev_attr_in_input1);
 	device_create_file(&new_client->dev, &dev_attr_in_input2);
--- linux-2.6.0-test1-smp/drivers/i2c/chips/w83781d.c.type_name	2003-06-26 21:41:22.000000000 +0400
+++ linux-2.6.0-test1-smp/drivers/i2c/chips/w83781d.c	2003-07-26 21:05:38.000000000 +0400
@@ -357,6 +357,13 @@ static struct i2c_driver w83781d_driver 
 };
 
 /* following are the sysfs callback functions */
+static const char *type_name = "";
+static ssize_t show_type_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", type_name);			
+}
+static DEVICE_ATTR(type_name, S_IRUGO, show_type_name, NULL);
+
 #define show_in_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
@@ -1304,19 +1311,27 @@ w83781d_detect(struct i2c_adapter *adapt
 	}
 
 	if (kind == w83781d) {
+		type_name = "w83781d";
 		client_name = "W83781D chip";
 	} else if (kind == w83782d) {
+		type_name = "w83782d";
 		client_name = "W83782D chip";
 	} else if (kind == w83783s) {
+		type_name = "w83783s";
 		client_name = "W83783S chip";
 	} else if (kind == w83627hf) {
-		if (val1 == 0x90)
+		if (val1 == 0x90) {
+			type_name = "w83627thf";
 			client_name = "W83627THF chip";
-		else
+		} else {
+			type_name = "w83627hf";
 			client_name = "W83627HF chip";
+		}
 	} else if (kind == as99127f) {
+		type_name = "as99127f";
 		client_name = "AS99127F chip";
 	} else if (kind == w83697hf) {
+		type_name = "w83697hf";
 		client_name = "W83697HF chip";
 	} else {
 		dev_err(&new_client->dev, "Internal error: unknown "
@@ -1346,6 +1361,8 @@ w83781d_detect(struct i2c_adapter *adapt
 		data->lm75[1] = NULL;
 	}
 
+	device_create_file(&new_client->dev, &dev_attr_type_name);
+
 	device_create_file_in(new_client, 0);
 	if (kind != w83783s && kind != w83697hf)
 		device_create_file_in(new_client, 1);

--Boundary-00=_THsI/1Ki7+A+4fd--

