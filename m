Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVGJV1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVGJV1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVGJTjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37596 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261741AbVGJTfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:40 -0400
Date: Sun, 10 Jul 2005 19:35:39 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 31/82] remove linux/version.h from drivers/scsi/aic7xxx/
Message-ID: <20050710193539.31.AMZXoK3100.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

remove code for obsolete kernels

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/scsi/aic7xxx/aic79xx_osm.c     |  262 ---------------------------------
drivers/scsi/aic7xxx/aic79xx_osm.h     |   20 --
drivers/scsi/aic7xxx/aic79xx_osm_pci.c |    6
drivers/scsi/aic7xxx/aic79xx_proc.c    |   12 -
drivers/scsi/aic7xxx/aic7xxx_osm.h     |    1
drivers/scsi/aic7xxx/aiclib.c          |    1
drivers/scsi/aic7xxx/aiclib.h          |   10 -
7 files changed, 312 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_osm.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -54,10 +54,6 @@

#include <linux/init.h>		/* __setup */

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include "sd.h"			/* For geometry detection */
-#endif
-
#include <linux/mm.h>		/* For fetching system memory size */
#include <linux/delay.h>	/* For ssleep/msleep */

@@ -66,11 +62,6 @@
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
@@ -709,7 +700,6 @@ ahd_linux_unmap_scb(struct ahd_softc *ah
static int	   ahd_linux_detect(Scsi_Host_Template *);
static const char *ahd_linux_info(struct Scsi_Host *);
static int	   ahd_linux_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
static int	   ahd_linux_slave_alloc(Scsi_Device *);
static int	   ahd_linux_slave_configure(Scsi_Device *);
static void	   ahd_linux_slave_destroy(Scsi_Device *);
@@ -717,14 +707,6 @@ static void	   ahd_linux_slave_destroy(S
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
@@ -749,45 +731,6 @@ static int	   ahd_linux_abort(Scsi_Cmnd
static void
ahd_linux_size_nseg(void)
{
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
}

/*
@@ -800,14 +743,6 @@ ahd_linux_detect(Scsi_Host_Template *tem
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
@@ -855,47 +790,10 @@ ahd_linux_detect(Scsi_Host_Template *tem
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
@@ -983,7 +881,6 @@ ahd_linux_queue(Scsi_Cmnd * cmd, void (*
return (0);
}

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
static int
ahd_linux_slave_alloc(Scsi_Device *device)
{
@@ -1056,92 +953,16 @@ ahd_linux_slave_destroy(Scsi_Device *dev
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
@@ -1151,22 +972,12 @@ ahd_linux_biosparam(Disk *disk, kdev_t d

ahd = *((struct ahd_softc **)sdev->host->hostdata);

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
bh = scsi_bios_ptable(bdev);
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,17)
-	bh = bread(MKDEV(MAJOR(dev), MINOR(dev) & ~0xf), 0, block_size(dev));
-#else
-	bh = bread(MKDEV(MAJOR(dev), MINOR(dev) & ~0xf), 0, 1024);
-#endif

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
@@ -1997,11 +1808,7 @@ ahd_linux_register_host(struct ahd_softc

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
@@ -2020,9 +1827,6 @@ ahd_linux_register_host(struct ahd_softc
ahd_set_name(ahd, new_name);
}
host->unique_id = ahd->unit;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	scsi_set_pci_device(host, ahd->dev_softc);
-#endif
ahd_linux_setup_user_rd_strm_settings(ahd);
ahd_linux_initialize_scsi_bus(ahd);
ahd_unlock(ahd, &s);
@@ -2064,10 +1868,8 @@ ahd_linux_register_host(struct ahd_softc
ahd_linux_start_dv(ahd);
ahd_unlock(ahd, &s);

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
scsi_add_host(host, &ahd->dev_softc->dev); /* XXX handle failure */
scsi_scan_host(host);
-#endif
return (0);
}

@@ -2192,9 +1994,7 @@ ahd_platform_free(struct ahd_softc *ahd)
ahd_linux_kill_dv_thread(ahd);
ahd_teardown_runq_tasklet(ahd);
if (ahd->platform_data->host != NULL) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
scsi_remove_host(ahd->platform_data->host);
-#endif
scsi_host_put(ahd->platform_data->host);
}

@@ -2233,16 +2033,6 @@ ahd_platform_free(struct ahd_softc *ahd)
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
@@ -2339,7 +2129,6 @@ ahd_platform_set_tags(struct ahd_softc *
dev->maxtags = 0;
dev->openings =  1 - dev->active;
}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
if (dev->scsi_device != NULL) {
switch ((dev->flags & (AHD_DEV_Q_BASIC|AHD_DEV_Q_TAGGED))) {
case AHD_DEV_Q_BASIC:
@@ -2365,7 +2154,6 @@ ahd_platform_set_tags(struct ahd_softc *
break;
}
}
-#endif
}

int
@@ -2478,18 +2266,8 @@ ahd_linux_dv_thread(void *data)
* Complete thread creation.
*/
lock_kernel();
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,60)
-	/*
-	 * Don't care about any signals.
-	 */
-	siginitsetinv(&current->blocked, 0);
-
-	daemonize();
-	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
-#else
daemonize("ahd_dv_%d", ahd->unit);
current->flags |= PF_NOFREEZE;
-#endif
unlock_kernel();

while (1) {
@@ -3985,7 +3763,6 @@ ahd_linux_run_device_queue(struct ahd_so
}

if ((dev->flags & (AHD_DEV_Q_TAGGED|AHD_DEV_Q_BASIC)) != 0) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
int	msg_bytes;
uint8_t tag_msgs[2];

@@ -3995,7 +3772,6 @@ ahd_linux_run_device_queue(struct ahd_so
if (tag_msgs[0] == MSG_ORDERED_TASK)
dev->commands_since_idle_or_otag = 0;
} else
-#endif
if (dev->commands_since_idle_or_otag == AHD_OTAG_THRESH
&& (dev->flags & AHD_DEV_Q_TAGGED) != 0) {
hscb->control |= MSG_ORDERED_TASK;
@@ -4264,28 +4040,9 @@ ahd_send_async(struct ahd_softc *ahd, ch
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
@@ -4972,18 +4729,7 @@ ahd_platform_dump_card_state(struct ahd_
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
@@ -5002,14 +4748,6 @@ ahd_linux_exit(void)
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

Index: linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_osm.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -48,7 +48,6 @@
#include <linux/ioport.h>
#include <linux/pci.h>
#include <linux/smp_lock.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <asm/byteorder.h>
#include <asm/io.h>
@@ -252,11 +251,7 @@ ahd_scb_timer_reset(struct scb *scb, u_i
/***************************** SMP support ************************************/
#include <linux/spinlock.h>

-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0) || defined(SCSI_HAS_HOST_LOCK))
#define AHD_SCSI_HAS_HOST_LOCK 1
-#else
-#define AHD_SCSI_HAS_HOST_LOCK 0
-#endif

#define AIC79XX_DRIVER_VERSION "1.3.11"

@@ -453,18 +448,7 @@ struct ahd_linux_target {
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
@@ -925,12 +909,8 @@ ahd_flush_device_writes(struct ahd_softc
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
Index: linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
@@ -195,13 +195,7 @@ ahd_linux_pci_dev_probe(struct pci_dev *
}
pci_set_drvdata(pdev, ahd);
if (aic79xx_detect_complete) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
ahd_linux_register_host(ahd, &aic79xx_driver_template);
-#else
-		printf("aic79xx: ignoring PCI device found after "
-		       "initializationn");
-		return (-ENODEV);
-#endif
}
return (0);
}
Index: linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_proc.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/aic7xxx/aic79xx_proc.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_proc.c
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
Index: linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic7xxx_osm.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -66,7 +66,6 @@
#include <linux/ioport.h>
#include <linux/pci.h>
#include <linux/smp_lock.h>
-#include <linux/version.h>
#include <linux/interrupt.h>
#include <linux/module.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aiclib.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/aic7xxx/aiclib.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aiclib.c
@@ -32,7 +32,6 @@

#include <linux/blkdev.h>
#include <linux/delay.h>
-#include <linux/version.h>

/* Core SCSI definitions */
#include <scsi/scsi_host.h>
Index: linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aiclib.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/aic7xxx/aiclib.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/aic7xxx/aiclib.h
@@ -866,15 +866,6 @@ typedef enum {
extern const char *scsi_sense_key_text[];

/************************* Large Disk Handling ********************************/
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static __inline int aic_sector_div(u_long capacity, int heads, int sectors);
-
-static __inline int
-aic_sector_div(u_long capacity, int heads, int sectors)
-{
-	return (capacity / (heads * sectors));
-}
-#else
static __inline int aic_sector_div(sector_t capacity, int heads, int sectors);

static __inline int
@@ -884,7 +875,6 @@ aic_sector_div(sector_t capacity, int he
sector_div(capacity, (heads * sectors));
return (int)capacity;
}
-#endif

/**************************** Module Library Hack *****************************/
/*
