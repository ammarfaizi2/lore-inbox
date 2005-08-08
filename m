Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVHHR13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVHHR13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVHHR13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:27:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:24738 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932123AbVHHR13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:27:29 -0400
Date: Mon, 8 Aug 2005 07:55:44 -0700
From: Greg KH <greg@kroah.com>
To: dmitry pervushin <dpervushin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi
Message-ID: <20050808145544.GB6478@kroah.com>
References: <1121025679.3008.10.camel@spirit> <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 01:12:18PM +0400, dmitry pervushin wrote:
> +config SPI
> +	default Y
> +	tristate "SPI support"
> +        default false
> +	help
> +	  Say Y if you need to enable SPI support on your kernel

What about the "the module will be called..." text for this?

> +obj-$(CONFIG_SPI) += spi-core.o helpers.o

Hm, this will not build :(

> +static LIST_HEAD( spi_busses );

No spaces after ( or before ) please.  You do this all over the place in
the code, please fix it up.

> +	if (NULL == dev || NULL == driver) {

Put the variable on the left side, gcc will complain if you incorrectly
put a "=" instead of a "==" here, which is all that you are defending
against with this style.


> +		printk(KERN_ERR
> +		       "%s: error - both dev and driver should not be NULL !\n",
> +		       __FUNCTION__);
> +		found = 0;
> +		goto spi_match_done;
> +	}
> +
> +	if (NULL == spidrv->supported_ids) {
> +		printk
> +		    ("%s: driver has no ids of devices to support, assuming ALL\n",
> +		     __FUNCTION__);

No KERN_ level here.  Also, please use dev_dbg() and friends if you
possibly can, it's much better for log messages.

> +int spi_bus_register( struct spi_bus* bus, char* name )
> +{
> +	int err = -EINVAL;
> +	static int count = 0;
> +	char busname[ BUS_ID_SIZE ];
> +	char fullname[ BUS_ID_SIZE ];
> +
> +	ENTER();	

Tracing?  ick, not really needed...

> +	if( bus ) {
> +		init_MUTEX( &bus->lock );
> +
> +		bus->platform_device.name = NULL;
> +		bus->the_bus.name = NULL;
> +
> +		strncpy( busname, name ? name : "SPI", sizeof( busname ) );
> +		bus->platform_device.id = count++ % 100;
> +		sprintf( fullname, "%s_%02d", busname, bus->platform_device.id);
> +		bus->the_bus.name = kmalloc( strlen( fullname )+1, GFP_KERNEL );
> +		if( bus->the_bus.name ) {
> +			strcpy( bus->the_bus.name, fullname );
> +		}
> +

{ } are not needed for 1 line if statements.

> +/**
> + * spi_add_adapter - register a new SPI bus adapter
> + * @spidev: spi_device structure for the registering adapter
> + *
> + * Make the adapter available for use by clients using name adap->name.
> + * The adap->adapters list is initialised by this function.
> + *
> + * Returns error code ( 0 on success ) ;
> + */
> +struct spi_bus* spi_bus_find( char* id )

Wrong comment.

> +{
> +	struct bus_type* the_bus = find_bus( id );
> +
> +	return the_bus ? container_of( the_bus, struct spi_bus, the_bus ) : NULL;
> +}
> +
> +EXPORT_SYMBOL( spi_bus_find );

EXPORT_SYMBOL_GPL ?


> +int spi_device_add( struct spi_bus* bus, struct spi_device *dev, char* name)

No space between that and the next function?

No comment for a public function ike this?

> +/**
> + * spi_del_adapter - unregister a SPI bus adapter
> + * @dev: spi_device structure to unregister
> + *
> + * Remove an adapter from the list of available SPI Bus adapters.
> + *
> + * Returns error code (0 on success);
> + */
> +
> +void spi_device_del(struct spi_device *dev)

Again, comments out of sync with the code.

> +void spi_driver_del( struct spi_driver* drv )
> +{
> +	driver_unregister( &drv->driver );
> +}
> +/**
> + * spi_transfer - transfer information on an SPI bus

Please, just 1 line of whitespace between functions, not none.

> +/**
> + * spi_write - send data to a device on an SPI bus
> + * @client: registered client structure
> + * @addr: SPI bus address
> + * @buf: buffer for bytes to send
> + * @len: number of bytes to send
> + *
> + * Send len bytes pointed to by buf to device address addr on the SPI bus
> + * described by client.
> + *
> + * Returns the number of bytes transferred, or negative error code.
> + */
> +int spi_write(struct spi_device *dev, int addr, const char *buf, int len)

Comment doesn't match function.  You will catch all of these errors if
you add the files to the kernel api docbook document.

> ===================================================================
> --- linux-2.6.10.orig/drivers/spi/spi-dev.c	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.10/drivers/spi/spi-dev.c	2005-07-15 06:57:39.000000000 +0000
> @@ -0,0 +1,303 @@
> +/*#ifdef CONFIG_DEVFS_FS	

What's with the #ifdef here?

> +
> +/* $Id: common_spi_core-2.patch,v 1.1.2.6 2005/07/15 07:24:40 tpoynor Exp $ */

No CVS ids in kernel code please.

> +/* struct file_operations changed too often in the 2.1 series for nice code */

I don't think this comment is necessary anymore :)

> +static ssize_t spidev_read(struct file *file, char *buf, size_t count,
> +			   loff_t * offset);
> +static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
> +			    loff_t * offset);

You didn't run this through sparse :(

That's enough to start with...

thanks,

greg k-h
