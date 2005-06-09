Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVFIMfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVFIMfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVFIMfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:35:30 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:47899 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262378AbVFIMdV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:33:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DlkeIE9d3c5l99X7uWsqpv1mGspmfEI+NCoqvKWjKTw/fwFKUf71SstReh4UqAszdKx4BXsAF1C+IYMYIjylM8EjIVlfo9SXqzyTErZL/UsAxLiolVRUOKYm5eFZXj6JvZNtqy06gGO+/HwVFPtLP5En2YeCezXIPLoEtT+n8qQ=
Message-ID: <84144f020506090533b00b823@mail.gmail.com>
Date: Thu, 9 Jun 2005 15:33:20 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: dpervushin@ru.mvista.com
Subject: Re: [RFC] SPI core
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some coding style comments. Sorry for any duplicates, I read
other comments only after I reviewed the patch.

                                   Pekka

On 5/31/05, dmitry pervushin <dpervushin@ru.mvista.com> wrote:
> diff -uNr -X dontdiff linux-2.6.12-rc4/drivers/spi/spi-core.c linux/drivers/spi/spi-core.c
> --- linux-2.6.12-rc4/drivers/spi/spi-core.c	1970-01-01 03:00:00.000000000 +0300
> +++ linux/drivers/spi/spi-core.c	2005-05-31 19:59:12.000000000 +0400
> +int spi_add_adapter(struct spi_adapter *adap)
> +{
> +	struct list_head *l;
> +
> +	INIT_LIST_HEAD(&adap->clients);
> +	down(&adapter_lock);
> +	init_MUTEX(&adap->lock);

adapter_lock protects adapter_list, not adap. Therefore, please move
adap->lock initialization outside the critical region.

> +struct spi_adapter *spi_get_adapter(int id)
> +{
> +	struct list_head *item;
> +	struct spi_adapter *adapter;
> +
> +	down(&adapter_lock);
> +	list_for_each(item, &adapter_list) {
> +		adapter = list_entry(item, struct spi_adapter, adapters);
> +		if (id == adapter->nr && try_module_get(adapter->owner)) {
> +			up(&adapter_lock);
> +			return adapter;

One exit path please. You can use goto here.

> +
> +EXPORT_SYMBOL(spi_add_adapter);
> +EXPORT_SYMBOL(spi_del_adapter);
> +EXPORT_SYMBOL(spi_get_adapter);
> +EXPORT_SYMBOL(spi_put_adapter);
> +
> +EXPORT_SYMBOL(spi_add_driver);
> +EXPORT_SYMBOL(spi_del_driver);
> +EXPORT_SYMBOL(spi_get_driver);
> +EXPORT_SYMBOL(spi_put_driver);
> +
> +EXPORT_SYMBOL(spi_attach_client);
> +EXPORT_SYMBOL(spi_detach_client);
> +
> +EXPORT_SYMBOL(spi_transfer);
> +EXPORT_SYMBOL(spi_write);
> +EXPORT_SYMBOL(spi_read);

Preferred location for EXPORT_SYMBOLs is immediately after the function
definition.

> diff -uNr -X dontdiff linux-2.6.12-rc4/drivers/spi/spi-dev.c linux/drivers/spi/spi-dev.c
> --- linux-2.6.12-rc4/drivers/spi/spi-dev.c	1970-01-01 03:00:00.000000000 +0300
> +++ linux/drivers/spi/spi-dev.c	2005-05-31 19:59:18.000000000 +0400
> @@ -0,0 +1,514 @@
> +#include <linux/init.h>
> +#include <asm/uaccess.h>
> +#include <linux/spi/spi.h>
> +
> +#define SPI_TRANSFER_MAX	65535
> +#define SPI_ADAP_MAX		32

Unused define.

> +static struct file_operations spidev_fops = {
> +      owner:THIS_MODULE,
> +      llseek:no_llseek,
> +      read:spidev_read,
> +      write:spidev_write,
> +      open:spidev_open,
> +      release:spidev_release,
> +      ioctl:spidev_ioctl,

Use C99 struct initializers.

> +};
> +
> +static struct spi_driver spidev_driver = {
> +      name:"spi",
> +      attach_adapter:spidev_attach_adapter,
> +      detach_adapter:spidev_detach_adapter,
> +      owner:THIS_MODULE,

Ditto.

> +};
> +
> +static struct spi_client spidev_client_template = {
> +      driver:&spidev_driver

Same here.

> +static struct spi_dev *get_free_spi_dev(struct spi_adapter *adap)
> +{
> +	struct spi_dev *spi_dev;
> +
> +	spi_dev = kmalloc(sizeof(*spi_dev), GFP_KERNEL);
> +	if (!spi_dev)
> +		return ERR_PTR(-ENOMEM);
> +	memset(spi_dev, 0x00, sizeof(*spi_dev));

See below.

> +
> +	spin_lock(&spi_dev_array_lock);
> +	if (spi_dev_array[adap->nr]) {
> +		spin_unlock(&spi_dev_array_lock);

One spin_unlock, please. Use gotos here.

> +		dev_err(&adap->dev,
> +			"spi-dev already has a device assigned to this adapter\n");
> +		goto error;
> +	}
> +	spi_dev->minor = adap->nr;

Instead of memset() followed by assignment, you can use C99 struct
initializers like this:

	*spi_dev = (struct spi_dev) { .minor = adap->nr; };

> +	spi_dev_array[adap->nr] = spi_dev;
> +	spin_unlock(&spi_dev_array_lock);
> +	return spi_dev;
> +      error:

The placement of this label is strange.

> +static int spidev_ioctl(struct inode *inode, struct file *file,
> +			unsigned int cmd, unsigned long arg)
> +{
> +	struct spi_client *client = (struct spi_client *)file->private_data;

Please remove the redundant cast.

> +	struct spi_rdwr_ioctl_data rdwr_arg;
> +	struct spi_msg *rdwr_pa;
> +	int res, i;
> +	unsigned long (*cpy_to_user) (void *to_user, const void *from,
> +				      unsigned long len);
> +	unsigned long (*cpy_from_user) (void *to, const void *from_user,
> +					unsigned long len);
> +	void *(*alloc) (size_t, int);
> +	void (*free) (const void *);

No type declarations within function body, please.

> +
> +	DBG("spi-%d ioctl, cmd: 0x%x, arg: %lx.\n",
> +	    MINOR(inode->i_rdev), cmd, arg);
> +
> +	cpy_to_user =
> +	    client->adapter->copy_to_user ? client->adapter->
> +	    copy_to_user : copy_to_user;
> +	cpy_from_user =
> +	    client->adapter->copy_from_user ? client->adapter->
> +	    copy_from_user : copy_from_user;
> +	alloc = client->adapter->alloc ? client->adapter->alloc : kmalloc;
> +	free = client->adapter->free ? client->adapter->free : kfree;
> +
> +	switch (cmd) {
> +	case SPI_RDWR:
> +		if (copy_from_user(&rdwr_arg,
> +				   (struct spi_rdwr_ioctl_data *)arg,
> +				   sizeof(rdwr_arg)))
> +			return -EFAULT;
> +
> +		rdwr_pa = (struct spi_msg *)
> +		    kmalloc(rdwr_arg.nmsgs * sizeof(struct spi_msg),
> +			    GFP_KERNEL);

Redundant cast.

> +static int spidev_attach_adapter(struct spi_adapter *adap)
> +{
> +	struct spi_dev *spi_dev;
> +	int retval;
> +
> +	spi_dev = get_free_spi_dev(adap);
> +	if (IS_ERR(spi_dev))
> +		return PTR_ERR(spi_dev);
> +
> +#if defined( CONFIG_DEVFS_FS )
> +	devfs_mk_cdev(MKDEV(SPI_MAJOR, spi_dev->minor),
> +		      S_IFCHR | S_IRUSR | S_IWUSR, "spi/%d", spi_dev->minor);
> +#endif
> +	dev_dbg(&adap->dev, "Registered as minor %d\n", spi_dev->minor);
> +
> +	/* register this spi device with the driver core */
> +	spi_dev->adap = adap;
> +	if (adap->dev.parent == &platform_bus)
> +		spi_dev->class_dev.dev = &adap->dev;
> +	else
> +		spi_dev->class_dev.dev = adap->dev.parent;
> +	spi_dev->class_dev.class = &spi_dev_class;
> +	snprintf(spi_dev->class_dev.class_id, BUS_ID_SIZE, "spi-%d",
> +		 spi_dev->minor);
> +	retval = class_device_register(&spi_dev->class_dev);
> +	if (retval)
> +		goto error;
> +	class_device_create_file(&spi_dev->class_dev, &class_device_attr_dev);
> +	class_device_create_file(&spi_dev->class_dev, &class_device_attr_name);
> +	return 0;
> +      error:

The placement of this label is strange.

> +static ssize_t spidev_read(struct file *file, char *buf, size_t count,
> +			   loff_t * offset)
> +{
> +	char *tmp;
> +	int ret;
> +#ifdef SPIDEV_DEBUG
> +	struct inode *inode = file->f_dentry->d_inode;
> +#endif
> +
> +	struct spi_client *client = (struct spi_client *)file->private_data;
> +	unsigned long (*cpy_to_user) (void *to_user, const void *from,
> +				      unsigned long len);
> +	void *(*alloc) (size_t, int);
> +	void (*free) (const void *);

Please remove the duplicate function pointer type declarations.

> +	if (count > SPI_TRANSFER_MAX)
> +		count = SPI_TRANSFER_MAX;
> +
> +	cpy_to_user =
> +	    client->adapter->copy_to_user ? client->adapter->
> +	    copy_to_user : copy_to_user;
> +	alloc = client->adapter->alloc ? client->adapter->alloc : kmalloc;
> +	free = client->adapter->free ? client->adapter->free : kfree;

More duplicate code.

> +
> +	/* copy user space data to kernel space. */
> +	tmp = alloc(count, GFP_KERNEL);
> +	if (tmp == NULL)
> +		return -ENOMEM;
> +
> +	DBG("spi-%d reading %d bytes.\n", MINOR(inode->i_rdev), count);
> +
> +	ret = spi_read(client, 0, tmp, count);
> +	if (ret >= 0)
> +		ret = cpy_to_user(buf, tmp, count) ? -EFAULT : ret;
> +	free(tmp);
> +	return ret;
> +}
> +
> +static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
> +			    loff_t * offset)
> +{
> +	int ret;
> +	char *tmp;
> +	struct spi_client *client = (struct spi_client *)file->private_data;
> +#ifdef SPIDEV_DEBUG
> +	struct inode *inode = file->f_dentry->d_inode;
> +#endif
> +	unsigned long (*cpy_from_user) (void *to, const void *from_user,
> +					unsigned long len);
> +	void *(*alloc) (size_t, int);
> +	void (*free) (const void *);

Aiie! Duplicates.

> +
> +	if (count > SPI_TRANSFER_MAX)
> +		count = SPI_TRANSFER_MAX;
> +
> +	cpy_from_user =
> +	    client->adapter->copy_from_user ? client->adapter->
> +	    copy_from_user : copy_from_user;
> +	alloc = client->adapter->alloc ? client->adapter->alloc : kmalloc;
> +	free = client->adapter->free ? client->adapter->free : kfree;

More of the same.

> +int spidev_open(struct inode *inode, struct file *file)
> +{
> +	unsigned int minor = iminor(inode);
> +	struct spi_client *client;
> +	struct spi_adapter *adap;
> +	struct spi_dev *spi_dev;
> +
> +	spi_dev = spi_dev_get_by_minor(minor);
> +	if (!spi_dev)
> +		return -ENODEV;
> +
> +	adap = spi_get_adapter(spi_dev->adap->nr);
> +	if (!adap)
> +		return -ENODEV;
> +
> +	client = kmalloc(sizeof(*client), GFP_KERNEL);
> +	if (!client) {
> +		spi_put_adapter(adap);
> +		return -ENOMEM;
> +	}
> +	memcpy(client, &spidev_client_template, sizeof(*client));
> +
> +	/* registered with adapter, passed as client to user */
> +	client->adapter = adap;

Please use C99 struct initializer here.

> +static int __init spi_dev_init(void)
> +{
> +	int res;
> +
> +	printk(KERN_INFO "spi /dev entries driver\n");
> +
> +	res = register_chrdev(SPI_MAJOR, "spi", &spidev_fops);
> +	if (res)
> +		goto out;
> +
> +	res = class_register(&spi_dev_class);
> +	if (res)
> +		goto out_unreg_chrdev;
> +
> +	res = spi_add_driver(&spidev_driver);
> +	if (res)
> +		goto out_unreg_class;
> +
> +#ifdef CONFIG_DEVFS_FS
> +	devfs_mk_dir("spi");
> +#endif
> +	return 0;
> +
> +      out_unreg_class:

The label indentation is strange.

> +	class_unregister(&spi_dev_class);
> +      out_unreg_chrdev:

Ditto.

> +	unregister_chrdev(SPI_MAJOR, "spi");
> +      out:

Here as well.

> diff -uNr -X dontdiff linux-2.6.12-rc4/include/linux/spi/spi.h linux/include/linux/spi/spi.h
> --- linux-2.6.12-rc4/include/linux/spi/spi.h	1970-01-01 03:00:00.000000000 +0300
> +++ linux/include/linux/spi/spi.h	2005-05-31 19:59:26.000000000 +0400
> @@ -0,0 +1,265 @@
> +/*
> + *  linux/include/linux/spi/spi.h
> + *
> + *  Copyright (C) 2001 Russell King, All Rights Reserved.
> + *  Copyright (C) 2002 Compaq Computer Corporation, All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * Derived from l3.h by Jamey Hicks
> + */
> +#ifndef SPI_H
> +#define SPI_H
> +
> +struct spi_msg {
> +	unsigned char addr;	/* slave address        */
> +	unsigned char flags;
> +#define SPI_M_RD		0x01
> +#define SPI_M_NOADDR	0x02

Please use enums instead.

> +	unsigned short len;	/* msg length           */
> +	unsigned char *buf;	/* pointer to msg data  */
> +};
> +
> +/*  TODO: should be in a separate header file?  */
> +
> +/*  Commands for the ioctl call */
> +#define SPI_RDWR	0x0801	/*  Read/write transfer in a single transaction */
> +#define SPI_CLK_RATE	0x0802	/*  Sets SPI clock divisor (int type)           */
> +#define SPI_SDMA	0x0803	/*  Turns on/off SDMA usage (int type).         */

Same here.

> +				 /*  Pass non-zero value to turn SDMA on         */
> +struct spi_rdwr_ioctl_data {
> +	struct spi_msg *msgs;	/* pointers to spi_msgs */
> +	int nmsgs;		/* number of spi_msgs */
> +};
> +/*------------^^^^^^^^^^^^^^^--------------*/

Please drop the above ASCII art.

> +
> +#ifdef __KERNEL__
> +
> +#include <linux/types.h>
> +#include <linux/list.h>
> +
> +#define SPI_ADAP_MAX	32

Unused constant.
