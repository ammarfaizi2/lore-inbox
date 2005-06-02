Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFBKKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFBKKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 06:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVFBKKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 06:10:20 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:47295 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261266AbVFBKKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 06:10:02 -0400
Subject: Re: [RFC] SPI core
From: dmitry pervushin <dpervushin@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
In-Reply-To: <20050531233215.GB23881@kroah.com>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
	 <20050531233215.GB23881@kroah.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 14:09:59 +0400
Message-Id: <1117706999.4715.54.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 16:32 -0700, Greg KH wrote:

Thanks for you comments; my answers follow. This patch will be reworked
in short time.

> Is this code intergrated into the driver model?
It will be.
> What does the /sys/ tree look like?
> Why are you using a char device node?
Because it's not a block device :) I assume that's common practice to
access low-level devices, isn't it ?
> 
> > +/**
> > + * spi_add_adapter - register a new SPI bus adapter
> > + * @adap: spi_adapter structure for the registering adapter
> > + *
> > + * Make the adapter available for use by clients using name adap->name.
> > + * The adap->adapters list is initialised by this function.
> > + *
> > + * Returns 0;
> 
> You have this a lot.  If the function can not fail, just make it a void
> type :)
I'd like to keep this of type int because of possible future
enhancements
> > +	list_for_each(l, &driver_list) {
> 
> list_for_each_entry() please.
Looks reasonable, thank you 
> 
> > +/**
> > + * spi_get_adapter - get a reference to an adapter
> > + * @id: driver id
> > + *
> > + * Obtain a spi_adapter structure for the specified adapter.  If the adapter
> > + * is not currently load, then load it.  The adapter will be locked in core
> > + * until all references are released via spi_put_adapter.
> > + */
> 
> Hm, that comment is not correct.  Please fix it as nothing is "loaded".
OK
> > +void spi_put_adapter(struct spi_adapter *adap)
> > +{
> > +	if (adap && adap->owner)
> > +		module_put(adap->owner);
> > +}
> 
> Then why not use the traditional kref style of reference counting?  That
> ensures that if you try to use the reference, bad things will happen?
> Right now all you are doing is relying on module references, and you
> aren't cleaning up the memory.
I'll consider this during rework
> > +EXPORT_SYMBOL(spi_transfer);
> > +EXPORT_SYMBOL(spi_write);
> > +EXPORT_SYMBOL(spi_read);
> 
> EXPORT_SYMBOL_GPL() perhaps?
Yup.
> Please use dev_dbg() and friends instead of your own debugging macros.
> The error log people will thank you (along with your users...)
I'd rather use pr_debug
> > +#include <linux/spi/spi.h>
> 
> Why a separate subdir for spi.h?
Due to historical reasons :) And functional drivers can pput their
public headers to separate directory.
> 
> > +static int spidev_ioctl(struct inode *inode, struct file *file,
> > +			unsigned int cmd, unsigned long arg)
This function will be removed, because its functionality is duplicated by spidev_read/spidev_write.


> > +static int spidev_attach_adapter(struct spi_adapter *adap)
> > +{
> > +	struct spi_dev *spi_dev;
> > +	int retval;
> > +
> > +	spi_dev = get_free_spi_dev(adap);
> > +	if (IS_ERR(spi_dev))
> > +		return PTR_ERR(spi_dev);
> > +
> > +#if defined( CONFIG_DEVFS_FS )
> > +	devfs_mk_cdev(MKDEV(SPI_MAJOR, spi_dev->minor),
> > +		      S_IFCHR | S_IRUSR | S_IWUSR, "spi/%d", spi_dev->minor);
> > +#endif
> 
> No #if needed.  You do this a lot.

As devfs is going to become obsolete, maybe just drop all the
devfs-related code?

> > +/*
> > + * spi_adapter is the structure used to identify a physical SPI bus along
> > + * with the access algorithms necessary to access it.
> > + */
> > +struct spi_adapter {
> 
> <snip>  Ick, don't copy the mess I did in the i2c core for i2c adapter
> structures please.  It was a hack then, and I regret it still.  Please
> fix it up properly.
> 
> This code is _very_ close to just a copy of the i2c core code.  Why
> duplicate it and not work with the i2c people instead?

Well, those two are both simple serial interfaces, so their similarity
is just reflected in driver structures.


