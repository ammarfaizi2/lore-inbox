Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422738AbWAMRbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWAMRbl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWAMRbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:31:41 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:42035 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1422738AbWAMRbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:31:40 -0500
X-IronPort-AV: i="3.99,366,1131343200"; 
   d="scan'208"; a="26948329:sNHT17989178"
Date: Fri, 13 Jan 2006 11:31:18 -0600
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, abhay_salunke@dell.com,
       Michael_E_Brown@dell.com
Cc: akpm@osdl.org
Subject: [patch 2.6.15] dell_rbu: [Bug 5854] New: dell firmware loader makes load grow up to 1, and permanently
Message-ID: <20060113173118.GA31721@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the bug 
[Bug 5854] New: dell firmware loader makes load grow up to 1, and permanently 
stay there 
See http://bugzilla.kernel.org/show_bug.cgi?id=5854

Root cause:
The dell_rbu driver creates entries in /sys/class/firmware/dell_rbu/
by calling request_firmware_nowait (without hotplug ) this function inturn 
starts a kernel thread which creates the entries in 
/sys/class/firmware/dell_rbu/loading , data and the thread waits on the user 
action to return control back to the callback fucntion of dell_rbu. The 
thread calls wait_on_completion which puts it in a D state until the user action 
happens. If there is no user action happening the load average goes up as the thread
D state is taken in to account. 
Also after downloading the BIOS image the enrties go away momentarily but they 
are recreated from the callback function in dell_rbu. This causes the thread to get
recreated causing the load average to permenently stay around 1.

Fix:
The dell_rbu also creates the entry /sys/devices/platform/dell_rbu/image_type at 
driver load time. The image type by default is mono if required the user can echo 
packet to image_type to make the BIOS update mechanism using packets. 
Also by echoing init in to image_type the /sys/class/firmware/dell_rbu entries 
can be created.

The driver code was changed to not create /sys/class/firmware/dell_rbu entries during 
load time, and also to not create the above entries from the callback function. 
The entries are only created by echoing init to /sys/devices/platform/dell_rbu/image_type
The user now needs to create the entries to download the image monolithic or packet.
This fixes the issue since the kernel thread only is created when ever the user is ready 
to download the BIOS image; this minimizes the life span of the kernel thread and the load
average goes back to normal.


Signed off by Abhay Salunke <abhay_salunke@dell.com>

Thanks
Abhay Salunke
Software Engineer.
DELL Inc

diff -uprN linux-2.6.15.clean/drivers/firmware/dell_rbu.c linux-2.6.15.new/drivers/firmware/dell_rbu.c
--- linux-2.6.15.clean/drivers/firmware/dell_rbu.c	2006-01-02 21:21:10.000000000 -0600
+++ linux-2.6.15.new/drivers/firmware/dell_rbu.c	2006-01-13 11:52:08.000000000 -0600
@@ -49,7 +49,7 @@
 MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
 MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("3.1");
+MODULE_VERSION("3.2");
 
 #define BIOS_SCAN_LIMIT 0xffffffff
 #define MAX_IMAGE_LENGTH 16
@@ -308,7 +308,7 @@ static int packet_read_list(char *data, 
 
 	remaining_bytes = *pread_length;
 	bytes_read = rbu_data.packet_read_count;
-
+	
 	ptemp_list = (&packet_data_head.list)->next;
 	while (!list_empty(ptemp_list)) {
 		bytes_copied = do_packet_read(pdest, ptemp_list,
@@ -564,12 +564,10 @@ static ssize_t read_rbu_data(struct kobj
 
 static void callbackfn_rbu(const struct firmware *fw, void *context)
 {
-	int rc = 0;
+	rbu_data.entry_created = 0;
 
-	if (!fw || !fw->size) {
-		rbu_data.entry_created = 0;
+	if (!fw || !fw->size)
 		return;
-	}
 
 	spin_lock(&rbu_data.lock);
 	if (!strcmp(image_type, "mono")) {
@@ -592,15 +590,6 @@ static void callbackfn_rbu(const struct 
 	} else
 		pr_debug("invalid image type specified.\n");
 	spin_unlock(&rbu_data.lock);
-
-	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
-		"dell_rbu", &rbu_device->dev, &context, callbackfn_rbu);
-	if (rc)
-		printk(KERN_ERR
-			"dell_rbu:%s request_firmware_nowait failed"
-			" %d\n", __FUNCTION__, rc);
-	else
-		rbu_data.entry_created = 1;
 }
 
 static ssize_t read_rbu_image_type(struct kobject *kobj, char *buffer,
@@ -734,15 +723,8 @@ static int __init dcdrbu_init(void)
 	sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_image_type_attr);
 	sysfs_create_bin_file(&rbu_device->dev.kobj,
 		&rbu_packet_size_attr);
-
-	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
-		"dell_rbu", &rbu_device->dev, &context, callbackfn_rbu);
-	if (rc)
-		printk(KERN_ERR "dell_rbu:%s:request_firmware_nowait"
-			" failed %d\n", __FUNCTION__, rc);
-	else
-		rbu_data.entry_created = 1;
-
+	
+	rbu_data.entry_created = 0;
 	return rc;
 
 }
