Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbSJZJ2R>; Sat, 26 Oct 2002 05:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSJZJ2R>; Sat, 26 Oct 2002 05:28:17 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:32762 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262020AbSJZJ2O>; Sat, 26 Oct 2002 05:28:14 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15802.24995.936888.44019@wombat.chubb.wattle.id.au>
Date: Sat, 26 Oct 2002 19:34:27 +1000
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] fusion scsi fixup
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, for those who have to use the Fusion fibrechannel driver, here's a
fix for 2.5.44.  It seems to work, but I have no idea if it's really
correct...  Alan, you said you intended to look into this.  Maybe this
patch will help.

--- linux-2.5.44/drivers/message/fusion/mptscsih.c	2002-10-26 19:31:03.000000000 +1000
+++ linux-2.5-ia64/drivers/message/fusion/mptscsih.c	2002-10-26 19:31:04.000000000 +1000
@@ -1295,10 +1295,6 @@
 #endif
 				sh->this_id = this->pfacts[portnum].PortSCSIID;
 
-				/* OS entry to allow host drivers to force
-				 * a queue depth on a per device basis.
-				 */
-				sh->select_queue_depths = mptscsih_select_queue_depths;
 				/* Required entry.
 				 */
 				sh->unique_id = this->id;
@@ -3668,23 +3664,15 @@
  *	Called once per device the bus scan. Use it to force the queue_depth
  *	member to 1 if a device does not support Q tags.
  */
-void
-mptscsih_select_queue_depths(struct Scsi_Host *sh, Scsi_Device *sdList)
+int
+mptscsih_slave_attach(Scsi_Device *device)
 {
-	struct scsi_device	*device;
+	struct Scsi_Host	*host = device->host;
 	VirtDevice		*pTarget;
 	MPT_SCSI_HOST		*hd;
 	int			 ii, max;
 
-	for (device = sdList; device != NULL; device = device->next) {
-
-		if (device->host != sh)
-			continue;
-
-		hd = (MPT_SCSI_HOST *) sh->hostdata;
-		if (hd == NULL)
-			continue;
-
+	hd = (MPT_SCSI_HOST *)host->hostdata;
 		if (hd->Targets != NULL) {
 			if (hd->is_spi)
 				max = MPT_MAX_SCSI_DEVICES;
@@ -3694,11 +3682,11 @@
 			for (ii=0; ii < max; ii++) {
 				pTarget = hd->Targets[ii];
 				if (pTarget && !(pTarget->tflags & MPT_TARGET_FLAGS_Q_YES)) {
-					device->queue_depth = 1;
-				}
+				scsi_adjust_queue_depth(device, 0, 1);
 			}
 		}
 	}
+	return 0;
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
--- linux-2.5.44/drivers/message/fusion/mptscsih.h	2002-10-26 19:31:42.000000000 +1000
+++ linux-2.5-ia64/drivers/message/fusion/mptscsih.h	2002-10-26 19:31:42.000000000 +1000
@@ -206,11 +206,11 @@
 #define x_scsi_dev_reset	mptscsih_dev_reset
 #define x_scsi_host_reset	mptscsih_host_reset
 #define x_scsi_bios_param	mptscsih_bios_param
-#define x_scsi_select_queue_depths	mptscsih_select_queue_depths
 
 #define x_scsi_taskmgmt_bh	mptscsih_taskmgmt_bh
 #define x_scsi_old_abort	mptscsih_old_abort
 #define x_scsi_old_reset	mptscsih_old_reset
+#define x_scsi_slave_attach	mptscsih_slave_attach
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*
@@ -234,8 +234,8 @@
 #else
 extern	int		 x_scsi_bios_param(Disk *, kdev_t, int *);
 #endif
-extern	void		 x_scsi_select_queue_depths(struct Scsi_Host *, Scsi_Device *);
 extern	void		 x_scsi_taskmgmt_bh(void *);
+extern	int		 x_scsi_slave_attach(Scsi_Device *);
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
 #define PROC_SCSI_DECL
@@ -248,53 +248,45 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,1)
 
 #define MPT_SCSIHOST {						\
-	next:				NULL,			\
 	PROC_SCSI_DECL						\
-	name:				"MPT SCSI Host",	\
-	detect:				x_scsi_detect,		\
-	release:			x_scsi_release,		\
-	info:				x_scsi_info,		\
-	command:			NULL,			\
-	queuecommand:			x_scsi_queuecommand,	\
-	eh_strategy_handler:		NULL,			\
-	eh_abort_handler:		x_scsi_abort,		\
-	eh_device_reset_handler:	x_scsi_dev_reset,	\
-	eh_bus_reset_handler:		x_scsi_bus_reset,	\
-	eh_host_reset_handler:		x_scsi_host_reset,	\
-	bios_param:			x_scsi_bios_param,	\
-	can_queue:			MPT_SCSI_CAN_QUEUE,	\
-	this_id:			-1,			\
-	sg_tablesize:			MPT_SCSI_SG_DEPTH,	\
-	max_sectors:			MPT_SCSI_MAX_SECTORS,   \
-	cmd_per_lun:			MPT_SCSI_CMD_PER_LUN,	\
-	unchecked_isa_dma:		0,			\
-	use_clustering:			ENABLE_CLUSTERING,	\
+	.name				= "MPT SCSI Host",	\
+	.detect				= x_scsi_detect,	\
+	.release			= x_scsi_release,	\
+	.info				= x_scsi_info,		\
+	.queuecommand			= x_scsi_queuecommand,	\
+	.slave_attach			= x_scsi_slave_attach,	\
+	.eh_abort_handler		= x_scsi_abort,		\
+	.eh_device_reset_handler	= x_scsi_dev_reset,	\
+	.eh_bus_reset_handler		= x_scsi_bus_reset,	\
+	.eh_host_reset_handler		= x_scsi_host_reset,	\
+	.bios_param			= x_scsi_bios_param,	\
+	.can_queue			= MPT_SCSI_CAN_QUEUE,	\
+	.this_id			= -1,			\
+	.sg_tablesize			= MPT_SCSI_SG_DEPTH,	\
+	.max_sectors			= MPT_SCSI_MAX_SECTORS,	\
+	.cmd_per_lun			= MPT_SCSI_CMD_PER_LUN,	\
+	.use_clustering			= ENABLE_CLUSTERING,	\
 }
 
 #else  /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,1) */
 
 #define MPT_SCSIHOST {						\
-	next:				NULL,			\
 	PROC_SCSI_DECL						\
-	name:				"MPT SCSI Host",	\
-	detect:				x_scsi_detect,		\
-	release:			x_scsi_release,		\
-	info:				x_scsi_info,		\
-	command:			NULL,			\
-	queuecommand:			x_scsi_queuecommand,	\
-	eh_strategy_handler:		NULL,			\
-	eh_abort_handler:		x_scsi_abort,		\
-	eh_device_reset_handler:	x_scsi_dev_reset,	\
-	eh_bus_reset_handler:		x_scsi_bus_reset,	\
-	eh_host_reset_handler:		NULL,			\
-	bios_param:			x_scsi_bios_param,	\
-	can_queue:			MPT_SCSI_CAN_QUEUE,	\
-	this_id:			-1,			\
-	sg_tablesize:			MPT_SCSI_SG_DEPTH,	\
-	cmd_per_lun:			MPT_SCSI_CMD_PER_LUN,	\
-	unchecked_isa_dma:		0,			\
-	use_clustering:			ENABLE_CLUSTERING,	\
-	use_new_eh_code:		1			\
+	.name				= "MPT SCSI Host",	\
+	.detect				= x_scsi_detect,	\
+	.release			= x_scsi_release,	\
+	.info				= x_scsi_info,		\
+	.queuecommand			= x_scsi_queuecommand,	\
+	.eh_abort_handler		= x_scsi_abort,		\
+	.eh_device_reset_handler	= x_scsi_dev_reset,	\
+	.eh_bus_reset_handler		= x_scsi_bus_reset,	\
+	.bios_param			= x_scsi_bios_param,	\
+	.can_queue			= MPT_SCSI_CAN_QUEUE,	\
+	.this_id			= -1,			\
+	.sg_tablesize			= MPT_SCSI_SG_DEPTH,	\
+	.cmd_per_lun			= MPT_SCSI_CMD_PER_LUN,	\
+	.use_clustering			= ENABLE_CLUSTERING,	\
+	.use_new_eh_code		= 1			\
 }
 
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,1) */
@@ -302,23 +294,20 @@
 #else /* MPT_SCSI_USE_NEW_EH */
 
 #define MPT_SCSIHOST {						\
-	next:				NULL,			\
 	PROC_SCSI_DECL						\
-	name:				"MPT SCSI Host",	\
-	detect:				x_scsi_detect,		\
-	release:			x_scsi_release,		\
-	info:				x_scsi_info,		\
-	command:			NULL,			\
-	queuecommand:			x_scsi_queuecommand,	\
-	abort:				x_scsi_old_abort,	\
-	reset:				x_scsi_old_reset,	\
-	bios_param:			x_scsi_bios_param,	\
-	can_queue:			MPT_SCSI_CAN_QUEUE,	\
-	this_id:			-1,			\
-	sg_tablesize:			MPT_SCSI_SG_DEPTH,	\
-	cmd_per_lun:			MPT_SCSI_CMD_PER_LUN,	\
-	unchecked_isa_dma:		0,			\
-	use_clustering:			ENABLE_CLUSTERING	\
+	.name				= "MPT SCSI Host",	\
+	.detect				= x_scsi_detect,	\
+	.release			= x_scsi_release,	\
+	.info				= x_scsi_info,		\
+	.queuecommand			= x_scsi_queuecommand,	\
+	.abort				= x_scsi_old_abort,	\
+	.reset				= x_scsi_old_reset,	\
+	.bios_param			= x_scsi_bios_param,	\
+	.can_queue			= MPT_SCSI_CAN_QUEUE,	\
+	.this_id			= -1,			\
+	.sg_tablesize			= MPT_SCSI_SG_DEPTH,	\
+	.cmd_per_lun			= MPT_SCSI_CMD_PER_LUN,	\
+	.use_clustering			= ENABLE_CLUSTERING	\
 }
 #endif  /* MPT_SCSI_USE_NEW_EH */
 
