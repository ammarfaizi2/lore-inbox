Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263209AbTDCAGx>; Wed, 2 Apr 2003 19:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbTDCAF0>; Wed, 2 Apr 2003 19:05:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:62631 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263211AbTDCACN> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:13 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289583037@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <10493289582463@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:58 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.6, 2003/04/02 11:32:24-08:00, greg@kroah.com

i2c: convert adm1021 chip driver to use sysfs files.

Note, some data is not converted and will not be displayed.
Someone with this hardware is going to have to finish the rest of 
this conversion.


 drivers/i2c/chips/adm1021.c |  358 ++++++++++++++++++++------------------------
 1 files changed, 166 insertions(+), 192 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Wed Apr  2 16:01:25 2003
+++ b/drivers/i2c/chips/adm1021.c	Wed Apr  2 16:01:25 2003
@@ -53,34 +53,34 @@
 
 /* The adm1021 registers */
 /* Read-only */
-#define ADM1021_REG_TEMP 0x00
-#define ADM1021_REG_REMOTE_TEMP 0x01
-#define ADM1021_REG_STATUS 0x02
-#define ADM1021_REG_MAN_ID 0x0FE	/* 0x41 = AMD, 0x49 = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = Onsemi*/
-#define ADM1021_REG_DEV_ID 0x0FF	/* ADM1021 = 0x0X, ADM1023 = 0x3X */
-#define ADM1021_REG_DIE_CODE 0x0FF	/* MAX1617A */
+#define ADM1021_REG_TEMP		0x00
+#define ADM1021_REG_REMOTE_TEMP		0x01
+#define ADM1021_REG_STATUS		0x02
+#define ADM1021_REG_MAN_ID		0x0FE	/* 0x41 = AMD, 0x49 = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = Onsemi*/
+#define ADM1021_REG_DEV_ID		0x0FF	/* ADM1021 = 0x0X, ADM1023 = 0x3X */
+#define ADM1021_REG_DIE_CODE		0x0FF	/* MAX1617A */
 /* These use different addresses for reading/writing */
-#define ADM1021_REG_CONFIG_R 0x03
-#define ADM1021_REG_CONFIG_W 0x09
-#define ADM1021_REG_CONV_RATE_R 0x04
-#define ADM1021_REG_CONV_RATE_W 0x0A
+#define ADM1021_REG_CONFIG_R		0x03
+#define ADM1021_REG_CONFIG_W		0x09
+#define ADM1021_REG_CONV_RATE_R		0x04
+#define ADM1021_REG_CONV_RATE_W		0x0A
 /* These are for the ADM1023's additional precision on the remote temp sensor */
-#define ADM1021_REG_REM_TEMP_PREC 0x010
-#define ADM1021_REG_REM_OFFSET 0x011
-#define ADM1021_REG_REM_OFFSET_PREC 0x012
-#define ADM1021_REG_REM_TOS_PREC 0x013
-#define ADM1021_REG_REM_THYST_PREC 0x014
+#define ADM1021_REG_REM_TEMP_PREC	0x010
+#define ADM1021_REG_REM_OFFSET		0x011
+#define ADM1021_REG_REM_OFFSET_PREC	0x012
+#define ADM1021_REG_REM_TOS_PREC	0x013
+#define ADM1021_REG_REM_THYST_PREC	0x014
 /* limits */
-#define ADM1021_REG_TOS_R 0x05
-#define ADM1021_REG_TOS_W 0x0B
-#define ADM1021_REG_REMOTE_TOS_R 0x07
-#define ADM1021_REG_REMOTE_TOS_W 0x0D
-#define ADM1021_REG_THYST_R 0x06
-#define ADM1021_REG_THYST_W 0x0C
-#define ADM1021_REG_REMOTE_THYST_R 0x08
-#define ADM1021_REG_REMOTE_THYST_W 0x0E
+#define ADM1021_REG_TOS_R		0x05
+#define ADM1021_REG_TOS_W		0x0B
+#define ADM1021_REG_REMOTE_TOS_R	0x07
+#define ADM1021_REG_REMOTE_TOS_W	0x0D
+#define ADM1021_REG_THYST_R		0x06
+#define ADM1021_REG_THYST_W		0x0C
+#define ADM1021_REG_REMOTE_THYST_R	0x08
+#define ADM1021_REG_REMOTE_THYST_W	0x0E
 /* write-only */
-#define ADM1021_REG_ONESHOT 0x0F
+#define ADM1021_REG_ONESHOT		0x0F
 
 
 /* Conversions. Rounding and limit checking is only done on the TO_REG
@@ -88,8 +88,8 @@
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 /* Conversions  note: 1021 uses normal integer signed-byte format*/
-#define TEMP_FROM_REG(val) (val > 127 ? val-256 : val)
-#define TEMP_TO_REG(val)   (SENSORS_LIMIT((val < 0 ? val+256 : val),0,255))
+#define TEMP_FROM_REG(val)	(val > 127 ? val-256 : val)
+#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val < 0 ? val+256 : val),0,255))
 
 /* Initial values */
 
@@ -97,44 +97,43 @@
 they don't quite work like a thermostat the way the LM75 does.  I.e., 
 a lower temp than THYST actually triggers an alarm instead of 
 clearing it.  Weird, ey?   --Phil  */
-#define adm1021_INIT_TOS 60
-#define adm1021_INIT_THYST 20
-#define adm1021_INIT_REMOTE_TOS 60
-#define adm1021_INIT_REMOTE_THYST 20
+#define adm1021_INIT_TOS		60
+#define adm1021_INIT_THYST		20
+#define adm1021_INIT_REMOTE_TOS		60
+#define adm1021_INIT_REMOTE_THYST	20
 
 /* Each client has this additional data */
 struct adm1021_data {
-	int sysctl_id;
 	enum chips type;
 
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	u8 temp, temp_os, temp_hyst;	/* Register values */
-	u8 remote_temp, remote_temp_os, remote_temp_hyst, alarms, die_code;
+	u8	temp_max;	/* Register values */
+	u8	temp_hyst;
+	u8	temp_input;
+	u8	remote_temp_max;
+	u8	remote_temp_hyst;
+	u8	remote_temp_input;
+	u8	alarms;
+	/* special values for ADM1021 only */
+	u8	die_code;
         /* Special values for ADM1023 only */
-	u8 remote_temp_prec, remote_temp_os_prec, remote_temp_hyst_prec, 
-	   remote_temp_offset, remote_temp_offset_prec;
+	u8	remote_temp_prec;
+	u8	remote_temp_os_prec;
+	u8	remote_temp_hyst_prec;
+	u8	remote_temp_offset;
+	u8	remote_temp_offset_prec;
 };
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter);
-static int adm1021_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind);
+static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind);
 static void adm1021_init_client(struct i2c_client *client);
 static int adm1021_detach_client(struct i2c_client *client);
 static int adm1021_read_value(struct i2c_client *client, u8 reg);
 static int adm1021_write_value(struct i2c_client *client, u8 reg,
 			       u16 value);
-static void adm1021_temp(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results);
-static void adm1021_remote_temp(struct i2c_client *client, int operation,
-				int ctl_name, int *nrels_mag,
-				long *results);
-static void adm1021_alarms(struct i2c_client *client, int operation,
-			   int ctl_name, int *nrels_mag, long *results);
-static void adm1021_die_code(struct i2c_client *client, int operation,
-			     int ctl_name, int *nrels_mag, long *results);
 static void adm1021_update_client(struct i2c_client *client);
 
 /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
@@ -151,45 +150,63 @@
 	.detach_client	= adm1021_detach_client,
 };
 
-/* These files are created for each detected adm1021. This is just a template;
-   though at first sight, you might think we could use a statically
-   allocated list, we need some way to get back to the parent - which
-   is done through one of the 'extra' fields which are initialized
-   when a new copy is allocated. */
-static ctl_table adm1021_dir_table_template[] = {
-	{ADM1021_SYSCTL_TEMP, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_temp},
-	{ADM1021_SYSCTL_REMOTE_TEMP, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_remote_temp},
-	{ADM1021_SYSCTL_DIE_CODE, "die_code", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_die_code},
-	{ADM1021_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_alarms},
-	{0}
-};
-
-static ctl_table adm1021_max_dir_table_template[] = {
-	{ADM1021_SYSCTL_TEMP, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_temp},
-	{ADM1021_SYSCTL_REMOTE_TEMP, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_remote_temp},
-	{ADM1021_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_alarms},
-	{0}
-};
-
 /* I choose here for semi-static allocation. Complete dynamic
    allocation could also be used; the code needed for this would probably
    take more memory than the datastructure takes now. */
 static int adm1021_id = 0;
 
+#define show(value)	\
+static ssize_t show_##value(struct device *dev, char *buf)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct adm1021_data *data = i2c_get_clientdata(client);	\
+	int temp;						\
+								\
+	adm1021_update_client(client);				\
+	temp = TEMP_FROM_REG(data->value);			\
+	return sprintf(buf, "%d\n", temp);			\
+}
+show(temp_max);
+show(temp_hyst);
+show(temp_input);
+show(remote_temp_max);
+show(remote_temp_hyst);
+show(remote_temp_input);
+show(alarms);
+show(die_code);
+
+#define set(value, reg)	\
+static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct adm1021_data *data = i2c_get_clientdata(client);	\
+	int temp = simple_strtoul(buf, NULL, 10);		\
+								\
+	data->value = TEMP_TO_REG(temp);			\
+	adm1021_write_value(client, reg, data->value);		\
+	return count;						\
+}
+set(temp_max, ADM1021_REG_TOS_W);
+set(temp_hyst, ADM1021_REG_THYST_W);
+set(remote_temp_max, ADM1021_REG_REMOTE_TOS_W);
+set(remote_temp_hyst, ADM1021_REG_REMOTE_THYST_W);
+
+static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp_min1, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp_max2, S_IWUSR | S_IRUGO, show_remote_temp_max, set_remote_temp_max);
+static DEVICE_ATTR(temp_min2, S_IWUSR | S_IRUGO, show_remote_temp_hyst, set_remote_temp_hyst);
+static DEVICE_ATTR(temp_input2, S_IRUGO, show_remote_temp_input, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR(die_code, S_IRUGO, show_die_code, NULL);
+
+
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, adm1021_detect);
 }
 
-static int adm1021_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind)
+static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
 	struct i2c_client *new_client;
@@ -202,8 +219,7 @@
 	   at this moment; i2c_detect really won't call us. */
 #ifdef DEBUG
 	if (i2c_is_isa_adapter(adapter)) {
-		printk
-		    ("adm1021.o: adm1021_detect called for an ISA bus adapter?!?\n");
+		dev_dbg(&adapter->dev, "adm1021_detect called for an ISA bus adapter?!?\n");
 		return 0;
 	}
 #endif
@@ -232,35 +248,28 @@
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. */
-
 	if (kind < 0) {
-		if (
-		    (adm1021_read_value(new_client, ADM1021_REG_STATUS) &
-		     0x03) != 0x00)
+		if ((adm1021_read_value(new_client, ADM1021_REG_STATUS) & 0x03) != 0x00)
 			goto error1;
 	}
 
 	/* Determine the chip type. */
-
 	if (kind <= 0) {
 		i = adm1021_read_value(new_client, ADM1021_REG_MAN_ID);
 		if (i == 0x41)
-		  if ((adm1021_read_value (new_client, ADM1021_REG_DEV_ID) & 0x0F0) == 0x030)
-			kind = adm1023;
-		  else
-			kind = adm1021;
+			if ((adm1021_read_value(new_client, ADM1021_REG_DEV_ID) & 0x0F0) == 0x030)
+				kind = adm1023;
+			else
+				kind = adm1021;
 		else if (i == 0x49)
 			kind = thmc10;
 		else if (i == 0x23)
 			kind = gl523sm;
 		else if ((i == 0x4d) &&
-			 (adm1021_read_value
-			  (new_client, ADM1021_REG_DEV_ID) == 0x01))
+			 (adm1021_read_value(new_client, ADM1021_REG_DEV_ID) == 0x01))
 			kind = max1617a;
 		/* LM84 Mfr ID in a different place */
-		else
-		    if (adm1021_read_value
-			(new_client, ADM1021_REG_CONV_RATE_R) == 0x00)
+		else if (adm1021_read_value(new_client, ADM1021_REG_CONV_RATE_R) == 0x00)
 			kind = lm84;
 		else if (i == 0x54)
 			kind = mc1066;
@@ -293,10 +302,8 @@
 		type_name = "mc1066";
 		client_name = "MC1066 chip";
 	} else {
-#ifdef DEBUG
-		printk("adm1021.o: Internal error: unknown kind (%d)?!?",
-		       kind);
-#endif
+		dev_err(&adapter->dev, "Internal error: unknown kind (%d)?!?",
+			kind);
 		goto error1;
 	}
 
@@ -312,25 +319,24 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto error3;
 
-	/* Register a new directory entry with module sensors */
-	err = i2c_register_entry(new_client, type_name,
-			(data->type == adm1021) ?
-				adm1021_dir_table_template :
-				adm1021_max_dir_table_template);
-	if (err < 0)
-		goto error4;
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_min1);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max2);
+	device_create_file(&new_client->dev, &dev_attr_temp_min2);
+	device_create_file(&new_client->dev, &dev_attr_temp_input2);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+	if (data->type == adm1021)
+		device_create_file(&new_client->dev, &dev_attr_die_code);
 
-	data->sysctl_id = err;
 	/* Initialize the ADM1021 chip */
 	adm1021_init_client(new_client);
 	return 0;
 
-      error4:
-	i2c_detach_client(new_client);
-      error3:
-      error1:
+error3:
+error1:
 	kfree(new_client);
-      error0:
+error0:
 	return err;
 }
 
@@ -353,21 +359,15 @@
 
 static int adm1021_detach_client(struct i2c_client *client)
 {
-
 	int err;
 
-	i2c_deregister_entry(((struct adm1021_data *) (i2c_get_clientdata(client)))->sysctl_id);
-
 	if ((err = i2c_detach_client(client))) {
-		printk
-		    ("adm1021.o: Client deregistration failed, client not detached.\n");
+		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
 	kfree(client);
-
 	return 0;
-
 }
 
 /* All registers are byte-sized */
@@ -391,39 +391,23 @@
 
 	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
 	    (jiffies < data->last_updated) || !data->valid) {
+		dev_dbg(&client->dev, "Starting adm1021 update\n");
 
-#ifdef DEBUG
-		printk("Starting adm1021 update\n");
-#endif
-
-		data->temp = adm1021_read_value(client, ADM1021_REG_TEMP);
-		data->temp_os =
-		    adm1021_read_value(client, ADM1021_REG_TOS_R);
-		data->temp_hyst =
-		    adm1021_read_value(client, ADM1021_REG_THYST_R);
-		data->remote_temp =
-		    adm1021_read_value(client, ADM1021_REG_REMOTE_TEMP);
-		data->remote_temp_os =
-		    adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
-		data->remote_temp_hyst =
-		    adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
-		data->alarms =
-		    adm1021_read_value(client, ADM1021_REG_STATUS) & 0xec;
+		data->temp_input = adm1021_read_value(client, ADM1021_REG_TEMP);
+		data->temp_max = adm1021_read_value(client, ADM1021_REG_TOS_R);
+		data->temp_hyst = adm1021_read_value(client, ADM1021_REG_THYST_R);
+		data->remote_temp_input = adm1021_read_value(client, ADM1021_REG_REMOTE_TEMP);
+		data->remote_temp_max = adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
+		data->remote_temp_hyst = adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
+		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0xec;
 		if (data->type == adm1021)
-			data->die_code =
-			    adm1021_read_value(client,
-					       ADM1021_REG_DIE_CODE);
+			data->die_code = adm1021_read_value(client, ADM1021_REG_DIE_CODE);
 		if (data->type == adm1023) {
-		  data->remote_temp_prec =
-		    adm1021_read_value(client, ADM1021_REG_REM_TEMP_PREC);
-		  data->remote_temp_os_prec =
-		    adm1021_read_value(client, ADM1021_REG_REM_TOS_PREC);
-		  data->remote_temp_hyst_prec =
-		    adm1021_read_value(client, ADM1021_REG_REM_THYST_PREC);
-		  data->remote_temp_offset =
-		    adm1021_read_value(client, ADM1021_REG_REM_OFFSET);
-		  data->remote_temp_offset_prec =
-		    adm1021_read_value(client, ADM1021_REG_REM_OFFSET_PREC);
+			data->remote_temp_prec = adm1021_read_value(client, ADM1021_REG_REM_TEMP_PREC);
+			data->remote_temp_os_prec = adm1021_read_value(client, ADM1021_REG_REM_TOS_PREC);
+			data->remote_temp_hyst_prec = adm1021_read_value(client, ADM1021_REG_REM_THYST_PREC);
+			data->remote_temp_offset = adm1021_read_value(client, ADM1021_REG_REM_OFFSET);
+			data->remote_temp_offset_prec = adm1021_read_value(client, ADM1021_REG_REM_OFFSET_PREC);
 		}
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -433,6 +417,9 @@
 }
 
 
+/* FIXME, remove these four functions, they are here to verify the sysfs
+ * conversion is correct, or not */
+__attribute__((unused))
 static void adm1021_temp(struct i2c_client *client, int operation,
 			 int ctl_name, int *nrels_mag, long *results)
 {
@@ -442,15 +429,15 @@
 		*nrels_mag = 0;
 	else if (operation == SENSORS_PROC_REAL_READ) {
 		adm1021_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp_os);
+		results[0] = TEMP_FROM_REG(data->temp_max);
 		results[1] = TEMP_FROM_REG(data->temp_hyst);
-		results[2] = TEMP_FROM_REG(data->temp);
+		results[2] = TEMP_FROM_REG(data->temp_input);
 		*nrels_mag = 3;
 	} else if (operation == SENSORS_PROC_REAL_WRITE) {
 		if (*nrels_mag >= 1) {
-			data->temp_os = TEMP_TO_REG(results[0]);
+			data->temp_max = TEMP_TO_REG(results[0]);
 			adm1021_write_value(client, ADM1021_REG_TOS_W,
-					    data->temp_os);
+					    data->temp_max);
 		}
 		if (*nrels_mag >= 2) {
 			data->temp_hyst = TEMP_TO_REG(results[1]);
@@ -460,6 +447,7 @@
 	}
 }
 
+__attribute__((unused))
 static void adm1021_remote_temp(struct i2c_client *client, int operation,
 				int ctl_name, int *nrels_mag, long *results)
 {
@@ -471,68 +459,53 @@
                  else { *nrels_mag = 0; }
 	else if (operation == SENSORS_PROC_REAL_READ) {
 		adm1021_update_client(client);
-		results[0] = TEMP_FROM_REG(data->remote_temp_os);
+		results[0] = TEMP_FROM_REG(data->remote_temp_max);
 		results[1] = TEMP_FROM_REG(data->remote_temp_hyst);
-		results[2] = TEMP_FROM_REG(data->remote_temp);
+		results[2] = TEMP_FROM_REG(data->remote_temp_input);
 		if (data->type == adm1023) {
-		  results[0]=results[0]*1000 + 
-		   ((data->remote_temp_os_prec >> 5) * 125);
-		  results[1]=results[1]*1000 + 
-		   ((data->remote_temp_hyst_prec >> 5) * 125);
-		  results[2]=(TEMP_FROM_REG(data->remote_temp_offset)*1000) + 
-                   ((data->remote_temp_offset_prec >> 5) * 125);
-		  results[3]=TEMP_FROM_REG(data->remote_temp)*1000 + 
-		   ((data->remote_temp_prec >> 5) * 125);
- 		  *nrels_mag = 4;
+			results[0] = results[0]*1000 + ((data->remote_temp_os_prec >> 5) * 125);
+			results[1] = results[1]*1000 + ((data->remote_temp_hyst_prec >> 5) * 125);
+			results[2] = (TEMP_FROM_REG(data->remote_temp_offset)*1000) + ((data->remote_temp_offset_prec >> 5) * 125);
+			results[3] = (TEMP_FROM_REG(data->remote_temp_input)*1000) + ((data->remote_temp_prec >> 5) * 125);
+			*nrels_mag = 4;
 		} else {
- 		  *nrels_mag = 3;
+ 			*nrels_mag = 3;
 		}
 	} else if (operation == SENSORS_PROC_REAL_WRITE) {
 		if (*nrels_mag >= 1) {
 			if (data->type == adm1023) {
-			  prec=((results[0]-((results[0]/1000)*1000))/125)<<5;
-			  adm1021_write_value(client,
-                                            ADM1021_REG_REM_TOS_PREC,
-                                            prec);
-			  results[0]=results[0]/1000;
-			  data->remote_temp_os_prec=prec;
+				prec = ((results[0]-((results[0]/1000)*1000))/125)<<5;
+				adm1021_write_value(client, ADM1021_REG_REM_TOS_PREC, prec);
+				results[0] = results[0]/1000;
+				data->remote_temp_os_prec=prec;
 			}
-			data->remote_temp_os = TEMP_TO_REG(results[0]);
-			adm1021_write_value(client,
-					    ADM1021_REG_REMOTE_TOS_W,
-					    data->remote_temp_os);
+			data->remote_temp_max = TEMP_TO_REG(results[0]);
+			adm1021_write_value(client, ADM1021_REG_REMOTE_TOS_W, data->remote_temp_max);
 		}
 		if (*nrels_mag >= 2) {
 			if (data->type == adm1023) {
-			  prec=((results[1]-((results[1]/1000)*1000))/125)<<5;
-			  adm1021_write_value(client,
-                                            ADM1021_REG_REM_THYST_PREC,
-                                            prec);
-			  results[1]=results[1]/1000;
-			  data->remote_temp_hyst_prec=prec;
+				prec = ((results[1]-((results[1]/1000)*1000))/125)<<5;
+				adm1021_write_value(client, ADM1021_REG_REM_THYST_PREC, prec);
+				results[1] = results[1]/1000;
+				data->remote_temp_hyst_prec=prec;
 			}
 			data->remote_temp_hyst = TEMP_TO_REG(results[1]);
-			adm1021_write_value(client,
-					    ADM1021_REG_REMOTE_THYST_W,
-					    data->remote_temp_hyst);
+			adm1021_write_value(client, ADM1021_REG_REMOTE_THYST_W, data->remote_temp_hyst);
 		}
 		if (*nrels_mag >= 3) {
 			if (data->type == adm1023) {
-			  prec=((results[2]-((results[2]/1000)*1000))/125)<<5;
-			  adm1021_write_value(client,
-                                            ADM1021_REG_REM_OFFSET_PREC,
-                                            prec);
-			  results[2]=results[2]/1000;
-			  data->remote_temp_offset_prec=prec;
-			  data->remote_temp_offset=results[2];
-			  adm1021_write_value(client,
-                                            ADM1021_REG_REM_OFFSET,
-                                            data->remote_temp_offset);
+				prec = ((results[2]-((results[2]/1000)*1000))/125)<<5;
+				adm1021_write_value(client, ADM1021_REG_REM_OFFSET_PREC, prec);
+				results[2]=results[2]/1000;
+				data->remote_temp_offset_prec=prec;
+				data->remote_temp_offset=results[2];
+				adm1021_write_value(client, ADM1021_REG_REM_OFFSET, data->remote_temp_offset);
 			}
 		}
 	}
 }
 
+__attribute__((unused))
 static void adm1021_die_code(struct i2c_client *client, int operation,
 			     int ctl_name, int *nrels_mag, long *results)
 {
@@ -549,6 +522,7 @@
 	}
 }
 
+__attribute__((unused))
 static void adm1021_alarms(struct i2c_client *client, int operation,
 			   int ctl_name, int *nrels_mag, long *results)
 {
@@ -574,8 +548,8 @@
 	i2c_del_driver(&adm1021_driver);
 }
 
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl> and "
+		"Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("adm1021 driver");
 MODULE_LICENSE("GPL");
 

