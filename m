Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVGHV6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVGHV6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVGHV4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:56:25 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:37009 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262580AbVGHVxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:53:54 -0400
Date: Fri, 8 Jul 2005 14:53:45 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, abhay_salunke@dell.com,
       greg@kroah.com
Subject: Re: [patch 2.6.12-rc3] modified firmware_class.c to add a new
 function request_firmware_nowait_nohotplug
Message-Id: <20050708145345.17d8c30d.rdunlap@xenotime.net>
In-Reply-To: <20050709001657.GA29556@abhays.us.dell.com>
References: <20050709001657.GA29556@abhays.us.dell.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005 19:16:57 -0500 Abhay Salunke wrote:

| This is the patch to add dell_rbu driver. This patch requires the 
| firmware_class.c patch sent earlier which adds request_firmware_nowait_nohotplug 
| function. 
| Andrew , 
| Could you add this patch to the -mm tree. This patch was submitted about a
| week ago for review.
| 
| Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>
| 
| Thanks
| Abhay

General comment:

The patches have lots of trailing whitespace.  Please remove all of that.

| diff -uprN linux-2.6.11.11.orig/drivers/firmware/dell_rbu.c linux-2.6.11.11.new/drivers/firmware/dell_rbu.c
| --- linux-2.6.11.11.orig/drivers/firmware/dell_rbu.c	1969-12-31 18:00:00.000000000 -0600
| +++ linux-2.6.11.11.new/drivers/firmware/dell_rbu.c	2005-06-30 15:37:27.000000000 -0500
| @@ -0,0 +1,627 @@
| +/*
| + * dell_rbu.c
| + * Bios Update driver for Dell systems
| + * Author: Dell Inc
| + *         Abhay Salunke <abhay_salunke@dell.com>
| + *
| + * Copyright (C) 2005 Dell Inc.
| + *
| + * Remote BIOS Update (rbu) driver is used for updating DELL BIOS by 
| + * creating entries in the /sys file systems on Linux 2.6 and higher 
| + * kernels. The driver supports two mechanism to update the BIOS namely 
                                       mechanisms              BIOS,
| + * contiguous and packetized. Both these methods still require having some
| + * application to set the CMOS bit indicating the BIOS to update itself 
| + * after a reboot.
| + *
| + * Contiguous method:
| + * This driver writes the incoming data in a monolithic image by allocating 
| + * contiguous physical pages large enough to accommodate the incoming BIOS 
| + * image size.  
| + *
| + * Packetized method:
| + * The driver writes the incoming packet image by allocating a new packet 
| + * on every time the packet data is written. This driver requires an 
      each time that the
| + * application to break the BIOS image in to fixed sized packet chunks.
                                          into
| + *
| + * See Documentation/dell_rbu.txt for more info.
| + *
| + */
| +#include <linux/version.h>
| +#include <linux/config.h>
| +#include <linux/init.h>
| +#include <linux/module.h>
| +#include <linux/string.h>
| +#include <linux/errno.h>
| +#include <linux/blkdev.h>
| +#include <linux/device.h>
| +#include <linux/spinlock.h>
| +#include <linux/moduleparam.h>
| +#include <linux/firmware.h>
| +#include <linux/dma-mapping.h>
| +
| +MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
| +MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
| +MODULE_LICENSE("GPL");
| +MODULE_VERSION("1.0");
| +
| +#define BIOS_SCAN_LIMIT 0xffffffff

Please remove this, it's not used.

| +#define MAX_IMAGE_LENGTH 16
| +static struct _rbu_data {
| +	void *image_update_buffer;
| +	unsigned long image_update_buffer_size;
| +	unsigned long bios_image_size;
| +	spinlock_t lock;
| +	unsigned long packet_read_count;
| +	unsigned long packet_write_count;
| +	unsigned long num_packets;
| +	unsigned long packetsize;
| +} rbu_data;
| +
| +static char image_type[MAX_IMAGE_LENGTH] = "mono";
| +module_param_string(image_type, image_type, sizeof (image_type), 0);

Why is permission 0?  0 means not visible in sysfs.
But you tested this, so.... ?

| +MODULE_PARM_DESC(image_type, "BIOS image type. choose- mono or packet");
| +
| +struct packet_data {
| +	struct list_head list;
| +	size_t length;
| +	void *data;
| +	int ordernum;
| +};
| +
| +static struct packet_data packet_data_head;
| +
| +struct platform_device *rbu_device;
| +int context;
| +static dma_addr_t dell_rbu_dmaaddr;
| +
| +static int
| +fill_last_packet(void *data, size_t length)
| +{
| +	struct list_head *ptemp_list;
| +	struct packet_data *packet = NULL;
| +	int packet_count = 0;
| +
| +	pr_debug("fill_last_packet: entry \n");
                                    entry\n          (other places also)
| +
| +	if (!rbu_data.num_packets) {
| +		pr_debug("fill_last_packet: num_packets=0\n");
| +		return -ENOMEM;
| +	}
| +
| +	packet_count = rbu_data.num_packets;
| +
| +	ptemp_list = (&packet_data_head.list)->prev;
| +
| +	packet = list_entry(ptemp_list, struct packet_data, list);
| +
| +	if ((rbu_data.packet_write_count + length) > rbu_data.packetsize) {
| +		pr_debug("dell_rbu:%s: packet size data "
| +			"overrun\n", __FUNCTION__);
| +		return -EINVAL;
| +	}
| +
| +	pr_debug("fill_last_packet : buffer = %p\n", packet->data);
| +
| +	memcpy((packet->data + rbu_data.packet_write_count), data, length);
| +
| +	if ((rbu_data.packet_write_count + length) == rbu_data.packetsize) {
| +		/*
| +		 * this was the last data chunk in the packet
| +		 * so reinitialize the packet data counter to zero
| +		 */
| +		rbu_data.packet_write_count = 0;
| +	} else
| +		rbu_data.packet_write_count += length;
| +
| +	pr_debug("fill_last_packet: exit \n");
                                    exit\n         (other places too)
| +	return 0;
| +}
| +
| +static int
| +create_packet(size_t length)
| +{
| +	struct packet_data *newpacket;
| +	int ordernum = 0;
| +
| +	pr_debug("create_packet: entry \n");
| +
| +	if (!rbu_data.packetsize) {
| +		pr_debug("create_packet: packetsize not specified\n");
| +		return -EINVAL;
| +	}
| +
| +	newpacket = kmalloc(sizeof (struct packet_data), GFP_KERNEL);
| +	if (!newpacket) {
| +		printk(KERN_WARNING
| +			"dell_rbu:%s: failed to allocate new "
| +			"packet\n", __FUNCTION__);
| +		return -ENOMEM;
| +	}
| +
| +	ordernum = get_order(length);
| +	/*
| +	 * there is no upper limit on memory 
| +	 * address for packetized mechanism 
| +	 */
| +	newpacket->data = (unsigned char *) __get_free_pages(GFP_KERNEL,
| +		ordernum);
| +
| +	pr_debug("create_packet: newpacket %p\n", newpacket->data);
                      actually   newpacket->data
| +
| +	if (!newpacket->data) {
| +		printk(KERN_WARNING
| +			"dell_rbu:%s: failed to allocate new "
| +			"packet\n", __FUNCTION__);
| +		kfree(newpacket);
| +		return -ENOMEM;
| +	}
| +
| +	newpacket->ordernum = ordernum;
| +	++rbu_data.num_packets;
| +	/*
| +	 * initialize the newly created packet headers 
| +	 */
| +	INIT_LIST_HEAD(&newpacket->list);
| +	list_add_tail(&newpacket->list, &packet_data_head.list);
| +	/*
| +	 * packets have fixed size 
| +	 */
| +	newpacket->length = rbu_data.packetsize;
| +
| +	pr_debug("create_packet: exit \n");
| +
| +	return 0;
| +}
| +
| +static int
| +packetize_data(void *data, size_t length)
| +{
| +	int rc = 0;
| +
| +	if (!rbu_data.packet_write_count) {
| +		if ((rc = create_packet(length)))
| +			return rc;
| +	}
| +	if ((rc = fill_last_packet(data, length)))
Just do:
	rc = fill_packet(data, length);
	return rc;

| +		return rc;
| +
| +	return rc;
| +}
| +
| +static int
| +packet_read_list(char *data, size_t * pread_length)
| +{
| +	struct list_head *ptemp_list;
| +	int temp_count = 0;
| +	int bytes_copied = 0;
| +	int bytes_read = 0;
| +	int remaining_bytes = 0;
| +	char *pdest = data;
| +
| +	/* check if we have any packets */
| +	if (0 == rbu_data.num_packets)

Please use (variable == constant) form.

| +		return -ENOMEM;
| +
| +	remaining_bytes = *pread_length;
| +	bytes_read = rbu_data.packet_read_count;
| +
| +	ptemp_list = (&packet_data_head.list)->next;
| +	while (!list_empty(ptemp_list)) {
| +		bytes_copied = do_packet_read(pdest, ptemp_list,
| +			remaining_bytes, bytes_read, &temp_count);
| +		remaining_bytes -= bytes_copied;
| +		bytes_read += bytes_copied;
| +		pdest += bytes_copied;
| +		/*
| +		 * check if we reached end of buffer before reaching the
| +		 * last packet
| +		 */
| +		if (remaining_bytes == 0)
| +			break;
| +
| +		ptemp_list = ptemp_list->next;
| +	}
| +	/*finally set the bytes read */
        /* finally
| +	*pread_length = bytes_read - rbu_data.packet_read_count;
| +	rbu_data.packet_read_count = bytes_read;
| +	return 0;
| +}
| +
| +
| +static ssize_t
| +read_packet_data(char *buffer, loff_t pos, size_t count)
| +{
| +	int retval;
| +	size_t bytes_left;
| +	size_t data_length;
| +	char *ptempBuf = buffer;
| +	unsigned long imagesize;
| +
| +	/* check to see if we have something to return */
| +	if (rbu_data.num_packets == 0) {
| +		pr_debug("read_packet_data: no packets written\n");
| +		retval = -ENOMEM;
| +		goto read_rbu_data_exit;
| +	}
| +
| +	imagesize = rbu_data.num_packets * rbu_data.packetsize;
| +
| +	if (pos > imagesize) {
| +		retval = 0;
| +		printk(KERN_WARNING "dell_rbu:read_packet_data: "
| +			"data underrun\n");
| +		goto read_rbu_data_exit;
| +	}
| +
| +	bytes_left = imagesize - pos;
| +	data_length = min(bytes_left, count);
| +
| +	if ((retval = packet_read_list(ptempBuf, &data_length)) < 0)
| +		goto read_rbu_data_exit;
| +
| +	if ((pos + count) > imagesize) {
| +		rbu_data.packet_read_count = 0;
| +		/* this was the last copy */
| +		retval = bytes_left;
| +	} else
| +		retval = count;
| +
| +      read_rbu_data_exit:
Darn, almost missed that label.  Please move it to column 1 (or 0).
It's hidden as is.

| +	return retval;
| +}
| +
| +static ssize_t
| +read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
| +{
| +	unsigned char *ptemp = NULL;
| +	size_t bytes_left = 0;
| +	size_t data_length = 0;
| +	ssize_t ret_count = 0;
| +
| +	/* check to see if we have something to return */
| +	if ((rbu_data.image_update_buffer == NULL) ||
| +		(rbu_data.bios_image_size == 0)) {
| +		pr_debug("read_rbu_data_mono: image_update_buffer %p ,"
| +			"bios_image_size %lu\n",
| +			rbu_data.image_update_buffer,
| +			rbu_data.bios_image_size);
| +		ret_count = -ENOMEM;
| +		goto read_rbu_data_exit;
| +	}
| +
| +	if (pos > rbu_data.bios_image_size) {
| +		ret_count = 0;
| +		goto read_rbu_data_exit;
| +	}
| +
| +	bytes_left = rbu_data.bios_image_size - pos;
| +	data_length = min(bytes_left, count);
| +
| +	ptemp = rbu_data.image_update_buffer;
| +	memcpy(buffer, (ptemp + pos), data_length);
| +
| +	if ((pos + count) > rbu_data.bios_image_size)
| +		/* this was the last copy */
| +		ret_count = bytes_left;
| +	else
| +		ret_count = count;
| +      read_rbu_data_exit:

Label in column 1.

| +	return ret_count;
| +}
| +
| +static ssize_t
| +read_rbu_data(struct kobject *kobj, char *buffer, loff_t pos, size_t count)
| +{
| +	ssize_t ret_count = 0;
| +
| +	spin_lock(&rbu_data.lock);
| +
| +	if (!strcmp(image_type, "mono"))
| +		ret_count = read_rbu_mono_data(buffer, pos, count);
| +	else if (!strcmp(image_type, "packet"))
| +		ret_count = read_packet_data(buffer, pos, count);
| +	else
| +		pr_debug("read_rbu_data: invalid image type specified\n");

Why is this pr_debug() and not a printk(KERN_WARNING...)?

| +
| +	spin_unlock(&rbu_data.lock);
| +	return ret_count;
| +}
| +
| +static ssize_t
| +rbu_show_image_type(struct platform_device *rbu_dev, char *buf)
| +{
| +	unsigned int size = 0;

Don't need to init size to 0 and then to the return value of
sprintf().

| +	size = sprintf(buf, "%s\n", image_type);
| +	return size;
| +}
| +
| +static ssize_t
| +rbu_store_image_type(struct platform_device *rbu_dev,
| +	const char *buf, size_t count)
| +{
| +	int rc = count;

Blank line between data and code, please.

| +	spin_lock(&rbu_data.lock);
| +
| +	if (strlen(buf) < MAX_IMAGE_LENGTH)
| +		sscanf(buf, "%s", image_type);
| +	else
| +		printk(KERN_WARNING "dell_rbu: image_type is invalid"
| +			"max chars = %d\n", MAX_IMAGE_LENGTH);
| +
| +	/* we must free all previous allocations */
| +	packet_empty_list();
| +	img_update_free();
| +
| +	spin_unlock(&rbu_data.lock);
| +	return rc;
| +}
| +
| +struct rbu_attribute {
| +	struct attribute attr;
| +	 ssize_t(*show) (struct platform_device * rbu_dev, char *buf);
| +	 ssize_t(*store) (struct platform_device * rbu_dev,
| +		const char *buf, size_t count);
| +};
| +
| +#define RBU_DEVICE_ATTR(_name,_mode,_show,_store ) \
| +struct rbu_attribute rbu_attr_##_name = {       \
| +	.attr ={.name= __stringify(_name), .mode= _mode, .owner= THIS_MODULE},\

Use some spaces around '=', as in " = ".  And like below.

| +	.show = _show,                                \
| +	.store = _store,                                \
| +};
| +
| +static RBU_DEVICE_ATTR(image_type, 0644, rbu_show_image_type,
| +	rbu_store_image_type);
| +
| +static struct bin_attribute rbu_data_attr = {
| +	.attr = {.name = "data",.owner = THIS_MODULE,.mode = 0444},

Spaces around '-' and after ','.

| +	.read = read_rbu_data,
| +};
| +
| +void
| +callbackfn_rbu(const struct firmware *fw, void *context)
| +{
| +	int rc = 0;
| +
| +	if (!fw || !fw->size)
| +		return;
| +
| +	spin_lock(&rbu_data.lock);
| +	if (!strcmp(image_type, "mono")) {
| +		if (!img_update_realloc(fw->size))
| +			memcpy(rbu_data.image_update_buffer,
| +				fw->data, fw->size);
| +	} else if (!strcmp(image_type, "packet")) {
| +		if (!rbu_data.packetsize)
| +			rbu_data.packetsize = fw->size;
| +		else if (rbu_data.packetsize != fw->size) {
| +			packet_empty_list();
| +			rbu_data.packetsize = fw->size;
| +		}
| +		packetize_data(fw->data, fw->size);
| +	} else
| +		pr_debug("invalid image type specified.\n");

Wny pr_debug() instead of printk() ?

| +	spin_unlock(&rbu_data.lock);
| +
| +	rc = request_firmware_nowait_nohotplug(THIS_MODULE,
| +		"dell_rbu", &rbu_device->dev, &context, callbackfn_rbu);
| +	if (rc)
| +		printk(KERN_ERR
| +			"dell_rbu:%s request_firmware_nowait failed"
| +			" %d\n", __FUNCTION__, rc);
| +}
| +
| +static int __init
| +dcdrbu_init(void)
| +{
| +	int rc = 0;

Blank line here, please.

| +	spin_lock_init(&rbu_data.lock);
| +
| +	init_packet_head();
| +
| +	rbu_device =
| +		platform_device_register_simple("dell_rbu", -1, NULL, 0);
| +	if (!rbu_device) {
| +		printk(KERN_ERR
| +			"dell_rbu:%s:platform_device_register_simple "
| +			"failed\n", __FUNCTION__);
| +		return -EIO;
| +	}
| +
| +	sysfs_create_file(&rbu_device->dev.kobj,
| +		&rbu_attr_image_type.attr);
| +
| +	sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_data_attr);
| +
| +	rc = request_firmware_nowait_nohotplug(THIS_MODULE,
| +		"dell_rbu", &rbu_device->dev, &context, callbackfn_rbu);
| +	if (rc)
| +		printk(KERN_ERR "dell_rbu:%s:request_firmware_nowait"
| +			" failed %d\n", __FUNCTION__, rc);
| +
| +	return rc;
| +
| +}
| +
| +static __exit void
| +dcdrbu_exit(void)
| +{
| +	spin_lock(&rbu_data.lock);
| +	packet_empty_list();
| +	img_update_free();
| +	spin_unlock(&rbu_data.lock);
| +	platform_device_unregister(rbu_device);
| +}
| +
| +module_exit(dcdrbu_exit);
| +module_init(dcdrbu_init);
| diff -uprN linux-2.6.11.11.orig/drivers/firmware/Kconfig linux-2.6.11.11.new/drivers/firmware/Kconfig
| --- linux-2.6.11.11.orig/drivers/firmware/Kconfig	2005-06-14 21:00:10.000000000 -0500
| +++ linux-2.6.11.11.new/drivers/firmware/Kconfig	2005-06-30 15:37:43.000000000 -0500
| @@ -58,4 +58,15 @@ config EFI_PCDP
|  
|  	  See <http://www.dig64.org/specifications/DIG64_HCDPv20_042804.pdf>
|  
| +config DELL_RBU
| +	tristate "BIOS update support for DELL systems via sysfs"
| +	default y

Why does the rest of the world want to build this driver?

| +	select FW_LOADER
| +	help
| +	 Say Y if you want to have the option of updating the BIOS for your
| +	 DELL system. Note you need a supporting application to comunicate
| +	 with the BIOS regardin the new image for the image update to
| +	 take effect.

When & where is this mystery app going to be available?

| +	 See <file:Documentation/dell_rbu.txt> for more details on the driver.
| +
|  endmenu


---
~Randy
