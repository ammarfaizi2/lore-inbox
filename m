Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVFOSHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFOSHD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVFOSHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:07:03 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:50342 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261259AbVFOSDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 14:03:31 -0400
X-IronPort-AV: i="3.93,201,1115010000"; 
   d="scan'208"; a="254677685:sNHT31313600"
Date: Wed, 15 Jun 2005 12:59:46 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: abhay_salunke@dell.com, matt_domsch@dell.com, Greg KH <greg@kroah.com>
Subject: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050615175946.GA1495@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses request_firmware_nowait without having to modify any firmware_class.c code.

By making a contribution to this project, I certify that:
The contribution was created in whole or in part by me and I have the
right to submit it under the open source license indicated in the file.
Resubmitting after cleaning up spaces/tabs etc...

Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>

Thanks,
Abhay Salunke
Software Engineer.
DELL Inc

diff -uprN /usr/src/linux-2.6.11.11.orig/Documentation/dell_rbu.txt /usr/src/linux-2.6.11.11/Documentation/dell_rbu.txt
--- /usr/src/linux-2.6.11.11.orig/Documentation/dell_rbu.txt	1969-12-31 18:00:00.000000000 -0600
+++ /usr/src/linux-2.6.11.11/Documentation/dell_rbu.txt	2005-06-14 21:02:09.000000000 -0500
@@ -0,0 +1,62 @@
+Purpose:
+Demonstrate the usage of the new open sourced rbu (Remote BIOS Update) driver 
+for updating BIOS images on Dell hardware.
+
+Scope:
+This document discusses the functionality of the rbu driver only. 
+It does not cover the mechanism related to flipping of the CMOS bit to tell 
+the BIOS for reflashing it self.
+
+Overview:
+The rbu driver is designed to be running on 2.6 kernel. 
+This driver is a open sourced code with one rbu.c (total lines ~500) file.
+The driver supports BIOS update using the monilothic image and packetized
+image methods. In case of moniolithic the driver allocates a contiguous chunk
+of physical pages having the BIOS image. In case of packetized the app
+using the driver breaks the image in to packets of fixed sizes and the driver
+woudl place each packet in contiguous physical memory. The driver also
+maintains a link list of packets if for reading them back.
+If the dell_rbu driver is unloaded all the allocated memory is freed.
+
+The rbu driver needs to have an aplication which flips the CMOS bit to enable 
+the BIOS update after a reboot.
+
+The user should not unload the rbu driver after downloading the BIOS image for updating.
+
+The driver load creates the following directories under the /sys file system.
+/sys/class/firmware/dell_rbu_mono
+/sys/class/firmware/dell_rbu_packet
+/sys/class/firmware/dell_rbu_cancel
+
+each of these directories have the files loading and data.
+
+Always before starting the BIOS update do 
+1> capture value of /sys/class/firmware/timeout 
+2> echo 0 > /sys/class/firmware/timeout
+before exiting the BIOS update script restore the timeout value.
+
+Steps for updating a monolithic image
+1> echo 1 > /sys/class/firmware/dell_rbu_mono/loading
+2> cp image_file /sys/class/firmware/dell_rbu_mono/data
+3> echo 0 > /sys/class/firmware/dell_rbu_mono/loading
+
+Steps for updating a packet image
+1> echo 1 > /sys/class/firmware/dell_rbu_packet/loading
+2> cp image_file /sys/class/firmware/dell_rbu_packet/data
+3> echo 0 > /sys/class/firmware/dell_rbu_packet/loading
+
+The uploaded image can be freed without unloading the driver as follows.
+echo "-1" > /sys/class/firmware/dell_rbu_cancel/loading
+
+
+The user can overwrite the data file with a new image. 
+The user has to make sure that the new image size is less than or equal to the 
+image size copied to the rbudatasize file. 
+If the new image is grater than the allocated size then only the allocated size gets copied the rest will not.
+
+NOTE:
+Afte updating the BIOS image the CMOS bit has to be set by some application to enable the update.
+Also dont unload the rbu drive if the image has to be updated.
+
+
+
diff -uprN /usr/src/linux-2.6.11.11.orig/drivers/firmware/dell_rbu.c /usr/src/linux-2.6.11.11/drivers/firmware/dell_rbu.c
--- /usr/src/linux-2.6.11.11.orig/drivers/firmware/dell_rbu.c	1969-12-31 18:00:00.000000000 -0600
+++ /usr/src/linux-2.6.11.11/drivers/firmware/dell_rbu.c	2005-06-15 15:05:13.928810384 -0500
@@ -0,0 +1,487 @@
+/*
+ * dell_rbu.c
+ * Bios Update driver for Dell systems
+ * Author: Dell Inc
+ *	   Abhay Salunke <abhay_salunke@dell.com>
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
+
+MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
+MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
+
+#define BIOS_SCAN_LIMIT 0xffffffff
+
+static struct _rbu_data {
+	void *image_update_buffer;
+	unsigned long image_update_buffer_size;
+	unsigned long bios_image_size;
+	unsigned long image_update_order_number;
+	spinlock_t lock;
+	unsigned long packet_read_count;
+	unsigned long packet_write_count;
+	unsigned long num_packets;
+	unsigned long packetsize;
+} rbu_data;
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
+static void init_packet_head(void)
+{
+	INIT_LIST_HEAD(&packet_data_head.list);
+	rbu_data.packet_write_count = 0;
+	rbu_data.packet_read_count = 0;
+	rbu_data.num_packets = 0;
+	rbu_data.packetsize = 0;
+}
+
+static struct device rbu_device_mono;
+static struct device rbu_device_packet;
+static struct device rbu_device_cancel;
+
+static int fill_last_packet(void *data, size_t length)
+{
+	struct list_head *ptemp_list;
+	struct packet_data *ppacket = NULL;
+	int packet_count = 0;
+
+	pr_debug("fill_last_packet: entry \n");
+
+	/* check if we have any packets */
+	if (0 == rbu_data.num_packets) {
+		pr_debug("fill_last_packet: num_packets=0\n");
+		return -ENOMEM;
+	}
+
+	packet_count = rbu_data.num_packets;
+
+	ptemp_list = (&packet_data_head.list)->next;
+
+	while (--packet_count)
+		ptemp_list = ptemp_list->next;
+
+	ppacket = list_entry(ptemp_list, struct packet_data, list);
+
+	if ((rbu_data.packet_write_count + length) > rbu_data.packetsize) {
+		printk(KERN_WARNING "fill_last_packet: packet size data "
+		       "overrun\n");
+		return -ENOMEM;
+	}
+
+	pr_debug("fill_last_packet : buffer = %p\n", ppacket->data);
+
+	/* copy the incoming data in to the new buffer */
+	memcpy((ppacket->data + rbu_data.packet_write_count), data, length);
+
+	if ((rbu_data.packet_write_count + length) == rbu_data.packetsize) {
+		/*
+		   this was the last data chunk in the packet
+		   so reinitialize the packet data counter to zero
+		 */
+		rbu_data.packet_write_count = 0;
+	} else
+		rbu_data.packet_write_count += length;
+
+	pr_debug("fill_last_packet: exit \n");
+	return 0;
+}
+
+/*
+ get_free_pages_limited:
+ This is a helper function which allocates free pages based on an upper limit.
+ On x86_64 or 64 bit arch the memory allocation goes above 4GB space which is
+ not addressable by the BIOS. This function tries to get allocation below the
+ limit (4GB) address. It first tries to allocate memory normally using the
+ GFP_KERNEL argument if the incoming limit is non-zero and if the returned
+ physical memory address exceeds the upper limit, the allocated pages are 
+ freed and the memory is reallocated using the GFP_DMA argument.
+*/
+static void *get_free_pages_limited(unsigned long size, int *ordernum,
+				    unsigned long limit)
+{
+	unsigned long img_buf_phys_addr;
+	void *pbuf = NULL;
+
+	*ordernum = get_order(size);
+	/*
+	   Check if we are not getting a very large file.
+	   This can happen as a user error in entering the file size
+	 */
+	if (*ordernum == BITS_PER_LONG) {
+		pr_debug("get_free_pages_limited: Incoming size is"
+			 " very large\n");
+		return NULL;
+	}
+
+	/* try allocating a new buffer to fit the request */
+	pbuf = (unsigned char *)__get_free_pages(GFP_KERNEL, *ordernum);
+
+	if (pbuf) {
+		/* check if the image is with in limits */
+		img_buf_phys_addr = (unsigned long)virt_to_phys(pbuf);
+
+		if (!limit && ((img_buf_phys_addr + size) > limit)) {
+			pr_debug("Got memory above 4GB range, free this "
+				 "and try with DMA memory\n");
+			/*
+			   free this memory as we need it with in 
+			   4GB range 
+			 */
+			free_pages((unsigned long)pbuf, *ordernum);
+			/*
+			   Try allocating a new buffer from the 
+			   GFP_DMA range as it is with in 16MB range.
+			 */
+			pbuf = (unsigned char *)__get_free_pages(GFP_DMA,
+								 *ordernum);
+			if (!pbuf)
+				pr_debug("Failed to get memory "
+					 "of size %ld "
+					 "using GFP_DMA\n", size);
+		}
+	}
+	return pbuf;
+}
+
+static int create_packet(size_t length)
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
+	newpacket = kmalloc(sizeof(struct packet_data), GFP_KERNEL);
+	if (!newpacket) {
+		printk(KERN_WARNING "create_packet: failed to allocate new "
+		       "packet\n");
+		return -ENOMEM;
+	}
+
+	/* there is no upper limit on memory address for packetized mechanism */
+	newpacket->data = get_free_pages_limited(rbu_data.packetsize,
+						 &ordernum, 0);
+	pr_debug("create_packet: newpacket %p\n", newpacket->data);
+
+	if (!newpacket->data) {
+		printk(KERN_WARNING "create_packet: failed to allocate new "
+		       "packet\n");
+		kfree(newpacket);
+		return -ENOMEM;
+	}
+
+	newpacket->ordernum = ordernum;
+	++rbu_data.num_packets;
+	/* initialize the newly created packet headers */
+	INIT_LIST_HEAD(&newpacket->list);
+	list_add_tail(&newpacket->list, &packet_data_head.list);
+	/* packets have fixed size */
+	newpacket->length = rbu_data.packetsize;
+
+	pr_debug("create_packet: exit \n");
+
+	return 0;
+}
+
+static int packetize_data(void *data, size_t length)
+{
+	int rc = 0;
+
+	if (!rbu_data.packet_write_count) {
+		if ((rc = create_packet(length)))
+			return rc;
+	}
+	/* fill data in to the packet */
+	if ((rc = fill_last_packet(data, length)))
+		return rc;
+
+	return rc;
+}
+
+static void packet_empty_list(void)
+{
+	struct list_head *ptemp_list;
+	struct list_head *pnext_list;
+	struct packet_data *newpacket;
+
+	ptemp_list = (&packet_data_head.list)->next;
+	while (!list_empty(ptemp_list)) {
+		newpacket = list_entry(ptemp_list, struct packet_data, list);
+		pnext_list = ptemp_list->next;
+		list_del(ptemp_list);
+		ptemp_list = pnext_list;
+		/*
+		   zero out the RBU packet memory before freeing 
+		   to make sure there are no stale RBU packets left in memory
+		 */
+		memset(newpacket->data, 0, rbu_data.packetsize);
+		free_pages((unsigned long)newpacket->data, newpacket->ordernum);
+		kfree(newpacket);
+	}
+	rbu_data.packet_write_count = 0;
+	rbu_data.packet_read_count = 0;
+	rbu_data.num_packets = 0;
+	rbu_data.packetsize = 0;
+}
+
+/*
+ img_update_free:
+ Frees the buffer allocated for storing BIOS image
+ Always called with lock held and returned with lock held
+*/
+static void img_update_free(void)
+{
+	if (!rbu_data.image_update_buffer)
+		return;
+	/*
+	   zero out this buffer before freeing it to get rid of any stale
+	   BIOS image copied in memory.
+	 */
+	memset(rbu_data.image_update_buffer, 0,
+	       rbu_data.image_update_buffer_size);
+	free_pages((unsigned long)rbu_data.image_update_buffer,
+		   rbu_data.image_update_order_number);
+	/* Re-initialize the rbu_data variables after a free */
+	rbu_data.image_update_buffer = NULL;
+	rbu_data.image_update_buffer_size = 0;
+	rbu_data.bios_image_size = 0;
+}
+
+/*
+ img_update_realloc:
+ This function allocates the contiguous pages to accommodate the requested
+ size of data. The memory address and size values are stored globally and
+ on every call to this function the new size is checked to see if more
+ data is required than the existing size. If true the previous memory is
+ freed and new allocation is done to accommodate the new size. If the 
+ incoming size is less then than the already allocated size, then that
+ memory is reused.
+ This function is called with lock held and returns with lock held.
+*/
+static int img_update_realloc(unsigned long size)
+{
+	unsigned char *image_update_buffer = NULL;
+	unsigned long rc;
+	int ordernum = 0;
+
+	/* 
+	   check if the buffer of sufficient size has been 
+	   already allocated 
+	 */
+	if (rbu_data.image_update_buffer_size >= size) {
+		/* check for corruption */
+		if ((size != 0) && (rbu_data.image_update_buffer == NULL)) {
+			printk(KERN_ERR "img_update_realloc: "
+			       "corruption check failed\n");
+			return -EINVAL;
+		}
+		/* 
+		   we have a valid pre-allocated buffer with 
+		   sufficient size 
+		 */
+		return 0;
+	}
+
+	/* free any previously allocated buffer */
+	img_update_free();
+
+	/*
+	   This has already been called as locked so we can now unlock
+	   and proceed to calling get_free_pages_limited as this function
+	   can sleep
+	 */
+	spin_unlock(&rbu_data.lock);
+
+	image_update_buffer = (unsigned char *)get_free_pages_limited(size,
+								      &ordernum,
+								      BIOS_SCAN_LIMIT);
+
+	/* acquire the spinlock again */
+	spin_lock(&rbu_data.lock);
+
+	if (image_update_buffer != NULL) {
+		rbu_data.image_update_buffer = image_update_buffer;
+		rbu_data.image_update_buffer_size = PAGE_SIZE << ordernum;
+		rbu_data.image_update_order_number = ordernum;
+		memset(rbu_data.image_update_buffer, 0,
+		       rbu_data.image_update_buffer_size);
+		rc = 0;
+	} else {
+		pr_debug("Not enough memory for image update:order"
+			 " number = %d,size = %ld\n", ordernum, size);
+		rc = -ENOMEM;
+	}
+
+	return rc;
+}				/* img_update_realloc */
+
+int context;
+
+void callbackfn_mono(const struct firmware *fw, void *context);
+void callbackfn_packet(const struct firmware *fw, void *context);
+void callbackfn_cancel(const struct firmware *fw, void *context);
+
+void callbackfn_cancel(const struct firmware *fw, void *context)
+{
+	int rc;
+	if (!fw) {
+		spin_lock(&rbu_data.lock);
+		packet_empty_list();
+		img_update_free();
+		spin_unlock(&rbu_data.lock);
+	}
+	if ((rc = request_firmware_nowait(THIS_MODULE,
+					  "dell_rbu_cancel", &rbu_device_cancel,
+					  &context, callbackfn_mono)))
+		printk(KERN_ERR "%s rbu_cancel request_firmware_nowait"
+		       " failed %d\n", __FUNCTION__, rc);
+
+}
+
+void callbackfn_packet(const struct firmware *fw, void *context)
+{
+	int rc;
+	if (fw) {
+		spin_lock(&rbu_data.lock);
+		if (!rbu_data.packetsize)
+			rbu_data.packetsize = fw->size;
+		else if (rbu_data.packetsize != fw->size) {
+			packet_empty_list();
+			rbu_data.packetsize = fw->size;
+		}
+		packetize_data(fw->data, fw->size);
+		spin_unlock(&rbu_data.lock);
+	}
+	if ((rc = request_firmware_nowait(THIS_MODULE,
+					  "dell_rbu_packet", &rbu_device_packet,
+					  &context, callbackfn_packet)))
+		printk(KERN_ERR "%s rbu_packet request_firmware_nowait"
+		       " failed %d\n", __FUNCTION__, rc);
+
+}
+
+void callbackfn_mono(const struct firmware *fw, void *context)
+{
+	int rc;
+	if (fw) {
+		spin_lock(&rbu_data.lock);
+		if (!img_update_realloc(fw->size))
+			memcpy(rbu_data.image_update_buffer,
+			       fw->data, fw->size);
+		spin_unlock(&rbu_data.lock);
+	}
+	if ((rc = request_firmware_nowait(THIS_MODULE,
+					  "dell_rbu_mono_", &rbu_device_mono,
+					  &context, callbackfn_mono)))
+		printk(KERN_ERR "%s rbu_mono request_firmware_nowait"
+		       " failed %d\n", __FUNCTION__, rc);
+
+}
+
+static int __init dcdrbu_init(void)
+{
+	int rc = 0;
+	spin_lock_init(&rbu_data.lock);
+
+	init_packet_head();
+
+	device_initialize(&rbu_device_mono);
+	device_initialize(&rbu_device_packet);
+	device_initialize(&rbu_device_cancel);
+
+	strncpy(rbu_device_mono.bus_id, "dell_rbu_mono", BUS_ID_SIZE);
+	strncpy(rbu_device_packet.bus_id, "dell_rbu_packet", BUS_ID_SIZE);
+	strncpy(rbu_device_cancel.bus_id, "dell_rbu_cancel", BUS_ID_SIZE);
+
+	kobject_set_name(&rbu_device_mono.kobj, "%s", rbu_device_mono.bus_id);
+	kobject_set_name(&rbu_device_packet.kobj, "%s",
+			 rbu_device_packet.bus_id);
+	kobject_set_name(&rbu_device_cancel.kobj, "%s",
+			 rbu_device_cancel.bus_id);
+
+	rc = request_firmware_nowait(THIS_MODULE,
+				     "dell_rbu_mono", &rbu_device_mono,
+				     &context, callbackfn_mono);
+	if (rc)
+		printk(KERN_ERR "%s rbu_mono request_firmware_nowait"
+		       " failed %d\n", __FUNCTION__, rc);
+
+	rc = request_firmware_nowait(THIS_MODULE,
+				     "dell_rbu_packet", &rbu_device_packet,
+				     &context, callbackfn_packet);
+	if (rc)
+		printk(KERN_ERR "%s rbu_packet request_firmware_nowait"
+		       " failed %d\n", __FUNCTION__, rc);
+
+	rc = request_firmware_nowait(THIS_MODULE,
+				     "dell_rbu_cancel", &rbu_device_cancel,
+				     &context, callbackfn_cancel);
+	if (rc)
+		printk(KERN_ERR "%s rbu_cancel request_firmware_nowait"
+		       " failed %d\n", __FUNCTION__, rc);
+
+	return rc;
+}
+
+static __exit void dcdrbu_exit(void)
+{
+	spin_lock(&rbu_data.lock);
+	packet_empty_list();
+	img_update_free();
+	spin_unlock(&rbu_data.lock);
+}
+
+module_exit(dcdrbu_exit);
+module_init(dcdrbu_init);
diff -uprN /usr/src/linux-2.6.11.11.orig/drivers/firmware/Kconfig /usr/src/linux-2.6.11.11/drivers/firmware/Kconfig
--- /usr/src/linux-2.6.11.11.orig/drivers/firmware/Kconfig	2005-06-14 21:00:10.000000000 -0500
+++ /usr/src/linux-2.6.11.11/drivers/firmware/Kconfig	2005-06-14 20:59:56.000000000 -0500
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
+	See <file:Documentation/dell_rbu.txt> for more details on the driver.
+
 endmenu
diff -uprN /usr/src/linux-2.6.11.11.orig/drivers/firmware/Makefile /usr/src/linux-2.6.11.11/drivers/firmware/Makefile
--- /usr/src/linux-2.6.11.11.orig/drivers/firmware/Makefile	2005-06-14 21:01:11.000000000 -0500
+++ /usr/src/linux-2.6.11.11/drivers/firmware/Makefile	2005-06-14 21:00:47.000000000 -0500
@@ -4,3 +4,4 @@
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_EFI_VARS)		+= efivars.o
 obj-$(CONFIG_EFI_PCDP)		+= pcdp.o
+obj-$(CONFIG_DELL_RBU)          += dell_rbu.o
