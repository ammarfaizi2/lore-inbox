Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268908AbUH3SRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268908AbUH3SRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUH3SPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:15:38 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:39859 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S268436AbUH3SD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:03:27 -0400
Date: Mon, 30 Aug 2004 20:03:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: zfcp host adapater.
Message-ID: <20040830180356.GC6411@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: zfcp host adapater.

From: Andreas Herrmann <aherrman@de.ibm.com>

zfcp host adapater changes:
 - Add ability to enqueue other WKA ports besides the nameserver port.
 - Document and cleanup sg_list functions.
 - Add get_port_by_did/get_adapater_by_busid functions.
 - Improve documentation of some functions and structures.
 - Fix error handling for nameserver requests.
 - Correct size check in zfcp_sg_list_copy_to_user.
 - Correct parameter description for loglevel parameter.
 - Remove unsused code, types and definitions.
 - Add support for exchange_port_data command.
 - Add infrastructure to set timers for ELS and SCSI commands.
 - Avoid adapter shutdown after receiving FSF_SQ_ULP_PROGRAMMING_ERROR.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/scsi/zfcp_aux.c           |  315 ++++++++++++++++++++++-----------
 drivers/s390/scsi/zfcp_def.h           |  167 +++++++----------
 drivers/s390/scsi/zfcp_erp.c           |   73 ++++---
 drivers/s390/scsi/zfcp_ext.h           |   26 +-
 drivers/s390/scsi/zfcp_fsf.c           |  225 +++++++++++++----------
 drivers/s390/scsi/zfcp_fsf.h           |    7 
 drivers/s390/scsi/zfcp_scsi.c          |   29 ++-
 drivers/s390/scsi/zfcp_sysfs_adapter.c |    4 
 drivers/s390/scsi/zfcp_sysfs_port.c    |    6 
 9 files changed, 507 insertions(+), 345 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	Mon Aug 30 19:14:11 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c	Mon Aug 30 19:14:23 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_AUX_REVISION "$Revision: 1.121 $"
+#define ZFCP_AUX_REVISION "$Revision: 1.129 $"
 
 #include "zfcp_ext.h"
 
@@ -47,7 +47,7 @@
 /* miscellaneous */
 
 static inline int zfcp_sg_list_alloc(struct zfcp_sg_list *, size_t);
-static inline int zfcp_sg_list_free(struct zfcp_sg_list *);
+static inline void zfcp_sg_list_free(struct zfcp_sg_list *);
 static inline int zfcp_sg_list_copy_from_user(struct zfcp_sg_list *,
 					      void __user *, size_t);
 static inline int zfcp_sg_list_copy_to_user(void __user *,
@@ -95,7 +95,7 @@
 module_param(loglevel, uint, 0);
 MODULE_PARM_DESC(loglevel,
 		 "log levels, 8 nibbles: "
-		 "(unassigned) FC ERP QDIO CIO Config FSF SCSI Other, "
+		 "FC ERP QDIO CIO Config FSF SCSI Other, "
 		 "levels: 0=none 1=normal 2=devel 3=trace");
 
 #ifdef ZFCP_PRINT_FLAGS
@@ -257,24 +257,20 @@
 static void __init
 zfcp_init_device_configure(void)
 {
-	int found = 0;
 	struct zfcp_adapter *adapter;
 	struct zfcp_port *port;
 	struct zfcp_unit *unit;
 
 	down(&zfcp_data.config_sema);
 	read_lock_irq(&zfcp_data.config_lock);
-	list_for_each_entry(adapter, &zfcp_data.adapter_list_head, list)
-		if (strcmp(zfcp_data.init_busid,
-			   zfcp_get_busid_by_adapter(adapter)) == 0) {
-			zfcp_adapter_get(adapter);
-			found = 1;
-			break;
-		}
+	adapter = zfcp_get_adapter_by_busid(zfcp_data.init_busid);
+	if (adapter)
+		zfcp_adapter_get(adapter);
 	read_unlock_irq(&zfcp_data.config_lock);
-	if (!found)
+
+	if (adapter == NULL)
 		goto out_adapter;
-	port = zfcp_port_enqueue(adapter, zfcp_data.init_wwpn, 0);
+	port = zfcp_port_enqueue(adapter, zfcp_data.init_wwpn, 0, 0);
 	if (!port)
 		goto out_port;
 	unit = zfcp_unit_enqueue(port, zfcp_data.init_fcp_lun);
@@ -377,6 +373,7 @@
  *              -ENOMEM     - Insufficient memory
  *              -EFAULT     - User space memory I/O operation fault
  *              -EPERM      - Cannot create or queue FSF request or create SBALs
+ *              -ERESTARTSYS- Received signal (is mapped to EAGAIN by VFS)
  */
 static int
 zfcp_cfdc_dev_ioctl(struct inode *inode, struct file *file,
@@ -467,22 +464,17 @@
 		(sense_data.devno >> 16) & 0xFF,
 		(sense_data.devno & 0xFFFF));
 
-	retval = -ENXIO;
 	read_lock_irq(&zfcp_data.config_lock);
-	list_for_each_entry(adapter, &zfcp_data.adapter_list_head, list) {
-		if (strncmp(bus_id, zfcp_get_busid_by_adapter(adapter),
-		    BUS_ID_SIZE) == 0) {
-			zfcp_adapter_get(adapter);
-			retval = 0;
-			break;
-		}
-	}
+	adapter = zfcp_get_adapter_by_busid(bus_id);
+	if (adapter)
+		zfcp_adapter_get(adapter);
 	read_unlock_irq(&zfcp_data.config_lock);
 
 	kfree(bus_id);
 
-	if (retval != 0) {
+	if (adapter == NULL) {
 		ZFCP_LOG_INFO("invalid adapter\n");
+		retval = -ENXIO;
 		goto out;
 	}
 
@@ -565,13 +557,16 @@
 }
 
 
-/*
- * function:    zfcp_sg_list_alloc
- *
- * purpose:     Create a scatter-gather list of the specified size
+/**
+ * zfcp_sg_list_alloc - create a scatter-gather list of the specified size
+ * @sg_list: structure describing a scatter gather list
+ * @size: size of scatter-gather list
+ * Return: 0 on success, else -ENOMEM
  *
- * returns:     0       - Scatter gather list is created
- *              -ENOMEM - Insufficient memory (*list_ptr is then set to NULL)
+ * In sg_list->sg a pointer to the created scatter-gather list is returned,
+ * or NULL if we run out of memory. sg_list->count specifies the number of
+ * elements of the scatter-gather list. The maximum size of a single element
+ * in the scatter-gather list is PAGE_SIZE.
  */
 static inline int
 zfcp_sg_list_alloc(struct zfcp_sg_list *sg_list, size_t size)
@@ -579,6 +574,9 @@
 	struct scatterlist *sg;
 	unsigned int i;
 	int retval = 0;
+	void *address;
+
+	BUG_ON(sg_list == NULL);
 
 	sg_list->count = size >> PAGE_SHIFT;
 	if (size & ~PAGE_MASK)
@@ -594,7 +592,8 @@
 	for (i = 0, sg = sg_list->sg; i < sg_list->count; i++, sg++) {
 		sg->length = min(size, PAGE_SIZE);
 		sg->offset = 0;
-		sg->page = alloc_pages(GFP_KERNEL, 0);
+		address = (void *) get_zeroed_page(GFP_KERNEL);
+		zfcp_address_to_sg(address, sg);
 		if (sg->page == NULL) {
 			sg_list->count = i;
 			zfcp_sg_list_free(sg_list);
@@ -609,38 +608,57 @@
 }
 
 
-/*
- * function:    zfcp_sg_list_free
- *
- * purpose:     Destroy a scatter-gather list and release memory
+/**
+ * zfcp_sg_list_free - free memory of a scatter-gather list
+ * @sg_list: structure describing a scatter-gather list
  *
- * returns:     Always 0
+ * Memory for each element in the scatter-gather list is freed.
+ * Finally sg_list->sg is freed itself and sg_list->count is reset.
  */
-static inline int
+static inline void
 zfcp_sg_list_free(struct zfcp_sg_list *sg_list)
 {
 	struct scatterlist *sg;
 	unsigned int i;
-	int retval = 0;
 
 	BUG_ON(sg_list == NULL);
 
 	for (i = 0, sg = sg_list->sg; i < sg_list->count; i++, sg++)
 		__free_pages(sg->page, 0);
 
+	sg_list->count = 0;
 	kfree(sg_list->sg);
+}
 
-	return retval;
+/**
+ * zfcp_sg_size - determine size of a scatter-gather list
+ * @sg: array of (struct scatterlist)
+ * @sg_count: elements in array
+ * Return: size of entire scatter-gather list
+ */
+size_t
+zfcp_sg_size(struct scatterlist *sg, unsigned int sg_count)
+{
+	unsigned int i;
+	struct scatterlist *p;
+	size_t size;
+
+	size = 0;
+	for (i = 0, p = sg; i < sg_count; i++, p++) {
+		BUG_ON(p == NULL);
+		size += p->length;
+	}
+
+	return size;
 }
 
 
-/*
- * function:    zfcp_sg_list_copy_from_user
- *
- * purpose:     Copy data from user space memory to the scatter-gather list
- *
- * returns:     0       - The data has been copied from user
- *              -EFAULT - Memory I/O operation fault
+/**
+ * zfcp_sg_list_copy_from_user -copy data from user space to scatter-gather list
+ * @sg_list: structure describing a scatter-gather list
+ * @user_buffer: pointer to buffer in user space
+ * @size: number of bytes to be copied
+ * Return: 0 on success, -EFAULT if copy_from_user fails.
  */
 static inline int
 zfcp_sg_list_copy_from_user(struct zfcp_sg_list *sg_list,
@@ -652,10 +670,14 @@
 	void *zfcp_buffer;
 	int retval = 0;
 
+	BUG_ON(sg_list == NULL);
+
+	if (zfcp_sg_size(sg_list->sg, sg_list->count) < size)
+		return -EFAULT;
+
 	for (sg = sg_list->sg; size > 0; sg++) {
 		length = min((unsigned int)size, sg->length);
-		zfcp_buffer = (void*)
-			((page_to_pfn(sg->page) << PAGE_SHIFT) + sg->offset);
+		zfcp_buffer = zfcp_sg_to_address(sg);
 		if (copy_from_user(zfcp_buffer, user_buffer, length)) {
 			retval = -EFAULT;
 			goto out;
@@ -669,13 +691,12 @@
 }
 
 
-/*
- * function:    zfcp_sg_list_copy_to_user
- *
- * purpose:     Copy data from the scatter-gather list to user space memory
- *
- * returns:     0       - The data has been copied to user
- *              -EFAULT - Memory I/O operation fault
+/**
+ * zfcp_sg_list_copy_to_user - copy data from scatter-gather list to user space
+ * @user_buffer: pointer to buffer in user space
+ * @sg_list: structure describing a scatter-gather list
+ * @size: number of bytes to be copied
+ * Return: 0 on success, -EFAULT if copy_to_user fails
  */
 static inline int
 zfcp_sg_list_copy_to_user(void __user  *user_buffer,
@@ -687,10 +708,14 @@
 	void *zfcp_buffer;
 	int retval = 0;
 
+	BUG_ON(sg_list == NULL);
+
+	if (zfcp_sg_size(sg_list->sg, sg_list->count) < size)
+		return -EFAULT;
+
 	for (sg = sg_list->sg; size > 0; sg++) {
-		length = min((unsigned int)size, sg->length);
-		zfcp_buffer = (void*)
-			((page_to_pfn(sg->page) << PAGE_SHIFT) + sg->offset);
+		length = min((unsigned int) size, sg->length);
+		zfcp_buffer = zfcp_sg_to_address(sg);
 		if (copy_to_user(user_buffer, zfcp_buffer, length)) {
 			retval = -EFAULT;
 			goto out;
@@ -713,13 +738,12 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_CONFIG
 
 /**
- * zfcp_get_unit_by_lun - find unit in unit list of port by fcp lun
+ * zfcp_get_unit_by_lun - find unit in unit list of port by FCP LUN
  * @port: pointer to port to search for unit
- * @fcp_lun: lun to search for
- * Traverses list of all units of a port and returns pointer to a unit
- * if lun of a unit matches.
+ * @fcp_lun: FCP LUN to search for
+ * Traverse list of all units of a port and return pointer to a unit
+ * with the given FCP LUN.
  */
-
 struct zfcp_unit *
 zfcp_get_unit_by_lun(struct zfcp_port *port, fcp_lun_t fcp_lun)
 {
@@ -738,13 +762,12 @@
 }
 
 /**
- * zfcp_get_port_by_wwpn - find unit in unit list of port by fcp lun
+ * zfcp_get_port_by_wwpn - find port in port list of adapter by wwpn
  * @adapter: pointer to adapter to search for port
  * @wwpn: wwpn to search for
- * Traverses list of all ports of an adapter and returns a pointer to a port
- * if wwpn of a port matches.
+ * Traverse list of all ports of an adapter and return pointer to a port
+ * with the given wwpn.
  */
-
 struct zfcp_port *
 zfcp_get_port_by_wwpn(struct zfcp_adapter *adapter, wwn_t wwpn)
 {
@@ -753,6 +776,30 @@
 
 	list_for_each_entry(port, &adapter->port_list_head, list) {
 		if ((port->wwpn == wwpn) &&
+		    !(atomic_read(&port->status) &
+		      (ZFCP_STATUS_PORT_NO_WWPN | ZFCP_STATUS_COMMON_REMOVE))) {
+			found = 1;
+			break;
+		}
+	}
+	return found ? port : NULL;
+}
+
+/**
+ * zfcp_get_port_by_did - find port in port list of adapter by d_id
+ * @adapter: pointer to adapter to search for port
+ * @d_id: d_id to search for
+ * Traverse list of all ports of an adapter and return pointer to a port
+ * with the given d_id.
+ */
+struct zfcp_port *
+zfcp_get_port_by_did(struct zfcp_adapter *adapter, u32 d_id)
+{
+	struct zfcp_port *port;
+	int found = 0;
+
+	list_for_each_entry(port, &adapter->port_list_head, list) {
+		if ((port->d_id == d_id) &&
 		    !atomic_test_mask(ZFCP_STATUS_COMMON_REMOVE, &port->status))
 		{
 			found = 1;
@@ -762,14 +809,38 @@
 	return found ? port : NULL;
 }
 
-/*
- * Enqueues a logical unit at the end of the unit list associated with the 
- * specified port. Also sets up some unit internal structures.
+/**
+ * zfcp_get_adapter_by_busid - find adpater in adapter list by bus_id
+ * @bus_id: bus_id to search for
+ * Traverse list of all adapters and return pointer to an adapter
+ * with the given bus_id.
+ */
+struct zfcp_adapter *
+zfcp_get_adapter_by_busid(char *bus_id)
+{
+	struct zfcp_adapter *adapter;
+	int found = 0;
+
+	list_for_each_entry(adapter, &zfcp_data.adapter_list_head, list) {
+		if ((strncmp(bus_id, zfcp_get_busid_by_adapter(adapter),
+			     BUS_ID_SIZE) == 0) &&
+		    !atomic_test_mask(ZFCP_STATUS_COMMON_REMOVE,
+				      &adapter->status)){
+			found = 1;
+			break;
+		}
+	}
+	return found ? adapter : NULL;
+}
+
+/**
+ * zfcp_unit_enqueue - enqueue unit to unit list of a port.
+ * @port: pointer to port where unit is added
+ * @fcp_lun: FCP LUN of unit to be enqueued
+ * Return: pointer to enqueued unit on success, NULL on error
+ * Locks: config_sema must be held to serialize changes to the unit list
  *
- * returns:	pointer to unit with a usecount of 1 if a new unit was
- *              successfully enqueued
- *              NULL otherwise
- * locks:	config_sema must be held to serialise changes to the unit list
+ * Sets up some unit internal structures and creates sysfs entry.
  */
 struct zfcp_unit *
 zfcp_unit_enqueue(struct zfcp_port *port, fcp_lun_t fcp_lun)
@@ -1030,6 +1101,12 @@
 	debug_unregister(adapter->in_els_dbf);
 }
 
+void
+zfcp_dummy_release(struct device *dev)
+{
+	return;
+}
+
 /*
  * Enqueues an adapter at the end of the adapter list in the driver data.
  * All adapter internal structures are set up.
@@ -1121,6 +1198,14 @@
 	if (zfcp_sysfs_adapter_create_files(&ccw_device->dev))
 		goto sysfs_failed;
 
+	adapter->generic_services.parent = &adapter->ccw_device->dev;
+	adapter->generic_services.release = zfcp_dummy_release;
+	snprintf(adapter->generic_services.bus_id, BUS_ID_SIZE,
+		 "generic_services");
+
+	if (device_register(&adapter->generic_services))
+		goto generic_services_failed;
+
 	/* put allocated adapter at list tail */
 	write_lock_irq(&zfcp_data.config_lock);
 	atomic_clear_mask(ZFCP_STATUS_COMMON_REMOVE, &adapter->status);
@@ -1131,6 +1216,8 @@
 
 	goto out;
 
+ generic_services_failed:
+	zfcp_sysfs_adapter_remove_files(&adapter->ccw_device->dev);
  sysfs_failed:
 	dev_set_drvdata(&ccw_device->dev, NULL);
  failed_low_mem_buffers:
@@ -1161,6 +1248,7 @@
 	int retval = 0;
 	unsigned long flags;
 
+	device_unregister(&adapter->generic_services);
 	zfcp_sysfs_adapter_remove_files(&adapter->ccw_device->dev);
 	dev_set_drvdata(&adapter->ccw_device->dev, NULL);
 	/* sanity check: no pending FSF requests */
@@ -1203,15 +1291,22 @@
 	return;
 }
 
-/*
- * Enqueues a remote port to the port list. All port internal structures
- * are set up and the sysfs entry is also generated.
+/**
+ * zfcp_port_enqueue - enqueue port to port list of adapter
+ * @adapter: adapter where remote port is added
+ * @wwpn: WWPN of the remote port to be enqueued
+ * @status: initial status for the port
+ * @d_id: destination id of the remote port to be enqueued
+ * Return: pointer to enqueued port on success, NULL on error
+ * Locks: config_sema must be held to serialize changes to the port list
  *
- * returns:     pointer to port or NULL
- * locks:       config_sema must be held to serialise changes to the port list
+ * All port internal structures are set up and the sysfs entry is generated.
+ * d_id is used to enqueue ports with a well known address like the Directory
+ * Service for nameserver lookup.
  */
 struct zfcp_port *
-zfcp_port_enqueue(struct zfcp_adapter *adapter, wwn_t wwpn, u32 status)
+zfcp_port_enqueue(struct zfcp_adapter *adapter, wwn_t wwpn, u32 status,
+		  u32 d_id)
 {
 	struct zfcp_port *port, *tmp_port;
 	int check_wwpn;
@@ -1251,12 +1346,39 @@
 	atomic_set_mask(status, &port->status);
 
 	/* setup for sysfs registration */
-	if (status & ZFCP_STATUS_PORT_NAMESERVER)
-		snprintf(port->sysfs_device.bus_id, BUS_ID_SIZE, "nameserver");
-	else
+	if (status & ZFCP_STATUS_PORT_WKA) {
+		switch (d_id) {
+		case ZFCP_DID_DIRECTORY_SERVICE:
+			snprintf(port->sysfs_device.bus_id, BUS_ID_SIZE,
+				 "directory");
+			break;
+		case ZFCP_DID_MANAGEMENT_SERVICE:
+			snprintf(port->sysfs_device.bus_id, BUS_ID_SIZE,
+				 "management");
+			break;
+		case ZFCP_DID_KEY_DISTRIBUTION_SERVICE:
+			snprintf(port->sysfs_device.bus_id, BUS_ID_SIZE,
+				 "key_distribution");
+			break;
+		case ZFCP_DID_ALIAS_SERVICE:
+			snprintf(port->sysfs_device.bus_id, BUS_ID_SIZE,
+				 "alias");
+			break;
+		case ZFCP_DID_TIME_SERVICE:
+			snprintf(port->sysfs_device.bus_id, BUS_ID_SIZE,
+				 "time");
+			break;
+		default:
+			kfree(port);
+			return NULL;
+		}
+		port->d_id = d_id;
+		port->sysfs_device.parent = &adapter->generic_services;
+	} else {
 		snprintf(port->sysfs_device.bus_id,
 			 BUS_ID_SIZE, "0x%016llx", wwpn);
 	port->sysfs_device.parent = &adapter->ccw_device->dev;
+	}
 	port->sysfs_device.release = zfcp_sysfs_port_release;
 	dev_set_drvdata(&port->sysfs_device, port);
 
@@ -1295,9 +1417,12 @@
 		list_add_tail(&port->list, &adapter->port_list_head);
 	atomic_clear_mask(ZFCP_STATUS_COMMON_REMOVE, &port->status);
 	atomic_set_mask(ZFCP_STATUS_COMMON_RUNNING, &port->status);
+	if (d_id == ZFCP_DID_DIRECTORY_SERVICE)
+		if (!adapter->nameserver_port)
+			adapter->nameserver_port = port;
+	adapter->ports++;
 	write_unlock_irq(&zfcp_data.config_lock);
 
-	adapter->ports++;
 	zfcp_adapter_get(adapter);
 
 	return port;
@@ -1309,8 +1434,8 @@
 	zfcp_port_wait(port);
 	write_lock_irq(&zfcp_data.config_lock);
 	list_del(&port->list);
-	write_unlock_irq(&zfcp_data.config_lock);
 	port->adapter->ports--;
+	write_unlock_irq(&zfcp_data.config_lock);
 	zfcp_adapter_put(port->adapter);
 	zfcp_sysfs_port_remove_files(&port->sysfs_device,
 				     atomic_read(&port->status));
@@ -1323,17 +1448,14 @@
 {
 	struct zfcp_port *port;
 
-	/* generate port structure */
-	port = zfcp_port_enqueue(adapter, 0, ZFCP_STATUS_PORT_NAMESERVER);
+	port = zfcp_port_enqueue(adapter, 0, ZFCP_STATUS_PORT_WKA,
+				 ZFCP_DID_DIRECTORY_SERVICE);
 	if (!port) {
 		ZFCP_LOG_INFO("error: enqueue of nameserver port for "
 			      "adapter %s failed\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		return -ENXIO;
 	}
-	/* set special D_ID */
-	port->d_id = ZFCP_DID_NAMESERVER;
-	adapter->nameserver_port = port;
 	zfcp_port_put(port);
 
 	return 0;
@@ -1397,7 +1519,7 @@
 		read_lock_irqsave(&zfcp_data.config_lock, flags);
 		list_for_each_entry(port, &adapter->port_list_head, list) {
 			if (atomic_test_mask
-			    (ZFCP_STATUS_PORT_NAMESERVER, &port->status))
+			    (ZFCP_STATUS_PORT_WKA, &port->status))
 				continue;
 			/* Do we know this port? If not skip it. */
 			if (!atomic_test_mask
@@ -1654,7 +1776,7 @@
 	ct_iu_req = zfcp_sg_to_address(ct->req);
 	ct_iu_resp = zfcp_sg_to_address(ct->resp);
 
-	if (zfcp_check_ct_response(&ct_iu_resp->header)) {
+	if ((ct->status != 0) || zfcp_check_ct_response(&ct_iu_resp->header)) {
 		/* FIXME: do we need some specific erp entry points */
 		atomic_set_mask(ZFCP_STATUS_PORT_INVALID_WWPN, &port->status);
 		goto failed;
@@ -1665,7 +1787,7 @@
 				"lookup does not match expected wwpn 0x%016Lx "
 				"for adapter %s\n", ct_iu_req->wwpn, port->wwpn,
 				zfcp_get_busid_by_port(port));
-		goto failed;
+		goto mismatch;
 	}
 
 	/* looks like a valid d_id */
@@ -1675,16 +1797,17 @@
 		       zfcp_get_busid_by_port(port), port->wwpn, port->d_id);
 	goto out;
 
- failed:
-	ZFCP_LOG_NORMAL("warning: failed gid_pn nameserver request for wwpn "
-			"0x%016Lx for adapter %s\n",
-			port->wwpn, zfcp_get_busid_by_port(port));
+ mismatch:
 	ZFCP_LOG_DEBUG("CT IUs do not match:\n");
 	ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG, (char *) ct_iu_req,
 		      sizeof(struct ct_iu_gid_pn_req));
 	ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG, (char *) ct_iu_resp,
 		      sizeof(struct ct_iu_gid_pn_resp));
 
+ failed:
+	ZFCP_LOG_NORMAL("warning: failed gid_pn nameserver request for wwpn "
+			"0x%016Lx for adapter %s\n",
+			port->wwpn, zfcp_get_busid_by_port(port));
  out:
         zfcp_gid_pn_buffers_free(gid_pn);
 	return;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Mon Aug 30 19:14:11 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Mon Aug 30 19:14:23 2004
@@ -33,7 +33,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.83 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.91 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -43,6 +43,7 @@
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
+#include <linux/timer.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_cmnd.h>
@@ -72,12 +73,22 @@
 /* zfcp version number, it consists of major, minor, and patch-level number */
 #define ZFCP_VERSION		"4.1.3"
 
+/**
+ * zfcp_sg_to_address - determine kernel address from struct scatterlist
+ * @list: struct scatterlist
+ * Return: kernel address
+ */
 static inline void *
 zfcp_sg_to_address(struct scatterlist *list)
 {
 	return (void *) (page_address(list->page) + list->offset);
 }
 
+/**
+ * zfcp_address_to_sg - set up struct scatterlist from kernel address
+ * @address: kernel address
+ * @list: struct scatterlist
+ */
 static inline void
 zfcp_address_to_sg(void *address, struct scatterlist *list)
 {
@@ -146,6 +157,9 @@
 #define ZFCP_EXCHANGE_CONFIG_DATA_RETRIES	6
 #define ZFCP_EXCHANGE_CONFIG_DATA_SLEEP		50
 
+/* timeout value for "default timer" for fsf requests */
+#define ZFCP_FSF_REQUEST_TIMEOUT (60*HZ);
+
 /*************** FIBRE CHANNEL PROTOCOL SPECIFIC DEFINES ********************/
 
 typedef unsigned long long wwn_t;
@@ -158,7 +172,6 @@
 
 /* timeout for name-server lookup (in seconds) */
 #define ZFCP_NS_GID_PN_TIMEOUT		10
-#define ZFCP_NS_GA_NXT_TIMEOUT		120
 
 /* largest SCSI command we can process */
 /* FCP-2 (FCP_CMND IU) allows up to (255-3+16) */
@@ -276,26 +289,12 @@
 #define R_A_TOV				10 /* seconds */
 #define ZFCP_ELS_TIMEOUT		(2 * R_A_TOV)
 
-#define ZFCP_LS_RJT			0x01
-#define ZFCP_LS_ACC			0x02
 #define ZFCP_LS_RTV			0x0E
 #define ZFCP_LS_RLS			0x0F
 #define ZFCP_LS_PDISC			0x50
 #define ZFCP_LS_ADISC			0x52
-#define ZFCP_LS_RSCN			0x61
-#define ZFCP_LS_RNID			0x78
-#define ZFCP_LS_RLIR			0x7A
 #define ZFCP_LS_RTV_E_D_TOV_FLAG	0x04000000
 
-/* LS_ACC Reason Codes */
-#define ZFCP_LS_RJT_INVALID_COMMAND_CODE	0x01
-#define ZFCP_LS_RJT_LOGICAL_ERROR		0x03
-#define ZFCP_LS_RJT_LOGICAL_BUSY		0x05
-#define ZFCP_LS_RJT_PROTOCOL_ERROR		0x07
-#define ZFCP_LS_RJT_UNABLE_TO_PERFORM		0x09
-#define ZFCP_LS_RJT_COMMAND_NOT_SUPPORTED	0x0B
-#define ZFCP_LS_RJT_VENDOR_UNIQUE_ERROR		0xFF
-
 struct zfcp_ls_rjt_par {
 	u8 action;
  	u8 reason_code;
@@ -381,46 +380,6 @@
 	fc_id_t		nport_id;
 } __attribute__ ((packed));
 
-struct zfcp_ls_rnid {
-	u8		code;
-	u8		field[3];
-	u8		node_id_format;
-	u8		reserved[3];
-} __attribute__((packed));
-
-/* common identification data */
-struct zfcp_ls_rnid_common_id {
-	u64		n_port_name;
-	u64		node_name;
-} __attribute__((packed));
-
-/* general topology specific identification data */
-struct zfcp_ls_rnid_general_topology_id {
-	u8		vendor_unique[16];
-	u32		associated_type;
-	u32		physical_port_number;
-	u32		nr_attached_nodes;
-	u8		node_management;
-	u8		ip_version;
-	u16		port_number;
-	u8		ip_address[16];
-	u8		reserved[2];
-	u16		vendor_specific;
-} __attribute__((packed));
-
-struct zfcp_ls_rnid_acc {
-	u8		code;
-	u8		field[3];
-	u8		node_id_format;
-	u8		common_id_length;
-	u8		reserved;
-	u8		specific_id_length;
-	struct zfcp_ls_rnid_common_id
-			common_id;
-	struct zfcp_ls_rnid_general_topology_id
-			specific_id;
-} __attribute__((packed));
-
 struct zfcp_rc_entry {
 	u8 code;
 	const char *description;
@@ -533,23 +492,29 @@
 	       __LINE__ , ##args);
 
 #define ZFCP_LOG(level, fmt, args...) \
+do { \
 	if (ZFCP_LOG_CHECK(level)) \
-		_ZFCP_LOG(fmt , ##args)
+		_ZFCP_LOG(fmt, ##args); \
+} while (0)
 	
 #if ZFCP_LOG_LEVEL_LIMIT < ZFCP_LOG_LEVEL_NORMAL
 # define ZFCP_LOG_NORMAL(fmt, args...)
 #else
 # define ZFCP_LOG_NORMAL(fmt, args...) \
+do { \
 	if (ZFCP_LOG_CHECK(ZFCP_LOG_LEVEL_NORMAL)) \
-		printk(KERN_ERR ZFCP_NAME": " fmt , ##args);
+		printk(KERN_ERR ZFCP_NAME": " fmt, ##args); \
+} while (0)
 #endif
 
 #if ZFCP_LOG_LEVEL_LIMIT < ZFCP_LOG_LEVEL_INFO
 # define ZFCP_LOG_INFO(fmt, args...)
 #else
 # define ZFCP_LOG_INFO(fmt, args...) \
+do { \
 	if (ZFCP_LOG_CHECK(ZFCP_LOG_LEVEL_INFO)) \
-		printk(KERN_ERR ZFCP_NAME": " fmt , ##args);
+		printk(KERN_ERR ZFCP_NAME": " fmt, ##args); \
+} while (0)
 #endif
 
 #if ZFCP_LOG_LEVEL_LIMIT < ZFCP_LOG_LEVEL_DEBUG
@@ -571,8 +536,10 @@
 #else
 extern u32 flags_dump;
 # define ZFCP_LOG_FLAGS(level, fmt, args...) \
+do { \
 	if (level <= flags_dump) \
-		_ZFCP_LOG(fmt , ##args)
+		_ZFCP_LOG(fmt, ##args); \
+} while (0)
 #endif
 
 /*************** ADAPTER/PORT/UNIT AND FSF_REQ STATUS FLAGS ******************/
@@ -609,7 +576,12 @@
 		 ZFCP_STATUS_ADAPTER_REGISTERED)
 
 
-#define ZFCP_DID_NAMESERVER			0xFFFFFC
+/* FC-PH/FC-GS well-known address identifiers for generic services */
+#define ZFCP_DID_MANAGEMENT_SERVICE		0xFFFFFA
+#define ZFCP_DID_TIME_SERVICE			0xFFFFFB
+#define ZFCP_DID_DIRECTORY_SERVICE		0xFFFFFC
+#define ZFCP_DID_ALIAS_SERVICE			0xFFFFF8
+#define ZFCP_DID_KEY_DISTRIBUTION_SERVICE	0xFFFFF7
 
 /* remote port status */
 #define ZFCP_STATUS_PORT_PHYS_OPEN		0x00000001
@@ -619,7 +591,8 @@
 #define ZFCP_STATUS_PORT_NO_SCSI_ID		0x00000010
 #define ZFCP_STATUS_PORT_INVALID_WWPN		0x00000020
 
-#define ZFCP_STATUS_PORT_NAMESERVER \
+/* for ports with well known addresses */
+#define ZFCP_STATUS_PORT_WKA \
 		(ZFCP_STATUS_PORT_NO_WWPN | \
 		 ZFCP_STATUS_PORT_NO_SCSI_ID)
 
@@ -792,43 +765,29 @@
 	wwn_t wwpn;
 } __attribute__ ((packed));
 
-/* nameserver request CT_IU -- for requests where
- * a port identifier is required */
-struct ct_iu_ga_nxt_req {
-	struct ct_hdr header;
-	fc_id_t d_id;
-} __attribute__ ((packed));
-
 /* FS_ACC IU and data unit for GID_PN nameserver request */
 struct ct_iu_gid_pn_resp {
 	struct ct_hdr header;
 	fc_id_t d_id;
 } __attribute__ ((packed));
 
-/* FS_ACC IU and data unit for GA_NXT nameserver request */
-struct ct_iu_ga_nxt_resp {
-	struct ct_hdr header;
-        u8 port_type;
-        u8 port_id[3];
-        u64 port_wwn;
-        u8 port_symbolic_name_length;
-        u8 port_symbolic_name[255];
-        u64 node_wwn;
-        u8 node_symbolic_name_length;
-        u8 node_symbolic_name[255];
-        u64 initial_process_associator;
-        u8 node_ip[16];
-        u32 cos;
-        u8 fc4_types[32];
-        u8 port_ip[16];
-        u64 fabric_wwn;
-        u8 reserved;
-        u8 hard_address[3];
-} __attribute__ ((packed));
-
 typedef void (*zfcp_send_ct_handler_t)(unsigned long);
 
-/* used to pass parameters to zfcp_send_ct() */
+/**
+ * struct zfcp_send_ct - used to pass parameters to function zfcp_fsf_send_ct
+ * @port: port where the request is sent to
+ * @req: scatter-gather list for request
+ * @resp: scatter-gather list for response
+ * @req_count: number of elements in request scatter-gather list
+ * @resp_count: number of elements in response scatter-gather list
+ * @handler: handler function (called for response to the request)
+ * @handler_data: data passed to handler function
+ * @pool: pointer to memory pool for ct request structure
+ * @timeout: FSF timeout for this request
+ * @timer: timer (e.g. for request initiated by erp)
+ * @completion: completion for synchronization purposes
+ * @status: used to pass error status to calling function
+ */
 struct zfcp_send_ct {
 	struct zfcp_port *port;
 	struct scatterlist *req;
@@ -837,7 +796,7 @@
 	unsigned int resp_count;
 	zfcp_send_ct_handler_t handler;
 	unsigned long handler_data;
-	mempool_t *pool;		/* mempool for ct not for fsf_req */
+	mempool_t *pool;
 	int timeout;
 	struct timer_list *timer;
 	struct completion *completion;
@@ -856,8 +815,20 @@
 
 typedef void (*zfcp_send_els_handler_t)(unsigned long);
 
-/* used to pass parameters to zfcp_send_els() */
-/* ToDo merge send_ct() and send_els() and corresponding structs */
+/**
+ * struct zfcp_send_els - used to pass parameters to function zfcp_fsf_send_els
+ * @port: port where the request is sent to
+ * @req: scatter-gather list for request
+ * @resp: scatter-gather list for response
+ * @req_count: number of elements in request scatter-gather list
+ * @resp_count: number of elements in response scatter-gather list
+ * @handler: handler function (called for response to the request)
+ * @handler_data: data passed to handler function
+ * @timer: timer (e.g. for request initiated by erp)
+ * @completion: completion for synchronization purposes
+ * @ls_code: hex code of ELS command
+ * @status: used to pass error status to calling function
+ */
 struct zfcp_send_els {
 	struct zfcp_port *port;
 	struct scatterlist *req;
@@ -866,6 +837,7 @@
 	unsigned int resp_count;
 	zfcp_send_els_handler_t handler;
 	unsigned long handler_data;
+	struct timer_list *timer;
 	struct completion *completion;
 	int ls_code;
 	int status;
@@ -895,6 +867,7 @@
 	struct zfcp_send_ct *send_ct;
 	struct zfcp_send_els *send_els;
 	struct zfcp_status_read 	  status_read;
+	struct fsf_qtcb_bottom_port *port_data;
 };
 
 struct zfcp_qdio_queue {
@@ -982,6 +955,7 @@
 	rwlock_t                cmd_dbf_lock;
 	struct zfcp_adapter_mempool	pool;      /* Adapter memory pools */
 	struct qdio_initialize  qdio_init_data;    /* for qdio_establish */
+	struct device           generic_services;  /* directory for WKA ports */
 };
 
 /*
@@ -1083,6 +1057,11 @@
 	fcp_lun_t               init_fcp_lun;
 };
 
+/**
+ * struct zfcp_sg_list - struct describing a scatter-gather list
+ * @sg: pointer to array of (struct scatterlist)
+ * @count: number of elements in scatter-gather list
+ */
 struct zfcp_sg_list {
 	struct scatterlist *sg;
 	unsigned int count;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Mon Aug 30 19:14:11 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Mon Aug 30 19:14:23 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.62 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.65 $"
 
 #include "zfcp_ext.h"
 
@@ -126,6 +126,25 @@
 static void zfcp_erp_timeout_handler(unsigned long);
 static inline void zfcp_erp_timeout_init(struct zfcp_erp_action *);
 
+/**
+ * zfcp_fsf_request_timeout_handler - called if a request timed out
+ * @data: pointer to adapter for handler function
+ *
+ * This function needs to be called if requests (ELS, Generic Service,
+ * or SCSI commands) exceed a certain time limit. The assumption is
+ * that after the time limit the adapter get stuck. So we trigger a reopen of
+ * the adapter. This should not be used for error recovery, SCSI abort
+ * commands and SCSI requests from SCSI mid-layer.
+ */
+void
+zfcp_fsf_request_timeout_handler(unsigned long data)
+{
+	struct zfcp_adapter *adapter;
+
+	adapter = (struct zfcp_adapter *) data;
+
+	zfcp_erp_adapter_reopen(adapter, 0);
+}
 
 /*
  * function:	zfcp_fsf_scsi_er_timeout_handler
@@ -650,14 +669,15 @@
 	return retval;
 }
 
-/*
- * function:	
- *
- * purpose:	Wrappper for zfcp_erp_port_reopen_internal
- *              used to ensure the correct locking
- *
- * returns:	0	- initiated action succesfully
- *		<0	- failed to initiate action
+/**
+ * zfcp_erp_port_reopen - initiate reopen of a remote port
+ * @port: port to be reopened
+ * @clear_mask: specifies flags in port status to be cleared
+ * Return: 0 on success, < 0 on error
+ *
+ * This is a wrappper function for zfcp_erp_port_reopen_internal. It ensures
+ * correct locking. An error recovery task is initiated to do the reopen.
+ * To wait for the completion of the reopen zfcp_erp_wait should be used.
  */
 int
 zfcp_erp_port_reopen(struct zfcp_port *port, int clear_mask)
@@ -717,14 +737,15 @@
 	return retval;
 }
 
-/*
- * function:	
- *
- * purpose:	Wrappper for zfcp_erp_unit_reopen_internal
- *              used to ensure the correct locking
- *
- * returns:	0	- initiated action succesfully
- *		<0	- failed to initiate action
+/**
+ * zfcp_erp_unit_reopen - initiate reopen of a unit
+ * @unit: unit to be reopened
+ * @clear_mask: specifies flags in unit status to be cleared
+ * Return: 0 on success, < 0 on error
+ *
+ * This is a wrappper for zfcp_erp_unit_reopen_internal. It ensures correct
+ * locking. An error recovery task is initiated to do the reopen.
+ * To wait for the completion of the reopen zfcp_erp_wait should be used.
  */
 int
 zfcp_erp_unit_reopen(struct zfcp_unit *unit, int clear_mask)
@@ -1902,12 +1923,10 @@
 	return retval;
 }
 
-/*
- * function:	
- *
- * purpose:	
- *
- * returns:
+/**
+ * zfcp_erp_wait - wait for completion of error recovery on an adapter
+ * @adapter: adapter for which to wait for completion of its error recovery
+ * Return: 0
  */
 int
 zfcp_erp_wait(struct zfcp_adapter *adapter)
@@ -2045,7 +2064,7 @@
 	struct zfcp_port *port;
 
 	list_for_each_entry(port, &adapter->port_list_head, list)
-		if (!atomic_test_mask(ZFCP_STATUS_PORT_NAMESERVER, &port->status))
+		if (!atomic_test_mask(ZFCP_STATUS_PORT_WKA, &port->status))
 			zfcp_erp_port_reopen_internal(port, clear_mask);
 
 	return retval;
@@ -2640,7 +2659,7 @@
 {
 	int retval;
 
-	if (atomic_test_mask(ZFCP_STATUS_PORT_NAMESERVER,
+	if (atomic_test_mask(ZFCP_STATUS_PORT_WKA,
 			     &erp_action->port->status))
 		retval = zfcp_erp_port_strategy_open_nameserver(erp_action);
 	else
@@ -2778,10 +2797,10 @@
 
 	case ZFCP_ERP_STEP_PORT_OPENING:
 		if (atomic_test_mask(ZFCP_STATUS_COMMON_OPEN, &port->status)) {
-			ZFCP_LOG_DEBUG("nameserver port is open\n");
+			ZFCP_LOG_DEBUG("WKA port is open\n");
 			retval = ZFCP_ERP_SUCCEEDED;
 		} else {
-			ZFCP_LOG_DEBUG("open failed for nameserver port\n");
+			ZFCP_LOG_DEBUG("open failed for WKA port\n");
 			retval = ZFCP_ERP_FAILED;
 		}
 		/* this is needed anyway (dont care for retval of wakeup) */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	Mon Aug 30 19:14:11 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h	Mon Aug 30 19:14:23 2004
@@ -31,7 +31,7 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_EXT_REVISION "$Revision: 1.53 $"
+#define ZFCP_EXT_REVISION "$Revision: 1.57 $"
 
 #include "zfcp_def.h"
 
@@ -50,15 +50,16 @@
 extern void zfcp_sysfs_unit_release(struct device *);
 
 /**************************** CONFIGURATION  *********************************/
-extern struct zfcp_unit *zfcp_get_unit_by_lun(struct zfcp_port *,
-					      fcp_lun_t fcp_lun);
-extern struct zfcp_port *zfcp_get_port_by_wwpn(struct zfcp_adapter *,
-					       wwn_t wwpn);
+extern struct zfcp_unit *zfcp_get_unit_by_lun(struct zfcp_port *, fcp_lun_t);
+extern struct zfcp_port *zfcp_get_port_by_wwpn(struct zfcp_adapter *, wwn_t);
+extern struct zfcp_port *zfcp_get_port_by_did(struct zfcp_adapter *, u32);
+struct zfcp_adapter *zfcp_get_adapter_by_busid(char *);
 extern struct zfcp_adapter *zfcp_adapter_enqueue(struct ccw_device *);
 extern int    zfcp_adapter_debug_register(struct zfcp_adapter *);
 extern void   zfcp_adapter_dequeue(struct zfcp_adapter *);
 extern void   zfcp_adapter_debug_unregister(struct zfcp_adapter *);
-extern struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *, wwn_t, u32);
+extern struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *, wwn_t,
+					   u32, u32);
 extern void   zfcp_port_dequeue(struct zfcp_port *);
 extern struct zfcp_unit *zfcp_unit_enqueue(struct zfcp_port *, fcp_lun_t);
 extern void   zfcp_unit_dequeue(struct zfcp_unit *);
@@ -94,8 +95,11 @@
 extern int  zfcp_fsf_close_unit(struct zfcp_erp_action *);
 
 extern int  zfcp_fsf_exchange_config_data(struct zfcp_erp_action *);
+extern int  zfcp_fsf_exchange_port_data(struct zfcp_adapter *,
+					struct fsf_qtcb_bottom_port *);
 extern int  zfcp_fsf_control_file(struct zfcp_adapter *, struct zfcp_fsf_req **,
 				  u32, u32, struct zfcp_sg_list *);
+extern void zfcp_fsf_request_timeout_handler(unsigned long);
 extern void zfcp_fsf_scsi_er_timeout_handler(unsigned long);
 extern int  zfcp_fsf_req_dismiss_all(struct zfcp_adapter *);
 extern int  zfcp_fsf_status_read(struct zfcp_adapter *, int);
@@ -108,7 +112,7 @@
 extern int  zfcp_fsf_send_fcp_command_task(struct zfcp_adapter *,
 					   struct zfcp_unit *,
 					   struct scsi_cmnd *,
-					   int);
+					   struct timer_list*, int);
 extern int  zfcp_fsf_req_complete(struct zfcp_fsf_req *);
 extern void zfcp_fsf_incoming_els(struct zfcp_fsf_req *);
 extern void zfcp_fsf_req_cleanup(struct zfcp_fsf_req *);
@@ -134,10 +138,10 @@
 extern void zfcp_fsf_start_scsi_er_timer(struct zfcp_adapter *);
 extern fcp_dl_t zfcp_get_fcp_dl(struct fcp_cmnd_iu *);
 
-extern int zfcp_scsi_command_async(struct zfcp_adapter *,struct zfcp_unit *unit,
-				   struct scsi_cmnd *scsi_cmnd);
-extern int zfcp_scsi_command_sync(struct zfcp_unit *unit,
-				  struct scsi_cmnd *scsi_cmnd);
+extern int zfcp_scsi_command_async(struct zfcp_adapter *,struct zfcp_unit *,
+				   struct scsi_cmnd *, struct timer_list *);
+extern int zfcp_scsi_command_sync(struct zfcp_unit *, struct scsi_cmnd *,
+				  struct timer_list *);
 extern struct scsi_transport_template *zfcp_transport_template;
 extern struct fc_function_template zfcp_transport_functions;
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Mon Aug 30 19:14:11 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Mon Aug 30 19:14:23 2004
@@ -29,11 +29,12 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.59 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.65 $"
 
 #include "zfcp_ext.h"
 
 static int zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *);
+static void zfcp_fsf_exchange_port_data_handler(struct zfcp_fsf_req *);
 static int zfcp_fsf_open_port_handler(struct zfcp_fsf_req *);
 static int zfcp_fsf_close_port_handler(struct zfcp_fsf_req *);
 static int zfcp_fsf_close_physical_port_handler(struct zfcp_fsf_req *);
@@ -683,13 +684,11 @@
 		break;
 	case FSF_SQ_ULP_PROGRAMMING_ERROR:
 		ZFCP_LOG_FLAGS(0, "FSF_SQ_ULP_PROGRAMMING_ERROR\n");
-		ZFCP_LOG_NORMAL("bug: An illegal amount of data was attempted "
-				"to be sent to the adapter %s "
-				"Stopping all operations on this adapter. ",
+		ZFCP_LOG_NORMAL("error: not enough SBALs for data transfer "
+				"(adapter %s)\n",
 				zfcp_get_busid_by_adapter(fsf_req->adapter));
 		debug_text_exception(fsf_req->adapter->erp_dbf, 0,
 				     "fsf_sq_ulp_err");
-		zfcp_erp_adapter_shutdown(fsf_req->adapter, 0);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 	case FSF_SQ_INVOKE_LINK_TEST_PROCEDURE:
@@ -784,6 +783,11 @@
 		zfcp_fsf_exchange_config_data_handler(fsf_req);
 		break;
 
+	case FSF_QTCB_EXCHANGE_PORT_DATA :
+		ZFCP_LOG_FLAGS(2, "FSF_QTCB_EXCHANGE_PORT_DATA\n");
+		zfcp_fsf_exchange_port_data_handler(fsf_req);
+		break;
+
 	case FSF_QTCB_SEND_ELS :
 		ZFCP_LOG_FLAGS(2, "FSF_QTCB_SEND_ELS\n");
 		zfcp_fsf_send_els_handler(fsf_req);
@@ -1623,26 +1627,6 @@
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
-	case FSF_REQUEST_BUF_NOT_VALID :
-		ZFCP_LOG_FLAGS(2, "FSF_REQUEST_BUF_NOT_VALID\n");
-		ZFCP_LOG_NORMAL("error: The port 0x%016Lx on adapter %s has "
-				"rejected a generic services command "
-				"due to invalid request buffer.\n",
-				port->wwpn, zfcp_get_busid_by_port(port));
-		debug_text_event(adapter->erp_dbf, 1, "fsf_s_reqiv");
-		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
-		break;
-
-	case FSF_RESPONSE_BUF_NOT_VALID :
-		ZFCP_LOG_FLAGS(2, "FSF_RESPONSE_BUF_NOT_VALID\n");
-		ZFCP_LOG_NORMAL("error: The port 0x%016Lx on adapter %s has "
-				"rejected a generic services command "
-				"due to invalid response buffer.\n",
-				port->wwpn, zfcp_get_busid_by_port(port));
-		debug_text_event(adapter->erp_dbf, 1, "fsf_s_resiv");
-		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
-		break;
-
         case FSF_PORT_BOXED :
 		ZFCP_LOG_FLAGS(2, "FSF_PORT_BOXED\n");
 		ZFCP_LOG_INFO("The remote port 0x%016Lx on adapter %s "
@@ -1664,9 +1648,10 @@
 	}
 
 skip_fsfstatus:
-	if (send_ct->handler != NULL) {
+	send_ct->status = retval;
+
+	if (send_ct->handler != NULL)
 		send_ct->handler(send_ct->handler_data);
-        }
 
 	return retval;
 }
@@ -1768,7 +1753,7 @@
 	sbale = zfcp_qdio_sbale_req(fsf_req, fsf_req->sbal_curr, 0);
 
 	/* start QDIO request for this FSF request */
-	ret = zfcp_fsf_req_send(fsf_req, NULL);
+	ret = zfcp_fsf_req_send(fsf_req, els->timer);
 	if (ret) {
 		ZFCP_LOG_DEBUG("error: initiation of ELS request failed "
 			       "(adapter %s, port 0x%016Lx)\n",
@@ -1924,15 +1909,6 @@
 			bottom->resp_buf_length);
 		break;
 
-	case FSF_UNKNOWN_COMMAND:
-		ZFCP_LOG_FLAGS(2, "FSF_UNKNOWN_COMMAND\n");
-		ZFCP_LOG_INFO(
-			"FSF command 0x%x is not supported by FCP adapter "
-			"(adapter: %s)\n", fsf_req->fsf_command,
-			zfcp_get_busid_by_port(port));
-		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
-		break;
-
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
 		ZFCP_LOG_NORMAL("Access denied, cannot send ELS "
@@ -2220,6 +2196,111 @@
 	return 0;
 }
 
+/**
+ * zfcp_fsf_exchange_port_data - request information about local port
+ * @adapter: for which port data is requested
+ * @data: response to exchange port data request
+ */
+int
+zfcp_fsf_exchange_port_data(struct zfcp_adapter *adapter,
+			    struct fsf_qtcb_bottom_port *data)
+{
+	volatile struct qdio_buffer_element *sbale;
+	int retval = 0;
+	unsigned long lock_flags;
+        struct zfcp_fsf_req *fsf_req;
+	struct timer_list *timer;
+
+        if(!(adapter->supported_features & FSF_FEATURE_HBAAPI_MANAGEMENT)){
+		ZFCP_LOG_INFO("error: exchange port data "
+                              "command not supported by adapter %s\n",
+			      zfcp_get_busid_by_adapter(adapter));
+                return -EOPNOTSUPP;
+        }
+
+	timer = kmalloc(sizeof(struct timer_list), GFP_KERNEL);
+	if (!timer)
+		return -ENOMEM;
+
+	/* setup new FSF request */
+	retval = zfcp_fsf_req_create(adapter, FSF_QTCB_EXCHANGE_PORT_DATA,
+                                     0, 0, &lock_flags, &fsf_req);
+	if (retval < 0) {
+		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
+                              "exchange port data request for"
+                              "the adapter %s.\n",
+			      zfcp_get_busid_by_adapter(adapter));
+		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
+					lock_flags);
+		goto out;
+	}
+
+	sbale = zfcp_qdio_sbale_req(fsf_req, fsf_req->sbal_curr, 0);
+        sbale[0].flags |= SBAL_FLAGS0_TYPE_READ;
+        sbale[1].flags |= SBAL_FLAGS_LAST_ENTRY;
+
+        fsf_req->data.port_data = data;
+
+	init_timer(timer);
+	timer->function = zfcp_fsf_request_timeout_handler;
+	timer->data = (unsigned long) adapter;
+	timer->expires = ZFCP_FSF_REQUEST_TIMEOUT;
+
+	retval = zfcp_fsf_req_send(fsf_req, timer);
+	if (retval) {
+		ZFCP_LOG_INFO("error: Could not send an exchange port data "
+                              "command on the adapter %s\n",
+			      zfcp_get_busid_by_adapter(adapter));
+		zfcp_fsf_req_free(fsf_req);
+		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
+					lock_flags);
+		goto out;
+	}
+
+	ZFCP_LOG_DEBUG("Exchange Port Data request initiated (adapter %s)\n",
+		       zfcp_get_busid_by_adapter(adapter));
+
+	write_unlock_irqrestore(&adapter->request_queue.queue_lock,
+				lock_flags);
+
+	wait_event(fsf_req->completion_wq,
+		   fsf_req->status & ZFCP_STATUS_FSFREQ_COMPLETED);
+	del_timer_sync(timer);
+	zfcp_fsf_req_cleanup(fsf_req);
+ out:
+	kfree(timer);
+	return retval;
+}
+
+
+/**
+ * zfcp_fsf_exchange_port_data_handler - handler for exchange_port_data request
+ * @fsf_req: pointer to struct zfcp_fsf_req
+ */
+static void
+zfcp_fsf_exchange_port_data_handler(struct zfcp_fsf_req *fsf_req)
+{
+	struct fsf_qtcb_bottom_port *bottom;
+	struct fsf_qtcb_bottom_port *data = fsf_req->data.port_data;
+
+	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR)
+		return;
+
+	switch (fsf_req->qtcb->header.fsf_status) {
+        case FSF_GOOD :
+                ZFCP_LOG_FLAGS(2,"FSF_GOOD\n");
+                bottom = &fsf_req->qtcb->bottom.port;
+                memcpy(data, bottom, sizeof(*data));
+                break;
+
+        default:
+		debug_text_event(fsf_req->adapter->erp_dbf, 0, "xchg-port-ng");
+                debug_event(fsf_req->adapter->erp_dbf, 0,
+			    &fsf_req->qtcb->header.fsf_status, sizeof(u32));
+	}
+}
+
+
 /*
  * function:    zfcp_fsf_open_port
  *
@@ -3320,19 +3401,19 @@
 	return retval;
 }
 
-/*
- * function:    zfcp_fsf_send_fcp_command_task
- *
- * purpose:
- *
- * returns:
- *
- * note: we do not employ linked commands (not supported by HBA anyway)
+/**
+ * zfcp_fsf_send_fcp_command_task - initiate an FCP command (for a SCSI command)
+ * @adapter: adapter where scsi command is issued
+ * @unit: unit where command is sent to
+ * @scsi_cmnd: scsi command to be sent
+ * @timer: timer to be started when request is initiated
+ * @req_flags: flags for fsf_request
  */
 int
 zfcp_fsf_send_fcp_command_task(struct zfcp_adapter *adapter,
 			       struct zfcp_unit *unit,
-			       struct scsi_cmnd * scsi_cmnd, int req_flags)
+			       struct scsi_cmnd * scsi_cmnd,
+			       struct timer_list *timer, int req_flags)
 {
 	struct zfcp_fsf_req *fsf_req = NULL;
 	struct fcp_cmnd_iu *fcp_cmnd_iu;
@@ -3487,7 +3568,7 @@
 	 * start QDIO request for this FSF request
 	 *  covered by an SBALE)
 	 */
-	retval = zfcp_fsf_req_send(fsf_req, NULL);
+	retval = zfcp_fsf_req_send(fsf_req, timer);
 	if (unlikely(retval < 0)) {
 		ZFCP_LOG_INFO("error: Could not send FCP command request "
 			      "on adapter %s, port 0x%016Lx, unit 0x%016Lx\n",
@@ -3789,44 +3870,6 @@
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
-		/* FIXME: this should be obsolete, isn' it? */
-	case FSF_INBOUND_DATA_LENGTH_NOT_VALID:
-		ZFCP_LOG_FLAGS(0, "FSF_INBOUND_DATA_LENGTH_NOT_VALID\n");
-		ZFCP_LOG_NORMAL("bug: An invalid inbound data length field "
-				"was found in a command for unit 0x%016Lx "
-				"on port 0x%016Lx on adapter %s.\n",
-				unit->fcp_lun,
-				unit->port->wwpn, zfcp_get_busid_by_unit(unit));
-		/* stop operation for this adapter */
-		debug_text_event(fsf_req->adapter->erp_dbf, 0,
-				 "fsf_s_in_dl_nv");
-		zfcp_erp_adapter_shutdown(unit->port->adapter, 0);
-		zfcp_cmd_dbf_event_fsf("idleninv",
-				       fsf_req,
-				       &header->fsf_status_qual,
-				       sizeof (union fsf_status_qual));
-		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
-		break;
-
-		/* FIXME: this should be obsolete, isn' it? */
-	case FSF_OUTBOUND_DATA_LENGTH_NOT_VALID:
-		ZFCP_LOG_FLAGS(0, "FSF_OUTBOUND_DATA_LENGTH_NOT_VALID\n");
-		ZFCP_LOG_NORMAL("bug: An invalid outbound data length field "
-				"was found in a command unit 0x%016Lx on port "
-				"0x%016Lx on adapter %s\n",
-				unit->fcp_lun,
-				unit->port->wwpn,
-				zfcp_get_busid_by_unit(unit));
-		/* stop operation for this adapter */
-		debug_text_event(fsf_req->adapter->erp_dbf, 0,
-				 "fsf_s_out_dl_nv");
-		zfcp_erp_adapter_shutdown(unit->port->adapter, 0);
-		zfcp_cmd_dbf_event_fsf("odleninv", fsf_req,
-				       &header->fsf_status_qual,
-				       sizeof (union fsf_status_qual));
-		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
-		break;
-
 	case FSF_CMND_LENGTH_NOT_VALID:
 		ZFCP_LOG_FLAGS(0, "FSF_CMND_LENGTH_NOT_VALID\n");
 		ZFCP_LOG_NORMAL
@@ -4505,16 +4548,6 @@
 		retval = -EIO;
 		break;
 
-	case FSF_UNKNOWN_COMMAND:
-		ZFCP_LOG_FLAGS(2, "FSF_UNKNOWN_COMMAND\n");
-		ZFCP_LOG_NORMAL(
-			"FSF command 0x%x is not supported by the adapter %s\n",
-			fsf_req->fsf_command,
-			zfcp_get_busid_by_adapter(adapter));
-		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
-		retval = -EINVAL;
-		break;
-
 	case FSF_UNKNOWN_OP_SUBTYPE:
 		ZFCP_LOG_FLAGS(2, "FSF_UNKNOWN_OP_SUBTYPE\n");
 		ZFCP_LOG_NORMAL(
@@ -4632,7 +4665,7 @@
  * zfcp_fsf_req_sbal_get - try to get one SBAL in the request queue
  * @adapter: adapter for which request queue is examined
  * @req_flags: flags indicating whether to wait for needed SBAL or not
- * @lock_flags: lock_flags is queue_lock is taken
+ * @lock_flags: lock_flags if queue_lock is taken
  * Return: 0 on success, otherwise -EIO, or -ERESTARTSYS
  * Locks: lock adapter->request_queue->queue_lock on success
  */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.h linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.h	Mon Aug 30 19:14:11 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h	Mon Aug 30 19:14:23 2004
@@ -84,19 +84,12 @@
 #define FSF_SERVICE_CLASS_NOT_SUPPORTED		0x00000006
 #define FSF_FCPLUN_NOT_VALID			0x00000009
 #define FSF_ACCESS_DENIED			0x00000010
-#define FSF_ACCESS_TYPE_NOT_VALID		0x00000011
 #define FSF_LUN_SHARING_VIOLATION               0x00000012
-#define FSF_COMMAND_ABORTED_ULP			0x00000020
-#define FSF_COMMAND_ABORTED_ADAPTER		0x00000021
 #define FSF_FCP_COMMAND_DOES_NOT_EXIST		0x00000022
 #define FSF_DIRECTION_INDICATOR_NOT_VALID	0x00000030
-#define FSF_INBOUND_DATA_LENGTH_NOT_VALID	0x00000031 /* FIX: obsolete? */
-#define FSF_OUTBOUND_DATA_LENGTH_NOT_VALID	0x00000032 /* FIX: obsolete? */
 #define FSF_CMND_LENGTH_NOT_VALID		0x00000033
 #define FSF_MAXIMUM_NUMBER_OF_PORTS_EXCEEDED	0x00000040
 #define FSF_MAXIMUM_NUMBER_OF_LUNS_EXCEEDED	0x00000041
-#define FSF_REQUEST_BUF_NOT_VALID		0x00000042
-#define FSF_RESPONSE_BUF_NOT_VALID		0x00000043
 #define FSF_ELS_COMMAND_REJECTED		0x00000050
 #define FSF_GENERIC_COMMAND_REJECTED		0x00000051
 #define FSF_OPERATION_PARTIALLY_SUCCESSFUL	0x00000052
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	Mon Aug 30 19:14:11 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c	Mon Aug 30 19:14:23 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.66 $"
+#define ZFCP_SCSI_REVISION "$Revision: 1.68 $"
 
 #include "zfcp_ext.h"
 
@@ -247,15 +247,16 @@
 /**
  * zfcp_scsi_command_async - worker for zfcp_scsi_queuecommand and
  *	zfcp_scsi_command_sync
- * @adapter: adapter for where scsi command is issued
+ * @adapter: adapter where scsi command is issued
  * @unit: unit to which scsi command is sent
  * @scpnt: scsi command to be sent
+ * @timer: timer to be started if request is successfully initiated
  *
  * Note: In scsi_done function must be set in scpnt.
  */
 int
 zfcp_scsi_command_async(struct zfcp_adapter *adapter, struct zfcp_unit *unit,
-			struct scsi_cmnd *scpnt)
+			struct scsi_cmnd *scpnt, struct timer_list *timer)
 {
 	int tmp;
 	int retval;
@@ -291,7 +292,7 @@
 		goto out;
 	}
 
-	tmp = zfcp_fsf_send_fcp_command_task(adapter, unit, scpnt,
+	tmp = zfcp_fsf_send_fcp_command_task(adapter, unit, scpnt, timer,
 					     ZFCP_REQ_AUTO_CLEANUP);
 
 	if (unlikely(tmp < 0)) {
@@ -313,18 +314,28 @@
 
 /**
  * zfcp_scsi_command_sync - send a SCSI command and wait for completion
- * returns 0, errors are indicated by scsi_cmnd->result
+ * @unit: unit where command is sent to
+ * @scpnt: scsi command to be sent
+ * @timer: timer to be started if request is successfully initiated
+ * Return: 0
+ *
+ * Errors are indicated in scpnt->result
  */
 int
-zfcp_scsi_command_sync(struct zfcp_unit *unit, struct scsi_cmnd *scpnt)
+zfcp_scsi_command_sync(struct zfcp_unit *unit, struct scsi_cmnd *scpnt,
+		       struct timer_list *timer)
 {
+	int ret;
 	DECLARE_COMPLETION(wait);
 
 	scpnt->SCp.ptr = (void *) &wait;  /* silent re-use */
-	scpnt->done = zfcp_scsi_command_sync_handler;
-        zfcp_scsi_command_async(unit->port->adapter, unit, scpnt);
+	scpnt->scsi_done = zfcp_scsi_command_sync_handler;
+	ret = zfcp_scsi_command_async(unit->port->adapter, unit, scpnt, timer);
+	if ((ret == 0) && (scpnt->result == 0))
 	wait_for_completion(&wait);
 
+	scpnt->SCp.ptr = NULL;
+
 	return 0;
 }
 
@@ -355,7 +366,7 @@
 	adapter = (struct zfcp_adapter *) scpnt->device->host->hostdata[0];
 	unit = (struct zfcp_unit *) scpnt->device->hostdata;
 
-	return zfcp_scsi_command_async(adapter, unit, scpnt);
+	return zfcp_scsi_command_async(adapter, unit, scpnt, NULL);
 }
 
 /*
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_adapter.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c	Mon Aug 30 19:14:11 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_adapter.c	Mon Aug 30 19:14:23 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.36 $"
+#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.37 $"
 
 #include "zfcp_ext.h"
 
@@ -106,7 +106,7 @@
 	if ((endp + 1) < (buf + count))
 		goto out;
 
-	port = zfcp_port_enqueue(adapter, wwpn, 0);
+	port = zfcp_port_enqueue(adapter, wwpn, 0, 0);
 	if (!port)
 		goto out;
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	Mon Aug 30 19:14:11 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c	Mon Aug 30 19:14:23 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.43 $"
+#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.44 $"
 
 #include "zfcp_ext.h"
 
@@ -279,7 +279,7 @@
 
 	retval = sysfs_create_group(&dev->kobj, &zfcp_port_common_attr_group);
 
-	if ((flags & ZFCP_STATUS_PORT_NAMESERVER) || retval)
+	if ((flags & ZFCP_STATUS_PORT_WKA) || retval)
 		return retval;
 
 	retval = sysfs_create_group(&dev->kobj, &zfcp_port_no_ns_attr_group);
@@ -299,7 +299,7 @@
 zfcp_sysfs_port_remove_files(struct device *dev, u32 flags)
 {
 	sysfs_remove_group(&dev->kobj, &zfcp_port_common_attr_group);
-	if (!(flags & ZFCP_STATUS_PORT_NAMESERVER))
+	if (!(flags & ZFCP_STATUS_PORT_WKA))
 		sysfs_remove_group(&dev->kobj, &zfcp_port_no_ns_attr_group);
 }
 
