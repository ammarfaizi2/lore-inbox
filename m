Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293466AbSCFLW1>; Wed, 6 Mar 2002 06:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293469AbSCFLWT>; Wed, 6 Mar 2002 06:22:19 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:45709 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S293466AbSCFLWP>; Wed, 6 Mar 2002 06:22:15 -0500
Date: Wed, 6 Mar 2002 03:22:13 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Patch?: Centralized DMA mapping in linux-2.5.6-pre2/drivers/scsi/scsi.c
Message-ID: <20020306032213.A8450@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I have been exploring the daunting task of trying to port
the numerous scsi drivers in 2.5.6-pre2 that no longer build to
the DMA mapping interface described in Documentation/DMA-mapping.txt.
There are approximately 90 scsi host controller drivers in Linus's
tree.  I believe that most of the effected drivers will need to
implement almost exactly the same code.

	So, I have created the following patch which defines two
new flags that scsi host templates can set, which tell scsi.c to
handle mapping (and unmapping) or Scsi_Request.request_buffer and
Scsi_Request.sense_buffer, respectively (some drivers have no use
for mapping sense_buffer).  All of the executable code is contained
in two static routines, scsi_map_dma and scsi_unmap_dma.  So, the
patch should be pretty readable.

	I believe this approach has the following advantages:

		o less code to maintain
		o faster cleanup of drivers/scsi
		o saves a few bytes of system size if more than one
		  device driver
		o drivers that do not use this facility should be unaffected,
		o easier to make changes in the future, for example:
			- scsi_map_dma could change all requests
			  that have use_sg=0 to one that have use_sg=1,
			  so drivers could eliminate the use_sg=0 case
			  before it becomes necessary to change all clients
			  to avoid use_sg=0.
			- Perhaps DMA mapping could be moved out to
			  scsi_allocate_device and scsi_release_request,
			  so that it could be done a little less often.
			- Perhaps allocate sense_buffer or request_buffer
			  via pci_pool_alloc, so it can be allocated from
			  high memory on systems that can DMA to it.

	Here are some small disadvantages, and why this the change is worth it.

		o Any driver that does not use named initializers for
		  its Scsi_Host_Template will break, but it's really unlikely
		  that such drivers have been maintained to reflect the
		  other 2.5 changes and not have named initializers.

		o This change 20 bytes to Scsi_Request, but its a big
		  data structure to begin with and some of that
		  size can be made up if we can eliminate the use_sg=0
		  and, in many cases, the new variables are eliminating
		  the need to create the same variables in driver private
		  data.

		o Right now, I only know that it compiles and links without
		  undefined symbols, but drivers that do not set the new
		  flags should not be affected.

	Comments?  Bugs in my implementation?

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmamap.diff"

--- linux-2.5.6-pre2/drivers/scsi/hosts.h	Tue Feb 19 18:10:59 2002
+++ linux/drivers/scsi/hosts.h	Wed Mar  6 01:10:44 2002
@@ -286,6 +286,11 @@
 
     unsigned highmem_io:1;
 
+    /* Have the high level code automatically handle DMA mapping of
+       Scsi_Request->request_buffer and Scsi_Request->sense_buf. */
+    unsigned dma_map_request:1;
+    unsigned dma_map_sense:1;
+
     /*
      * Name of proc directory
      */
--- linux-2.5.6-pre2/drivers/scsi/scsi.h	Tue Feb 19 18:10:58 2002
+++ linux/drivers/scsi/scsi.h	Wed Mar  6 02:31:05 2002
@@ -734,12 +732,14 @@
 
 	struct timer_list eh_timeout;	/* Used to time out the command. */
 	void *request_buffer;		/* Actual requested buffer */
+	dma_addr_t request_dma_addr;
 
 	/* These elements define the operation we ultimately want to perform */
 	unsigned char data_cmnd[MAX_COMMAND_SIZE];
 	unsigned short old_use_sg;	/* We save  use_sg here when requesting
 					 * sense info */
 	unsigned short use_sg;	/* Number of pieces of scatter-gather */
+	unsigned short sgcnt_dma;	/* Returned by pci_map_sg. */
 	unsigned short sglist_len;	/* size of malloc'd scatter-gather list */
 	unsigned short abort_reason;	/* If the mid-level code requests an
 					 * abort, this is the reason. */
@@ -768,6 +768,7 @@
 						 * when CHECK CONDITION is
 						 * received on original command 
 						 * (auto-sense) */
+	dma_addr_t sense_dma_addr;
 
 	unsigned flags;
 
--- linux-2.5.6-pre2/drivers/scsi/scsi.c	Tue Feb 19 18:11:03 2002
+++ linux/drivers/scsi/scsi.c	Wed Mar  6 02:43:55 2002
@@ -309,6 +309,76 @@
 	return SRpnt;
 }
 
+static inline void
+scsi_unmap_dma(Scsi_Cmnd *cmd)
+{
+	const Scsi_Host_Template *template = cmd->host->hostt;
+
+	/* TODO: Simplify device drivers by having this routine rebuild
+	   any cmd->use_sg==0 request as a cmd->use_sg==1 request. */
+
+	if (template->dma_map_request) {
+		int dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+		if (cmd->use_sg)
+			pci_unmap_sg(cmd->host->pci_dev,
+				     (struct scatterlist*)cmd->request_buffer,
+				     cmd->use_sg,
+				     dma_dir);
+		else if (cmd->request_bufflen)
+			pci_unmap_single(cmd->host->pci_dev,
+					 cmd->request_dma_addr,
+					 cmd->request_bufflen,
+					 dma_dir);
+	}
+
+	if (template->dma_map_sense && cmd->sense_dma_addr)
+		pci_unmap_single(cmd->host->pci_dev,
+				 cmd->sense_dma_addr,
+				 sizeof(cmd->sense_buffer),
+				 PCI_DMA_FROMDEVICE);
+}
+
+static inline int
+scsi_map_dma(Scsi_Cmnd *cmd)
+{
+	const Scsi_Host_Template *template = cmd->host->hostt;
+
+	/* TODO: Simplify device drivers by having this routine rebuild
+	   any cmd->use_sg==0 request as a cmd->use_sg==1 request. */
+
+	if (template->dma_map_request) {
+		int dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+		if (cmd->use_sg) {
+			cmd->sgcnt_dma = pci_map_sg(cmd->host->pci_dev,
+						    (struct scatterlist*)
+						    cmd->request_buffer,
+						    cmd->use_sg,
+						    dma_dir);
+			if (cmd->sgcnt_dma <= 0)
+				return -EBUSY;
+		} else if (cmd->request_bufflen) {
+			cmd->request_dma_addr =
+				pci_map_single(cmd->host->pci_dev,
+					       cmd->request_buffer,
+					       cmd->request_bufflen,
+					       dma_dir);
+			if (!cmd->request_dma_addr)
+				return -EBUSY;
+		}
+	}
+	if (template->dma_map_sense) {
+		cmd->sense_dma_addr = pci_map_single(cmd->host->pci_dev,
+						     cmd->sense_buffer,
+						     sizeof(cmd->sense_buffer),
+						     PCI_DMA_FROMDEVICE);
+		if (!cmd->sense_dma_addr) {
+			scsi_unmap_dma(cmd);
+			return -EBUSY;
+		}
+	}
+	return 0;
+}
+
 /*
  * Function:    scsi_release_request
  *
@@ -706,6 +776,7 @@
 		 * length exceeds what the host adapter can handle.
 		 */
 		if (CDB_SIZE(SCpnt) <= SCpnt->host->max_cmd_len) {
+			scsi_map_dma(SCpnt);
 			spin_lock_irqsave(host->host_lock, flags);
 			rtn = host->hostt->queuecommand(SCpnt, scsi_done);
 			spin_unlock_irqrestore(host->host_lock, flags);
@@ -1146,6 +1217,7 @@
 		SCSI_LOG_MLCOMPLETE(1, printk("Ignoring completion of %p due to timeout status", SCpnt));
 		return;
 	}
+	scsi_unmap_dma(SCpnt);
 	spin_lock_irqsave(&scsi_bhqueue_lock, flags);
 
 	SCpnt->serial_number_at_timeout = 0;

--AqsLC8rIMeq19msA--
