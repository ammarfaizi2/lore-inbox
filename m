Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUCLUH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbUCLUG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:06:56 -0500
Received: from mtagate7.de.ibm.com ([195.212.29.156]:58612 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S262454AbUCLTiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:38:50 -0500
Date: Fri, 12 Mar 2004 20:38:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (9/10): zfcp log messages part 1.
Message-ID: <20040312193834.GJ2757@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zfcp host adapter log message cleanup part 1:
 - Shorten log output.
 - Increase log level for some messages.
 - Always print leading zeroes for wwpn and fcp-lun.

diffstat:
 drivers/s390/scsi/zfcp_aux.c |  239 ++++++-------------
 drivers/s390/scsi/zfcp_ccw.c |   11 
 drivers/s390/scsi/zfcp_def.h |    3 
 drivers/s390/scsi/zfcp_erp.c |  517 +++++++++++++++++--------------------------
 drivers/s390/scsi/zfcp_ext.h |    3 
 5 files changed, 295 insertions(+), 478 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	Fri Mar 12 20:03:36 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c	Fri Mar 12 20:03:36 2004
@@ -52,6 +52,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/workqueue.h>
+#include <linux/syscalls.h>
 
 #include "zfcp_ext.h"
 
@@ -440,11 +441,6 @@
 
 	atomic_set(&zfcp_data.loglevel, loglevel);
 
-	ZFCP_LOG_DEBUG(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
-
-	ZFCP_LOG_TRACE("Start Address of module: 0x%lx\n",
-		       (unsigned long) &zfcp_module_init);
-
 	/* initialize adapter list */
 	INIT_LIST_HEAD(&zfcp_data.adapter_list_head);
 
@@ -459,22 +455,18 @@
 	retval = register_ioctl32_conversion(zfcp_ioctl_trans.cmd,
 					     zfcp_ioctl_trans.handler);
 	if (retval != 0) {
-		ZFCP_LOG_INFO("Cannot register a 32-bit support of "
-			      "the IOC handler\n");
+		ZFCP_LOG_INFO("registration of ioctl32 conversion failed\n");
 		goto out_ioctl32;
 	}
 #endif
 	retval = misc_register(&zfcp_cfdc_misc);
 	if (retval != 0) {
-		ZFCP_LOG_INFO(
-			"Device file for the control file data channel "
-			"cannot be registered\n");
+		ZFCP_LOG_INFO("registration of misc device "
+			      "zfcp_cfdc failed\n");
 		goto out_misc_register;
 	} else {
-		ZFCP_LOG_INFO(
-			"Device file for the control file data channel "
-			"has become MAJOR/MINOR numbers %d/%d\n",
-			ZFCP_CFDC_DEV_MAJOR, zfcp_cfdc_misc.minor);
+		ZFCP_LOG_TRACE("major/minor for zfcp_cfdc: %d/%d\n",
+			       ZFCP_CFDC_DEV_MAJOR, zfcp_cfdc_misc.minor);
 	}
 
 	/* Initialise proc semaphores */
@@ -492,7 +484,7 @@
 	/* setup dynamic I/O */
 	retval = zfcp_ccw_register();
 	if (retval) {
-		ZFCP_LOG_NORMAL("Registering with common I/O layer failed.\n");
+		ZFCP_LOG_NORMAL("registration with common I/O layer failed\n");
 		goto out_ccw_register;
 	}
 
@@ -529,7 +521,6 @@
 #ifdef ZFCP_STAT_REQSIZES
 	zfcp_statistics_clear_all();
 #endif
-	ZFCP_LOG_DEBUG("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
 }
 
 /*
@@ -576,46 +567,35 @@
 	char *bus_id = NULL;
 	int retval = 0;
 
-	ZFCP_LOG_NORMAL(
-		"Control file data channel transaction opened\n");
-
 	sg_list = kmalloc(sizeof(struct zfcp_sg_list), GFP_KERNEL);
 	if (sg_list == NULL) {
-		ZFCP_LOG_NORMAL(
-			"Not enough memory for the scatter-gather list\n");
 		retval = -ENOMEM;
 		goto out;
 	}
 	sg_list->count = 0;
 
 	if (command != ZFCP_CFDC_IOC) {
-		ZFCP_LOG_NORMAL(
-			"IOC request code 0x%x is not valid\n",
-			command);
+		ZFCP_LOG_INFO("IOC request code 0x%x invalid\n", command);
 		retval = -ENOTTY;
 		goto out;
 	}
 
 	if ((sense_data_user = (struct zfcp_cfdc_sense_data*)buffer) == NULL) {
-		ZFCP_LOG_NORMAL(
-			"Sense data record is required\n");
+		ZFCP_LOG_INFO("sense data record is required\n");
 		retval = -EINVAL;
 		goto out;
 	}
 
 	retval = copy_from_user(&sense_data, sense_data_user,
-		sizeof(struct zfcp_cfdc_sense_data));
+				sizeof(struct zfcp_cfdc_sense_data));
 	if (retval) {
-		ZFCP_LOG_NORMAL("Cannot copy sense data record from user space "
-				"memory\n");
 		retval = -EFAULT;
 		goto out;
 	}
 
 	if (sense_data.signature != ZFCP_CFDC_SIGNATURE) {
-		ZFCP_LOG_NORMAL(
-			"No valid sense data request signature 0x%08x found\n",
-			ZFCP_CFDC_SIGNATURE);
+		ZFCP_LOG_INFO("invalid sense data request signature 0x%08x\n",
+			      ZFCP_CFDC_SIGNATURE);
 		retval = -EINVAL;
 		goto out;
 	}
@@ -648,16 +628,14 @@
 		break;
 
 	default:
-		ZFCP_LOG_NORMAL(
-			"Command code 0x%08x is not valid\n",
-			sense_data.command);
+		ZFCP_LOG_INFO("invalid command code 0x%08x\n",
+			      sense_data.command);
 		retval = -EINVAL;
 		goto out;
 	}
 
 	bus_id = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
 	if (bus_id == NULL) {
-		ZFCP_LOG_NORMAL("Out of memory!\n");
 		retval = -ENOMEM;
 		goto out;
 	}
@@ -681,7 +659,7 @@
 	kfree(bus_id);
 
 	if (retval != 0) {
-		ZFCP_LOG_NORMAL("Specified adapter does not exist\n");
+		ZFCP_LOG_INFO("invalid adapter\n");
 		goto out;
 	}
 
@@ -689,8 +667,6 @@
 		retval = zfcp_sg_list_alloc(sg_list,
 					    ZFCP_CFDC_MAX_CONTROL_FILE_SIZE);
 		if (retval) {
-			ZFCP_LOG_NORMAL("Not enough memory for the "
-					"scatter-gather list\n");
 			retval = -ENOMEM;
 			goto out;
 		}
@@ -702,8 +678,6 @@
 			sg_list, &sense_data_user->control_file,
 			ZFCP_CFDC_MAX_CONTROL_FILE_SIZE);
 		if (retval) {
-			ZFCP_LOG_NORMAL("Cannot copy control file from user "
-					"space memory\n");
 			retval = -EFAULT;
 			goto out;
 		}
@@ -712,12 +686,10 @@
 	retval = zfcp_fsf_control_file(
 		adapter, &fsf_req, fsf_command, option, sg_list);
 	if (retval == -EOPNOTSUPP) {
-		ZFCP_LOG_NORMAL(
-			"Specified adapter does not support control file\n");
+		ZFCP_LOG_INFO("adapter does not support cfdc\n");
 		goto out;
 	} else if (retval != 0) {
-		ZFCP_LOG_NORMAL(
-			"Cannot create or queue FSF request or create SBALs\n");
+		ZFCP_LOG_INFO("initiation of cfdc up/download failed\n");
 		retval = -EPERM;
 		goto out;
 	}
@@ -734,8 +706,6 @@
 	retval = copy_to_user(sense_data_user, &sense_data,
 		sizeof(struct zfcp_cfdc_sense_data));
 	if (retval) {
-		ZFCP_LOG_NORMAL(
-			"Cannot copy sense data record to user space memory\n");
 		retval = -EFAULT;
 		goto out;
 	}
@@ -745,8 +715,6 @@
 			&sense_data_user->control_file, sg_list,
 			ZFCP_CFDC_MAX_CONTROL_FILE_SIZE);
 		if (retval) {
-			ZFCP_LOG_NORMAL("Cannot copy control file to user "
-					"space memory\n");
 			retval = -EFAULT;
 			goto out;
 		}
@@ -764,9 +732,6 @@
 		kfree(sg_list);
 	}
 
-	ZFCP_LOG_NORMAL(
-		"Control file data channel transaction closed\n");
-
 	return retval;
 }
 
@@ -859,7 +824,6 @@
 		zfcp_buffer = (void*)
 			((page_to_pfn(sg->page) << PAGE_SHIFT) + sg->offset);
 		if (copy_from_user(zfcp_buffer, user_buffer, length)) {
-			ZFCP_LOG_INFO("Memory error (copy_from_user)\n");
 			retval = -EFAULT;
 			goto out;
 		}
@@ -894,7 +858,6 @@
 		zfcp_buffer = (void*)
 			((page_to_pfn(sg->page) << PAGE_SHIFT) + sg->offset);
 		if (copy_to_user(user_buffer, zfcp_buffer, length)) {
-			ZFCP_LOG_INFO("Memory error (copy_to_user)\n");
 			retval = -EFAULT;
 			goto out;
 		}
@@ -1092,63 +1055,48 @@
 			       zfcp_mempool_alloc, zfcp_mempool_free, (void *)
 			       sizeof(struct zfcp_fsf_req_pool_element));
 
-	if (NULL == adapter->pool.fsf_req_erp) {
-		ZFCP_LOG_INFO("error: pool allocation failed (fsf_req_erp)\n");
+	if (NULL == adapter->pool.fsf_req_erp)
 		return -ENOMEM;
-	}
 
 	adapter->pool.fsf_req_scsi =
 		mempool_create(ZFCP_POOL_FSF_REQ_SCSI_NR,
 			       zfcp_mempool_alloc, zfcp_mempool_free, (void *)
 			       sizeof(struct zfcp_fsf_req_pool_element));
 
-	if (NULL == adapter->pool.fsf_req_scsi) {
-		ZFCP_LOG_INFO("error: pool allocation failed (fsf_req_scsi)\n");
+	if (NULL == adapter->pool.fsf_req_scsi)
 		return -ENOMEM;
-	}
 
 	adapter->pool.fsf_req_abort =
 		mempool_create(ZFCP_POOL_FSF_REQ_ABORT_NR,
 			       zfcp_mempool_alloc, zfcp_mempool_free, (void *)
 			       sizeof(struct zfcp_fsf_req_pool_element));
 
-	if (NULL == adapter->pool.fsf_req_abort) {
-		ZFCP_LOG_INFO("error: pool allocation failed "
-			      "(fsf_req_abort)\n");
+	if (NULL == adapter->pool.fsf_req_abort)
 		return -ENOMEM;
-	}
 
 	adapter->pool.fsf_req_status_read =
 		mempool_create(ZFCP_POOL_STATUS_READ_NR,
 			       zfcp_mempool_alloc, zfcp_mempool_free,
 			       (void *) sizeof(struct zfcp_fsf_req));
 
-	if (NULL == adapter->pool.fsf_req_status_read) {
-		ZFCP_LOG_INFO("error: pool allocation failed "
-			      "(fsf_req_status_read\n");
+	if (NULL == adapter->pool.fsf_req_status_read)
 		return -ENOMEM;
-	}
 
 	adapter->pool.data_status_read =
 		mempool_create(ZFCP_POOL_STATUS_READ_NR,
 			       zfcp_mempool_alloc, zfcp_mempool_free, 
 			       (void *) sizeof(struct fsf_status_read_buffer));
 
-	if (NULL == adapter->pool.data_status_read) {
-		ZFCP_LOG_INFO("error: pool allocation failed "
-			      "(data_status_read)\n");
+	if (NULL == adapter->pool.data_status_read)
 		return -ENOMEM;
-	}
 
 	adapter->pool.data_gid_pn =
 		mempool_create(ZFCP_POOL_DATA_GID_PN_NR,
 			       zfcp_mempool_alloc, zfcp_mempool_free, (void *)
 			       sizeof(struct zfcp_gid_pn_data));
 
-	if (NULL == adapter->pool.data_gid_pn) {
-		ZFCP_LOG_INFO("error: pool allocation failed (data_gid_pn)\n");
+	if (NULL == adapter->pool.data_gid_pn)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -1200,7 +1148,7 @@
 	/* try to allocate new adapter data structure (zeroed) */
 	adapter = kmalloc(sizeof (struct zfcp_adapter), GFP_KERNEL);
 	if (!adapter) {
-		ZFCP_LOG_INFO("error: Allocation of base adapter "
+		ZFCP_LOG_INFO("error: allocation of base adapter "
 			      "structure failed\n");
 		goto out;
 	}
@@ -1220,8 +1168,10 @@
 		goto qdio_allocate_failed;
 
 	retval = zfcp_allocate_low_mem_buffers(adapter);
-	if (retval)
+	if (retval) {
+		ZFCP_LOG_INFO("error: pool allocation failed\n");
 		goto failed_low_mem_buffers;
+	}
 
 	/* initialise reference count stuff */
 	atomic_set(&adapter->refcount, 0);
@@ -1274,10 +1224,8 @@
 					  ZFCP_REQ_DBF_AREAS,
 					  ZFCP_REQ_DBF_LENGTH);
 	if (!adapter->req_dbf) {
-		ZFCP_LOG_INFO
-		    ("error: Out of resources. Request debug feature for "
-		     "adapter %s could not be generated.\n",
-		     zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_INFO("registration of dbf for adapter %s failed\n",
+			      zfcp_get_busid_by_adapter(adapter));
 		retval = -ENOMEM;
 		goto failed_req_dbf;
 	}
@@ -1296,10 +1244,8 @@
 					  ZFCP_CMD_DBF_AREAS,
 					  ZFCP_CMD_DBF_LENGTH);
 	if (!adapter->cmd_dbf) {
-		ZFCP_LOG_INFO
-		    ("error: Out of resources. Command debug feature for "
-		     "adapter %s could not be generated.\n",
-		     zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_INFO("registration of dbf for adapter %s failed\n",
+			      zfcp_get_busid_by_adapter(adapter));
 		retval = -ENOMEM;
 		goto failed_cmd_dbf;
 	}
@@ -1316,10 +1262,8 @@
 					    ZFCP_ABORT_DBF_AREAS,
 					    ZFCP_ABORT_DBF_LENGTH);
 	if (!adapter->abort_dbf) {
-		ZFCP_LOG_INFO
-		    ("error: Out of resources. Abort debug feature for "
-		     "adapter %s could not be generated.\n",
-		     zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_INFO("registration of dbf for adapter %s failed\n",
+			      zfcp_get_busid_by_adapter(adapter));
 		retval = -ENOMEM;
 		goto failed_abort_dbf;
 	}
@@ -1336,8 +1280,7 @@
 					     ZFCP_IN_ELS_DBF_AREAS,
 					     ZFCP_IN_ELS_DBF_LENGTH);
 	if (!adapter->in_els_dbf) {
-		ZFCP_LOG_INFO("error: Out of resources. ELS debug feature for "
-			      "adapter %s could not be generated.\n",
+		ZFCP_LOG_INFO("registration of dbf for adapter %s failed\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		retval = -ENOMEM;
 		goto failed_in_els_dbf;
@@ -1353,8 +1296,7 @@
 					  ZFCP_ERP_DBF_AREAS,
 					  ZFCP_ERP_DBF_LENGTH);
 	if (!adapter->erp_dbf) {
-		ZFCP_LOG_INFO("error: Out of resources. ERP debug feature for "
-			      "adapter %s could not be generated.\n",
+		ZFCP_LOG_INFO("registration of dbf for adapter %s failed\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		retval = -ENOMEM;
 		goto failed_erp_dbf;
@@ -1398,10 +1340,8 @@
  failed_low_mem_buffers:
 	zfcp_free_low_mem_buffers(adapter);
 	if (qdio_free(ccw_device) != 0)
-		ZFCP_LOG_NORMAL
-		    ("bug: could not free memory used by data transfer "
-		     "mechanism for adapter %s\n",
-		     zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_NORMAL("bug: qdio_free for adapter %s failed\n",
+				zfcp_get_busid_by_adapter(adapter));
  qdio_allocate_failed:
 	zfcp_qdio_free_queues(adapter);
  queues_alloc_failed:
@@ -1432,12 +1372,10 @@
 	retval = !list_empty(&adapter->fsf_req_list_head);
 	read_unlock_irqrestore(&adapter->fsf_req_list_lock, flags);
 	if (retval) {
-		ZFCP_LOG_NORMAL("bug: Adapter %s is still in use, "
-				"%i requests are still outstanding "
-				"(debug info 0x%lx)\n",
-				zfcp_get_busid_by_adapter(adapter),
-				atomic_read(&adapter->fsf_reqs_active),
-				(unsigned long) adapter);
+		ZFCP_LOG_NORMAL("bug: adapter %s (%p) still in use, "
+				"%i requests outstanding\n",
+				zfcp_get_busid_by_adapter(adapter), adapter, 
+				atomic_read(&adapter->fsf_reqs_active));
 		retval = -EBUSY;
 		goto out;
 	}
@@ -1450,16 +1388,15 @@
 	/* decrease number of adapters in list */
 	zfcp_data.adapters--;
 
-	ZFCP_LOG_TRACE("adapter 0x%lx removed from list, "
+	ZFCP_LOG_TRACE("adapter %s (%p) removed from list, "
 		       "%i adapters still in list\n",
-		       (unsigned long) adapter, zfcp_data.adapters);
+		       zfcp_get_busid_by_adapter(adapter),
+		       adapter, zfcp_data.adapters);
 
 	retval = qdio_free(adapter->ccw_device);
 	if (retval)
-		ZFCP_LOG_NORMAL
-		    ("bug: could not free memory used by data transfer "
-		     "mechanism for adapter %s\n",
-		     zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_NORMAL("bug: qdio_free for adapter %s failed\n",
+				zfcp_get_busid_by_adapter(adapter));
 
 	debug_unregister(adapter->erp_dbf);
 
@@ -1481,7 +1418,7 @@
 	zfcp_free_low_mem_buffers(adapter);
 	/* free memory of adapter data structure and queues */
 	zfcp_qdio_free_queues(adapter);
-	ZFCP_LOG_TRACE("Freeing adapter structure.\n");
+	ZFCP_LOG_TRACE("freeing adapter structure\n");
 	kfree(adapter);
  out:
 	return;
@@ -1610,9 +1547,8 @@
 	/* generate port structure */
 	port = zfcp_port_enqueue(adapter, 0, ZFCP_STATUS_PORT_NAMESERVER);
 	if (!port) {
-		ZFCP_LOG_INFO("error: Could not establish a connection to the "
-			      "fabric name server connected to the "
-			      "adapter %s\n",
+		ZFCP_LOG_INFO("error: enqueue of nameserver port for "
+			      "adapter %s failed\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		return -ENXIO;
 	}
@@ -1675,8 +1611,8 @@
 			range_mask = ZFCP_PORTS_RANGE_FABRIC;
 			break;
 		default:
-			ZFCP_LOG_INFO("Received RSCN with unknown "
-				      "address format.\n");
+			ZFCP_LOG_INFO("incoming RSCN with unknown "
+				      "address format\n");
 			continue;
 		}
 		read_lock_irqsave(&zfcp_data.config_lock, flags);
@@ -1687,11 +1623,8 @@
 			/* Do we know this port? If not skip it. */
 			if (!atomic_test_mask
 			    (ZFCP_STATUS_PORT_DID_DID, &port->status)) {
-				ZFCP_LOG_INFO
-					("Received state change notification."
-					 "Trying to open the port with wwpn "
-					 "0x%Lx. Hope it's there now.\n",
-					 port->wwpn);
+				ZFCP_LOG_INFO("incoming RSCN, trying to open "
+					      "port 0x%016Lx\n", port->wwpn);
 				debug_text_event(adapter->erp_dbf, 1,
 						 "unsol_els_rscnu:");
 				zfcp_erp_port_reopen(port,
@@ -1705,7 +1638,7 @@
 			 */
 			if ((port->d_id & range_mask)
 			    == (fcp_rscn_element->nport_did & range_mask)) {
-				ZFCP_LOG_TRACE("reopen did 0x%x\n",
+				ZFCP_LOG_TRACE("reopen did 0x%08x\n",
 					       fcp_rscn_element->nport_did);
 				/*
 				 * Unfortunately, an RSCN does not specify the
@@ -1717,10 +1650,8 @@
 				 * Where would such code be put in?
 				 * (inside or outside erp)
 				 */
-				ZFCP_LOG_INFO
-				    ("Received state change notification."
-				     "Trying to reopen the port with wwpn "
-				     "0x%Lx.\n", port->wwpn);
+				ZFCP_LOG_INFO("incoming RSCN, trying to open "
+					      "port 0x%016Lx\n", port->wwpn);
 				debug_text_event(adapter->erp_dbf, 1,
 						 "unsol_els_rscnk:");
 				zfcp_test_link(port);
@@ -1748,10 +1679,8 @@
 	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
 
 	if (!port || (port->wwpn != (*(wwn_t *) & els_logi->nport_wwn))) {
-		ZFCP_LOG_DEBUG("Re-open port indication received "
-			       "for the non-existing port with D_ID "
-			       "0x%3.3x, on the adapter "
-			       "%s. Ignored.\n",
+		ZFCP_LOG_DEBUG("ignored incoming PLOGI for nonexisting port "
+			       "with d_id 0x%08x on adapter %s\n",
 			       status_buffer->d_id,
 			       zfcp_get_busid_by_adapter(adapter));
 	} else {
@@ -1779,10 +1708,8 @@
 	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
 
 	if (!port || (port->wwpn != els_logo->nport_wwpn)) {
-		ZFCP_LOG_DEBUG("Re-open port indication received "
-			       "for the non-existing port with D_ID "
-			       "0x%3.3x, on the adapter "
-			       "%s. Ignored.\n",
+		ZFCP_LOG_DEBUG("ignored incoming LOGO for nonexisting port "
+			       "with d_id 0x%08x on adapter %s\n",
 			       status_buffer->d_id,
 			       zfcp_get_busid_by_adapter(adapter));
 	} else {
@@ -1797,9 +1724,8 @@
 			      struct fsf_status_read_buffer *status_buffer)
 {
 	zfcp_in_els_dbf_event(adapter, "##undef", status_buffer, 24);
-	ZFCP_LOG_NORMAL("warning: Unknown incoming ELS (0x%x) received "
-			"for the adapter %s\n",
-			*(u32 *) (status_buffer->payload),
+	ZFCP_LOG_NORMAL("warning: unknown incoming ELS 0x%08x "
+			"for adapter %s\n", *(u32 *) (status_buffer->payload),
 			zfcp_get_busid_by_adapter(adapter));
 
 }
@@ -1845,12 +1771,10 @@
 		}
 	} else {
 		data = kmalloc(sizeof(struct zfcp_gid_pn_data), GFP_ATOMIC);
-		}
+	}
 
-        if (NULL == data){
-		ZFCP_LOG_DEBUG("Out of memory.\n");
+        if (NULL == data)
                 return -ENOMEM;
-	}
 
 	memset(data, 0, sizeof(*data));
         data->ct.req = &data->req;
@@ -1872,11 +1796,10 @@
 static void
 zfcp_gid_pn_buffers_free(struct zfcp_gid_pn_data *gid_pn)
 {
-        if ((gid_pn->ct.pool != 0)) {
+        if ((gid_pn->ct.pool != 0))
 		mempool_free(gid_pn, gid_pn->ct.pool);
-        } else {
+	else
                 kfree(gid_pn);
-	}
 
 	return;
 }
@@ -1895,11 +1818,10 @@
 
 	ret = zfcp_gid_pn_buffers_alloc(&gid_pn, adapter->pool.data_gid_pn);
 	if (ret < 0) {
-		ZFCP_LOG_INFO("error: Out of memory. Could not allocate "
-                              "buffers for nameserver request GID_PN. "
-                              "(adapter: %s)\n",
+		ZFCP_LOG_INFO("error: buffer allocation for gid_pn nameserver "
+			      "request failed for adapter %s\n",
 			      zfcp_get_busid_by_adapter(adapter));
-	goto out;
+		goto out;
 	}
 
 	/* setup nameserver request */
@@ -1923,8 +1845,8 @@
 	ret = zfcp_fsf_send_ct(&gid_pn->ct, adapter->pool.fsf_req_erp,
 			       erp_action);
 	if (ret) {
-		ZFCP_LOG_INFO("error: Could not send nameserver request GID_PN."
-                              "(adapter %s)\n",
+		ZFCP_LOG_INFO("error: initiation of gid_pn nameserver request "
+                              "failed for adapter %s\n",
 			      zfcp_get_busid_by_adapter(adapter));
 
                 zfcp_gid_pn_buffers_free(gid_pn);
@@ -1968,26 +1890,23 @@
 	}
 	/* paranoia */
 	if (ct_iu_req->wwpn != port->wwpn) {
-		ZFCP_LOG_NORMAL(
-			"bug: Port WWPN returned by nameserver lookup "
-                        "does not correspond to the expected value "
-			"(adapter: %s, debug info: 0x%016Lx, 0x%016Lx)\n",
-			zfcp_get_busid_by_port(port), port->wwpn,
-                        ct_iu_req->wwpn);
+		ZFCP_LOG_NORMAL("bug: wwpn 0x%016Lx returned by nameserver "
+				"lookup does not match expected wwpn 0x%016Lx "
+				"for adapter %s\n", ct_iu_req->wwpn, port->wwpn,
+				zfcp_get_busid_by_port(port));
 		goto failed;
 	}
 
 	/* looks like a valid d_id */
         port->d_id = ct_iu_resp->d_id & ZFCP_DID_MASK;
 	atomic_set_mask(ZFCP_STATUS_PORT_DID_DID, &port->status);
-	ZFCP_LOG_DEBUG("busid %s:  WWPN=0x%Lx ---> D_ID=0x%6.6x\n",
-		       zfcp_get_busid_by_port(port),
-		       port->wwpn, (unsigned int) port->d_id);
+	ZFCP_LOG_DEBUG("adapter %s:  wwpn=0x%016Lx ---> d_id=0x%08x\n",
+		       zfcp_get_busid_by_port(port), port->wwpn, port->d_id);
 	goto out;
 
 failed:
-	ZFCP_LOG_NORMAL("warning: WWPN 0x%Lx not found by nameserver lookup "
-			"(adapter: %s)\n",
+	ZFCP_LOG_NORMAL("warning: failed gid_pn nameserver request for wwpn "
+			"0x%016Lx for adapter %s\n",
 			port->wwpn, zfcp_get_busid_by_port(port));
 	ZFCP_LOG_DEBUG("CT IUs do not match:\n");
 	ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG, (char *) ct_iu_req,
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ccw.c linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	Fri Mar 12 20:03:36 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c	Fri Mar 12 20:03:36 2004
@@ -161,9 +161,8 @@
 
 	retval = zfcp_erp_thread_setup(adapter); 
 	if (retval) {
-		ZFCP_LOG_INFO("error: out of resources. "
-			      "error recovery thread for adapter %s "
-			      "could not be started\n",
+		ZFCP_LOG_INFO("error: start of error recovery thread for "
+			      "adapter %s failed\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		goto out;
 	}
@@ -225,15 +224,15 @@
 	adapter = dev_get_drvdata(&ccw_device->dev);
 	switch (event) {
 	case CIO_GONE:
-		ZFCP_LOG_NORMAL("Adapter %s: device gone.\n",
+		ZFCP_LOG_NORMAL("adapter %s: device gone\n",
 				zfcp_get_busid_by_adapter(adapter));
 		break;
 	case CIO_NO_PATH:
-		ZFCP_LOG_NORMAL("Adapter %s: no path.\n",
+		ZFCP_LOG_NORMAL("adapter %s: no path\n",
 				zfcp_get_busid_by_adapter(adapter));
 		break;
 	case CIO_OPER:
-		ZFCP_LOG_NORMAL("Adapter %s: operational again.\n",
+		ZFCP_LOG_NORMAL("adapter %s: operational again\n",
 				zfcp_get_busid_by_adapter(adapter));
 		zfcp_erp_modify_adapter_status(adapter,
 					       ZFCP_STATUS_COMMON_RUNNING,
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Fri Mar 12 20:03:36 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Fri Mar 12 20:03:36 2004
@@ -33,7 +33,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.66 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.67 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -1037,7 +1037,6 @@
 						  refcount drop to zero */
 	struct zfcp_port       *port;	       /* remote port of unit */
 	atomic_t	       status;	       /* status of this logical unit */
-	u32		       lun_access;     /* access flags for this unit */
 	scsi_lun_t	       scsi_lun;       /* own SCSI LUN */
 	fcp_lun_t	       fcp_lun;	       /* own FCP_LUN */
 	u32		       handle;	       /* handle assigned by FSF */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Thu Mar 11 03:55:23 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Fri Mar 12 20:03:36 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.44 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.45 $"
 
 #include "zfcp_ext.h"
 
@@ -159,31 +159,6 @@
 }
 
 /*
- * function:     zfcp_erp_scsi_low_mem_buffer_timeout_handler
- *
- * purpose:      This function needs to be called whenever the SCSI command
- *               in the low memory buffer does not return.
- *               Re-opening the adapter means that the command can be returned
- *               by zfcp (it is guarranteed that it does not return via the
- *               adapter anymore). The buffer can then be used again.
- *    
- * returns:      sod all
- */
-void
-zfcp_erp_scsi_low_mem_buffer_timeout_handler(unsigned long data)
-{
-	struct zfcp_adapter *adapter = (struct zfcp_adapter *) data;
-
-	ZFCP_LOG_NORMAL("warning: Emergency buffer for SCSI I/O timed out. "
-			"Restarting all operations on the adapter %s.\n",
-			zfcp_get_busid_by_adapter(adapter));
-	debug_text_event(adapter->erp_dbf, 1, "scsi_lmem_tout");
-	zfcp_erp_adapter_reopen(adapter, 0);
-
-	return;
-}
-
-/*
  * function:	zfcp_fsf_scsi_er_timeout_handler
  *
  * purpose:     This function needs to be called whenever a SCSI error recovery
@@ -199,10 +174,9 @@
 {
 	struct zfcp_adapter *adapter = (struct zfcp_adapter *) data;
 
-	ZFCP_LOG_NORMAL
-	    ("warning: Emergency buffer for SCSI error handling timed out. "
-	     "Restarting all operations on the adapter %s.\n",
-	     zfcp_get_busid_by_adapter(adapter));
+	ZFCP_LOG_NORMAL("warning: SCSI error recovery timed out. "
+			"Restarting all operations on the adapter %s\n",
+			zfcp_get_busid_by_adapter(adapter));
 	debug_text_event(adapter->erp_dbf, 1, "eh_lmem_tout");
 	zfcp_erp_adapter_reopen(adapter, 0);
 
@@ -225,13 +199,13 @@
 	int retval;
 
 	debug_text_event(adapter->erp_dbf, 5, "a_ro");
-	ZFCP_LOG_DEBUG("Reopen on the adapter %s.\n",
+	ZFCP_LOG_DEBUG("reopen adapter %s\n",
 		       zfcp_get_busid_by_adapter(adapter));
 
 	zfcp_erp_adapter_block(adapter, clear_mask);
 
 	if (atomic_test_mask(ZFCP_STATUS_COMMON_ERP_FAILED, &adapter->status)) {
-		ZFCP_LOG_DEBUG("skipped reopen on the failed adapter %s.\n",
+		ZFCP_LOG_DEBUG("skipped reopen of failed adapter %s\n",
 			       zfcp_get_busid_by_adapter(adapter));
 		debug_text_event(adapter->erp_dbf, 5, "a_ro_f");
 		/* ensure propagation of failed status to new devices */
@@ -390,9 +364,8 @@
 	case ZFCP_LS_RTV:
 		send_els->req->length = sizeof(struct zfcp_ls_rtv);
 		send_els->resp->length = sizeof(struct zfcp_ls_rtv_acc);
-		ZFCP_LOG_NORMAL(
-			"RTV request from sid 0x%06x to did 0x%06x\n",
-			port->adapter->s_id, port->d_id);
+		ZFCP_LOG_INFO("RTV request from s_id 0x%08x to d_id 0x%08x\n",
+			      port->adapter->s_id, port->d_id);
 		break;
 
 	case ZFCP_LS_RLS:
@@ -400,10 +373,9 @@
 		send_els->resp->length = sizeof(struct zfcp_ls_rls_acc);
 		rls = (struct zfcp_ls_rls*)req;
 		rls->port_id = port->adapter->s_id;
-		ZFCP_LOG_NORMAL(
-			"RLS request from sid 0x%06x to did 0x%06x "
-			"with payload(port_id=0x%06x)\n",
-			port->adapter->s_id, port->d_id, rls->port_id);
+		ZFCP_LOG_INFO("RLS request from s_id 0x%08x to d_id 0x%08x "
+			      "(port_id=0x%08x)\n",
+			      port->adapter->s_id, port->d_id, rls->port_id);
 		break;
 
 	case ZFCP_LS_PDISC:
@@ -412,11 +384,10 @@
 		pdisc = (struct zfcp_ls_pdisc*)req;
 		pdisc->wwpn = port->adapter->wwpn;
 		pdisc->wwnn = port->adapter->wwnn;
-		ZFCP_LOG_NORMAL(
-			"PDISC request from sid 0x%06x to did 0x%06x "
-			"with payload(wwpn=0x%016Lx wwnn=0x%016Lx)\n",
-			port->adapter->s_id, port->d_id,
-			pdisc->wwpn, pdisc->wwnn);
+		ZFCP_LOG_INFO("PDISC request from s_id 0x%08x to d_id 0x%08x "
+			      "(wwpn=0x%016Lx, wwnn=0x%016Lx)\n",
+			      port->adapter->s_id, port->d_id,
+			      pdisc->wwpn, pdisc->wwnn);
 		break;
 
 	case ZFCP_LS_ADISC:
@@ -427,35 +398,33 @@
 		adisc->wwpn = port->adapter->wwpn;
 		adisc->wwnn = port->adapter->wwnn;
 		adisc->nport_id = port->adapter->s_id;
-		ZFCP_LOG_NORMAL(
-			"ADISC request from sid 0x%06x to did 0x%06x "
-			"with payload(wwpn=0x%016Lx wwnn=0x%016Lx "
-			"hard_nport_id=0x%06x nport_id=0x%06x)\n",
-			port->adapter->s_id, port->d_id,
-			adisc->wwpn, adisc->wwnn,
-			adisc->hard_nport_id, adisc->nport_id);
+		ZFCP_LOG_INFO("ADISC request from s_id 0x%08x to d_id 0x%08x "
+			      "(wwpn=0x%016Lx, wwnn=0x%016Lx, "
+			      "hard_nport_id=0x%08x, nport_id=0x%08x)\n",
+			      port->adapter->s_id, port->d_id,
+			      adisc->wwpn, adisc->wwnn,
+			      adisc->hard_nport_id, adisc->nport_id);
 		break;
 
 	default:
-		ZFCP_LOG_NORMAL(
-			"ELS command code 0x%02x is not supported\n", ls_code);
+		ZFCP_LOG_NORMAL("ELS command code 0x%02x is not supported\n",
+				ls_code);
 		retval = -EINVAL;
 		goto invalid_ls_code;
 	}
 
 	retval = zfcp_fsf_send_els(send_els);
 	if (retval != 0) {
-		ZFCP_LOG_NORMAL(
-			"ELS request could not be processed "
-			"(sid=0x%06x did=0x%06x)\n",
-			port->adapter->s_id, port->d_id);
+		ZFCP_LOG_NORMAL("error: initiation of Send ELS failed for port "
+				"0x%016Lx on adapter %s\n",
+				port->wwpn, zfcp_get_busid_by_port(port));
 		retval = -EPERM;
 	}
 
 	goto out;
 
 nomem:
-	ZFCP_LOG_INFO("Out of memory!\n");
+	ZFCP_LOG_DEBUG("out of memory\n");
 	retval = -ENOMEM;
 
 invalid_ls_code:
@@ -513,68 +482,53 @@
 		switch (rjt->reason_code) {
 
 		case ZFCP_LS_RJT_INVALID_COMMAND_CODE:
-			ZFCP_LOG_NORMAL(
-				"Invalid command code "
-				"(wwpn=0x%016Lx command=0x%02x)\n",
-				(unsigned long long)port->wwpn,
-				req_code);
+			ZFCP_LOG_INFO("invalid LS command code "
+				      "(wwpn=0x%016Lx, command=0x%02x)\n",
+				      port->wwpn, req_code);
 			break;
 
 		case ZFCP_LS_RJT_LOGICAL_ERROR:
-			ZFCP_LOG_NORMAL(
-				"Logical error "
-				"(wwpn=0x%016Lx reason_explanation=0x%02x)\n",
-				(unsigned long long)port->wwpn,
-				rjt->reason_expl);
+			ZFCP_LOG_INFO("logical error (wwpn=0x%016Lx, "
+				      "reason_expl=0x%02x)\n",
+				      port->wwpn, rjt->reason_expl);
 			break;
 
 		case ZFCP_LS_RJT_LOGICAL_BUSY:
-			ZFCP_LOG_NORMAL(
-				"Logical busy "
-				"(wwpn=0x%016Lx reason_explanation=0x%02x)\n",
-				(unsigned long long)port->wwpn,
-				rjt->reason_expl);
+			ZFCP_LOG_INFO("logical busy (wwpn=0x%016Lx, "
+				      "reason_expl=0x%02x)\n",
+				      port->wwpn, rjt->reason_expl);
 			break;
 
 		case ZFCP_LS_RJT_PROTOCOL_ERROR:
-			ZFCP_LOG_NORMAL(
-				"Protocol error "
-				"(wwpn=0x%016Lx reason_explanation=0x%02x)\n",
-				(unsigned long long)port->wwpn,
-				rjt->reason_expl);
+			ZFCP_LOG_INFO("protocol error (wwpn=0x%016Lx, "
+				      "reason_expl=0x%02x)\n",
+				      port->wwpn, rjt->reason_expl);
 			break;
 
 		case ZFCP_LS_RJT_UNABLE_TO_PERFORM:
-			ZFCP_LOG_NORMAL(
-				"Unable to perform command requested "
-				"(wwpn=0x%016Lx reason_explanation=0x%02x)\n",
-				(unsigned long long)port->wwpn,
-				rjt->reason_expl);
+			ZFCP_LOG_INFO("unable to perform command requested "
+				      "(wwpn=0x%016Lx, reason_expl=0x%02x)\n",
+				      port->wwpn, rjt->reason_expl);
 			break;
 
 		case ZFCP_LS_RJT_COMMAND_NOT_SUPPORTED:
-			ZFCP_LOG_NORMAL(
-				"Command not supported "
-				"(wwpn=0x%016Lx command=0x%02x)\n",
-				(unsigned long long)port->wwpn,
-				req_code);
+			ZFCP_LOG_INFO("command not supported (wwpn=0x%016Lx, "
+				      "command=0x%02x)\n",
+				      port->wwpn, req_code);
 			break;
 
 		case ZFCP_LS_RJT_VENDOR_UNIQUE_ERROR:
-			ZFCP_LOG_NORMAL(
-				"Vendor unique error "
-				"(wwpn=0x%016Lx vendor_unique=0x%02x)\n",
-				(unsigned long long)port->wwpn,
-				rjt->vendor_unique);
+			ZFCP_LOG_INFO("vendor specific error (wwpn=0x%016Lx, "
+				      "vendor_unique=0x%02x)\n",
+				      port->wwpn, rjt->vendor_unique);
 			break;
 
 		default:
-			ZFCP_LOG_NORMAL(
-				"ELS has been rejected by remote port "
-				"with WWPN 0x%Lx on the adapter %s "
-				"with the reason code 0x%02x\n",
-				port->wwpn, zfcp_get_busid_by_port(port),
-				rjt->reason_code);
+			ZFCP_LOG_NORMAL("ELS rejected by remote port 0x%016Lx "
+					"on adapter %s (reason_code=0x%02x)\n",
+					port->wwpn,
+					zfcp_get_busid_by_port(port),
+					rjt->reason_code);
 		}
 		retval = -ENXIO;
 		break;
@@ -584,57 +538,51 @@
 
 		case ZFCP_LS_RTV:
 			rtv = (struct zfcp_ls_rtv_acc*)resp;
-			ZFCP_LOG_NORMAL(
-				"RTV response from did 0x%06x to sid 0x%06x "
-				"with payload(R_A_TOV=%ds E_D_TOV=%d%cs)\n",
-				port->d_id, port->adapter->s_id,
-				rtv->r_a_tov, rtv->e_d_tov,
-				rtv->qualifier & ZFCP_LS_RTV_E_D_TOV_FLAG ?
-					'n' : 'm');
+			ZFCP_LOG_INFO("RTV response from d_id 0x%08x to s_id "
+				      "0x%08x (R_A_TOV=%ds E_D_TOV=%d%cs)\n",
+				      port->d_id, port->adapter->s_id,
+				      rtv->r_a_tov, rtv->e_d_tov,
+				      rtv->qualifier &
+				      ZFCP_LS_RTV_E_D_TOV_FLAG ? 'n' : 'm');
 			break;
 
 		case ZFCP_LS_RLS:
 			rls = (struct zfcp_ls_rls_acc*)resp;
-			ZFCP_LOG_NORMAL(
-				"RLS response from did 0x%06x to sid 0x%06x "
-				"with payload(link_failure_count=%u "
-				"loss_of_sync_count=%u "
-				"loss_of_signal_count=%u "
-				"primitive_sequence_protocol_error=%u "
-				"invalid_transmition_word=%u "
-				"invalid_crc_count=%u)\n",
-				port->d_id, port->adapter->s_id,
-				rls->link_failure_count,
-				rls->loss_of_sync_count,
-				rls->loss_of_signal_count,
-				rls->prim_seq_prot_error,
-				rls->invalid_transmition_word,
-				rls->invalid_crc_count);
+			ZFCP_LOG_INFO("RLS response from d_id 0x%08x to s_id "
+				      "0x%08x (link_failure_count=%u, "
+				      "loss_of_sync_count=%u, "
+				      "loss_of_signal_count=%u, "
+				      "primitive_sequence_protocol_error=%u, "
+				      "invalid_transmition_word=%u, "
+				      "invalid_crc_count=%u)\n",
+				      port->d_id, port->adapter->s_id,
+				      rls->link_failure_count,
+				      rls->loss_of_sync_count,
+				      rls->loss_of_signal_count,
+				      rls->prim_seq_prot_error,
+				      rls->invalid_transmition_word,
+				      rls->invalid_crc_count);
 			break;
 
 		case ZFCP_LS_PDISC:
 			pdisc = (struct zfcp_ls_pdisc_acc*)resp;
-			ZFCP_LOG_NORMAL(
-				"PDISC response from did 0x%06x to sid 0x%06x "
-				"with payload(wwpn=0x%016Lx wwnn=0x%016Lx "
-				"vendor='%-16s')\n",
-				port->d_id, port->adapter->s_id,
-				(unsigned long long)pdisc->wwpn,
-				(unsigned long long)pdisc->wwnn,
-				pdisc->vendor_version);
+			ZFCP_LOG_INFO("PDISC response from d_id 0x%08x to s_id "
+				      "0x%08x (wwpn=0x%016Lx, wwnn=0x%016Lx, "
+				      "vendor='%-16s')\n", port->d_id,
+				      port->adapter->s_id, pdisc->wwpn,
+				      pdisc->wwnn, pdisc->vendor_version);
 			break;
 
 		case ZFCP_LS_ADISC:
 			adisc = (struct zfcp_ls_adisc_acc*)resp;
-			ZFCP_LOG_NORMAL(
-				"ADISC response from did 0x%06x to sid 0x%06x "
-				"with payload(wwpn=0x%016Lx wwnn=0x%016Lx "
-				"hard_nport_id=0x%06x nport_id=0x%06x)\n",
-				port->d_id, port->adapter->s_id,
-				(unsigned long long)adisc->wwpn,
-				(unsigned long long)adisc->wwnn,
-				adisc->hard_nport_id, adisc->nport_id);
-			/* FIXME: missing wwnn value in port struct */
+			ZFCP_LOG_INFO("ADISC response from d_id 0x%08x to s_id "
+				      "0x%08x (wwpn=0x%016Lx, wwnn=0x%016Lx, "
+				      "hard_nport_id=0x%08x, "
+				      "nport_id=0x%08x)\n", port->d_id,
+				      port->adapter->s_id, adisc->wwpn,
+				      adisc->wwnn, adisc->hard_nport_id,
+				      adisc->nport_id);
+			/* FIXME: set wwnn in during open port */
 			if (port->wwnn == 0)
 				port->wwnn = adisc->wwnn;
 			break;
@@ -642,17 +590,16 @@
 		break;
 
 	default:
-		ZFCP_LOG_NORMAL(
-			"Unknown payload code 0x%02x received on a request "
-			"0x%02x from sid 0x%06x to did 0x%06x, "
-			"port needs to be reopened\n",
-			req_code, resp_code, port->adapter->s_id, port->d_id);
+		ZFCP_LOG_NORMAL("unknown payload code 0x%02x received for "
+				"request 0x%02x to d_id 0x%08x, reopen needed "
+				"for port 0x%016Lx on adapter %s\n", resp_code,
+				req_code, port->d_id,  port->wwpn,
+				zfcp_get_busid_by_port(port));
 		retval = zfcp_erp_port_forced_reopen(port, 0);
 		if (retval != 0) {
-			ZFCP_LOG_NORMAL(
-				"Cannot reopen a remote port "
-				"with WWPN 0x%Lx on the adapter %s\n",
-				port->wwpn, zfcp_get_busid_by_port(port));
+			ZFCP_LOG_NORMAL("reopen of remote port 0x%016Lx on "
+					"adapter %s failed\n", port->wwpn,
+					zfcp_get_busid_by_port(port));
 			retval = -EPERM;
 		}
 	}
@@ -681,16 +628,14 @@
 
 	retval = zfcp_els(port, ZFCP_LS_ADISC);
 	if (retval != 0) {
-		ZFCP_LOG_NORMAL(
-			"Port with WWPN 0x%Lx on the adapter %s "
-			"needs to be reopened\n",
-			port->wwpn, zfcp_get_busid_by_port(port));
+		ZFCP_LOG_NORMAL("reopen needed for port 0x%016Lx "
+				"on adapter %s\n ", port->wwpn,
+				zfcp_get_busid_by_port(port));
 		retval = zfcp_erp_port_forced_reopen(port, 0);
 		if (retval != 0) {
-			ZFCP_LOG_NORMAL(
-				"Cannot reopen a remote port "
-				"with WWPN 0x%Lx on the adapter %s\n",
-				port->wwpn, zfcp_get_busid_by_port(port));
+			ZFCP_LOG_NORMAL("reopen of remote port 0x%016Lx "
+					"on adapter %s failed\n", port->wwpn,
+					zfcp_get_busid_by_port(port));
 			retval = -EPERM;
 		}
 	}
@@ -718,16 +663,15 @@
 	debug_text_event(adapter->erp_dbf, 5, "pf_ro");
 	debug_event(adapter->erp_dbf, 5, &port->wwpn, sizeof (wwn_t));
 
-	ZFCP_LOG_DEBUG("Forced reopen of the port with WWPN 0x%Lx "
-		       "on the adapter %s.\n",
+	ZFCP_LOG_DEBUG("forced reopen of port 0x%016Lx on adapter %s\n",
 		       port->wwpn, zfcp_get_busid_by_port(port));
 
 	zfcp_erp_port_block(port, clear_mask);
 
 	if (atomic_test_mask(ZFCP_STATUS_COMMON_ERP_FAILED, &port->status)) {
-		ZFCP_LOG_DEBUG("skipped forced reopen on the failed port "
-			       "with WWPN 0x%Lx on the adapter %s.\n",
-			       port->wwpn, zfcp_get_busid_by_port(port));
+		ZFCP_LOG_DEBUG("skipped forced reopen of failed port 0x%016Lx "
+			       "on adapter %s\n", port->wwpn,
+			       zfcp_get_busid_by_port(port));
 		debug_text_event(adapter->erp_dbf, 5, "pf_ro_f");
 		debug_event(adapter->erp_dbf, 5, &port->wwpn, sizeof (wwn_t));
 		retval = -EIO;
@@ -786,17 +730,15 @@
 	debug_text_event(adapter->erp_dbf, 5, "p_ro");
 	debug_event(adapter->erp_dbf, 5, &port->wwpn, sizeof (wwn_t));
 
-	ZFCP_LOG_DEBUG("Reopen of the port with WWPN 0x%Lx "
-		       "on the adapter %s.\n",
+	ZFCP_LOG_DEBUG("reopen of port 0x%016Lx on adapter %s\n",
 		       port->wwpn, zfcp_get_busid_by_port(port));
 
 	zfcp_erp_port_block(port, clear_mask);
 
 	if (atomic_test_mask(ZFCP_STATUS_COMMON_ERP_FAILED, &port->status)) {
-		ZFCP_LOG_DEBUG
-		    ("skipped reopen on the failed port with WWPN 0x%Lx "
-		     "on the adapter %s.\n", port->wwpn,
-		     zfcp_get_busid_by_port(port));
+		ZFCP_LOG_DEBUG("skipped reopen of failed port 0x%016Lx "
+			       "on adapter %s\n", port->wwpn,
+			       zfcp_get_busid_by_port(port));
 		debug_text_event(adapter->erp_dbf, 5, "p_ro_f");
 		debug_event(adapter->erp_dbf, 5, &port->wwpn, sizeof (wwn_t));
 		/* ensure propagation of failed status to new devices */
@@ -855,20 +797,17 @@
 
 	debug_text_event(adapter->erp_dbf, 5, "u_ro");
 	debug_event(adapter->erp_dbf, 5, &unit->fcp_lun, sizeof (fcp_lun_t));
-	ZFCP_LOG_DEBUG("Reopen of the unit with FCP LUN 0x%Lx on the "
-		       "port with WWPN 0x%Lx "
-		       "on the adapter %s.\n",
-		       unit->fcp_lun,
+	ZFCP_LOG_DEBUG("reopen of unit 0x%016Lx on port 0x%016Lx "
+		       "on adapter %s\n", unit->fcp_lun,
 		       unit->port->wwpn, zfcp_get_busid_by_unit(unit));
 
 	zfcp_erp_unit_block(unit, clear_mask);
 
 	if (atomic_test_mask(ZFCP_STATUS_COMMON_ERP_FAILED, &unit->status)) {
-		ZFCP_LOG_DEBUG
-		    ("skipped reopen on the failed unit with FCP LUN 0x%Lx "
-		     "on the port with WWPN 0x%Lx " "on the adapter %s.\n",
-		     unit->fcp_lun, unit->port->wwpn,
-		     zfcp_get_busid_by_unit(unit));
+		ZFCP_LOG_DEBUG("skipped reopen of failed unit 0x%016Lx "
+			       "on port 0x%016Lx on adapter %s\n",
+			       unit->fcp_lun, unit->port->wwpn,
+			       zfcp_get_busid_by_unit(unit));
 		debug_text_event(adapter->erp_dbf, 5, "u_ro_f");
 		debug_event(adapter->erp_dbf, 5, &unit->fcp_lun,
 			    sizeof (fcp_lun_t));
@@ -1115,14 +1054,10 @@
 				fsf_req->status |= ZFCP_STATUS_FSFREQ_DISMISSED;
 			}
 			if (erp_action->status & ZFCP_STATUS_ERP_TIMEDOUT) {
-				ZFCP_LOG_NORMAL
-					("error: Error Recovery Procedure "
-					 "step timed out. The action flag "
-					 "is 0x%x. The FSF request "
-					 "is at 0x%lx\n",
-					 erp_action->action,
-					 (unsigned long)
-					 erp_action->fsf_req);
+				ZFCP_LOG_NORMAL("error: erp step timed out "
+						"(action=%d, fsf_req=%p)\n ",
+						erp_action->action,
+						erp_action->fsf_req);
 			}
 			/*
 			 * If fsf_req is neither dismissed nor completed
@@ -1309,9 +1244,8 @@
 
 	retval = kernel_thread(zfcp_erp_thread, adapter, SIGCHLD);
 	if (retval < 0) {
-		ZFCP_LOG_NORMAL("error: Out of resources. Could not create an "
-				"error recovery procedure thread "
-				"for the adapter %s.\n",
+		ZFCP_LOG_NORMAL("error: creation of erp thread failed for "
+				"adapter %s\n",
 				zfcp_get_busid_by_adapter(adapter));
 		debug_text_event(adapter->erp_dbf, 5, "a_thset_fail");
 	} else {
@@ -1497,11 +1431,10 @@
 		 */
 		if (adapter->erp_total_count == adapter->erp_low_mem_count) {
 			debug_text_event(adapter->erp_dbf, 3, "a_st_lowmem");
-			ZFCP_LOG_NORMAL
-				("error: Out of memory. No mempool elements "
-				 "available. Restarting IO on the adapter %s "
-				 "to free mempool.\n",
-				 zfcp_get_busid_by_adapter(adapter));
+			ZFCP_LOG_NORMAL("error: no mempool elements available, "
+					"restarting I/O on adapter %s "
+					"to free mempool\n",
+					zfcp_get_busid_by_adapter(adapter));
 			zfcp_erp_adapter_reopen_internal(adapter, 0);
 		} else {
 		debug_text_event(adapter->erp_dbf, 2, "a_st_memw");
@@ -1640,9 +1573,8 @@
 		debug_text_exception(adapter->erp_dbf, 1, "a_stda_bug");
 		debug_event(adapter->erp_dbf, 1, &erp_action->action,
 			    sizeof (int));
-		ZFCP_LOG_NORMAL("bug: Unknown error recovery procedure "
-				"action requested on the adapter %s "
-				"(debug info %d)\n",
+		ZFCP_LOG_NORMAL("bug: unknown erp action requested on "
+				"adapter %s (action=%d)\n",
 				zfcp_get_busid_by_adapter(erp_action->adapter),
 				erp_action->action);
 	}
@@ -1686,8 +1618,8 @@
 {
 	zfcp_erp_modify_adapter_status(adapter,
 				       ZFCP_STATUS_COMMON_ERP_FAILED, ZFCP_SET);
-	ZFCP_LOG_NORMAL("Adapter recovery failed on the "
-			"adapter %s.\n", zfcp_get_busid_by_adapter(adapter));
+	ZFCP_LOG_NORMAL("adapter erp failed on adapter %s\n",
+			zfcp_get_busid_by_adapter(adapter));
 	debug_text_event(adapter->erp_dbf, 2, "a_afail");
 }
 
@@ -1703,9 +1635,7 @@
 	zfcp_erp_modify_port_status(port,
 				    ZFCP_STATUS_COMMON_ERP_FAILED, ZFCP_SET);
 
-	ZFCP_LOG_NORMAL("Port recovery failed on the "
-			"port with WWPN 0x%Lx at the "
-			"adapter %s.\n",
+	ZFCP_LOG_NORMAL("port erp failed on port 0x%016Lx on adapter %s\n",
 			port->wwpn, zfcp_get_busid_by_port(port));
 	debug_text_event(port->adapter->erp_dbf, 2, "p_pfail");
 	debug_event(port->adapter->erp_dbf, 2, &port->wwpn, sizeof (wwn_t));
@@ -1723,10 +1653,8 @@
 	zfcp_erp_modify_unit_status(unit,
 				    ZFCP_STATUS_COMMON_ERP_FAILED, ZFCP_SET);
 
-	ZFCP_LOG_NORMAL("Unit recovery failed on the unit with FCP LUN 0x%Lx "
-			"connected to the port with WWPN 0x%Lx at the "
-			"adapter %s.\n",
-			unit->fcp_lun,
+	ZFCP_LOG_NORMAL("unit erp failed on unit 0x%016Lx on port 0x%016Lx "
+			" on adapter %s\n", unit->fcp_lun,
 			unit->port->wwpn, zfcp_get_busid_by_unit(unit));
 	debug_text_event(unit->port->adapter->erp_dbf, 2, "u_ufail");
 	debug_event(unit->port->adapter->erp_dbf, 2,
@@ -1885,13 +1813,10 @@
 		return 0;
 
 	if ((p = kmalloc(sizeof(*p), GFP_KERNEL)) == NULL) {
-		ZFCP_LOG_NORMAL("error: Out of resources. Could not register "
-			      "the FCP-LUN 0x%Lx connected to "
-			      "the port with WWPN 0x%Lx connected to "
-			      "the adapter %s with the SCSI stack.\n",
-			      unit->fcp_lun,
-			      unit->port->wwpn,
-			      zfcp_get_busid_by_unit(unit));
+		ZFCP_LOG_NORMAL("error: registration at SCSI stack failed for "
+				"unit 0x%016Lx on port 0x%016Lx on "
+				"adapter %s\n", unit->fcp_lun, unit->port->wwpn,
+				zfcp_get_busid_by_unit(unit));
 		atomic_set(&p->unit->scsi_add_work, 0);
 		return -ENOMEM;
 	}
@@ -2301,7 +2226,7 @@
 
 	if (retval == ZFCP_ERP_FAILED) {
 		ZFCP_LOG_INFO("Waiting to allow the adapter %s "
-			      "to recover itself\n.",
+			      "to recover itself\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		/*
 		 * SUGGESTION: substitute by
@@ -2417,25 +2342,23 @@
 	int retval_cleanup = 0;
 
 	if (atomic_test_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status)) {
-		ZFCP_LOG_NORMAL
-		    ("bug: QDIO (data transfer mechanism) start-up on "
-		     "adapter %s attempted twice. Second attempt ignored.\n",
-		     zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_NORMAL("bug: second attempt to set up QDIO on "
+				"adapter %s\n",
+				zfcp_get_busid_by_adapter(adapter));
 		goto failed_sanity;
 	}
 
 	if (qdio_establish(&adapter->qdio_init_data) != 0) {
-		ZFCP_LOG_INFO
-		    ("error: Could not establish queues for QDIO (data "
-		     "transfer mechanism) operation on adapter %s\n.",
-		     zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_INFO("error: establishment of QDIO queues failed "
+			      "on adapter %s\n.",
+			      zfcp_get_busid_by_adapter(adapter));
 		goto failed_qdio_establish;
 	}
 	ZFCP_LOG_DEBUG("queues established\n");
 
 	if (qdio_activate(adapter->ccw_device, 0) != 0) {
-		ZFCP_LOG_INFO("error: Could not activate queues for QDIO (data "
-			      "transfer mechanism) operation on adapter %s\n.",
+		ZFCP_LOG_INFO("error: activation of QDIO queues failed "
+			      "on adapter %s\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		goto failed_qdio_activate;
 	}
@@ -2451,8 +2374,8 @@
 		sbale->addr = 0;
 	}
 
-	ZFCP_LOG_TRACE("Calling do QDIO busid=%s, flags=0x%x, queue_no=%i, "
-		       "index_in_queue=%i, count=%i\n",
+	ZFCP_LOG_TRACE("calling do_QDIO on adapter %s (flags=0x%x, "
+		       "queue_no=%i, index_in_queue=%i, count=%i)\n",
 		       zfcp_get_busid_by_adapter(adapter),
 		       QDIO_FLAG_SYNC_INPUT, 0, 0, QDIO_MAX_BUFFERS_PER_Q);
 
@@ -2461,17 +2384,14 @@
 			 0, 0, QDIO_MAX_BUFFERS_PER_Q, NULL);
 
 	if (retval) {
-		ZFCP_LOG_NORMAL
-		    ("bug: QDIO (data transfer mechanism) inobund transfer "
-		     "structures could not be set-up (debug info %d)\n",
-		     retval);
+		ZFCP_LOG_NORMAL("bug: setup of QDIO failed (retval=%d)\n",
+				retval);
 		goto failed_do_qdio;
 	} else {
 		adapter->response_queue.free_index = 0;
 		atomic_set(&adapter->response_queue.free_count, 0);
-		ZFCP_LOG_DEBUG
-		    ("%i buffers successfully enqueued to response queue\n",
-		     QDIO_MAX_BUFFERS_PER_Q);
+		ZFCP_LOG_DEBUG("%i buffers successfully enqueued to "
+			       "response queue\n", QDIO_MAX_BUFFERS_PER_Q);
 	}
 	/* set index of first avalable SBALS / number of available SBALS */
 	adapter->request_queue.free_index = 0;
@@ -2496,9 +2416,8 @@
 	retval_cleanup = qdio_shutdown(adapter->ccw_device,
 				       QDIO_FLAG_CLEANUP_USING_CLEAR);
 	if (retval_cleanup) {
-		ZFCP_LOG_NORMAL
-		    ("bug: Could not clean QDIO (data transfer mechanism) "
-		     "queues. (debug info %i).\n", retval_cleanup);
+		ZFCP_LOG_NORMAL("bug: shutdown of QDIO queues failed "
+				"(retval=%d)\n", retval_cleanup);
 	}
 #ifdef ZFCP_DEBUG_REQUESTS
 	else
@@ -2532,9 +2451,8 @@
 	struct zfcp_adapter *adapter = erp_action->adapter;
 
 	if (!atomic_test_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status)) {
-		ZFCP_LOG_DEBUG("Termination of QDIO (data transfer operation) "
-			       "attempted for an inactive qdio on the "
-			       "adapter %s....ignored.\n",
+		ZFCP_LOG_DEBUG("error: attempt to shut down inactive QDIO "
+			       "queues on adapter %s\n",
 			       zfcp_get_busid_by_adapter(adapter));
 		retval = ZFCP_ERP_FAILED;
 		goto out;
@@ -2571,10 +2489,9 @@
 		 * FIXME(design):
 		 * What went wrong? What to do best? Proper retval?
 		 */
-		ZFCP_LOG_NORMAL
-		    ("error: Clean-up of QDIO (data transfer mechanism) "
-		     "structures failed for adapter %s.\n",
-		     zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_NORMAL("bug: shutdown of QDIO queues failed on "
+				"adapter %s\n",
+				zfcp_get_busid_by_adapter(adapter));
 	} else {
 		ZFCP_LOG_DEBUG("queues cleaned up\n");
 #ifdef ZFCP_DEBUG_REQUESTS
@@ -2657,10 +2574,9 @@
 		if (zfcp_fsf_exchange_config_data(erp_action)) {
 			retval = ZFCP_ERP_FAILED;
 			debug_text_event(adapter->erp_dbf, 5, "a_fstx_xf");
-			ZFCP_LOG_INFO("error: Out of resources. Could not "
-				      "start exchange of configuration data "
-				      "between the adapter %s "
-				      "and the device driver.\n",
+			ZFCP_LOG_INFO("error:  initiation of exchange of "
+				      "configuration data failed for "
+				      "adapter %s\n",
 				      zfcp_get_busid_by_adapter(adapter));
 			break;
 		}
@@ -2682,17 +2598,15 @@
 		 */
 		down_interruptible(&adapter->erp_ready_sem);
 		if (erp_action->status & ZFCP_STATUS_ERP_TIMEDOUT) {
-			ZFCP_LOG_INFO
-			    ("error: Exchange of configuration data between "
-			     "the adapter with %s and the device "
-			     "driver timed out\n",
-			     zfcp_get_busid_by_adapter(adapter));
+			ZFCP_LOG_INFO("error: exchange of configuration data "
+				      "for adapter %s timed out\n",
+				      zfcp_get_busid_by_adapter(adapter));
 			break;
 		}
 		if (atomic_test_mask(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
 				     &adapter->status)) {
-			ZFCP_LOG_DEBUG("Host connection still initialising... "
-				       "waiting and retrying....\n");
+			ZFCP_LOG_DEBUG("host connection still initialising... "
+				       "waiting and retrying...\n");
 			/* sleep a little bit before retry */
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(ZFCP_EXCHANGE_CONFIG_DATA_SLEEP);
@@ -2703,8 +2617,8 @@
 
 	if (!atomic_test_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK,
 			      &adapter->status)) {
-		ZFCP_LOG_INFO("error: Exchange of configuration data between "
-			      "the adapter %s and the device driver failed.\n",
+		ZFCP_LOG_INFO("error: exchange of configuration data for "
+			      "adapter %s failed\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		retval = ZFCP_ERP_FAILED;;
 	}
@@ -2732,10 +2646,8 @@
 	for (i = 0; i < ZFCP_STATUS_READS_RECOM; i++) {
 		temp_ret = zfcp_fsf_status_read(adapter, ZFCP_WAIT_FOR_SBAL);
 		if (temp_ret < 0) {
-			ZFCP_LOG_INFO("error: Out of resources. Could not "
-				      "set-up the infrastructure for "
-				      "unsolicited status presentation "
-				      "for the adapter %s.\n",
+			ZFCP_LOG_INFO("error: set-up of unsolicited status "
+				      "notification failed on adapter %s\n",
 				      zfcp_get_busid_by_adapter(adapter));
 			retval = ZFCP_ERP_FAILED;
 			i--;
@@ -2807,9 +2719,8 @@
 		if (atomic_test_mask((ZFCP_STATUS_PORT_PHYS_OPEN |
 				      ZFCP_STATUS_COMMON_OPEN),
 			             &port->status)) {
-			ZFCP_LOG_DEBUG("Port wwpn=0x%Lx is open -> trying "
-				       " close physical\n",
-				       port->wwpn);
+			ZFCP_LOG_DEBUG("port 0x%016Lx is open -> trying "
+				       "close physical\n", port->wwpn);
 			retval =
 			    zfcp_erp_port_forced_strategy_close(erp_action);
 		} else
@@ -2819,9 +2730,8 @@
 	case ZFCP_ERP_STEP_PHYS_PORT_CLOSING:
 		if (atomic_test_mask(ZFCP_STATUS_PORT_PHYS_OPEN,
 				     &port->status)) {
-			ZFCP_LOG_DEBUG
-				("failed to close physical port wwpn=0x%Lx\n",
-				 port->wwpn);
+			ZFCP_LOG_DEBUG("close physical failed for port "
+				       "0x%016Lx\n", port->wwpn);
 			retval = ZFCP_ERP_FAILED;
 		} else
 			retval = ZFCP_ERP_SUCCEEDED;
@@ -2861,9 +2771,8 @@
 	case ZFCP_ERP_STEP_UNINITIALIZED:
 		zfcp_erp_port_strategy_clearstati(port);
 		if (atomic_test_mask(ZFCP_STATUS_COMMON_OPEN, &port->status)) {
-			ZFCP_LOG_DEBUG
-			    ("port wwpn=0x%Lx is open -> trying close\n",
-			     port->wwpn);
+			ZFCP_LOG_DEBUG("port 0x%016Lx is open -> trying "
+				       "close\n", port->wwpn);
 			retval = zfcp_erp_port_strategy_close(erp_action);
 			goto out;
 		}		/* else it's already closed, open it */
@@ -2871,7 +2780,7 @@
 
 	case ZFCP_ERP_STEP_PORT_CLOSING:
 		if (atomic_test_mask(ZFCP_STATUS_COMMON_OPEN, &port->status)) {
-			ZFCP_LOG_DEBUG("failed to close port wwpn=0x%Lx\n",
+			ZFCP_LOG_DEBUG("close failed for port 0x%016Lx\n",
 				       port->wwpn);
 			retval = ZFCP_ERP_FAILED;
 			goto out;
@@ -2937,19 +2846,17 @@
 		if (!(adapter->nameserver_port)) {
 			retval = zfcp_nameserver_enqueue(adapter);
 			if (retval != 0) {
-				ZFCP_LOG_NORMAL
-				    ("error: nameserver port not available "
-				     "(adapter with busid %s)\n",
-				     zfcp_get_busid_by_adapter(adapter));
+				ZFCP_LOG_NORMAL("error: nameserver port "
+						"unavailable for adapter %s\n",
+						zfcp_get_busid_by_adapter(adapter));
 				retval = ZFCP_ERP_FAILED;
 				break;
 			}
 		}
 		if (!atomic_test_mask(ZFCP_STATUS_COMMON_UNBLOCKED,
 				      &adapter->nameserver_port->status)) {
-			ZFCP_LOG_DEBUG
-			    ("nameserver port is not open -> open "
-			     "nameserver port\n");
+			ZFCP_LOG_DEBUG("nameserver port is not open -> open "
+				       "nameserver port\n");
 			/* nameserver port may live again */
 			atomic_set_mask(ZFCP_STATUS_COMMON_RUNNING,
 					&adapter->nameserver_port->status);
@@ -2962,12 +2869,11 @@
 	case ZFCP_ERP_STEP_NAMESERVER_OPEN:
 		if (!atomic_test_mask(ZFCP_STATUS_COMMON_OPEN,
 				      &adapter->nameserver_port->status)) {
-			ZFCP_LOG_DEBUG("failed to open nameserver port\n");
+			ZFCP_LOG_DEBUG("open failed for nameserver port\n");
 			retval = ZFCP_ERP_FAILED;
 		} else {
 			ZFCP_LOG_DEBUG("nameserver port is open -> "
-				       "ask nameserver for current D_ID of "
-				       "port with WWPN 0x%Lx\n",
+				       "nameserver look-up for port 0x%016Lx\n",
 				       port->wwpn);
 			retval = zfcp_erp_port_strategy_open_common_lookup
 				(erp_action);
@@ -2978,21 +2884,20 @@
 		if (!atomic_test_mask(ZFCP_STATUS_PORT_DID_DID, &port->status)) {
 			if (atomic_test_mask
 			    (ZFCP_STATUS_PORT_INVALID_WWPN, &port->status)) {
-				ZFCP_LOG_DEBUG
-				    ("failed to look up the D_ID of the port wwpn=0x%Lx "
-				     "(misconfigured WWPN?)\n", port->wwpn);
+				ZFCP_LOG_DEBUG("nameserver look-up failed "
+					       "for port 0x%016Lx "
+					       "(misconfigured WWPN?)\n",
+					       port->wwpn);
 				zfcp_erp_port_failed(port);
 				retval = ZFCP_ERP_EXIT;
 			} else {
-				ZFCP_LOG_DEBUG
-				    ("failed to look up the D_ID of the port wwpn=0x%Lx\n",
-				     port->wwpn);
+				ZFCP_LOG_DEBUG("nameserver look-up failed for "
+					       "port 0x%016Lx\n", port->wwpn);
 				retval = ZFCP_ERP_FAILED;
 			}
 		} else {
-			ZFCP_LOG_DEBUG
-			    ("port wwpn=0x%Lx has D_ID=0x%6.6x -> trying open\n",
-			     port->wwpn, (unsigned int) port->d_id);
+			ZFCP_LOG_DEBUG("port 0x%016Lx has d_id=0x%08x -> "
+				       "trying open\n", port->wwpn, port->d_id);
 			retval = zfcp_erp_port_strategy_open_port(erp_action);
 		}
 		break;
@@ -3002,17 +2907,17 @@
 		if (atomic_test_mask((ZFCP_STATUS_COMMON_OPEN |
 				      ZFCP_STATUS_PORT_DID_DID),
 				     &port->status)) {
-			ZFCP_LOG_DEBUG("port wwpn=0x%Lx is open\n", port->wwpn);
+			ZFCP_LOG_DEBUG("port 0x%016Lx is open\n", port->wwpn);
 			retval = ZFCP_ERP_SUCCEEDED;
 		} else {
-			ZFCP_LOG_DEBUG("failed to open port wwpn=0x%Lx\n",
+			ZFCP_LOG_DEBUG("open failed for port 0x%016Lx\n",
 				       port->wwpn);
 			retval = ZFCP_ERP_FAILED;
 		}
 		break;
 
 	default:
-		ZFCP_LOG_NORMAL("bug: unkown erp step 0x%x\n",
+		ZFCP_LOG_NORMAL("bug: unknown erp step 0x%08x\n",
 				erp_action->step);
 		retval = ZFCP_ERP_FAILED;
 	}
@@ -3038,9 +2943,8 @@
 	case ZFCP_ERP_STEP_UNINITIALIZED:
 	case ZFCP_ERP_STEP_PHYS_PORT_CLOSING:
 	case ZFCP_ERP_STEP_PORT_CLOSING:
-		ZFCP_LOG_DEBUG
-		    ("port wwpn=0x%Lx has D_ID=0x%6.6x -> trying open\n",
-		     port->wwpn, (unsigned int) port->d_id);
+		ZFCP_LOG_DEBUG("port 0x%016Lx has d_id=0x%08x -> trying open\n",
+			       port->wwpn, port->d_id);
 		retval = zfcp_erp_port_strategy_open_port(erp_action);
 		break;
 
@@ -3049,7 +2953,7 @@
 			ZFCP_LOG_DEBUG("nameserver port is open\n");
 			retval = ZFCP_ERP_SUCCEEDED;
 		} else {
-			ZFCP_LOG_DEBUG("failed to open nameserver port\n");
+			ZFCP_LOG_DEBUG("open failed for nameserver port\n");
 			retval = ZFCP_ERP_FAILED;
 		}
 		/* this is needed anyway (dont care for retval of wakeup) */
@@ -3058,7 +2962,7 @@
 		break;
 
 	default:
-		ZFCP_LOG_NORMAL("bug: unkown erp step 0x%x\n",
+		ZFCP_LOG_NORMAL("bug: unknown erp step 0x%08x\n",
 				erp_action->step);
 		retval = ZFCP_ERP_FAILED;
 	}
@@ -3304,25 +3208,23 @@
 	case ZFCP_ERP_STEP_UNINITIALIZED:
 		zfcp_erp_unit_strategy_clearstati(unit);
 		if (atomic_test_mask(ZFCP_STATUS_COMMON_OPEN, &unit->status)) {
-			ZFCP_LOG_DEBUG
-			    ("unit fcp_lun=0x%Lx is open -> trying close\n",
-			     unit->fcp_lun);
+			ZFCP_LOG_DEBUG("unit 0x%016Lx is open -> "
+				       "trying close\n", unit->fcp_lun);
 			retval = zfcp_erp_unit_strategy_close(erp_action);
 			break;
 		}
 		/* else it's already closed, fall through */
 	case ZFCP_ERP_STEP_UNIT_CLOSING:
 		if (atomic_test_mask(ZFCP_STATUS_COMMON_OPEN, &unit->status)) {
-			ZFCP_LOG_DEBUG("failed to close unit fcp_lun=0x%Lx\n",
+			ZFCP_LOG_DEBUG("close failed for unit 0x%016Lx\n",
 				       unit->fcp_lun);
 			retval = ZFCP_ERP_FAILED;
 		} else {
 			if (erp_action->status & ZFCP_STATUS_ERP_CLOSE_ONLY)
 				retval = ZFCP_ERP_EXIT;
 			else {
-				ZFCP_LOG_DEBUG("unit fcp_lun=0x%Lx is not "
-					       "open -> trying open\n",
-					       unit->fcp_lun);
+				ZFCP_LOG_DEBUG("unit 0x%016Lx is not open -> "
+					       "trying open\n", unit->fcp_lun);
 				retval =
 				    zfcp_erp_unit_strategy_open(erp_action);
 			}
@@ -3331,11 +3233,11 @@
 
 	case ZFCP_ERP_STEP_UNIT_OPENING:
 		if (atomic_test_mask(ZFCP_STATUS_COMMON_OPEN, &unit->status)) {
-			ZFCP_LOG_DEBUG("unit fcp_lun=0x%Lx is open\n",
+			ZFCP_LOG_DEBUG("unit 0x%016Lx is open\n",
 				       unit->fcp_lun);
 			retval = ZFCP_ERP_SUCCEEDED;
 		} else {
-			ZFCP_LOG_DEBUG("failed to open unit fcp_lun=0x%Lx\n",
+			ZFCP_LOG_DEBUG("open failed for unit 0x%016Lx\n",
 				       unit->fcp_lun);
 			retval = ZFCP_ERP_FAILED;
 		}
@@ -3572,9 +3474,8 @@
 	default:
 		debug_text_exception(adapter->erp_dbf, 1, "a_actenq_bug");
 		debug_event(adapter->erp_dbf, 1, &action, sizeof (int));
-		ZFCP_LOG_NORMAL("bug: Unknown error recovery procedure "
-				"action requested on the adapter %s "
-				"(debug info %d)\n",
+		ZFCP_LOG_NORMAL("bug: unknown erp action requested "
+				"on adapter %s (action=%d)\n",
 				zfcp_get_busid_by_adapter(adapter), action);
 		goto out;
 	}
@@ -3584,8 +3485,8 @@
 		debug_text_event(adapter->erp_dbf, 4, "a_actenq_str");
 		debug_event(adapter->erp_dbf, 4, &stronger_action,
 			    sizeof (int));
-		ZFCP_LOG_DEBUG("shortcut: need erp action %i before "
-			       "erp action %i (adapter busid=%s)\n",
+		ZFCP_LOG_DEBUG("stronger erp action %d needed before "
+			       "erp action %d on adapter %s\n",
 			       stronger_action, action,
 			       zfcp_get_busid_by_adapter(adapter));
 		action = stronger_action;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	Fri Mar 12 20:03:36 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h	Fri Mar 12 20:03:36 2004
@@ -31,7 +31,7 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_EXT_REVISION "$Revision: 1.46 $"
+#define ZFCP_EXT_REVISION "$Revision: 1.47 $"
 
 #include "zfcp_def.h"
 
@@ -152,7 +152,6 @@
 extern int  zfcp_erp_unit_shutdown(struct zfcp_unit *, int);
 extern void zfcp_erp_unit_failed(struct zfcp_unit *);
 
-extern void zfcp_erp_scsi_low_mem_buffer_timeout_handler(unsigned long);
 extern int  zfcp_erp_thread_setup(struct zfcp_adapter *);
 extern int  zfcp_erp_thread_kill(struct zfcp_adapter *);
 extern int  zfcp_erp_wait(struct zfcp_adapter *);
