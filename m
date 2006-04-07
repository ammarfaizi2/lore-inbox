Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWDGSza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWDGSza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWDGSz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:55:29 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:25149 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S964878AbWDGSz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:55:28 -0400
In-Reply-To: <Pine.LNX.4.44.0603301711240.10382-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0603301711240.10382-100000@gate.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
X-Gpgmail-State: !signed
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8F6363F6-83DE-40EF-B7F2-CBF48952CCE5@kernel.crashing.org>
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org,
       <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] i2c: pca954x I2C mux driver
Date: Fri, 7 Apr 2006 13:55:27 -0500
To: Kumar Gala <galak@kernel.crashing.org>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any comment or acceptance of this patch?

- k

On Mar 30, 2006, at 5:11 PM, Kumar Gala wrote:

> Driver for the Phillips pca954x I2C mux/switches devices.  These  
> devices handle
> the fact that a number of I2C devices have limited address  
> selection capablities
> and systems may end up having to mux to access all the I2C devices.
>
> The driver uses the i2c virtual adapter support to make each mux/ 
> switch port
> look like its own i2c bus.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> ---
> commit 735344d2f587938da9012070f881b725269c4dc9
> tree a12c50c7f3d34b44e33397863dc7e57f8fd0e3ec
> parent 862cbc263e3d3e44028d7465a912847cf5366163
> author Kumar Gala <galak@kernel.crashing.org> Thu, 30 Mar 2006  
> 17:05:14 -0600
> committer Kumar Gala <galak@kernel.crashing.org> Thu, 30 Mar 2006  
> 17:05:14 -0600
>
>  drivers/i2c/chips/Kconfig   |   10 +
>  drivers/i2c/chips/Makefile  |    1
>  drivers/i2c/chips/pca954x.c |  320 ++++++++++++++++++++++++++++++++ 
> +++++++++++
>  include/linux/i2c-id.h      |    1
>  4 files changed, 332 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index 7aa5c38..894c95e 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -56,6 +56,16 @@ config SENSORS_PCA9539
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called pca9539.
>
> +config SENSORS_PCA954x
> +	tristate "Philips PCA954x I2C Mux/switches"
> +	depends on I2C && I2C_VIRT && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the Philips PCA954x
> +	  I2C mux/switch devices.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called pca954x.
> +
>  config SENSORS_PCF8591
>  	tristate "Philips PCF8591"
>  	depends on I2C && EXPERIMENTAL
> diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
> index 779868e..e69190d 100644
> --- a/drivers/i2c/chips/Makefile
> +++ b/drivers/i2c/chips/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
>  obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
>  obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
>  obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
> +obj-$(CONFIG_SENSORS_PCA954x)	+= pca954x.o
>  obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>  obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
> diff --git a/drivers/i2c/chips/pca954x.c b/drivers/i2c/chips/pca954x.c
> new file mode 100644
> index 0000000..f300493
> --- /dev/null
> +++ b/drivers/i2c/chips/pca954x.c
> @@ -0,0 +1,320 @@
> +/*
> + * pca954x.c - Part of lm_sensors, Linux kernel modules for hardware
> + *             monitoring
> + * This module supports the PCA954x series of I2C multiplexer/ 
> switch chips
> + * made by Philips Semiconductors.  This includes the
> + *	PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547  
> and PCA9548.
> + *
> + * These chips are all controlled via the I2C bus itself, and all  
> have a
> + * single 8-bit register (normally at 0x70).  The upstream  
> "parent" bus fans
> + * out to two, four, or eight downstream busses or channels; which  
> of these
> + * are selected is determined by the chip type and register  
> contents.  A
> + * mux can select only one sub-bus at a time; a switch can select any
> + * combination simultaneously.
> + *
> + * Based on:
> + *    pca954x.c from Ken Harrenstien
> + * Copyright (C) 2004 Google, Inc. (Ken Harrenstien)
> + *
> + * Based on:
> + *    i2c-virtual_cb.c from Brian Kuschak <bkuschak@yahoo.com>
> + * and
> + *    pca9540.c from Jean Delvare <khali@linux-fr.org>, which was
> + *	based on pcf8574.c from the same project by Frodo Looijaard,
> + *	Philip Edelbrock, Dan Eaton and Aurelien Jarno.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +
> +#define PCA954X_MAX_NCHANS 8
> +
> +static struct i2c_driver pca954x_driver;
> +
> +/* Addresses to scan: none. These chip cannot be detected. */
> +static unsigned short normal_i2c[] = { I2C_CLIENT_END };
> +
> +/* Chip type must normally be specified using a parameter of the form
> +	"force_pca9544=0,0x70"
> +   The following declares the possible types.
> +*/
> +I2C_CLIENT_INSMOD_8(pca9540, pca9542, pca9543, pca9544,
> +		    pca9545, pca9546, pca9547, pca9548);
> +
> +struct pca954x_chipdef {
> +	enum chips type;
> +	const char *name;
> +	u8 nchans;
> +	u8 enable;		/* used for muxes only */
> +	enum muxtype { pca954x_ismux = 0, pca954x_isswi } muxtype;
> +};
> +
> +/* Provide specs for the PCA954x types we know about */
> +static struct pca954x_chipdef pca954x_chipdefs[] = {
> +	{
> +		.type = pca9540,
> +		.name = "pca9540",
> +		.nchans = 2,
> +		.enable = 0x4,
> +		.muxtype = pca954x_ismux,
> +	},
> +	{
> +		.type = pca9542,
> +		.name = "pca9542",
> +		.nchans = 2,
> +		.enable = 0x4,
> +		.muxtype = pca954x_ismux,
> +	},
> +	{
> +		.type = pca9543,
> +		.name = "pca9543",
> +		.nchans = 2,
> +		.enable = 0x0,
> +		.muxtype = pca954x_isswi,
> +	},
> +	{
> +		.type = pca9544,
> +		.name = "pca9544",
> +		.nchans = 4,
> +		.enable = 0x4,
> +		.muxtype = pca954x_ismux,
> +	},
> +	{
> +		.type = pca9545,
> +		.name = "pca9545",
> +		.nchans = 4,
> +		.enable = 0x0,
> +		.muxtype = pca954x_isswi,
> +	},
> +	{
> +		.type = pca9546,
> +		.name = "pca9546",
> +		.nchans = 4,
> +		.enable = 0x0,
> +		.muxtype = pca954x_isswi,
> +	},
> +	{
> +		.type = pca9547,
> +		.name = "pca9547",
> +		.nchans = 8,
> +		.enable = 0x8,
> +		.muxtype = pca954x_ismux,
> +	},
> +	{
> +		.type = pca9548,
> +		.name = "pca9548",
> +		.nchans = 8,
> +		.enable = 0x0,
> +		.muxtype = pca954x_isswi,
> +	},
> +};
> +
> +struct pca954x_data {
> +	struct i2c_client client;
> +	unsigned int chip_offset;
> +	u8 last_chan;
> +	struct i2c_adapter *virt_adapters[PCA954X_MAX_NCHANS];
> +};
> +
> +static int pca954x_xfer(struct i2c_adapter *adap,
> +			struct i2c_client *client, int read_write, u8 * val)
> +{
> +	int ret = -ENODEV;
> +
> +	if (adap->algo->master_xfer) {
> +		struct i2c_msg msg;
> +		char buf[1];
> +
> +		msg.addr = client->addr;
> +		msg.flags = (read_write == I2C_SMBUS_READ ? I2C_M_RD : 0);
> +		msg.len = 1;
> +		buf[0] = *val;
> +		msg.buf = buf;
> +		ret = adap->algo->master_xfer(adap, &msg, 1);
> +	} else if (adap->algo->smbus_xfer) {
> +		union i2c_smbus_data data;
> +		ret = adap->algo->smbus_xfer(adap,
> +					     client->addr,
> +					     client->flags & I2C_M_TEN,
> +					     read_write,
> +					     *val, I2C_SMBUS_BYTE, &data);
> +	}
> +
> +	return ret;
> +}
> +
> +static int pca954x_select_chan(struct i2c_adapter *adap,
> +			       struct i2c_client *client, u32 chan)
> +{
> +	struct pca954x_data *data = i2c_get_clientdata(client);
> +	struct pca954x_chipdef *chip = &pca954x_chipdefs[data->chip_offset];
> +	u8 regval = 0;
> +	int ret = 0;
> +
> +	/* we make switches look like muxes, not sure how to be smarter */
> +	if (chip->muxtype == pca954x_ismux)
> +		regval = chan | chip->enable;
> +	else
> +		regval = 1 << chan;
> +
> +	/* Only select the channel if its different from the last channel */
> +	if (data->last_chan != chan) {
> +		ret = pca954x_xfer(adap, client, I2C_SMBUS_WRITE, &regval);
> +		data->last_chan = chan;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pca954x_deselect_mux(struct i2c_adapter *adap,
> +				struct i2c_client *client, u32 value)
> +{
> +	/* We never deselect, just stay on the last channel we selected */
> +	return 0;
> +}
> +
> +static int pca954x_detect(struct i2c_adapter *bus, int address,  
> int kind)
> +{
> +	int i, n;
> +	struct i2c_client *client;
> +	struct pca954x_data *data;
> +	int ret = -ENODEV;
> +
> +	if (!i2c_check_functionality(bus, I2C_FUNC_SMBUS_BYTE))
> +		goto err;
> +
> +	if (!(data = kzalloc(sizeof(struct pca954x_data), GFP_KERNEL))) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	client = &data->client;
> +	client->addr = address;
> +	client->adapter = bus;
> +	client->driver = &pca954x_driver;
> +	client->flags = 0;
> +	i2c_set_clientdata(client, data);
> +	if (kind < 0) {
> +		dev_err(&bus->dev, "Attempted ill-advised probe at addr 0x%x\n",
> +			address);
> +		goto exit_free;
> +	}
> +
> +	/* Read the mux register at addr.  This does two things: it verifies
> +	   that the mux is in fact present, and fetches its current
> +	   contents for possible use with a future deselect algorithm.
> +	 */
> +	if ((i = i2c_smbus_read_byte(client)) < 0) {
> +		dev_warn(&bus->dev, "pca954x failed to read reg at 0x%x\n",
> +			 address);
> +		goto exit_free;
> +	}
> +
> +	if (kind == any_chip) {
> +		dev_warn(&bus->dev, "pca954x needs advice on chip type - "
> +			 "wildly guessing 0x%x is a PCA9540\n", address);
> +		kind = pca9540;
> +	}
> +
> +	/* Look up in table */
> +	for (i = sizeof(pca954x_chipdefs) / sizeof(pca954x_chipdefs[0]);
> +	     --i >= 0;) {
> +		if (pca954x_chipdefs[i].type == kind)
> +			break;
> +	}
> +	if (i < 0) {
> +		dev_err(&bus->dev, "Internal error: unknown kind (%d)\n", kind);
> +		goto exit_free;
> +	}
> +
> +	data->chip_offset = i;
> +
> +	if ((ret = i2c_attach_client(client)))
> +		goto exit_free;
> +
> +	/* Now create virtual busses and adapters for them */
> +	for (i = 0; i < pca954x_chipdefs[data->chip_offset].nchans; i++) {
> +		data->virt_adapters[i] =
> +		    i2c_add_virt_adapter(bus, client, i,
> +					 &pca954x_select_chan,
> +					 &pca954x_deselect_mux);
> +		if (data->virt_adapters[i] == NULL) {
> +			ret = -ENODEV;
> +			goto virt_reg_failed;
> +		}
> +	}
> +
> +	dev_info(&client->dev,
> +		 "Registered %d virtual busses for I2C %s %s\n", i,
> +		 pca954x_chipdefs[data->chip_offset].muxtype == pca954x_ismux ?
> +		 "mux" : "switch", pca954x_chipdefs[data->chip_offset].name);
> +
> +	return 0;
> +
> +virt_reg_failed:
> +	for (n = 0; n < i; n++)
> +		i2c_del_virt_adapter(data->virt_adapters[n]);
> +	i2c_detach_client(client);
> +exit_free:
> +	kfree(data);
> +err:
> +	return ret;
> +}
> +
> +static int pca954x_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	return i2c_probe(adapter, &addr_data, pca954x_detect);
> +}
> +
> +static int pca954x_detach_client(struct i2c_client *client)
> +{
> +	struct pca954x_data *data = i2c_get_clientdata(client);
> +	struct pca954x_chipdef *chip = &pca954x_chipdefs[data->chip_offset];
> +	int i, err;
> +
> +	for (i = 0; i < chip->nchans; ++i) {
> +		if (data->virt_adapters[i]) {
> +			if ((err =
> +			     i2c_del_virt_adapter(data->virt_adapters[i])))
> +				return err;
> +			data->virt_adapters[i] = NULL;
> +		}
> +	}
> +
> +	if ((err = i2c_detach_client(client)))
> +		return err;
> +
> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct i2c_driver pca954x_driver = {
> +	.driver = {
> +		   .name = "pca954x",
> +		   },
> +	.id = I2C_DRIVERID_PCA954X,
> +	.attach_adapter = pca954x_attach_adapter,
> +	.detach_client = pca954x_detach_client,
> +};
> +
> +static int __init pca954x_init(void)
> +{
> +	return i2c_add_driver(&pca954x_driver);
> +}
> +
> +static void __exit pca954x_exit(void)
> +{
> +	i2c_del_driver(&pca954x_driver);
> +}
> +
> +module_init(pca954x_init);
> +module_exit(pca954x_exit);
> +
> +MODULE_AUTHOR("Kumar Gala <galak@kernel.crashing.org>");
> +MODULE_DESCRIPTION("PCA954X I2C mux/switch driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
> index 66d5533..f8f7f20 100644
> --- a/include/linux/i2c-id.h
> +++ b/include/linux/i2c-id.h
> @@ -112,6 +112,7 @@
>  #define I2C_DRIVERID_X1205	82	/* Xicor/Intersil X1205 RTC	*/
>  #define I2C_DRIVERID_PCF8563	83	/* Philips PCF8563 RTC		*/
>  #define I2C_DRIVERID_RS5C372	84	/* Ricoh RS5C372 RTC		*/
> +#define I2C_DRIVERID_PCA954X	85	/* pca954x I2C mux/switch	*/
>
>  #define I2C_DRIVERID_I2CDEV	900
>  #define I2C_DRIVERID_ARP        902    /* SMBus ARP  
> Client              */
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

