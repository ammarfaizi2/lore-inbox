Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSLBArh>; Sun, 1 Dec 2002 19:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSLBArh>; Sun, 1 Dec 2002 19:47:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61198 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262924AbSLBArf>; Sun, 1 Dec 2002 19:47:35 -0500
Date: Mon, 2 Dec 2002 01:55:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: i2c-amd766 driver for 2.5.50
Message-ID: <20021202005502.GA30652@atrey.karlin.mff.cuni.cz>
References: <20021201233451.GB4182@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021201233451.GB4182@cadcamlab.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +MOD_LIST_NAME := SENSORS_BUS_MODULES
> > +
> > +obj-$(CONFIG_I2C_MAINBOARD) += i2c-mainboard.o
> > +obj-$(CONFIG_I2C_AMD756) += i2c-amd756.o
> > +
> > +include $(TOPDIR)/Rules.make
> 
> MOD_LIST_NAME was deprecated in 2.3.  'include Rules.make' was
> deprecated in 2.5.  Also appears in drivers/i2c/chips/Makefile.

I agree with MOD_LIST_NAME, but I still see include
$(TOPDIR)/Rules.make used all over the kernel, so I kept it.

> > +#ifndef PCI_DEVICE_ID_AMD_756
> > +#define PCI_DEVICE_ID_AMD_756 0x740B
> > +#endif
> > +#ifndef PCI_DEVICE_ID_AMD_766
> > +#define PCI_DEVICE_ID_AMD_766 0x7413
> > +#endif
> > +#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS
> > +#define PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS 0x01B4
> > +#endif
> 
> These are all in pci_ids.h already, under other names.  If these names
> are better, they should replace the others.

Fixed.

> > +struct sd {
> > +	const unsigned short vendor;
> > +	const unsigned short device;
> > +	const unsigned short function;
> > +	const char* name;
> > +	int amdsetup:1;
> > +};
> > +
> > +static struct sd supported[] = {
> > +	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_756, 3, "AMD756", 1},
> > +	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_766, 3, "AMD766", 1},
> > +	{PCI_VENDOR_ID_AMD, 0x7443, 3, "AMD768", 1},
> > +	{PCI_VENDOR_ID_NVIDIA, 0x01B4, 1, "nVidia nForce", 0},
> > +	{0, 0, 0}
> > +};
> 
> You should also have a struct pci_device_id[] here, so you can have a
> MODULE_DEVICE_TABLE().

This one will have to wait...

> > +/* OK, this is not exactly good programming practice, usually. But it is
> > +   very code-efficient in this case. */
> 
> No need to apologise for goto error unwinding - it's all over the
> > kernel.

Yep, killed comment.

> > +void adm1021_dec_use(struct i2c_client *client)
> > +{
> > +#ifdef MODULE
> > +	MOD_DEC_USE_COUNT;
> > +#endif
> > +}
> 
> No need for #ifdef.  Also found in lm75_inc_use() and elsewhere.

Agreed, killed those I could find quickly.

> > +void adm1021_update_client(struct i2c_client *client)
> > +{
> > +	struct adm1021_data *data = client->data;
> > +
> > +	down(&data->update_lock);
> > +
> > +	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
> > +	    (jiffies < data->last_updated) || !data->valid) {
> 
> 	if (time_after(jiffies, data->last_updated + HZ+HZ/2) || !data->valid) {
> 
> It *appears* the (jiffies < data->last_updated) test is unnecessary.

I guess I'd better leave it alone :-).

> > +EXPORT_NO_SYMBOLS;
> 
> Deprecated (from lm75.c).

Killed.

> General comment: what's up with /proc/sys/dev/ versus /proc/driver/
> versus sysfs?  Do we really need all three?

sensors are sysctl-capable, /proc/sys/dev/ is just side effect, IIRC.

								Pavel 

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
