Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVCBJqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVCBJqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVCBJqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:46:06 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:29177 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262246AbVCBJpl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:45:41 -0500
Date: Wed, 2 Mar 2005 10:43:43 +0100 (CET)
To: jchapman@katalix.com
Subject: Re: [PATCH: 2.6.11-rc5] i2c chips: ds1337 RTC driver
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <cIyC5ZN2.1109756623.5808030.khali@localhost>
In-Reply-To: <4224C0D4.2060303@katalix.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "LKML" <linux-kernel@vger.kernel.org>, "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

> diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> --- a/drivers/i2c/chips/Kconfig	2005-02-27 20:42:22 +00:00
> +++ b/drivers/i2c/chips/Kconfig	2005-02-27 20:42:22 +00:00
> @@ -62,6 +62,17 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called asb100.
> 
> +config SENSORS_DS1337
> +      	tristate "Dallas Semiconductor DS1337 Real Time Clock"
> +	depends on I2C && EXPERIMENTAL
> +	select I2C_SENSOR
> +	help
> +	  If you say yes here you get support for Dallas Semiconductor
> +	  DS1337 real-time clock chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called ds1337.
> +
>  config SENSORS_DS1621
>        	tristate "Dallas Semiconductor DS1621 and DS1625"
>  	depends on I2C && EXPERIMENTAL

I don't think it belongs there. The DS1337 is not a hardware monitoring
chip, please move it down to the "Other I2C Chip support" menu. I also
think I see an indentation issue on the "tristate" line, seemingly
copied from the SENSORS_DS1621 section which would need to be fixed as
well.

> +static struct i2c_driver ds1337_driver = {
> +	.owner		= THIS_MODULE,
> +	.name		= "ds1337",
> +	.id		= I2C_DRIVERID_DS1337,
> +	.flags		= I2C_DF_NOTIFY,
> +	.attach_adapter	= ds1337_attach_adapter,
> +	.detach_client	= ds1337_detach_client,
> +	.command	= ds1337_command,
> +};

I2C_DRIVERID_DS1337 isn't defined anywhere that I can see, so your
driver will hardly compile. You don't seem to actually need a driver
id, so you can simply omit it.

> +static inline int ds1337_read(struct i2c_client *client, u8 reg, u8
> 	*value)
> +{
> +	s32 tmp = i2c_smbus_read_byte_data(client, reg);
> +
> +	if (tmp < 0)
> +		return -EIO;
> +
> +	*value = (u8) (tmp & 0xff);
> +
> +	return 0;
> +}

The bitmasking is a no-op, and so is probably the cast as I'd expect the
compiler to do the right thing on its own.

> +static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time > 	*dt)
> +{
> (...)
> +	if (!dt || !client) {

How could client be NULL? Same question for ds1337_set_datetime.

> +	memset(buf, 0, sizeof(buf));

Why is this memset needed at all?

> +	result = client->adapter->algo->master_xfer(client->adapter,
> +						    &msg[0],
> +						    2);

You did not check that the adapter was capable of raw I2C transfers.

> +static int ds1337_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	if (!(adapter->class & I2C_CLASS_HWMON))
> +		return 0;

You do not want to check that. The DS1337 is not a hardware monitoring
device!

> +static int ds1337_detect(struct i2c_adapter *adapter, int address, int
>	kind)
+{
+	struct i2c_client *new_client;
+	struct ds1337_data *data;
+	int err = 0;
+	const char *name = "";
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;

You must verify the ability to do raw I2C transfers here, as said above.

+	err = -ENODEV;

Not correct. The detection function should NOT return a non-zero value
unless it meets a critical error (such as memory shortage). Just finding
a different device from what you were looking for isn't an error.

> +		/* Check that control register bits 5-6 are zero */
> +		if (buf[14] & ((1 << 5) | (1 << 6)))
> +			goto exit_free;
> +
> +		/* Check that status register bits 2-6 are zero */
> +		if (buf[15] & ((1 << 2) | (1 << 3) | (1 << 4) |
> +			       (1 << 5) | (1 << 6)))
> +			goto exit_free;

These would be much more readable as "& 0x60" and "& 0x7c" if you
want my opinion (but maybe it's just me). Also, I usually write "bits
6-2", not "2-6" (but again that might be just me).

> +	new_client->id = ds1337_id++;

Client ids are not used by the core and were dropped recently. Don't use
that struct member.

> +static void ds1337_init_client(struct i2c_client *client)
> +{
> +	u8 val;
> +
> +	/* Ensure that device is set in 24-hour mode */
> +	val = i2c_smbus_read_byte_data(client, 2);
> +	i2c_smbus_write_byte_data(client, 2, val | (1 << 6));
> +}

You can probably spare a write if the device was already in 24-hour mode.
It might also be nice to give register 2 a name (DS1337_REG_CONFIG?) and
use that.

Also note that you are not handling errors properly here. You could get
-1 returned from the read, forcing all bits of the register to 1 on
subsequent write.

--
Jean Delvare
