Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVE2ILr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVE2ILr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 04:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVE2ILq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 04:11:46 -0400
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:18314 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261277AbVE2IHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 04:07:21 -0400
Date: Sun, 29 May 2005 03:46:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFT][PATCH] aic79xx: remove busyq
Message-ID: <20050529074620.GA26151@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can anyone with aic79xx hardware give me a simple "it works"
or "this breaks things" answer, for the patch below?

This changes the aic79xx driver to use the standard Linux SCSI queueing
code, rather than its own.  After applying this patch, NO behavior
changes should be seen.

The patch is against 2.6.12-rc5, but probably applies OK to recent 2.6.x
kernels.


 drivers/scsi/aic7xxx/aic79xx_core.c    |    1 
 drivers/scsi/aic7xxx/aic79xx_osm.c     |  822 +++++----------------------------
 drivers/scsi/aic7xxx/aic79xx_osm.h     |   24 
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |    6 
 drivers/scsi/aic7xxx/aic79xx_proc.c    |   12 
 include/linux/libata.h                 |    6 
 include/linux/pci.h                    |    5 
 7 files changed, 146 insertions(+), 730 deletions(-)


diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -9039,7 +9039,6 @@ ahd_dump_card_state(struct ahd_softc *ah
 		ahd_outb(ahd, STACK, (ahd->saved_stack[i] >> 8) & 0xFF);
 	}
 	printf("\n<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>\n");
-	ahd_platform_dump_card_state(ahd);
 	ahd_restore_modes(ahd, saved_modes);
 	if (paused == 0)
 		ahd_unpause(ahd);
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -53,11 +53,6 @@
 #include "aiclib.c"
 
 #include <linux/init.h>		/* __setup */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include "sd.h"			/* For geometry detection */
-#endif
-
 #include <linux/mm.h>		/* For fetching system memory size */
 #include <linux/delay.h>	/* For ssleep/msleep */
 
@@ -66,11 +61,6 @@
  */
 spinlock_t ahd_list_spinlock;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-/* For dynamic sglist size calculation. */
-u_int ahd_linux_nseg;
-#endif
-
 /*
  * Bucket size for counting good commands in between bad ones.
  */
@@ -457,7 +447,6 @@ static void ahd_linux_filter_inquiry(str
 static void ahd_linux_dev_timed_unfreeze(u_long arg);
 static void ahd_linux_sem_timeout(u_long arg);
 static void ahd_linux_initialize_scsi_bus(struct ahd_softc *ahd);
-static void ahd_linux_size_nseg(void);
 static void ahd_linux_thread_run_complete_queue(struct ahd_softc *ahd);
 static void ahd_linux_start_dv(struct ahd_softc *ahd);
 static void ahd_linux_dv_timeout(struct scsi_cmnd *cmd);
@@ -516,31 +505,23 @@ static struct ahd_linux_device*	ahd_linu
 						       u_int);
 static void			ahd_linux_free_device(struct ahd_softc*,
 						      struct ahd_linux_device*);
-static void ahd_linux_run_device_queue(struct ahd_softc*,
-				       struct ahd_linux_device*);
+static int ahd_linux_run_command(struct ahd_softc*,
+				 struct ahd_linux_device*,
+				 struct scsi_cmnd *);
 static void ahd_linux_setup_tag_info_global(char *p);
 static aic_option_callback_t ahd_linux_setup_tag_info;
 static aic_option_callback_t ahd_linux_setup_rd_strm_info;
 static aic_option_callback_t ahd_linux_setup_dv;
 static aic_option_callback_t ahd_linux_setup_iocell_info;
 static int ahd_linux_next_unit(void);
-static void ahd_runq_tasklet(unsigned long data);
 static int aic79xx_setup(char *c);
 
 /****************************** Inlines ***************************************/
 static __inline void ahd_schedule_completeq(struct ahd_softc *ahd);
-static __inline void ahd_schedule_runq(struct ahd_softc *ahd);
-static __inline void ahd_setup_runq_tasklet(struct ahd_softc *ahd);
-static __inline void ahd_teardown_runq_tasklet(struct ahd_softc *ahd);
 static __inline struct ahd_linux_device*
 		     ahd_linux_get_device(struct ahd_softc *ahd, u_int channel,
 					  u_int target, u_int lun, int alloc);
 static struct ahd_cmd *ahd_linux_run_complete_queue(struct ahd_softc *ahd);
-static __inline void ahd_linux_check_device_queue(struct ahd_softc *ahd,
-						  struct ahd_linux_device *dev);
-static __inline struct ahd_linux_device *
-		     ahd_linux_next_device_to_run(struct ahd_softc *ahd);
-static __inline void ahd_linux_run_device_queues(struct ahd_softc *ahd);
 static __inline void ahd_linux_unmap_scb(struct ahd_softc*, struct scb*);
 
 static __inline void
@@ -553,28 +534,6 @@ ahd_schedule_completeq(struct ahd_softc 
 	}
 }
 
-/*
- * Must be called with our lock held.
- */
-static __inline void
-ahd_schedule_runq(struct ahd_softc *ahd)
-{
-	tasklet_schedule(&ahd->platform_data->runq_tasklet);
-}
-
-static __inline
-void ahd_setup_runq_tasklet(struct ahd_softc *ahd)
-{
-	tasklet_init(&ahd->platform_data->runq_tasklet, ahd_runq_tasklet,
-		     (unsigned long)ahd);
-}
-
-static __inline void
-ahd_teardown_runq_tasklet(struct ahd_softc *ahd)
-{
-	tasklet_kill(&ahd->platform_data->runq_tasklet);
-}
-
 static __inline struct ahd_linux_device*
 ahd_linux_get_device(struct ahd_softc *ahd, u_int channel, u_int target,
 		     u_int lun, int alloc)
@@ -641,46 +600,6 @@ ahd_linux_run_complete_queue(struct ahd_
 }
 
 static __inline void
-ahd_linux_check_device_queue(struct ahd_softc *ahd,
-			     struct ahd_linux_device *dev)
-{
-	if ((dev->flags & AHD_DEV_FREEZE_TIL_EMPTY) != 0
-	 && dev->active == 0) {
-		dev->flags &= ~AHD_DEV_FREEZE_TIL_EMPTY;
-		dev->qfrozen--;
-	}
-
-	if (TAILQ_FIRST(&dev->busyq) == NULL
-	 || dev->openings == 0 || dev->qfrozen != 0)
-		return;
-
-	ahd_linux_run_device_queue(ahd, dev);
-}
-
-static __inline struct ahd_linux_device *
-ahd_linux_next_device_to_run(struct ahd_softc *ahd)
-{
-	
-	if ((ahd->flags & AHD_RESOURCE_SHORTAGE) != 0
-	 || (ahd->platform_data->qfrozen != 0
-	  && AHD_DV_SIMQ_FROZEN(ahd) == 0))
-		return (NULL);
-	return (TAILQ_FIRST(&ahd->platform_data->device_runq));
-}
-
-static __inline void
-ahd_linux_run_device_queues(struct ahd_softc *ahd)
-{
-	struct ahd_linux_device *dev;
-
-	while ((dev = ahd_linux_next_device_to_run(ahd)) != NULL) {
-		TAILQ_REMOVE(&ahd->platform_data->device_runq, dev, links);
-		dev->flags &= ~AHD_DEV_ON_RUN_LIST;
-		ahd_linux_check_device_queue(ahd, dev);
-	}
-}
-
-static __inline void
 ahd_linux_unmap_scb(struct ahd_softc *ahd, struct scb *scb)
 {
 	Scsi_Cmnd *cmd;
@@ -709,7 +628,6 @@ ahd_linux_unmap_scb(struct ahd_softc *ah
 static int	   ahd_linux_detect(Scsi_Host_Template *);
 static const char *ahd_linux_info(struct Scsi_Host *);
 static int	   ahd_linux_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 static int	   ahd_linux_slave_alloc(Scsi_Device *);
 static int	   ahd_linux_slave_configure(Scsi_Device *);
 static void	   ahd_linux_slave_destroy(Scsi_Device *);
@@ -717,78 +635,10 @@ static void	   ahd_linux_slave_destroy(S
 static int	   ahd_linux_biosparam(struct scsi_device*,
 				       struct block_device*, sector_t, int[]);
 #endif
-#else
-static int	   ahd_linux_release(struct Scsi_Host *);
-static void	   ahd_linux_select_queue_depth(struct Scsi_Host *host,
-						Scsi_Device *scsi_devs);
-#if defined(__i386__)
-static int	   ahd_linux_biosparam(Disk *, kdev_t, int[]);
-#endif
-#endif
 static int	   ahd_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahd_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahd_linux_abort(Scsi_Cmnd *);
 
-/*
- * Calculate a safe value for AHD_NSEG (as expressed through ahd_linux_nseg).
- *
- * In pre-2.5.X...
- * The midlayer allocates an S/G array dynamically when a command is issued
- * using SCSI malloc.  This array, which is in an OS dependent format that
- * must later be copied to our private S/G list, is sized to house just the
- * number of segments needed for the current transfer.  Since the code that
- * sizes the SCSI malloc pool does not take into consideration fragmentation
- * of the pool, executing transactions numbering just a fraction of our
- * concurrent transaction limit with SG list lengths aproaching AHC_NSEG will
- * quickly depleat the SCSI malloc pool of usable space.  Unfortunately, the
- * mid-layer does not properly handle this scsi malloc failures for the S/G
- * array and the result can be a lockup of the I/O subsystem.  We try to size
- * our S/G list so that it satisfies our drivers allocation requirements in
- * addition to avoiding fragmentation of the SCSI malloc pool.
- */
-static void
-ahd_linux_size_nseg(void)
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
-		if (nseg < AHD_LINUX_MIN_NSEG)
-			continue;
-
-		if (best_size == 0) {
-			best_size = cur_size;
-			ahd_linux_nseg = nseg;
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
-				ahd_linux_nseg = nseg;
-			}
-		}
-	}
-#endif
-}
 
 /*
  * Try to detect an Adaptec 79XX controller.
@@ -800,14 +650,6 @@ ahd_linux_detect(Scsi_Host_Template *tem
 	int     found;
 	int	error = 0;
 
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
@@ -819,10 +661,7 @@ ahd_linux_detect(Scsi_Host_Template *tem
 		printf("ahd_linux_detect: Unable to attach\n");
 		return (0);
 	}
-	/*
-	 * Determine an appropriate size for our Scatter Gatther lists.
-	 */
-	ahd_linux_size_nseg();
+
 #ifdef MODULE
 	/*
 	 * If we've been passed any parameters, process them now.
@@ -855,47 +694,10 @@ ahd_linux_detect(Scsi_Host_Template *tem
 		if (ahd_linux_register_host(ahd, template) == 0)
 			found++;
 	}
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	spin_lock_irq(&io_request_lock);
-#endif
 	aic79xx_detect_complete++;
 	return 0;
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-/*
- * Free the passed in Scsi_Host memory structures prior to unloading the
- * module.
- */
-static int
-ahd_linux_release(struct Scsi_Host * host)
-{
-	struct ahd_softc *ahd;
-	u_long l;
-
-	ahd_list_lock(&l);
-	if (host != NULL) {
-
-		/*
-		 * We should be able to just perform
-		 * the free directly, but check our
-		 * list for extra sanity.
-		 */
-		ahd = ahd_find_softc(*(struct ahd_softc **)host->hostdata);
-		if (ahd != NULL) {
-			u_long s;
-
-			ahd_lock(ahd, &s);
-			ahd_intr_enable(ahd, FALSE);
-			ahd_unlock(ahd, &s);
-			ahd_free(ahd);
-		}
-	}
-	ahd_list_unlock(&l);
-	return (0);
-}
-#endif
-
 /*
  * Return a string describing the driver.
  */
@@ -932,7 +734,6 @@ ahd_linux_queue(Scsi_Cmnd * cmd, void (*
 {
 	struct	 ahd_softc *ahd;
 	struct	 ahd_linux_device *dev;
-	u_long	 flags;
 
 	ahd = *(struct ahd_softc **)cmd->device->host->hostdata;
 
@@ -941,49 +742,25 @@ ahd_linux_queue(Scsi_Cmnd * cmd, void (*
 	 */
 	cmd->scsi_done = scsi_done;
 
-	ahd_midlayer_entrypoint_lock(ahd, &flags);
-
 	/*
 	 * Close the race of a command that was in the process of
 	 * being queued to us just as our simq was frozen.  Let
 	 * DV commands through so long as we are only frozen to
 	 * perform DV.
 	 */
-	if (ahd->platform_data->qfrozen != 0
-	 && AHD_DV_CMD(cmd) == 0) {
+	if (ahd->platform_data->qfrozen != 0)
+		return SCSI_MLQUEUE_HOST_BUSY;
 
-		ahd_cmd_set_transaction_status(cmd, CAM_REQUEUE_REQ);
-		ahd_linux_queue_cmd_complete(ahd, cmd);
-		ahd_schedule_completeq(ahd);
-		ahd_midlayer_entrypoint_unlock(ahd, &flags);
-		return (0);
-	}
 	dev = ahd_linux_get_device(ahd, cmd->device->channel,
 				   cmd->device->id, cmd->device->lun,
 				   /*alloc*/TRUE);
-	if (dev == NULL) {
-		ahd_cmd_set_transaction_status(cmd, CAM_RESRC_UNAVAIL);
-		ahd_linux_queue_cmd_complete(ahd, cmd);
-		ahd_schedule_completeq(ahd);
-		ahd_midlayer_entrypoint_unlock(ahd, &flags);
-		printf("%s: aic79xx_linux_queue - Unable to allocate device!\n",
-		       ahd_name(ahd));
-		return (0);
-	}
-	if (cmd->cmd_len > MAX_CDB_LEN)
-		return (-EINVAL);
+	BUG_ON(dev == NULL);
+
 	cmd->result = CAM_REQ_INPROG << 16;
-	TAILQ_INSERT_TAIL(&dev->busyq, (struct ahd_cmd *)cmd, acmd_links.tqe);
-	if ((dev->flags & AHD_DEV_ON_RUN_LIST) == 0) {
-		TAILQ_INSERT_TAIL(&ahd->platform_data->device_runq, dev, links);
-		dev->flags |= AHD_DEV_ON_RUN_LIST;
-		ahd_linux_run_device_queues(ahd);
-	}
-	ahd_midlayer_entrypoint_unlock(ahd, &flags);
-	return (0);
+
+	return ahd_linux_run_command(ahd, dev, cmd);
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 static int
 ahd_linux_slave_alloc(Scsi_Device *device)
 {
@@ -1049,99 +826,22 @@ ahd_linux_slave_destroy(Scsi_Device *dev
 	if (dev != NULL
 	 && (dev->flags & AHD_DEV_SLAVE_CONFIGURED) != 0) {
 		dev->flags |= AHD_DEV_UNCONFIGURED;
-		if (TAILQ_EMPTY(&dev->busyq)
-		 && dev->active == 0
+		if (dev->active == 0
 		 && (dev->flags & AHD_DEV_TIMER_ACTIVE) == 0)
 			ahd_linux_free_device(ahd, dev);
 	}
 	ahd_midlayer_entrypoint_unlock(ahd, &flags);
 }
-#else
-/*
- * Sets the queue depth for each SCSI device hanging
- * off the input host adapter.
- */
-static void
-ahd_linux_select_queue_depth(struct Scsi_Host * host,
-			     Scsi_Device * scsi_devs)
-{
-	Scsi_Device *device;
-	Scsi_Device *ldev;
-	struct	ahd_softc *ahd;
-	u_long	flags;
-
-	ahd = *((struct ahd_softc **)host->hostdata);
-	ahd_lock(ahd, &flags);
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
-
-		if (device->host == host) {
-			struct	 ahd_linux_device *dev;
-
-			/*
-			 * Since Linux has attached to the device, configure
-			 * it so we don't free and allocate the device
-			 * structure on every command.
-			 */
-			dev = ahd_linux_get_device(ahd, device->channel,
-						   device->id, device->lun,
-						   /*alloc*/TRUE);
-			if (dev != NULL) {
-				dev->flags &= ~AHD_DEV_UNCONFIGURED;
-				dev->scsi_device = device;
-				ahd_linux_device_queue_depth(ahd, dev);
-				device->queue_depth = dev->openings
-						    + dev->active;
-				if ((dev->flags & (AHD_DEV_Q_BASIC
-						| AHD_DEV_Q_TAGGED)) == 0) {
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
-	ahd_unlock(ahd, &flags);
-}
-#endif
 
 #if defined(__i386__)
 /*
  * Return the disk geometry for the given SCSI device.
  */
 static int
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 ahd_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 		    sector_t capacity, int geom[])
 {
 	uint8_t *bh;
-#else
-ahd_linux_biosparam(Disk *disk, kdev_t dev, int geom[])
-{
-	struct	scsi_device *sdev = disk->device;
-	u_long	capacity = disk->capacity;
-	struct	buffer_head *bh;
-#endif
 	int	 heads;
 	int	 sectors;
 	int	 cylinders;
@@ -1151,22 +851,11 @@ ahd_linux_biosparam(Disk *disk, kdev_t d
 
 	ahd = *((struct ahd_softc **)sdev->host->hostdata);
 
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
@@ -1198,7 +887,6 @@ ahd_linux_abort(Scsi_Cmnd *cmd)
 {
 	struct ahd_softc *ahd;
 	struct ahd_cmd *acmd;
-	struct ahd_cmd *list_acmd;
 	struct ahd_linux_device *dev;
 	struct scb *pending_scb;
 	u_long s;
@@ -1265,22 +953,6 @@ ahd_linux_abort(Scsi_Cmnd *cmd)
 		goto no_cmd;
 	}
 
-	TAILQ_FOREACH(list_acmd, &dev->busyq, acmd_links.tqe) {
-		if (list_acmd == acmd)
-			break;
-	}
-
-	if (list_acmd != NULL) {
-		printf("%s:%d:%d:%d: Command found on device queue\n",
-		       ahd_name(ahd), cmd->device->channel, cmd->device->id,
-		       cmd->device->lun);
-		TAILQ_REMOVE(&dev->busyq, list_acmd, acmd_links.tqe);
-		cmd->result = DID_ABORT << 16;
-		ahd_linux_queue_cmd_complete(ahd, cmd);
-		retval = SUCCESS;
-		goto done;
-	}
-
 	/*
 	 * See if we can find a matching cmd in the pending list.
 	 */
@@ -1468,7 +1140,6 @@ done:
 		}
 		spin_lock_irq(&ahd->platform_data->spin_lock);
 	}
-	ahd_schedule_runq(ahd);
 	ahd_linux_run_complete_queue(ahd);
 	ahd_midlayer_entrypoint_unlock(ahd, &s);
 	return (retval);
@@ -1568,7 +1239,6 @@ ahd_linux_dev_reset(Scsi_Cmnd *cmd)
 		retval = FAILED;
 	}
 	spin_lock_irq(&ahd->platform_data->spin_lock);
-	ahd_schedule_runq(ahd);
 	ahd_linux_run_complete_queue(ahd);
 	ahd_midlayer_entrypoint_unlock(ahd, &s);
 	printf("%s: Device reset returning 0x%x\n", ahd_name(ahd), retval);
@@ -1625,35 +1295,6 @@ Scsi_Host_Template aic79xx_driver_templa
 	.slave_destroy		= ahd_linux_slave_destroy,
 };
 
-/**************************** Tasklet Handler *********************************/
-
-/*
- * In 2.4.X and above, this routine is called from a tasklet,
- * so we must re-acquire our lock prior to executing this code.
- * In all prior kernels, ahd_schedule_runq() calls this routine
- * directly and ahd_schedule_runq() is called with our lock held.
- */
-static void
-ahd_runq_tasklet(unsigned long data)
-{
-	struct ahd_softc* ahd;
-	struct ahd_linux_device *dev;
-	u_long flags;
-
-	ahd = (struct ahd_softc *)data;
-	ahd_lock(ahd, &flags);
-	while ((dev = ahd_linux_next_device_to_run(ahd)) != NULL) {
-	
-		TAILQ_REMOVE(&ahd->platform_data->device_runq, dev, links);
-		dev->flags &= ~AHD_DEV_ON_RUN_LIST;
-		ahd_linux_check_device_queue(ahd, dev);
-		/* Yeild to our interrupt handler */
-		ahd_unlock(ahd, &flags);
-		ahd_lock(ahd, &flags);
-	}
-	ahd_unlock(ahd, &flags);
-}
-
 /******************************** Bus DMA *************************************/
 int
 ahd_dma_tag_create(struct ahd_softc *ahd, bus_dma_tag_t parent,
@@ -1997,11 +1638,7 @@ ahd_linux_register_host(struct ahd_softc
 
 	*((struct ahd_softc **)host->hostdata) = ahd;
 	ahd_lock(ahd, &s);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	scsi_assign_lock(host, &ahd->platform_data->spin_lock);
-#elif AHD_SCSI_HAS_HOST_LOCK != 0
-	host->lock = &ahd->platform_data->spin_lock;
-#endif
 	ahd->platform_data->host = host;
 	host->can_queue = AHD_MAX_QUEUE;
 	host->cmd_per_lun = 2;
@@ -2020,9 +1657,7 @@ ahd_linux_register_host(struct ahd_softc
 		ahd_set_name(ahd, new_name);
 	}
 	host->unique_id = ahd->unit;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	scsi_set_pci_device(host, ahd->dev_softc);
-#endif
+	scsi_set_device(host, pci_dev_to_dev(ahd->dev_softc));
 	ahd_linux_setup_user_rd_strm_settings(ahd);
 	ahd_linux_initialize_scsi_bus(ahd);
 	ahd_unlock(ahd, &s);
@@ -2064,10 +1699,8 @@ ahd_linux_register_host(struct ahd_softc
 	ahd_linux_start_dv(ahd);
 	ahd_unlock(ahd, &s);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	scsi_add_host(host, &ahd->dev_softc->dev); /* XXX handle failure */
 	scsi_scan_host(host);
-#endif
 	return (0);
 }
 
@@ -2175,7 +1808,6 @@ ahd_platform_alloc(struct ahd_softc *ahd
 	init_MUTEX_LOCKED(&ahd->platform_data->eh_sem);
 	init_MUTEX_LOCKED(&ahd->platform_data->dv_sem);
 	init_MUTEX_LOCKED(&ahd->platform_data->dv_cmd_sem);
-	ahd_setup_runq_tasklet(ahd);
 	ahd->seltime = (aic79xx_seltime & 0x3) << 4;
 	return (0);
 }
@@ -2190,11 +1822,8 @@ ahd_platform_free(struct ahd_softc *ahd)
 	if (ahd->platform_data != NULL) {
 		del_timer_sync(&ahd->platform_data->completeq_timer);
 		ahd_linux_kill_dv_thread(ahd);
-		ahd_teardown_runq_tasklet(ahd);
 		if (ahd->platform_data->host != NULL) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 			scsi_remove_host(ahd->platform_data->host);
-#endif
 			scsi_host_put(ahd->platform_data->host);
 		}
 
@@ -2233,16 +1862,6 @@ ahd_platform_free(struct ahd_softc *ahd)
 			release_mem_region(ahd->platform_data->mem_busaddr,
 					   0x1000);
 		}
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-    		/*
-		 * In 2.4 we detach from the scsi midlayer before the PCI
-		 * layer invokes our remove callback.  No per-instance
-		 * detach is provided, so we must reach inside the PCI
-		 * subsystem's internals and detach our driver manually.
-		 */
-		if (ahd->dev_softc != NULL)
-			ahd->dev_softc->driver = NULL;
-#endif
 		free(ahd->platform_data, M_DEVBUF);
 	}
 }
@@ -2339,7 +1958,7 @@ ahd_platform_set_tags(struct ahd_softc *
 		dev->maxtags = 0;
 		dev->openings =  1 - dev->active;
 	}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+
 	if (dev->scsi_device != NULL) {
 		switch ((dev->flags & (AHD_DEV_Q_BASIC|AHD_DEV_Q_TAGGED))) {
 		case AHD_DEV_Q_BASIC:
@@ -2365,65 +1984,13 @@ ahd_platform_set_tags(struct ahd_softc *
 			break;
 		}
 	}
-#endif
 }
 
 int
 ahd_platform_abort_scbs(struct ahd_softc *ahd, int target, char channel,
 			int lun, u_int tag, role_t role, uint32_t status)
 {
-	int targ;
-	int maxtarg;
-	int maxlun;
-	int clun;
-	int count;
-
-	if (tag != SCB_LIST_NULL)
-		return (0);
-
-	targ = 0;
-	if (target != CAM_TARGET_WILDCARD) {
-		targ = target;
-		maxtarg = targ + 1;
-	} else {
-		maxtarg = (ahd->features & AHD_WIDE) ? 16 : 8;
-	}
-	clun = 0;
-	if (lun != CAM_LUN_WILDCARD) {
-		clun = lun;
-		maxlun = clun + 1;
-	} else {
-		maxlun = AHD_NUM_LUNS;
-	}
-
-	count = 0;
-	for (; targ < maxtarg; targ++) {
-
-		for (; clun < maxlun; clun++) {
-			struct ahd_linux_device *dev;
-			struct ahd_busyq *busyq;
-			struct ahd_cmd *acmd;
-
-			dev = ahd_linux_get_device(ahd, /*chan*/0, targ,
-						   clun, /*alloc*/FALSE);
-			if (dev == NULL)
-				continue;
-
-			busyq = &dev->busyq;
-			while ((acmd = TAILQ_FIRST(busyq)) != NULL) {
-				Scsi_Cmnd *cmd;
-
-				cmd = &acmd_scsi_cmd(acmd);
-				TAILQ_REMOVE(busyq, acmd,
-					     acmd_links.tqe);
-				count++;
-				cmd->result = status << 16;
-				ahd_linux_queue_cmd_complete(ahd, cmd);
-			}
-		}
-	}
-
-	return (count);
+	return 0;
 }
 
 static void
@@ -2478,18 +2045,10 @@ ahd_linux_dv_thread(void *data)
 	 * Complete thread creation.
 	 */
 	lock_kernel();
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,60)
-	/*
-	 * Don't care about any signals.
-	 */
-	siginitsetinv(&current->blocked, 0);
 
-	daemonize();
-	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
-#else
 	daemonize("ahd_dv_%d", ahd->unit);
 	current->flags |= PF_FREEZE;
-#endif
+
 	unlock_kernel();
 
 	while (1) {
@@ -3685,8 +3244,6 @@ ahd_linux_dv_timeout(struct scsi_cmnd *c
 	ahd->platform_data->reset_timer.function =
 	    (ahd_linux_callback_t *)ahd_release_simq;
 	add_timer(&ahd->platform_data->reset_timer);
-	if (ahd_linux_next_device_to_run(ahd) != NULL)
-		ahd_schedule_runq(ahd);
 	ahd_linux_run_complete_queue(ahd);
 	ahd_unlock(ahd, &flags);
 }
@@ -3903,11 +3460,10 @@ ahd_linux_device_queue_depth(struct ahd_
 	}
 }
 
-static void
-ahd_linux_run_device_queue(struct ahd_softc *ahd, struct ahd_linux_device *dev)
+static int
+ahd_linux_run_command(struct ahd_softc *ahd, struct ahd_linux_device *dev,
+		      struct scsi_cmnd *cmd)
 {
-	struct	 ahd_cmd *acmd;
-	struct	 scsi_cmnd *cmd;
 	struct	 scb *scb;
 	struct	 hardware_scb *hscb;
 	struct	 ahd_initiator_tinfo *tinfo;
@@ -3915,157 +3471,136 @@ ahd_linux_run_device_queue(struct ahd_so
 	u_int	 col_idx;
 	uint16_t mask;
 
-	if ((dev->flags & AHD_DEV_ON_RUN_LIST) != 0)
-		panic("running device on run list");
+	if (ahd->platform_data->qfrozen != 0)
+		return SCSI_MLQUEUE_HOST_BUSY;
 
-	while ((acmd = TAILQ_FIRST(&dev->busyq)) != NULL
-	    && dev->openings > 0 && dev->qfrozen == 0) {
+	/*
+	 * Get an scb to use.
+	 */
+	tinfo = ahd_fetch_transinfo(ahd, 'A', ahd->our_id,
+				    cmd->device->id, &tstate);
+	if (!blk_rq_tagged(cmd->request)
+	 || (dev->flags & (AHD_DEV_Q_TAGGED|AHD_DEV_Q_BASIC)) == 0
+	 || (tinfo->curr.ppr_options & MSG_EXT_PPR_IU_REQ) != 0) {
+		col_idx = AHD_NEVER_COL_IDX;
+	} else {
+		col_idx = AHD_BUILD_COL_IDX(cmd->device->id,
+					    cmd->device->lun);
+	}
+	if ((scb = ahd_get_scb(ahd, col_idx)) == NULL) {
+		ahd->flags |= AHD_RESOURCE_SHORTAGE;
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
-		/*
-		 * Schedule us to run later.  The only reason we are not
-		 * running is because the whole controller Q is frozen.
-		 */
-		if (ahd->platform_data->qfrozen != 0
-		 && AHD_DV_SIMQ_FROZEN(ahd) == 0) {
+	scb->io_ctx = cmd;
+	scb->platform_data->dev = dev;
+	hscb = scb->hscb;
+	cmd->host_scribble = (char *)scb;
 
-			TAILQ_INSERT_TAIL(&ahd->platform_data->device_runq,
-					  dev, links);
-			dev->flags |= AHD_DEV_ON_RUN_LIST;
-			return;
-		}
+	/*
+	 * Fill out basics of the HSCB.
+	 */
+	hscb->control = 0;
+	hscb->scsiid = BUILD_SCSIID(ahd, cmd);
+	hscb->lun = cmd->device->lun;
+	scb->hscb->task_management = 0;
+	mask = SCB_GET_TARGET_MASK(ahd, scb);
 
-		cmd = &acmd_scsi_cmd(acmd);
+	if ((ahd->user_discenable & mask) != 0)
+		hscb->control |= DISCENB;
 
-		/*
-		 * Get an scb to use.
-		 */
-		tinfo = ahd_fetch_transinfo(ahd, 'A', ahd->our_id,
-					    cmd->device->id, &tstate);
-		if ((dev->flags & (AHD_DEV_Q_TAGGED|AHD_DEV_Q_BASIC)) == 0
-		 || (tinfo->curr.ppr_options & MSG_EXT_PPR_IU_REQ) != 0) {
-			col_idx = AHD_NEVER_COL_IDX;
-		} else {
-			col_idx = AHD_BUILD_COL_IDX(cmd->device->id,
-						    cmd->device->lun);
-		}
-		if ((scb = ahd_get_scb(ahd, col_idx)) == NULL) {
-			TAILQ_INSERT_TAIL(&ahd->platform_data->device_runq,
-					 dev, links);
-			dev->flags |= AHD_DEV_ON_RUN_LIST;
-			ahd->flags |= AHD_RESOURCE_SHORTAGE;
-			return;
-		}
-		TAILQ_REMOVE(&dev->busyq, acmd, acmd_links.tqe);
-		scb->io_ctx = cmd;
-		scb->platform_data->dev = dev;
-		hscb = scb->hscb;
-		cmd->host_scribble = (char *)scb;
+ 	if (AHD_DV_CMD(cmd) != 0)
+		scb->flags |= SCB_SILENT;
 
-		/*
-		 * Fill out basics of the HSCB.
-		 */
-		hscb->control = 0;
-		hscb->scsiid = BUILD_SCSIID(ahd, cmd);
-		hscb->lun = cmd->device->lun;
-		scb->hscb->task_management = 0;
-		mask = SCB_GET_TARGET_MASK(ahd, scb);
-
-		if ((ahd->user_discenable & mask) != 0)
-			hscb->control |= DISCENB;
-
-	 	if (AHD_DV_CMD(cmd) != 0)
-			scb->flags |= SCB_SILENT;
-
-		if ((tinfo->curr.ppr_options & MSG_EXT_PPR_IU_REQ) != 0)
-			scb->flags |= SCB_PACKETIZED;
-
-		if ((tstate->auto_negotiate & mask) != 0) {
-			scb->flags |= SCB_AUTO_NEGOTIATE;
-			scb->hscb->control |= MK_MESSAGE;
-		}
-
-		if ((dev->flags & (AHD_DEV_Q_TAGGED|AHD_DEV_Q_BASIC)) != 0) {
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
-			if (dev->commands_since_idle_or_otag == AHD_OTAG_THRESH
-			 && (dev->flags & AHD_DEV_Q_TAGGED) != 0) {
-				hscb->control |= MSG_ORDERED_TASK;
+	if ((tinfo->curr.ppr_options & MSG_EXT_PPR_IU_REQ) != 0)
+		scb->flags |= SCB_PACKETIZED;
+
+	if ((tstate->auto_negotiate & mask) != 0) {
+		scb->flags |= SCB_AUTO_NEGOTIATE;
+		scb->hscb->control |= MK_MESSAGE;
+	}
+
+	if ((dev->flags & (AHD_DEV_Q_TAGGED|AHD_DEV_Q_BASIC)) != 0) {
+		int	msg_bytes;
+		uint8_t tag_msgs[2];
+
+		msg_bytes = scsi_populate_tag_msg(cmd, tag_msgs);
+		if (msg_bytes && tag_msgs[0] != MSG_SIMPLE_TASK) {
+			hscb->control |= tag_msgs[0];
+			if (tag_msgs[0] == MSG_ORDERED_TASK)
 				dev->commands_since_idle_or_otag = 0;
-			} else {
-				hscb->control |= MSG_SIMPLE_TASK;
-			}
+		} else
+		if (dev->commands_since_idle_or_otag == AHD_OTAG_THRESH
+		 && (dev->flags & AHD_DEV_Q_TAGGED) != 0) {
+			hscb->control |= MSG_ORDERED_TASK;
+			dev->commands_since_idle_or_otag = 0;
+		} else {
+			hscb->control |= MSG_SIMPLE_TASK;
 		}
+	}
 
-		hscb->cdb_len = cmd->cmd_len;
-		memcpy(hscb->shared_data.idata.cdb, cmd->cmnd, hscb->cdb_len);
+	hscb->cdb_len = cmd->cmd_len;
+	memcpy(hscb->shared_data.idata.cdb, cmd->cmnd, hscb->cdb_len);
 
-		scb->sg_count = 0;
-		ahd_set_residual(scb, 0);
-		ahd_set_sense_residual(scb, 0);
-		if (cmd->use_sg != 0) {
-			void	*sg;
-			struct	 scatterlist *cur_seg;
-			u_int	 nseg;
-			int	 dir;
-
-			cur_seg = (struct scatterlist *)cmd->request_buffer;
-			dir = cmd->sc_data_direction;
-			nseg = pci_map_sg(ahd->dev_softc, cur_seg,
-					  cmd->use_sg, dir);
-			scb->platform_data->xfer_len = 0;
-			for (sg = scb->sg_list; nseg > 0; nseg--, cur_seg++) {
-				dma_addr_t addr;
-				bus_size_t len;
-
-				addr = sg_dma_address(cur_seg);
-				len = sg_dma_len(cur_seg);
-				scb->platform_data->xfer_len += len;
-				sg = ahd_sg_setup(ahd, scb, sg, addr, len,
-						  /*last*/nseg == 1);
-			}
-		} else if (cmd->request_bufflen != 0) {
-			void *sg;
+	scb->sg_count = 0;
+	ahd_set_residual(scb, 0);
+	ahd_set_sense_residual(scb, 0);
+	if (cmd->use_sg != 0) {
+		void	*sg;
+		struct	 scatterlist *cur_seg;
+		u_int	 nseg;
+		int	 dir;
+
+		cur_seg = (struct scatterlist *)cmd->request_buffer;
+		dir = cmd->sc_data_direction;
+		nseg = pci_map_sg(ahd->dev_softc, cur_seg,
+				  cmd->use_sg, dir);
+		scb->platform_data->xfer_len = 0;
+		for (sg = scb->sg_list; nseg > 0; nseg--, cur_seg++) {
 			dma_addr_t addr;
-			int dir;
+			bus_size_t len;
 
-			sg = scb->sg_list;
-			dir = cmd->sc_data_direction;
-			addr = pci_map_single(ahd->dev_softc,
-					      cmd->request_buffer,
-					      cmd->request_bufflen, dir);
-			scb->platform_data->xfer_len = cmd->request_bufflen;
-			scb->platform_data->buf_busaddr = addr;
-			sg = ahd_sg_setup(ahd, scb, sg, addr,
-					  cmd->request_bufflen, /*last*/TRUE);
-		}
-
-		LIST_INSERT_HEAD(&ahd->pending_scbs, scb, pending_links);
-		dev->openings--;
-		dev->active++;
-		dev->commands_issued++;
-
-		/* Update the error counting bucket and dump if needed */
-		if (dev->target->cmds_since_error) {
-			dev->target->cmds_since_error++;
-			if (dev->target->cmds_since_error >
-			    AHD_LINUX_ERR_THRESH)
-				dev->target->cmds_since_error = 0;
-		}
-
-		if ((dev->flags & AHD_DEV_PERIODIC_OTAG) != 0)
-			dev->commands_since_idle_or_otag++;
-		scb->flags |= SCB_ACTIVE;
-		ahd_queue_scb(ahd, scb);
+			addr = sg_dma_address(cur_seg);
+			len = sg_dma_len(cur_seg);
+			scb->platform_data->xfer_len += len;
+			sg = ahd_sg_setup(ahd, scb, sg, addr, len,
+					  /*last*/nseg == 1);
+		}
+	} else if (cmd->request_bufflen != 0) {
+		void *sg;
+		dma_addr_t addr;
+		int dir;
+
+		sg = scb->sg_list;
+		dir = cmd->sc_data_direction;
+		addr = pci_map_single(ahd->dev_softc,
+				      cmd->request_buffer,
+				      cmd->request_bufflen, dir);
+		scb->platform_data->xfer_len = cmd->request_bufflen;
+		scb->platform_data->buf_busaddr = addr;
+		sg = ahd_sg_setup(ahd, scb, sg, addr,
+				  cmd->request_bufflen, /*last*/TRUE);
 	}
+
+	LIST_INSERT_HEAD(&ahd->pending_scbs, scb, pending_links);
+	dev->openings--;
+	dev->active++;
+	dev->commands_issued++;
+
+	/* Update the error counting bucket and dump if needed */
+	if (dev->target->cmds_since_error) {
+		dev->target->cmds_since_error++;
+		if (dev->target->cmds_since_error >
+		    AHD_LINUX_ERR_THRESH)
+			dev->target->cmds_since_error = 0;
+	}
+
+	if ((dev->flags & AHD_DEV_PERIODIC_OTAG) != 0)
+		dev->commands_since_idle_or_otag++;
+	scb->flags |= SCB_ACTIVE;
+	ahd_queue_scb(ahd, scb);
+
+	return 0;
 }
 
 /*
@@ -4081,8 +3616,6 @@ ahd_linux_isr(int irq, void *dev_id, str
 	ahd = (struct ahd_softc *) dev_id;
 	ahd_lock(ahd, &flags); 
 	ours = ahd_intr(ahd);
-	if (ahd_linux_next_device_to_run(ahd) != NULL)
-		ahd_schedule_runq(ahd);
 	ahd_linux_run_complete_queue(ahd);
 	ahd_unlock(ahd, &flags);
 	return IRQ_RETVAL(ours);
@@ -4161,7 +3694,6 @@ ahd_linux_alloc_device(struct ahd_softc 
 		return (NULL);
 	memset(dev, 0, sizeof(*dev));
 	init_timer(&dev->timer);
-	TAILQ_INIT(&dev->busyq);
 	dev->flags = AHD_DEV_UNCONFIGURED;
 	dev->lun = lun;
 	dev->target = targ;
@@ -4264,28 +3796,9 @@ ahd_send_async(struct ahd_softc *ahd, ch
 	}
         case AC_SENT_BDR:
 	{
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 		WARN_ON(lun != CAM_LUN_WILDCARD);
 		scsi_report_device_reset(ahd->platform_data->host,
 					 channel - 'A', target);
-#else
-		Scsi_Device *scsi_dev;
-
-		/*
-		 * Find the SCSI device associated with this
-		 * request and indicate that a UA is expected.
-		 */
-		for (scsi_dev = ahd->platform_data->host->host_queue;
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
@@ -4406,12 +3919,11 @@ ahd_done(struct ahd_softc *ahd, struct s
 	if (dev->active == 0)
 		dev->commands_since_idle_or_otag = 0;
 
-	if (TAILQ_EMPTY(&dev->busyq)) {
-		if ((dev->flags & AHD_DEV_UNCONFIGURED) != 0
-		 && dev->active == 0
-		 && (dev->flags & AHD_DEV_TIMER_ACTIVE) == 0)
-			ahd_linux_free_device(ahd, dev);
-	} else if ((dev->flags & AHD_DEV_ON_RUN_LIST) == 0) {
+	if ((dev->flags & AHD_DEV_UNCONFIGURED) != 0
+	    && dev->active == 0
+	    && (dev->flags & AHD_DEV_TIMER_ACTIVE) == 0)
+		ahd_linux_free_device(ahd, dev);
+	else if ((dev->flags & AHD_DEV_ON_RUN_LIST) == 0) {
 		TAILQ_INSERT_TAIL(&ahd->platform_data->device_runq, dev, links);
 		dev->flags |= AHD_DEV_ON_RUN_LIST;
 	}
@@ -4887,7 +4399,6 @@ ahd_release_simq(struct ahd_softc *ahd)
 		ahd->platform_data->flags &= ~AHD_DV_WAIT_SIMQ_RELEASE;
 		up(&ahd->platform_data->dv_sem);
 	}
-	ahd_schedule_runq(ahd);
 	ahd_unlock(ahd, &s);
 	/*
 	 * There is still a race here.  The mid-layer
@@ -4929,61 +4440,16 @@ ahd_linux_dev_timed_unfreeze(u_long arg)
 	dev->flags &= ~AHD_DEV_TIMER_ACTIVE;
 	if (dev->qfrozen > 0)
 		dev->qfrozen--;
-	if (dev->qfrozen == 0
-	 && (dev->flags & AHD_DEV_ON_RUN_LIST) == 0)
-		ahd_linux_run_device_queue(ahd, dev);
 	if ((dev->flags & AHD_DEV_UNCONFIGURED) != 0
 	 && dev->active == 0)
 		ahd_linux_free_device(ahd, dev);
 	ahd_unlock(ahd, &s);
 }
 
-void
-ahd_platform_dump_card_state(struct ahd_softc *ahd)
-{
-	struct ahd_linux_device *dev;
-	int target;
-	int maxtarget;
-	int lun;
-	int i;
-
-	maxtarget = (ahd->features & AHD_WIDE) ? 15 : 7;
-	for (target = 0; target <=maxtarget; target++) {
-
-		for (lun = 0; lun < AHD_NUM_LUNS; lun++) {
-			struct ahd_cmd *acmd;
-
-			dev = ahd_linux_get_device(ahd, 0, target,
-						   lun, /*alloc*/FALSE);
-			if (dev == NULL)
-				continue;
-
-			printf("DevQ(%d:%d:%d): ", 0, target, lun);
-			i = 0;
-			TAILQ_FOREACH(acmd, &dev->busyq, acmd_links.tqe) {
-				if (i++ > AHD_SCB_MAX)
-					break;
-			}
-			printf("%d waiting\n", i);
-		}
-	}
-}
-
 static int __init
 ahd_linux_init(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	return ahd_linux_detect(&aic79xx_driver_template);
-#else
-	scsi_register_module(MODULE_SCSI_HA, &aic79xx_driver_template);
-	if (aic79xx_driver_template.present == 0) {
-		scsi_unregister_module(MODULE_SCSI_HA,
-				       &aic79xx_driver_template);
-		return (-ENODEV);
-	}
-
-	return (0);
-#endif
 }
 
 static void __exit
@@ -5002,14 +4468,6 @@ ahd_linux_exit(void)
 		ahd_linux_kill_dv_thread(ahd);
 	}
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	/*
-	 * In 2.4 we have to unregister from the PCI core _after_
-	 * unregistering from the scsi midlayer to avoid dangling
-	 * references.
-	 */
-	scsi_unregister_module(MODULE_SCSI_HA, &aic79xx_driver_template);
-#endif
 	ahd_linux_pci_exit();
 }
 
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.h b/drivers/scsi/aic7xxx/aic79xx_osm.h
--- a/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -269,11 +269,7 @@ ahd_scb_timer_reset(struct scb *scb, u_i
 /***************************** SMP support ************************************/
 #include <linux/spinlock.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0) || defined(SCSI_HAS_HOST_LOCK))
 #define AHD_SCSI_HAS_HOST_LOCK 1
-#else
-#define AHD_SCSI_HAS_HOST_LOCK 0
-#endif
 
 #define AIC79XX_DRIVER_VERSION "1.3.11"
 
@@ -314,7 +310,7 @@ struct ahd_cmd {
  * after a successfully completed inquiry command to the target when
  * that inquiry data indicates a lun is present.
  */
-TAILQ_HEAD(ahd_busyq, ahd_cmd);
+
 typedef enum {
 	AHD_DEV_UNCONFIGURED	 = 0x01,
 	AHD_DEV_FREEZE_TIL_EMPTY = 0x02, /* Freeze queue until active == 0 */
@@ -329,7 +325,6 @@ typedef enum {
 struct ahd_linux_target;
 struct ahd_linux_device {
 	TAILQ_ENTRY(ahd_linux_device) links;
-	struct			ahd_busyq busyq;
 
 	/*
 	 * The number of transactions currently
@@ -470,18 +465,7 @@ struct ahd_linux_target {
  * manner and are allocated below 4GB, the number of S/G segments is
  * unrestricted.
  */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-/*
- * We dynamically adjust the number of segments in pre-2.5 kernels to
- * avoid fragmentation issues in the SCSI mid-layer's private memory
- * allocator.  See aic79xx_osm.c ahd_linux_size_nseg() for details.
- */
-extern u_int ahd_linux_nseg;
-#define	AHD_NSEG ahd_linux_nseg
-#define	AHD_LINUX_MIN_NSEG 64
-#else
 #define	AHD_NSEG 128
-#endif
 
 /*
  * Per-SCB OSM storage.
@@ -523,7 +507,6 @@ struct ahd_platform_data {
 	struct ahd_completeq	 completeq;
 
 	spinlock_t		 spin_lock;
-	struct tasklet_struct	 runq_tasklet;
 	u_int			 qfrozen;
 	pid_t			 dv_pid;
 	struct timer_list	 completeq_timer;
@@ -942,12 +925,8 @@ ahd_flush_device_writes(struct ahd_softc
 }
 
 /**************************** Proc FS Support *********************************/
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-int	ahd_linux_proc_info(char *, char **, off_t, int, int, int);
-#else
 int	ahd_linux_proc_info(struct Scsi_Host *, char *, char **,
 			    off_t, int, int);
-#endif
 
 /*************************** Domain Validation ********************************/
 #define AHD_DV_CMD(cmd) ((cmd)->scsi_done == ahd_linux_dv_complete)
@@ -1134,7 +1113,6 @@ void	ahd_done(struct ahd_softc*, struct 
 void	ahd_send_async(struct ahd_softc *, char channel,
 		       u_int target, u_int lun, ac_code, void *);
 void	ahd_print_path(struct ahd_softc *, struct scb *);
-void	ahd_platform_dump_card_state(struct ahd_softc *ahd);
 
 #ifdef CONFIG_PCI
 #define AHD_PCI_CONFIG 1
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
@@ -195,13 +195,7 @@ ahd_linux_pci_dev_probe(struct pci_dev *
 	}
 	pci_set_drvdata(pdev, ahd);
 	if (aic79xx_detect_complete) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 		ahd_linux_register_host(ahd, &aic79xx_driver_template);
-#else
-		printf("aic79xx: ignoring PCI device found after "
-		       "initialization\n");
-		return (-ENODEV);
-#endif
 	}
 	return (0);
 }
diff --git a/drivers/scsi/aic7xxx/aic79xx_proc.c b/drivers/scsi/aic7xxx/aic79xx_proc.c
--- a/drivers/scsi/aic7xxx/aic79xx_proc.c
+++ b/drivers/scsi/aic7xxx/aic79xx_proc.c
@@ -278,13 +278,8 @@ done:
  * Return information to handle /proc support for the driver.
  */
 int
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-ahd_linux_proc_info(char *buffer, char **start, off_t offset,
-		    int length, int hostno, int inout)
-#else
 ahd_linux_proc_info(struct Scsi_Host *shost, char *buffer, char **start,
 		    off_t offset, int length, int inout)
-#endif
 {
 	struct	ahd_softc *ahd;
 	struct	info_str info;
@@ -296,14 +291,7 @@ ahd_linux_proc_info(struct Scsi_Host *sh
 
 	retval = -EINVAL;
 	ahd_list_lock(&l);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	TAILQ_FOREACH(ahd, &ahd_tailq, links) {
-		if (ahd->platform_data->host->host_no == hostno)
-			break;
-	}
-#else
 	ahd = ahd_find_softc(*(struct ahd_softc **)shost->hostdata);
-#endif
 
 	if (ahd == NULL)
 		goto done;
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -69,12 +69,6 @@
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
-/* move to PCI layer? */
-static inline struct device *pci_dev_to_dev(struct pci_dev *pdev)
-{
-	return &pdev->dev;
-}
-
 enum {
 	/* various global constants */
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -573,6 +573,11 @@ struct pci_dev {
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 
+static inline struct device *pci_dev_to_dev(struct pci_dev *pdev)
+{
+	return &pdev->dev;
+}
+
 /*
  *  For PCI devices, the region numbers are assigned this way:
  *
