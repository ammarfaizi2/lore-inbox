Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbVF3PzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbVF3PzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 11:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbVF3Pyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 11:54:32 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:57472 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262974AbVF3PuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:50:16 -0400
X-IronPort-AV: i="3.94,154,1118034000"; 
   d="scan'208"; a="280106931:sNHT21339992"
Date: Thu, 30 Jun 2005 15:48:30 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, abhay_salunke@dell.com
Cc: greg@kroah.com
Subject: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050630204830.GA3565@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 08:55:52AM -0700, Greg KH wrote:
> On Wed, Jun 29, 2005 at 03:26:40PM -0500, Abhay Salunke wrote:
> > This patch adds a new function to firmware_calss.c request_firmware_nowait_nohotplug .
> > The dell_rbu driver uses this call to create entries in /sys/class/firmware.
>
> No, this patch is your whole driver and the firmware changes all
> together.  Please split this up into at least two different patches so
> we can review them easier.

This mail hs the patch for dell_rbu only , will be sending another patch for firmware_class.c

Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>

Thanks
Abhay
diff -uprN linux-2.6.11.11.orig/Documentation/dell_rbu.txt linux-2.6.11.11.new/Documentation/dell_rbu.txt
--- linux-2.6.11.11.orig/Documentation/dell_rbu.txt	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.11.new/Documentation/dell_rbu.txt	2005-06-30 15:41:28.000000000 -0500
@@ -0,0 +1,72 @@
+Purpose:
+Demonstrate the usage of the new open sourced rbu (Remote BIOS Update) driver
+for updating BIOS images on Dell servers and desktops.
+
+Scope:
+This document discusses the functionality of the rbu driver only.
+It does not cover the support needed from aplications to enable the BIOS to
+update itself with the image downloaded in to the memory.
+
+Overview:
+This driver enables userspace applications to update the BIOS on Dell servers
+(starting from servers sold since 1999), desktops and notebooks (starting
+from those sold in 2005).
+
+The driver supports BIOS update using the monilothic image and packetized
+image methods. In case of moniolithic the driver allocates a contiguous chunk
+of physical pages having the BIOS image. In case of packetized the app
+using the driver breaks the image in to packets of fixed sizes and the driver
+would place each packet in contiguous physical memory. The driver also
+maintains a link list of packets for reading them back.
+If the dell_rbu driver is unloaded all the allocated memory is freed.
+
+The rbu driver needs to have an application which will inform the BIOS to
+enable the update in the next system reboot.
+
+The user should not unload the rbu driver after downloading the BIOS image
+or updating.
+
+The driver load creates the following directories under the /sys file system.
+/sys/class/firmware/dell_rbu/loading 
+/sys/class/firmware/dell_rbu/data
+/sys/devices/platform/dell_rbu/image_type
+/sys/devices/platform/dell_rbu/data
+
+The driver supports two types of update mechanism; monolithic and packetized.
+These update mechanism depends upon the BIOS currently running on the system.
+Most of the Dell systems support a monolithic update where the BIOS image is 
+copied to a single contiguous block of physical memory. 
+In case of packet mechanism the single memory can be broken in smaller chuks
+of contiguous memory and the BIOS image is scattered in these packets.
+
+By default the driver uses monolithic memory for the update type. This can be
+changed to contiguous during the driver load time by specifying the load
+parameter image_type=packet.  This can also be changed later as below
+echo "packet" > /sys/devices/platform/dell_rbu/image_type 
+
+Do the steps below to download the BIOS image.
+1) echo 1 > /sys/class/firmware/dell_rbu/loading
+2) cp bios_image.hdr /sys/class/firmware/dell_rbu/data
+3) echo 0 > /sys/class/firmware/dell_rbu/loading
+
+The /sys/class/firmware/dell_rbu/ entries will remain till the following is
+done. 
+echo -1 > /sys/class/firmware/dell_rbu/loading
+
+Until this step is completed the drivr cannot be unloaded.
+
+Also the driver provides /sys/devices/platform/dell_rbu/data readonly file to
+read back the image downloaded. This is useful in case of packet update 
+mechanism where the above steps 1,2,3 will repeated for every packet. 
+By reading the /sys/devices/platform/dell_rbu/data file all packet data 
+downloaded can be verified in a single file. 
+The packets are arranged in this file one after the other in a FIFO order.
+
+NOTE:
+This driver requires a patch for firmware_class.c which has the addition
+of request_firmware_nowait_nohotplug function to wortk
+Also after updating the BIOS image an user mdoe application neeeds to execute
+code which message the BIOS update request to the BIOS. So on the next reboot
+the BIOS knows about the new image downloaded and it updates it self.
+Also don't unload the rbu drive if the image has to be updated.
+
diff -uprN linux-2.6.11.11.orig/drivers/firmware/dell_rbu.c linux-2.6.11.11.new/drivers/firmware/dell_rbu.c
--- linux-2.6.11.11.orig/drivers/firmware/dell_rbu.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.11.new/drivers/firmware/dell_rbu.c	2005-06-30 15:37:27.000000000 -0500
@@ -0,0 +1,627 @@
+/*
+ * dell_rbu.c
+ * Bios Update driver for Dell systems
+ * Author: Dell Inc
+ *         Abhay Salunke <abhay_salunke@dell.com>
+ *
+ * Copyright (C) 2005 Dell Inc.
+ *
+ * Remote BIOS Update (rbu) driver is used for updating DELL BIOS by 
+ * creating entries in the /sys file systems on Linux 2.6 and higher 
+ * kernels. The driver supports two mechanism to update the BIOS namely 
+ * contiguous and packetized. Both these methods still require having some
+ * application to set the CMOS bit indicating the BIOS to update itself 
+ * after a reboot.
+ *
+ * Contiguous method:
+ * This driver writes the incoming data in a monolithic image by allocating 
+ * contiguous physical pages large enough to accommodate the incoming BIOS 
+ * image size.  
+ *
+ * Packetized method:
+ * The driver writes the incoming packet image by allocating a new packet 
+ * on every time the packet data is written. This driver requires an 
+ * application to break the BIOS image in to fixed sized packet chunks.
+ *
+ * See Documentation/dell_rbu.txt for more info.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License v2.0 as published by
+ * the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/blkdev.h>
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/moduleparam.h>
+#include <linux/firmware.h>
+#include <linux/dma-mapping.h>
+
+MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
+MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
+
+#define BIOS_SCAN_LIMIT 0xffffffff
+#define MAX_IMAGE_LENGTH 16
+static struct _rbu_data {
+	void *image_update_buffer;
+	unsigned long image_update_buffer_size;
+	unsigned long bios_image_size;
+	spinlock_t lock;
+	unsigned long packet_read_count;
+	unsigned long packet_write_count;
+	unsigned long num_packets;
+	unsigned long packetsize;
+} rbu_data;
+
+static char image_type[MAX_IMAGE_LENGTH] = "mono";
+module_param_string(image_type, image_type, sizeof (image_type), 0);
+MODULE_PARM_DESC(image_type, "BIOS image type. choose- mono or packet");
+
+struct packet_data {
+	struct list_head list;
+	size_t length;
+	void *data;
+	int ordernum;
+};
+
+static struct packet_data packet_data_head;
+
+struct platform_device *rbu_device;
+int context;
+static dma_addr_t dell_rbu_dmaaddr;
+
+static void
+init_packet_head(void)
+{
+	INIT_LIST_HEAD(&packet_data_head.list);
+	rbu_data.packet_write_count = 0;
+	rbu_data.packet_read_count = 0;
+	rbu_data.num_packets = 0;
+	rbu_data.packetsize = 0;
+}
+
+static int
+fill_last_packet(void *data, size_t length)
+{
+	struct list_head *ptemp_list;
+	struct packet_data *packet = NULL;
+	int packet_count = 0;
+
+	pr_debug("fill_last_packet: entry \n");
+
+	if (!rbu_data.num_packets) {
+		pr_debug("fill_last_packet: num_packets=0\n");
+		return -ENOMEM;
+	}
+
+	packet_count = rbu_data.num_packets;
+
+	ptemp_list = (&packet_data_head.list)->prev;
+
+	packet = list_entry(ptemp_list, struct packet_data, list);
+
+	if ((rbu_data.packet_write_count + length) > rbu_data.packetsize) {
+		pr_debug("dell_rbu:%s: packet size data "
+			"overrun\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	pr_debug("fill_last_packet : buffer = %p\n", packet->data);
+
+	memcpy((packet->data + rbu_data.packet_write_count), data, length);
+
+	if ((rbu_data.packet_write_count + length) == rbu_data.packetsize) {
+		/*
+		 * this was the last data chunk in the packet
+		 * so reinitialize the packet data counter to zero
+		 */
+		rbu_data.packet_write_count = 0;
+	} else
+		rbu_data.packet_write_count += length;
+
+	pr_debug("fill_last_packet: exit \n");
+	return 0;
+}
+
+static int
+create_packet(size_t length)
+{
+	struct packet_data *newpacket;
+	int ordernum = 0;
+
+	pr_debug("create_packet: entry \n");
+
+	if (!rbu_data.packetsize) {
+		pr_debug("create_packet: packetsize not specified\n");
+		return -EINVAL;
+	}
+
+	newpacket = kmalloc(sizeof (struct packet_data), GFP_KERNEL);
+	if (!newpacket) {
+		printk(KERN_WARNING
+			"dell_rbu:%s: failed to allocate new "
+			"packet\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+
+	ordernum = get_order(length);
+	/*
+	 * there is no upper limit on memory 
+	 * address for packetized mechanism 
+	 */
+	newpacket->data = (unsigned char *) __get_free_pages(GFP_KERNEL,
+		ordernum);
+
+	pr_debug("create_packet: newpacket %p\n", newpacket->data);
+
+	if (!newpacket->data) {
+		printk(KERN_WARNING
+			"dell_rbu:%s: failed to allocate new "
+			"packet\n", __FUNCTION__);
+		kfree(newpacket);
+		return -ENOMEM;
+	}
+
+	newpacket->ordernum = ordernum;
+	++rbu_data.num_packets;
+	/*
+	 * initialize the newly created packet headers 
+	 */
+	INIT_LIST_HEAD(&newpacket->list);
+	list_add_tail(&newpacket->list, &packet_data_head.list);
+	/*
+	 * packets have fixed size 
+	 */
+	newpacket->length = rbu_data.packetsize;
+
+	pr_debug("create_packet: exit \n");
+
+	return 0;
+}
+
+static int
+packetize_data(void *data, size_t length)
+{
+	int rc = 0;
+
+	if (!rbu_data.packet_write_count) {
+		if ((rc = create_packet(length)))
+			return rc;
+	}
+	if ((rc = fill_last_packet(data, length)))
+		return rc;
+
+	return rc;
+}
+
+int
+do_packet_read(char *data, struct list_head *ptemp_list,
+	int length, int bytes_read, int *list_read_count)
+{
+	void *ptemp_buf;
+	struct packet_data *newpacket = NULL;
+	int bytes_copied = 0;
+	int j = 0;
+
+	newpacket = list_entry(ptemp_list, struct packet_data, list);
+	*list_read_count += newpacket->length;
+
+	if (*list_read_count > bytes_read) {
+		/* point to the start of unread data */
+		j = newpacket->length - (*list_read_count - bytes_read);
+		/* point to the offset in the packet buffer */
+		ptemp_buf = (u8 *) newpacket->data + j;
+		/* 
+		 * check if there is enough room in 
+		 * * the incoming buffer 
+		 */
+		if (length > (*list_read_count - bytes_read))
+			/* 
+			 * copy what ever is there in this 
+			 * * packet and move on 
+			 */
+			bytes_copied = (*list_read_count - bytes_read);
+		else
+			/* copy the remaining */
+			bytes_copied = length;
+		memcpy(data, ptemp_buf, bytes_copied);
+	}
+	return bytes_copied;
+}
+
+static int
+packet_read_list(char *data, size_t * pread_length)
+{
+	struct list_head *ptemp_list;
+	int temp_count = 0;
+	int bytes_copied = 0;
+	int bytes_read = 0;
+	int remaining_bytes = 0;
+	char *pdest = data;
+
+	/* check if we have any packets */
+	if (0 == rbu_data.num_packets)
+		return -ENOMEM;
+
+	remaining_bytes = *pread_length;
+	bytes_read = rbu_data.packet_read_count;
+
+	ptemp_list = (&packet_data_head.list)->next;
+	while (!list_empty(ptemp_list)) {
+		bytes_copied = do_packet_read(pdest, ptemp_list,
+			remaining_bytes, bytes_read, &temp_count);
+		remaining_bytes -= bytes_copied;
+		bytes_read += bytes_copied;
+		pdest += bytes_copied;
+		/*
+		 * check if we reached end of buffer before reaching the
+		 * last packet
+		 */
+		if (remaining_bytes == 0)
+			break;
+
+		ptemp_list = ptemp_list->next;
+	}
+	/*finally set the bytes read */
+	*pread_length = bytes_read - rbu_data.packet_read_count;
+	rbu_data.packet_read_count = bytes_read;
+	return 0;
+}
+
+static void
+packet_empty_list(void)
+{
+	struct list_head *ptemp_list;
+	struct list_head *pnext_list;
+	struct packet_data *newpacket;
+
+	ptemp_list = (&packet_data_head.list)->next;
+	while (!list_empty(ptemp_list)) {
+		newpacket =
+			list_entry(ptemp_list, struct packet_data, list);
+		pnext_list = ptemp_list->next;
+		list_del(ptemp_list);
+		ptemp_list = pnext_list;
+		/*
+		 * zero out the RBU packet memory before freeing 
+		 * to make sure there are no stale RBU packets left in memory
+		 */
+		memset(newpacket->data, 0, rbu_data.packetsize);
+		free_pages((unsigned long) newpacket->data,
+			newpacket->ordernum);
+		kfree(newpacket);
+	}
+	rbu_data.packet_write_count = 0;
+	rbu_data.packet_read_count = 0;
+	rbu_data.num_packets = 0;
+	rbu_data.packetsize = 0;
+}
+
+/*
+ * img_update_free: Frees the buffer allocated for storing BIOS image
+ * Always called with lock held and returned with lock held 
+ */
+static void
+img_update_free(void)
+{
+	if (!rbu_data.image_update_buffer)
+		return;
+	/*
+	 * zero out this buffer before freeing it to get rid of any stale
+	 * BIOS image copied in memory.
+	 */
+	memset(rbu_data.image_update_buffer, 0,
+		rbu_data.image_update_buffer_size);
+	dma_free_coherent(NULL, rbu_data.bios_image_size,
+		rbu_data.image_update_buffer, dell_rbu_dmaaddr);
+
+	/*
+	 * Re-initialize the rbu_data variables after a free 
+	 */
+	rbu_data.image_update_buffer = NULL;
+	rbu_data.image_update_buffer_size = 0;
+	rbu_data.bios_image_size = 0;
+}
+
+/*
+ * img_update_realloc: This function allocates the contiguous pages to
+ * accommodate the requested size of data. The memory address and size
+ * values are stored globally and on every call to this function the new
+ * size is checked to see if more data is required than the existing size. 
+ * If true the previous memory is freed and new allocation is done to
+ * accommodate the new size. If the incoming size is less then than the
+ * already allocated size, then that memory is reused. This function is
+ * called with lock held and returns with lock held. 
+ */
+static int
+img_update_realloc(unsigned long size)
+{
+	unsigned char *image_update_buffer = NULL;
+	unsigned long rc;
+
+	/*
+	 * check if the buffer of sufficient size has been 
+	 * already allocated 
+	 */
+	if (rbu_data.image_update_buffer_size >= size) {
+		/*
+		 * check for corruption 
+		 */
+		if ((size != 0) && (rbu_data.image_update_buffer == NULL)) {
+			printk(KERN_ERR "dell_rbu:%s: corruption "
+				"check failed\n", __FUNCTION__);
+			return -EINVAL;
+		}
+		/*
+		 * we have a valid pre-allocated buffer with 
+		 * sufficient size 
+		 */
+		return 0;
+	}
+
+	/*
+	 * free any previously allocated buffer 
+	 */
+	img_update_free();
+
+	spin_unlock(&rbu_data.lock);
+
+	image_update_buffer = dma_alloc_coherent(NULL, size,
+		&dell_rbu_dmaaddr, GFP_KERNEL);
+
+	spin_lock(&rbu_data.lock);
+
+	if (image_update_buffer != NULL) {
+		rbu_data.image_update_buffer = image_update_buffer;
+		rbu_data.image_update_buffer_size = size;
+		rbu_data.bios_image_size =
+			rbu_data.image_update_buffer_size;
+		rc = 0;
+	} else {
+		pr_debug("Not enough memory for image update:"
+			"size = %ld\n", size);
+		rc = -ENOMEM;
+	}
+
+	return rc;
+}
+
+static ssize_t
+read_packet_data(char *buffer, loff_t pos, size_t count)
+{
+	int retval;
+	size_t bytes_left;
+	size_t data_length;
+	char *ptempBuf = buffer;
+	unsigned long imagesize;
+
+	/* check to see if we have something to return */
+	if (rbu_data.num_packets == 0) {
+		pr_debug("read_packet_data: no packets written\n");
+		retval = -ENOMEM;
+		goto read_rbu_data_exit;
+	}
+
+	imagesize = rbu_data.num_packets * rbu_data.packetsize;
+
+	if (pos > imagesize) {
+		retval = 0;
+		printk(KERN_WARNING "dell_rbu:read_packet_data: "
+			"data underrun\n");
+		goto read_rbu_data_exit;
+	}
+
+	bytes_left = imagesize - pos;
+	data_length = min(bytes_left, count);
+
+	if ((retval = packet_read_list(ptempBuf, &data_length)) < 0)
+		goto read_rbu_data_exit;
+
+	if ((pos + count) > imagesize) {
+		rbu_data.packet_read_count = 0;
+		/* this was the last copy */
+		retval = bytes_left;
+	} else
+		retval = count;
+
+      read_rbu_data_exit:
+	return retval;
+}
+
+static ssize_t
+read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
+{
+	unsigned char *ptemp = NULL;
+	size_t bytes_left = 0;
+	size_t data_length = 0;
+	ssize_t ret_count = 0;
+
+	/* check to see if we have something to return */
+	if ((rbu_data.image_update_buffer == NULL) ||
+		(rbu_data.bios_image_size == 0)) {
+		pr_debug("read_rbu_data_mono: image_update_buffer %p ,"
+			"bios_image_size %lu\n",
+			rbu_data.image_update_buffer,
+			rbu_data.bios_image_size);
+		ret_count = -ENOMEM;
+		goto read_rbu_data_exit;
+	}
+
+	if (pos > rbu_data.bios_image_size) {
+		ret_count = 0;
+		goto read_rbu_data_exit;
+	}
+
+	bytes_left = rbu_data.bios_image_size - pos;
+	data_length = min(bytes_left, count);
+
+	ptemp = rbu_data.image_update_buffer;
+	memcpy(buffer, (ptemp + pos), data_length);
+
+	if ((pos + count) > rbu_data.bios_image_size)
+		/* this was the last copy */
+		ret_count = bytes_left;
+	else
+		ret_count = count;
+      read_rbu_data_exit:
+	return ret_count;
+}
+
+static ssize_t
+read_rbu_data(struct kobject *kobj, char *buffer, loff_t pos, size_t count)
+{
+	ssize_t ret_count = 0;
+
+	spin_lock(&rbu_data.lock);
+
+	if (!strcmp(image_type, "mono"))
+		ret_count = read_rbu_mono_data(buffer, pos, count);
+	else if (!strcmp(image_type, "packet"))
+		ret_count = read_packet_data(buffer, pos, count);
+	else
+		pr_debug("read_rbu_data: invalid image type specified\n");
+
+	spin_unlock(&rbu_data.lock);
+	return ret_count;
+}
+
+static ssize_t
+rbu_show_image_type(struct platform_device *rbu_dev, char *buf)
+{
+	unsigned int size = 0;
+	size = sprintf(buf, "%s\n", image_type);
+	return size;
+}
+
+static ssize_t
+rbu_store_image_type(struct platform_device *rbu_dev,
+	const char *buf, size_t count)
+{
+	int rc = count;
+	spin_lock(&rbu_data.lock);
+
+	if (strlen(buf) < MAX_IMAGE_LENGTH)
+		sscanf(buf, "%s", image_type);
+	else
+		printk(KERN_WARNING "dell_rbu: image_type is invalid"
+			"max chars = %d\n", MAX_IMAGE_LENGTH);
+
+	/* we must free all previous allocations */
+	packet_empty_list();
+	img_update_free();
+
+	spin_unlock(&rbu_data.lock);
+	return rc;
+}
+
+struct rbu_attribute {
+	struct attribute attr;
+	 ssize_t(*show) (struct platform_device * rbu_dev, char *buf);
+	 ssize_t(*store) (struct platform_device * rbu_dev,
+		const char *buf, size_t count);
+};
+
+#define RBU_DEVICE_ATTR(_name,_mode,_show,_store ) \
+struct rbu_attribute rbu_attr_##_name = {       \
+	.attr ={.name= __stringify(_name), .mode= _mode, .owner= THIS_MODULE},\
+	.show = _show,                                \
+	.store = _store,                                \
+};
+
+static RBU_DEVICE_ATTR(image_type, 0644, rbu_show_image_type,
+	rbu_store_image_type);
+
+static struct bin_attribute rbu_data_attr = {
+	.attr = {.name = "data",.owner = THIS_MODULE,.mode = 0444},
+	.read = read_rbu_data,
+};
+
+void
+callbackfn_rbu(const struct firmware *fw, void *context)
+{
+	int rc = 0;
+
+	if (!fw || !fw->size)
+		return;
+
+	spin_lock(&rbu_data.lock);
+	if (!strcmp(image_type, "mono")) {
+		if (!img_update_realloc(fw->size))
+			memcpy(rbu_data.image_update_buffer,
+				fw->data, fw->size);
+	} else if (!strcmp(image_type, "packet")) {
+		if (!rbu_data.packetsize)
+			rbu_data.packetsize = fw->size;
+		else if (rbu_data.packetsize != fw->size) {
+			packet_empty_list();
+			rbu_data.packetsize = fw->size;
+		}
+		packetize_data(fw->data, fw->size);
+	} else
+		pr_debug("invalid image type specified.\n");
+	spin_unlock(&rbu_data.lock);
+
+	rc = request_firmware_nowait_nohotplug(THIS_MODULE,
+		"dell_rbu", &rbu_device->dev, &context, callbackfn_rbu);
+	if (rc)
+		printk(KERN_ERR
+			"dell_rbu:%s request_firmware_nowait failed"
+			" %d\n", __FUNCTION__, rc);
+}
+
+static int __init
+dcdrbu_init(void)
+{
+	int rc = 0;
+	spin_lock_init(&rbu_data.lock);
+
+	init_packet_head();
+
+	rbu_device =
+		platform_device_register_simple("dell_rbu", -1, NULL, 0);
+	if (!rbu_device) {
+		printk(KERN_ERR
+			"dell_rbu:%s:platform_device_register_simple "
+			"failed\n", __FUNCTION__);
+		return -EIO;
+	}
+
+	sysfs_create_file(&rbu_device->dev.kobj,
+		&rbu_attr_image_type.attr);
+
+	sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_data_attr);
+
+	rc = request_firmware_nowait_nohotplug(THIS_MODULE,
+		"dell_rbu", &rbu_device->dev, &context, callbackfn_rbu);
+	if (rc)
+		printk(KERN_ERR "dell_rbu:%s:request_firmware_nowait"
+			" failed %d\n", __FUNCTION__, rc);
+
+	return rc;
+
+}
+
+static __exit void
+dcdrbu_exit(void)
+{
+	spin_lock(&rbu_data.lock);
+	packet_empty_list();
+	img_update_free();
+	spin_unlock(&rbu_data.lock);
+	platform_device_unregister(rbu_device);
+}
+
+module_exit(dcdrbu_exit);
+module_init(dcdrbu_init);
diff -uprN linux-2.6.11.11.orig/drivers/firmware/Kconfig linux-2.6.11.11.new/drivers/firmware/Kconfig
--- linux-2.6.11.11.orig/drivers/firmware/Kconfig	2005-06-14 21:00:10.000000000 -0500
+++ linux-2.6.11.11.new/drivers/firmware/Kconfig	2005-06-30 15:37:43.000000000 -0500
@@ -58,4 +58,15 @@ config EFI_PCDP
 
 	  See <http://www.dig64.org/specifications/DIG64_HCDPv20_042804.pdf>
 
+config DELL_RBU
+	tristate "BIOS update support for DELL systems via sysfs"
+	default y
+	select FW_LOADER
+	help
+	 Say Y if you want to have the option of updating the BIOS for your
+	 DELL system. Note you need a supporting application to comunicate
+	 with the BIOS regardin the new image for the image update to
+	 take effect.
+	 See <file:Documentation/dell_rbu.txt> for more details on the driver.
+
 endmenu
diff -uprN linux-2.6.11.11.orig/drivers/firmware/Makefile linux-2.6.11.11.new/drivers/firmware/Makefile
--- linux-2.6.11.11.orig/drivers/firmware/Makefile	2005-06-14 21:01:11.000000000 -0500
+++ linux-2.6.11.11.new/drivers/firmware/Makefile	2005-06-30 15:37:35.000000000 -0500
@@ -4,3 +4,4 @@
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_EFI_VARS)		+= efivars.o
 obj-$(CONFIG_EFI_PCDP)		+= pcdp.o
+obj-$(CONFIG_DELL_RBU)          += dell_rbu.o
