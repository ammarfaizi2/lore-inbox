Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVJaQIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVJaQIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVJaQIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:08:17 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:8298 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932333AbVJaQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:08:16 -0500
X-IronPort-AV: i="3.97,270,1125896400"; 
   d="scan'208"; a="333571087:sNHT28656824"
Date: Mon, 31 Oct 2005 10:04:33 -0600
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, abhay_salunke@dell.com,
       Michael_E_Brown@dell.com
Cc: akpm@osdl.org
Subject: [patch 2.6.14-rc5] dell_rbu: Adding BIOS memory floor support
Message-ID: <20051031160433.GA23670@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has the changes to support the memory floor fix done in Dell BIOS. 
The BIOS incase of packet update mechanism would not accept packet placed in 
memory below a cretain address. This address is by default 128K but can change. 
The driver now can accept the memory floor if the user chooses to make it 
different other than the default by giving it at the insmod time. The driver 
will try to allocate contiguous physical memory above the memory floor by 
allocating a set of packets till a valid memory allocation is made. All the 
allocates then are freed. This repeats for everty packet.

This patch was created by Michael E Brown and has been tested on 2.6.14-rc5

Signed off by Michael E Brown <Michael_E_Brown@Dell.com>
Signed off by Abhay Salunke <abhay_salunke@dell.com>

Thanks
Abhay Salunke
Software Engineer.
DELL Inc

Binary files linux-2.6.14-rc5/drivers/firmware/.dcdbas.c.swp and linux-2.6.14-rc5-MEB/drivers/firmware/.dcdbas.c.swp differ
diff -ruP linux-2.6.14-rc5/drivers/firmware/dell_rbu.c linux-2.6.14-rc5-MEB/drivers/firmware/dell_rbu.c
--- linux-2.6.14-rc5/drivers/firmware/dell_rbu.c	2005-10-27 11:15:40.000000000 -0500
+++ linux-2.6.14-rc5-MEB/drivers/firmware/dell_rbu.c	2005-10-27 18:09:12.000000000 -0500
@@ -50,7 +50,7 @@
 MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
 MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("3.0");
+MODULE_VERSION("3.1");
 
 #define BIOS_SCAN_LIMIT 0xffffffff
 #define MAX_IMAGE_LENGTH 16
@@ -73,6 +73,11 @@
 MODULE_PARM_DESC(image_type,
 	"BIOS image type. choose- mono or packet or init");
 
+static unsigned long allocation_floor = 0x100000;
+module_param(allocation_floor, ulong, 0644);
+MODULE_PARM_DESC(allocation_floor,
+    "Minimum address for allocations when using Packet mode");
+
 struct packet_data {
 	struct list_head list;
 	size_t length;
@@ -99,61 +104,122 @@
 {
 	struct packet_data *newpacket;
 	int ordernum = 0;
+	int retval = 0;
+	unsigned int packet_array_size = 0;
+	void **invalid_addr_packet_array = 0;
+	void *packet_data_temp_buf = 0;
+	unsigned int idx = 0;
 
 	pr_debug("create_packet: entry \n");
 
 	if (!rbu_data.packetsize) {
 		pr_debug("create_packet: packetsize not specified\n");
-		return -EINVAL;
+		retval = -EINVAL;
+		goto out_noalloc;
 	}
+
 	spin_unlock(&rbu_data.lock);
-	newpacket = kmalloc(sizeof (struct packet_data), GFP_KERNEL);
-	spin_lock(&rbu_data.lock);
+
+	newpacket = kzalloc(sizeof (struct packet_data), GFP_KERNEL);
 
 	if (!newpacket) {
 		printk(KERN_WARNING
 			"dell_rbu:%s: failed to allocate new "
 			"packet\n", __FUNCTION__);
-		return -ENOMEM;
+		retval = -ENOMEM;
+		spin_lock(&rbu_data.lock);
+		goto out_noalloc;
 	}
 
 	ordernum = get_order(length);
+
 	/*
-	 * there is no upper limit on memory
-	 * address for packetized mechanism
+	 * BIOS errata mean we cannot allocate packets below 1MB or they will
+	 * be overwritten by BIOS.
+	 *
+	 * array to temporarily hold packets
+	 * that are below the allocation floor
+	 *
+	 * NOTE: very simplistic because we only need the floor to be at 1MB
+	 *       due to BIOS errata. This shouldn't be used for higher floors
+	 *       or you will run out of mem trying to allocate the array.
 	 */
-	spin_unlock(&rbu_data.lock);
-	newpacket->data = (unsigned char *) __get_free_pages(GFP_KERNEL,
-		ordernum);
-	spin_lock(&rbu_data.lock);
-
-	pr_debug("create_packet: newpacket %p\n", newpacket->data);
+	packet_array_size = max(
+	       		(unsigned int)(allocation_floor / rbu_data.packetsize),
+			(unsigned int)1);
+	invalid_addr_packet_array = kzalloc(packet_array_size * sizeof(void*),
+						GFP_KERNEL);
 
-	if (!newpacket->data) {
+	if (!invalid_addr_packet_array) {
 		printk(KERN_WARNING
-			"dell_rbu:%s: failed to allocate new "
-			"packet\n", __FUNCTION__);
-		kfree(newpacket);
-		return -ENOMEM;
+			"dell_rbu:%s: failed to allocate "
+			"invalid_addr_packet_array \n",
+			__FUNCTION__);
+		retval = -ENOMEM;
+		spin_lock(&rbu_data.lock);
+		goto out_alloc_packet;
 	}
 
+	while (!packet_data_temp_buf) {
+		packet_data_temp_buf = (unsigned char *)
+			__get_free_pages(GFP_KERNEL, ordernum);
+		if (!packet_data_temp_buf) {
+			printk(KERN_WARNING
+				"dell_rbu:%s: failed to allocate new "
+				"packet\n", __FUNCTION__);
+			retval = -ENOMEM;
+			spin_lock(&rbu_data.lock);
+			goto out_alloc_packet_array;
+		}
+
+		if ((unsigned long)virt_to_phys(packet_data_temp_buf)
+				< allocation_floor) {
+			pr_debug("packet 0x%lx below floor at 0x%lx.\n",
+					(unsigned long)virt_to_phys(
+						packet_data_temp_buf),
+					allocation_floor);
+			invalid_addr_packet_array[idx++] = packet_data_temp_buf;
+			packet_data_temp_buf = 0;
+		}
+	}
+	spin_lock(&rbu_data.lock);
+
+	newpacket->data = packet_data_temp_buf;
+
+	pr_debug("create_packet: newpacket at physical addr %lx\n",
+		(unsigned long)virt_to_phys(newpacket->data));
+
+	/* packets may not have fixed size */
+	newpacket->length = length;
 	newpacket->ordernum = ordernum;
 	++rbu_data.num_packets;
-	/*
-	 * initialize the newly created packet headers
-	 */
+
+	/* initialize the newly created packet headers */
 	INIT_LIST_HEAD(&newpacket->list);
 	list_add_tail(&newpacket->list, &packet_data_head.list);
-	/*
-	 * packets may not have fixed size
-	 */
-	newpacket->length = length;
 
 	memcpy(newpacket->data, data, length);
 
 	pr_debug("create_packet: exit \n");
 
-	return 0;
+out_alloc_packet_array:
+	/* always free packet array */
+	for (;idx>0;idx--) {
+		pr_debug("freeing unused packet below floor 0x%lx.\n",
+			(unsigned long)virt_to_phys(
+				invalid_addr_packet_array[idx-1]));
+		free_pages((unsigned long)invalid_addr_packet_array[idx-1],
+			ordernum);
+	}
+	kfree(invalid_addr_packet_array);
+
+out_alloc_packet:
+	/* if error, free data */
+	if (retval)
+		kfree(newpacket);
+
+out_noalloc:
+	return retval;
 }
 
 static int packetize_data(void *data, size_t length)
@@ -693,3 +759,6 @@
 
 module_exit(dcdrbu_exit);
 module_init(dcdrbu_init);
+
+/* vim:noet:ts=8:sw=8
+*/
