Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSJYWVB>; Fri, 25 Oct 2002 18:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSJYWUu>; Fri, 25 Oct 2002 18:20:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:27369 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261659AbSJYWQV>;
	Fri, 25 Oct 2002 18:16:21 -0400
Date: Fri, 25 Oct 2002 15:22:26 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 3/6 2.5.44 scsi multi-path IO - mid layer changes
Message-ID: <20021025152226.C17527@eng2.beaverton.ibm.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20021025152116.A17462@eng2.beaverton.ibm.com> <20021025152149.A17527@eng2.beaverton.ibm.com> <20021025152208.B17527@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021025152208.B17527@eng2.beaverton.ibm.com>; from patman on Fri, Oct 25, 2002 at 03:22:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI mid-layer multi-path IO changes

 drivers/scsi/scsi_paths.h |  146 ++++++++++++++++
 drivers/scsi/scsi_proc.c  |    8 
 drivers/scsi/scsi_scan.c  |  408 +++++++++++++++++++++++++++-------------------
 drivers/scsi/scsi_syms.c  |    7 
 include/scsi/scsi.h       |   23 ++
 5 files changed, 422 insertions(+), 170 deletions(-)

diff -Nru a/drivers/scsi/scsi_paths.h b/drivers/scsi/scsi_paths.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/scsi/scsi_paths.h	Fri Oct 25 11:26:48 2002
@@ -0,0 +1,146 @@
+/*
+ * Scsi Multi-path Support Library
+ *
+ * Copyright (c) 2002 IBM
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <patmans@us.ibm.com> and/or andmike@us.ibm.com
+ */
+
+#ifndef _SCSI_PATHS_H
+#define _SCSI_PATHS_H
+
+#include <linux/list.h>
+/*
+ * XXX asm/mmzone.h holds the xxx_to_nid and other information needed, but
+ * right now it is x86 specific, as well as patch specific, so a way is
+ * needed to correctly include it (rather than conditionally). The
+ * asm-i386 mmzone.h is created as part of the topo patch, and xxx_to_nid
+ * api's are added by pdorwin patch. The following is ugly and not even
+ * correct, since CONFIG_X86_NUMAQ means build for IBM NUMAQ box, it does
+ * not mean the API or even asm/mmzone.h exist.
+ */
+#ifdef CONFIG_X86_NUMAQ
+#include <asm/mmzone.h>
+#endif
+
+
+#if !defined(MAX_NUMNODES) || (MAX_NUMNODES == 0)
+#error Undefined or unexpected value of MAX_NUMNODES
+#endif
+
+#if MAX_NUMNODES == 1
+/*
+ * No NUMA support is configured or no NUMA patches. Use one
+ * last active pointer (SCSI_MAX_ACTIVE_LIST), and have one
+ * (SCSI_PATHS_MAX_PATH_LISTS) list of active paths.
+ */
+#define SCSI_MAX_ACTIVE_LIST	1
+#define SCSI_PATHS_MAX_PATH_LISTS	1
+#define req_to_nid(req)	0
+#define scsihost_to_node(host)	0
+#define	page_to_nid(page)	0
+#else
+/*
+ * NUMA support is configured, use one last active pointer per maximum
+ * number of nodes plus one last active pointer for all paths
+ * (SCSI_MAX_ACTIVE_LIST), and have two lists of paths
+ * (SCSI_PATHS_MAX_PATH_LISTS) - one for all paths and one for node local
+ * paths.
+ */
+#define SCSI_MAX_ACTIVE_LIST	(MAX_NUMNODES + 1)
+#define SCSI_PATHS_MAX_PATH_LISTS	2
+
+/*
+ * XXX use a real page_to_nid() API.
+ */
+#define page_to_nid(page) pfn_to_nid(page_to_pfn(page))
+/*
+ * FIXME This does not properly handle requests with req->bio NULL, these are
+ * generated via scsi_do_req calls. Fix this by putting a node number in the
+ * request, and have scsi_do_req() and __make_request() set req->node.
+ */
+#define req_to_nid(req)	\
+	(((req)->bio == NULL) ? 0 : page_to_nid(bio_page((req)->bio)))
+#endif
+
+#define SCSI_PATHS_ALL_LIST	(SCSI_MAX_ACTIVE_LIST - 1)
+
+#define SCSI_ALL_ACTIVE_NEXT_LIST	0
+#define SCSI_NID_ACTIVE_NEXT_LIST	1
+
+/**
+ * enum scsi_path_policy - Path selection policy.
+ * @SCSI_PATH_POLICY_LPU: Use the same path that was used for the last IO
+ * @SCSI_PATH_POLICY_ROUND_ROBIN: Round robin across all active paths
+ **/
+enum scsi_path_policy {
+	SCSI_PATH_POLICY_LPU = 1,
+	SCSI_PATH_POLICY_ROUND_ROBIN
+};
+
+/**
+ * enum scsi_path_state - Path state flags
+ * @SCSI_PATH_STATE_GOOD: The path is active for IO.
+ * @SCSI_PATH_STATE_FAILING: The path might be failing (XXX not fully
+ * implemented yet)
+ * @SCSI_PATH_STATE_DEAD: The path has failed.
+ **/
+enum scsi_path_state {
+	SCSI_PATH_STATE_GOOD = 1,
+	SCSI_PATH_STATE_FAILING,
+	SCSI_PATH_STATE_DEAD
+};
+
+/**
+ * struct scsi_path - A single scsi path
+ * @sp_path_list: list head for all paths
+ * @sp_active_next: circular list of all active paths, list at 0 is for all
+ * active paths, the list at 1 for all active paths on a given node id.
+ * @sp_path_id: id of path (host/channel/target/lun)
+ * @sp_state: state of path
+ * @sp_failures: number of failures on this path
+ * @sp_weight: path weight 0 best, higher values worse (XXX path weighting
+ * is not implemented, for now setting this has no affect)
+ **/
+struct scsi_path {
+	struct list_head sp_path_list;
+	struct scsi_path *sp_active_next[SCSI_PATHS_MAX_PATH_LISTS];
+	struct scsi_path_id sp_path_id;
+	enum scsi_path_state sp_state;
+	unsigned int sp_failures;
+	unsigned int sp_weight;
+};
+
+/**
+ * struct scsi_mpath - All paths for a scsi device
+ * @scsi_mp_paths: list of scsi paths
+ * @scsi_mp_last_active: last active path used, one for each node, plus
+ * one for the all active list.
+ * @scsi_mp_path_policy: path selection policy - round robin or last used
+ * @scsi_mp_path_active_cnt: number of paths XXX change to an array
+ **/
+struct scsi_mpath {
+	struct list_head scsi_mp_paths_head;
+	struct scsi_path *scsi_mp_last_active[SCSI_MAX_ACTIVE_LIST];
+	unsigned int scsi_mp_path_active_cnt[SCSI_MAX_ACTIVE_LIST];
+	enum scsi_path_policy scsi_mp_path_policy;
+};
+
+#endif
diff -Nru a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
--- a/drivers/scsi/scsi_proc.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/scsi_proc.c	Fri Oct 25 11:26:47 2002
@@ -264,15 +264,15 @@
 	return (cmdIndex);
 }
 
-void proc_print_scsidevice(Scsi_Device * scd, char *buffer, int *size, int len)
+void proc_print_scsidevice(Scsi_Device *scd, char *buffer, int *size, int len)
 {
 
 	int x, y = *size;
 	extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];
 
-	y = sprintf(buffer + len,
-	     "Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n  Vendor: ",
-		    scd->host->host_no, scd->channel, scd->id, scd->lun);
+	y = scsi_paths_proc_print_paths(scd, buffer + len,
+		"Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n");
+	y += sprintf(buffer + len + y, "Vendor: ");
 	for (x = 0; x < 8; x++) {
 		if (scd->vendor[x] >= 0x20)
 			y += sprintf(buffer + len + y, "%c", scd->vendor[x]);
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Fri Oct 25 11:26:48 2002
+++ b/drivers/scsi/scsi_scan.c	Fri Oct 25 11:26:48 2002
@@ -189,26 +189,22 @@
 	" SCSI scanning, some SCSI devices might not be configured\n"
 
 /*
- * Prefix values for the SCSI id's (stored in driverfs name field)
- */
-#define SCSI_UID_SER_NUM 'S'
-#define SCSI_UID_UNKNOWN 'Z'
-
-/*
- * Return values of some of the scanning functions.
+ * Return values for (some of) the scanning functions, these are masks.
  *
  * SCSI_SCAN_NO_RESPONSE: no valid response received from the target, this
  * includes allocation or general failures preventing IO from being sent.
  *
- * SCSI_SCAN_TARGET_PRESENT: target responded, but no device is available
- * on the given LUN.
+ * SCSI_SCAN_TARGET_PRESENT: target responded, a device may or may not be
+ * present on a given LUN in such cases.
  *
- * SCSI_SCAN_LUN_PRESENT: target responded, and a device is available on a
- * given LUN.
+ * SCSI_SCAN_LUN_PRESENT: A device is available on a given LUN.
+ *
+ * SCSI_SCAN_NEW_LUN: This is a pre-existing device with a new path.
  */
-#define SCSI_SCAN_NO_RESPONSE		0
-#define SCSI_SCAN_TARGET_PRESENT	1
-#define SCSI_SCAN_LUN_PRESENT		2
+#define SCSI_SCAN_NO_RESPONSE		0x00
+#define SCSI_SCAN_TARGET_PRESENT	0x01
+#define SCSI_SCAN_LUN_PRESENT		0x02
+#define SCSI_SCAN_NEW_LUN		0x04
 
 static char *scsi_null_device_strs = "nullnullnullnull";
 
@@ -486,9 +482,8 @@
  * scsi_alloc_sdev - allocate and setup a Scsi_Device
  *
  * Description:
- *     Allocate, initialize for io, and return a pointer to a Scsi_Device.
- *     Stores the @shost, @channel, @id, and @lun in the Scsi_Device, and
- *     adds Scsi_Device to the appropriate list.
+ *     Allocate, initialize for io, add to the device list, and return a
+ *     pointer to a Scsi_Device.
  *
  * Return value:
  *     Scsi_Device pointer, or NULL on failure.
@@ -506,10 +501,16 @@
 		sdev->vendor = scsi_null_device_strs;
 		sdev->model = scsi_null_device_strs;
 		sdev->rev = scsi_null_device_strs;
-		sdev->host = shost;
-		sdev->id = id;
-		sdev->lun = lun;
-		sdev->channel = channel;
+
+		/*
+		 * XXX move this out, if it is overly redundant; if so, be
+		 * sure to call scsi_add_path somewhere, or modify
+		 * scsi_replace_path.
+		 */
+		if (scsi_add_path(sdev, shost, channel, id, lun)) {
+			kfree(sdev);
+			return (NULL);
+		}
 		sdev->online = TRUE;
 		/*
 		 * Some low level driver could use device->type
@@ -527,45 +528,12 @@
 		scsi_initialize_merge_fn(sdev);
 		init_waitqueue_head(&sdev->scpnt_wait);
 
-		/*
-		 * Add it to the end of the shost->host_queue list.
-		 */
-		if (shost->host_queue != NULL) {
-			sdev->prev = shost->host_queue;
-			while (sdev->prev->next != NULL)
-				sdev->prev = sdev->prev->next;
-			sdev->prev->next = sdev;
-		} else
-			shost->host_queue = sdev;
-
+		scsi_add_scsi_device(sdev, shost);
 	}
 	return (sdev);
 }
 
 /**
- * scsi_free_sdev - cleanup and free a Scsi_Device
- * @sdev:	cleanup and free this Scsi_Device
- *
- * Description:
- *     Undo the actions in scsi_alloc_sdev, including removing @sdev from
- *     the list, and freeing @sdev.
- **/
-static void scsi_free_sdev(Scsi_Device *sdev)
-{
-	if (sdev->prev != NULL)
-		sdev->prev->next = sdev->next;
-	else
-		sdev->host->host_queue = sdev->next;
-	if (sdev->next != NULL)
-		sdev->next->prev = sdev->prev;
-
-	blk_cleanup_queue(&sdev->request_queue);
-	if (sdev->inquiry != NULL)
-		kfree(sdev->inquiry);
-	kfree(sdev);
-}
-
-/**
  * scsi_check_id_size - check if size fits in the driverfs name
  * @sdev:	Scsi_Device to use for error message
  * @size:	the length of the id we want to store
@@ -581,11 +549,10 @@
 static int scsi_check_id_size(Scsi_Device *sdev, int size)
 {
 	if (size > DEVICE_NAME_SIZE) {
-		printk(KERN_WARNING "scsi scan: host %d channel %d id %d lun %d"
-		       " identifier too long, length %d, max %d. Device might"
-		       " be improperly identified.\n", sdev->host->host_no,
-		       sdev->channel, sdev->id, sdev->lun, size,
-		       DEVICE_NAME_SIZE);
+		printk(KERN_WARNING "scsi scan: ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk(" identifier too long, length %d, max %d. Device might"
+		       " be improperly identified.\n", size, DEVICE_NAME_SIZE);
 		return 1;
 	} else
 		return 0;
@@ -603,7 +570,8 @@
  * Return:
  *     A pointer to data containing the results on success, else NULL.
  **/
-unsigned char *scsi_get_evpd_page(Scsi_Device *sdev, Scsi_Request *sreq)
+unsigned char *scsi_get_evpd_page(Scsi_Device *sdev, Scsi_Request *sreq,
+				  struct scsi_path_id *pathid)
 {
 	unsigned char *evpd_page;
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
@@ -611,15 +579,15 @@
 
 retry:
 	evpd_page = kmalloc(max_lgth, GFP_ATOMIC |
-			      (sdev->host->unchecked_isa_dma) ?
+			      (pathid->spi_shpnt->unchecked_isa_dma) ?
 			      GFP_DMA : 0);
 	if (!evpd_page) {
-		printk(KERN_WARNING "scsi scan: Allocation failure identifying"
-		       " host %d channel %d id %d lun %d, device might be"
-		       " improperly identified.\n", sdev->host->host_no,
-		       sdev->channel, sdev->id, sdev->lun);
+		printk(KERN_WARNING "scsi scan: Allocation failure identifying ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk("device might be improperly identified.\n");
 		return NULL;
 	}
+	memset(evpd_page, 0, max_lgth);
 
 	memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
 	scsi_cmd[0] = INQUIRY;
@@ -856,24 +824,26 @@
  *     0: Failure
  *     1: Success
  **/
-int scsi_get_deviceid(Scsi_Device *sdev, Scsi_Request *sreq)
+int scsi_get_deviceid(Scsi_Device *sdev, Scsi_Request *sreq,
+		      struct scsi_path_id *pathid)
 {
 	unsigned char *id_page;
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
 	int id_idx, scnt, ret;
 	int max_lgth = 255;
 
+
 retry:
 	id_page = kmalloc(max_lgth, GFP_ATOMIC |
-			      (sdev->host->unchecked_isa_dma) ?
+			      (pathid->spi_shpnt->unchecked_isa_dma) ?
 			      GFP_DMA : 0);
 	if (!id_page) {
-		printk(KERN_WARNING "scsi scan: Allocation failure identifying"
-		       " host %d channel %d id %d lun %d, device might be"
-		       " improperly identified.\n", sdev->host->host_no,
-		       sdev->channel, sdev->id, sdev->lun);
+		printk(KERN_WARNING "scsi scan: Allocation failure identifying ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk("device might be improperly identified.\n");
 		return 0;
 	}
+	memset(id_page, 0, max_lgth);
 
 	memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
 	scsi_cmd[0] = INQUIRY;
@@ -916,8 +886,9 @@
 				SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
 				  "scsi scan: host %d channel %d id %d lun %d"
 				  " used id desc %d/%d/%d\n",
-				  sdev->host->host_no, sdev->channel,
-				  sdev->id, sdev->lun,
+				  pathid->spi_shpnt->host_no,
+				  pathid->spi_channel, pathid->spi_id,
+				  pathid->spi_lun,
 				  id_search_list[id_idx].id_type,
 				  id_search_list[id_idx].naa_type,
 				  id_search_list[id_idx].code_set));
@@ -927,8 +898,9 @@
 				SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
 				  "scsi scan: host %d channel %d id %d lun %d"
 				  " no match/error id desc %d/%d/%d\n",
-				  sdev->host->host_no, sdev->channel,
-				  sdev->id, sdev->lun,
+				  pathid->spi_shpnt->host_no,
+				  pathid->spi_channel, pathid->spi_id,
+				  pathid->spi_lun,
 				  id_search_list[id_idx].id_type,
 				  id_search_list[id_idx].naa_type,
 				  id_search_list[id_idx].code_set));
@@ -959,7 +931,8 @@
  *     0: Failure
  *     1: Success
  **/
-int scsi_get_serialnumber(Scsi_Device *sdev, Scsi_Request *sreq)
+int scsi_get_serialnumber(Scsi_Device *sdev, Scsi_Request *sreq,
+			  struct scsi_path_id *pathid)
 {
 	unsigned char *serialnumber_page;
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
@@ -967,15 +940,15 @@
 
  retry:
 	serialnumber_page = kmalloc(max_lgth, GFP_ATOMIC |
-			      (sdev->host->unchecked_isa_dma) ?
+			      (pathid->spi_shpnt->unchecked_isa_dma) ?
 			      GFP_DMA : 0);
 	if (!serialnumber_page) {
-		printk(KERN_WARNING "scsi scan: Allocation failure identifying"
-		       " host %d channel %d id %d lun %d, device might be"
-		       " improperly identified.\n", sdev->host->host_no,
-		       sdev->channel, sdev->id, sdev->lun);
+		printk(KERN_WARNING "scsi scan: Allocation failure identifying ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk("device might be improperly identified.\n");
 		return 0;
 	}
+	memset(serialnumber_page, 0, max_lgth);
 
 	memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
 	scsi_cmd[0] = INQUIRY;
@@ -1074,14 +1047,20 @@
 {
 	unsigned char *evpd_page = NULL;
 	int cnt;
+	struct scsi_path_id pathid;
 
 	memset(sdev->sdev_driverfs_dev.name, 0, DEVICE_NAME_SIZE);
-	evpd_page = scsi_get_evpd_page(sdev, sreq);
+	if (scsi_get_path(sdev, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		scsi_get_default_name(sdev);
+		return;
+	}
+	evpd_page = scsi_get_evpd_page(sdev, sreq, &pathid);
 	if (evpd_page == NULL) {
 		/*
 		 * try to obtain serial number anyway
 		 */
-		(void)scsi_get_serialnumber(sdev, sreq);
+		(void)scsi_get_serialnumber(sdev, sreq, &pathid);
 	} else {
 		/*
 		 * XXX search high to low, since the pages are lowest to
@@ -1089,23 +1068,25 @@
 		 */
 		for(cnt = 4; cnt <= evpd_page[3] + 3; cnt++)
 			if (evpd_page[cnt] == 0x83)
-				if (scsi_get_deviceid(sdev, sreq))
+				if (scsi_get_deviceid(sdev, sreq, &pathid))
 					goto leave;
 
 		for(cnt = 4; cnt <= evpd_page[3] + 3; cnt++)
 			if (evpd_page[cnt] == 0x80)
-				if (scsi_get_serialnumber(sdev, sreq))
+				if (scsi_get_serialnumber(sdev, sreq, &pathid))
 					goto leave;
 
-		if (sdev->sdev_driverfs_dev.name[0] == 0)
-			scsi_get_default_name(sdev);
 
 	}
+	if (sdev->sdev_driverfs_dev.name[0] == 0)
+		scsi_get_default_name(sdev);
 leave:
 	if (evpd_page) kfree(evpd_page);
-	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: host %d channel %d"
-	    " id %d lun %d name/id: '%s'\n", sdev->host->host_no,
-	    sdev->channel, sdev->id, sdev->lun, sdev->sdev_driverfs_dev.name));
+	SCSI_LOG_SCAN_BUS(3, {
+		printk(KERN_INFO "scsi scan: ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk(" name/id: '%s'\n", sdev->sdev_driverfs_dev.name);
+		});
 	return;
 }
 
@@ -1124,9 +1105,10 @@
 {
 	int res = SCSI_2;
 	Scsi_Device *sdev;
+	struct scsi_traverse_hndl strav_hndl;
 
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next)
-		if ((id == sdev->id) && (channel == sdev->channel))
+	scsi_for_each_sdev_lun (&strav_hndl, sdev, shost->host_no,
+				channel, id)
 			return (int) sdev->scsi_level;
 	/*
 	 * FIXME No matching target id is configured, this needs to get
@@ -1156,9 +1138,10 @@
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
 	int possible_inq_resp_len;
 
-	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: INQUIRY to host %d"
-			" channel %d id %d lun %d\n", sdev->host->host_no,
-			sdev->channel, sdev->id, sdev->lun));
+	SCSI_LOG_SCAN_BUS(3, {
+		printk(KERN_INFO "scsi scan: INQUIRY to ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d\n");
+	});
 
 	memset(scsi_cmd, 0, 6);
 	scsi_cmd[0] = INQUIRY;
@@ -1271,6 +1254,55 @@
 	return;
 }
 
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+/*
+ * scsi_check_sdev_id - check if a path already exist for sdev, if so add
+ * a new path, and return an appropriate value.
+ * @sdev:	check for exiting paths on this
+ * @path:	path to sdev
+ *
+ * Returns 0 if this is a new device, else a  SCSI_SCAN_ mask value.
+ */
+static int scsi_check_sdev_id(Scsi_Device *sdev, Scsi_Device **sdevnew,
+			      struct scsi_path_id *pathid)
+{
+	Scsi_Device *sdev_found;
+
+	/*
+	 * XXX check here if host adapter is OK with multipath, or if a
+	 * particular device is white or black listed for a unique id.
+	 */
+
+	/*
+	 * sdev is linked onto the list, so we need to let the lookup id
+	 * know to skip sdev.
+	 */
+	sdev_found = scsi_lookup_id(sdev->sdev_driverfs_dev.name, sdev);
+	if (sdev_found != NULL) {
+		/*
+		 * Found a new path to an existing device, remove the just
+		 * allocated sdev.
+		 *
+		 * FIXME for now don't add any driverfs info for the new path.
+		 */
+		scsi_remove_scsi_device(sdev);
+		(void)scsi_add_path(sdev_found, pathid->spi_shpnt,
+				    pathid->spi_channel, pathid->spi_id,
+				    pathid->spi_lun);
+		if (sdevnew != NULL)
+			*sdevnew = sdev_found;
+		return (SCSI_SCAN_TARGET_PRESENT | SCSI_SCAN_LUN_PRESENT);
+	}
+	return 0;
+}
+#else
+static int scsi_check_sdev_id(Scsi_Device *sdev, Scsi_Device **sdevnew,
+			      struct scsi_path_id *pathid)
+{
+	return 0;
+}
+#endif
+
 /**
  * scsi_add_lun - allocate and fully initialze a Scsi_Device
  * @sdevscan:	holds information to be stored in the new Scsi_Device
@@ -1285,9 +1317,7 @@
  *     NULL, store the address of the new Scsi_Device in *@sdevnew (needed
  *     when scanning a particular LUN).
  *
- * Return:
- *     SCSI_SCAN_NO_RESPONSE: could not allocate or setup a Scsi_Device
- *     SCSI_SCAN_LUN_PRESENT: a new Scsi_Device was allocated and initialized
+ * Returns a SCSI_SCAN_ mask value.
  **/
 static int scsi_add_lun(Scsi_Device *sdevscan, Scsi_Device **sdevnew,
 			Scsi_Request *sreq, char *inq_result, int *bflags)
@@ -1296,9 +1326,20 @@
 	struct Scsi_Device_Template *sdt;
 	char devname[64];
 	extern devfs_handle_t scsi_devfs_handle;
+	struct scsi_path_id pathid;
+	int ret;
 
-	sdev = scsi_alloc_sdev(sdevscan->host, sdevscan->channel,
-				     sdevscan->id, sdevscan->lun);
+	/*
+	 * sdevscan must have only one path, add it to this device.  XXX
+	 * this is a bit ugly, there must be a better solution, maybe pass
+	 * a scsi_path_id everywhere.
+	 */
+	if (scsi_get_path(sdevscan, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		return SCSI_SCAN_NO_RESPONSE;
+	}
+	sdev = scsi_alloc_sdev(pathid.spi_shpnt, pathid.spi_channel,
+			       pathid.spi_id, pathid.spi_lun);
 	if (sdev == NULL)
 		return SCSI_SCAN_NO_RESPONSE;
 
@@ -1316,7 +1357,7 @@
 	sdev->inquiry_len = sdevscan->inquiry_len;
 	sdev->inquiry = kmalloc(sdev->inquiry_len, GFP_ATOMIC);
 	if (sdev->inquiry == NULL) {
-		scsi_free_sdev(sdev);
+		scsi_remove_scsi_device(sdev);
 		return SCSI_SCAN_NO_RESPONSE;
 	}
 
@@ -1325,6 +1366,22 @@
 	sdev->model = (char *) (sdev->inquiry + 16);
 	sdev->rev = (char *) (sdev->inquiry + 32);
 
+	/*
+	 * XXX move the identifier and driverfs/devfs setup to a new
+	 * function
+	 *
+	 * scsi_load_identifier is the only reason sreq is needed in this
+	 * function; it also requires that the inquiry strings be set up.
+	 */
+	scsi_load_identifier(sdev, sreq);
+
+	/*
+	 * Check for multi-path device.
+	 */
+	ret = scsi_check_sdev_id(sdev, sdevnew, &pathid);
+	if (ret) 
+		return(ret);
+
 	if (*bflags & BLIST_ISROM) {
 		/*
 		 * It would be better to modify sdev->type, and set
@@ -1395,20 +1452,12 @@
 		sdev->sdtr = 1;
 
 	/*
-	 * XXX maybe move the identifier and driverfs/devfs setup to a new
-	 * function, and call them after this function is called.
-	 *
-	 * scsi_load_identifier is the only reason sreq is needed in this
-	 * function.
-	 */
-	scsi_load_identifier(sdev, sreq);
-
-	/*
 	 * create driverfs files
 	 */
 	sprintf(sdev->sdev_driverfs_dev.bus_id,"%d:%d:%d:%d",
-		sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
-	sdev->sdev_driverfs_dev.parent = &sdev->host->host_driverfs_dev;
+		pathid.spi_shpnt->host_no, pathid.spi_channel, pathid.spi_id,
+		pathid.spi_lun);
+	sdev->sdev_driverfs_dev.parent = &pathid.spi_shpnt->host_driverfs_dev;
 	sdev->sdev_driverfs_dev.bus = &scsi_driverfs_bus_type;
 	device_register(&sdev->sdev_driverfs_dev);
 
@@ -1418,7 +1467,8 @@
 	device_create_file(&sdev->sdev_driverfs_dev, &dev_attr_type);
 
 	sprintf(devname, "host%d/bus%d/target%d/lun%d",
-		sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
+		pathid.spi_shpnt->host_no, pathid.spi_channel, pathid.spi_id,
+		pathid.spi_lun);
 	if (sdev->de)
 		printk(KERN_WARNING "scsi devfs dir: \"%s\" already exists\n",
 		       devname);
@@ -1454,19 +1504,20 @@
 		if (sdt->detect)
 			sdev->attached += (*sdt->detect) (sdev);
 
-	if (sdev->host->hostt->slave_attach != NULL) {
-		if (sdev->host->hostt->slave_attach(sdev) != 0) {
+	if (pathid.spi_shpnt->hostt->slave_attach != NULL) {
+		if (pathid.spi_shpnt->hostt->slave_attach(sdev) != 0) {
 			printk(KERN_INFO "%s: scsi_add_lun: failed low level driver attach, setting device offline", devname);
 			sdev->online = FALSE;
 		}
-	} else if(sdev->host->cmd_per_lun) {
-		scsi_adjust_queue_depth(sdev, 0, sdev->host->cmd_per_lun);
+	} else if(pathid.spi_shpnt->cmd_per_lun) {
+		scsi_adjust_queue_depth(sdev, 0, pathid.spi_shpnt->cmd_per_lun);
 	}
 
 	if (sdevnew != NULL)
 		*sdevnew = sdev;
 
-	return SCSI_SCAN_LUN_PRESENT;
+	return (SCSI_SCAN_TARGET_PRESENT | SCSI_SCAN_LUN_PRESENT |
+		SCSI_SCAN_NEW_LUN);
 }
 
 /**
@@ -1479,11 +1530,7 @@
  *     Call scsi_probe_lun, if a LUN with an attached device is found,
  *     allocate and set it up by calling scsi_add_lun.
  *
- * Return:
- *     SCSI_SCAN_NO_RESPONSE: could not allocate or setup a Scsi_Device
- *     SCSI_SCAN_TARGET_PRESENT: target responded, but no device is
- *         attached at the LUN
- *     SCSI_SCAN_LUN_PRESENT: a new Scsi_Device was allocated and initialized
+ * Returns a SCSI_SCAN_ mask value.
  **/
 static int scsi_probe_and_add_lun(Scsi_Device *sdevscan, Scsi_Device **sdevnew,
 				  int *bflagsp)
@@ -1493,7 +1540,15 @@
 	unsigned char *scsi_result = NULL;
 	int bflags;
 	int res;
+	struct scsi_path_id pathid;
+
+	if (sdevnew != NULL)
+		*sdevnew = NULL;
 
+	if (scsi_get_path(sdevscan, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		return SCSI_SCAN_NO_RESPONSE;
+	}
 	/*
 	 * Any command blocks allocated are fixed to use sdevscan->lun,
 	 * so they must be allocated and released if sdevscan->lun
@@ -1519,9 +1574,8 @@
 	 * The sreq is for use only with sdevscan.
 	 */
 
-	scsi_result = kmalloc(256, GFP_ATOMIC |
-			      (sdevscan->host->unchecked_isa_dma) ?
-			      GFP_DMA : 0);
+	scsi_result = kmalloc(256, GFP_ATOMIC | 
+	    (pathid.spi_shpnt->unchecked_isa_dma) ?  GFP_DMA : 0);
 	if (scsi_result == NULL)
 		goto alloc_failed;
 
@@ -1550,12 +1604,12 @@
 		} else {
 			res = scsi_add_lun(sdevscan, &sdev, sreq, scsi_result,
 					   &bflags);
-			if (res == SCSI_SCAN_LUN_PRESENT) {
+			if (res & SCSI_SCAN_LUN_PRESENT) {
 				BUG_ON(sdev == NULL);
-				if ((bflags & BLIST_KEY) != 0) {
+				if ((res & SCSI_SCAN_NEW_LUN) &&
+				    (bflags & BLIST_KEY) != 0) {
 					sdev->lockable = 0;
-					scsi_unlock_floptical(sreq,
-							      scsi_result);
+					scsi_unlock_floptical(sreq, scsi_result);
 					/*
 					 * scsi_result no longer contains
 					 * the INQUIRY data.
@@ -1604,22 +1658,26 @@
 static void scsi_sequential_lun_scan(Scsi_Device *sdevscan, int bflags,
 				     int lun0_res)
 {
-	struct Scsi_Host *shost = sdevscan->host;
 	unsigned int sparse_lun;
 	unsigned int max_dev_lun;
+	struct scsi_path_id pathid;
 
+	if (scsi_get_path(sdevscan, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		return;
+	}
 	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: Sequential scan of"
-			" host %d channel %d id %d\n", sdevscan->host->host_no,
-			sdevscan->channel, sdevscan->id));
+		" host %d channel %d id %d\n", pathid.spi_shpnt->host_no,
+		pathid.spi_channel, pathid.spi_id));
 
-	max_dev_lun = min(max_scsi_luns, shost->max_lun);
+	max_dev_lun = min(max_scsi_luns, pathid.spi_shpnt->max_lun);
 	/*
 	 * If this device is known to support sparse multiple units,
 	 * override the other settings, and scan all of them. Normally,
 	 * SCSI-3 devices should be scanned via the REPORT LUNS.
 	 */
 	if (bflags & BLIST_SPARSELUN) {
-		max_dev_lun = shost->max_lun;
+		max_dev_lun = pathid.spi_shpnt->max_lun;
 		sparse_lun = 1;
 	} else
 		sparse_lun = 0;
@@ -1628,7 +1686,7 @@
 	 * If not sparse lun and no device attached at LUN 0 do not scan
 	 * any further.
 	 */
-	if (!sparse_lun && (lun0_res != SCSI_SCAN_LUN_PRESENT))
+	if (!sparse_lun && !(lun0_res & SCSI_SCAN_LUN_PRESENT))
 		return;
 
 	/*
@@ -1645,7 +1703,7 @@
 	 * the other settings, and scan all of them.
 	 */
 	if (bflags & BLIST_FORCELUN)
-		max_dev_lun = shost->max_lun;
+		max_dev_lun = pathid.spi_shpnt->max_lun;
 	/*
 	 * REGAL CDC-4X: avoid hang after LUN 4
 	 */
@@ -1663,10 +1721,16 @@
 	 * until we reach the max, or no LUN is found and we are not
 	 * sparse_lun.
 	 */
-	for (sdevscan->lun = 1; sdevscan->lun < max_dev_lun; ++sdevscan->lun)
-		if ((scsi_probe_and_add_lun(sdevscan, NULL, NULL)
-		     != SCSI_SCAN_LUN_PRESENT) && !sparse_lun)
+
+	for (pathid.spi_lun = 1; pathid.spi_lun < max_dev_lun;
+	     ++pathid.spi_lun) {
+		scsi_replace_path(sdevscan, pathid.spi_shpnt,
+				   pathid.spi_channel, pathid.spi_id,
+				  pathid.spi_lun);
+		if (!(scsi_probe_and_add_lun(sdevscan, NULL, NULL)
+		     & SCSI_SCAN_LUN_PRESENT) && !sparse_lun)
 			return;
+	}
 }
 
 #ifdef CONFIG_SCSI_REPORT_LUNS
@@ -1730,6 +1794,7 @@
 	ScsiLun *fcp_cur_lun, *lun_data;
 	Scsi_Request *sreq;
 	char *data;
+	struct scsi_path_id pathid;
 
 	/*
 	 * Only support SCSI-3 and up devices.
@@ -1737,6 +1802,13 @@
 	if (sdevscan->scsi_level < SCSI_3)
 		return 1;
 
+	if (scsi_get_path(sdevscan, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		/*
+		 * An inconsistency, so don't try scanning any further.
+		 */
+		return 0;
+	}
 	sdevscan->new_queue_depth = 1;
 	scsi_build_commandblocks(sdevscan);
 	if (sdevscan->current_queue_depth == 0) {
@@ -1748,8 +1820,8 @@
 	}
 	sreq = scsi_allocate_request(sdevscan);
 
-	sprintf(devname, "host %d channel %d id %d", sdevscan->host->host_no,
-		sdevscan->channel, sdevscan->id);
+	sprintf(devname, "host %d channel %d id %d", pathid.spi_shpnt->host_no,
+		pathid.spi_channel, pathid.spi_id);
 	/*
 	 * Allocate enough to hold the header (the same size as one ScsiLun)
 	 * plus the max number of luns we are requesting.
@@ -1761,9 +1833,8 @@
 	 * prevent us from finding any LUNs on this target.
 	 */
 	length = (max_scsi_report_luns + 1) * sizeof(ScsiLun);
-	lun_data = (ScsiLun *) kmalloc(length, GFP_ATOMIC |
-					   (sdevscan->host->unchecked_isa_dma ?
-					    GFP_DMA : 0));
+	lun_data = (ScsiLun *) kmalloc(length, GFP_ATOMIC | 
+	    (pathid.spi_shpnt->unchecked_isa_dma ?  GFP_DMA : 0));
 	if (lun_data == NULL) {
 		printk(ALLOC_FAILURE_MSG, __FUNCTION__);
 		scsi_release_commandblocks(sdevscan);
@@ -1843,9 +1914,8 @@
 	} else
 		num_luns = (length / sizeof(ScsiLun));
 
-	SCSI_LOG_SCAN_BUS(3, printk (KERN_INFO "scsi scan: REPORT LUN scan of"
-			" host %d channel %d id %d\n", sdevscan->host->host_no,
-			sdevscan->channel, sdevscan->id));
+	SCSI_LOG_SCAN_BUS(3, 
+	    printk(KERN_INFO "scsi scan: REPORT LUN scan of %s\n", devname));
 	/*
 	 * Scan the luns in lun_data. The entry at offset 0 is really
 	 * the header, so start at 1 and go up to and including num_luns.
@@ -1875,22 +1945,23 @@
 			/*
 			 * LUN 0 has already been scanned.
 			 */
-		} else if (lun > sdevscan->host->max_lun) {
+		} else if (lun > pathid.spi_shpnt->max_lun) {
 			printk(KERN_WARNING "scsi: %s lun%d has a LUN larger"
 			       " than allowed by the host adapter\n",
 			       devname, lun);
 		} else {
-			int res;
-
-			sdevscan->lun = lun;
-			res = scsi_probe_and_add_lun(sdevscan, NULL, NULL);
-			if (res == SCSI_SCAN_NO_RESPONSE) {
+			pathid.spi_lun = lun;
+			scsi_replace_path(sdevscan, pathid.spi_shpnt,
+					   pathid.spi_channel, pathid.spi_id,
+					  pathid.spi_lun);
+			if (scsi_probe_and_add_lun(sdevscan, NULL, NULL) ==
+			    SCSI_SCAN_NO_RESPONSE) {
 				/*
 				 * Got some results, but now none, abort.
 				 */
 				printk(KERN_ERR "scsi: Unexpected response"
 				       " from %s lun %d while scanning, scan"
-				       " aborted\n", devname, sdevscan->lun);
+				       " aborted\n", devname, pathid.spi_lun);
 				break;
 			}
 		}
@@ -1936,18 +2007,15 @@
 		 */
 		return;
 
-	sdevscan->host = shost;
-	sdevscan->id = id;
-	sdevscan->channel = channel;
+	scsi_replace_path(sdevscan, shost, channel, id, 0 /* LUN */);
 	/*
 	 * Scan LUN 0, if there is some response, scan further. Ideally, we
 	 * would not configure LUN 0 until all LUNs are scanned.
 	 *
 	 * The scsi_level is set (in scsi_probe_lun) if a target responds.
 	 */
-	sdevscan->lun = 0;
 	res = scsi_probe_and_add_lun(sdevscan, NULL, &bflags);
-	if (res != SCSI_SCAN_NO_RESPONSE) {
+	if (res & SCSI_SCAN_TARGET_PRESENT) {
 		/*
 		 * Some scsi devices cannot properly handle a lun != 0.
 		 * BLIST_NOLUN also prevents a REPORT LUN from being sent.
@@ -1993,11 +2061,11 @@
 		return;
 
 	sdevscan->scsi_level = scsi_find_scsi_level(channel, id, shost);
+	sdevscan->scanning = 1;
 	res = scsi_probe_and_add_lun(sdevscan, &sdev, NULL);
-	scsi_free_sdev(sdevscan);
-	if (res == SCSI_SCAN_LUN_PRESENT) {
+	scsi_remove_scsi_device(sdevscan);
+	if (res & SCSI_SCAN_NEW_LUN) {
 		BUG_ON(sdev == NULL);
-
 		for (sdt = scsi_devicelist; sdt; sdt = sdt->next)
 			if (sdt->init && sdt->dev_noticed)
 				(*sdt->init) ();
@@ -2063,12 +2131,20 @@
 		 * queue_nr_requests requests are allocated. Don't do so
 		 * here for scsi_scan_selected_lun, since we end up
 		 * calling select_queue_depths with an extra Scsi_Device
-		 * on the host_queue list.
+		 * on the device list.
 		 */
 		sdevscan = scsi_alloc_sdev(shost, 0, 0, 0);
 		if (sdevscan == NULL)
 			return;
 		/*
+		 * Set the scanning bit, so error messages about errors
+		 * and path failure are not printed; this should be used
+		 * in scsi_error.c to prevent overly aggressive action on
+		 * failure for a scan. This is never reset, as the default
+		 * state for a new Scsi_Device is 0.
+		 */
+		sdevscan->scanning = 1;
+		/*
 		 * The sdevscan host, channel, id and lun are filled in as
 		 * needed to scan.
 		 */
@@ -2094,6 +2170,6 @@
 						 order_id);
 			}
 		}
-		scsi_free_sdev(sdevscan);
+		scsi_remove_scsi_device(sdevscan);
 	}
 }
diff -Nru a/drivers/scsi/scsi_syms.c b/drivers/scsi/scsi_syms.c
--- a/drivers/scsi/scsi_syms.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/scsi_syms.c	Fri Oct 25 11:26:47 2002
@@ -71,6 +71,7 @@
 
 EXPORT_SYMBOL(scsi_get_host_dev);
 EXPORT_SYMBOL(scsi_free_host_dev);
+EXPORT_SYMBOL(scsi_sdev_list);
 
 EXPORT_SYMBOL(scsi_sleep);
 
@@ -105,6 +106,12 @@
 EXPORT_SYMBOL(scsi_add_timer);
 EXPORT_SYMBOL(scsi_delete_timer);
 
+EXPORT_SYMBOL(scsi_add_path);
+EXPORT_SYMBOL(scsi_remove_path);
+EXPORT_SYMBOL(scsi_get_path);
+EXPORT_SYMBOL(scsi_get_host);
+EXPORT_SYMBOL(scsi_paths_printk);
+EXPORT_SYMBOL(scsi_traverse_sdevs);
 /*
  * driverfs support for determining driver types
  */
diff -Nru a/include/scsi/scsi.h b/include/scsi/scsi.h
--- a/include/scsi/scsi.h	Fri Oct 25 11:26:48 2002
+++ b/include/scsi/scsi.h	Fri Oct 25 11:26:48 2002
@@ -91,6 +91,29 @@
 #define WRITE_LONG_2          0xea
 
 /*
+ * SCSI INQUIRY Flags (byte 7)
+ */
+#define SCSI_EVPD       0x01   /* enable vital product data */
+#define SCSI_RMB7       0x80   /* removable media */
+#define SCSI_AENC       0x80   /* asynchronous event notification capability */
+#define SCSI_TRMIOP     0x40   /* terminate I/O process capability */
+#define SCSI_RELADR7    0x80   /* relative addressing capability */
+#define SCSI_WBUS16     0x20   /* 16 byte wide transfer capabilitiy */
+#define SCSI_WBUS32     0x40   /* 32 byte wide transfer capabilitiy */
+#define SCSI_SYNC       0x10   /* synchronous data transfer capability */
+#define SCSI_LINKED     0x08   /* linked command capability */
+#define SCSI_CMDQUE     0x02   /* command queueing capability */
+#define SCSI_SFTRE      0x01   /* soft reset capability */
+
+/*
+ * SCSI INQUIRY Vital Product Data Page Codes
+ */
+#define SCSI_VPROD_SUPPORTED            0x00
+#define SCSI_VPROD_UNIT_SERIAL          0x80
+#define SCSI_VPROD_AODEFN               0x82
+#define SCSI_VPROD_DEVICE_ID            0x83
+
+/*
  *  Status codes
  */
 
