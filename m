Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVIWTmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVIWTmd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVIWTmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:42:33 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:48425 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1751057AbVIWTmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:42:32 -0400
X-IronPort-AV: i="3.97,141,1125896400"; 
   d="scan'208"; a="298555817:sNHT32235864"
Date: Fri, 23 Sep 2005 14:40:14 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, abhay_salunke@dell.com
Cc: akpm@osdl.org
Subject: [RFC][patch 2.6.14-rc2] dell_rbu: Changing packet update mechanism
Message-ID: <20050923194009.GA2682@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore earlier patches as there was error submitting it! :-(
patch below is good...

In the current dell_rbu code ver 2.0 the packet update mechanism makes the user
app dump every individual packet in to the driver. 
This adds in efficiency as every packet update makes the 
/sys/class/firmware/dell_rbu/loading and data files to disappear and reappear 
again. Thus the user app needs to wait for the files to reappear to dump another
packet. This slows down the packet update tremendously in case of large number 
of packets. I am submitting a new patch for dell_rbu which will change the way 
we do packet updates; 

In the new method the user app will create a new single file which has already 
packetized the rbu image and all the packets are now staged in this file.

This driver also creates a new entry in 
/sys/devices/platform/dell_rbu/packet_size ; the user needs to echo the packet 
size here before downloading the packet file.

The user should do the following:
create one single file which has all the packets stacked together.
echo the packet size in to /sys/devices/platform/dell_rbu/packet_size.
echo 1 > /sys/class/firmware/dell_rbu/loading
cat the packetfile > /sys/class/firmware/dell_rbu/data
echo 0 > /sys/class/firmware/dell_rbu/loading
The driver takes the file which came through /sys/class/firmware/dell_rbu/data 
and takes chunks of paket_size data from it and place in contiguous memory. 

This makes packet update process very efficient and fast. As all the packet update 
happens in one single operation.
The user can still read back the downloaded file from 
/sys/devices/platform/dell_rbu/data.
This code has been tested.

Thanks,
Abhay
diff -uprN linux-2.6.14-rc2.orig/Documentation/dell_rbu.txt linux-2.6.14-rc2.new/Documentation/dell_rbu.txt
--- linux-2.6.14-rc2.orig/Documentation/dell_rbu.txt	2005-09-22 13:41:38.000000000 -0500
+++ linux-2.6.14-rc2.new/Documentation/dell_rbu.txt	2005-09-22 14:19:41.000000000 -0500
@@ -35,6 +35,7 @@ The driver load creates the following di
 /sys/class/firmware/dell_rbu/data
 /sys/devices/platform/dell_rbu/image_type
 /sys/devices/platform/dell_rbu/data
+/sys/devices/platform/dell_rbu/packet_size
 
 The driver supports two types of update mechanism; monolithic and packetized.
 These update mechanism depends upon the BIOS currently running on the system.
@@ -46,10 +47,28 @@ of contiguous memory and the BIOS image 
 By default the driver uses monolithic memory for the update type. This can be
 changed to packets during the driver load time by specifying the load
 parameter image_type=packet.  This can also be changed later as below
-echo packet > /sys/devices/platform/dell_rbu/image_type
-Also echoing either mono ,packet or init in to image_type will free up the
-memory allocated by the driver.
+echo packet > /sys/devices/platform/dell_rbu/image_type 
 
+In packet update mode the packet size has to be given before any packets can
+be downloaded. It is done as below
+echo XXXX > /sys/devices/platform/dell_rbu/packet_size 
+In the packet update mechanism, the user neesd to create a new file having
+packets of data arranged back to back. It can be done as follows
+The user creates packets header, gets the chunk of the BIOS image and 
+placs it next to the packetheader; now, the packetheader + BIOS image chunk
+added to geather should match the specified packet_size. This makes one
+packet, the user needs to create more such packets out of the entire BIOS
+image file and then arrange all these packets back to back in to one single 
+file.
+This file is then copied to /sys/class/firmware/dell_rbu/data.  
+Once this file gets to the driver, the driver extracts packet_size data from 
+the file and spreads it accross the physical memory in contiguous packet_sized
+space. 
+This method makes sure that all the packets get to the driver in a single operation.
+
+In monolithic update the user simply get the BIOS image (.hdr file) and copies 
+to the data file as is without any change to the BIOS image itself.
+ 
 Do the steps below to download the BIOS image.
 1) echo 1 > /sys/class/firmware/dell_rbu/loading
 2) cp bios_image.hdr /sys/class/firmware/dell_rbu/data
@@ -58,7 +77,10 @@ Do the steps below to download the BIOS 
 The /sys/class/firmware/dell_rbu/ entries will remain till the following is
 done.
 echo -1 > /sys/class/firmware/dell_rbu/loading.
-Until this step is completed the drivr cannot be unloaded.
+Until this step is completed the driver cannot be unloaded.
+Also echoing either mono ,packet or init in to image_type will free up the
+memory allocated by the driver.
+
 If an user by accident executes steps 1 and 3 above without executing step 2;
 it will make the /sys/class/firmware/dell_rbu/ entries to disappear.
 The entries can be recreated by doing the following
@@ -66,15 +88,11 @@ echo init > /sys/devices/platform/dell_r
 NOTE: echoing init in image_type does not change it original value.
 
 Also the driver provides /sys/devices/platform/dell_rbu/data readonly file to
-read back the image downloaded. This is useful in case of packet update
-mechanism where the above steps 1,2,3 will repeated for every packet.
-By reading the /sys/devices/platform/dell_rbu/data file all packet data
-downloaded can be verified in a single file.
-The packets are arranged in this file one after the other in a FIFO order.
+read back the image downloaded. 
 
 NOTE:
-This driver requires a patch for firmware_class.c which has the addition
-of request_firmware_nowait_nohotplug function to wortk
+This driver requires a patch for firmware_class.c which has the modified
+request_firmware_nowait function.
 Also after updating the BIOS image an user mdoe application neeeds to execute
 code which message the BIOS update request to the BIOS. So on the next reboot
 the BIOS knows about the new image downloaded and it updates it self.
diff -uprN linux-2.6.14-rc2.orig/drivers/firmware/dell_rbu.c linux-2.6.14-rc2.new/drivers/firmware/dell_rbu.c
--- linux-2.6.14-rc2.orig/drivers/firmware/dell_rbu.c	2005-09-22 13:42:09.000000000 -0500
+++ linux-2.6.14-rc2.new/drivers/firmware/dell_rbu.c	2005-09-22 13:48:02.000000000 -0500
@@ -50,7 +50,7 @@
 MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
 MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("2.0");
+MODULE_VERSION("3.0");
 
 #define BIOS_SCAN_LIMIT 0xffffffff
 #define MAX_IMAGE_LENGTH 16
@@ -62,15 +62,16 @@ static struct _rbu_data {
 	int dma_alloc;
 	spinlock_t lock;
 	unsigned long packet_read_count;
-	unsigned long packet_write_count;
 	unsigned long num_packets;
 	unsigned long packetsize;
+	unsigned long imagesize;
 	int entry_created;
 } rbu_data;
 
 static char image_type[MAX_IMAGE_LENGTH + 1] = "mono";
 module_param_string(image_type, image_type, sizeof (image_type), 0);
-MODULE_PARM_DESC(image_type, "BIOS image type. choose- mono or packet");
+MODULE_PARM_DESC(image_type,
+	"BIOS image type. choose- mono or packet or init");
 
 struct packet_data {
 	struct list_head list;
@@ -85,58 +86,18 @@ static struct platform_device *rbu_devic
 static int context;
 static dma_addr_t dell_rbu_dmaaddr;
 
-static void init_packet_head(void)
+static void
+init_packet_head(void)
 {
 	INIT_LIST_HEAD(&packet_data_head.list);
-	rbu_data.packet_write_count = 0;
 	rbu_data.packet_read_count = 0;
 	rbu_data.num_packets = 0;
 	rbu_data.packetsize = 0;
+	rbu_data.imagesize = 0;
 }
 
-static int fill_last_packet(void *data, size_t length)
-{
-	struct list_head *ptemp_list;
-	struct packet_data *packet = NULL;
-	int packet_count = 0;
-
-	pr_debug("fill_last_packet: entry \n");
-
-	if (!rbu_data.num_packets) {
-		pr_debug("fill_last_packet: num_packets=0\n");
-		return -ENOMEM;
-	}
-
-	packet_count = rbu_data.num_packets;
-
-	ptemp_list = (&packet_data_head.list)->prev;
-
-	packet = list_entry(ptemp_list, struct packet_data, list);
-
-	if ((rbu_data.packet_write_count + length) > rbu_data.packetsize) {
-		pr_debug("dell_rbu:%s: packet size data "
-			"overrun\n", __FUNCTION__);
-		return -EINVAL;
-	}
-
-	pr_debug("fill_last_packet : buffer = %p\n", packet->data);
-
-	memcpy((packet->data + rbu_data.packet_write_count), data, length);
-
-	if ((rbu_data.packet_write_count + length) == rbu_data.packetsize) {
-		/*
-		 * this was the last data chunk in the packet
-		 * so reinitialize the packet data counter to zero
-		 */
-		rbu_data.packet_write_count = 0;
-	} else
-		rbu_data.packet_write_count += length;
-
-	pr_debug("fill_last_packet: exit \n");
-	return 0;
-}
-
-static int create_packet(size_t length)
+static int
+create_packet(void *data, size_t length)
 {
 	struct packet_data *newpacket;
 	int ordernum = 0;
@@ -186,30 +147,60 @@ static int create_packet(size_t length)
 	INIT_LIST_HEAD(&newpacket->list);
 	list_add_tail(&newpacket->list, &packet_data_head.list);
 	/*
-	 * packets have fixed size
+	 * packets may not have fixed size
 	 */
-	newpacket->length = rbu_data.packetsize;
+	newpacket->length = length;
+
+	memcpy(newpacket->data, data, length);
 
 	pr_debug("create_packet: exit \n");
 
 	return 0;
 }
 
-static int packetize_data(void *data, size_t length)
+static int
+packetize_data(void *data, size_t length)
 {
 	int rc = 0;
+	int done = 0;
+	int packet_length;
+	u8 *temp;
+	u8 *end = (u8 *) data + length;
+
+	pr_debug("packetize_data: data length %d\n", length);
+
+	if (!rbu_data.packetsize) {
+		printk(KERN_WARNING
+			"dell_rbu: packetsize not specified\n");
+		return -EIO;
+	}
+
+	temp = (u8 *) data;
+
+	/* packetize the hunk */
+	while (!done) {
+		if ((temp + rbu_data.packetsize) < end)
+			packet_length = rbu_data.packetsize;
+		else {
+			/* this is the last packet */
+			packet_length = end - temp;
+			done = 1;
+		}
 
-	if (!rbu_data.packet_write_count) {
-		if ((rc = create_packet(length)))
+		if ((rc = create_packet(temp, packet_length)))
 			return rc;
+
+		pr_debug("%lu:%lu\n", temp, (end - temp));
+		temp += packet_length;
 	}
-	if ((rc = fill_last_packet(data, length)))
-		return rc;
+
+	rbu_data.imagesize = length;
 
 	return rc;
 }
 
-static int do_packet_read(char *data, struct list_head *ptemp_list,
+static int
+do_packet_read(char *data, struct list_head *ptemp_list,
 	int length, int bytes_read, int *list_read_count)
 {
 	void *ptemp_buf;
@@ -243,7 +234,8 @@ static int do_packet_read(char *data, st
 	return bytes_copied;
 }
 
-static int packet_read_list(char *data, size_t *pread_length)
+static int
+packet_read_list(char *data, size_t * pread_length)
 {
 	struct list_head *ptemp_list;
 	int temp_count = 0;
@@ -281,7 +273,8 @@ static int packet_read_list(char *data, 
 	return 0;
 }
 
-static void packet_empty_list(void)
+static void
+packet_empty_list(void)
 {
 	struct list_head *ptemp_list;
 	struct list_head *pnext_list;
@@ -303,17 +296,17 @@ static void packet_empty_list(void)
 			newpacket->ordernum);
 		kfree(newpacket);
 	}
-	rbu_data.packet_write_count = 0;
 	rbu_data.packet_read_count = 0;
 	rbu_data.num_packets = 0;
-	rbu_data.packetsize = 0;
+	rbu_data.imagesize = 0;
 }
 
 /*
  * img_update_free: Frees the buffer allocated for storing BIOS image
  * Always called with lock held and returned with lock held
  */
-static void img_update_free(void)
+static void
+img_update_free(void)
 {
 	if (!rbu_data.image_update_buffer)
 		return;
@@ -350,7 +343,8 @@ static void img_update_free(void)
  * already allocated size, then that memory is reused. This function is
  * called with lock held and returns with lock held.
  */
-static int img_update_realloc(unsigned long size)
+static int
+img_update_realloc(unsigned long size)
 {
 	unsigned char *image_update_buffer = NULL;
 	unsigned long rc;
@@ -419,13 +413,13 @@ static int img_update_realloc(unsigned l
 	return rc;
 }
 
-static ssize_t read_packet_data(char *buffer, loff_t pos, size_t count)
+static ssize_t
+read_packet_data(char *buffer, loff_t pos, size_t count)
 {
 	int retval;
 	size_t bytes_left;
 	size_t data_length;
 	char *ptempBuf = buffer;
-	unsigned long imagesize;
 
 	/* check to see if we have something to return */
 	if (rbu_data.num_packets == 0) {
@@ -434,22 +428,20 @@ static ssize_t read_packet_data(char *bu
 		goto read_rbu_data_exit;
 	}
 
-	imagesize = rbu_data.num_packets * rbu_data.packetsize;
-
-	if (pos > imagesize) {
+	if (pos > rbu_data.imagesize) {
 		retval = 0;
 		printk(KERN_WARNING "dell_rbu:read_packet_data: "
 			"data underrun\n");
 		goto read_rbu_data_exit;
 	}
 
-	bytes_left = imagesize - pos;
+	bytes_left = rbu_data.imagesize - pos;
 	data_length = min(bytes_left, count);
 
 	if ((retval = packet_read_list(ptempBuf, &data_length)) < 0)
 		goto read_rbu_data_exit;
 
-	if ((pos + count) > imagesize) {
+	if ((pos + count) > rbu_data.imagesize) {
 		rbu_data.packet_read_count = 0;
 		/* this was the last copy */
 		retval = bytes_left;
@@ -460,7 +452,8 @@ static ssize_t read_packet_data(char *bu
 	return retval;
 }
 
-static ssize_t read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
+static ssize_t
+read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
 {
 	unsigned char *ptemp = NULL;
 	size_t bytes_left = 0;
@@ -498,8 +491,8 @@ static ssize_t read_rbu_mono_data(char *
 	return ret_count;
 }
 
-static ssize_t read_rbu_data(struct kobject *kobj, char *buffer,
-			loff_t pos, size_t count)
+static ssize_t
+read_rbu_data(struct kobject *kobj, char *buffer, loff_t pos, size_t count)
 {
 	ssize_t ret_count = 0;
 
@@ -516,7 +509,8 @@ static ssize_t read_rbu_data(struct kobj
 	return ret_count;
 }
 
-static void callbackfn_rbu(const struct firmware *fw, void *context)
+static void
+callbackfn_rbu(const struct firmware *fw, void *context)
 {
 	int rc = 0;
 
@@ -531,13 +525,18 @@ static void callbackfn_rbu(const struct 
 			memcpy(rbu_data.image_update_buffer,
 				fw->data, fw->size);
 	} else if (!strcmp(image_type, "packet")) {
-		if (!rbu_data.packetsize)
-			rbu_data.packetsize = fw->size;
-		else if (rbu_data.packetsize != fw->size) {
+		/*
+		 * we need to free previous packets if a
+		 * hunk of packets needs to be downloaded
+		 */
+		packet_empty_list();
+		if (packetize_data(fw->data, fw->size))
+			/* Incase something goes wrong when we are 
+			 * in middle of a packetizing the data, we 
+			 * need to free up whatever packets might 
+			 * have been created before we quit.
+			 */
 			packet_empty_list();
-			rbu_data.packetsize = fw->size;
-		}
-		packetize_data(fw->data, fw->size);
 	} else
 		pr_debug("invalid image type specified.\n");
 	spin_unlock(&rbu_data.lock);
@@ -552,8 +551,9 @@ static void callbackfn_rbu(const struct 
 		rbu_data.entry_created = 1;
 }
 
-static ssize_t read_rbu_image_type(struct kobject *kobj, char *buffer,
-			loff_t pos, size_t count)
+static ssize_t
+read_rbu_image_type(struct kobject *kobj, char *buffer, loff_t pos,
+	size_t count)
 {
 	int size = 0;
 	if (!pos)
@@ -561,15 +561,16 @@ static ssize_t read_rbu_image_type(struc
 	return size;
 }
 
-static ssize_t write_rbu_image_type(struct kobject *kobj, char *buffer,
-			loff_t pos, size_t count)
+static ssize_t
+write_rbu_image_type(struct kobject *kobj, char *buffer, loff_t pos,
+	size_t count)
 {
 	int rc = count;
 	int req_firm_rc = 0;
 	int i;
 	spin_lock(&rbu_data.lock);
 	/*
-	 * Find the first newline or space
+	 * Find the first newline or space 
 	 */
 	for (i = 0; i < count; ++i)
 		if (buffer[i] == '\n' || buffer[i] == ' ') {
@@ -621,26 +622,53 @@ static ssize_t write_rbu_image_type(stru
 	return rc;
 }
 
+static ssize_t
+read_rbu_packet_size(struct kobject *kobj, char *buffer, loff_t pos,
+	size_t count)
+{
+	int size = 0;
+	if (!pos) {
+		spin_lock(&rbu_data.lock);
+		size = sprintf(buffer, "%lu\n", rbu_data.packetsize);
+		spin_unlock(&rbu_data.lock);
+	}
+	return size;
+}
+
+static ssize_t
+write_rbu_packet_size(struct kobject *kobj, char *buffer, loff_t pos,
+	size_t count)
+{
+	unsigned long temp;
+	spin_lock(&rbu_data.lock);
+	packet_empty_list();
+	sscanf(buffer, "%lu", &temp);
+	if (temp < 0xffffffff)
+		rbu_data.packetsize = temp;
+
+	spin_unlock(&rbu_data.lock);
+	return count;
+}
+
 static struct bin_attribute rbu_data_attr = {
-	.attr = {
-		.name = "data",
-		.owner = THIS_MODULE,
-		.mode = 0444,
-	},
+	.attr = {.name = "data",.owner = THIS_MODULE,.mode = 0444},
 	.read = read_rbu_data,
 };
 
 static struct bin_attribute rbu_image_type_attr = {
-	.attr = {
-		.name = "image_type",
-		.owner = THIS_MODULE,
-		.mode = 0644,
-	},
+	.attr = {.name = "image_type",.owner = THIS_MODULE,.mode = 0644},
 	.read = read_rbu_image_type,
 	.write = write_rbu_image_type,
 };
 
-static int __init dcdrbu_init(void)
+static struct bin_attribute rbu_packet_size_attr = {
+	.attr = {.name = "packet_size",.owner = THIS_MODULE,.mode = 0644},
+	.read = read_rbu_packet_size,
+	.write = write_rbu_packet_size,
+};
+
+static int __init
+dcdrbu_init(void)
 {
 	int rc = 0;
 	spin_lock_init(&rbu_data.lock);
@@ -657,6 +685,8 @@ static int __init dcdrbu_init(void)
 
 	sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_data_attr);
 	sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_image_type_attr);
+	sysfs_create_bin_file(&rbu_device->dev.kobj,
+		&rbu_packet_size_attr);
 
 	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
 		"dell_rbu", &rbu_device->dev, &context, callbackfn_rbu);
@@ -670,7 +700,8 @@ static int __init dcdrbu_init(void)
 
 }
 
-static __exit void dcdrbu_exit(void)
+static __exit void
+dcdrbu_exit(void)
 {
 	spin_lock(&rbu_data.lock);
 	packet_empty_list();
