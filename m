Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVETANe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVETANe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 20:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVETANd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 20:13:33 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:33222 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261338AbVESX4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:56:48 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: dino@in.ibm.com
Cc: "K.R. Foley" <kr@cybsft.com>, Andrew Morton <akpm@osdl.org>,
       gregoire.favre@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050519095143.GA3972@in.ibm.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave> <428C030E.8030102@cybsft.com>
	 <1116476630.5867.2.camel@mulgrave>  <20050519095143.GA3972@in.ibm.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 18:56:10 -0500
Message-Id: <1116546970.5037.137.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 15:21 +0530, Dinakar Guniguntala wrote:
> This doesn't seem to fix the problem :(
> I tried both 2.6.12-rc4+patch and 2.6.4-rc4-mm1+patch

Well ... great, it doesn't work for anyone, sigh.

OK, could you try this one (also against vanilla 2.6.12-rc4).  Hopefully
it's a rollup of all the aic7xxx changes plus the necessary supporting
infrastructure in my scsi-misc tree.

If it works, trying to get it into a patch set for Linus is going to be
a right pain ...

James

--- a/drivers/scsi/aic7xxx/aic7770_osm.c
+++ b/drivers/scsi/aic7xxx/aic7770_osm.c
@@ -41,7 +41,6 @@
 
 #include "aic7xxx_osm.h"
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 #include <linux/device.h>
 #include <linux/eisa.h>
 
@@ -62,13 +61,6 @@ static struct eisa_driver aic7770_driver
 };
 
 typedef  struct device *aic7770_dev_t;
-#else
-#define MINSLOT			1
-#define NUMSLOTS		16
-#define IDOFFSET		0x80
-
-typedef void *aic7770_dev_t;
-#endif
 
 static int aic7770_linux_config(struct aic7770_identity *entry,
 				aic7770_dev_t dev, u_int eisaBase);
@@ -76,7 +68,6 @@ static int aic7770_linux_config(struct a
 int
 ahc_linux_eisa_init(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	struct eisa_device_id *eid;
 	struct aic7770_identity *id;
 	int i;
@@ -110,44 +101,6 @@ ahc_linux_eisa_init(void)
 	eid->sig[0] = 0;
 
 	return eisa_driver_register(&aic7770_driver);
-#else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
-	struct aic7770_identity *entry;
-	u_int  slot;
-	u_int  eisaBase;
-	u_int  i;
-	int ret = -ENODEV;
-
-	if (aic7xxx_probe_eisa_vl == 0)
-		return ret;
-
-	eisaBase = 0x1000 + AHC_EISA_SLOT_OFFSET;
-	for (slot = 1; slot < NUMSLOTS; eisaBase+=0x1000, slot++) {
-		uint32_t eisa_id;
-		size_t	 id_size;
-
-		if (request_region(eisaBase, AHC_EISA_IOSIZE, "aic7xxx") == 0)
-			continue;
-
-		eisa_id = 0;
-		id_size = sizeof(eisa_id);
-		for (i = 0; i < 4; i++) {
-			/* VLcards require priming*/
-			outb(0x80 + i, eisaBase + IDOFFSET);
-			eisa_id |= inb(eisaBase + IDOFFSET + i)
-				   << ((id_size-i-1) * 8);
-		}
-		release_region(eisaBase, AHC_EISA_IOSIZE);
-		if (eisa_id & 0x80000000)
-			continue;  /* no EISA card in slot */
-
-		entry = aic7770_find_device(eisa_id);
-		if (entry != NULL) {
-			aic7770_linux_config(entry, NULL, eisaBase);
-			ret = 0;
-		}
-	}
-	return ret;
-#endif
 }
 
 void
@@ -187,11 +140,10 @@ aic7770_linux_config(struct aic7770_iden
 		ahc_free(ahc);
 		return (error);
 	}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+
 	dev->driver_data = (void *)ahc;
 	if (aic7xxx_detect_complete)
 		error = ahc_linux_register_host(ahc, &aic7xxx_driver_template);
-#endif
 	return (error);
 }
 
@@ -225,7 +177,6 @@ aic7770_map_int(struct ahc_softc *ahc, u
 	return (-error);
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 static int
 aic7770_eisa_dev_probe(struct device *dev)
 {
@@ -261,4 +212,3 @@ aic7770_eisa_dev_remove(struct device *d
 
 	return (0);
 }
-#endif
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -134,11 +134,6 @@ static struct scsi_transport_template *a
 #include "aiclib.c"
 
 #include <linux/init.h>		/* __setup */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include "sd.h"			/* For geometry detection */
-#endif
-
 #include <linux/mm.h>		/* For fetching system memory size */
 #include <linux/blkdev.h>		/* For block_size() */
 #include <linux/delay.h>	/* For ssleep/msleep */
@@ -148,11 +143,6 @@ static struct scsi_transport_template *a
  */
 spinlock_t ahc_list_spinlock;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-/* For dynamic sglist size calculation. */
-u_int ahc_linux_nseg;
-#endif
-
 /*
  * Set this to the delay in seconds after SCSI bus reset.
  * Note, we honor this only for the initial bus reset.
@@ -436,15 +426,12 @@ static void ahc_linux_handle_scsi_status
 					 struct ahc_linux_device *,
 					 struct scb *);
 static void ahc_linux_queue_cmd_complete(struct ahc_softc *ahc,
-					 Scsi_Cmnd *cmd);
+					 struct scsi_cmnd *cmd);
 static void ahc_linux_sem_timeout(u_long arg);
 static void ahc_linux_freeze_simq(struct ahc_softc *ahc);
 static void ahc_linux_release_simq(u_long arg);
-static void ahc_linux_dev_timed_unfreeze(u_long arg);
-static int  ahc_linux_queue_recovery_cmd(Scsi_Cmnd *cmd, scb_flag flag);
+static int  ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag);
 static void ahc_linux_initialize_scsi_bus(struct ahc_softc *ahc);
-static void ahc_linux_size_nseg(void);
-static void ahc_linux_thread_run_complete_queue(struct ahc_softc *ahc);
 static u_int ahc_linux_user_tagdepth(struct ahc_softc *ahc,
 				     struct ahc_devinfo *devinfo);
 static void ahc_linux_device_queue_depth(struct ahc_softc *ahc,
@@ -458,54 +445,27 @@ static struct ahc_linux_device*	ahc_linu
 						       u_int);
 static void			ahc_linux_free_device(struct ahc_softc*,
 						      struct ahc_linux_device*);
-static void ahc_linux_run_device_queue(struct ahc_softc*,
-				       struct ahc_linux_device*);
+static int ahc_linux_run_command(struct ahc_softc*,
+				 struct ahc_linux_device *,
+				 struct scsi_cmnd *);
 static void ahc_linux_setup_tag_info_global(char *p);
 static aic_option_callback_t ahc_linux_setup_tag_info;
 static int  aic7xxx_setup(char *s);
 static int  ahc_linux_next_unit(void);
-static void ahc_runq_tasklet(unsigned long data);
-static struct ahc_cmd *ahc_linux_run_complete_queue(struct ahc_softc *ahc);
 
 /********************************* Inlines ************************************/
-static __inline void ahc_schedule_runq(struct ahc_softc *ahc);
 static __inline struct ahc_linux_device*
 		     ahc_linux_get_device(struct ahc_softc *ahc, u_int channel,
-					  u_int target, u_int lun, int alloc);
-static __inline void ahc_schedule_completeq(struct ahc_softc *ahc);
-static __inline void ahc_linux_check_device_queue(struct ahc_softc *ahc,
-						  struct ahc_linux_device *dev);
-static __inline struct ahc_linux_device *
-		     ahc_linux_next_device_to_run(struct ahc_softc *ahc);
-static __inline void ahc_linux_run_device_queues(struct ahc_softc *ahc);
+					  u_int target, u_int lun);
 static __inline void ahc_linux_unmap_scb(struct ahc_softc*, struct scb*);
 
 static __inline int ahc_linux_map_seg(struct ahc_softc *ahc, struct scb *scb,
 		 		      struct ahc_dma_seg *sg,
 				      dma_addr_t addr, bus_size_t len);
 
-static __inline void
-ahc_schedule_completeq(struct ahc_softc *ahc)
-{
-	if ((ahc->platform_data->flags & AHC_RUN_CMPLT_Q_TIMER) == 0) {
-		ahc->platform_data->flags |= AHC_RUN_CMPLT_Q_TIMER;
-		ahc->platform_data->completeq_timer.expires = jiffies;
-		add_timer(&ahc->platform_data->completeq_timer);
-	}
-}
-
-/*
- * Must be called with our lock held.
- */
-static __inline void
-ahc_schedule_runq(struct ahc_softc *ahc)
-{
-	tasklet_schedule(&ahc->platform_data->runq_tasklet);
-}
-
 static __inline struct ahc_linux_device*
 ahc_linux_get_device(struct ahc_softc *ahc, u_int channel, u_int target,
-		     u_int lun, int alloc)
+		     u_int lun)
 {
 	struct ahc_linux_target *targ;
 	struct ahc_linux_device *dev;
@@ -515,102 +475,15 @@ ahc_linux_get_device(struct ahc_softc *a
 	if (channel != 0)
 		target_offset += 8;
 	targ = ahc->platform_data->targets[target_offset];
-	if (targ == NULL) {
-		if (alloc != 0) {
-			targ = ahc_linux_alloc_target(ahc, channel, target);
-			if (targ == NULL)
-				return (NULL);
-		} else
-			return (NULL);
-	}
+	BUG_ON(targ == NULL);
 	dev = targ->devices[lun];
-	if (dev == NULL && alloc != 0)
-		dev = ahc_linux_alloc_device(ahc, targ, lun);
-	return (dev);
-}
-
-#define AHC_LINUX_MAX_RETURNED_ERRORS 4
-static struct ahc_cmd *
-ahc_linux_run_complete_queue(struct ahc_softc *ahc)
-{
-	struct	ahc_cmd *acmd;
-	u_long	done_flags;
-	int	with_errors;
-
-	with_errors = 0;
-	ahc_done_lock(ahc, &done_flags);
-	while ((acmd = TAILQ_FIRST(&ahc->platform_data->completeq)) != NULL) {
-		Scsi_Cmnd *cmd;
-
-		if (with_errors > AHC_LINUX_MAX_RETURNED_ERRORS) {
-			/*
-			 * Linux uses stack recursion to requeue
-			 * commands that need to be retried.  Avoid
-			 * blowing out the stack by "spoon feeding"
-			 * commands that completed with error back
-			 * the operating system in case they are going
-			 * to be retried. "ick"
-			 */
-			ahc_schedule_completeq(ahc);
-			break;
-		}
-		TAILQ_REMOVE(&ahc->platform_data->completeq,
-			     acmd, acmd_links.tqe);
-		cmd = &acmd_scsi_cmd(acmd);
-		cmd->host_scribble = NULL;
-		if (ahc_cmd_get_transaction_status(cmd) != DID_OK
-		 || (cmd->result & 0xFF) != SCSI_STATUS_OK)
-			with_errors++;
-
-		cmd->scsi_done(cmd);
-	}
-	ahc_done_unlock(ahc, &done_flags);
-	return (acmd);
-}
-
-static __inline void
-ahc_linux_check_device_queue(struct ahc_softc *ahc,
-			     struct ahc_linux_device *dev)
-{
-	if ((dev->flags & AHC_DEV_FREEZE_TIL_EMPTY) != 0
-	 && dev->active == 0) {
-		dev->flags &= ~AHC_DEV_FREEZE_TIL_EMPTY;
-		dev->qfrozen--;
-	}
-
-	if (TAILQ_FIRST(&dev->busyq) == NULL
-	 || dev->openings == 0 || dev->qfrozen != 0)
-		return;
-
-	ahc_linux_run_device_queue(ahc, dev);
-}
-
-static __inline struct ahc_linux_device *
-ahc_linux_next_device_to_run(struct ahc_softc *ahc)
-{
-	
-	if ((ahc->flags & AHC_RESOURCE_SHORTAGE) != 0
-	    || (ahc->platform_data->qfrozen != 0))
-		return (NULL);
-	return (TAILQ_FIRST(&ahc->platform_data->device_runq));
-}
-
-static __inline void
-ahc_linux_run_device_queues(struct ahc_softc *ahc)
-{
-	struct ahc_linux_device *dev;
-
-	while ((dev = ahc_linux_next_device_to_run(ahc)) != NULL) {
-		TAILQ_REMOVE(&ahc->platform_data->device_runq, dev, links);
-		dev->flags &= ~AHC_DEV_ON_RUN_LIST;
-		ahc_linux_check_device_queue(ahc, dev);
-	}
+	return dev;
 }
 
 static __inline void
 ahc_linux_unmap_scb(struct ahc_softc *ahc, struct scb *scb)
 {
-	Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 
 	cmd = scb->io_ctx;
 	ahc_sync_sglist(ahc, scb, BUS_DMASYNC_POSTWRITE);
@@ -650,109 +523,15 @@ ahc_linux_map_seg(struct ahc_softc *ahc,
 	return (consumed);
 }
 
-/************************  Host template entry points *************************/
-static int	   ahc_linux_detect(Scsi_Host_Template *);
-static int	   ahc_linux_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
-static const char *ahc_linux_info(struct Scsi_Host *);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-static int	   ahc_linux_slave_alloc(Scsi_Device *);
-static int	   ahc_linux_slave_configure(Scsi_Device *);
-static void	   ahc_linux_slave_destroy(Scsi_Device *);
-#if defined(__i386__)
-static int	   ahc_linux_biosparam(struct scsi_device*,
-				       struct block_device*,
-				       sector_t, int[]);
-#endif
-#else
-static int	   ahc_linux_release(struct Scsi_Host *);
-static void	   ahc_linux_select_queue_depth(struct Scsi_Host *host,
-						Scsi_Device *scsi_devs);
-#if defined(__i386__)
-static int	   ahc_linux_biosparam(Disk *, kdev_t, int[]);
-#endif
-#endif
-static int	   ahc_linux_bus_reset(Scsi_Cmnd *);
-static int	   ahc_linux_dev_reset(Scsi_Cmnd *);
-static int	   ahc_linux_abort(Scsi_Cmnd *);
-
-/*
- * Calculate a safe value for AHC_NSEG (as expressed through ahc_linux_nseg).
- *
- * In pre-2.5.X...
- * The midlayer allocates an S/G array dynamically when a command is issued
- * using SCSI malloc.  This array, which is in an OS dependent format that
- * must later be copied to our private S/G list, is sized to house just the
- * number of segments needed for the current transfer.  Since the code that
- * sizes the SCSI malloc pool does not take into consideration fragmentation
- * of the pool, executing transactions numbering just a fraction of our
- * concurrent transaction limit with list lengths aproaching AHC_NSEG will
- * quickly depleat the SCSI malloc pool of usable space.  Unfortunately, the
- * mid-layer does not properly handle this scsi malloc failures for the S/G
- * array and the result can be a lockup of the I/O subsystem.  We try to size
- * our S/G list so that it satisfies our drivers allocation requirements in
- * addition to avoiding fragmentation of the SCSI malloc pool.
- */
-static void
-ahc_linux_size_nseg(void)
-{
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	u_int cur_size;
-	u_int best_size;
-
-	/*
-	 * The SCSI allocator rounds to the nearest 512 bytes
-	 * an cannot allocate across a page boundary.  Our algorithm
-	 * is to start at 1K of scsi malloc space per-command and
-	 * loop through all factors of the PAGE_SIZE and pick the best.
-	 */
-	best_size = 0;
-	for (cur_size = 1024; cur_size <= PAGE_SIZE; cur_size *= 2) {
-		u_int nseg;
-
-		nseg = cur_size / sizeof(struct scatterlist);
-		if (nseg < AHC_LINUX_MIN_NSEG)
-			continue;
-
-		if (best_size == 0) {
-			best_size = cur_size;
-			ahc_linux_nseg = nseg;
-		} else {
-			u_int best_rem;
-			u_int cur_rem;
-
-			/*
-			 * Compare the traits of the current "best_size"
-			 * with the current size to determine if the
-			 * current size is a better size.
-			 */
-			best_rem = best_size % sizeof(struct scatterlist);
-			cur_rem = cur_size % sizeof(struct scatterlist);
-			if (cur_rem < best_rem) {
-				best_size = cur_size;
-				ahc_linux_nseg = nseg;
-			}
-		}
-	}
-#endif
-}
-
 /*
  * Try to detect an Adaptec 7XXX controller.
  */
 static int
-ahc_linux_detect(Scsi_Host_Template *template)
+ahc_linux_detect(struct scsi_host_template *template)
 {
 	struct	ahc_softc *ahc;
 	int     found = 0;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	/*
-	 * It is a bug that the upper layer takes
-	 * this lock just prior to calling us.
-	 */
-	spin_unlock_irq(&io_request_lock);
-#endif
-
 	/*
 	 * Sanity checking of Linux SCSI data structures so
 	 * that some of our hacks^H^H^H^H^Hassumptions aren't
@@ -764,7 +543,6 @@ ahc_linux_detect(Scsi_Host_Template *tem
 		printf("ahc_linux_detect: Unable to attach\n");
 		return (0);
 	}
-	ahc_linux_size_nseg();
 	/*
 	 * If we've been passed any parameters, process them now.
 	 */
@@ -793,48 +571,11 @@ ahc_linux_detect(Scsi_Host_Template *tem
 			found++;
 	}
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	spin_lock_irq(&io_request_lock);
-#endif
 	aic7xxx_detect_complete++;
 
 	return (found);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-/*
- * Free the passed in Scsi_Host memory structures prior to unloading the
- * module.
- */
-int
-ahc_linux_release(struct Scsi_Host * host)
-{
-	struct ahc_softc *ahc;
-	u_long l;
-
-	ahc_list_lock(&l);
-	if (host != NULL) {
-
-		/*
-		 * We should be able to just perform
-		 * the free directly, but check our
-		 * list for extra sanity.
-		 */
-		ahc = ahc_find_softc(*(struct ahc_softc **)host->hostdata);
-		if (ahc != NULL) {
-			u_long s;
-
-			ahc_lock(ahc, &s);
-			ahc_intr_enable(ahc, FALSE);
-			ahc_unlock(ahc, &s);
-			ahc_free(ahc);
-		}
-	}
-	ahc_list_unlock(&l);
-	return (0);
-}
-#endif
-
 /*
  * Return a string describing the driver.
  */
@@ -867,11 +608,10 @@ ahc_linux_info(struct Scsi_Host *host)
  * Queue an SCB to the controller.
  */
 static int
-ahc_linux_queue(Scsi_Cmnd * cmd, void (*scsi_done) (Scsi_Cmnd *))
+ahc_linux_queue(struct scsi_cmnd * cmd, void (*scsi_done) (struct scsi_cmnd *))
 {
 	struct	 ahc_softc *ahc;
 	struct	 ahc_linux_device *dev;
-	u_long	 flags;
 
 	ahc = *(struct ahc_softc **)cmd->device->host->hostdata;
 
@@ -880,205 +620,149 @@ ahc_linux_queue(Scsi_Cmnd * cmd, void (*
 	 */
 	cmd->scsi_done = scsi_done;
 
-	ahc_midlayer_entrypoint_lock(ahc, &flags);
-
 	/*
 	 * Close the race of a command that was in the process of
 	 * being queued to us just as our simq was frozen.  Let
 	 * DV commands through so long as we are only frozen to
 	 * perform DV.
 	 */
-	if (ahc->platform_data->qfrozen != 0) {
+	if (ahc->platform_data->qfrozen != 0)
+		return SCSI_MLQUEUE_HOST_BUSY;
 
-		ahc_cmd_set_transaction_status(cmd, CAM_REQUEUE_REQ);
-		ahc_linux_queue_cmd_complete(ahc, cmd);
-		ahc_schedule_completeq(ahc);
-		ahc_midlayer_entrypoint_unlock(ahc, &flags);
-		return (0);
-	}
 	dev = ahc_linux_get_device(ahc, cmd->device->channel, cmd->device->id,
-				   cmd->device->lun, /*alloc*/TRUE);
-	if (dev == NULL) {
-		ahc_cmd_set_transaction_status(cmd, CAM_RESRC_UNAVAIL);
-		ahc_linux_queue_cmd_complete(ahc, cmd);
-		ahc_schedule_completeq(ahc);
-		ahc_midlayer_entrypoint_unlock(ahc, &flags);
-		printf("%s: aic7xxx_linux_queue - Unable to allocate device!\n",
-		       ahc_name(ahc));
-		return (0);
-	}
+				   cmd->device->lun);
+	BUG_ON(dev == NULL);
+
 	cmd->result = CAM_REQ_INPROG << 16;
-	TAILQ_INSERT_TAIL(&dev->busyq, (struct ahc_cmd *)cmd, acmd_links.tqe);
-	if ((dev->flags & AHC_DEV_ON_RUN_LIST) == 0) {
-		TAILQ_INSERT_TAIL(&ahc->platform_data->device_runq, dev, links);
-		dev->flags |= AHC_DEV_ON_RUN_LIST;
-		ahc_linux_run_device_queues(ahc);
-	}
-	ahc_midlayer_entrypoint_unlock(ahc, &flags);
-	return (0);
+
+	return ahc_linux_run_command(ahc, dev, cmd);
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 static int
-ahc_linux_slave_alloc(Scsi_Device *device)
+ahc_linux_slave_alloc(struct scsi_device *device)
 {
 	struct	ahc_softc *ahc;
+	struct ahc_linux_target *targ;
+	struct scsi_target *starget = device->sdev_target;
+	struct ahc_linux_device *dev;
+	unsigned int target_offset;
+	unsigned long flags;
+	int retval = -ENOMEM;
+
+	target_offset = starget->id;
+	if (starget->channel != 0)
+		target_offset += 8;
 
 	ahc = *((struct ahc_softc **)device->host->hostdata);
 	if (bootverbose)
 		printf("%s: Slave Alloc %d\n", ahc_name(ahc), device->id);
-	return (0);
+	ahc_lock(ahc, &flags);
+	targ = ahc->platform_data->targets[target_offset];
+	if (targ == NULL) {
+		targ = ahc_linux_alloc_target(ahc, starget->channel, starget->id);
+		struct seeprom_config *sc = ahc->seep_config;
+		if (targ == NULL)
+			goto out;
+
+		if (sc) {
+			unsigned short scsirate;
+			struct ahc_devinfo devinfo;
+			struct ahc_initiator_tinfo *tinfo;
+			struct ahc_tmode_tstate *tstate;
+			char channel = starget->channel + 'A';
+			unsigned int our_id = ahc->our_id;
+
+			if (starget->channel)
+				our_id = ahc->our_id_b;
+
+			if ((ahc->features & AHC_ULTRA2) != 0) {
+				scsirate = sc->device_flags[target_offset] & CFXFER;
+			} else {
+				scsirate = (sc->device_flags[target_offset] & CFXFER) << 4;
+				if (sc->device_flags[target_offset] & CFSYNCH)
+					scsirate |= SOFS;
+			}
+			if (sc->device_flags[target_offset] & CFWIDEB) {
+				scsirate |= WIDEXFER;
+				spi_max_width(starget) = 1;
+			} else
+				spi_max_width(starget) = 0;
+			spi_min_period(starget) = 
+				ahc_find_period(ahc, scsirate, AHC_SYNCRATE_DT);
+			tinfo = ahc_fetch_transinfo(ahc, channel, ahc->our_id,
+						    targ->target, &tstate);
+			ahc_compile_devinfo(&devinfo, our_id, targ->target,
+					    CAM_LUN_WILDCARD, channel,
+					    ROLE_INITIATOR);
+			ahc_set_syncrate(ahc, &devinfo, NULL, 0, 0, 0,
+					 AHC_TRANS_GOAL, /*paused*/FALSE);
+			ahc_set_width(ahc, &devinfo, MSG_EXT_WDTR_BUS_8_BIT,
+				      AHC_TRANS_GOAL, /*paused*/FALSE);
+		}
+			
+	}
+	dev = targ->devices[device->lun];
+	if (dev == NULL) {
+		dev = ahc_linux_alloc_device(ahc, targ, device->lun);
+		if (dev == NULL)
+			goto out;
+	}
+	retval = 0;
+
+ out:
+	ahc_unlock(ahc, &flags);
+	return retval;
 }
 
 static int
-ahc_linux_slave_configure(Scsi_Device *device)
+ahc_linux_slave_configure(struct scsi_device *device)
 {
 	struct	ahc_softc *ahc;
 	struct	ahc_linux_device *dev;
-	u_long	flags;
 
 	ahc = *((struct ahc_softc **)device->host->hostdata);
+
 	if (bootverbose)
 		printf("%s: Slave Configure %d\n", ahc_name(ahc), device->id);
-	ahc_midlayer_entrypoint_lock(ahc, &flags);
-	/*
-	 * Since Linux has attached to the device, configure
-	 * it so we don't free and allocate the device
-	 * structure on every command.
-	 */
-	dev = ahc_linux_get_device(ahc, device->channel,
-				   device->id, device->lun,
-				   /*alloc*/TRUE);
-	if (dev != NULL) {
-		dev->flags &= ~AHC_DEV_UNCONFIGURED;
-		dev->scsi_device = device;
-		ahc_linux_device_queue_depth(ahc, dev);
-	}
-	ahc_midlayer_entrypoint_unlock(ahc, &flags);
+
+	dev = ahc_linux_get_device(ahc, device->channel, device->id,
+				   device->lun);
+	dev->scsi_device = device;
+	ahc_linux_device_queue_depth(ahc, dev);
 
 	/* Initial Domain Validation */
 	if (!spi_initial_dv(device->sdev_target))
 		spi_dv_device(device);
 
-	return (0);
+	return 0;
 }
 
 static void
-ahc_linux_slave_destroy(Scsi_Device *device)
+ahc_linux_slave_destroy(struct scsi_device *device)
 {
 	struct	ahc_softc *ahc;
 	struct	ahc_linux_device *dev;
-	u_long	flags;
 
 	ahc = *((struct ahc_softc **)device->host->hostdata);
 	if (bootverbose)
 		printf("%s: Slave Destroy %d\n", ahc_name(ahc), device->id);
-	ahc_midlayer_entrypoint_lock(ahc, &flags);
 	dev = ahc_linux_get_device(ahc, device->channel,
-				   device->id, device->lun,
-					   /*alloc*/FALSE);
-	/*
-	 * Filter out "silly" deletions of real devices by only
-	 * deleting devices that have had slave_configure()
-	 * called on them.  All other devices that have not
-	 * been configured will automatically be deleted by
-	 * the refcounting process.
-	 */
-	if (dev != NULL
-	 && (dev->flags & AHC_DEV_SLAVE_CONFIGURED) != 0) {
-		dev->flags |= AHC_DEV_UNCONFIGURED;
-		if (TAILQ_EMPTY(&dev->busyq)
-		 && dev->active == 0
-	 	 && (dev->flags & AHC_DEV_TIMER_ACTIVE) == 0)
-			ahc_linux_free_device(ahc, dev);
-	}
-	ahc_midlayer_entrypoint_unlock(ahc, &flags);
-}
-#else
-/*
- * Sets the queue depth for each SCSI device hanging
- * off the input host adapter.
- */
-static void
-ahc_linux_select_queue_depth(struct Scsi_Host *host, Scsi_Device *scsi_devs)
-{
-	Scsi_Device *device;
-	Scsi_Device *ldev;
-	struct	ahc_softc *ahc;
-	u_long	flags;
-
-	ahc = *((struct ahc_softc **)host->hostdata);
-	ahc_lock(ahc, &flags);
-	for (device = scsi_devs; device != NULL; device = device->next) {
-
-		/*
-		 * Watch out for duplicate devices.  This works around
-		 * some quirks in how the SCSI scanning code does its
-		 * device management.
-		 */
-		for (ldev = scsi_devs; ldev != device; ldev = ldev->next) {
-			if (ldev->host == device->host
-			 && ldev->channel == device->channel
-			 && ldev->id == device->id
-			 && ldev->lun == device->lun)
-				break;
-		}
-		/* Skip duplicate. */
-		if (ldev != device)
-			continue;
+				   device->id, device->lun);
 
-		if (device->host == host) {
-			struct	 ahc_linux_device *dev;
+	BUG_ON(dev->active);
 
-			/*
-			 * Since Linux has attached to the device, configure
-			 * it so we don't free and allocate the device
-			 * structure on every command.
-			 */
-			dev = ahc_linux_get_device(ahc, device->channel,
-						   device->id, device->lun,
-						   /*alloc*/TRUE);
-			if (dev != NULL) {
-				dev->flags &= ~AHC_DEV_UNCONFIGURED;
-				dev->scsi_device = device;
-				ahc_linux_device_queue_depth(ahc, dev);
-				device->queue_depth = dev->openings
-						    + dev->active;
-				if ((dev->flags & (AHC_DEV_Q_BASIC
-						| AHC_DEV_Q_TAGGED)) == 0) {
-					/*
-					 * We allow the OS to queue 2 untagged
-					 * transactions to us at any time even
-					 * though we can only execute them
-					 * serially on the controller/device.
-					 * This should remove some latency.
-					 */
-					device->queue_depth = 2;
-				}
-			}
-		}
-	}
-	ahc_unlock(ahc, &flags);
+	ahc_linux_free_device(ahc, dev);
 }
-#endif
 
 #if defined(__i386__)
 /*
  * Return the disk geometry for the given SCSI device.
  */
 static int
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 ahc_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 		    sector_t capacity, int geom[])
 {
 	uint8_t *bh;
-#else
-ahc_linux_biosparam(Disk *disk, kdev_t dev, int geom[])
-{
-	struct	scsi_device *sdev = disk->device;
-	u_long	capacity = disk->capacity;
-	struct	buffer_head *bh;
-#endif
 	int	 heads;
 	int	 sectors;
 	int	 cylinders;
@@ -1090,22 +774,11 @@ ahc_linux_biosparam(Disk *disk, kdev_t d
 	ahc = *((struct ahc_softc **)sdev->host->hostdata);
 	channel = sdev->channel;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	bh = scsi_bios_ptable(bdev);
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,17)
-	bh = bread(MKDEV(MAJOR(dev), MINOR(dev) & ~0xf), 0, block_size(dev));
-#else
-	bh = bread(MKDEV(MAJOR(dev), MINOR(dev) & ~0xf), 0, 1024);
-#endif
-
 	if (bh) {
 		ret = scsi_partsize(bh, capacity,
 				    &geom[2], &geom[0], &geom[1]);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 		kfree(bh);
-#else
-		brelse(bh);
-#endif
 		if (ret != -1)
 			return (ret);
 	}
@@ -1135,7 +808,7 @@ ahc_linux_biosparam(Disk *disk, kdev_t d
  * Abort the current SCSI command(s).
  */
 static int
-ahc_linux_abort(Scsi_Cmnd *cmd)
+ahc_linux_abort(struct scsi_cmnd *cmd)
 {
 	int error;
 
@@ -1149,7 +822,7 @@ ahc_linux_abort(Scsi_Cmnd *cmd)
  * Attempt to send a target reset message to the device that timed out.
  */
 static int
-ahc_linux_dev_reset(Scsi_Cmnd *cmd)
+ahc_linux_dev_reset(struct scsi_cmnd *cmd)
 {
 	int error;
 
@@ -1163,18 +836,14 @@ ahc_linux_dev_reset(Scsi_Cmnd *cmd)
  * Reset the SCSI bus.
  */
 static int
-ahc_linux_bus_reset(Scsi_Cmnd *cmd)
+ahc_linux_bus_reset(struct scsi_cmnd *cmd)
 {
 	struct ahc_softc *ahc;
-	u_long s;
 	int    found;
 
 	ahc = *(struct ahc_softc **)cmd->device->host->hostdata;
-	ahc_midlayer_entrypoint_lock(ahc, &s);
 	found = ahc_reset_channel(ahc, cmd->device->channel + 'A',
 				  /*initiate reset*/TRUE);
-	ahc_linux_run_complete_queue(ahc);
-	ahc_midlayer_entrypoint_unlock(ahc, &s);
 
 	if (bootverbose)
 		printf("%s: SCSI bus reset delivered. "
@@ -1183,7 +852,7 @@ ahc_linux_bus_reset(Scsi_Cmnd *cmd)
 	return SUCCESS;
 }
 
-Scsi_Host_Template aic7xxx_driver_template = {
+struct scsi_host_template aic7xxx_driver_template = {
 	.module			= THIS_MODULE,
 	.name			= "aic7xxx",
 	.proc_info		= ahc_linux_proc_info,
@@ -1206,33 +875,6 @@ Scsi_Host_Template aic7xxx_driver_templa
 
 /**************************** Tasklet Handler *********************************/
 
-/*
- * In 2.4.X and above, this routine is called from a tasklet,
- * so we must re-acquire our lock prior to executing this code.
- * In all prior kernels, ahc_schedule_runq() calls this routine
- * directly and ahc_schedule_runq() is called with our lock held.
- */
-static void
-ahc_runq_tasklet(unsigned long data)
-{
-	struct ahc_softc* ahc;
-	struct ahc_linux_device *dev;
-	u_long flags;
-
-	ahc = (struct ahc_softc *)data;
-	ahc_lock(ahc, &flags);
-	while ((dev = ahc_linux_next_device_to_run(ahc)) != NULL) {
-	
-		TAILQ_REMOVE(&ahc->platform_data->device_runq, dev, links);
-		dev->flags &= ~AHC_DEV_ON_RUN_LIST;
-		ahc_linux_check_device_queue(ahc, dev);
-		/* Yeild to our interrupt handler */
-		ahc_unlock(ahc, &flags);
-		ahc_lock(ahc, &flags);
-	}
-	ahc_unlock(ahc, &flags);
-}
-
 /******************************** Macros **************************************/
 #define BUILD_SCSIID(ahc, cmd)						    \
 	((((cmd)->device->id << TID_SHIFT) & TID)			    \
@@ -1278,37 +920,11 @@ int
 ahc_dmamem_alloc(struct ahc_softc *ahc, bus_dma_tag_t dmat, void** vaddr,
 		 int flags, bus_dmamap_t *mapp)
 {
-	bus_dmamap_t map;
-
-	map = malloc(sizeof(*map), M_DEVBUF, M_NOWAIT);
-	if (map == NULL)
-		return (ENOMEM);
-	/*
-	 * Although we can dma data above 4GB, our
-	 * "consistent" memory is below 4GB for
-	 * space efficiency reasons (only need a 4byte
-	 * address).  For this reason, we have to reset
-	 * our dma mask when doing allocations.
-	 */
-	if (ahc->dev_softc != NULL)
-		if (pci_set_dma_mask(ahc->dev_softc, 0xFFFFFFFF)) {
-			printk(KERN_WARNING "aic7xxx: No suitable DMA available.\n");
-			kfree(map);
-			return (ENODEV);
-		}
 	*vaddr = pci_alloc_consistent(ahc->dev_softc,
-				      dmat->maxsize, &map->bus_addr);
-	if (ahc->dev_softc != NULL)
-		if (pci_set_dma_mask(ahc->dev_softc,
-				     ahc->platform_data->hw_dma_mask)) {
-			printk(KERN_WARNING "aic7xxx: No suitable DMA available.\n");
-			kfree(map);
-			return (ENODEV);
-		}
+				      dmat->maxsize, mapp);
 	if (*vaddr == NULL)
-		return (ENOMEM);
-	*mapp = map;
-	return(0);
+		return ENOMEM;
+	return 0;
 }
 
 void
@@ -1316,7 +932,7 @@ ahc_dmamem_free(struct ahc_softc *ahc, b
 		void* vaddr, bus_dmamap_t map)
 {
 	pci_free_consistent(ahc->dev_softc, dmat->maxsize,
-			    vaddr, map->bus_addr);
+			    vaddr, map);
 }
 
 int
@@ -1330,7 +946,7 @@ ahc_dmamap_load(struct ahc_softc *ahc, b
 	 */
 	bus_dma_segment_t stack_sg;
 
-	stack_sg.ds_addr = map->bus_addr;
+	stack_sg.ds_addr = map;
 	stack_sg.ds_len = dmat->maxsize;
 	cb(cb_arg, &stack_sg, /*nseg*/1, /*error*/0);
 	return (0);
@@ -1339,12 +955,6 @@ ahc_dmamap_load(struct ahc_softc *ahc, b
 void
 ahc_dmamap_destroy(struct ahc_softc *ahc, bus_dma_tag_t dmat, bus_dmamap_t map)
 {
-	/*
-	 * The map may is NULL in our < 2.3.X implementation.
-	 * Now it's 2.6.5, but just in case...
-	 */
-	BUG_ON(map == NULL);
-	free(map, M_DEVBUF);
 }
 
 int
@@ -1550,7 +1160,7 @@ __setup("aic7xxx=", aic7xxx_setup);
 uint32_t aic7xxx_verbose;
 
 int
-ahc_linux_register_host(struct ahc_softc *ahc, Scsi_Host_Template *template)
+ahc_linux_register_host(struct ahc_softc *ahc, struct scsi_host_template *template)
 {
 	char	 buf[80];
 	struct	 Scsi_Host *host;
@@ -1564,11 +1174,7 @@ ahc_linux_register_host(struct ahc_softc
 
 	*((struct ahc_softc **)host->hostdata) = ahc;
 	ahc_lock(ahc, &s);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	scsi_assign_lock(host, &ahc->platform_data->spin_lock);
-#elif AHC_SCSI_HAS_HOST_LOCK != 0
-	host->lock = &ahc->platform_data->spin_lock;
-#endif
 	ahc->platform_data->host = host;
 	host->can_queue = AHC_MAX_QUEUE;
 	host->cmd_per_lun = 2;
@@ -1587,19 +1193,14 @@ ahc_linux_register_host(struct ahc_softc
 		ahc_set_name(ahc, new_name);
 	}
 	host->unique_id = ahc->unit;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	scsi_set_pci_device(host, ahc->dev_softc);
-#endif
 	ahc_linux_initialize_scsi_bus(ahc);
 	ahc_intr_enable(ahc, TRUE);
 	ahc_unlock(ahc, &s);
 
 	host->transportt = ahc_linux_transport_template;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	scsi_add_host(host, (ahc->dev_softc ? &ahc->dev_softc->dev : NULL)); /* XXX handle failure */
 	scsi_scan_host(host);
-#endif
 	return (0);
 }
 
@@ -1717,19 +1318,9 @@ ahc_platform_alloc(struct ahc_softc *ahc
 	if (ahc->platform_data == NULL)
 		return (ENOMEM);
 	memset(ahc->platform_data, 0, sizeof(struct ahc_platform_data));
-	TAILQ_INIT(&ahc->platform_data->completeq);
-	TAILQ_INIT(&ahc->platform_data->device_runq);
 	ahc->platform_data->irq = AHC_LINUX_NOIRQ;
-	ahc->platform_data->hw_dma_mask = 0xFFFFFFFF;
 	ahc_lockinit(ahc);
-	ahc_done_lockinit(ahc);
-	init_timer(&ahc->platform_data->completeq_timer);
-	ahc->platform_data->completeq_timer.data = (u_long)ahc;
-	ahc->platform_data->completeq_timer.function =
-	    (ahc_linux_callback_t *)ahc_linux_thread_run_complete_queue;
 	init_MUTEX_LOCKED(&ahc->platform_data->eh_sem);
-	tasklet_init(&ahc->platform_data->runq_tasklet, ahc_runq_tasklet,
-		     (unsigned long)ahc);
 	ahc->seltime = (aic7xxx_seltime & 0x3) << 4;
 	ahc->seltime_b = (aic7xxx_seltime & 0x3) << 4;
 	if (aic7xxx_pci_parity == 0)
@@ -1746,12 +1337,8 @@ ahc_platform_free(struct ahc_softc *ahc)
 	int i, j;
 
 	if (ahc->platform_data != NULL) {
-		del_timer_sync(&ahc->platform_data->completeq_timer);
-		tasklet_kill(&ahc->platform_data->runq_tasklet);
 		if (ahc->platform_data->host != NULL) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 			scsi_remove_host(ahc->platform_data->host);
-#endif
 			scsi_host_put(ahc->platform_data->host);
 		}
 
@@ -1787,16 +1374,7 @@ ahc_platform_free(struct ahc_softc *ahc)
 			release_mem_region(ahc->platform_data->mem_busaddr,
 					   0x1000);
 		}
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		/*
-		 * In 2.4 we detach from the scsi midlayer before the PCI
-		 * layer invokes our remove callback.  No per-instance
-		 * detach is provided, so we must reach inside the PCI
-		 * subsystem's internals and detach our driver manually.
-		 */
-		if (ahc->dev_softc != NULL)
-			ahc->dev_softc->driver = NULL;
-#endif
+
 		free(ahc->platform_data, M_DEVBUF);
 	}
 }
@@ -1820,7 +1398,7 @@ ahc_platform_set_tags(struct ahc_softc *
 
 	dev = ahc_linux_get_device(ahc, devinfo->channel - 'A',
 				   devinfo->target,
-				   devinfo->lun, /*alloc*/FALSE);
+				   devinfo->lun);
 	if (dev == NULL)
 		return;
 	was_queuing = dev->flags & (AHC_DEV_Q_BASIC|AHC_DEV_Q_TAGGED);
@@ -1873,7 +1451,6 @@ ahc_platform_set_tags(struct ahc_softc *
 		dev->maxtags = 0;
 		dev->openings =  1 - dev->active;
 	}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	if (dev->scsi_device != NULL) {
 		switch ((dev->flags & (AHC_DEV_Q_BASIC|AHC_DEV_Q_TAGGED))) {
 		case AHC_DEV_Q_BASIC:
@@ -1899,90 +1476,13 @@ ahc_platform_set_tags(struct ahc_softc *
 			break;
 		}
 	}
-#endif
 }
 
 int
 ahc_platform_abort_scbs(struct ahc_softc *ahc, int target, char channel,
 			int lun, u_int tag, role_t role, uint32_t status)
 {
-	int chan;
-	int maxchan;
-	int targ;
-	int maxtarg;
-	int clun;
-	int maxlun;
-	int count;
-
-	if (tag != SCB_LIST_NULL)
-		return (0);
-
-	chan = 0;
-	if (channel != ALL_CHANNELS) {
-		chan = channel - 'A';
-		maxchan = chan + 1;
-	} else {
-		maxchan = (ahc->features & AHC_TWIN) ? 2 : 1;
-	}
-	targ = 0;
-	if (target != CAM_TARGET_WILDCARD) {
-		targ = target;
-		maxtarg = targ + 1;
-	} else {
-		maxtarg = (ahc->features & AHC_WIDE) ? 16 : 8;
-	}
-	clun = 0;
-	if (lun != CAM_LUN_WILDCARD) {
-		clun = lun;
-		maxlun = clun + 1;
-	} else {
-		maxlun = AHC_NUM_LUNS;
-	}
-
-	count = 0;
-	for (; chan < maxchan; chan++) {
-
-		for (; targ < maxtarg; targ++) {
-
-			for (; clun < maxlun; clun++) {
-				struct ahc_linux_device *dev;
-				struct ahc_busyq *busyq;
-				struct ahc_cmd *acmd;
-
-				dev = ahc_linux_get_device(ahc, chan,
-							   targ, clun,
-							   /*alloc*/FALSE);
-				if (dev == NULL)
-					continue;
-
-				busyq = &dev->busyq;
-				while ((acmd = TAILQ_FIRST(busyq)) != NULL) {
-					Scsi_Cmnd *cmd;
-
-					cmd = &acmd_scsi_cmd(acmd);
-					TAILQ_REMOVE(busyq, acmd,
-						     acmd_links.tqe);
-					count++;
-					cmd->result = status << 16;
-					ahc_linux_queue_cmd_complete(ahc, cmd);
-				}
-			}
-		}
-	}
-
-	return (count);
-}
-
-static void
-ahc_linux_thread_run_complete_queue(struct ahc_softc *ahc)
-{
-	u_long flags;
-
-	ahc_lock(ahc, &flags);
-	del_timer(&ahc->platform_data->completeq_timer);
-	ahc->platform_data->flags &= ~AHC_RUN_CMPLT_Q_TIMER;
-	ahc_linux_run_complete_queue(ahc);
-	ahc_unlock(ahc, &flags);
+	return 0;
 }
 
 static u_int
@@ -2045,213 +1545,200 @@ ahc_linux_device_queue_depth(struct ahc_
 	}
 }
 
-static void
-ahc_linux_run_device_queue(struct ahc_softc *ahc, struct ahc_linux_device *dev)
+static int
+ahc_linux_run_command(struct ahc_softc *ahc, struct ahc_linux_device *dev,
+		      struct scsi_cmnd *cmd)
 {
-	struct	 ahc_cmd *acmd;
-	struct	 scsi_cmnd *cmd;
 	struct	 scb *scb;
 	struct	 hardware_scb *hscb;
 	struct	 ahc_initiator_tinfo *tinfo;
 	struct	 ahc_tmode_tstate *tstate;
 	uint16_t mask;
+	struct scb_tailq *untagged_q = NULL;
 
-	if ((dev->flags & AHC_DEV_ON_RUN_LIST) != 0)
-		panic("running device on run list");
+	/*
+	 * Schedule us to run later.  The only reason we are not
+	 * running is because the whole controller Q is frozen.
+	 */
+	if (ahc->platform_data->qfrozen != 0)
+		return SCSI_MLQUEUE_HOST_BUSY;
 
-	while ((acmd = TAILQ_FIRST(&dev->busyq)) != NULL
-	    && dev->openings > 0 && dev->qfrozen == 0) {
+	/*
+	 * We only allow one untagged transaction
+	 * per target in the initiator role unless
+	 * we are storing a full busy target *lun*
+	 * table in SCB space.
+	 */
+	if (!blk_rq_tagged(cmd->request)
+	    && (ahc->features & AHC_SCB_BTT) == 0) {
+		int target_offset;
 
-		/*
-		 * Schedule us to run later.  The only reason we are not
-		 * running is because the whole controller Q is frozen.
-		 */
-		if (ahc->platform_data->qfrozen != 0) {
-			TAILQ_INSERT_TAIL(&ahc->platform_data->device_runq,
-					  dev, links);
-			dev->flags |= AHC_DEV_ON_RUN_LIST;
-			return;
-		}
-		/*
-		 * Get an scb to use.
-		 */
-		if ((scb = ahc_get_scb(ahc)) == NULL) {
-			TAILQ_INSERT_TAIL(&ahc->platform_data->device_runq,
-					 dev, links);
-			dev->flags |= AHC_DEV_ON_RUN_LIST;
+		target_offset = cmd->device->id + cmd->device->channel * 8;
+		untagged_q = &(ahc->untagged_queues[target_offset]);
+		if (!TAILQ_EMPTY(untagged_q))
+			/* if we're already executing an untagged command
+			 * we're busy to another */
+			return SCSI_MLQUEUE_DEVICE_BUSY;
+	}
+
+	/*
+	 * Get an scb to use.
+	 */
+	if ((scb = ahc_get_scb(ahc)) == NULL) {
 			ahc->flags |= AHC_RESOURCE_SHORTAGE;
-			return;
-		}
-		TAILQ_REMOVE(&dev->busyq, acmd, acmd_links.tqe);
-		cmd = &acmd_scsi_cmd(acmd);
-		scb->io_ctx = cmd;
-		scb->platform_data->dev = dev;
-		hscb = scb->hscb;
-		cmd->host_scribble = (char *)scb;
+			return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
-		/*
-		 * Fill out basics of the HSCB.
-		 */
-		hscb->control = 0;
-		hscb->scsiid = BUILD_SCSIID(ahc, cmd);
-		hscb->lun = cmd->device->lun;
-		mask = SCB_GET_TARGET_MASK(ahc, scb);
-		tinfo = ahc_fetch_transinfo(ahc, SCB_GET_CHANNEL(ahc, scb),
-					    SCB_GET_OUR_ID(scb),
-					    SCB_GET_TARGET(ahc, scb), &tstate);
-		hscb->scsirate = tinfo->scsirate;
-		hscb->scsioffset = tinfo->curr.offset;
-		if ((tstate->ultraenb & mask) != 0)
-			hscb->control |= ULTRAENB;
-
-		if ((ahc->user_discenable & mask) != 0)
-			hscb->control |= DISCENB;
-
-		if ((tstate->auto_negotiate & mask) != 0) {
-			scb->flags |= SCB_AUTO_NEGOTIATE;
-			scb->hscb->control |= MK_MESSAGE;
-		}
-
-		if ((dev->flags & (AHC_DEV_Q_TAGGED|AHC_DEV_Q_BASIC)) != 0) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-			int	msg_bytes;
-			uint8_t tag_msgs[2];
-
-			msg_bytes = scsi_populate_tag_msg(cmd, tag_msgs);
-			if (msg_bytes && tag_msgs[0] != MSG_SIMPLE_TASK) {
-				hscb->control |= tag_msgs[0];
-				if (tag_msgs[0] == MSG_ORDERED_TASK)
-					dev->commands_since_idle_or_otag = 0;
-			} else
-#endif
-			if (dev->commands_since_idle_or_otag == AHC_OTAG_THRESH
-			 && (dev->flags & AHC_DEV_Q_TAGGED) != 0) {
-				hscb->control |= MSG_ORDERED_TASK;
-				dev->commands_since_idle_or_otag = 0;
-			} else {
-				hscb->control |= MSG_SIMPLE_TASK;
-			}
-		}
+	scb->io_ctx = cmd;
+	scb->platform_data->dev = dev;
+	hscb = scb->hscb;
+	cmd->host_scribble = (char *)scb;
+
+	/*
+	 * Fill out basics of the HSCB.
+	 */
+	hscb->control = 0;
+	hscb->scsiid = BUILD_SCSIID(ahc, cmd);
+	hscb->lun = cmd->device->lun;
+	mask = SCB_GET_TARGET_MASK(ahc, scb);
+	tinfo = ahc_fetch_transinfo(ahc, SCB_GET_CHANNEL(ahc, scb),
+				    SCB_GET_OUR_ID(scb),
+				    SCB_GET_TARGET(ahc, scb), &tstate);
+	hscb->scsirate = tinfo->scsirate;
+	hscb->scsioffset = tinfo->curr.offset;
+	if ((tstate->ultraenb & mask) != 0)
+		hscb->control |= ULTRAENB;
+	
+	if ((ahc->user_discenable & mask) != 0)
+		hscb->control |= DISCENB;
+	
+	if ((tstate->auto_negotiate & mask) != 0) {
+		scb->flags |= SCB_AUTO_NEGOTIATE;
+		scb->hscb->control |= MK_MESSAGE;
+	}
 
-		hscb->cdb_len = cmd->cmd_len;
-		if (hscb->cdb_len <= 12) {
-			memcpy(hscb->shared_data.cdb, cmd->cmnd, hscb->cdb_len);
+	if ((dev->flags & (AHC_DEV_Q_TAGGED|AHC_DEV_Q_BASIC)) != 0) {
+		int	msg_bytes;
+		uint8_t tag_msgs[2];
+		
+		msg_bytes = scsi_populate_tag_msg(cmd, tag_msgs);
+		if (msg_bytes && tag_msgs[0] != MSG_SIMPLE_TASK) {
+			hscb->control |= tag_msgs[0];
+			if (tag_msgs[0] == MSG_ORDERED_TASK)
+				dev->commands_since_idle_or_otag = 0;
+		} else if (dev->commands_since_idle_or_otag == AHC_OTAG_THRESH
+				&& (dev->flags & AHC_DEV_Q_TAGGED) != 0) {
+			hscb->control |= MSG_ORDERED_TASK;
+			dev->commands_since_idle_or_otag = 0;
 		} else {
-			memcpy(hscb->cdb32, cmd->cmnd, hscb->cdb_len);
-			scb->flags |= SCB_CDB32_PTR;
+			hscb->control |= MSG_SIMPLE_TASK;
 		}
+	}
 
-		scb->platform_data->xfer_len = 0;
-		ahc_set_residual(scb, 0);
-		ahc_set_sense_residual(scb, 0);
-		scb->sg_count = 0;
-		if (cmd->use_sg != 0) {
-			struct	ahc_dma_seg *sg;
-			struct	scatterlist *cur_seg;
-			struct	scatterlist *end_seg;
-			int	nseg;
-
-			cur_seg = (struct scatterlist *)cmd->request_buffer;
-			nseg = pci_map_sg(ahc->dev_softc, cur_seg, cmd->use_sg,
-			    cmd->sc_data_direction);
-			end_seg = cur_seg + nseg;
-			/* Copy the segments into the SG list. */
-			sg = scb->sg_list;
-			/*
-			 * The sg_count may be larger than nseg if
-			 * a transfer crosses a 32bit page.
-			 */ 
-			while (cur_seg < end_seg) {
-				dma_addr_t addr;
-				bus_size_t len;
-				int consumed;
-
-				addr = sg_dma_address(cur_seg);
-				len = sg_dma_len(cur_seg);
-				consumed = ahc_linux_map_seg(ahc, scb,
-							     sg, addr, len);
-				sg += consumed;
-				scb->sg_count += consumed;
-				cur_seg++;
-			}
-			sg--;
-			sg->len |= ahc_htole32(AHC_DMA_LAST_SEG);
-
-			/*
-			 * Reset the sg list pointer.
-			 */
-			scb->hscb->sgptr =
-			    ahc_htole32(scb->sg_list_phys | SG_FULL_RESID);
+	hscb->cdb_len = cmd->cmd_len;
+	if (hscb->cdb_len <= 12) {
+		memcpy(hscb->shared_data.cdb, cmd->cmnd, hscb->cdb_len);
+	} else {
+		memcpy(hscb->cdb32, cmd->cmnd, hscb->cdb_len);
+		scb->flags |= SCB_CDB32_PTR;
+	}
 
-			/*
-			 * Copy the first SG into the "current"
-			 * data pointer area.
-			 */
-			scb->hscb->dataptr = scb->sg_list->addr;
-			scb->hscb->datacnt = scb->sg_list->len;
-		} else if (cmd->request_bufflen != 0) {
-			struct	 ahc_dma_seg *sg;
+	scb->platform_data->xfer_len = 0;
+	ahc_set_residual(scb, 0);
+	ahc_set_sense_residual(scb, 0);
+	scb->sg_count = 0;
+	if (cmd->use_sg != 0) {
+		struct	ahc_dma_seg *sg;
+		struct	scatterlist *cur_seg;
+		struct	scatterlist *end_seg;
+		int	nseg;
+
+		cur_seg = (struct scatterlist *)cmd->request_buffer;
+		nseg = pci_map_sg(ahc->dev_softc, cur_seg, cmd->use_sg,
+				  cmd->sc_data_direction);
+		end_seg = cur_seg + nseg;
+		/* Copy the segments into the SG list. */
+		sg = scb->sg_list;
+		/*
+		 * The sg_count may be larger than nseg if
+		 * a transfer crosses a 32bit page.
+		 */ 
+		while (cur_seg < end_seg) {
 			dma_addr_t addr;
+			bus_size_t len;
+			int consumed;
 
-			sg = scb->sg_list;
-			addr = pci_map_single(ahc->dev_softc,
-			       cmd->request_buffer,
-			       cmd->request_bufflen,
-			       cmd->sc_data_direction);
-			scb->platform_data->buf_busaddr = addr;
-			scb->sg_count = ahc_linux_map_seg(ahc, scb,
-							  sg, addr,
-							  cmd->request_bufflen);
-			sg->len |= ahc_htole32(AHC_DMA_LAST_SEG);
+			addr = sg_dma_address(cur_seg);
+			len = sg_dma_len(cur_seg);
+			consumed = ahc_linux_map_seg(ahc, scb,
+						     sg, addr, len);
+			sg += consumed;
+			scb->sg_count += consumed;
+			cur_seg++;
+		}
+		sg--;
+		sg->len |= ahc_htole32(AHC_DMA_LAST_SEG);
 
-			/*
-			 * Reset the sg list pointer.
-			 */
-			scb->hscb->sgptr =
-			    ahc_htole32(scb->sg_list_phys | SG_FULL_RESID);
+		/*
+		 * Reset the sg list pointer.
+		 */
+		scb->hscb->sgptr =
+			ahc_htole32(scb->sg_list_phys | SG_FULL_RESID);
+		
+		/*
+		 * Copy the first SG into the "current"
+		 * data pointer area.
+		 */
+		scb->hscb->dataptr = scb->sg_list->addr;
+		scb->hscb->datacnt = scb->sg_list->len;
+	} else if (cmd->request_bufflen != 0) {
+		struct	 ahc_dma_seg *sg;
+		dma_addr_t addr;
 
-			/*
-			 * Copy the first SG into the "current"
-			 * data pointer area.
-			 */
-			scb->hscb->dataptr = sg->addr;
-			scb->hscb->datacnt = sg->len;
-		} else {
-			scb->hscb->sgptr = ahc_htole32(SG_LIST_NULL);
-			scb->hscb->dataptr = 0;
-			scb->hscb->datacnt = 0;
-			scb->sg_count = 0;
-		}
+		sg = scb->sg_list;
+		addr = pci_map_single(ahc->dev_softc,
+				      cmd->request_buffer,
+				      cmd->request_bufflen,
+				      cmd->sc_data_direction);
+		scb->platform_data->buf_busaddr = addr;
+		scb->sg_count = ahc_linux_map_seg(ahc, scb,
+						  sg, addr,
+						  cmd->request_bufflen);
+		sg->len |= ahc_htole32(AHC_DMA_LAST_SEG);
 
-		ahc_sync_sglist(ahc, scb, BUS_DMASYNC_PREWRITE);
-		LIST_INSERT_HEAD(&ahc->pending_scbs, scb, pending_links);
-		dev->openings--;
-		dev->active++;
-		dev->commands_issued++;
-		if ((dev->flags & AHC_DEV_PERIODIC_OTAG) != 0)
-			dev->commands_since_idle_or_otag++;
+		/*
+		 * Reset the sg list pointer.
+		 */
+		scb->hscb->sgptr =
+			ahc_htole32(scb->sg_list_phys | SG_FULL_RESID);
 
 		/*
-		 * We only allow one untagged transaction
-		 * per target in the initiator role unless
-		 * we are storing a full busy target *lun*
-		 * table in SCB space.
+		 * Copy the first SG into the "current"
+		 * data pointer area.
 		 */
-		if ((scb->hscb->control & (TARGET_SCB|TAG_ENB)) == 0
-		 && (ahc->features & AHC_SCB_BTT) == 0) {
-			struct scb_tailq *untagged_q;
-			int target_offset;
-
-			target_offset = SCB_GET_TARGET_OFFSET(ahc, scb);
-			untagged_q = &(ahc->untagged_queues[target_offset]);
-			TAILQ_INSERT_TAIL(untagged_q, scb, links.tqe);
-			scb->flags |= SCB_UNTAGGEDQ;
-			if (TAILQ_FIRST(untagged_q) != scb)
-				continue;
-		}
-		scb->flags |= SCB_ACTIVE;
-		ahc_queue_scb(ahc, scb);
+		scb->hscb->dataptr = sg->addr;
+		scb->hscb->datacnt = sg->len;
+	} else {
+		scb->hscb->sgptr = ahc_htole32(SG_LIST_NULL);
+		scb->hscb->dataptr = 0;
+		scb->hscb->datacnt = 0;
+		scb->sg_count = 0;
+	}
+
+	LIST_INSERT_HEAD(&ahc->pending_scbs, scb, pending_links);
+	dev->openings--;
+	dev->active++;
+	dev->commands_issued++;
+	if ((dev->flags & AHC_DEV_PERIODIC_OTAG) != 0)
+		dev->commands_since_idle_or_otag++;
+	
+	scb->flags |= SCB_ACTIVE;
+	if (untagged_q) {
+		TAILQ_INSERT_TAIL(untagged_q, scb, links.tqe);
+		scb->flags |= SCB_UNTAGGEDQ;
 	}
+	ahc_queue_scb(ahc, scb);
+	return 0;
 }
 
 /*
@@ -2267,9 +1754,6 @@ ahc_linux_isr(int irq, void *dev_id, str
 	ahc = (struct ahc_softc *) dev_id;
 	ahc_lock(ahc, &flags); 
 	ours = ahc_intr(ahc);
-	if (ahc_linux_next_device_to_run(ahc) != NULL)
-		ahc_schedule_runq(ahc);
-	ahc_linux_run_complete_queue(ahc);
 	ahc_unlock(ahc, &flags);
 	return IRQ_RETVAL(ours);
 }
@@ -2278,8 +1762,6 @@ void
 ahc_platform_flushwork(struct ahc_softc *ahc)
 {
 
-	while (ahc_linux_run_complete_queue(ahc) != NULL)
-		;
 }
 
 static struct ahc_linux_target*
@@ -2348,9 +1830,6 @@ ahc_linux_alloc_device(struct ahc_softc 
 	if (dev == NULL)
 		return (NULL);
 	memset(dev, 0, sizeof(*dev));
-	init_timer(&dev->timer);
-	TAILQ_INIT(&dev->busyq);
-	dev->flags = AHC_DEV_UNCONFIGURED;
 	dev->lun = lun;
 	dev->target = targ;
 
@@ -2373,7 +1852,7 @@ ahc_linux_alloc_device(struct ahc_softc 
 }
 
 static void
-__ahc_linux_free_device(struct ahc_softc *ahc, struct ahc_linux_device *dev)
+ahc_linux_free_device(struct ahc_softc *ahc, struct ahc_linux_device *dev)
 {
 	struct ahc_linux_target *targ;
 
@@ -2385,13 +1864,6 @@ __ahc_linux_free_device(struct ahc_softc
 		ahc_linux_free_target(ahc, targ);
 }
 
-static void
-ahc_linux_free_device(struct ahc_softc *ahc, struct ahc_linux_device *dev)
-{
-	del_timer_sync(&dev->timer);
-	__ahc_linux_free_device(ahc, dev);
-}
-
 void
 ahc_send_async(struct ahc_softc *ahc, char channel,
 	       u_int target, u_int lun, ac_code code, void *arg)
@@ -2463,28 +1935,9 @@ ahc_send_async(struct ahc_softc *ahc, ch
 	}
         case AC_SENT_BDR:
 	{
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 		WARN_ON(lun != CAM_LUN_WILDCARD);
 		scsi_report_device_reset(ahc->platform_data->host,
 					 channel - 'A', target);
-#else
-		Scsi_Device *scsi_dev;
-
-		/*
-		 * Find the SCSI device associated with this
-		 * request and indicate that a UA is expected.
-		 */
-		for (scsi_dev = ahc->platform_data->host->host_queue;
-		     scsi_dev != NULL; scsi_dev = scsi_dev->next) {
-			if (channel - 'A' == scsi_dev->channel
-			 && target == scsi_dev->id
-			 && (lun == CAM_LUN_WILDCARD
-			  || lun == scsi_dev->lun)) {
-				scsi_dev->was_reset = 1;
-				scsi_dev->expecting_cc_ua = 1;
-			}
-		}
-#endif
 		break;
 	}
         case AC_BUS_RESET:
@@ -2504,7 +1957,7 @@ ahc_send_async(struct ahc_softc *ahc, ch
 void
 ahc_done(struct ahc_softc *ahc, struct scb *scb)
 {
-	Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 	struct	   ahc_linux_device *dev;
 
 	LIST_REMOVE(scb, pending_links);
@@ -2515,7 +1968,7 @@ ahc_done(struct ahc_softc *ahc, struct s
 		target_offset = SCB_GET_TARGET_OFFSET(ahc, scb);
 		untagged_q = &(ahc->untagged_queues[target_offset]);
 		TAILQ_REMOVE(untagged_q, scb, links.tqe);
-		ahc_run_untagged_queue(ahc, untagged_q);
+		BUG_ON(!TAILQ_EMPTY(untagged_q));
 	}
 
 	if ((scb->flags & SCB_ACTIVE) == 0) {
@@ -2583,8 +2036,6 @@ ahc_done(struct ahc_softc *ahc, struct s
 		}
 	} else if (ahc_get_transaction_status(scb) == CAM_SCSI_STATUS_ERROR) {
 		ahc_linux_handle_scsi_status(ahc, dev, scb);
-	} else if (ahc_get_transaction_status(scb) == CAM_SEL_TIMEOUT) {
-		dev->flags |= AHC_DEV_UNCONFIGURED;
 	}
 
 	if (dev->openings == 1
@@ -2606,16 +2057,6 @@ ahc_done(struct ahc_softc *ahc, struct s
 	if (dev->active == 0)
 		dev->commands_since_idle_or_otag = 0;
 
-	if (TAILQ_EMPTY(&dev->busyq)) {
-		if ((dev->flags & AHC_DEV_UNCONFIGURED) != 0
-		 && dev->active == 0
-	 	 && (dev->flags & AHC_DEV_TIMER_ACTIVE) == 0)
-			ahc_linux_free_device(ahc, dev);
-	} else if ((dev->flags & AHC_DEV_ON_RUN_LIST) == 0) {
-		TAILQ_INSERT_TAIL(&ahc->platform_data->device_runq, dev, links);
-		dev->flags |= AHC_DEV_ON_RUN_LIST;
-	}
-
 	if ((scb->flags & SCB_RECOVERY_SCB) != 0) {
 		printf("Recovery SCB completes\n");
 		if (ahc_get_transaction_status(scb) == CAM_BDR_SENT
@@ -2659,7 +2100,7 @@ ahc_linux_handle_scsi_status(struct ahc_
 	case SCSI_STATUS_CHECK_COND:
 	case SCSI_STATUS_CMD_TERMINATED:
 	{
-		Scsi_Cmnd *cmd;
+		struct scsi_cmnd *cmd;
 
 		/*
 		 * Copy sense information to the OS's cmd
@@ -2754,52 +2195,15 @@ ahc_linux_handle_scsi_status(struct ahc_
 		ahc_platform_set_tags(ahc, &devinfo,
 			     (dev->flags & AHC_DEV_Q_BASIC)
 			   ? AHC_QUEUE_BASIC : AHC_QUEUE_TAGGED);
-		/* FALLTHROUGH */
-	}
-	case SCSI_STATUS_BUSY:
-	{
-		/*
-		 * Set a short timer to defer sending commands for
-		 * a bit since Linux will not delay in this case.
-		 */
-		if ((dev->flags & AHC_DEV_TIMER_ACTIVE) != 0) {
-			printf("%s:%c:%d: Device Timer still active during "
-			       "busy processing\n", ahc_name(ahc),
-				dev->target->channel, dev->target->target);
-			break;
-		}
-		dev->flags |= AHC_DEV_TIMER_ACTIVE;
-		dev->qfrozen++;
-		init_timer(&dev->timer);
-		dev->timer.data = (u_long)dev;
-		dev->timer.expires = jiffies + (HZ/2);
-		dev->timer.function = ahc_linux_dev_timed_unfreeze;
-		add_timer(&dev->timer);
 		break;
 	}
 	}
 }
 
 static void
-ahc_linux_queue_cmd_complete(struct ahc_softc *ahc, Scsi_Cmnd *cmd)
+ahc_linux_queue_cmd_complete(struct ahc_softc *ahc, struct scsi_cmnd *cmd)
 {
 	/*
-	 * Typically, the complete queue has very few entries
-	 * queued to it before the queue is emptied by
-	 * ahc_linux_run_complete_queue, so sorting the entries
-	 * by generation number should be inexpensive.
-	 * We perform the sort so that commands that complete
-	 * with an error are retuned in the order origionally
-	 * queued to the controller so that any subsequent retries
-	 * are performed in order.  The underlying ahc routines do
-	 * not guarantee the order that aborted commands will be
-	 * returned to us.
-	 */
-	struct ahc_completeq *completeq;
-	struct ahc_cmd *list_cmd;
-	struct ahc_cmd *acmd;
-
-	/*
 	 * Map CAM error codes into Linux Error codes.  We
 	 * avoid the conversion so that the DV code has the
 	 * full error information available when making
@@ -2852,26 +2256,7 @@ ahc_linux_queue_cmd_complete(struct ahc_
 			new_status = DID_ERROR;
 			break;
 		case CAM_REQUEUE_REQ:
-			/*
-			 * If we want the request requeued, make sure there
-			 * are sufficent retries.  In the old scsi error code,
-			 * we used to be able to specify a result code that
-			 * bypassed the retry count.  Now we must use this
-			 * hack.  We also "fake" a check condition with
-			 * a sense code of ABORTED COMMAND.  This seems to
-			 * evoke a retry even if this command is being sent
-			 * via the eh thread.  Ick!  Ick!  Ick!
-			 */
-			if (cmd->retries > 0)
-				cmd->retries--;
-			new_status = DID_OK;
-			ahc_cmd_set_scsi_status(cmd, SCSI_STATUS_CHECK_COND);
-			cmd->result |= (DRIVER_SENSE << 24);
-			memset(cmd->sense_buffer, 0,
-			       sizeof(cmd->sense_buffer));
-			cmd->sense_buffer[0] = SSD_ERRCODE_VALID
-					     | SSD_CURRENT_ERROR;
-			cmd->sense_buffer[2] = SSD_KEY_ABORTED_COMMAND;
+			new_status = DID_REQUEUE;
 			break;
 		default:
 			/* We should never get here */
@@ -2882,17 +2267,7 @@ ahc_linux_queue_cmd_complete(struct ahc_
 		ahc_cmd_set_transaction_status(cmd, new_status);
 	}
 
-	completeq = &ahc->platform_data->completeq;
-	list_cmd = TAILQ_FIRST(completeq);
-	acmd = (struct ahc_cmd *)cmd;
-	while (list_cmd != NULL
-	    && acmd_scsi_cmd(list_cmd).serial_number
-	     < acmd_scsi_cmd(acmd).serial_number)
-		list_cmd = TAILQ_NEXT(list_cmd, acmd_links.tqe);
-	if (list_cmd != NULL)
-		TAILQ_INSERT_BEFORE(list_cmd, acmd, acmd_links.tqe);
-	else
-		TAILQ_INSERT_TAIL(completeq, acmd, acmd_links.tqe);
+	cmd->scsi_done(cmd);
 }
 
 static void
@@ -2940,7 +2315,6 @@ ahc_linux_release_simq(u_long arg)
 		ahc->platform_data->qfrozen--;
 	if (ahc->platform_data->qfrozen == 0)
 		unblock_reqs = 1;
-	ahc_schedule_runq(ahc);
 	ahc_unlock(ahc, &s);
 	/*
 	 * There is still a race here.  The mid-layer
@@ -2952,37 +2326,12 @@ ahc_linux_release_simq(u_long arg)
 		scsi_unblock_requests(ahc->platform_data->host);
 }
 
-static void
-ahc_linux_dev_timed_unfreeze(u_long arg)
-{
-	struct ahc_linux_device *dev;
-	struct ahc_softc *ahc;
-	u_long s;
-
-	dev = (struct ahc_linux_device *)arg;
-	ahc = dev->target->ahc;
-	ahc_lock(ahc, &s);
-	dev->flags &= ~AHC_DEV_TIMER_ACTIVE;
-	if (dev->qfrozen > 0)
-		dev->qfrozen--;
-	if (dev->qfrozen == 0
-	 && (dev->flags & AHC_DEV_ON_RUN_LIST) == 0)
-		ahc_linux_run_device_queue(ahc, dev);
-	if (TAILQ_EMPTY(&dev->busyq)
-	 && dev->active == 0)
-		__ahc_linux_free_device(ahc, dev);
-	ahc_unlock(ahc, &s);
-}
-
 static int
-ahc_linux_queue_recovery_cmd(Scsi_Cmnd *cmd, scb_flag flag)
+ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 {
 	struct ahc_softc *ahc;
-	struct ahc_cmd *acmd;
-	struct ahc_cmd *list_acmd;
 	struct ahc_linux_device *dev;
 	struct scb *pending_scb;
-	u_long s;
 	u_int  saved_scbptr;
 	u_int  active_scb_index;
 	u_int  last_phase;
@@ -2998,7 +2347,6 @@ ahc_linux_queue_recovery_cmd(Scsi_Cmnd *
 	paused = FALSE;
 	wait = FALSE;
 	ahc = *(struct ahc_softc **)cmd->device->host->hostdata;
-	acmd = (struct ahc_cmd *)cmd;
 
 	printf("%s:%d:%d:%d: Attempting to queue a%s message\n",
 	       ahc_name(ahc), cmd->device->channel,
@@ -3011,22 +2359,6 @@ ahc_linux_queue_recovery_cmd(Scsi_Cmnd *
 	printf("\n");
 
 	/*
-	 * In all versions of Linux, we have to work around
-	 * a major flaw in how the mid-layer is locked down
-	 * if we are to sleep successfully in our error handler
-	 * while allowing our interrupt handler to run.  Since
-	 * the midlayer acquires either the io_request_lock or
-	 * our lock prior to calling us, we must use the
-	 * spin_unlock_irq() method for unlocking our lock.
-	 * This will force interrupts to be enabled on the
-	 * current CPU.  Since the EH thread should not have
-	 * been running with CPU interrupts disabled other than
-	 * by acquiring either the io_request_lock or our own
-	 * lock, this *should* be safe.
-	 */
-	ahc_midlayer_entrypoint_lock(ahc, &s);
-
-	/*
 	 * First determine if we currently own this command.
 	 * Start by searching the device queue.  If not found
 	 * there, check the pending_scb list.  If not found
@@ -3034,7 +2366,7 @@ ahc_linux_queue_recovery_cmd(Scsi_Cmnd *
 	 * command, return success.
 	 */
 	dev = ahc_linux_get_device(ahc, cmd->device->channel, cmd->device->id,
-				   cmd->device->lun, /*alloc*/FALSE);
+				   cmd->device->lun);
 
 	if (dev == NULL) {
 		/*
@@ -3048,24 +2380,6 @@ ahc_linux_queue_recovery_cmd(Scsi_Cmnd *
 		goto no_cmd;
 	}
 
-	TAILQ_FOREACH(list_acmd, &dev->busyq, acmd_links.tqe) {
-		if (list_acmd == acmd)
-			break;
-	}
-
-	if (list_acmd != NULL) {
-		printf("%s:%d:%d:%d: Command found on device queue\n",
-		       ahc_name(ahc), cmd->device->channel, cmd->device->id,
-		       cmd->device->lun);
-		if (flag == SCB_ABORT) {
-			TAILQ_REMOVE(&dev->busyq, list_acmd, acmd_links.tqe);
-			cmd->result = DID_ABORT << 16;
-			ahc_linux_queue_cmd_complete(ahc, cmd);
-			retval = SUCCESS;
-			goto done;
-		}
-	}
-
 	if ((dev->flags & (AHC_DEV_Q_BASIC|AHC_DEV_Q_TAGGED)) == 0
 	 && ahc_search_untagged_queues(ahc, cmd, cmd->device->id,
 				       cmd->device->channel + 'A',
@@ -3299,53 +2613,42 @@ done:
 		}
 		spin_lock_irq(&ahc->platform_data->spin_lock);
 	}
-	ahc_schedule_runq(ahc);
-	ahc_linux_run_complete_queue(ahc);
-	ahc_midlayer_entrypoint_unlock(ahc, &s);
 	return (retval);
 }
 
 void
 ahc_platform_dump_card_state(struct ahc_softc *ahc)
 {
-	struct ahc_linux_device *dev;
-	int channel;
-	int maxchannel;
-	int target;
-	int maxtarget;
-	int lun;
-	int i;
-
-	maxchannel = (ahc->features & AHC_TWIN) ? 1 : 0;
-	maxtarget = (ahc->features & AHC_WIDE) ? 15 : 7;
-	for (channel = 0; channel <= maxchannel; channel++) {
-
-		for (target = 0; target <=maxtarget; target++) {
-
-			for (lun = 0; lun < AHC_NUM_LUNS; lun++) {
-				struct ahc_cmd *acmd;
-
-				dev = ahc_linux_get_device(ahc, channel, target,
-							   lun, /*alloc*/FALSE);
-				if (dev == NULL)
-					continue;
-
-				printf("DevQ(%d:%d:%d): ",
-				       channel, target, lun);
-				i = 0;
-				TAILQ_FOREACH(acmd, &dev->busyq,
-					      acmd_links.tqe) {
-					if (i++ > AHC_SCB_MAX)
-						break;
-				}
-				printf("%d waiting\n", i);
-			}
-		}
-	}
 }
 
 static void ahc_linux_exit(void);
 
+static void ahc_linux_get_width(struct scsi_target *starget)
+{
+	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
+	struct ahc_softc *ahc = *((struct ahc_softc **)shost->hostdata);
+	struct ahc_tmode_tstate *tstate;
+	struct ahc_initiator_tinfo *tinfo 
+		= ahc_fetch_transinfo(ahc,
+				      starget->channel + 'A',
+				      shost->this_id, starget->id, &tstate);
+	spi_width(starget) = tinfo->curr.width;
+}
+
+static void ahc_linux_set_width(struct scsi_target *starget, int width)
+{
+	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
+	struct ahc_softc *ahc = *((struct ahc_softc **)shost->hostdata);
+	struct ahc_devinfo devinfo;
+	unsigned long flags;
+
+	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
+			    starget->channel + 'A', ROLE_INITIATOR);
+	ahc_lock(ahc, &flags);
+	ahc_set_width(ahc, &devinfo, width, AHC_TRANS_GOAL, FALSE);
+	ahc_unlock(ahc, &flags);
+}
+
 static void ahc_linux_get_period(struct scsi_target *starget)
 {
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
@@ -3378,6 +2681,14 @@ static void ahc_linux_set_period(struct 
 
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
+
+	/* all PPR requests apart from QAS require wide transfers */
+	if (ppr_options & ~MSG_EXT_PPR_QAS_REQ) {
+		ahc_linux_get_width(starget);
+		if (spi_width(starget) == 0)
+			ppr_options &= MSG_EXT_PPR_QAS_REQ;
+	}
+
 	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options, AHC_SYNCRATE_DT);
 	ahc_lock(ahc, &flags);
 	ahc_set_syncrate(ahc, &devinfo, syncrate, period, offset,
@@ -3425,32 +2736,6 @@ static void ahc_linux_set_offset(struct 
 	ahc_unlock(ahc, &flags);
 }
 
-static void ahc_linux_get_width(struct scsi_target *starget)
-{
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct ahc_softc *ahc = *((struct ahc_softc **)shost->hostdata);
-	struct ahc_tmode_tstate *tstate;
-	struct ahc_initiator_tinfo *tinfo 
-		= ahc_fetch_transinfo(ahc,
-				      starget->channel + 'A',
-				      shost->this_id, starget->id, &tstate);
-	spi_width(starget) = tinfo->curr.width;
-}
-
-static void ahc_linux_set_width(struct scsi_target *starget, int width)
-{
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct ahc_softc *ahc = *((struct ahc_softc **)shost->hostdata);
-	struct ahc_devinfo devinfo;
-	unsigned long flags;
-
-	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
-			    starget->channel + 'A', ROLE_INITIATOR);
-	ahc_lock(ahc, &flags);
-	ahc_set_width(ahc, &devinfo, width, AHC_TRANS_GOAL, FALSE);
-	ahc_unlock(ahc, &flags);
-}
-
 static void ahc_linux_get_dt(struct scsi_target *starget)
 {
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
@@ -3481,8 +2766,7 @@ static void ahc_linux_set_dt(struct scsi
 
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
-	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,
-				     dt ? AHC_SYNCRATE_DT : AHC_SYNCRATE_ULTRA2);
+	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,AHC_SYNCRATE_DT);
 	ahc_lock(ahc, &flags);
 	ahc_set_syncrate(ahc, &devinfo, syncrate, period, tinfo->curr.offset,
 			 ppr_options, AHC_TRANS_GOAL, FALSE);
@@ -3514,7 +2798,6 @@ static void ahc_linux_set_qas(struct scs
 	unsigned int ppr_options = tinfo->curr.ppr_options
 		& ~MSG_EXT_PPR_QAS_REQ;
 	unsigned int period = tinfo->curr.period;
-	unsigned int dt = ppr_options & MSG_EXT_PPR_DT_REQ;
 	unsigned long flags;
 	struct ahc_syncrate *syncrate;
 
@@ -3523,8 +2806,7 @@ static void ahc_linux_set_qas(struct scs
 
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
-	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,
-				     dt ? AHC_SYNCRATE_DT : AHC_SYNCRATE_ULTRA2);
+	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options, AHC_SYNCRATE_DT);
 	ahc_lock(ahc, &flags);
 	ahc_set_syncrate(ahc, &devinfo, syncrate, period, tinfo->curr.offset,
 			 ppr_options, AHC_TRANS_GOAL, FALSE);
@@ -3556,7 +2838,6 @@ static void ahc_linux_set_iu(struct scsi
 	unsigned int ppr_options = tinfo->curr.ppr_options
 		& ~MSG_EXT_PPR_IU_REQ;
 	unsigned int period = tinfo->curr.period;
-	unsigned int dt = ppr_options & MSG_EXT_PPR_DT_REQ;
 	unsigned long flags;
 	struct ahc_syncrate *syncrate;
 
@@ -3565,8 +2846,7 @@ static void ahc_linux_set_iu(struct scsi
 
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
-	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,
-				     dt ? AHC_SYNCRATE_DT : AHC_SYNCRATE_ULTRA2);
+	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options, AHC_SYNCRATE_DT);
 	ahc_lock(ahc, &flags);
 	ahc_set_syncrate(ahc, &devinfo, syncrate, period, tinfo->curr.offset,
 			 ppr_options, AHC_TRANS_GOAL, FALSE);
@@ -3599,7 +2879,6 @@ static struct spi_function_template ahc_
 static int __init
 ahc_linux_init(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	ahc_linux_transport_template = spi_attach_transport(&ahc_linux_transport_functions);
 	if (!ahc_linux_transport_template)
 		return -ENODEV;
@@ -3608,29 +2887,11 @@ ahc_linux_init(void)
 	spi_release_transport(ahc_linux_transport_template);
 	ahc_linux_exit();
 	return -ENODEV;
-#else
-	scsi_register_module(MODULE_SCSI_HA, &aic7xxx_driver_template);
-	if (aic7xxx_driver_template.present == 0) {
-		scsi_unregister_module(MODULE_SCSI_HA,
-				       &aic7xxx_driver_template);
-		return (-ENODEV);
-	}
-
-	return (0);
-#endif
 }
 
 static void
 ahc_linux_exit(void)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	/*
-	 * In 2.4 we have to unregister from the PCI core _after_
-	 * unregistering from the scsi midlayer to avoid dangling
-	 * references.
-	 */
-	scsi_unregister_module(MODULE_SCSI_HA, &aic7xxx_driver_template);
-#endif
 	ahc_linux_pci_exit();
 	ahc_linux_eisa_exit();
 	spi_release_transport(ahc_linux_transport_template);
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -59,6 +59,7 @@
 #ifndef _AIC7XXX_LINUX_H_
 #define _AIC7XXX_LINUX_H_
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
@@ -66,18 +67,21 @@
 #include <linux/pci.h>
 #include <linux/smp_lock.h>
 #include <linux/version.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <asm/byteorder.h>
 #include <asm/io.h>
 
-#include <linux/interrupt.h> /* For tasklet support. */
-#include <linux/config.h>
-#include <linux/slab.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi_tcq.h>
 
 /* Core SCSI definitions */
 #define AIC_LIB_PREFIX ahc
-#include "scsi.h"
-#include <scsi/scsi_host.h>
 
 /* Name space conflict with BSD queue macros */
 #ifdef LIST_HEAD
@@ -106,7 +110,7 @@
 /************************* Forward Declarations *******************************/
 struct ahc_softc;
 typedef struct pci_dev *ahc_dev_softc_t;
-typedef Scsi_Cmnd      *ahc_io_ctx_t;
+typedef struct scsi_cmnd      *ahc_io_ctx_t;
 
 /******************************* Byte Order ***********************************/
 #define ahc_htobe16(x)	cpu_to_be16(x)
@@ -144,7 +148,7 @@ typedef Scsi_Cmnd      *ahc_io_ctx_t;
 extern u_int aic7xxx_no_probe;
 extern u_int aic7xxx_allow_memio;
 extern int aic7xxx_detect_complete;
-extern Scsi_Host_Template aic7xxx_driver_template;
+extern struct scsi_host_template aic7xxx_driver_template;
 
 /***************************** Bus Space/DMA **********************************/
 
@@ -174,11 +178,7 @@ struct ahc_linux_dma_tag
 };
 typedef struct ahc_linux_dma_tag* bus_dma_tag_t;
 
-struct ahc_linux_dmamap
-{
-	dma_addr_t	bus_addr;
-};
-typedef struct ahc_linux_dmamap* bus_dmamap_t;
+typedef dma_addr_t bus_dmamap_t;
 
 typedef int bus_dma_filter_t(void*, dma_addr_t);
 typedef void bus_dmamap_callback_t(void *, bus_dma_segment_t *, int, int);
@@ -281,12 +281,6 @@ ahc_scb_timer_reset(struct scb *scb, u_i
 /***************************** SMP support ************************************/
 #include <linux/spinlock.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0) || defined(SCSI_HAS_HOST_LOCK))
-#define AHC_SCSI_HAS_HOST_LOCK 1
-#else
-#define AHC_SCSI_HAS_HOST_LOCK 0
-#endif
-
 #define AIC7XXX_DRIVER_VERSION "6.2.36"
 
 /**************************** Front End Queues ********************************/
@@ -328,20 +322,15 @@ struct ahc_cmd {
  */
 TAILQ_HEAD(ahc_busyq, ahc_cmd);
 typedef enum {
-	AHC_DEV_UNCONFIGURED	 = 0x01,
 	AHC_DEV_FREEZE_TIL_EMPTY = 0x02, /* Freeze queue until active == 0 */
-	AHC_DEV_TIMER_ACTIVE	 = 0x04, /* Our timer is active */
-	AHC_DEV_ON_RUN_LIST	 = 0x08, /* Queued to be run later */
 	AHC_DEV_Q_BASIC		 = 0x10, /* Allow basic device queuing */
 	AHC_DEV_Q_TAGGED	 = 0x20, /* Allow full SCSI2 command queueing */
 	AHC_DEV_PERIODIC_OTAG	 = 0x40, /* Send OTAG to prevent starvation */
-	AHC_DEV_SLAVE_CONFIGURED = 0x80	 /* slave_configure() has been called */
 } ahc_linux_dev_flags;
 
 struct ahc_linux_target;
 struct ahc_linux_device {
 	TAILQ_ENTRY(ahc_linux_device) links;
-	struct		ahc_busyq busyq;
 
 	/*
 	 * The number of transactions currently
@@ -382,11 +371,6 @@ struct ahc_linux_device {
 	ahc_linux_dev_flags	flags;
 
 	/*
-	 * Per device timer.
-	 */
-	struct timer_list	timer;
-
-	/*
 	 * The high limit for the tags variable.
 	 */
 	u_int			maxtags;
@@ -419,7 +403,7 @@ struct ahc_linux_device {
 #define AHC_OTAG_THRESH	500
 
 	int			lun;
-	Scsi_Device	       *scsi_device;
+	struct scsi_device       *scsi_device;
 	struct			ahc_linux_target *target;
 };
 
@@ -439,32 +423,16 @@ struct ahc_linux_target {
  * manner and are allocated below 4GB, the number of S/G segments is
  * unrestricted.
  */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-/*
- * We dynamically adjust the number of segments in pre-2.5 kernels to
- * avoid fragmentation issues in the SCSI mid-layer's private memory
- * allocator.  See aic7xxx_osm.c ahc_linux_size_nseg() for details.
- */
-extern u_int ahc_linux_nseg;
-#define	AHC_NSEG ahc_linux_nseg
-#define	AHC_LINUX_MIN_NSEG 64
-#else
 #define	AHC_NSEG 128
-#endif
 
 /*
  * Per-SCB OSM storage.
  */
-typedef enum {
-	AHC_UP_EH_SEMAPHORE = 0x1
-} ahc_linux_scb_flags;
-
 struct scb_platform_data {
 	struct ahc_linux_device	*dev;
 	dma_addr_t		 buf_busaddr;
 	uint32_t		 xfer_len;
 	uint32_t		 sense_resid;	/* Auto-Sense residual */
-	ahc_linux_scb_flags	 flags;
 };
 
 /*
@@ -473,39 +441,24 @@ struct scb_platform_data {
  * alignment restrictions of the various platforms supported by
  * this driver.
  */
-typedef enum {
-	AHC_RUN_CMPLT_Q_TIMER	 = 0x10
-} ahc_linux_softc_flags;
-
-TAILQ_HEAD(ahc_completeq, ahc_cmd);
-
 struct ahc_platform_data {
 	/*
 	 * Fields accessed from interrupt context.
 	 */
 	struct ahc_linux_target *targets[AHC_NUM_TARGETS]; 
-	TAILQ_HEAD(, ahc_linux_device) device_runq;
-	struct ahc_completeq	 completeq;
 
 	spinlock_t		 spin_lock;
-	struct tasklet_struct	 runq_tasklet;
 	u_int			 qfrozen;
-	pid_t			 dv_pid;
-	struct timer_list	 completeq_timer;
 	struct timer_list	 reset_timer;
 	struct semaphore	 eh_sem;
-	struct semaphore	 dv_sem;
-	struct semaphore	 dv_cmd_sem;	/* XXX This needs to be in
-						 * the target struct
-						 */
-	struct scsi_device	*dv_scsi_dev;
 	struct Scsi_Host        *host;		/* pointer to scsi host */
 #define AHC_LINUX_NOIRQ	((uint32_t)~0)
 	uint32_t		 irq;		/* IRQ for this adapter */
 	uint32_t		 bios_address;
 	uint32_t		 mem_busaddr;	/* Mem Base Addr */
-	uint64_t		 hw_dma_mask;
-	ahc_linux_softc_flags	 flags;
+
+#define	AHC_UP_EH_SEMAPHORE	 0x1
+	uint32_t		 flags;
 };
 
 /************************** OS Utility Wrappers *******************************/
@@ -594,7 +547,7 @@ ahc_insb(struct ahc_softc * ahc, long po
 
 /**************************** Initialization **********************************/
 int		ahc_linux_register_host(struct ahc_softc *,
-					Scsi_Host_Template *);
+					struct scsi_host_template *);
 
 uint64_t	ahc_linux_get_memsize(void);
 
@@ -615,17 +568,6 @@ static __inline void ahc_lockinit(struct
 static __inline void ahc_lock(struct ahc_softc *, unsigned long *flags);
 static __inline void ahc_unlock(struct ahc_softc *, unsigned long *flags);
 
-/* Lock acquisition and release of the above lock in midlayer entry points. */
-static __inline void ahc_midlayer_entrypoint_lock(struct ahc_softc *,
-						  unsigned long *flags);
-static __inline void ahc_midlayer_entrypoint_unlock(struct ahc_softc *,
-						    unsigned long *flags);
-
-/* Lock held during command compeletion to the upper layer */
-static __inline void ahc_done_lockinit(struct ahc_softc *);
-static __inline void ahc_done_lock(struct ahc_softc *, unsigned long *flags);
-static __inline void ahc_done_unlock(struct ahc_softc *, unsigned long *flags);
-
 /* Lock held during ahc_list manipulation and ahc softc frees */
 extern spinlock_t ahc_list_spinlock;
 static __inline void ahc_list_lockinit(void);
@@ -651,57 +593,6 @@ ahc_unlock(struct ahc_softc *ahc, unsign
 }
 
 static __inline void
-ahc_midlayer_entrypoint_lock(struct ahc_softc *ahc, unsigned long *flags)
-{
-	/*
-	 * In 2.5.X and some 2.4.X versions, the midlayer takes our
-	 * lock just before calling us, so we avoid locking again.
-	 * For other kernel versions, the io_request_lock is taken
-	 * just before our entry point is called.  In this case, we
-	 * trade the io_request_lock for our per-softc lock.
-	 */
-#if AHC_SCSI_HAS_HOST_LOCK == 0
-	spin_unlock(&io_request_lock);
-	spin_lock(&ahc->platform_data->spin_lock);
-#endif
-}
-
-static __inline void
-ahc_midlayer_entrypoint_unlock(struct ahc_softc *ahc, unsigned long *flags)
-{
-#if AHC_SCSI_HAS_HOST_LOCK == 0
-	spin_unlock(&ahc->platform_data->spin_lock);
-	spin_lock(&io_request_lock);
-#endif
-}
-
-static __inline void
-ahc_done_lockinit(struct ahc_softc *ahc)
-{
-	/*
-	 * In 2.5.X, our own lock is held during completions.
-	 * In previous versions, the io_request_lock is used.
-	 * In either case, we can't initialize this lock again.
-	 */
-}
-
-static __inline void
-ahc_done_lock(struct ahc_softc *ahc, unsigned long *flags)
-{
-#if AHC_SCSI_HAS_HOST_LOCK == 0
-	spin_lock_irqsave(&io_request_lock, *flags);
-#endif
-}
-
-static __inline void
-ahc_done_unlock(struct ahc_softc *ahc, unsigned long *flags)
-{
-#if AHC_SCSI_HAS_HOST_LOCK == 0
-	spin_unlock_irqrestore(&io_request_lock, *flags);
-#endif
-}
-
-static __inline void
 ahc_list_lockinit(void)
 {
 	spin_lock_init(&ahc_list_spinlock);
@@ -767,12 +658,6 @@ typedef enum
 } ahc_power_state;
 
 /**************************** VL/EISA Routines ********************************/
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) \
-  && (defined(__i386__) || defined(__alpha__)) \
-  && (!defined(CONFIG_EISA)))
-#define CONFIG_EISA
-#endif
-
 #ifdef CONFIG_EISA
 extern uint32_t aic7xxx_probe_eisa_vl;
 int			 ahc_linux_eisa_init(void);
@@ -888,22 +773,18 @@ ahc_flush_device_writes(struct ahc_softc
 }
 
 /**************************** Proc FS Support *********************************/
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-int	ahc_linux_proc_info(char *, char **, off_t, int, int, int);
-#else
 int	ahc_linux_proc_info(struct Scsi_Host *, char *, char **,
 			    off_t, int, int);
-#endif
 
 /*************************** Domain Validation ********************************/
 /*********************** Transaction Access Wrappers *************************/
-static __inline void ahc_cmd_set_transaction_status(Scsi_Cmnd *, uint32_t);
+static __inline void ahc_cmd_set_transaction_status(struct scsi_cmnd *, uint32_t);
 static __inline void ahc_set_transaction_status(struct scb *, uint32_t);
-static __inline void ahc_cmd_set_scsi_status(Scsi_Cmnd *, uint32_t);
+static __inline void ahc_cmd_set_scsi_status(struct scsi_cmnd *, uint32_t);
 static __inline void ahc_set_scsi_status(struct scb *, uint32_t);
-static __inline uint32_t ahc_cmd_get_transaction_status(Scsi_Cmnd *cmd);
+static __inline uint32_t ahc_cmd_get_transaction_status(struct scsi_cmnd *cmd);
 static __inline uint32_t ahc_get_transaction_status(struct scb *);
-static __inline uint32_t ahc_cmd_get_scsi_status(Scsi_Cmnd *cmd);
+static __inline uint32_t ahc_cmd_get_scsi_status(struct scsi_cmnd *cmd);
 static __inline uint32_t ahc_get_scsi_status(struct scb *);
 static __inline void ahc_set_transaction_tag(struct scb *, int, u_int);
 static __inline u_long ahc_get_transfer_length(struct scb *);
@@ -922,7 +803,7 @@ static __inline void ahc_platform_scb_fr
 static __inline void ahc_freeze_scb(struct scb *scb);
 
 static __inline
-void ahc_cmd_set_transaction_status(Scsi_Cmnd *cmd, uint32_t status)
+void ahc_cmd_set_transaction_status(struct scsi_cmnd *cmd, uint32_t status)
 {
 	cmd->result &= ~(CAM_STATUS_MASK << 16);
 	cmd->result |= status << 16;
@@ -935,7 +816,7 @@ void ahc_set_transaction_status(struct s
 }
 
 static __inline
-void ahc_cmd_set_scsi_status(Scsi_Cmnd *cmd, uint32_t status)
+void ahc_cmd_set_scsi_status(struct scsi_cmnd *cmd, uint32_t status)
 {
 	cmd->result &= ~0xFFFF;
 	cmd->result |= status;
@@ -948,7 +829,7 @@ void ahc_set_scsi_status(struct scb *scb
 }
 
 static __inline
-uint32_t ahc_cmd_get_transaction_status(Scsi_Cmnd *cmd)
+uint32_t ahc_cmd_get_transaction_status(struct scsi_cmnd *cmd)
 {
 	return ((cmd->result >> 16) & CAM_STATUS_MASK);
 }
@@ -960,7 +841,7 @@ uint32_t ahc_get_transaction_status(stru
 }
 
 static __inline
-uint32_t ahc_cmd_get_scsi_status(Scsi_Cmnd *cmd)
+uint32_t ahc_cmd_get_scsi_status(struct scsi_cmnd *cmd)
 {
 	return (cmd->result & 0xFFFF);
 }
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -221,13 +221,11 @@ ahc_linux_pci_dev_probe(struct pci_dev *
 	 && ahc_linux_get_memsize() > 0x80000000
 	 && pci_set_dma_mask(pdev, mask_39bit) == 0) {
 		ahc->flags |= AHC_39BIT_ADDRESSING;
-		ahc->platform_data->hw_dma_mask = mask_39bit;
 	} else {
 		if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 			printk(KERN_WARNING "aic7xxx: No suitable DMA available.\n");
                 	return (-ENODEV);
 		}
-		ahc->platform_data->hw_dma_mask = DMA_32BIT_MASK;
 	}
 	ahc->dev_softc = pci;
 	error = ahc_pci_config(ahc, entry);
@@ -236,15 +234,8 @@ ahc_linux_pci_dev_probe(struct pci_dev *
 		return (-error);
 	}
 	pci_set_drvdata(pdev, ahc);
-	if (aic7xxx_detect_complete) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	if (aic7xxx_detect_complete)
 		ahc_linux_register_host(ahc, &aic7xxx_driver_template);
-#else
-		printf("aic7xxx: ignoring PCI device found after "
-		       "initialization\n");
-		return (-ENODEV);
-#endif
-	}
 	return (0);
 }
 
--- a/drivers/scsi/aic7xxx/aic7xxx_proc.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_proc.c
@@ -289,13 +289,8 @@ done:
  * Return information to handle /proc support for the driver.
  */
 int
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-ahc_linux_proc_info(char *buffer, char **start, off_t offset,
-		    int length, int hostno, int inout)
-#else
 ahc_linux_proc_info(struct Scsi_Host *shost, char *buffer, char **start,
 		    off_t offset, int length, int inout)
-#endif
 {
 	struct	ahc_softc *ahc;
 	struct	info_str info;
@@ -307,15 +302,7 @@ ahc_linux_proc_info(struct Scsi_Host *sh
 
 	retval = -EINVAL;
 	ahc_list_lock(&s);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	TAILQ_FOREACH(ahc, &ahc_tailq, links) {
-		if (ahc->platform_data->host->host_no == hostno)
-			break;
-	}
-#else
 	ahc = ahc_find_softc(*(struct ahc_softc **)shost->hostdata);
-#endif
-
 	if (ahc == NULL)
 		goto done;
 
--- a/drivers/scsi/aic7xxx/aiclib.c
+++ b/drivers/scsi/aic7xxx/aiclib.c
@@ -35,7 +35,6 @@
 #include <linux/version.h>
 
 /* Core SCSI definitions */
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include "aiclib.h"
 #include "cam.h"
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -35,7 +35,7 @@
 
 #define SPI_PRINTK(x, l, f, a...)	dev_printk(l, &(x)->dev, f , ##a)
 
-#define SPI_NUM_ATTRS 10	/* increase this if you add attributes */
+#define SPI_NUM_ATTRS 13	/* increase this if you add attributes */
 #define SPI_OTHER_ATTRS 1	/* Increase this if you add "always
 				 * on" attributes */
 #define SPI_HOST_ATTRS	1
@@ -219,8 +219,11 @@ static int spi_setup_transport_attrs(str
 	struct scsi_target *starget = to_scsi_target(dev);
 
 	spi_period(starget) = -1;	/* illegal value */
+	spi_min_period(starget) = 0;
 	spi_offset(starget) = 0;	/* async */
+	spi_max_offset(starget) = 255;
 	spi_width(starget) = 0;	/* narrow */
+	spi_max_width(starget) = 1;
 	spi_iu(starget) = 0;	/* no IU */
 	spi_dt(starget) = 0;	/* ST */
 	spi_qas(starget) = 0;
@@ -235,6 +238,34 @@ static int spi_setup_transport_attrs(str
 	return 0;
 }
 
+#define spi_transport_show_simple(field, format_string)			\
+									\
+static ssize_t								\
+show_spi_transport_##field(struct class_device *cdev, char *buf)	\
+{									\
+	struct scsi_target *starget = transport_class_to_starget(cdev);	\
+	struct spi_transport_attrs *tp;					\
+									\
+	tp = (struct spi_transport_attrs *)&starget->starget_data;	\
+	return snprintf(buf, 20, format_string, tp->field);		\
+}
+
+#define spi_transport_store_simple(field, format_string)		\
+									\
+static ssize_t								\
+store_spi_transport_##field(struct class_device *cdev, const char *buf, \
+			    size_t count)				\
+{									\
+	int val;							\
+	struct scsi_target *starget = transport_class_to_starget(cdev);	\
+	struct spi_transport_attrs *tp;					\
+									\
+	tp = (struct spi_transport_attrs *)&starget->starget_data;	\
+	val = simple_strtoul(buf, NULL, 0);				\
+	tp->field = val;						\
+	return count;							\
+}
+
 #define spi_transport_show_function(field, format_string)		\
 									\
 static ssize_t								\
@@ -261,6 +292,25 @@ store_spi_transport_##field(struct class
 	struct spi_internal *i = to_spi_internal(shost->transportt);	\
 									\
 	val = simple_strtoul(buf, NULL, 0);				\
+	i->f->set_##field(starget, val);			\
+	return count;							\
+}
+
+#define spi_transport_store_max(field, format_string)			\
+static ssize_t								\
+store_spi_transport_##field(struct class_device *cdev, const char *buf, \
+			    size_t count)				\
+{									\
+	int val;							\
+	struct scsi_target *starget = transport_class_to_starget(cdev);	\
+	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);	\
+	struct spi_internal *i = to_spi_internal(shost->transportt);	\
+	struct spi_transport_attrs *tp					\
+		= (struct spi_transport_attrs *)&starget->starget_data;	\
+									\
+	val = simple_strtoul(buf, NULL, 0);				\
+	if (val > tp->max_##field)					\
+		val = tp->max_##field;					\
 	i->f->set_##field(starget, val);				\
 	return count;							\
 }
@@ -272,9 +322,24 @@ static CLASS_DEVICE_ATTR(field, S_IRUGO 
 			 show_spi_transport_##field,			\
 			 store_spi_transport_##field);
 
+#define spi_transport_simple_attr(field, format_string)			\
+	spi_transport_show_simple(field, format_string)			\
+	spi_transport_store_simple(field, format_string)		\
+static CLASS_DEVICE_ATTR(field, S_IRUGO | S_IWUSR,			\
+			 show_spi_transport_##field,			\
+			 store_spi_transport_##field);
+
+#define spi_transport_max_attr(field, format_string)			\
+	spi_transport_show_function(field, format_string)		\
+	spi_transport_store_max(field, format_string)			\
+	spi_transport_simple_attr(max_##field, format_string)		\
+static CLASS_DEVICE_ATTR(field, S_IRUGO | S_IWUSR,			\
+			 show_spi_transport_##field,			\
+			 store_spi_transport_##field);
+
 /* The Parallel SCSI Tranport Attributes: */
-spi_transport_rd_attr(offset, "%d\n");
-spi_transport_rd_attr(width, "%d\n");
+spi_transport_max_attr(offset, "%d\n");
+spi_transport_max_attr(width, "%d\n");
 spi_transport_rd_attr(iu, "%d\n");
 spi_transport_rd_attr(dt, "%d\n");
 spi_transport_rd_attr(qas, "%d\n");
@@ -300,26 +365,18 @@ static CLASS_DEVICE_ATTR(revalidate, S_I
 
 /* Translate the period into ns according to the current spec
  * for SDTR/PPR messages */
-static ssize_t show_spi_transport_period(struct class_device *cdev, char *buf)
-
+static ssize_t
+show_spi_transport_period_helper(struct class_device *cdev, char *buf,
+				 int period)
 {
-	struct scsi_target *starget = transport_class_to_starget(cdev);
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct spi_transport_attrs *tp;
 	int len, picosec;
-	struct spi_internal *i = to_spi_internal(shost->transportt);
-
-	tp = (struct spi_transport_attrs *)&starget->starget_data;
-
-	if (i->f->get_period)
-		i->f->get_period(starget);
 
-	if (tp->period < 0 || tp->period > 0xff) {
+	if (period < 0 || period > 0xff) {
 		picosec = -1;
-	} else if (tp->period <= SPI_STATIC_PPR) {
-		picosec = ppr_to_ps[tp->period];
+	} else if (period <= SPI_STATIC_PPR) {
+		picosec = ppr_to_ps[period];
 	} else {
-		picosec = tp->period * 4000;
+		picosec = period * 4000;
 	}
 
 	if (picosec == -1) {
@@ -334,12 +391,9 @@ static ssize_t show_spi_transport_period
 }
 
 static ssize_t
-store_spi_transport_period(struct class_device *cdev, const char *buf,
-			    size_t count)
+store_spi_transport_period_helper(struct class_device *cdev, const char *buf,
+				  size_t count, int *periodp)
 {
-	struct scsi_target *starget = transport_class_to_starget(cdev);
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct spi_internal *i = to_spi_internal(shost->transportt);
 	int j, picosec, period = -1;
 	char *endp;
 
@@ -368,15 +422,79 @@ store_spi_transport_period(struct class_
 	if (period > 0xff)
 		period = 0xff;
 
-	i->f->set_period(starget, period);
+	*periodp = period;
 
 	return count;
 }
 
+static ssize_t
+show_spi_transport_period(struct class_device *cdev, char *buf)
+{
+	struct scsi_target *starget = transport_class_to_starget(cdev);
+	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
+	struct spi_internal *i = to_spi_internal(shost->transportt);
+	struct spi_transport_attrs *tp =
+		(struct spi_transport_attrs *)&starget->starget_data;
+
+	if (i->f->get_period)
+		i->f->get_period(starget);
+
+	return show_spi_transport_period_helper(cdev, buf, tp->period);
+}
+
+static ssize_t
+store_spi_transport_period(struct class_device *cdev, const char *buf,
+			    size_t count)
+{
+	struct scsi_target *starget = transport_class_to_starget(cdev);
+	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
+	struct spi_internal *i = to_spi_internal(shost->transportt);
+	struct spi_transport_attrs *tp =
+		(struct spi_transport_attrs *)&starget->starget_data;
+	int period, retval;
+
+	retval = store_spi_transport_period_helper(cdev, buf, count, &period);
+
+	if (period < tp->min_period)
+		period = tp->min_period;
+
+	i->f->set_period(starget, period);
+
+	return retval;
+}
+
 static CLASS_DEVICE_ATTR(period, S_IRUGO | S_IWUSR, 
 			 show_spi_transport_period,
 			 store_spi_transport_period);
 
+static ssize_t
+show_spi_transport_min_period(struct class_device *cdev, char *buf)
+{
+	struct scsi_target *starget = transport_class_to_starget(cdev);
+	struct spi_transport_attrs *tp =
+		(struct spi_transport_attrs *)&starget->starget_data;
+
+	return show_spi_transport_period_helper(cdev, buf, tp->min_period);
+}
+
+static ssize_t
+store_spi_transport_min_period(struct class_device *cdev, const char *buf,
+			    size_t count)
+{
+	struct scsi_target *starget = transport_class_to_starget(cdev);
+	struct spi_transport_attrs *tp =
+		(struct spi_transport_attrs *)&starget->starget_data;
+
+	return store_spi_transport_period_helper(cdev, buf, count,
+						 &tp->min_period);
+}
+
+
+static CLASS_DEVICE_ATTR(min_period, S_IRUGO | S_IWUSR, 
+			 show_spi_transport_min_period,
+			 store_spi_transport_min_period);
+
+
 static ssize_t show_spi_host_signalling(struct class_device *cdev, char *buf)
 {
 	struct Scsi_Host *shost = transport_class_to_shost(cdev);
@@ -642,6 +760,7 @@ spi_dv_device_internal(struct scsi_reque
 {
 	struct spi_internal *i = to_spi_internal(sreq->sr_host->transportt);
 	struct scsi_device *sdev = sreq->sr_device;
+	struct scsi_target *starget = sdev->sdev_target;
 	int len = sdev->inquiry_len;
 	/* first set us up for narrow async */
 	DV_SET(offset, 0);
@@ -655,9 +774,11 @@ spi_dv_device_internal(struct scsi_reque
 	}
 
 	/* test width */
-	if (i->f->set_width && sdev->wdtr) {
+	if (i->f->set_width && spi_max_width(starget) && sdev->wdtr) {
 		i->f->set_width(sdev->sdev_target, 1);
 
+		printk("WIDTH IS %d\n", spi_max_width(starget));
+
 		if (spi_dv_device_compare_inquiry(sreq, buffer,
 						   buffer + len,
 						   DV_LOOPS)
@@ -684,8 +805,8 @@ spi_dv_device_internal(struct scsi_reque
  retry:
 
 	/* now set up to the maximum */
-	DV_SET(offset, 255);
-	DV_SET(period, 1);
+	DV_SET(offset, spi_max_offset(starget));
+	DV_SET(period, spi_min_period(starget));
 
 	if (len == 0) {
 		SPI_PRINTK(sdev->sdev_target, KERN_INFO, "Domain Validation skipping write tests\n");
@@ -892,6 +1013,16 @@ EXPORT_SYMBOL(spi_display_xfer_agreement
 	if (i->f->show_##field)						\
 		count++
 
+#define SETUP_RELATED_ATTRIBUTE(field, rel_field)			\
+	i->private_attrs[count] = class_device_attr_##field;		\
+	if (!i->f->set_##rel_field) {					\
+		i->private_attrs[count].attr.mode = S_IRUGO;		\
+		i->private_attrs[count].store = NULL;			\
+	}								\
+	i->attrs[count] = &i->private_attrs[count];			\
+	if (i->f->show_##rel_field)					\
+		count++
+
 #define SETUP_HOST_ATTRIBUTE(field)					\
 	i->private_host_attrs[count] = class_device_attr_##field;	\
 	if (!i->f->set_##field) {					\
@@ -975,8 +1106,11 @@ spi_attach_transport(struct spi_function
 	i->f = ft;
 
 	SETUP_ATTRIBUTE(period);
+	SETUP_RELATED_ATTRIBUTE(min_period, period);
 	SETUP_ATTRIBUTE(offset);
+	SETUP_RELATED_ATTRIBUTE(max_offset, offset);
 	SETUP_ATTRIBUTE(width);
+	SETUP_RELATED_ATTRIBUTE(max_width, width);
 	SETUP_ATTRIBUTE(iu);
 	SETUP_ATTRIBUTE(dt);
 	SETUP_ATTRIBUTE(qas);
--- a/include/scsi/scsi_transport_spi.h
+++ b/include/scsi/scsi_transport_spi.h
@@ -27,8 +27,11 @@ struct scsi_transport_template;
 
 struct spi_transport_attrs {
 	int period;		/* value in the PPR/SDTR command */
+	int min_period;
 	int offset;
+	int max_offset;
 	unsigned int width:1;	/* 0 - narrow, 1 - wide */
+	unsigned int max_width:1;
 	unsigned int iu:1;	/* Information Units enabled */
 	unsigned int dt:1;	/* DT clocking enabled */
 	unsigned int qas:1;	/* Quick Arbitration and Selection enabled */
@@ -63,8 +66,11 @@ struct spi_host_attrs {
 
 /* accessor functions */
 #define spi_period(x)	(((struct spi_transport_attrs *)&(x)->starget_data)->period)
+#define spi_min_period(x) (((struct spi_transport_attrs *)&(x)->starget_data)->min_period)
 #define spi_offset(x)	(((struct spi_transport_attrs *)&(x)->starget_data)->offset)
+#define spi_max_offset(x) (((struct spi_transport_attrs *)&(x)->starget_data)->max_offset)
 #define spi_width(x)	(((struct spi_transport_attrs *)&(x)->starget_data)->width)
+#define spi_max_width(x) (((struct spi_transport_attrs *)&(x)->starget_data)->max_width)
 #define spi_iu(x)	(((struct spi_transport_attrs *)&(x)->starget_data)->iu)
 #define spi_dt(x)	(((struct spi_transport_attrs *)&(x)->starget_data)->dt)
 #define spi_qas(x)	(((struct spi_transport_attrs *)&(x)->starget_data)->qas)


