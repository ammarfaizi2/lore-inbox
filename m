Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbTCZUQS>; Wed, 26 Mar 2003 15:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbTCZUQS>; Wed, 26 Mar 2003 15:16:18 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4102 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262065AbTCZUQE>;
	Wed, 26 Mar 2003 15:16:04 -0500
Date: Wed, 26 Mar 2003 12:26:23 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, sensors@stimpy.netroedge.com
Subject: Re: w83781d i2c driver updated for 2.5.66 (without sysfs support)
Message-ID: <20030326202622.GJ24689@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E82024A.4000809@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 08:40:58PM +0100, Jan Dittmer wrote:
> Martin Schlemmer wrote:
> >
> >I did look at the changes needed for sysfs, but this beast have
> >about 6 ctl_tables, and is hairy in general.  I am not sure what
> >is the best way to do it for the different chips, so here is what
> >I have until I or somebody else can do the sysfs stuff.
> >
> I've just done this with the via686a driver. Saves about 100 lines of code.
> 
> Comments?

<snip>

> +/* following are the sysfs callback functions */
> +static ssize_t show_in(struct device *dev, char *buf, int nr) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct via686a_data *data = i2c_get_clientdata(client);
> +	via686a_update_client(client);
> +
> +	return sprintf(buf,"%ld %ld %ld\n",
> +		IN_FROM_REG(data->in_min[nr], nr),
> +		IN_FROM_REG(data->in_max[nr], nr),
> +		IN_FROM_REG(data->in[nr], nr) );
> +}

We should really split these multivalue files up into individual files,
as sysfs is for single value files.  Makes parsing easier too.

Here's a patch for the lm75.c driver that does this.  As we are going to
need a "generic" read and write for the "real" values that the i2c
drivers use, I added these files to the i2c-proc.c file.

Yes, i2c_read_real() doesn't really work just yet :)

Anyway, I think this is the direction we should be moving to.  And what
is "temp_os" and "temp_hyst"?  Should these files be named something a
bit more descriptive?

thanks,

greg k-h

diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Wed Mar 26 12:28:45 2003
+++ b/drivers/i2c/chips/lm75.c	Wed Mar 26 12:28:45 2003
@@ -102,6 +102,49 @@
 
 static int lm75_id = 0;
 
+#define show(value)	\
+static ssize_t show_##value(struct device *dev, char *buf)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct lm75_data *data = i2c_get_clientdata(client);	\
+	int temp;						\
+								\
+	lm75_update_client(client);				\
+	temp = TEMP_FROM_REG(data->value);			\
+	return i2c_write_real(buf, temp, 1);			\
+}
+show(temp);
+show(temp_os);
+show(temp_hyst);
+
+static ssize_t set_temp_os(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm75_data *data = i2c_get_clientdata(client);
+	int temp;
+
+	i2c_read_real(buf, &temp, 1);
+	data->temp_os = TEMP_TO_REG(temp);
+	lm75_write_value(client, LM75_REG_TEMP_OS, data->temp_os);
+	return count;
+}
+
+static ssize_t set_temp_hyst(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm75_data *data = i2c_get_clientdata(client);
+	int temp;
+
+	i2c_read_real(buf, &temp, 1);
+	data->temp_hyst = TEMP_TO_REG(temp);
+	lm75_write_value(client, LM75_REG_TEMP_HYST, data->temp_hyst);
+	return count;
+}
+
+static DEVICE_ATTR(temp, S_IRUGO, show_temp, NULL);
+static DEVICE_ATTR(temp_os, 0644, show_temp_os, set_temp_os);
+static DEVICE_ATTR(temp_hyst, 0644, show_temp_hyst, set_temp_hyst);
+
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, lm75_detect);
@@ -192,6 +235,10 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto error3;
 
+	device_create_file(&new_client->dev, &dev_attr_temp);
+	device_create_file(&new_client->dev, &dev_attr_temp_os);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
+
 	/* Register a new directory entry with module sensors */
 	i = i2c_register_entry(new_client, type_name, lm75_dir_table_template);
 	if (i < 0) {
diff -Nru a/drivers/i2c/i2c-proc.c b/drivers/i2c/i2c-proc.c
--- a/drivers/i2c/i2c-proc.c	Wed Mar 26 12:28:45 2003
+++ b/drivers/i2c/i2c-proc.c	Wed Mar 26 12:28:45 2003
@@ -381,6 +381,14 @@
 	return ret;
 }
 
+int i2c_read_real(const char *buf, int *real, int magnitude)
+{
+	char *temp;
+
+	*real = simple_strtoul(buf, &temp, 10);
+
+	return 0;
+}
 
 /* nrels contains initially the maximum number of elements which can be
    put in results, and finally the number of elements actually put there.
@@ -499,6 +507,29 @@
 	return 0;
 }
 
+int i2c_write_real(char *buf, int real, int magnitude)
+{
+	char printfstr[12];
+	int mag;
+	int times;
+	int field_location;
+
+	mag = magnitude;
+	for (times = 1; mag-- > 0; times *= 10)
+		;
+
+	if (real < 0) {
+		strcpy(printfstr, "-%ld.%0Xld");
+		field_location = 7;
+	} else {
+		strcpy(printfstr, "%ld.%0Xld");
+		field_location = 6;
+	}
+	printfstr[field_location] = magnitude + '0';
+	real = abs(real);
+	return sprintf(buf, printfstr, real / times, real % times);
+}
+
 static int i2c_write_reals(int nrels, void *buffer, size_t *bufsize,
 			 long *results, int magnitude)
 {
@@ -724,6 +755,8 @@
 EXPORT_SYMBOL(i2c_proc_real);
 EXPORT_SYMBOL(i2c_sysctl_real);
 EXPORT_SYMBOL(i2c_detect);
+EXPORT_SYMBOL(i2c_write_real);
+EXPORT_SYMBOL(i2c_read_real);
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("i2c-proc driver");
diff -Nru a/include/linux/i2c-proc.h b/include/linux/i2c-proc.h
--- a/include/linux/i2c-proc.h	Wed Mar 26 12:28:45 2003
+++ b/include/linux/i2c-proc.h	Wed Mar 26 12:28:45 2003
@@ -410,5 +410,8 @@
 	char name[SENSORS_PREFIX_MAX + 13];
 };
 
+extern int i2c_write_real(char *buf, int real, int magnitude);
+extern int i2c_read_real(const char *buf, int *real, int magnitude);
+
 #endif				/* def _LINUX_I2C_PROC_H */
 
