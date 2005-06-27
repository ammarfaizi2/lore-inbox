Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVF0WnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVF0WnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVF0WnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:43:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31899 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262049AbVF0Wmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:42:40 -0400
Message-ID: <42C0774C.4050006@us.ibm.com>
Date: Mon, 27 Jun 2005 17:01:48 -0500
From: Linda Xie <lxiep@us.ibm.com>
Reply-To: lxiep@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, zh-cn, zh
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Dave C Boutcher <sleddog@us.ibm.com>, Santiago Leon <santil@us.ibm.com>
Subject: [PATCH] IBM VSCSI Client: sending client info to  server
Content-Type: multipart/mixed;
 boundary="------------010100020007090506060202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010100020007090506060202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

The attached patch fixes the problem in IBM VSCSI Client  where the 
client doesn't send
the information which is expected by the server.

Comments are welcome.

If there are no objections, I would like to get this upstream.

Thanks,

Linda Xie
IBM Linux Technology Center

Signed-off-by: Linda Xie <lxie@us.ibm.com>


--------------010100020007090506060202
Content-Type: text/plain;
 name="mainline-IBMVSCSI-CLIENT-madinfo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mainline-IBMVSCSI-CLIENT-madinfo.patch"

diff -X ../dontdiff -purN linux-2.6.12-rc5-git10-orig/drivers/scsi/ibmvscsi/ibmvscsi.c madinfo/drivers/scsi/ibmvscsi/ibmvscsi.c
--- linux-2.6.12-rc5-git10-orig/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-06-20 19:00:43.000000000 -0500
+++ madinfo/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-06-24 16:36:16.000000000 -0500
@@ -87,7 +87,7 @@ static int max_channel = 3;
 static int init_timeout = 5;
 static int max_requests = 50;
 
-#define IBMVSCSI_VERSION "1.5.5"
+#define IBMVSCSI_VERSION "1.5.6"
 
 MODULE_DESCRIPTION("IBM Virtual SCSI");
 MODULE_AUTHOR("Dave Boutcher");
@@ -675,8 +675,6 @@ static void send_mad_adapter_info(struct
 	struct viosrp_adapter_info *req;
 	struct srp_event_struct *evt_struct;
 	
-	memset(&hostdata->madapter_info, 0x00, sizeof(hostdata->madapter_info));
-	
 	evt_struct = get_event_struct(&hostdata->pool);
 	if (!evt_struct) {
 		printk(KERN_ERR "ibmvscsi: couldn't allocate an event "
diff -X ../dontdiff -purN linux-2.6.12-rc5-git10-orig/drivers/scsi/ibmvscsi/rpa_vscsi.c madinfo/drivers/scsi/ibmvscsi/rpa_vscsi.c
--- linux-2.6.12-rc5-git10-orig/drivers/scsi/ibmvscsi/rpa_vscsi.c	2005-03-02 01:38:13.000000000 -0600
+++ madinfo/drivers/scsi/ibmvscsi/rpa_vscsi.c	2005-06-24 16:36:16.000000000 -0500
@@ -33,6 +33,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include "ibmvscsi.h"
+#include "srp.h"
+
+static char partition_name[97] = "UNKNOWN";
+static unsigned int partition_number = -1;
 
 /* ------------------------------------------------------------
  * Routines for managing the command/response queue
@@ -148,6 +152,48 @@ static void ibmvscsi_task(void *data)
 	}
 }
 
+static void gather_partition_info(void)
+{
+	struct device_node *rootdn;
+
+	char *ppartition_name;
+	unsigned int *p_number_ptr;
+
+	/* Retrieve information about this partition */
+	rootdn = find_path_device("/");
+	if (!rootdn) {
+		return;
+	}
+
+	ppartition_name =
+		get_property(rootdn, "ibm,partition-name", NULL);
+	if (ppartition_name)
+		strncpy(partition_name, ppartition_name,
+				sizeof(partition_name));
+	p_number_ptr =
+		(unsigned int *)get_property(rootdn, "ibm,partition-no",
+					     NULL);
+	if (p_number_ptr)
+		partition_number = *p_number_ptr;
+}
+
+static void set_adapter_info(struct ibmvscsi_host_data *hostdata)
+{
+	memset(&hostdata->madapter_info, 0x00,
+			sizeof(hostdata->madapter_info));
+
+	printk(KERN_INFO "rpa_vscsi: SPR_VERSION: %s\n", SRP_VERSION);
+	strcpy(hostdata->madapter_info.srp_version, SRP_VERSION);
+
+	strncpy(hostdata->madapter_info.partition_name, partition_name,
+			sizeof(hostdata->madapter_info.partition_name));
+
+	hostdata->madapter_info.partition_number = partition_number;
+
+	hostdata->madapter_info.mad_version = 1;
+	hostdata->madapter_info.os_type = 2;
+}
+
 /**
  * initialize_crq_queue: - Initializes and registers CRQ with hypervisor
  * @queue:	crq_queue to initialize and register
@@ -177,6 +223,9 @@ int ibmvscsi_init_crq_queue(struct crq_q
 	if (dma_mapping_error(queue->msg_token))
 		goto map_failed;
 
+	gather_partition_info();
+	set_adapter_info(hostdata);
+
 	rc = plpar_hcall_norets(H_REG_CRQ,
 				vdev->unit_address,
 				queue->msg_token, PAGE_SIZE);
@@ -246,6 +295,8 @@ void ibmvscsi_reset_crq_queue(struct crq
 	memset(queue->msgs, 0x00, PAGE_SIZE);
 	queue->cur = 0;
 
+	set_adapter_info(hostdata);
+
 	/* And re-open it again */
 	rc = plpar_hcall_norets(H_REG_CRQ,
 				vdev->unit_address,
diff -X ../dontdiff -purN linux-2.6.12-rc5-git10-orig/drivers/scsi/ibmvscsi/srp.h madinfo/drivers/scsi/ibmvscsi/srp.h
--- linux-2.6.12-rc5-git10-orig/drivers/scsi/ibmvscsi/srp.h	2005-03-02 01:38:33.000000000 -0600
+++ madinfo/drivers/scsi/ibmvscsi/srp.h	2005-06-24 16:36:16.000000000 -0500
@@ -28,6 +28,8 @@
 #ifndef SRP_H
 #define SRP_H
 
+#define SRP_VERSION "16.a"
+
 #define PACKED __attribute__((packed))
 
 enum srp_types {

--------------010100020007090506060202--

