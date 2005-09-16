Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbVIPRMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbVIPRMg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161174AbVIPRMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:12:36 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:179 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1161166AbVIPRMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:12:35 -0400
X-IronPort-AV: i="3.97,117,1125896400"; 
   d="scan'208"; a="295149797:sNHT33632688"
Date: Fri, 16 Sep 2005 17:10:00 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: abhay_salunke@dell.com
Subject: [patch 2.6.14-rc1] Enhancements and fixes for dell_rbu driver
Message-ID: <20050916221000.GA3454@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply this patch which fixes as bug and usability issues in the
dell_rbu driver and has some enhancements.

BUG fixes:
The driver used to allocate memory with spinlock held which has been fixed in
this patch.
The driver was printing the entire buffer when it received a invalid entry in
image_type. The fix is to only print a warning message and not the buffer.

Usability enhancements:
It is possible that due to user error the /sys/class/firmware/dell_rbu entries
migh be missing, this can happen if the user does the following
echo 1 > /sys/class/firmware/dell_rbu/loading
echo 0 > /sys/class/firmware/dell_rbu/loading
This will make the entries in /sys/class/firmware/ to disappear and the only
way get them back was bby unloading and loading the driver.
This patch makes the user recreate these entries by echoing init in to
image_type.

This patch has been tested with Libsmbios and Dell OpenManage.

Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>

Thanks
Abhay 

diff -uprN linux-2.6.14-rc1.orig/Documentation/dell_rbu.txt linux-2.6.14-rc1.new/Documentation/dell_rbu.txt
--- linux-2.6.14-rc1.orig/Documentation/dell_rbu.txt	2005-09-15 15:31:27.000000000 -0500
+++ linux-2.6.14-rc1.new/Documentation/dell_rbu.txt	2005-09-16 11:11:25.000000000 -0500
@@ -13,6 +13,8 @@ the BIOS on Dell servers (starting from 
 and notebooks (starting from those sold in 2005).
 Please go to  http://support.dell.com register and you can find info on
 OpenManage and Dell Update packages (DUP).
+Libsmbios can also be used to update BIOS on Dell systems go to
+http://linux.dell.com/libsmbios/ for details.
 
 Dell_RBU driver supports BIOS update using the monilothic image and packetized
 image methods. In case of moniolithic the driver allocates a contiguous chunk
@@ -22,8 +24,8 @@ would place each packet in contiguous ph
 maintains a link list of packets for reading them back.
 If the dell_rbu driver is unloaded all the allocated memory is freed.
 
-The rbu driver needs to have an application which will inform the BIOS to
-enable the update in the next system reboot.
+The rbu driver needs to have an application (as mentioned above)which will 
+inform the BIOS to enable the update in the next system reboot.
 
 The user should not unload the rbu driver after downloading the BIOS image
 or updating.
@@ -42,9 +44,11 @@ In case of packet mechanism the single m
 of contiguous memory and the BIOS image is scattered in these packets.
 
 By default the driver uses monolithic memory for the update type. This can be
-changed to contiguous during the driver load time by specifying the load
+changed to packets during the driver load time by specifying the load
 parameter image_type=packet.  This can also be changed later as below
 echo packet > /sys/devices/platform/dell_rbu/image_type
+Also echoing either mono ,packet or init in to image_type will free up the 
+memory allocated by the driver.
 
 Do the steps below to download the BIOS image.
 1) echo 1 > /sys/class/firmware/dell_rbu/loading
@@ -52,10 +56,14 @@ Do the steps below to download the BIOS 
 3) echo 0 > /sys/class/firmware/dell_rbu/loading
 
 The /sys/class/firmware/dell_rbu/ entries will remain till the following is
-done.
-echo -1 > /sys/class/firmware/dell_rbu/loading
-
+done. 
+echo -1 > /sys/class/firmware/dell_rbu/loading.
 Until this step is completed the drivr cannot be unloaded.
+If an user by accident executes steps 1 and 3 above without executing step 2; 
+it will make the /sys/class/firmware/dell_rbu/ entries to disappear. 
+The entries can be recreated by doing the following
+echo init > /sys/devices/platform/dell_rbu/image_type
+NOTE: echoing init in image_type does not change it original value.
 
 Also the driver provides /sys/devices/platform/dell_rbu/data readonly file to
 read back the image downloaded. This is useful in case of packet update
diff -uprN linux-2.6.14-rc1.orig/drivers/firmware/dell_rbu.c linux-2.6.14-rc1.new/drivers/firmware/dell_rbu.c
--- linux-2.6.14-rc1.orig/drivers/firmware/dell_rbu.c	2005-09-15 15:31:34.000000000 -0500
+++ linux-2.6.14-rc1.new/drivers/firmware/dell_rbu.c	2005-09-16 11:36:49.000000000 -0500
@@ -50,7 +50,7 @@
 MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
 MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("1.0");
+MODULE_VERSION("2.0");
 
 #define BIOS_SCAN_LIMIT 0xffffffff
 #define MAX_IMAGE_LENGTH 16
@@ -65,10 +65,11 @@ static struct _rbu_data {
 	unsigned long packet_write_count;
 	unsigned long num_packets;
 	unsigned long packetsize;
+	int entry_created;
 } rbu_data;
 
-static char image_type[MAX_IMAGE_LENGTH] = "mono";
-module_param_string(image_type, image_type, sizeof(image_type), 0);
+static char image_type[MAX_IMAGE_LENGTH + 1] = "mono";
+module_param_string(image_type, image_type, sizeof (image_type), 0);
 MODULE_PARM_DESC(image_type, "BIOS image type. choose- mono or packet");
 
 struct packet_data {
@@ -84,7 +85,8 @@ static struct platform_device *rbu_devic
 static int context;
 static dma_addr_t dell_rbu_dmaaddr;
 
-static void init_packet_head(void)
+static void
+init_packet_head(void)
 {
 	INIT_LIST_HEAD(&packet_data_head.list);
 	rbu_data.packet_write_count = 0;
@@ -93,7 +95,8 @@ static void init_packet_head(void)
 	rbu_data.packetsize = 0;
 }
 
-static int fill_last_packet(void *data, size_t length)
+static int
+fill_last_packet(void *data, size_t length)
 {
 	struct list_head *ptemp_list;
 	struct packet_data *packet = NULL;
@@ -114,7 +117,7 @@ static int fill_last_packet(void *data, 
 
 	if ((rbu_data.packet_write_count + length) > rbu_data.packetsize) {
 		pr_debug("dell_rbu:%s: packet size data "
-			 "overrun\n", __FUNCTION__);
+			"overrun\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
@@ -135,7 +138,8 @@ static int fill_last_packet(void *data, 
 	return 0;
 }
 
-static int create_packet(size_t length)
+static int
+create_packet(size_t length)
 {
 	struct packet_data *newpacket;
 	int ordernum = 0;
@@ -146,12 +150,14 @@ static int create_packet(size_t length)
 		pr_debug("create_packet: packetsize not specified\n");
 		return -EINVAL;
 	}
-
-	newpacket = kmalloc(sizeof(struct packet_data), GFP_KERNEL);
+	spin_unlock(&rbu_data.lock);
+	newpacket = kmalloc(sizeof (struct packet_data), GFP_KERNEL);
+	spin_lock(&rbu_data.lock);
+	
 	if (!newpacket) {
 		printk(KERN_WARNING
-		       "dell_rbu:%s: failed to allocate new "
-		       "packet\n", __FUNCTION__);
+			"dell_rbu:%s: failed to allocate new "
+			"packet\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 
@@ -160,15 +166,17 @@ static int create_packet(size_t length)
 	 * there is no upper limit on memory
 	 * address for packetized mechanism
 	 */
-	newpacket->data = (unsigned char *)__get_free_pages(GFP_KERNEL,
-							    ordernum);
+	spin_unlock(&rbu_data.lock);
+	newpacket->data = (unsigned char *) __get_free_pages(GFP_KERNEL,
+		ordernum);
+	spin_lock(&rbu_data.lock);
 
 	pr_debug("create_packet: newpacket %p\n", newpacket->data);
 
 	if (!newpacket->data) {
 		printk(KERN_WARNING
-		       "dell_rbu:%s: failed to allocate new "
-		       "packet\n", __FUNCTION__);
+			"dell_rbu:%s: failed to allocate new "
+			"packet\n", __FUNCTION__);
 		kfree(newpacket);
 		return -ENOMEM;
 	}
@@ -190,7 +198,8 @@ static int create_packet(size_t length)
 	return 0;
 }
 
-static int packetize_data(void *data, size_t length)
+static int
+packetize_data(void *data, size_t length)
 {
 	int rc = 0;
 
@@ -206,7 +215,7 @@ static int packetize_data(void *data, si
 
 static int
 do_packet_read(char *data, struct list_head *ptemp_list,
-	       int length, int bytes_read, int *list_read_count)
+	int length, int bytes_read, int *list_read_count)
 {
 	void *ptemp_buf;
 	struct packet_data *newpacket = NULL;
@@ -239,7 +248,8 @@ do_packet_read(char *data, struct list_h
 	return bytes_copied;
 }
 
-static int packet_read_list(char *data, size_t * pread_length)
+static int
+packet_read_list(char *data, size_t * pread_length)
 {
 	struct list_head *ptemp_list;
 	int temp_count = 0;
@@ -258,8 +268,7 @@ static int packet_read_list(char *data, 
 	ptemp_list = (&packet_data_head.list)->next;
 	while (!list_empty(ptemp_list)) {
 		bytes_copied = do_packet_read(pdest, ptemp_list,
-					      remaining_bytes, bytes_read,
-					      &temp_count);
+			remaining_bytes, bytes_read, &temp_count);
 		remaining_bytes -= bytes_copied;
 		bytes_read += bytes_copied;
 		pdest += bytes_copied;
@@ -278,7 +287,8 @@ static int packet_read_list(char *data, 
 	return 0;
 }
 
-static void packet_empty_list(void)
+static void
+packet_empty_list(void)
 {
 	struct list_head *ptemp_list;
 	struct list_head *pnext_list;
@@ -287,7 +297,7 @@ static void packet_empty_list(void)
 	ptemp_list = (&packet_data_head.list)->next;
 	while (!list_empty(ptemp_list)) {
 		newpacket =
-		    list_entry(ptemp_list, struct packet_data, list);
+			list_entry(ptemp_list, struct packet_data, list);
 		pnext_list = ptemp_list->next;
 		list_del(ptemp_list);
 		ptemp_list = pnext_list;
@@ -296,8 +306,8 @@ static void packet_empty_list(void)
 		 * to make sure there are no stale RBU packets left in memory
 		 */
 		memset(newpacket->data, 0, rbu_data.packetsize);
-		free_pages((unsigned long)newpacket->data,
-			   newpacket->ordernum);
+		free_pages((unsigned long) newpacket->data,
+			newpacket->ordernum);
 		kfree(newpacket);
 	}
 	rbu_data.packet_write_count = 0;
@@ -310,7 +320,8 @@ static void packet_empty_list(void)
  * img_update_free: Frees the buffer allocated for storing BIOS image
  * Always called with lock held and returned with lock held
  */
-static void img_update_free(void)
+static void
+img_update_free(void)
 {
 	if (!rbu_data.image_update_buffer)
 		return;
@@ -319,14 +330,13 @@ static void img_update_free(void)
 	 * BIOS image copied in memory.
 	 */
 	memset(rbu_data.image_update_buffer, 0,
-	       rbu_data.image_update_buffer_size);
+		rbu_data.image_update_buffer_size);
 	if (rbu_data.dma_alloc == 1)
 		dma_free_coherent(NULL, rbu_data.bios_image_size,
-				  rbu_data.image_update_buffer,
-				  dell_rbu_dmaaddr);
+			rbu_data.image_update_buffer, dell_rbu_dmaaddr);
 	else
-		free_pages((unsigned long)rbu_data.image_update_buffer,
-			   rbu_data.image_update_ordernum);
+		free_pages((unsigned long) rbu_data.image_update_buffer,
+			rbu_data.image_update_ordernum);
 
 	/*
 	 * Re-initialize the rbu_data variables after a free
@@ -348,7 +358,8 @@ static void img_update_free(void)
  * already allocated size, then that memory is reused. This function is
  * called with lock held and returns with lock held.
  */
-static int img_update_realloc(unsigned long size)
+static int
+img_update_realloc(unsigned long size)
 {
 	unsigned char *image_update_buffer = NULL;
 	unsigned long rc;
@@ -366,7 +377,7 @@ static int img_update_realloc(unsigned l
 		 */
 		if ((size != 0) && (rbu_data.image_update_buffer == NULL)) {
 			printk(KERN_ERR "dell_rbu:%s: corruption "
-			       "check failed\n", __FUNCTION__);
+				"check failed\n", __FUNCTION__);
 			return -EINVAL;
 		}
 		/*
@@ -385,17 +396,16 @@ static int img_update_realloc(unsigned l
 
 	ordernum = get_order(size);
 	image_update_buffer =
-	    (unsigned char *)__get_free_pages(GFP_KERNEL, ordernum);
+		(unsigned char *) __get_free_pages(GFP_KERNEL, ordernum);
 
 	img_buf_phys_addr =
-	    (unsigned long)virt_to_phys(image_update_buffer);
+		(unsigned long) virt_to_phys(image_update_buffer);
 
 	if (img_buf_phys_addr > BIOS_SCAN_LIMIT) {
-		free_pages((unsigned long)image_update_buffer, ordernum);
+		free_pages((unsigned long) image_update_buffer, ordernum);
 		ordernum = -1;
 		image_update_buffer = dma_alloc_coherent(NULL, size,
-							 &dell_rbu_dmaaddr,
-							 GFP_KERNEL);
+			&dell_rbu_dmaaddr, GFP_KERNEL);
 		dma_alloc = 1;
 	}
 
@@ -405,20 +415,21 @@ static int img_update_realloc(unsigned l
 		rbu_data.image_update_buffer = image_update_buffer;
 		rbu_data.image_update_buffer_size = size;
 		rbu_data.bios_image_size =
-		    rbu_data.image_update_buffer_size;
+			rbu_data.image_update_buffer_size;
 		rbu_data.image_update_ordernum = ordernum;
 		rbu_data.dma_alloc = dma_alloc;
 		rc = 0;
 	} else {
 		pr_debug("Not enough memory for image update:"
-			 "size = %ld\n", size);
+			"size = %ld\n", size);
 		rc = -ENOMEM;
 	}
 
 	return rc;
 }
 
-static ssize_t read_packet_data(char *buffer, loff_t pos, size_t count)
+static ssize_t
+read_packet_data(char *buffer, loff_t pos, size_t count)
 {
 	int retval;
 	size_t bytes_left;
@@ -438,7 +449,7 @@ static ssize_t read_packet_data(char *bu
 	if (pos > imagesize) {
 		retval = 0;
 		printk(KERN_WARNING "dell_rbu:read_packet_data: "
-		       "data underrun\n");
+			"data underrun\n");
 		goto read_rbu_data_exit;
 	}
 
@@ -459,7 +470,8 @@ static ssize_t read_packet_data(char *bu
 	return retval;
 }
 
-static ssize_t read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
+static ssize_t
+read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
 {
 	unsigned char *ptemp = NULL;
 	size_t bytes_left = 0;
@@ -468,11 +480,11 @@ static ssize_t read_rbu_mono_data(char *
 
 	/* check to see if we have something to return */
 	if ((rbu_data.image_update_buffer == NULL) ||
-	    (rbu_data.bios_image_size == 0)) {
+		(rbu_data.bios_image_size == 0)) {
 		pr_debug("read_rbu_data_mono: image_update_buffer %p ,"
-			 "bios_image_size %lu\n",
-			 rbu_data.image_update_buffer,
-			 rbu_data.bios_image_size);
+			"bios_image_size %lu\n",
+			rbu_data.image_update_buffer,
+			rbu_data.bios_image_size);
 		ret_count = -ENOMEM;
 		goto read_rbu_data_exit;
 	}
@@ -515,9 +527,46 @@ read_rbu_data(struct kobject *kobj, char
 	return ret_count;
 }
 
+static void
+callbackfn_rbu(const struct firmware *fw, void *context)
+{
+	int rc = 0;
+
+	if (!fw || !fw->size) {
+		rbu_data.entry_created = 0;
+		return;
+	}
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
+	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
+		"dell_rbu", &rbu_device->dev, &context, callbackfn_rbu);
+	if (rc)
+		printk(KERN_ERR
+			"dell_rbu:%s request_firmware_nowait failed"
+			" %d\n", __FUNCTION__, rc);
+	else
+		rbu_data.entry_created = 1;
+}
+
 static ssize_t
 read_rbu_image_type(struct kobject *kobj, char *buffer, loff_t pos,
-		    size_t count)
+	size_t count)
 {
 	int size = 0;
 	if (!pos)
@@ -527,25 +576,63 @@ read_rbu_image_type(struct kobject *kobj
 
 static ssize_t
 write_rbu_image_type(struct kobject *kobj, char *buffer, loff_t pos,
-		     size_t count)
+	size_t count)
 {
 	int rc = count;
+	int req_firm_rc = 0;
+	int i;
 	spin_lock(&rbu_data.lock);
+	/*
+	 * Find the first newline or space 
+	 */
+	for (i = 0; i < count; ++i)
+		if (buffer[i] == '\n' || buffer[i] == ' ') {
+			buffer[i] = '\0';
+			break;
+		}
+	if (i == count)
+		buffer[count] = '\0';
 
-	if (strlen(buffer) < MAX_IMAGE_LENGTH)
-		sscanf(buffer, "%s", image_type);
-	else
-		printk(KERN_WARNING "dell_rbu: image_type is invalid"
-		       "max chars = %d, \n incoming str--%s-- \n",
-		       MAX_IMAGE_LENGTH, buffer);
+	if (strstr(buffer, "mono"))
+		strcpy(image_type, "mono");
+	else if (strstr(buffer, "packet"))
+		strcpy(image_type, "packet");
+	else if (strstr(buffer, "init")) {
+		/*
+		 * If due to the user error the driver gets in a bad
+		 * state where even though it is loaded , the
+		 * /sys/class/firmware/dell_rbu entries are missing.
+		 * to cover this situation the user can recreate entries
+		 * by writing init to image_type.
+		 */
+		if (!rbu_data.entry_created) {
+			spin_unlock(&rbu_data.lock);
+			req_firm_rc = request_firmware_nowait(THIS_MODULE,
+				FW_ACTION_NOHOTPLUG, "dell_rbu",
+				&rbu_device->dev, &context,
+				callbackfn_rbu);
+			if (req_firm_rc) {
+				printk(KERN_ERR
+					"dell_rbu:%s request_firmware_nowait"
+					" failed %d\n", __FUNCTION__, rc);
+				rc = -EIO;
+			} else
+				rbu_data.entry_created = 1;
+
+			spin_lock(&rbu_data.lock);
+		}
+	} else {
+		printk(KERN_WARNING "dell_rbu: image_type is invalid\n");
+		spin_unlock(&rbu_data.lock);
+		return -EINVAL;
+	}
 
 	/* we must free all previous allocations */
 	packet_empty_list();
 	img_update_free();
-
 	spin_unlock(&rbu_data.lock);
+	
 	return rc;
-
 }
 
 static struct bin_attribute rbu_data_attr = {
@@ -559,51 +646,19 @@ static struct bin_attribute rbu_image_ty
 	.write = write_rbu_image_type,
 };
 
-static void callbackfn_rbu(const struct firmware *fw, void *context)
-{
-	int rc = 0;
-
-	if (!fw || !fw->size)
-		return;
-
-	spin_lock(&rbu_data.lock);
-	if (!strcmp(image_type, "mono")) {
-		if (!img_update_realloc(fw->size))
-			memcpy(rbu_data.image_update_buffer,
-			       fw->data, fw->size);
-	} else if (!strcmp(image_type, "packet")) {
-		if (!rbu_data.packetsize)
-			rbu_data.packetsize = fw->size;
-		else if (rbu_data.packetsize != fw->size) {
-			packet_empty_list();
-			rbu_data.packetsize = fw->size;
-		}
-		packetize_data(fw->data, fw->size);
-	} else
-		pr_debug("invalid image type specified.\n");
-	spin_unlock(&rbu_data.lock);
-
-	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
-				     "dell_rbu", &rbu_device->dev,
-				     &context, callbackfn_rbu);
-	if (rc)
-		printk(KERN_ERR
-		       "dell_rbu:%s request_firmware_nowait failed"
-		       " %d\n", __FUNCTION__, rc);
-}
-
-static int __init dcdrbu_init(void)
+static int __init
+dcdrbu_init(void)
 {
 	int rc = 0;
 	spin_lock_init(&rbu_data.lock);
 
 	init_packet_head();
 	rbu_device =
-	    platform_device_register_simple("dell_rbu", -1, NULL, 0);
+		platform_device_register_simple("dell_rbu", -1, NULL, 0);
 	if (!rbu_device) {
 		printk(KERN_ERR
-		       "dell_rbu:%s:platform_device_register_simple "
-		       "failed\n", __FUNCTION__);
+			"dell_rbu:%s:platform_device_register_simple "
+			"failed\n", __FUNCTION__);
 		return -EIO;
 	}
 
@@ -611,17 +666,19 @@ static int __init dcdrbu_init(void)
 	sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_image_type_attr);
 
 	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
-				     "dell_rbu", &rbu_device->dev,
-				     &context, callbackfn_rbu);
+		"dell_rbu", &rbu_device->dev, &context, callbackfn_rbu);
 	if (rc)
 		printk(KERN_ERR "dell_rbu:%s:request_firmware_nowait"
-		       " failed %d\n", __FUNCTION__, rc);
+			" failed %d\n", __FUNCTION__, rc);
+	else
+		rbu_data.entry_created = 1;
 
 	return rc;
 
 }
 
-static __exit void dcdrbu_exit(void)
+static __exit void
+dcdrbu_exit(void)
 {
 	spin_lock(&rbu_data.lock);
 	packet_empty_list();
