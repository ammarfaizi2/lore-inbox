Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbSJYUAS>; Fri, 25 Oct 2002 16:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbSJYUAS>; Fri, 25 Oct 2002 16:00:18 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:7176 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261578AbSJYT61>; Fri, 25 Oct 2002 15:58:27 -0400
Date: Fri, 25 Oct 2002 14:00:55 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Message-ID: <20021025140055.B1224@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DESC

Allow cciss driver to use more then 31 scatter gather elements

 drivers/block/Config.help  |   12 ++
 drivers/block/Config.in    |    3 
 drivers/block/cciss.c      |  261 ++++++++++++++++++++++++++++++++++-----------
 drivers/block/cciss.h      |   10 +
 drivers/block/cciss_cmd.h  |   12 ++
 drivers/block/cciss_scsi.c |   26 ++++
 6 files changed, 261 insertions, 63 deletions

--- lx2544ac3/drivers/block/cciss.c~sgc3	Fri Oct 25 13:46:12 2002
+++ lx2544ac3-scameron/drivers/block/cciss.c	Fri Oct 25 13:46:12 2002
@@ -37,6 +37,7 @@
 #include <linux/init.h> 
 #include <linux/hdreg.h>
 #include <linux/spinlock.h>
+#include <linux/completion.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -164,7 +165,7 @@ static int cciss_proc_get_info(char *buf
                 "       Current Q depth: %d\n"
                 "       Max Q depth since init: %d\n"
 		"       Max # commands on controller since init: %d\n"
-		"       Max SG entries since init: %d\n\n",
+		"       Max SG entries since init: %d/%d\n\n",
                 h->devname,
                 h->product_name,
                 (unsigned long)h->board_id,
@@ -173,7 +174,8 @@ static int cciss_proc_get_info(char *buf
                 (unsigned int)h->intr,
                 h->num_luns, 
                 h->highest_lun, 
-                h->Qdepth, h->maxQsinceinit, h->max_outstanding, h->maxSG);
+                h->Qdepth, h->maxQsinceinit, h->max_outstanding, h->maxSG,
+		CONFIG_CISS_MAX_SG_PAGES * MAXSGENTRIES);
 
         pos += size; len += size;
 	cciss_proc_tape_report(ctlr, buffer, &pos, &len);
@@ -248,6 +250,44 @@ static void __init cciss_procinit(int i)
 }
 #endif /* CONFIG_PROC_FS */
 
+static int supports_sg_chaining(ctlr_info_t *h)
+{
+	int fw_ver =	(h->firm_ver[0] - '0') * 100 + /* [1] == '.', skip */
+			(h->firm_ver[2] - '0') * 10 +
+			(h->firm_ver[3] - '0');
+	/* 1st generation controllers need >= 2.32 firmware */
+	if (h->pdev->device == PCI_DEVICE_ID_COMPAQ_CISS)
+		return (fw_ver >= 232);
+	/* 2nd generation controllers need >= 1.78 firmware */
+	if (h->pdev->device == PCI_DEVICE_ID_COMPAQ_CISSB)
+		return (fw_ver >= 178);
+	/* All controllers >= 3rd generation (will) support this. */
+	return 1;
+}
+
+static void cciss_allocate_extra_sg_pages(int ctlr)
+{
+	/* Allocate extra SG list pages if supported and requested */
+	if (supports_sg_chaining(hba[ctlr]) && CONFIG_CISS_MAX_SG_PAGES > 1) {
+		hba[ctlr]->sglist_pool = (SGDescriptor_struct *)
+		pci_alloc_consistent(hba[ctlr]->pdev,
+			(CONFIG_CISS_MAX_SG_PAGES-1) * MAXSGENTRIES *
+				NR_CMDS * sizeof(SGDescriptor_struct),
+			&(hba[ctlr]->sglist_pool_dhandle));
+		if (hba[ctlr]->sglist_pool == NULL)
+			printk(KERN_WARNING "cciss%d: Scatter-gather list "
+				"chaining not enabled.", ctlr);
+	}
+}
+
+static inline int figure_sg_limit(int i)
+{
+	/* figure out how many SGs we can allow block system to send us */
+	if (supports_sg_chaining(hba[i]) && hba[i]->sglist_pool != NULL)
+		return CONFIG_CISS_MAX_SG_PAGES * (MAXSGENTRIES-1);
+	return MAXSGENTRIES; /* no SG list chaining. */
+}
+
 /* 
  * For operations that cannot sleep, a command block is allocated at init, 
  * and managed by cmd_alloc() and cmd_free() using a simple bitmap to track
@@ -258,7 +298,7 @@ static void __init cciss_procinit(int i)
 static CommandList_struct * cmd_alloc(ctlr_info_t *h, int get_from_pool)
 {
 	CommandList_struct *c;
-	int i; 
+	int i, j;
 	u64bit temp64;
 	dma_addr_t cmd_dma_handle, err_dma_handle;
 
@@ -273,14 +313,40 @@ static CommandList_struct * cmd_alloc(ct
 		c->err_info = (ErrorInfo_struct *)pci_alloc_consistent(
 					h->pdev, sizeof(ErrorInfo_struct), 
 					&err_dma_handle);
-	
-		if (c->err_info == NULL)
-		{
+
+		if (c->err_info == NULL) {
 			pci_free_consistent(h->pdev, 
 				sizeof(CommandList_struct), c, cmd_dma_handle);
 			return NULL;
 		}
+		c->sgdlist[0].sgd = c->SG;
+		c->sgdlist[0].dma = cmd_dma_handle +
+			((void *) c->SG - (void *) c);
 		memset(c->err_info, 0, sizeof(ErrorInfo_struct));
+
+		if (h->sglist_pool != NULL) {
+			c->sgdlist[1].sgd = (SGDescriptor_struct *)
+				pci_alloc_consistent(h->pdev, SGD_SIZE *
+					(CONFIG_CISS_MAX_SG_PAGES - 1),
+					&c->sgdlist[0].dma);
+
+			if (c->sgdlist[1].sgd == NULL) {
+				pci_free_consistent(h->pdev,
+					sizeof(ErrorInfo_struct), c->err_info,
+					err_dma_handle);
+				pci_free_consistent(h->pdev,
+					sizeof(CommandList_struct), c,
+					cmd_dma_handle);
+				return NULL;
+			}
+			memset(&c->sgdlist[0].sgd[0], 0, SGD_SIZE);
+			for (j=1;j<CONFIG_CISS_MAX_SG_PAGES-1; j++) {
+				c->sgdlist[j+1].sgd =
+					(void *)c->sgdlist[j].sgd+j*SGD_SIZE;
+				c->sgdlist[j+1].dma =
+					c->sgdlist[j].dma + j * SGD_SIZE;
+			}
+		}
 	} else /* get it out of the controllers pool */ 
 	{
 	     	do {
@@ -300,6 +366,22 @@ static CommandList_struct * cmd_alloc(ct
 		err_dma_handle = h->errinfo_pool_dhandle 
 					+ i*sizeof(ErrorInfo_struct);
                 h->nr_allocs++;
+		c->sgdlist[0].sgd = c->SG;
+		c->sgdlist[0].dma = cmd_dma_handle +
+			((void *) c->SG - (void *) c);
+		if (h->sglist_pool != NULL)
+			for (j=0; j < CONFIG_CISS_MAX_SG_PAGES-1 ; j++) {
+				c->sgdlist[j+1].sgd =
+					(void *) h->sglist_pool +
+					SGD_SIZE *
+					(i * (CONFIG_CISS_MAX_SG_PAGES - 1)+j);
+				// This memset is paranoia. 
+				// memset(c->sgdlist[j+1].sgd, 0, SGD_SIZE);
+				c->sgdlist[j+1].dma =
+					h->sglist_pool_dhandle +
+					SGD_SIZE *
+					(i * (CONFIG_CISS_MAX_SG_PAGES - 1)+j);
+			}
         }
 
 	c->busaddr = (__u32) cmd_dma_handle;
@@ -307,11 +389,8 @@ static CommandList_struct * cmd_alloc(ct
 	c->ErrDesc.Addr.lower = temp64.val32.lower;
 	c->ErrDesc.Addr.upper = temp64.val32.upper;
 	c->ErrDesc.Len = sizeof(ErrorInfo_struct);
-	
 	c->ctlr = h->ctlr;
-        return c;
-
-
+	return c;
 }
 
 /* 
@@ -326,6 +405,9 @@ static void cmd_free(ctlr_info_t *h, Com
 	{ 
 		temp64.val32.lower = c->ErrDesc.Addr.lower;
 		temp64.val32.upper = c->ErrDesc.Addr.upper;
+		pci_free_consistent(h->pdev, SGD_SIZE *
+			CONFIG_CISS_MAX_SG_PAGES,
+			c->sgdlist[0].sgd, c->sgdlist[0].dma);
 		pci_free_consistent(h->pdev, sizeof(ErrorInfo_struct), 
 			c->err_info, (dma_addr_t) temp64.val);
 		pci_free_consistent(h->pdev, sizeof(CommandList_struct), 
@@ -1768,6 +1850,50 @@ static inline void complete_command( ctl
 	cmd_free(h,cmd,1);
 }
 
+struct sg_setup_data {
+	int total_sgs;
+	int sgelem;
+	int sgd_number;
+	int dir;
+	CommandList_struct *c;
+};
+
+static void
+cciss_setup_sg(struct scatterlist *sg, struct sg_setup_data *sgs)
+{
+	/* this function gets called back by blk_rq_map_sg_one_by_one
+	   once for each scatter gather element. */
+
+	SGDescriptor_struct *sgd;
+	ctlr_info_t *h = hba[sgs->c->ctlr];
+	u64bit temp64;
+
+	sgd = &sgs->c->sgdlist[sgs->sgd_number].sgd[sgs->sgelem];
+
+	/* if we can chain, and we hit end of page, chain to new SG page */
+	if (sgs->sgelem == MAXSGENTRIES-1 && h->sglist_pool != NULL) {
+		sgs->sgd_number++;	// Move on to the next SG page
+		/* Set this SG elem to point to phys addr of next SG page */
+		temp64.val = (__u64) sgs->c->sgdlist[sgs->sgd_number].dma;
+		sgd->Addr.lower = temp64.val32.lower;
+		sgd->Addr.upper = temp64.val32.upper;
+		sgd->Ext = 0x80000000;	// mark as a pointer to next SG page
+		sgd->Len = SGD_SIZE;	// total no. of bytes in a SG page.
+					// (probably wrong for the last page.)
+		sgd = &sgs->c->sgdlist[sgs->sgd_number].sgd[0];
+		sgs->sgelem = 0;	// Start at SG zero on the new SG page
+		sgs->total_sgs++;	// ptrs to SG pages count as SG elems.
+	}
+	temp64.val = (__u64) pci_map_page(h->pdev, sg->page, sg->offset,
+				sg->length, sgs->dir);
+	sgd->Addr.lower = temp64.val32.lower;
+	sgd->Addr.upper = temp64.val32.upper;
+	sgd->Len = sg->length;
+	sgd->Ext = 0;		// Ordinary SG element, not a ptr to SG page
+	sgs->sgelem++;		// move on to next SG element on this page.
+	sgs->total_sgs++;
+}
+
 /* 
  * Get a request and submit it to the controller. 
  */
@@ -1777,10 +1903,8 @@ static void do_cciss_request(request_que
 	CommandList_struct *c;
 	int start_blk, seg;
 	struct request *creq;
-	u64bit temp64;
-	struct scatterlist tmp_sg[MAXSGENTRIES];
 	drive_info_struct *drv;
-	int i, dir;
+	struct sg_setup_data sgs;
 
 	if (blk_queue_plugged(q))
 		goto startio;
@@ -1790,7 +1914,7 @@ queue:
 		goto startio;
 
 	creq = elv_next_request(q);
-	if (creq->nr_phys_segments > MAXSGENTRIES)
+	if (creq->nr_phys_segments > h->sg_limit)
                 BUG();
 
 	if (( c = cmd_alloc(h, 1)) == NULL)
@@ -1822,33 +1946,32 @@ queue:
 		(int) creq->nr_sectors);	
 #endif /* CCISS_DEBUG */
 
-	seg = blk_rq_map_sg(q, creq, tmp_sg);
-
-	/* get the DMA records for the setup */ 
-	if (c->Request.Type.Direction == XFER_READ)
-		dir = PCI_DMA_FROMDEVICE;
-	else
-		dir = PCI_DMA_TODEVICE;
+	sgs.c = c;
+	sgs.sgelem = 0;
+	sgs.sgd_number = 0;
+	sgs.total_sgs = 0;
+	sgs.dir = (c->Request.Type.Direction == XFER_READ) ?
+			PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE;
+	seg = blk_rq_map_sg_one_by_one(q, creq,
+			(consume_sg_callback) cciss_setup_sg, &sgs);
 
-	for (i=0; i<seg; i++)
-	{
-		c->SG[i].Len = tmp_sg[i].length;
-		temp64.val = (__u64) pci_map_page(h->pdev, tmp_sg[i].page,
-			 		  tmp_sg[i].offset, tmp_sg[i].length,
-					  dir);
-		c->SG[i].Addr.lower = temp64.val32.lower;
-                c->SG[i].Addr.upper = temp64.val32.upper;
-                c->SG[i].Ext = 0;  // we are not chaining
-	}
 	/* track how many SG entries we are using */ 
-	if( seg > h->maxSG)
-		h->maxSG = seg; 
+	if( sgs.total_sgs > h->maxSG)
+		h->maxSG = sgs.total_sgs;
 
 #ifdef CCISS_DEBUG
 	printk(KERN_DEBUG "cciss: Submitting %d sectors in %d segments\n", creq->nr_sectors, seg);
 #endif /* CCISS_DEBUG */
 
-	c->Header.SGList = c->Header.SGTotal = seg;
+	if (sgs.total_sgs > MAXSGENTRIES) {
+		c->Header.SGList = MAXSGENTRIES;
+		/* fixup last chained sg page length, probably not SGD_SIZE. */
+		c->sgdlist[sgs.sgd_number-1].sgd[MAXSGENTRIES-1].Len =
+			sgs.sgelem * sizeof(SGDescriptor_struct);
+	} else
+		c->Header.SGList = sgs.total_sgs;
+
+	c->Header.SGTotal = sgs.total_sgs;
 	c->Request.CDB[1]= 0;
 	c->Request.CDB[2]= (start_blk >> 24) & 0xff;	//MSB
 	c->Request.CDB[3]= (start_blk >> 16) & 0xff;
@@ -2316,6 +2439,33 @@ static void free_hba(int i)
 	kfree(p);
 }
 
+
+static void bail_out(int i)
+{
+	if(hba[i]->cmd_pool_bits)
+		kfree(hba[i]->cmd_pool_bits);
+	if(hba[i]->cmd_pool)
+		pci_free_consistent(hba[i]->pdev,
+			NR_CMDS * sizeof(CommandList_struct),
+			hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
+	if(hba[i]->errinfo_pool)
+		pci_free_consistent(hba[i]->pdev,
+			NR_CMDS * sizeof( ErrorInfo_struct),
+			hba[i]->errinfo_pool,
+			hba[i]->errinfo_pool_dhandle);
+	if (hba[i]->sglist_pool != NULL)
+		pci_free_consistent(hba[i]->pdev,
+			(CONFIG_CISS_MAX_SG_PAGES-1) * MAXSGENTRIES *
+				NR_CMDS * sizeof(SGDescriptor_struct),
+			hba[i]->sglist_pool,
+			hba[i]->sglist_pool_dhandle);
+	free_irq(hba[i]->intr, hba[i]);
+	unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
+	release_io_mem(hba[i]);
+	free_hba(i);
+	printk( KERN_ERR "cciss: out of memory");
+}
+
 /*
  *  This is it.  Find all the controllers and register them.  I really hate
  *  stealing all these major device numbers.
@@ -2364,6 +2514,11 @@ static int __init cciss_init_one(struct 
 		free_hba(i);
 		return(-1);
 	}
+	/* Assume we can't do SG page chaining until we know otherwise */
+	hba[i]->sglist_pool = NULL;
+	hba[i]->sglist_pool_dhandle = (dma_addr_t) NULL;
+	hba[i]->sg_limit = MAXSGENTRIES;
+
 	/* make sure the board interrupts are off */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_OFF);
 	if( request_irq(hba[i]->intr, do_cciss_intr, 
@@ -2386,24 +2541,8 @@ static int __init cciss_init_one(struct 
 		&(hba[i]->errinfo_pool_dhandle));
 	if((hba[i]->cmd_pool_bits == NULL) 
 		|| (hba[i]->cmd_pool == NULL)
-		|| (hba[i]->errinfo_pool == NULL))
-        {
-		if(hba[i]->cmd_pool_bits)
-                	kfree(hba[i]->cmd_pool_bits);
-                if(hba[i]->cmd_pool)
-                	pci_free_consistent(hba[i]->pdev,  
-				NR_CMDS * sizeof(CommandList_struct), 
-				hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);	
-		if(hba[i]->errinfo_pool)
-			pci_free_consistent(hba[i]->pdev,
-				NR_CMDS * sizeof( ErrorInfo_struct),
-				hba[i]->errinfo_pool, 
-				hba[i]->errinfo_pool_dhandle);
-                free_irq(hba[i]->intr, hba[i]);
-                unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
-		release_io_mem(hba[i]);
-		free_hba(i);
-                printk( KERN_ERR "cciss: out of memory");
+		|| (hba[i]->errinfo_pool == NULL)) {
+		bail_out(i);
 		return(-1);
 	}
 
@@ -2419,7 +2558,7 @@ static int __init cciss_init_one(struct 
 #endif /* CCISS_DEBUG */
 
 	cciss_getgeometry(i);
-
+	cciss_allocate_extra_sg_pages(i);
 	cciss_scsi_setup(i);
 
 	/* Turn the interrupts on so we can service requests */
@@ -2427,21 +2566,16 @@ static int __init cciss_init_one(struct 
 
 	cciss_procinit(i);
 
+	hba[i]->sg_limit = figure_sg_limit(i);
 	q = &hba[i]->queue;
         q->queuedata = hba[i];
 	spin_lock_init(&hba[i]->lock);
         blk_init_queue(q, do_cciss_request, &hba[i]->lock);
 	blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
-
-	/* This is a hardware imposed limit. */
-	blk_queue_max_hw_segments(q, MAXSGENTRIES);
-
-	/* This is a limit in the driver and could be eliminated. */
-	blk_queue_max_phys_segments(q, MAXSGENTRIES);
-
+	blk_queue_max_hw_segments(q, hba[i]->sg_limit);
+	blk_queue_max_phys_segments(q, hba[i]->sg_limit);
 	blk_queue_max_sectors(q, 512);
 
-
 	for(j=0; j<NWD; j++) {
 		drive_info_struct *drv = &(hba[i]->drv[j]);
 		struct gendisk *disk = hba[i]->gendisk[j];
@@ -2509,6 +2643,11 @@ static void __devexit cciss_remove_one (
 			    hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof( ErrorInfo_struct),
 		hba[i]->errinfo_pool, hba[i]->errinfo_pool_dhandle);
+	if (hba[i]->sglist_pool != NULL)
+		pci_free_consistent(hba[i]->pdev,
+			(CONFIG_CISS_MAX_SG_PAGES-1) * MAXSGENTRIES *
+				NR_CMDS * sizeof(SGDescriptor_struct),
+			hba[i]->sglist_pool, hba[i]->sglist_pool_dhandle);
 	kfree(hba[i]->cmd_pool_bits);
  	release_io_mem(hba[i]);
 	free_hba(i);
--- lx2544ac3/drivers/block/cciss_cmd.h~sgc3	Fri Oct 25 13:46:12 2002
+++ lx2544ac3-scameron/drivers/block/cciss_cmd.h	Fri Oct 25 13:46:12 2002
@@ -7,6 +7,10 @@
 
 //general boundary defintions
 #define SENSEINFOBYTES          32//note that this value may vary between host implementations
+
+/* MAXSGENTRIES is the max scatter gather entries per SG page,
+   some adapters support chaining SG pages, using the last SG
+   entry to point to the next SG page. */
 #define MAXSGENTRIES            31
 #define MAXREPLYQS              256
 
@@ -197,6 +201,8 @@ typedef struct _SGDescriptor_struct {
   DWORD  Ext;
 } SGDescriptor_struct;
 
+#define SGD_SIZE (sizeof(SGDescriptor_struct) * MAXSGENTRIES)
+
 typedef union _MoreErrInfo_struct{
   struct {
     BYTE  Reserved[3];
@@ -226,6 +232,11 @@ typedef struct _ErrorInfo_struct {
 #define CMD_MSG_DONE	0x04
 #define CMD_MSG_TIMEOUT 0x05
 
+struct sgd_list_t {
+	SGDescriptor_struct *sgd;
+	dma_addr_t dma;
+};
+
 typedef struct _CommandList_struct {
   CommandListHeader_struct Header;
   RequestBlock_struct      Request;
@@ -241,6 +252,7 @@ typedef struct _CommandList_struct {
   struct request *	   rq;
   struct completion *waiting;
   int	 retry_count;
+  struct sgd_list_t sgdlist[CONFIG_CISS_MAX_SG_PAGES];
 #ifdef CONFIG_CISS_SCSI_TAPE
   void * scsi_cmd;
 #endif
--- lx2544ac3/drivers/block/cciss.h~sgc3	Fri Oct 25 13:46:12 2002
+++ lx2544ac3-scameron/drivers/block/cciss.h	Fri Oct 25 13:46:12 2002
@@ -36,6 +36,13 @@ typedef struct _drive_info_struct
 	int 	cylinders;
 } drive_info_struct;
 
+#if CONFIG_CISS_MAX_SG_PAGES < 1
+#error "CONFIG_CISS_MAX_SG_PAGES must be greater than 0 and less than 9"
+#elif CONFIG_CISS_MAX_SG_PAGES > 8
+/* eight is rather arbitrary...no real limit here. */
+#error "CONFIG_CISS_MAX_SG_PAGES must be greater than 0 and less than 9"
+#endif
+
 struct ctlr_info 
 {
 	int	ctlr;
@@ -77,9 +84,12 @@ struct ctlr_info 
 	dma_addr_t		cmd_pool_dhandle; 
 	ErrorInfo_struct 	*errinfo_pool;
 	dma_addr_t		errinfo_pool_dhandle; 
+	SGDescriptor_struct	*sglist_pool;
+	dma_addr_t		sglist_pool_dhandle;
         unsigned long  		*cmd_pool_bits;
 	int			nr_allocs;
 	int			nr_frees; 
+	int			sg_limit;
 
 	// Disk structures we need to pass back
 	struct gendisk   *gendisk[NWD];
--- lx2544ac3/drivers/block/cciss_scsi.c~sgc3	Fri Oct 25 13:46:12 2002
+++ lx2544ac3-scameron/drivers/block/cciss_scsi.c	Fri Oct 25 13:46:12 2002
@@ -257,7 +257,7 @@ scsi_cmd_stack_free(int ctlr)
 	"Unknown" : scsi_device_types[n]
 
 #if 0
-static int xmargin=8;
+static int xmargin=24;
 static int amargin=60;
 
 static void
@@ -297,6 +297,10 @@ print_bytes (unsigned char *c, int len, 
 static void
 print_cmd(CommandList_struct *cp)
 {
+	int i;
+	int sg, sgp;
+	SGDescriptor_struct *sgd;
+
 	printk("queue:%d\n", cp->Header.ReplyQueue);
 	printk("sglist:%d\n", cp->Header.SGList);
 	printk("sgtot:%d\n", cp->Header.SGTotal);
@@ -329,7 +333,25 @@ print_cmd(CommandList_struct *cp)
 	printk("edesc.Addr: 0x%08x/0%08x, Len  = %d\n", 
 		cp->ErrDesc.Addr.upper, cp->ErrDesc.Addr.lower, 
 			cp->ErrDesc.Len);
-	printk("sgs..........Errorinfo:\n");
+	printk("SGS:\n");
+	sgp = 0; sg = 0;
+	sgd = cp->sgdlist[sgp].sgd;
+	for (i=0;i<cp->Header.SGTotal;i++) {
+		printk("0x%08x%08x : %d: %d %s\n", sgd[sg].Addr.upper,
+			sgd[sg].Addr.lower, sgd[sg].Len,
+			sgd[sg].Ext, sg >= MAXSGENTRIES-1 ? " chain" : "");
+
+		if (sg == MAXSGENTRIES-1 && ! sgd[sg].Ext &&
+			cp->Header.SGTotal != cp->Header.SGList)
+			printk("Extended SG bit expected, but not set!\n");
+		sg++;
+		if (sg >= MAXSGENTRIES) {
+			sg = 0;
+			sgp++;
+			sgd = cp->sgdlist[sgp].sgd;
+		}
+	}
+	printk("Errorinfo:\n");
 	printk("scsistatus:%d\n", cp->err_info->ScsiStatus);
 	printk("senselen:%d\n", cp->err_info->SenseLen);
 	printk("cmd status:%d\n", cp->err_info->CommandStatus);
--- lx2544ac3/drivers/block/Config.help~sgc3	Fri Oct 25 13:46:12 2002
+++ lx2544ac3-scameron/drivers/block/Config.help	Fri Oct 25 13:46:12 2002
@@ -196,6 +196,18 @@ CONFIG_BLK_CPQ_CISS_DA
   boards supported by this driver, and for further information
   on the use of this driver.
 
+CONFIG_CISS_MAX_SG_PAGES
+  This is the number of scatter gather pages to allocate for 
+  each command.  Each page can hold up to 31 address/length 
+  pairs.  The minimum and default value is 1 page.  You may observe 
+  the values reported in /proc/driver/cciss/cciss* for "Max SG 
+  entries since init X/Y".  These two values, X and Y, are the 
+  maximum number of address/length pairs used by any one command 
+  so far, and the total number of address/length pairs available 
+  to each command respectively.  If, after running a typical load,
+  X == Y, then adding another page may help.  If Y - X > 31,
+  then subtracting a page may help.
+
 CONFIG_CISS_SCSI_TAPE
   When enabled (Y), this option allows SCSI tape drives and SCSI medium
   changers (tape robots) to be accessed via a Compaq 5xxx array 
--- lx2544ac3/drivers/block/Config.in~sgc3	Fri Oct 25 13:46:12 2002
+++ lx2544ac3-scameron/drivers/block/Config.in	Fri Oct 25 13:46:12 2002
@@ -35,6 +35,9 @@ if [ "$CONFIG_PARIDE" = "y" -o "$CONFIG_
 fi
 dep_tristate 'Compaq SMART2 support' CONFIG_BLK_CPQ_DA $CONFIG_PCI
 dep_tristate 'Compaq Smart Array 5xxx support' CONFIG_BLK_CPQ_CISS_DA $CONFIG_PCI 
+if [ "$CONFIG_BLK_CPQ_CISS_DA" = "y" -o "$CONFIG_BLK_CPQ_CISS_DA" = "m" ]; then
+	int '       Maximum scatter gather pages per command (1-8)' CONFIG_CISS_MAX_SG_PAGES 1
+fi
 dep_mbool '       SCSI tape drive support for Smart Array 5xxx' CONFIG_CISS_SCSI_TAPE $CONFIG_BLK_CPQ_CISS_DA $CONFIG_SCSI
 dep_tristate 'Mylex DAC960/DAC1100 PCI RAID Controller support' CONFIG_BLK_DEV_DAC960 $CONFIG_PCI
 dep_tristate 'Micro Memory MM5415 Battery Backed RAM support (EXPERIMENTAL)' CONFIG_BLK_DEV_UMEM $CONFIG_PCI $CONFIG_EXPERIMENTAL

.
