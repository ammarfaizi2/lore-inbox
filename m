Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWIZTIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWIZTIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWIZTIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:08:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932468AbWIZTI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:08:29 -0400
Date: Tue, 26 Sep 2006 12:08:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 real-V5] drivers: add lcd display support
Message-Id: <20060926120821.e11f3254.akpm@osdl.org>
In-Reply-To: <20060922220346.69f63338.maxextreme@gmail.com>
References: <20060922220346.69f63338.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 22:03:46 +0200
Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:

> miguelojeda-2.6.18-add-lcd-display-support.patch
> 
> ...
>
> diff -uprN -X dontdiff linux-2.6.18-vanilla/include/linux/device.h linux-2.6.18/include/linux/device.h
> --- linux-2.6.18-vanilla/include/linux/device.h	2006-09-20 14:52:00.000000000 +0200
> +++ linux-2.6.18/include/linux/device.h	2006-09-20 14:55:56.000000000 +0200
> @@ -271,7 +271,7 @@ struct class_interface {
>  extern int class_interface_register(struct class_interface *);
>  extern void class_interface_unregister(struct class_interface *);
>  
> -extern struct class *class_create(struct module *owner, char *name);
> +extern struct class *class_create(struct module *owner, const char *name);

Please prepare a separate patch for this, send to Greg.

> --- linux-2.6.18-vanilla/drivers/lcddisplay/cfag12864b.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.18/drivers/lcddisplay/cfag12864b.c	2006-09-22 21:46:52.000000000 +0200
> @@ -0,0 +1,529 @@
> +/*
> + *    Filename: cfag12864b.c
> + *     Version: 0.1.0
> + * Description: cfag12864b LCD Display Driver
> + *     License: GPLv2
> + *     Depends: lcddisplay ks0108
> + *
> + *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
> + *        Date: 2006-09-21
> + */
> +
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/lcddisplay.h>
> +#include <linux/ks0108.h>
> +#include <linux/cfag12864b.h>
> +#include <asm/uaccess.h>
> +
> +#define NAME "cfag12864b"
> +#define PRINTK_PREFIX  KERN_INFO NAME ": "

In numerous places the driver uses PRINTK_PREFIX for reporting errors.  It
should use KERN_ERR.  I suggest that PRINTK_PREFIX be removed and that you
open-code all the printk facility levels, make sure that the appropriate
level is being used at each site.

> +
> +
> +/*
> + * Device
> + */
> +
> +static const unsigned int cfag12864b_firstminor;
> +static const unsigned int cfag12864b_ndevices = 1;
> +static const char * cfag12864b_name = NAME;

The more usual kernel style is to not put a space after the `*':

	static const char *cfag12864b_name = NAME;

(this affects the entire patch).


Suggest that cfag12864b_name be removed - just use NAME at the single place
where this variable is used.

> +static int cfag12864b_major;
> +static int cfag12864b_minor;
> +static dev_t cfag12864b_device;
> +struct cdev cfag12864b_chardevice;
> +
> +
> +
> +

One blank line is sufficient (there are many instances of this)

> +/*
> + * cfag12864b Commands
> + */
> +
> +static const unsigned int cfag12864b_bits = 8;
> +static const unsigned int cfag12864b_width = CFAG12864B_WIDTH;
> +static const unsigned int cfag12864b_height = CFAG12864B_HEIGHT;
> +static const unsigned int cfag12864b_matrixsize = CFAG12864B_MATRIXSIZE;
> +static const unsigned int cfag12864b_controllers = CFAG12864B_CONTROLLERS;
> +static const unsigned int cfag12864b_pages = CFAG12864B_PAGES;
> +static const unsigned int cfag12864b_addresses = CFAG12864B_ADDRESSES;
> +static const unsigned int cfag12864b_size = CFAG12864B_SIZE;
> +static unsigned char cfag12864b_state;
> +
> +static void cfag12864b_set(void)
> +{
> +	ks0108_writecontrol(cfag12864b_state);
> +}
> +
> +static void cfag12864b_setbit(unsigned char state, unsigned char bit)
> +{
> +	if (state)
> +		set_bit(bit, (void*)&cfag12864b_state);
> +	else
> +		clear_bit(bit, (void*)&cfag12864b_state);
> +	cfag12864b_set();
> +}

bitops are defined on an unsigned long only.  This trick is as ugly as sin
and is buggy on big-endian CPUs.  Suggest that cfag12864b_state be
converted to unsigned long.

> +{
> +	cfag12864b_startline(0);
> +}
> +
> +
> +

blank lines

> +/*
> + * Auxiliary
> + */
> +
> +static void normalizeoffset(unsigned int * offset)

coding style.

> +{
> +	if (*offset >= cfag12864b_pages*cfag12864b_addresses)
> +		*offset -= cfag12864b_pages*cfag12864b_addresses;
> +}

Ths usual kernel style is to put a single space around arithmetic operators
and around comparison operators.  This affects the entire patch, please.


> +void cfag12864b_clear(void)
> +{
> +	unsigned char page,address;
> +
> +	cfag12864b_setcontrollers(1, 1);
> +	for (page=0; page<cfag12864b_pages; ++page) {

For example,

	for (page = 0; page < cfag12864b_pages; page++) {

would be more kernelish.

The use of the identifier `page' here is unfortunate.  We usually expect
such a thing to have type `struct page *'.  I understand that "Each
controller is divided into 8 pages", but it'd be nice if some different
nomenclature could be used here.  If nothing else comes to mind, we can
live with it as-is.

> +void cfag12864b_write(
> +	unsigned short offset,
> +	const unsigned char * buffer,
> +	unsigned short count)
> +{

It is more usual to do

void cfag12864b_write(unsigned short offset, const unsigned char *buffer,
			unsigned short count)
{

> +	for (controller=0; controller < cfag12864b_controllers; ++controller)
> +	for (page=0; page < cfag12864b_pages; ++page)
> +	for (address=0; address < cfag12864b_addresses; ++address) {
> +		dest[(controller*cfag12864b_pages+page)*cfag12864b_addresses+address]=0;
> +		for (bit=0; bit < cfag12864b_bits; ++bit)
> +			if (src[controller*cfag12864b_addresses+address+(page*cfag12864b_bits+bit)*cfag12864b_width])
> +				set_bit(bit, (void*)(dest+(controller*cfag12864b_pages+page)*cfag12864b_addresses+address));
> +	}

That's rather ugly-looking.

It's also probably-incorrect on big-endian CPUs.  Perhaps you should not
use bitops at all for this driver, use open-coded | and &/~ instead?


The driver doesn't have any locking.  Is it racy on SMP and/or
CONFIG_PREEMPT?

> +static int cfag12864b_fopioctlformat(void __user * arg)
> +{
> +	int result;
> +	int ret = -ENOTTY;
> +
> +	unsigned char * tmpbuffer;
> +
> +	tmpbuffer = kmalloc(
> +		sizeof(unsigned char)*cfag12864b_matrixsize,GFP_KERNEL);
> +	if (tmpbuffer == NULL) {
> +		printk(PRINTK_PREFIX "FOP ioctl: ERROR: "
> +			"can't alloc memory %i bytes\n",
> +			sizeof(unsigned char)*cfag12864b_matrixsize);
> +		goto none;
> +	}
> +
> +	result = copy_from_user(
> +		tmpbuffer,
> +		arg,
> +		sizeof(unsigned char)*cfag12864b_matrixsize);

	result = copy_from_user(tmpbuffer, arg, cfag12864b_matrixsize);


> +	if (result != 0) {
> +		printk(PRINTK_PREFIX "FOP ioctl: ERROR: "
> +			"can't copy memory from user\n");
> +		goto bufferalloced;
> +	}
> +	
> +	cfag12864b_format(tmpbuffer);
> +
> +	ret = 0;
> +
> +bufferalloced:
> +	kfree(tmpbuffer);
> +
> +none:
> +	return ret;
> +}
> +
>
> ...
>
> +
> +static struct file_operations cfag12864b_fops =

`static const struct'

> +
> +	class_device_create(
> +		lcddisplay_class,NULL,
> +		cfag12864b_device,
> +		NULL,"cfag12864b%d", cfag12864b_minor);

class_device_create() can fail.

> +void ks0108_writecontrol(unsigned char byte)
> +{
> +	const unsigned int ecycledelay = 2;
> +	udelay(ecycledelay);
> +	parport_write_control(ks0108_parport, byte^(bit(3)|bit(1)|bit(0)));
> +}

udelay(2) would be clearer.

> +void ks0108_displaystate(unsigned char state)
> +{
> +	unsigned char cmd = bit(1) | bit(2) | bit(3) | bit(4) | bit(5);
> +	if (state)
> +		set_bit(0, (void*)&cmd);

argh.  Even if this driver will only ever run on big-endian hardware,
please don't do this.

> +void ks0108_startline(unsigned char startline)
> +{
> +	const unsigned char maxstartline = 63;
> +	unsigned char cmd = bit(6) | bit(7);
> +	if (startline > maxstartline)
> +		startline = maxstartline;

There are a lot of open-coded min() and max() operations in this driver. 
Suggest it be changed to use min() and max().


