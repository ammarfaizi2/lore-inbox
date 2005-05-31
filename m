Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVEaSgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVEaSgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 14:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVEaSge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 14:36:34 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:31620 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261174AbVEaSdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 14:33:44 -0400
Date: Tue, 31 May 2005 11:33:39 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: dpervushin@ru.mvista.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core
Message-Id: <20050531113339.49b2e4bf.rdunlap@xenotime.net>
In-Reply-To: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005 20:09:16 +0400 dmitry pervushin wrote:

| Hello guys,
| 
| In order to support the specific board, we have ported the generic SPI core to the 2.6 kernel. This core provides basic API to create/manage SPI devices like the I2C core does. We need to continue providing support of SPI devices and would like to maintain the SPI subtree. It would be nice if SPI core patch were applied to the vanilla kernel.
| I2C people do not like to mainain this code as well as I2C, so...
| 
| Signed-off-by: dmitry pervushin <dpervushin@gmail.com>
| 
| KernelVersion: 2.6.12-rc4

Hi,

Are there more parts to the patch (other than "core")?
E.g., the patch refers to some Documentation/spi/, but those
parts are missing.

I was going to read that to see what SPI means.... so what
does it mean?


Also, a diffstat summary would be nice to see:

 drivers/spi/Kconfig     |   26 ++
 drivers/spi/Makefile    |   12 +
 drivers/spi/spi-core.c  |  385 +++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dev.c   |  514 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  266 ++++++++++++++++++++++++
 5 files changed, 1202 insertions(+), 1 deletion(-)



| diff -uNr -X dontdiff linux-2.6.12-rc4/drivers/spi/Makefile linux/drivers/spi/Makefile
| --- linux-2.6.12-rc4/drivers/spi/Makefile	1970-01-01 03:00:00.000000000 +0300
| +++ linux/drivers/spi/Makefile	2005-05-31 19:59:01.000000000 +0400
| @@ -0,0 +1,12 @@
| +#
| +# Makefile for the kernel spi bus driver.

Don't need such obvious comments.


| diff -uNr -X dontdiff linux-2.6.12-rc4/drivers/spi/spi-core.c linux/drivers/spi/spi-core.c
| --- linux-2.6.12-rc4/drivers/spi/spi-core.c	1970-01-01 03:00:00.000000000 +0300
| +++ linux/drivers/spi/spi-core.c	2005-05-31 19:59:12.000000000 +0400
| @@ -0,0 +1,385 @@
| +#include <linux/module.h>
| +#include <linux/config.h>
| +#include <linux/kernel.h>
| +#include <linux/errno.h>
| +#include <linux/slab.h>
| +#include <linux/device.h>
| +#include <linux/proc_fs.h>
| +#include <linux/kmod.h>
| +#include <linux/init.h>
| +#include <linux/spi/spi.h>

Please put those in alphabetical order as much as possible.


| +/**
| + * spi_get_adapter - get a reference to an adapter
| + * @id: driver id
| + *
| + * Obtain a spi_adapter structure for the specified adapter.  If the adapter
| + * is not currently load, then load it.  The adapter will be locked in core
                       loaded

| + * until all references are released via spi_put_adapter.
| + */
| +struct spi_adapter *spi_get_adapter(int id)
| +{
| +	struct list_head *item;
| +	struct spi_adapter *adapter;
| +
| +	down(&adapter_lock);
| +	list_for_each(item, &adapter_list) {
| +		adapter = list_entry(item, struct spi_adapter, adapters);
| +		if (id == adapter->nr && try_module_get(adapter->owner)) {
| +			up(&adapter_lock);
| +			return adapter;
| +		}
| +	}
| +	up(&adapter_lock);
| +	return NULL;
| +
| +}
| +
| +/**
| + * spi_get_driver - get a reference to a driver
| + * @name: driver name
| + *
| + * Obtain a spi_driver structure for the specified driver.  If the driver is
| + * not currently load, then load it.  The driver will be locked in core
                    loaded

| + * until all references are released via spi_put_driver.
| + */


| +/**
| + * spi_detach_client - detach a client from an adapter and driver
| + * @client: client structure to detach
| + *
| + * Detach the client from the adapter and driver.

    * Returns 0


| diff -uNr -X dontdiff linux-2.6.12-rc4/drivers/spi/spi-dev.c linux/drivers/spi/spi-dev.c
| --- linux-2.6.12-rc4/drivers/spi/spi-dev.c	1970-01-01 03:00:00.000000000 +0300
| +++ linux/drivers/spi/spi-dev.c	2005-05-31 19:59:18.000000000 +0400
| @@ -0,0 +1,514 @@
| +
| +#include <linux/init.h>
| +#include <linux/config.h>
| +#include <linux/kernel.h>
| +#include <linux/module.h>
| +#include <linux/device.h>
| +#include <linux/fs.h>
| +#include <linux/slab.h>
| +#include <linux/version.h>
| +#include <linux/smp_lock.h>

Alpha order as much as possible, please.

| +#ifdef CONFIG_DEVFS_FS
| +#include <linux/devfs_fs_kernel.h>
| +#endif

Shouldn't need to surround #includes with #ifdef/#endif.

| +#include <linux/init.h>
| +#include <asm/uaccess.h>
| +#include <linux/spi/spi.h>
| +
| +#define SPI_TRANSFER_MAX	65535
| +#define SPI_ADAP_MAX		32

What is SPI_ADAP_MAX used for?  It's not used in the core patch at all.
And it's #defined in 2 places, should just be put into a header file
and #included if it's needed at all.  Oh, it's in spi.h, so it's
not needed here.


| +extern struct spi_adapter *spi_get_adapter(int id);	/* spi-core.c ? */
| +extern void spi_put_adapter(struct spi_adapter *);

These should be declared in some header file, please.

| +/* struct file_operations changed too often in the 2.1 series for nice code */

Does that comment need to be here?

| +static ssize_t spidev_read(struct file *file, char *buf, size_t count,
| +			   loff_t * offset);
| +static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
| +			    loff_t * offset);
| +
| +static int spidev_open(struct inode *inode, struct file *file);
| +static int spidev_release(struct inode *inode, struct file *file);
| +static int spidev_ioctl(struct inode *inode, struct file *file,
| +			unsigned int cmd, unsigned long arg);
| +static int spidev_attach_adapter(struct spi_adapter *);
| +static int spidev_detach_adapter(struct spi_adapter *);
| +static int __init spi_dev_init(void);
| +static void spidev_cleanup(void);
| +
| +static struct file_operations spidev_fops = {
| +      owner:THIS_MODULE,
| +      llseek:no_llseek,
| +      read:spidev_read,
| +      write:spidev_write,
| +      open:spidev_open,
| +      release:spidev_release,
| +      ioctl:spidev_ioctl,
| +};

Please use C99-style initializers and align the init values so that
it is more readable.


| +static struct spi_driver spidev_driver = {
| +      name:"spi",
| +      attach_adapter:spidev_attach_adapter,
| +      detach_adapter:spidev_detach_adapter,
| +      owner:THIS_MODULE,
| +};

ditto

| +static struct spi_client spidev_client_template = {
| +      driver:&spidev_driver
| +};

ditto

| +struct spi_dev {
| +	int minor;
| +	struct spi_adapter *adap;
| +	struct class_device class_dev;
| +	struct completion released;	/* FIXME, we need a class_device_unregister() */
| +};

| +struct spi_dev *spi_dev_get_by_minor(unsigned index)
| +{
| +	struct spi_dev *spi_dev;
| +
| +	spin_lock(&spi_dev_array_lock);
| +	spi_dev = spi_dev_array[index];
| +	spin_unlock(&spi_dev_array_lock);
| +	return spi_dev;
| +}

Should this increment a reference count?

| +struct spi_dev *spi_dev_get_by_adapter(struct spi_adapter *adap)
| +{
| +	struct spi_dev *spi_dev = NULL;
| +
| +	spin_lock(&spi_dev_array_lock);
| +	if ((spi_dev_array[adap->nr]) &&
| +	    (spi_dev_array[adap->nr]->adap == adap))
| +		spi_dev = spi_dev_array[adap->nr];
| +	spin_unlock(&spi_dev_array_lock);
| +	return spi_dev;
| +}

same question.

| +static void return_spi_dev(struct spi_dev *spi_dev)
| +{
| +	spin_lock(&spi_dev_array_lock);
| +	spi_dev_array[spi_dev->minor] = NULL;
| +	spin_unlock(&spi_dev_array_lock);
| +}

same question (with decrement)

| +static int spidev_ioctl(struct inode *inode, struct file *file,
| +			unsigned int cmd, unsigned long arg)
| +{
| +	struct spi_client *client = (struct spi_client *)file->private_data;
| +	struct spi_rdwr_ioctl_data rdwr_arg;
| +	struct spi_msg *rdwr_pa;
| +	int res, i;
| +	unsigned long (*cpy_to_user) (void *to_user, const void *from,
| +				      unsigned long len);
| +	unsigned long (*cpy_from_user) (void *to, const void *from_user,
| +					unsigned long len);
| +	void *(*alloc) (size_t, int);
| +	void (*free) (const void *);
| +
| +	cpy_to_user =
| +	    client->adapter->copy_to_user ? client->adapter->
| +	    copy_to_user : copy_to_user;
| +	cpy_from_user =
| +	    client->adapter->copy_from_user ? client->adapter->
| +	    copy_from_user : copy_from_user;
| +	alloc = client->adapter->alloc ? client->adapter->alloc : kmalloc;
| +	free = client->adapter->free ? client->adapter->free : kfree;
| +
| +	switch (cmd) {
| +	case SPI_RDWR:
| +		if (copy_from_user(&rdwr_arg,
| +				   (struct spi_rdwr_ioctl_data *)arg,
| +				   sizeof(rdwr_arg)))
| +			return -EFAULT;
| +
| +		rdwr_pa = (struct spi_msg *)
| +		    kmalloc(rdwr_arg.nmsgs * sizeof(struct spi_msg),
| +			    GFP_KERNEL);
| +
| +		if (rdwr_pa == NULL)
| +			return -ENOMEM;
| +
| +		res = 0;
| +		for (i = 0; i < rdwr_arg.nmsgs; i++) {
| +			if (copy_from_user(&(rdwr_pa[i]),
| +					   &(rdwr_arg.msgs[i]),
| +					   sizeof(rdwr_pa[i]))) {
| +				res = -EFAULT;
| +				break;
| +			}
| +			rdwr_pa[i].buf = alloc(rdwr_pa[i].len, GFP_KERNEL);
| +			if (rdwr_pa[i].buf == NULL) {
| +				res = -ENOMEM;
| +				break;
| +			}

when do you user copy_from_user() vs. cpy_from_user() ?

| +			if (cpy_from_user(rdwr_pa[i].buf,
| +					  rdwr_arg.msgs[i].buf,
| +					  rdwr_pa[i].len)) {
| +				free(rdwr_pa[i].buf);
| +				res = -EFAULT;
| +				break;
| +			}
| +		}
| +		if (!res) {
| +			res = spi_transfer(client->adapter,
| +					   rdwr_pa, rdwr_arg.nmsgs);
| +		}
| +		while (i-- > 0) {
| +			if (res >= 0 && (rdwr_pa[i].flags & SPI_M_RD))
| +				if (cpy_to_user(rdwr_arg.msgs[i].buf,
| +						rdwr_pa[i].buf,
| +						rdwr_pa[i].len)) {
| +					res = -EFAULT;
| +				}
| +			free(rdwr_pa[i].buf);
| +		}
| +		kfree(rdwr_pa);
| +		return res;
| +
| +	case SPI_CLK_RATE:
| +	default:
| +		break;
| +	}
| +
| +	return 0;
| +}
| +

| +static ssize_t spidev_read(struct file *file, char *buf, size_t count,
| +			   loff_t * offset)
| +{
| +	char *tmp;
| +	int ret;
| +#ifdef SPIDEV_DEBUG
| +	struct inode *inode = file->f_dentry->d_inode;
| +#endif
| +
| +	struct spi_client *client = (struct spi_client *)file->private_data;
| +	unsigned long (*cpy_to_user) (void *to_user, const void *from,
| +				      unsigned long len);
| +	void *(*alloc) (size_t, int);
| +	void (*free) (const void *);

insert blank line here (at end of data), please.

| +	if (count > SPI_TRANSFER_MAX)
| +		count = SPI_TRANSFER_MAX;
| +
| +	cpy_to_user =
| +	    client->adapter->copy_to_user ? client->adapter->
| +	    copy_to_user : copy_to_user;
| +	alloc = client->adapter->alloc ? client->adapter->alloc : kmalloc;
| +	free = client->adapter->free ? client->adapter->free : kfree;
| +
| +	/* copy user space data to kernel space. */
| +	tmp = alloc(count, GFP_KERNEL);
| +	if (tmp == NULL)
| +		return -ENOMEM;
| +
| +	ret = spi_read(client, 0, tmp, count);
| +	if (ret >= 0)
| +		ret = cpy_to_user(buf, tmp, count) ? -EFAULT : ret;
| +	free(tmp);
| +	return ret;
| +}


| +int spidev_open(struct inode *inode, struct file *file)
Can't this be static?
| +{


---
~Randy
