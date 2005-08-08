Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVHHW7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVHHW7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVHHW7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:59:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932340AbVHHW7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:59:14 -0400
Date: Mon, 8 Aug 2005 15:58:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: dmitry pervushin <dpervushin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi
Message-Id: <20050808155801.77d5962b.akpm@osdl.org>
In-Reply-To: <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
References: <1121025679.3008.10.camel@spirit>
	<1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmitry pervushin <dpervushin@gmail.com> wrote:
>

A few coding style nits.

> +#include "spi_locals.h"
> +
> +static LIST_HEAD( spi_busses );

Please don't put spaces after '(' and before ')'.

> +		if (0 == strncmp(*id, SPI_ID_ANY, strlen(SPI_ID_ANY))) {

And this trick isn't really needed.  If you do

	if (whatever = constant)

then the compiler will generate a warning.  Please do these comparisons in
the conventional way, with the constant on the right hand side.

> +	if( bus ) {
> +		init_MUTEX( &bus->lock );
> +
> +		bus->platform_device.name = NULL;
> +		bus->the_bus.name = NULL;
> +
> +		strncpy( busname, name ? name : "SPI", sizeof( busname ) );

Lots more extraneous spaces after '(' and before ')'.

> +		if( bus->the_bus.name ) {
> +			strcpy( bus->the_bus.name, fullname );
> +		}

No braces here.

> +		err = bus_register( &bus->the_bus );
> +		if( err ) {
> +			goto out;
> +		}

And here.

> +		list_add_tail( &bus->bus_list, &spi_busses );
> +		bus->platform_device.name = kmalloc( strlen( busname )+1, GFP_KERNEL );
> +		if( bus->platform_device.name ) {
> +			strcpy( bus->platform_device.name, busname );
> +		}

and here...

> +void spi_bus_unregister( struct spi_bus* bus )
> +{
> +	if( bus ) {

We do put a space after `if', so this line should be

	if (bus) {

> +struct spi_bus* spi_bus_find( char* id )

The asterisk goes with the variable, not with the type.  So the above should be

	struct spi_bus *spi_bus_find(char *id)

> +int spi_device_add( struct spi_bus* bus, struct spi_device *dev, char* name)

Here too.

> +int spi_do_probe( struct device* dev, void* device_driver )

You seem to have an awful lot of non-static functions.  Please check
whether they all really need to have global scope.

> +	if (NULL == dev) {

	if (dev == NULL) {

> +static int spidev_do_open(struct device *the_dev, void *context)
> +{
> +	struct spidev_openclose *o = (struct spidev_openclose *) context;

Don't typecast void* when assigning to and from pointers.  It adds clutter
and defeats typechecking.

> +	struct spi_device *dev = SPI_DEV(the_dev);
> +	struct spidev_driver_data *drvdata;
> +
> +	drvdata = (struct spidev_driver_data *) dev_get_drvdata(the_dev);

Ditto.

> +
> +      out_unreg:

Labels go in column zero.

> +	void *(*alloc) (size_t, int);
> +	void (*free) (const void *);
> +	unsigned long (*copy_from_user) (void *to, const void *from_user,
> +					 unsigned long len);
> +	unsigned long (*copy_to_user) (void *to_user, const void *from,
> +				       unsigned long len);

The above names are risky.  Some platform may implement copy_to_user() as a
macro.


