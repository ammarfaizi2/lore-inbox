Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264803AbSIQWt5>; Tue, 17 Sep 2002 18:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264794AbSIQWtz>; Tue, 17 Sep 2002 18:49:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65426 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264675AbSIQWrl>;
	Tue, 17 Sep 2002 18:47:41 -0400
Date: Tue, 17 Sep 2002 15:52:32 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC] [PATCH] 5/7 2.5.35 SCSI multi-path
Message-ID: <20020917155232.E18424@eng2.beaverton.ibm.com>
References: <20020917154940.A18401@eng2.beaverton.ibm.com> <20020917155018.A18424@eng2.beaverton.ibm.com> <20020917155041.B18424@eng2.beaverton.ibm.com> <20020917155120.C18424@eng2.beaverton.ibm.com> <20020917155201.D18424@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020917155201.D18424@eng2.beaverton.ibm.com>; from patman on Tue, Sep 17, 2002 at 03:52:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches to scsi adapter drivers (scsi low level drivers) to simplify and
enable the addition of scsi multi-path IO support.

This does not add multi-path support, it adds changes that simplify the
addition of the actual scsi multi-path code.

Only the adapters that have been run with the multi-path patch are
included here. Other adpaters will likely fail compilation.

This includes a change to the qlogicfc.c driver to flush all SCSI commands
on a loop down, so that driver is more functional with the multi-path
patch (when patched on top of this patch).

 aic7xxx/aic7xxx_linux.c |   28 +++++++++++++++-----------
 ips.c                   |    7 +++++-
 qlogicfc.c              |   51 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 13 deletions(-)

diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_linux.c b/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- a/drivers/scsi/aic7xxx/aic7xxx_linux.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/aic7xxx/aic7xxx_linux.c	Mon Sep 16 15:29:45 2002
@@ -1457,15 +1457,14 @@
 	struct	ahc_softc *ahc;
 	u_long	flags;
 	int	scbnum;
+	scsi_traverse_hndl_t strav_hndl;
 
 	ahc = *((struct ahc_softc **)host->hostdata);
 	ahc_lock(ahc, &flags);
 	scbnum = 0;
-	for (device = scsi_devs; device != NULL; device = device->next) {
-		if (device->host == host) {
-			ahc_linux_device_queue_depth(ahc, device);
-			scbnum += device->queue_depth;
-		}
+	scsi_for_each_host_sdev(&strav_hndl, device, host->host_no) {
+		ahc_linux_device_queue_depth(ahc, device);
+		scbnum += device->queue_depth;
 	}
 	ahc_unlock(ahc, &flags);
 }
@@ -1480,11 +1479,14 @@
 	struct	ahc_initiator_tinfo *targ_info;
 	struct	ahc_tmode_tstate *tstate;
 	uint8_t tags;
+	struct scsi_path_id scsi_path;
+
+	scsi_get_path(device, &scsi_path);
 
 	ahc_compile_devinfo(&devinfo,
-			    device->channel == 0 ? ahc->our_id : ahc->our_id_b,
-			    device->id, device->lun,
-			    device->channel == 0 ? 'A' : 'B',
+			    scsi_path.spi_channel == 0 ? ahc->our_id : ahc->our_id_b,
+			    scsi_path.spi_id, scsi_path.spi_lun,
+			    scsi_path.spi_channel == 0 ? 'A' : 'B',
 			    ROLE_INITIATOR);
 	targ_info = ahc_fetch_transinfo(ahc, devinfo.channel,
 					devinfo.our_scsiid,
@@ -1515,8 +1517,8 @@
 		device->queue_depth = tags;
 		ahc_set_tags(ahc, &devinfo, AHC_QUEUE_TAGGED);
 		printf("scsi%d:%c:%d:%d: Tagged Queuing enabled.  Depth %d\n",
-	       	       ahc->platform_data->host->host_no, device->channel + 'A',
-		       device->id, device->lun, tags);
+	       	       ahc->platform_data->host->host_no, scsi_path.spi_channel + 'A',
+		       scsi_path.spi_id, scsi_path.spi_lun, tags);
 	} else {
 		/*
 		 * We allow the OS to queue 2 untagged transactions to
@@ -2735,8 +2737,10 @@
 	int	extended;
 	struct	ahc_softc *ahc;
 	unsigned char *buf;
+	struct scsi_path_id scsi_path;
 
-	ahc = *((struct ahc_softc **)disk->device->host->hostdata);
+	scsi_get_path(disk->device, &scsi_path);
+	ahc = *((struct ahc_softc **)scsi_path.spi_shpnt->hostdata);
 	buf = scsi_bios_ptable(bdev);
 
 	if (buf) {
@@ -2752,7 +2756,7 @@
 
 	if (aic7xxx_extended != 0)
 		extended = 1;
-	else if (disk->device->channel == 0)
+	else if (scsi_path.spi_channel == 0)
 		extended = (ahc->flags & AHC_EXTENDED_TRANS_A) != 0;
 	else
 		extended = (ahc->flags & AHC_EXTENDED_TRANS_B) != 0;
diff -Nru a/drivers/scsi/ips.c b/drivers/scsi/ips.c
--- a/drivers/scsi/ips.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/ips.c	Mon Sep 16 15:29:45 2002
@@ -1858,10 +1858,15 @@
    int               heads;
    int               sectors;
    int               cylinders;
+   struct Scsi_Host *host;
 
    METHOD_TRACE("ips_biosparam", 1);
 
-   ha = (ips_ha_t *) disk->device->host->hostdata;
+   host = scsi_get_host(disk->device);
+   if (host == NULL)
+      return (0);
+
+   ha = (ips_ha_t *) host->hostdata;
 
    if (!ha)
       /* ?!?! host adater info invalid */
diff -Nru a/drivers/scsi/qlogicfc.c b/drivers/scsi/qlogicfc.c
--- a/drivers/scsi/qlogicfc.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/qlogicfc.c	Mon Sep 16 15:29:45 2002
@@ -679,6 +679,8 @@
 static void isp2x00_print_status_entry(struct Status_Entry *);
 #endif
 
+static void do_isp2x00_flush_all_SCSI_cmds(unsigned long arg);
+
 static inline void isp2x00_enable_irqs(struct Scsi_Host *host)
 {
 	outw(ISP_EN_INT | ISP_EN_RISC, host->io_port + PCI_INTER_CTL);
@@ -1154,6 +1156,13 @@
 
 	DEBUG(isp2x00_print_scsi_cmd(Cmnd));
 
+	if (hostdata->adapter_state == AS_LOOP_DOWN) {
+		Cmnd->result = DID_NO_CONNECT << 16;
+		if (Cmnd->scsi_done)
+			(*Cmnd->scsi_done) (Cmnd);
+		return 0;
+	}
+
 	if (hostdata->adapter_state & AS_REDO_FABRIC_PORTDB || hostdata->adapter_state & AS_REDO_LOOP_PORTDB) {
 		isp2x00_make_portdb(host);
 		hostdata->adapter_state = AS_LOOP_GOOD;
@@ -1469,6 +1478,7 @@
 		case LOOP_DOWN:
 		        printk("qlogicfc%d : Link is Down\n", hostdata->host_id);
 			hostdata->adapter_state = AS_LOOP_DOWN;
+			do_isp2x00_flush_all_SCSI_cmds((unsigned long) host);
 			break;
 		case CONNECTION_MODE:
 		        printk("received CONNECTION_MODE irq %x\n", inw(host->io_port + MBOX1));
@@ -2222,6 +2232,47 @@
 }
 
 #endif				/* DEBUG_ISP2x00 */
+
+/*
+ * Flush all SCSI commands we have.
+ */
+void do_isp2x00_flush_all_SCSI_cmds(unsigned long arg)
+{
+        struct Scsi_Host * host = (struct Scsi_Host *) arg;
+	struct isp2x00_hostdata * hostdata;
+	int i;
+
+	hostdata = (struct isp2x00_hostdata *) host->hostdata;
+
+	printk("qlogicfc%d : Flushing all SCSI commands?\n", hostdata->host_id);
+	for (i = 0; i < QLOGICFC_REQ_QUEUE_LEN; i++){ 
+		if (hostdata->handle_ptrs[i] ){
+			Scsi_Cmnd *Cmnd = hostdata->handle_ptrs[i];
+
+			 if (Cmnd->use_sg)
+				 pci_unmap_sg(hostdata->pci_dev,
+					      (struct scatterlist *)Cmnd->buffer,
+					      Cmnd->use_sg,
+					      scsi_to_pci_dma_dir(Cmnd->sc_data_direction));
+			 else if (Cmnd->request_bufflen &&
+				  Cmnd->sc_data_direction != PCI_DMA_NONE) {
+				 pci_unmap_page(hostdata->pci_dev,
+						Cmnd->SCp.dma_handle,
+						Cmnd->request_bufflen,
+						scsi_to_pci_dma_dir(Cmnd->sc_data_direction));
+			 }
+
+			 Cmnd->result = DID_NO_CONNECT << 16;
+
+			 if (Cmnd->scsi_done){
+			   (*Cmnd->scsi_done) (Cmnd);
+			 }
+			 else printk("qlogicfc%d : done is null?\n", hostdata->host_id);
+			 hostdata->handle_ptrs[i] = NULL;
+			 hostdata->handle_serials[i] = 0;
+		}
+	}
+}
 
 MODULE_LICENSE("GPL");
 
