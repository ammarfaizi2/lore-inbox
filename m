Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262246AbSJKBPt>; Thu, 10 Oct 2002 21:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJKBPt>; Thu, 10 Oct 2002 21:15:49 -0400
Received: from themargofoundation.org ([65.206.132.246]:40974 "HELO
	themargofoundation.org") by vger.kernel.org with SMTP
	id <S262246AbSJKBPd>; Thu, 10 Oct 2002 21:15:33 -0400
From: "Steven Dake" <scd@broked.org>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] [RFC] Advanced TCA Disk Hotswap support in Linux Kernel [qla2300 2/2]
Date: Thu, 10 Oct 2002 18:19:52 -0700
Message-ID: <004501c270c4$4d23d4d0$0200000a@persist>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml,

I am developing the Linux kernel support required to support Advanced
TCA
(PICMG 3.0) architecture.  Advanced TCA is a technology where boards
exist
in a chassis and can either be processor nodes or storage nodes.  All
blades in the chassis are connected by FibreChannel and Ethernet.  The
blades can be hot added or hot removed while the Linux processor nodes
are
active, meaning that the SCSI subsystem must add devices on insertion
requests and remove devices on ejection requests.

This second patch is a FibreChannel driver that is modified to support
SCSI
Hotswap driver previously posted.

Regards,
-steve

diff -uNr linux-campbell/drivers/scsi/qla2xxx/qla2x00.c
linux-scsi-hotswap/drivers/scsi/qla2xxx/qla2x00.c
--- linux-campbell/drivers/scsi/qla2xxx/qla2x00.c	Fri Jun 21
20:56:35 2002
+++ linux-scsi-hotswap/drivers/scsi/qla2xxx/qla2x00.c	Mon Jul  8
18:53:05 2002
@@ -244,6 +244,7 @@
 STATIC uint8_t  qla2x00_register_with_Linux(scsi_qla_host_t *ha,
uint8_t maxchannels);
 STATIC int   qla2x00_done(scsi_qla_host_t *);
 STATIC void qla2x00_select_queue_depth(struct Scsi_Host *, Scsi_Device
*);
+int qla2x00_get_scsi_info_from_wwn (int mode, unsigned long long wwn, 
+int *host, int *channel, int *lun, int *id);
 
 STATIC void
 qla2x00_timer(scsi_qla_host_t *);
@@ -2036,6 +2037,9 @@
 	host->can_queue = max_srbs;  /* default value:-MAX_SRBS(4096)
*/
 	host->cmd_per_lun = 1;
 	host->select_queue_depths = qla2x00_select_queue_depth;
+	host->hostt->get_scsi_info_from_wwn =
qla2x00_get_scsi_info_from_wwn;
+
+
 	host->n_io_port = 0xFF;
 
 #if MEMORY_MAPPED_IO
@@ -3981,6 +3985,80 @@
 			device->queue_depth);
 	}
 
+}
+
+union wwnmap {
+	unsigned long long wwn;
+	unsigned char wwn_u8[8];
+};
+
+int qla2x00_get_scsi_info_from_wwn (int mode,
+	unsigned long long wwn,
+	int *host,
+	int *channel,
+	int *lun,
+	int *id) {
+
+scsi_qla_host_t *list;
+Scsi_Device *scsi_device;
+union wwnmap wwncompare;
+union wwnmap wwncompare2;
+int i, j, k;
+
+	/*
+	 * Retrieve big endian version of world wide name
+	 */
+	wwncompare2.wwn = wwn;
+	for (j = 0, k=7; j < 8; j++, k--) {
+		wwncompare.wwn_u8[j] = wwncompare2.wwn_u8[k];
+	}
+
+	/*
+	 * query all hosts searching for WWN
+	 */
+	for (list = qla2x00_hostlist; list; list = list->next) {
+		for (i = 0; i < MAX_FIBRE_DEVICES; i++) {
+			/*
+			 * Scan all devices in FibreChannel database
+			 * if WWN match found, return SCSI device
information
+			 */
+			if (memcmp (wwncompare.wwn_u8,
list->fc_db[i].wwn, 8) == 0) {
+				/*
+				 * If inserting, avoid scan for channel
and lun information
+				 */
+				if (mode == 0) {
+					*channel = 0;
+					*lun = 0;
+					*host = list->host->host_no;
+					*id = i;
+					return (0);
+				}
+			
+
+				/*
+				 * WWN matches, find channel and lun
information from scsi
+				 * device
+				 */
+				for (scsi_device =
list->host->host_queue; scsi_device; scsi_device = scsi_device->next) {
+					if (scsi_device->id == i) {
+						*channel =
scsi_device->channel;
+						*lun = scsi_device->lun;
+						break;
+					}
+				}
+				if (scsi_device == 0) {
+					return (-ENOENT);
+				}
+				/*
+				 * Device found, return all data
+				 */
+				*host = list->host->host_no;
+				*id = i;
+				return (0);
+			} /* memcmp */
+		} /* i < MAXFIBREDEVICES */
+	}
+	return (-ENOENT);
 }
 
 
/***********************************************************************
***


