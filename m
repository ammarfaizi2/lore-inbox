Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSLAXbY>; Sun, 1 Dec 2002 18:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSLAXbY>; Sun, 1 Dec 2002 18:31:24 -0500
Received: from surf.cadcamlab.org ([156.26.20.182]:49572 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S262828AbSLAXbW>; Sun, 1 Dec 2002 18:31:22 -0500
Date: Sun, 1 Dec 2002 17:34:51 -0600
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: i2c-amd766 driver for 2.5.50
Message-ID: <20021201233451.GB4182@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cosmetic stuff..

> --- clean.2.5/drivers/i2c/busses/Makefile 2002-12-01 16:56:56.000000000 +0100
> +++ linux-sensors/drivers/i2c/busses/Makefile 2002-12-01 17:57:14.000000000 +0100
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for the kernel hardware sensors bus drivers.
> +#
> +
> +MOD_LIST_NAME := SENSORS_BUS_MODULES
> +
> +obj-$(CONFIG_I2C_MAINBOARD) += i2c-mainboard.o
> +obj-$(CONFIG_I2C_AMD756) += i2c-amd756.o
> +
> +include $(TOPDIR)/Rules.make

MOD_LIST_NAME was deprecated in 2.3.  'include Rules.make' was
deprecated in 2.5.  Also appears in drivers/i2c/chips/Makefile.

> +#ifndef PCI_DEVICE_ID_AMD_756
> +#define PCI_DEVICE_ID_AMD_756 0x740B
> +#endif
> +#ifndef PCI_DEVICE_ID_AMD_766
> +#define PCI_DEVICE_ID_AMD_766 0x7413
> +#endif
> +#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS 0x01B4
> +#endif

These are all in pci_ids.h already, under other names.  If these names
are better, they should replace the others.

> +struct sd {
> +	const unsigned short vendor;
> +	const unsigned short device;
> +	const unsigned short function;
> +	const char* name;
> +	int amdsetup:1;
> +};
> +
> +static struct sd supported[] = {
> +	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_756, 3, "AMD756", 1},
> +	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_766, 3, "AMD766", 1},
> +	{PCI_VENDOR_ID_AMD, 0x7443, 3, "AMD768", 1},
> +	{PCI_VENDOR_ID_NVIDIA, 0x01B4, 1, "nVidia nForce", 0},
> +	{0, 0, 0}
> +};

You should also have a struct pci_device_id[] here, so you can have a
MODULE_DEVICE_TABLE().

> +/* OK, this is not exactly good programming practice, usually. But it is
> +   very code-efficient in this case. */
> +
> +      ERROR4:
> +	i2c_detach_client(new_client);

No need to apologise for goto error unwinding - it's all over the kernel.

> +void adm1021_dec_use(struct i2c_client *client)
> +{
> +#ifdef MODULE
> +	MOD_DEC_USE_COUNT;
> +#endif
> +}

No need for #ifdef.  Also found in lm75_inc_use() and elsewhere.

> +void adm1021_update_client(struct i2c_client *client)
> +{
> +	struct adm1021_data *data = client->data;
> +
> +	down(&data->update_lock);
> +
> +	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
> +	    (jiffies < data->last_updated) || !data->valid) {

	if (time_after(jiffies, data->last_updated + HZ+HZ/2) || !data->valid) {

It *appears* the (jiffies < data->last_updated) test is unnecessary.

> +EXPORT_NO_SYMBOLS;

Deprecated (from lm75.c).

General comment: what's up with /proc/sys/dev/ versus /proc/driver/
versus sysfs?  Do we really need all three?

Peter
