Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSJYWZc>; Fri, 25 Oct 2002 18:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSJYWWH>; Fri, 25 Oct 2002 18:22:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:36319 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261663AbSJYWRX>; Fri, 25 Oct 2002 18:17:23 -0400
Date: Fri, 25 Oct 2002 15:23:30 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 5/6 2.5.44 scsi multi-path IO - lower layer (adapter) changes
Message-ID: <20021025152330.E17527@eng2.beaverton.ibm.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20021025152116.A17462@eng2.beaverton.ibm.com> <20021025152149.A17527@eng2.beaverton.ibm.com> <20021025152208.B17527@eng2.beaverton.ibm.com> <20021025152226.C17527@eng2.beaverton.ibm.com> <20021025152252.D17527@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021025152252.D17527@eng2.beaverton.ibm.com>; from patman on Fri, Oct 25, 2002 at 03:22:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI low-layer (adapter drivers) multi-path IO changes

 53c700.c                |   27 +++++++++++++++++--------
 aic7xxx/aic7xxx_linux.c |   27 ++++++++++++++++---------
 ips.c                   |   13 ++++++++++--
 qlogicfc.c              |   51 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 19 deletions(-)

diff -Nru a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
--- a/drivers/scsi/53c700.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/53c700.c	Fri Oct 25 11:26:47 2002
@@ -1084,7 +1084,7 @@
 		DEBUG(("scsi%d: (%d:%d) RESELECTED!\n",
 		       host->host_no, reselection_id, lun));
 		/* clear the reselection indicator */
-		SDp = scsi_find_device(host, 0, reselection_id, lun);
+		SDp = scsi_locate_sdev(host->host_no, 0, reselection_id, lun);
 		if(unlikely(SDp == NULL)) {
 			printk(KERN_ERR "scsi%d: (%d:%d) HAS NO device\n",
 			       host->host_no, reselection_id, lun);
@@ -1506,6 +1506,7 @@
 		if(sstat0 & SCSI_RESET_DETECTED) {
 			Scsi_Device *SDp;
 			int i;
+			struct scsi_traverse_hndl strav_hndl;
 
 			hostdata->state = NCR_700_HOST_BUSY;
 
@@ -1513,7 +1514,7 @@
 			       host->host_no, SCp, SCp == NULL ? NULL : SCp->host_scribble, dsp, dsp - hostdata->pScript);
 
 			/* clear all the negotiated parameters */
-			for(SDp = host->host_queue; SDp != NULL; SDp = SDp->next)
+			scsi_for_each_host_sdev(&strav_hndl, SDp, host->host_no)
 				SDp->hostdata = 0;
 			
 			/* clear all the slots and their pending commands */
@@ -1726,6 +1727,7 @@
 	struct Scsi_Host *host;
 	struct NCR_700_Host_Parameters *hostdata;
 	Scsi_Device *SDp;
+	struct scsi_traverse_hndl strav_hndl;
 
 	host = scsi_host_hn_get(host_no);
 	if(host == NULL)
@@ -1740,8 +1742,10 @@
 	len += sprintf(&buf[len],"\
 Target	Depth  Active  Next Tag\n\
 ======	=====  ======  ========\n");
-	for(SDp = host->host_queue; SDp != NULL; SDp = SDp->next) {
-		len += sprintf(&buf[len]," %2d:%2d   %4d    %4d      %4d\n", SDp->id, SDp->lun, SDp->current_queue_depth, NCR_700_get_depth(SDp), SDp->current_tag);
+	scsi_for_each_host_sdev(&strav_hndl, SDp, host->host_no) {
+		len += scsi_paths_proc_print_paths(SDp, &buf[len],
+			"%2d:%2d:%2d:%2d");
+		len += sprintf(&buf[len],"   %4d    %4d      %4d\n", SDp->current_queue_depth, NCR_700_get_depth(SDp), SDp->current_tag);
 	}
 	if((len -= offset) <= 0)
 		return 0;
@@ -1814,13 +1818,13 @@
 		 * tag queuing per LUN.  We only support it per PUN because
 		 * of potential reselection issues */
 		printk(KERN_NOTICE "scsi%d: (%d:%d) beginning blk layer TCQ\n",
-		       SCp->device->host->host_no, SCp->target, SCp->lun);
+		       SCp->host->host_no, SCp->target, SCp->lun);
 		scsi_activate_tcq(SCp->device, NCR_700_MAX_TAGS);
 	}
 
 	if(blk_rq_tagged(SCp->request)
 	   && (hostdata->tag_negotiated &(1<<SCp->target)) == 0) {
-		printk(KERN_INFO "scsi%d: (%d:%d) Enabling Tag Command Queuing\n", SCp->device->host->host_no, SCp->target, SCp->lun);
+		printk(KERN_INFO "scsi%d: (%d:%d) Enabling Tag Command Queuing\n", SCp->host->host_no, SCp->target, SCp->lun);
 		hostdata->tag_negotiated |= (1<<SCp->target);
 		NCR_700_set_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
 	}
@@ -1833,7 +1837,7 @@
 	 * */
 	if(!blk_rq_tagged(SCp->request)
 	   && (hostdata->tag_negotiated &(1<<SCp->target))) {
-		printk(KERN_INFO "scsi%d: (%d:%d) Disabling Tag Command Queuing\n", SCp->device->host->host_no, SCp->target, SCp->lun);
+		printk(KERN_INFO "scsi%d: (%d:%d) Disabling Tag Command Queuing\n", SCp->host->host_no, SCp->target, SCp->lun);
 		hostdata->tag_negotiated &= ~(1<<SCp->target);
 	}
 
@@ -2003,12 +2007,19 @@
 STATIC int
 NCR_700_slave_attach(Scsi_Device *SDp)
 {
+	struct Scsi_Host *host;
 	/* to do here: allocate memory; build a queue_full list */
 	if(SDp->tagged_supported) {
 		/* do TCQ stuff here */
 	} else {
 		/* initialise to default depth */
-		scsi_adjust_queue_depth(SDp, 0, SDp->host->cmd_per_lun);
+		host = scsi_get_host(SDp);
+		if (!host)
+			/*
+			 * Probably a BUG.
+			 */
+			return 1;
+		scsi_adjust_queue_depth(SDp, 0, host->cmd_per_lun);
 	}
 	return 0;
 }
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_linux.c b/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- a/drivers/scsi/aic7xxx/aic7xxx_linux.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/aic7xxx/aic7xxx_linux.c	Fri Oct 25 11:26:47 2002
@@ -1452,8 +1452,12 @@
 {
 	struct	ahc_softc *ahc;
 	u_long	flags;
+	struct Scsi_Host *shost;
 
-	ahc = *((struct ahc_softc **)device->host->hostdata);
+	shost = scsi_get_host(device);
+	if (!shost)
+		return 1;
+	ahc = *((struct ahc_softc **)shost->hostdata);
 	ahc_lock(ahc, &flags);
 	ahc_linux_device_queue_depth(ahc, device);
 	ahc_unlock(ahc, &flags);
@@ -1470,11 +1474,14 @@
 	struct	ahc_initiator_tinfo *targ_info;
 	struct	ahc_tmode_tstate *tstate;
 	uint8_t tags;
+	struct scsi_path_id path;
+
+	scsi_get_path(device, &path);
 
 	ahc_compile_devinfo(&devinfo,
-			    device->channel == 0 ? ahc->our_id : ahc->our_id_b,
-			    device->id, device->lun,
-			    device->channel == 0 ? 'A' : 'B',
+			    path.spi_channel == 0 ? ahc->our_id : ahc->our_id_b,
+			    path.spi_id, path.spi_lun,
+			    path.spi_channel == 0 ? 'A' : 'B',
 			    ROLE_INITIATOR);
 	targ_info = ahc_fetch_transinfo(ahc, devinfo.channel,
 					devinfo.our_scsiid,
@@ -1506,8 +1513,8 @@
 		/* device->queue_depth = tags; */
 		ahc_set_tags(ahc, &devinfo, AHC_QUEUE_TAGGED);
 		printf("scsi%d:%c:%d:%d: Tagged Queuing enabled.  Depth %d\n",
-	       	       ahc->platform_data->host->host_no, device->channel + 'A',
-		       device->id, device->lun, tags);
+	       	       ahc->platform_data->host->host_no, path.spi_channel + 'A',
+		       path.spi_id, path.spi_lun, tags);
 	} else {
 		/*
 		 * We allow the OS to queue 2 untagged transactions to
@@ -1516,7 +1523,7 @@
 		 * some latency.
 		device->queue_depth = 2;
 		 */
-		scsi_adjust_queue_depth(device, 0, device->host->cmd_per_lun);
+		scsi_adjust_queue_depth(device, 0, path.spi_shpnt->cmd_per_lun);
 	}
 }
 
@@ -2727,8 +2734,10 @@
 	int	extended;
 	struct	ahc_softc *ahc;
 	unsigned char *buf;
+	struct scsi_path_id path;
 
-	ahc = *((struct ahc_softc **)disk->device->host->hostdata);
+	scsi_get_path(disk->device, &path);
+	ahc = *((struct ahc_softc **)path.spi_shpnt->hostdata);
 	buf = scsi_bios_ptable(bdev);
 
 	if (buf) {
@@ -2744,7 +2753,7 @@
 
 	if (aic7xxx_extended != 0)
 		extended = 1;
-	else if (disk->device->channel == 0)
+	else if (path.spi_channel == 0)
 		extended = (ahc->flags & AHC_EXTENDED_TRANS_A) != 0;
 	else
 		extended = (ahc->flags & AHC_EXTENDED_TRANS_B) != 0;
diff -Nru a/drivers/scsi/ips.c b/drivers/scsi/ips.c
--- a/drivers/scsi/ips.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/ips.c	Fri Oct 25 11:26:47 2002
@@ -1782,10 +1782,15 @@
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
@@ -1877,8 +1882,12 @@
 {
    ips_ha_t    *ha;
    int          min;
+   struct Scsi_Host   *sh;
 
-   ha = IPS_HA(SDptr->host);
+   sh = scsi_get_host(SDptr);
+   if (!sh)
+	   return 1;
+   ha = IPS_HA(sh);
    if (SDptr->tagged_supported) {
       min = ha->max_cmds / 2;
       if (min <= 16)
diff -Nru a/drivers/scsi/qlogicfc.c b/drivers/scsi/qlogicfc.c
--- a/drivers/scsi/qlogicfc.c	Fri Oct 25 11:26:48 2002
+++ b/drivers/scsi/qlogicfc.c	Fri Oct 25 11:26:48 2002
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
 
