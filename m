Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTDNRya (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTDNRya (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:54:30 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:62407 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id S263597AbTDNRpd (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:33 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (8/16): dasd driver coding style - part 1.
Date: Mon, 14 Apr 2003 19:50:46 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141950.46676.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 dasd driver:
 - Coding style adaptions. Removed almost all typedefs from the dasd driver.

diffstat:
 dasd.c          |  314 +++++++++++++++++++++++++-------------------------------
 dasd_3370_erp.c |    7 -
 dasd_3990_erp.c |  258 ++++++++++++++++++++++------------------------
 dasd_9336_erp.c |    7 -
 dasd_9343_erp.c |    7 -
 dasd_devmap.c   |   73 +++++--------
 dasd_diag.c     |  135 +++++++++++-------------
 dasd_diag.h     |   29 +----
 8 files changed, 385 insertions(+), 445 deletions(-)

diff -urN linux-2.5.67/drivers/s390/block/dasd.c linux-2.5.67-s390/drivers/s390/block/dasd.c
--- linux-2.5.67/drivers/s390/block/dasd.c	Mon Apr 14 19:11:53 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd.c	Mon Apr 14 19:11:53 2003
@@ -7,43 +7,12 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.82 $
- *
- * History of changes (starts July 2000)
- * 11/09/00 complete redesign after code review
- * 02/01/01 added dynamic registration of ioctls
- *	    fixed bug in registration of new majors
- *	    fixed handling of request during dasd_end_request
- *	    fixed handling of plugged queues
- *	    fixed partition handling and HDIO_GETGEO
- *	    fixed traditional naming scheme for devices beyond 702
- *	    fixed some race conditions related to modules
- *	    added devfs suupport
- * 03/06/01 refined dynamic attach/detach for leaving devices which are online.
- * 03/09/01 refined dynamic modifiaction of devices
- * 03/12/01 moved policy in dasd_format to dasdfmt (renamed BIODASDFORMAT)
- * 03/19/01 added BIODASDINFO-ioctl
- *	    removed 2.2 compatibility
- * 04/27/01 fixed PL030119COT (dasd_disciplines does not work)
- * 04/30/01 fixed PL030146HSM (module locking with dynamic ioctls)
- *	    fixed PL030130SBA (handling of invalid ranges)
- * 05/02/01 fixed PL030145SBA (killing dasdmt)
- *	    fixed PL030149SBA (status of 'accepted' devices)
- *	    fixed PL030146SBA (BUG in ibm.c after adding device)
- *	    added BIODASDPRRD ioctl interface
- * 05/11/01 fixed  PL030164MVE (trap in probeonly mode)
- * 05/15/01 fixed devfs support for unformatted devices
- * 06/26/01 hopefully fixed PL030172SBA,PL030234SBA
- * 07/09/01 fixed PL030324MSH (wrong statistics output)
- * 07/16/01 merged in new fixes for handling low-mem situations
- * 01/22/01 fixed PL030579KBE (wrong statistics)
- * 05/04/02 code restructuring.
+ * $Revision: 1.94 $
  */
 
 #define LOCAL_END_REQUEST /* Don't generate end_request in blk.h */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -83,12 +52,12 @@
 /*
  * SECTION: prototypes for static functions of dasd.c
  */
-static int  dasd_setup_blkdev(dasd_device_t * device);
-static void dasd_disable_blkdev(dasd_device_t * device);
-static void dasd_flush_request_queue(dasd_device_t *);
+static int  dasd_setup_blkdev(struct dasd_device * device);
+static void dasd_disable_blkdev(struct dasd_device * device);
+static void dasd_flush_request_queue(struct dasd_device *);
 static void dasd_int_handler(struct ccw_device *, unsigned long, struct irb *);
-static void dasd_flush_ccw_queue(dasd_device_t *, int);
-static void dasd_tasklet(dasd_device_t *);
+static void dasd_flush_ccw_queue(struct dasd_device *, int);
+static void dasd_tasklet(struct dasd_device *);
 static void do_kick_device(void *data);
 static int  dasd_add_sysfs_files(struct ccw_device *cdev);
 
@@ -100,16 +69,16 @@
 /*
  * Allocate memory for a new device structure.
  */
-dasd_device_t *
+struct dasd_device *
 dasd_alloc_device(unsigned int devindex)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	struct gendisk *gdp;
 
-	device = kmalloc(sizeof (dasd_device_t), GFP_ATOMIC);
+	device = kmalloc(sizeof (struct dasd_device), GFP_ATOMIC);
 	if (device == NULL)
 		return ERR_PTR(-ENOMEM);
-	memset(device, 0, sizeof (dasd_device_t));
+	memset(device, 0, sizeof (struct dasd_device));
 
 	/* Get two pages for normal block device operations. */
 	device->ccw_mem = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
@@ -131,7 +100,7 @@
 		free_page((unsigned long) device->erp_mem);
 		free_pages((unsigned long) device->ccw_mem, 1);
 		kfree(device);
-		return (dasd_device_t *) gdp;
+		return (struct dasd_device *) gdp;
 	}
 	gdp->private_data = device;
 	device->gdp = gdp;
@@ -156,7 +125,7 @@
  * Free memory of a device structure.
  */
 void
-dasd_free_device(dasd_device_t *device)
+dasd_free_device(struct dasd_device *device)
 {
 	if (device->private)
 		kfree(device->private);
@@ -170,7 +139,7 @@
  * Make a new device known to the system.
  */
 static inline int
-dasd_state_new_to_known(dasd_device_t *device)
+dasd_state_new_to_known(struct dasd_device *device)
 {
 	umode_t devfs_perm;
 	kdev_t kdev;
@@ -211,7 +180,7 @@
  * Let the system forget about a device.
  */
 static inline void
-dasd_state_known_to_new(dasd_device_t * device)
+dasd_state_known_to_new(struct dasd_device * device)
 {
 	/* Remove device entry and devfs directory. */
 	devfs_unregister(device->devfs_entry);
@@ -229,7 +198,7 @@
  * Request the irq line for the device.
  */
 static inline int
-dasd_state_known_to_basic(dasd_device_t * device)
+dasd_state_known_to_basic(struct dasd_device * device)
 {
 	/* register 'device' debug area, used for all DBF_DEV_XXX calls */
 	device->debug_area = debug_register(device->gdp->disk_name, 0, 2,
@@ -246,7 +215,7 @@
  * Release the irq line for the device. Terminate any running i/o.
  */
 static inline void
-dasd_state_basic_to_known(dasd_device_t * device)
+dasd_state_basic_to_known(struct dasd_device * device)
 {
 	dasd_flush_ccw_queue(device, 1);
 	DBF_DEV_EVENT(DBF_EMERG, device, "%p debug area deleted", device);
@@ -268,7 +237,7 @@
  * discipline code, see dasd_eckd.c.
  */
 static inline int
-dasd_state_basic_to_accept(dasd_device_t * device)
+dasd_state_basic_to_accept(struct dasd_device * device)
 {
 	int rc;
 
@@ -284,7 +253,7 @@
  * Forget everything the initial analysis found out.
  */
 static inline void
-dasd_state_accept_to_basic(dasd_device_t * device)
+dasd_state_accept_to_basic(struct dasd_device * device)
 {
 	device->blocks = 0;
 	device->bp_block = 0;
@@ -296,7 +265,7 @@
  * Setup block device.
  */
 static inline int
-dasd_state_accept_to_ready(dasd_device_t * device)
+dasd_state_accept_to_ready(struct dasd_device * device)
 {
 	int rc;
 
@@ -312,7 +281,7 @@
  * Remove device from block device layer. Destroy dirty buffers.
  */
 static inline void
-dasd_state_ready_to_accept(dasd_device_t * device)
+dasd_state_ready_to_accept(struct dasd_device * device)
 {
 	dasd_flush_ccw_queue(device, 0);
 	dasd_destroy_partitions(device);
@@ -327,7 +296,7 @@
  * ccw queue.
  */
 static inline int
-dasd_state_ready_to_online(dasd_device_t * device)
+dasd_state_ready_to_online(struct dasd_device * device)
 {
 	device->state = DASD_STATE_ONLINE;
 	dasd_schedule_bh(device);
@@ -338,7 +307,7 @@
  * Stop the requeueing of requests again.
  */
 static inline void
-dasd_state_online_to_ready(dasd_device_t * device)
+dasd_state_online_to_ready(struct dasd_device * device)
 {
 	device->state = DASD_STATE_READY;
 }
@@ -347,7 +316,7 @@
  * Device startup state changes.
  */
 static inline int
-dasd_increase_state(dasd_device_t *device)
+dasd_increase_state(struct dasd_device *device)
 {
 	int rc;
 
@@ -379,7 +348,7 @@
  * Device shutdown state changes.
  */
 static inline int
-dasd_decrease_state(dasd_device_t *device)
+dasd_decrease_state(struct dasd_device *device)
 {
 	if (device->state == DASD_STATE_ONLINE &&
 	    device->target <= DASD_STATE_READY)
@@ -408,7 +377,7 @@
  * This is the main startup/shutdown routine.
  */
 static void
-dasd_change_state(dasd_device_t *device)
+dasd_change_state(struct dasd_device *device)
 {
         int rc;
 
@@ -440,16 +409,16 @@
 static void
 do_kick_device(void *data)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
-	device = (dasd_device_t *) data;
+	device = (struct dasd_device *) data;
 	dasd_change_state(device);
 	dasd_schedule_bh(device);
 	dasd_put_device(device);
 }
 
 void
-dasd_kick_device(dasd_device_t *device)
+dasd_kick_device(struct dasd_device *device)
 {
 	dasd_get_device(device);
 	/* queue call to dasd_kick_device to the kernel event daemon. */
@@ -460,7 +429,7 @@
  * Set the target state for a device and starts the state change.
  */
 void
-dasd_set_target_state(dasd_device_t *device, int target)
+dasd_set_target_state(struct dasd_device *device, int target)
 {
 	/* If we are in probeonly mode stop at DASD_STATE_ACCEPT. */
 	if (dasd_probeonly && target > DASD_STATE_ACCEPT)
@@ -478,14 +447,14 @@
  * Enable devices with device numbers in [from..to].
  */
 static inline int
-_wait_for_device(dasd_device_t *device)
+_wait_for_device(struct dasd_device *device)
 {
 	return (device->state == device->target);
 }
 
 // FIXME: if called from dasd_devices_write discpline is not set -> oops.
 void
-dasd_enable_device(dasd_device_t *device)
+dasd_enable_device(struct dasd_device *device)
 {
 	dasd_set_target_state(device, DASD_STATE_ONLINE);
 	if (device->state <= DASD_STATE_KNOWN)
@@ -500,7 +469,7 @@
  */
 #ifdef CONFIG_DASD_PROFILE
 
-dasd_profile_info_t dasd_global_profile;
+struct dasd_profile_info_t dasd_global_profile;
 unsigned int dasd_profile_level = DASD_PROFILE_OFF;
 
 /*
@@ -518,7 +487,7 @@
  * Add profiling information for cqr before execution.
  */
 static inline void
-dasd_profile_start(dasd_device_t *device, dasd_ccw_req_t * cqr,
+dasd_profile_start(struct dasd_device *device, struct dasd_ccw_req * cqr,
 		   struct request *req)
 {
 	struct list_head *l;
@@ -540,7 +509,7 @@
  * Add profiling information for cqr after execution.
  */
 static inline void
-dasd_profile_end(dasd_device_t *device, dasd_ccw_req_t * cqr,
+dasd_profile_end(struct dasd_device *device, struct dasd_ccw_req * cqr,
 		 struct request *req)
 {
 	long strtime, irqtime, endtime, tottime;	/* in microseconds */
@@ -562,12 +531,14 @@
 	tottimeps = tottime / sectors;
 
 	if (!dasd_global_profile.dasd_io_reqs)
-		memset(&dasd_global_profile, 0, sizeof (dasd_profile_info_t));
+		memset(&dasd_global_profile, 0,
+		       sizeof (struct dasd_profile_info_t));
 	dasd_global_profile.dasd_io_reqs++;
 	dasd_global_profile.dasd_io_sects += sectors;
 
 	if (!device->profile.dasd_io_reqs)
-		memset(&device->profile, 0, sizeof (dasd_profile_info_t));
+		memset(&device->profile, 0,
+		       sizeof (struct dasd_profile_info_t));
 	device->profile.dasd_io_reqs++;
 	device->profile.dasd_io_sects += sectors;
 
@@ -591,11 +562,11 @@
  * memory and 2) dasd_smalloc_request uses the static ccw memory
  * that gets allocated for each device.
  */
-dasd_ccw_req_t *
+struct dasd_ccw_req *
 dasd_kmalloc_request(char *magic, int cplength, int datasize,
-		   dasd_device_t * device)
+		   struct dasd_device * device)
 {
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 
 	/* Sanity checks */
 	if ( magic == NULL || datasize > PAGE_SIZE ||
@@ -606,10 +577,10 @@
 	debug_int_event ( dasd_debug_area, 1, cplength);
 	debug_int_event ( dasd_debug_area, 1, datasize);
 
-	cqr = kmalloc(sizeof(dasd_ccw_req_t), GFP_ATOMIC);
+	cqr = kmalloc(sizeof(struct dasd_ccw_req), GFP_ATOMIC);
 	if (cqr == NULL)
 		return ERR_PTR(-ENOMEM);
-	memset(cqr, 0, sizeof(dasd_ccw_req_t));
+	memset(cqr, 0, sizeof(struct dasd_ccw_req));
 	cqr->cpaddr = NULL;
 	if (cplength > 0) {
 		cqr->cpaddr = kmalloc(cplength*sizeof(struct ccw1),
@@ -637,12 +608,12 @@
 	return cqr;
 }
 
-dasd_ccw_req_t *
+struct dasd_ccw_req *
 dasd_smalloc_request(char *magic, int cplength, int datasize,
-		   dasd_device_t * device)
+		   struct dasd_device * device)
 {
 	unsigned long flags;
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 	char *data;
 	int size;
 
@@ -655,18 +626,19 @@
 	debug_int_event ( dasd_debug_area, 1, cplength);
 	debug_int_event ( dasd_debug_area, 1, datasize);
 
-	size = (sizeof(dasd_ccw_req_t) + 7L) & -8L;
+	size = (sizeof(struct dasd_ccw_req) + 7L) & -8L;
 	if (cplength > 0)
 		size += cplength * sizeof(struct ccw1);
 	if (datasize > 0)
 		size += datasize;
 	spin_lock_irqsave(&device->mem_lock, flags);
-	cqr = (dasd_ccw_req_t *) dasd_alloc_chunk(&device->ccw_chunks, size);
+	cqr = (struct dasd_ccw_req *)
+		dasd_alloc_chunk(&device->ccw_chunks, size);
 	spin_unlock_irqrestore(&device->mem_lock, flags);
 	if (cqr == NULL)
 		return ERR_PTR(-ENOMEM);
-	memset(cqr, 0, sizeof(dasd_ccw_req_t));
-	data = (char *) cqr + ((sizeof(dasd_ccw_req_t) + 7L) & -8L);
+	memset(cqr, 0, sizeof(struct dasd_ccw_req));
+	data = (char *) cqr + ((sizeof(struct dasd_ccw_req) + 7L) & -8L);
 	cqr->cpaddr = NULL;
 	if (cplength > 0) {
 		cqr->cpaddr = (struct ccw1 *) data;
@@ -687,10 +659,10 @@
 /*
  * Free memory of a channel program. This function needs to free all the
  * idal lists that might have been created by dasd_set_cda and the
- * dasd_ccw_req_t itself.
+ * struct dasd_ccw_req itself.
  */
 void
-dasd_kfree_request(dasd_ccw_req_t * cqr, dasd_device_t * device)
+dasd_kfree_request(struct dasd_ccw_req * cqr, struct dasd_device * device)
 {
 #ifdef CONFIG_ARCH_S390X
 	struct ccw1 *ccw;
@@ -714,7 +686,7 @@
 }
 
 void
-dasd_sfree_request(dasd_ccw_req_t * cqr, dasd_device_t * device)
+dasd_sfree_request(struct dasd_ccw_req * cqr, struct dasd_device * device)
 {
 	unsigned long flags;
 
@@ -732,16 +704,16 @@
  * Check discipline magic in cqr.
  */
 static inline int
-dasd_check_cqr(dasd_ccw_req_t *cqr)
+dasd_check_cqr(struct dasd_ccw_req *cqr)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	if (cqr == NULL)
 		return -EINVAL;
 	device = cqr->device;
 	if (strncmp((char *) &cqr->magic, device->discipline->ebcname, 4)) {
 		DEV_MESSAGE(KERN_WARNING, device,
-			    " dasd_ccw_req_t 0x%08x magic doesn't match"
+			    " dasd_ccw_req 0x%08x magic doesn't match"
 			    " discipline 0x%08x",
 			    cqr->magic,
 			    *(unsigned int *) device->discipline->name);
@@ -756,9 +728,9 @@
  * is in a bad mood.
  */
 int
-dasd_term_IO(dasd_ccw_req_t * cqr)
+dasd_term_IO(struct dasd_ccw_req * cqr)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int retries, rc;
 
 	/* Check the cqr */
@@ -766,7 +738,7 @@
 	if (rc)
 		return rc;
 	retries = 0;
-	device = (dasd_device_t *) cqr->device;
+	device = (struct dasd_device *) cqr->device;
 	while ((retries < 5) && (cqr->status == DASD_CQR_IN_IO)) {
 		if (retries < 2)
 			rc = ccw_device_halt(device->cdev, (long) cqr);
@@ -808,16 +780,16 @@
  * In that case set up a timer to start the request later.
  */
 int
-dasd_start_IO(dasd_ccw_req_t * cqr)
+dasd_start_IO(struct dasd_ccw_req * cqr)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int rc;
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
 	if (rc)
 		return rc;
-	device = (dasd_device_t *) cqr->device;
+	device = (struct dasd_device *) cqr->device;
 	cqr->startclk = get_clock();
 	rc = ccw_device_start(device->cdev, cqr->cpaddr, (long) cqr,
 			      cqr->lpm, 0);
@@ -860,14 +832,15 @@
 dasd_timeout_device(unsigned long ptr)
 {
 	unsigned long flags;
-	dasd_device_t *device;
-	dasd_ccw_req_t *cqr;
+	struct dasd_device *device;
+	struct dasd_ccw_req *cqr;
 
-	device = (dasd_device_t *) ptr;
+	device = (struct dasd_device *) ptr;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	/* re-activate first request in queue */
 	if (!list_empty(&device->ccw_queue)) {
-		cqr = list_entry(device->ccw_queue.next, dasd_ccw_req_t, list);
+		cqr = list_entry(device->ccw_queue.next,
+				 struct dasd_ccw_req, list);
 		if (cqr->status == DASD_CQR_PENDING)
 			cqr->status = DASD_CQR_QUEUED;
 	}
@@ -879,7 +852,7 @@
  * Setup timeout for a device.
  */
 void
-dasd_set_timer(dasd_device_t *device, int expires)
+dasd_set_timer(struct dasd_device *device, int expires)
 {
 	/* FIXME: timeouts are based on jiffies but the timeout
 	 * comparision in __dasd_check_expire is based on the
@@ -903,7 +876,7 @@
  * Clear timeout for a device.
  */
 void
-dasd_clear_timer(dasd_device_t *device)
+dasd_clear_timer(struct dasd_device *device)
 {
 	if (timer_pending(&device->timer))
 		del_timer(&device->timer);
@@ -921,10 +894,10 @@
 {
 	struct {
 		struct work_struct work;
-		dasd_device_t *device;
+		struct dasd_device *device;
 	} *p;
-	dasd_device_t *device;
-	dasd_ccw_req_t *cqr;
+	struct dasd_device *device;
+	struct dasd_ccw_req *cqr;
 
 	p = data;
 	device = p->device;
@@ -934,7 +907,8 @@
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	/* re-activate first request in queue */
 	if (!list_empty(&device->ccw_queue)) {
-		cqr = list_entry(device->ccw_queue.next, dasd_ccw_req_t, list);
+		cqr = list_entry(device->ccw_queue.next,
+				 struct dasd_ccw_req, list);
 		if (cqr == NULL) {
 			MESSAGE (KERN_DEBUG,
 				 "got state change pending interrupt on"
@@ -954,10 +928,10 @@
 static void
 dasd_handle_killed_request(struct ccw_device *cdev, unsigned long intparm)
 {
-	dasd_ccw_req_t *cqr;
-	dasd_device_t *device;
+	struct dasd_ccw_req *cqr;
+	struct dasd_device *device;
 
-	cqr = (dasd_ccw_req_t *) intparm;
+	cqr = (struct dasd_ccw_req *) intparm;
 	if (cqr->status != DASD_CQR_IN_IO) {
 		MESSAGE(KERN_DEBUG,
 			"invalid status: bus_id %s, status %02x",
@@ -965,7 +939,7 @@
 		return;
 	}
 
-	device = (dasd_device_t *) cqr->device;
+	device = (struct dasd_device *) cqr->device;
 	if (device == NULL ||
 	    device != cdev->dev.driver_data ||
 	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
@@ -982,11 +956,11 @@
 }
 
 static void
-dasd_handle_state_change_pending(dasd_device_t *device)
+dasd_handle_state_change_pending(struct dasd_device *device)
 {
 	struct {
 		struct work_struct work;
-		dasd_device_t *device;
+		struct dasd_device *device;
 	} *p;
 
 	p = kmalloc(sizeof(*p), GFP_ATOMIC);
@@ -1006,8 +980,8 @@
 dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		 struct irb *irb)
 {
-	dasd_ccw_req_t *cqr, *next;
-	dasd_device_t *device;
+	struct dasd_ccw_req *cqr, *next;
+	struct dasd_device *device;
 	unsigned long long now;
 	int expires;
 	dasd_era_t era;
@@ -1042,7 +1016,7 @@
 		return;
 	}
 
-	cqr = (dasd_ccw_req_t *) intparm;
+	cqr = (struct dasd_ccw_req *) intparm;
 	/*
 	 * check status - the request might have been killed
 	 * because of dyn detach
@@ -1054,7 +1028,7 @@
 		return;
 	}
 
-	device = (dasd_device_t *) cqr->device;
+	device = (struct dasd_device *) cqr->device;
 	if (device == NULL ||
 	    device != cdev->dev.driver_data ||
 	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
@@ -1084,7 +1058,7 @@
 		/* Start first request on queue if possible -> fast_io. */
 		if (cqr->list.next != &device->ccw_queue) {
 			next = list_entry(cqr->list.next,
-					  dasd_ccw_req_t, list);
+					  struct dasd_ccw_req, list);
 			if (next->status == DASD_CQR_QUEUED) {
 				if (device->discipline->start_IO(next) == 0)
 					expires = next->expires;
@@ -1141,7 +1115,7 @@
  * Process finished error recovery ccw.
  */
 static inline void
-__dasd_process_erp(dasd_device_t *device, dasd_ccw_req_t *cqr)
+__dasd_process_erp(struct dasd_device *device, struct dasd_ccw_req *cqr)
 {
 	dasd_erp_fn_t erp_fn;
 
@@ -1157,16 +1131,17 @@
  * Process ccw request queue.
  */
 static inline void
-__dasd_process_ccw_queue(dasd_device_t * device, struct list_head *final_queue)
+__dasd_process_ccw_queue(struct dasd_device * device,
+			 struct list_head *final_queue)
 {
 	struct list_head *l, *n;
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 	dasd_erp_fn_t erp_fn;
 
 restart:
 	/* Process request with final status. */
 	list_for_each_safe(l, n, &device->ccw_queue) {
-		cqr = list_entry(l, dasd_ccw_req_t, list);
+		cqr = list_entry(l, struct dasd_ccw_req, list);
 		/* Stop list processing at the first non-final request. */
 		if (cqr->status != DASD_CQR_DONE &&
 		    cqr->status != DASD_CQR_FAILED &&
@@ -1197,7 +1172,7 @@
 }
 
 static void
-dasd_end_request_cb(dasd_ccw_req_t * cqr, void *data)
+dasd_end_request_cb(struct dasd_ccw_req * cqr, void *data)
 {
 	struct request *req;
 
@@ -1214,11 +1189,11 @@
  * Fetch requests from the block device queue.
  */
 static inline void
-__dasd_process_blk_queue(dasd_device_t * device)
+__dasd_process_blk_queue(struct dasd_device * device)
 {
 	request_queue_t *queue;
 	struct request *req;
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 	int nr_queued;
 
 	queue = device->request_queue;
@@ -1281,14 +1256,14 @@
  * if it reached its expire time. If so, terminate the IO.
  */
 static inline void
-__dasd_check_expire(dasd_device_t * device)
+__dasd_check_expire(struct dasd_device * device)
 {
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 	unsigned long long now;
 
 	if (list_empty(&device->ccw_queue))
 		return;
-	cqr = list_entry(device->ccw_queue.next, dasd_ccw_req_t, list);
+	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
 	if (cqr->status == DASD_CQR_IN_IO && cqr->expires != 0) {
 		now = get_clock();
 		if (cqr->expires * (TOD_SEC / HZ) + cqr->startclk < now) {
@@ -1304,14 +1279,14 @@
  * if it needs to be started.
  */
 static inline void
-__dasd_start_head(dasd_device_t * device)
+__dasd_start_head(struct dasd_device * device)
 {
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (list_empty(&device->ccw_queue))
 		return;
-	cqr = list_entry(device->ccw_queue.next, dasd_ccw_req_t, list);
+	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
 	if (cqr->status == DASD_CQR_QUEUED) {
 		/* try to start the first I/O that can be started */
 		rc = device->discipline->start_IO(cqr);
@@ -1327,16 +1302,16 @@
  * Remove requests from the ccw queue. 
  */
 static void
-dasd_flush_ccw_queue(dasd_device_t * device, int all)
+dasd_flush_ccw_queue(struct dasd_device * device, int all)
 {
 	struct list_head flush_queue;
 	struct list_head *l, *n;
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 
 	INIT_LIST_HEAD(&flush_queue);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	list_for_each_safe(l, n, &device->ccw_queue) {
-		cqr = list_entry(l, dasd_ccw_req_t, list);
+		cqr = list_entry(l, struct dasd_ccw_req, list);
 		/* Flush all request or only block device requests? */
 		if (all == 0 && cqr->callback == dasd_end_request_cb)
 			continue;
@@ -1359,7 +1334,7 @@
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	/* Now call the callback function of flushed requests */
 	list_for_each_safe(l, n, &flush_queue) {
-		cqr = list_entry(l, dasd_ccw_req_t, list);
+		cqr = list_entry(l, struct dasd_ccw_req, list);
 		if (cqr->callback != NULL)
 			(cqr->callback)(cqr, cqr->callback_data);
 	}
@@ -1369,11 +1344,11 @@
  * Acquire the device lock and process queues for the device.
  */
 static void
-dasd_tasklet(dasd_device_t * device)
+dasd_tasklet(struct dasd_device * device)
 {
 	struct list_head final_queue;
 	struct list_head *l, *n;
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 
 	atomic_set (&device->tasklet_scheduled, 0);
 	INIT_LIST_HEAD(&final_queue);
@@ -1385,7 +1360,7 @@
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	/* Now call the callback function of requests with final status */
 	list_for_each_safe(l, n, &final_queue) {
-		cqr = list_entry(l, dasd_ccw_req_t, list);
+		cqr = list_entry(l, struct dasd_ccw_req, list);
 		list_del(&cqr->list);
 		if (cqr->callback != NULL)
 			(cqr->callback)(cqr, cqr->callback_data);
@@ -1405,7 +1380,7 @@
  * Schedules a call to dasd_tasklet over the device tasklet.
  */
 void
-dasd_schedule_bh(dasd_device_t * device)
+dasd_schedule_bh(struct dasd_device * device)
 {
 	/* Protect against rescheduling. */
 	if (atomic_compare_and_swap (0, 1, &device->tasklet_scheduled))
@@ -1419,9 +1394,9 @@
  * possible.
  */
 void
-dasd_add_request_head(dasd_ccw_req_t *req)
+dasd_add_request_head(struct dasd_ccw_req *req)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	unsigned long flags;
 
 	device = req->device;
@@ -1439,9 +1414,9 @@
  * possible.
  */
 void
-dasd_add_request_tail(dasd_ccw_req_t *req)
+dasd_add_request_tail(struct dasd_ccw_req *req)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	unsigned long flags;
 
 	device = req->device;
@@ -1458,15 +1433,15 @@
  * Wakeup callback.
  */
 static void
-dasd_wakeup_cb(dasd_ccw_req_t *cqr, void *data)
+dasd_wakeup_cb(struct dasd_ccw_req *cqr, void *data)
 {
 	wake_up((wait_queue_head_t *) data);
 }
 
 static inline int
-_wait_for_wakeup(dasd_ccw_req_t *cqr)
+_wait_for_wakeup(struct dasd_ccw_req *cqr)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int rc;
 
 	device = cqr->device;
@@ -1480,10 +1455,10 @@
  * Attempts to start a special ccw queue and waits for its completion.
  */
 int
-dasd_sleep_on(dasd_ccw_req_t * cqr)
+dasd_sleep_on(struct dasd_ccw_req * cqr)
 {
 	wait_queue_head_t wait_q;
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int rc;
 	
 	device = cqr->device;
@@ -1512,10 +1487,10 @@
  * for its completion.
  */
 int
-dasd_sleep_on_interruptible(dasd_ccw_req_t * cqr)
+dasd_sleep_on_interruptible(struct dasd_ccw_req * cqr)
 {
 	wait_queue_head_t wait_q;
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int rc, finished;
 
 	device = cqr->device;
@@ -1557,14 +1532,14 @@
  * to the head of the queue. Then the special request is waited on normally.
  */
 static inline int
-_dasd_term_running_cqr(dasd_device_t *device)
+_dasd_term_running_cqr(struct dasd_device *device)
 {
-	dasd_ccw_req_t *cqr;
+	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (list_empty(&device->ccw_queue))
 		return 0;
-	cqr = list_entry(device->ccw_queue.next, dasd_ccw_req_t, list);
+	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
 	rc = device->discipline->term_IO(cqr);
 	if (rc == 0) {
 		/* termination successful */
@@ -1575,10 +1550,10 @@
 }
 
 int
-dasd_sleep_on_immediatly(dasd_ccw_req_t * cqr)
+dasd_sleep_on_immediatly(struct dasd_ccw_req * cqr)
 {
 	wait_queue_head_t wait_q;
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int rc;
 	
 	device = cqr->device;
@@ -1613,9 +1588,9 @@
  * terminated if it is currently in i/o.
  * Returns 1 if the request has been terminated.
  */
-int dasd_cancel_req(dasd_ccw_req_t *cqr)
+int dasd_cancel_req(struct dasd_ccw_req *cqr)
 {
-	dasd_device_t *device = cqr->device;
+	struct dasd_device *device = cqr->device;
 	unsigned long flags;
 	int rc;
 
@@ -1661,9 +1636,9 @@
 static void
 do_dasd_request(request_queue_t * queue)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
-	device = (dasd_device_t *) queue->queuedata;
+	device = (struct dasd_device *) queue->queuedata;
 	spin_lock(get_ccwdev_lock(device->cdev));
 	/* Get new request from the block device request queue */
 	__dasd_process_blk_queue(device);
@@ -1676,7 +1651,7 @@
  * Allocate request queue and initialize gendisk info for device.
  */
 static int
-dasd_setup_blkdev(dasd_device_t * device)
+dasd_setup_blkdev(struct dasd_device * device)
 {
 	int max, rc;
 
@@ -1711,7 +1686,7 @@
  * Deactivate and free request queue.
  */
 static void
-dasd_disable_blkdev(dasd_device_t * device)
+dasd_disable_blkdev(struct dasd_device * device)
 {
 	if (device->request_queue) {
 		blk_cleanup_queue(device->request_queue);
@@ -1724,7 +1699,7 @@
  * Flush request on the request queue.
  */
 static void
-dasd_flush_request_queue(dasd_device_t * device)
+dasd_flush_request_queue(struct dasd_device * device)
 {
 	struct request *req;
 
@@ -1745,7 +1720,7 @@
 static int
 dasd_open(struct inode *inp, struct file *filp)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int rc;
 	
 	if (dasd_probeonly) {
@@ -1776,7 +1751,7 @@
 static int
 dasd_release(struct inode *inp, struct file *filp)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	device = inp->i_bdev->bd_disk->private_data;
 
@@ -1824,7 +1799,8 @@
 /* initial attempt at a probe function. this can be simplified once
  * the other detection code is gone */
 int
-dasd_generic_probe (struct ccw_device *cdev, dasd_discipline_t *discipline)
+dasd_generic_probe (struct ccw_device *cdev,
+		    struct dasd_discipline *discipline)
 {
 	int devno;
 	int ret = 0;
@@ -1857,7 +1833,7 @@
 int
 dasd_generic_remove (struct ccw_device *cdev)
 {
-	struct dasd_device_t *device;
+	struct dasd_device *device;
 
 	device = cdev->dev.driver_data;
 	cdev->dev.driver_data = NULL;
@@ -1871,10 +1847,10 @@
  * or the user has started activation through sysfs */
 int
 dasd_generic_set_online (struct ccw_device *cdev,
-			 dasd_discipline_t *discipline)
+			 struct dasd_discipline *discipline)
 
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 	int rc;
 
 	device = dasd_create_device(cdev);
@@ -1928,7 +1904,7 @@
 int
 dasd_generic_set_offline (struct ccw_device *cdev)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	device = cdev->dev.driver_data;
 	if (atomic_read(&device->open_count) > 0) {
@@ -1984,7 +1960,7 @@
 static ssize_t
 dasd_ro_show(struct device *dev, char *buf)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	device = dev->driver_data;
 	if (!device)
@@ -1996,7 +1972,7 @@
 static ssize_t
 dasd_ro_store(struct device *dev, const char *buf, size_t count)
 {
-	dasd_device_t *device = dev->driver_data;
+	struct dasd_device *device = dev->driver_data;
 
 	if (device)
 		device->ro_flag = (buf[0] == '1') ? 1 : 0;
@@ -2013,7 +1989,7 @@
 static ssize_t 
 dasd_use_diag_show(struct device *dev, char *buf)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	device = dev->driver_data;
 	if (!device)
@@ -2025,7 +2001,7 @@
 static ssize_t
 dasd_use_diag_store(struct device *dev, const char *buf, size_t count)
 {
-	dasd_device_t *device = dev->driver_data;
+	struct dasd_device *device = dev->driver_data;
 
 	if (device)
 		device->use_diag_flag = (buf[0] == '1') ? 1 : 0;
@@ -2043,7 +2019,7 @@
 dasd_devices_show(struct device *dev, char *buf)
 {
 	
-	dasd_device_t *device;
+	struct dasd_device *device;
 	dasd_devmap_t *devmap;
 
 	devmap = NULL;
@@ -2063,7 +2039,7 @@
 static ssize_t
 dasd_discipline_show(struct device *dev, char *buf)
 {
-	dasd_device_t *device;
+	struct dasd_device *device;
 
 	device = dev->driver_data;
 	if (!device || !device->discipline)
diff -urN linux-2.5.67/drivers/s390/block/dasd_3370_erp.c linux-2.5.67-s390/drivers/s390/block/dasd_3370_erp.c
--- linux-2.5.67/drivers/s390/block/dasd_3370_erp.c	Mon Apr  7 19:31:50 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_3370_erp.c	Mon Apr 14 19:11:53 2003
@@ -4,10 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000
  *
- * $Revision: 1.7 $
- *
- * History of changes 
- *
+ * $Revision: 1.9 $
  */
 
 #define PRINTK_HEADER "dasd_erp(3370)"
@@ -32,7 +29,7 @@
  *   dasd_era_recover	for all others.
  */
 dasd_era_t
-dasd_3370_erp_examine(dasd_ccw_req_t * cqr, struct irb * irb)
+dasd_3370_erp_examine(struct dasd_ccw_req * cqr, struct irb * irb)
 {
 	char *sense = irb->ecw;
 
diff -urN linux-2.5.67/drivers/s390/block/dasd_3990_erp.c linux-2.5.67-s390/drivers/s390/block/dasd_3990_erp.c
--- linux-2.5.67/drivers/s390/block/dasd_3990_erp.c	Mon Apr  7 19:32:27 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_3990_erp.c	Mon Apr 14 19:11:53 2003
@@ -5,11 +5,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000, 2001
  *
- * $Revision: 1.20 $
- *
- * History of changes:
- * 05/14/01 fixed PL030160GTO (BUG() in erp_action_5)
- * 05/04/02 code restructuring.
+ * $Revision: 1.24 $
  */
 
 #include <linux/timer.h>
@@ -23,11 +19,11 @@
 #include "dasd_eckd.h"
 
 
-typedef struct DCTL_data_t {
+struct DCTL_data {
 	unsigned char subcommand;	/* e.g Inhibit Write, Enable Write,... */
 	unsigned char modifier;	/* Subcommand modifier		       */
 	unsigned short res;	/* reserved */
-} __attribute__ ((packed)) DCTL_data_t;
+} __attribute__ ((packed));
 
 /*
  ***************************************************************************** 
@@ -54,10 +50,10 @@
  *   dasd_era_recover	for all others.
  */
 static dasd_era_t
-dasd_3990_erp_examine_24(dasd_ccw_req_t * cqr, char *sense)
+dasd_3990_erp_examine_24(struct dasd_ccw_req * cqr, char *sense)
 {
 
-	dasd_device_t *device = cqr->device;
+	struct dasd_device *device = cqr->device;
 
 	/* check for 'Command Reject' */
 	if ((sense[0] & SNS0_CMD_REJECT) &&
@@ -111,10 +107,10 @@
  *   dasd_era_recover	for recoverable others.
  */
 static dasd_era_t
-dasd_3990_erp_examine_32(dasd_ccw_req_t * cqr, char *sense)
+dasd_3990_erp_examine_32(struct dasd_ccw_req * cqr, char *sense)
 {
 
-	dasd_device_t *device = cqr->device;
+	struct dasd_device *device = cqr->device;
 
 	switch (sense[25]) {
 	case 0x00:
@@ -149,12 +145,12 @@
  *   dasd_era_recover	for all others.
  */
 dasd_era_t
-dasd_3990_erp_examine(dasd_ccw_req_t * cqr, struct irb * irb)
+dasd_3990_erp_examine(struct dasd_ccw_req * cqr, struct irb * irb)
 {
 
 	char *sense = irb->ecw;
 	dasd_era_t era = dasd_era_recover;
-	dasd_device_t *device = cqr->device;
+	struct dasd_device *device = cqr->device;
 
 	/* check for successful execution first */
 	if (irb->scsw.cstat == 0x00 &&
@@ -207,10 +203,10 @@
  * RETURN VALUES
  *   cqr		original cqr		   
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_cleanup(dasd_ccw_req_t * erp, char final_status)
+static struct dasd_ccw_req *
+dasd_3990_erp_cleanup(struct dasd_ccw_req * erp, char final_status)
 {
-	dasd_ccw_req_t *cqr = erp->refers;
+	struct dasd_ccw_req *cqr = erp->refers;
 
 	dasd_free_erp_request(erp, erp->device);
 	cqr->status = final_status;
@@ -234,10 +230,10 @@
  *   void		
  */
 static void
-dasd_3990_erp_block_queue(dasd_ccw_req_t * erp, int expires)
+dasd_3990_erp_block_queue(struct dasd_ccw_req * erp, int expires)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	DEV_MESSAGE(KERN_INFO, device,
 		    "blocking request queue for %is", expires);
@@ -258,11 +254,11 @@
  * RETURN VALUES
  *   erp		modified erp
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_int_req(dasd_ccw_req_t * erp)
+static struct dasd_ccw_req *
+dasd_3990_erp_int_req(struct dasd_ccw_req * erp)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	/* first time set initial retry counter and erp_function */
 	/* and retry once without blocking queue		 */
@@ -301,9 +297,9 @@
  *   erp		modified pointer to the ERP
  */
 static void
-dasd_3990_erp_alternate_path(dasd_ccw_req_t * erp)
+dasd_3990_erp_alternate_path(struct dasd_ccw_req * erp)
 {
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 	__u8 opm;
 
 	/* try alternate valid path */
@@ -349,17 +345,18 @@
  *   dctl_cqr		pointer to NEW dctl_cqr 
  *
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_DCTL(dasd_ccw_req_t * erp, char modifier)
+static struct dasd_ccw_req *
+dasd_3990_erp_DCTL(struct dasd_ccw_req * erp, char modifier)
 {
 
-	dasd_device_t *device = erp->device;
-	DCTL_data_t *DCTL_data;
+	struct dasd_device *device = erp->device;
+	struct DCTL_data *DCTL_data;
 	struct ccw1 *ccw;
-	dasd_ccw_req_t *dctl_cqr;
+	struct dasd_ccw_req *dctl_cqr;
 
 	dctl_cqr = dasd_alloc_erp_request((char *) &erp->magic, 1,
-					  sizeof (DCTL_data_t), erp->device);
+					  sizeof (struct DCTL_data),
+					  erp->device);
 	if (IS_ERR(dctl_cqr)) {
 		DEV_MESSAGE(KERN_ERR, device, "%s",
 			    "Unable to allocate DCTL-CQR");
@@ -409,8 +406,8 @@
  *   erp		pointer to the ERP
  *
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_action_1(dasd_ccw_req_t * erp)
+static struct dasd_ccw_req *
+dasd_3990_erp_action_1(struct dasd_ccw_req * erp)
 {
 
 	erp->function = dasd_3990_erp_action_1;
@@ -438,11 +435,11 @@
  *   erp		pointer to the ERP
  *
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_action_4(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_action_4(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	/* first time set initial retry counter and erp_function    */
 	/* and retry once without waiting for state change pending  */
@@ -496,8 +493,8 @@
  *   erp		pointer to the ERP
  *
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_action_5(dasd_ccw_req_t * erp)
+static struct dasd_ccw_req *
+dasd_3990_erp_action_5(struct dasd_ccw_req * erp)
 {
 
 	/* first of all retry */
@@ -523,10 +520,10 @@
  *   void
  */
 static void
-dasd_3990_handle_env_data(dasd_ccw_req_t * erp, char *sense)
+dasd_3990_handle_env_data(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 	char msg_format = (sense[7] & 0xF0);
 	char msg_no = (sense[7] & 0x0F);
 
@@ -1146,11 +1143,11 @@
  * RETURN VALUES
  *   erp		'new' erp_head - pointer to new ERP 
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_com_rej(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_com_rej(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	erp->function = dasd_3990_erp_com_rej;
 
@@ -1187,11 +1184,11 @@
  * RETURN VALUES
  *   erp		new erp_head - pointer to new ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_bus_out(dasd_ccw_req_t * erp)
+static struct dasd_ccw_req *
+dasd_3990_erp_bus_out(struct dasd_ccw_req * erp)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	/* first time set initial retry counter and erp_function */
 	/* and retry once without blocking queue		 */
@@ -1226,11 +1223,11 @@
  * RETURN VALUES
  *   erp		new erp_head - pointer to new ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_equip_check(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_equip_check(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	erp->function = dasd_3990_erp_equip_check;
 
@@ -1288,11 +1285,11 @@
  * RETURN VALUES
  *   erp		new erp_head - pointer to new ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_data_check(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_data_check(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	erp->function = dasd_3990_erp_data_check;
 
@@ -1347,11 +1344,11 @@
  * RETURN VALUES
  *   erp		new erp_head - pointer to new ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_overrun(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_overrun(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	erp->function = dasd_3990_erp_overrun;
 
@@ -1376,11 +1373,11 @@
  * RETURN VALUES
  *   erp		new erp_head - pointer to new ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_inv_format(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_inv_format(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	erp->function = dasd_3990_erp_inv_format;
 
@@ -1417,11 +1414,11 @@
  * RETURN VALUES
  *   erp		pointer to original (failed) cqr.
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_EOC(dasd_ccw_req_t * default_erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_EOC(struct dasd_ccw_req * default_erp, char *sense)
 {
 
-	dasd_device_t *device = default_erp->device;
+	struct dasd_device *device = default_erp->device;
 
 	DEV_MESSAGE(KERN_ERR, device, "%s",
 		    "End-of-Cylinder - must never happen");
@@ -1442,11 +1439,11 @@
  * RETURN VALUES
  *   erp		new erp_head - pointer to new ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_env_data(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_env_data(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	erp->function = dasd_3990_erp_env_data;
 
@@ -1479,11 +1476,11 @@
  * RETURN VALUES
  *   erp		new erp_head - pointer to new ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_no_rec(dasd_ccw_req_t * default_erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_no_rec(struct dasd_ccw_req * default_erp, char *sense)
 {
 
-	dasd_device_t *device = default_erp->device;
+	struct dasd_device *device = default_erp->device;
 
 	DEV_MESSAGE(KERN_ERR, device, "%s",
 		    "No Record Found - Fatal error should "
@@ -1506,11 +1503,11 @@
  * RETURN VALUES
  *   erp		new erp_head - pointer to new ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_file_prot(dasd_ccw_req_t * erp)
+static struct dasd_ccw_req *
+dasd_3990_erp_file_prot(struct dasd_ccw_req * erp)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	DEV_MESSAGE(KERN_ERR, device, "%s", "File Protected");
 
@@ -1532,11 +1529,11 @@
  * RETURN VALUES
  *   erp		pointer to the (addtitional) ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_inspect_24(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_inspect_24(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_ccw_req_t *erp_filled = NULL;
+	struct dasd_ccw_req *erp_filled = NULL;
 
 	/* Check sense for ....	   */
 	/* 'Command Reject'	   */
@@ -1612,11 +1609,11 @@
  * RETURN VALUES
  *   erp		modified erp_head
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_action_10_32(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_action_10_32(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	erp->retries = 256;
 	erp->function = dasd_3990_erp_action_10_32;
@@ -1646,15 +1643,15 @@
  *   erp		new erp or 
  *			default_erp in case of imprecise ending or error
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_action_1B_32(dasd_ccw_req_t * default_erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 {
 
-	dasd_device_t *device = default_erp->device;
+	struct dasd_device *device = default_erp->device;
 	__u32 cpa = 0;
-	dasd_ccw_req_t *cqr;
-	dasd_ccw_req_t *erp;
-	DE_eckd_data_t *DE_data;
+	struct dasd_ccw_req *cqr;
+	struct dasd_ccw_req *erp;
+	struct DE_eckd_data *DE_data;
 	char *LO_data;		/* LO_eckd_data_t */
 	struct ccw1 *ccw;
 
@@ -1695,8 +1692,8 @@
 	/* Build new ERP request including DE/LO */
 	erp = dasd_alloc_erp_request((char *) &cqr->magic,
 				     2 + 1,/* DE/LO + TIC */
-				     sizeof (DE_eckd_data_t) +
-				     sizeof (LO_eckd_data_t), device);
+				     sizeof (struct DE_eckd_data) +
+				     sizeof (struct LO_eckd_data), device);
 
 	if (IS_ERR(erp)) {
 		DEV_MESSAGE(KERN_ERR, device, "%s", "Unable to allocate ERP");
@@ -1705,10 +1702,10 @@
 
 	/* use original DE */
 	DE_data = erp->data;
-	memcpy(DE_data, cqr->data, sizeof (DE_eckd_data_t));
+	memcpy(DE_data, cqr->data, sizeof (struct DE_eckd_data));
 
 	/* create LO */
-	LO_data = erp->data + sizeof (DE_eckd_data_t);
+	LO_data = erp->data + sizeof (struct DE_eckd_data);
 
 	if ((sense[3] == 0x01) && (LO_data[1] & 0x01)) {
 
@@ -1791,15 +1788,15 @@
  * RETURN VALUES
  *   erp		modified erp 
  */
-static dasd_ccw_req_t *
-dasd_3990_update_1B(dasd_ccw_req_t * previous_erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_update_1B(struct dasd_ccw_req * previous_erp, char *sense)
 {
 
-	dasd_device_t *device = previous_erp->device;
+	struct dasd_device *device = previous_erp->device;
 	__u32 cpa = 0;
-	dasd_ccw_req_t *cqr;
-	dasd_ccw_req_t *erp;
-	char *LO_data;		/* LO_eckd_data_t */
+	struct dasd_ccw_req *cqr;
+	struct dasd_ccw_req *erp;
+	char *LO_data;		/* struct LO_eckd_data */
 	struct ccw1 *ccw;
 
 	DEV_MESSAGE(KERN_DEBUG, device, "%s",
@@ -1842,7 +1839,7 @@
 	erp = previous_erp;
 
 	/* update the LO with the new returned sense data  */
-	LO_data = erp->data + sizeof (DE_eckd_data_t);
+	LO_data = erp->data + sizeof (struct DE_eckd_data);
 
 	if ((sense[3] == 0x01) && (LO_data[1] & 0x01)) {
 
@@ -1905,7 +1902,7 @@
  *
  */
 static void
-dasd_3990_erp_compound_retry(dasd_ccw_req_t * erp, char *sense)
+dasd_3990_erp_compound_retry(struct dasd_ccw_req * erp, char *sense)
 {
 
 	switch (sense[25] & 0x03) {
@@ -1949,7 +1946,7 @@
  *
  */
 static void
-dasd_3990_erp_compound_path(dasd_ccw_req_t * erp, char *sense)
+dasd_3990_erp_compound_path(struct dasd_ccw_req * erp, char *sense)
 {
 
 	if (sense[25] & DASD_SENSE_BIT_3) {
@@ -1984,8 +1981,8 @@
  *   erp		NEW ERP pointer
  *
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_compound_code(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_compound_code(struct dasd_ccw_req * erp, char *sense)
 {
 
 	if (sense[25] & DASD_SENSE_BIT_2) {
@@ -2033,13 +2030,13 @@
  *
  */
 static void
-dasd_3990_erp_compound_config(dasd_ccw_req_t * erp, char *sense)
+dasd_3990_erp_compound_config(struct dasd_ccw_req * erp, char *sense)
 {
 
 	if ((sense[25] & DASD_SENSE_BIT_1) && (sense[26] & DASD_SENSE_BIT_2)) {
 
 		/* set to suspended duplex state then restart */
-		dasd_device_t *device = erp->device;
+		struct dasd_device *device = erp->device;
 
 		DEV_MESSAGE(KERN_ERR, device, "%s",
 			    "Set device to suspended duplex state should be "
@@ -2068,8 +2065,8 @@
  *   erp		(additional) ERP pointer
  *
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_compound(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_compound(struct dasd_ccw_req * erp, char *sense)
 {
 
 	if ((erp->function == dasd_3990_erp_compound_retry) &&
@@ -2115,11 +2112,11 @@
  *   erp_filled		pointer to the ERP
  *
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_inspect_32(dasd_ccw_req_t * erp, char *sense)
+static struct dasd_ccw_req *
+dasd_3990_erp_inspect_32(struct dasd_ccw_req * erp, char *sense)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 
 	erp->function = dasd_3990_erp_inspect_32;
 
@@ -2232,11 +2229,11 @@
  * RETURN VALUES
  *   erp_new		contens was possibly modified 
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_inspect(dasd_ccw_req_t * erp)
+static struct dasd_ccw_req *
+dasd_3990_erp_inspect(struct dasd_ccw_req * erp)
 {
 
-	dasd_ccw_req_t *erp_new = NULL;
+	struct dasd_ccw_req *erp_new = NULL;
 	/* sense data are located in the refers record of the */
 	/* already set up new ERP !			      */
 	char *sense = erp->refers->dstat->ecw;
@@ -2272,15 +2269,15 @@
  * RETURN VALUES
  *   erp		pointer to new ERP-chain head
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_add_erp(dasd_ccw_req_t * cqr)
+static struct dasd_ccw_req *
+dasd_3990_erp_add_erp(struct dasd_ccw_req * cqr)
 {
 
-	dasd_device_t *device = cqr->device;
+	struct dasd_device *device = cqr->device;
 	struct ccw1 *ccw;
 
 	/* allocate additional request block */
-	dasd_ccw_req_t *erp;
+	struct dasd_ccw_req *erp;
 
 	erp = dasd_alloc_erp_request((char *) &cqr->magic, 2, 0, cqr->device);
 	if (IS_ERR(erp)) {
@@ -2333,11 +2330,11 @@
  * RETURN VALUES
  *   erp		pointer to new ERP-chain head
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_additional_erp(dasd_ccw_req_t * cqr)
+static struct dasd_ccw_req *
+dasd_3990_erp_additional_erp(struct dasd_ccw_req * cqr)
 {
 
-	dasd_ccw_req_t *erp = NULL;
+	struct dasd_ccw_req *erp = NULL;
 
 	/* add erp and initialize with default TIC */
 	erp = dasd_3990_erp_add_erp(cqr);
@@ -2371,7 +2368,7 @@
  *			returns 1 if match found, otherwise 0.
  */
 static int
-dasd_3990_erp_error_match(dasd_ccw_req_t * cqr1, dasd_ccw_req_t * cqr2)
+dasd_3990_erp_error_match(struct dasd_ccw_req *cqr1, struct dasd_ccw_req *cqr2)
 {
 
 	/* check failed CCW */
@@ -2406,11 +2403,11 @@
  *			recovery procedure OR
  *			NULL if a 'new' error occurred.
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_in_erp(dasd_ccw_req_t * cqr)
+static struct dasd_ccw_req *
+dasd_3990_erp_in_erp(struct dasd_ccw_req *cqr)
 {
 
-	dasd_ccw_req_t *erp_head = cqr,	/* save erp chain head */
+	struct dasd_ccw_req *erp_head = cqr,	/* save erp chain head */
 	*erp_match = NULL;	/* save erp chain head */
 	int match = 0;		/* 'boolean' for matching error found */
 
@@ -2450,11 +2447,11 @@
  * RETURN VALUES
  *   erp		modified/additional ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_further_erp(dasd_ccw_req_t * erp)
+static struct dasd_ccw_req *
+dasd_3990_erp_further_erp(struct dasd_ccw_req *erp)
 {
 
-	dasd_device_t *device = erp->device;
+	struct dasd_device *device = erp->device;
 	char *sense = erp->dstat->ecw;
 
 	/* check for 24 byte sense ERP */
@@ -2539,13 +2536,14 @@
  * RETURN VALUES
  *   erp		modified/additional ERP
  */
-static dasd_ccw_req_t *
-dasd_3990_erp_handle_match_erp(dasd_ccw_req_t * erp_head, dasd_ccw_req_t * erp)
+static struct dasd_ccw_req *
+dasd_3990_erp_handle_match_erp(struct dasd_ccw_req *erp_head,
+			       struct dasd_ccw_req *erp)
 {
 
-	dasd_device_t *device = erp_head->device;
-	dasd_ccw_req_t *erp_done = erp_head;	/* finished req */
-	dasd_ccw_req_t *erp_free = NULL;	/* req to be freed */
+	struct dasd_device *device = erp_head->device;
+	struct dasd_ccw_req *erp_done = erp_head;	/* finished req */
+	struct dasd_ccw_req *erp_free = NULL;	/* req to be freed */
 
 	/* loop over successful ERPs and remove them from chanq */
 	while (erp_done != erp) {
@@ -2619,12 +2617,12 @@
  *			 - the original given cqr (which's status might 
  *			   be modified)
  */
-dasd_ccw_req_t *
-dasd_3990_erp_action(dasd_ccw_req_t * cqr)
+struct dasd_ccw_req *
+dasd_3990_erp_action(struct dasd_ccw_req * cqr)
 {
 
-	dasd_ccw_req_t *erp = NULL;
-	dasd_device_t *device = cqr->device;
+	struct dasd_ccw_req *erp = NULL;
+	struct dasd_device *device = cqr->device;
 	__u32 cpa = cqr->dstat->scsw.cpa;
 
 #ifdef ERP_DEBUG
@@ -2632,7 +2630,7 @@
 	DEV_MESSAGE(KERN_DEBUG, device, "%s",
 		    "ERP chain at BEGINNING of ERP-ACTION");
 	{
-		dasd_ccw_req_t *temp_erp = NULL;
+		struct dasd_ccw_req *temp_erp = NULL;
 
 		for (temp_erp = cqr;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
@@ -2683,7 +2681,7 @@
 	/* print current erp_chain */
 	DEV_MESSAGE(KERN_DEBUG, device, "%s", "ERP chain at END of ERP-ACTION");
 	{
-		dasd_ccw_req_t *temp_erp = NULL;
+		struct dasd_ccw_req *temp_erp = NULL;
 		for (temp_erp = erp;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
 
diff -urN linux-2.5.67/drivers/s390/block/dasd_9336_erp.c linux-2.5.67-s390/drivers/s390/block/dasd_9336_erp.c
--- linux-2.5.67/drivers/s390/block/dasd_9336_erp.c	Mon Apr  7 19:32:16 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_9336_erp.c	Mon Apr 14 19:11:53 2003
@@ -4,10 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000
  *
- * $Revision: 1.6 $
- *
- * History of changes 
- *
+ * $Revision: 1.8 $
  */
 
 #define PRINTK_HEADER "dasd_erp(9336)"
@@ -32,7 +29,7 @@
  *   dasd_era_recover	for all others.
  */
 dasd_era_t
-dasd_9336_erp_examine(dasd_ccw_req_t * cqr, struct irb * irb)
+dasd_9336_erp_examine(struct dasd_ccw_req * cqr, struct irb * irb)
 {
 	/* check for successful execution first */
 	if (irb->scsw.cstat == 0x00 &&
diff -urN linux-2.5.67/drivers/s390/block/dasd_9343_erp.c linux-2.5.67-s390/drivers/s390/block/dasd_9343_erp.c
--- linux-2.5.67/drivers/s390/block/dasd_9343_erp.c	Mon Apr  7 19:33:03 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_9343_erp.c	Mon Apr 14 19:11:53 2003
@@ -4,10 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000
  *
- * $Revision: 1.11 $
- *
- * History of changes 
- * 
+ * $Revision: 1.13 $
  */
 
 #define PRINTK_HEADER "dasd_erp(9343)"
@@ -15,7 +12,7 @@
 #include "dasd_int.h"
 
 dasd_era_t
-dasd_9343_erp_examine(dasd_ccw_req_t * cqr, struct irb * irb)
+dasd_9343_erp_examine(struct dasd_ccw_req * cqr, struct irb * irb)
 {
 	if (irb->scsw.cstat == 0x00 &&
 	    irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
diff -urN linux-2.5.67/drivers/s390/block/dasd_devmap.c linux-2.5.67-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.5.67/drivers/s390/block/dasd_devmap.c	Mon Apr 14 19:11:53 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_devmap.c	Mon Apr 14 19:11:53 2003
@@ -11,14 +11,10 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.12 $
- *
- * History of changes 
- * 05/04/02 split from dasd.c, code restructuring.
+ * $Revision: 1.15 $
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
 
@@ -40,14 +36,14 @@
  * can be removed since the device number will then be identical
  * to the device index.
  */
-typedef struct {
+struct dasd_devmap {
 	struct list_head devindex_list;
 	struct list_head devno_list;
         unsigned int devindex;
         unsigned short devno;
         unsigned short features;
-	dasd_device_t *device;
-} dasd_devmap_t;
+	struct dasd_device *device;
+};
 
 /*
  * Parameter parsing functions for dasd= parameter. The syntax is:
@@ -264,13 +260,12 @@
 	}
 	spin_lock(&dasd_devmap_lock);
 	for (devno = from; devno <= to; devno++) {
-		dasd_devmap_t *devmap, *tmp;
-		struct list_head *l;
+		struct dasd_devmap *devmap, *tmp;
 
 		devmap = NULL;
 		/* Find previous devmap for device number i */
-		list_for_each(l, &dasd_devno_hashlists[devno & 255]) {
-			tmp = list_entry(l, dasd_devmap_t, devno_list);
+		list_for_each_entry(tmp, &dasd_devno_hashlists[devno & 255],
+				    devno_list) {
 			if (tmp->devno == devno) {
 				devmap = tmp;
 				break;
@@ -278,8 +273,8 @@
 		}
 		if (devmap == NULL) {
 			/* This devno is new. */
-			devmap = (dasd_devmap_t *)
-				kmalloc(sizeof(dasd_devmap_t), GFP_KERNEL);
+			devmap = (struct dasd_devmap *)
+				kmalloc(sizeof(struct dasd_devmap),GFP_KERNEL);
 			if (devmap == NULL)
 				return -ENOMEM;
 			devindex = dasd_max_devindex++;
@@ -303,14 +298,15 @@
 int
 dasd_devno_in_range(int devno)
 {
-	struct list_head *l;
+	struct dasd_devmap *devmap;
 	int ret;
 		
 	ret = -ENOENT;
 	spin_lock(&dasd_devmap_lock);
 	/* Find devmap for device with device number devno */
-	list_for_each(l, &dasd_devno_hashlists[devno&255]) {
-		if (list_entry(l, dasd_devmap_t, devno_list)->devno == devno) {
+	list_for_each_entry(devmap, &dasd_devno_hashlists[devno&255],
+			    devno_list) {
+		if (devmap->devno == devno) {
 			/* Found the device. */
 			ret = 0;
 			break;
@@ -332,9 +328,9 @@
 	spin_lock(&dasd_devmap_lock);
 	for (i = 0; i < 256; i++) {
 		struct list_head *l, *next;
-		dasd_devmap_t *devmap;
+		struct dasd_devmap *devmap;
 		list_for_each_safe(l, next, &dasd_devno_hashlists[i]) {
-			devmap = list_entry(l, dasd_devmap_t, devno_list);
+			devmap = list_entry(l, struct dasd_devmap, devno_list);
 			if (devmap->device != NULL)
 				BUG();
 			list_del(&devmap->devindex_list);
@@ -349,17 +345,15 @@
  * Find the devmap structure from a devno. Can be removed as soon
  * as big minors are available.
  */
-static dasd_devmap_t *
+static struct dasd_devmap *
 dasd_devmap_from_devno(int devno)
 {
-	struct list_head *l;
-	dasd_devmap_t *devmap, *tmp;
+	struct dasd_devmap *devmap, *tmp;
 		
 	devmap = NULL;
 	spin_lock(&dasd_devmap_lock);
 	/* Find devmap for device with device number devno */
-	list_for_each(l, &dasd_devno_hashlists[devno&255]) {
-		tmp = list_entry(l, dasd_devmap_t, devno_list);
+	list_for_each_entry(tmp, &dasd_devno_hashlists[devno&255], devno_list) {
 		if (tmp->devno == devno) {
 			/* Found the device, return devmap */
 			devmap = tmp;
@@ -374,17 +368,16 @@
  * Find the devmap for a device by its device index. Can be removed
  * as soon as big minors are available.
  */
-static dasd_devmap_t *
+static struct dasd_devmap *
 dasd_devmap_from_devindex(int devindex)
 {
-	struct list_head *l;
-	dasd_devmap_t *devmap, *tmp;
+	struct dasd_devmap *devmap, *tmp;
 		
 	devmap = NULL;
 	spin_lock(&dasd_devmap_lock);
 	/* Find devmap for device with device index devindex */
-	list_for_each(l, &dasd_devindex_hashlists[devindex & 255]) {
-		tmp = list_entry(l, dasd_devmap_t, devindex_list);
+	list_for_each_entry(tmp, &dasd_devindex_hashlists[devindex & 255],
+			    devindex_list) {
 		if (tmp->devindex == devindex) {
 			/* Found the device, return devno */
 			devmap = tmp;
@@ -395,11 +388,11 @@
 	return devmap;
 }
 
-dasd_device_t *
+struct dasd_device *
 dasd_device_from_devindex(int devindex)
 {
-	dasd_devmap_t *devmap;
-	dasd_device_t *device;
+	struct dasd_devmap *devmap;
+	struct dasd_device *device;
 
 	devmap = dasd_devmap_from_devindex(devindex);
 	spin_lock(&dasd_devmap_lock);
@@ -416,9 +409,9 @@
  * Return kdev for a dasd device.
  */
 kdev_t
-dasd_get_kdev(dasd_device_t *device)
+dasd_get_kdev(struct dasd_device *device)
 {
-	dasd_devmap_t *devmap;
+	struct dasd_devmap *devmap;
 	int major, minor;
 	int devno;
 
@@ -436,11 +429,11 @@
 /*
  * Create a dasd device structure for cdev.
  */
-dasd_device_t *
+struct dasd_device *
 dasd_create_device(struct ccw_device *cdev)
 {
-	dasd_devmap_t *devmap;
-	dasd_device_t *device;
+	struct dasd_devmap *devmap;
+	struct dasd_device *device;
 	int devno;
 	int rc;
 
@@ -491,10 +484,10 @@
  * Remove a dasd device structure.
  */
 void
-dasd_delete_device(dasd_device_t *device)
+dasd_delete_device(struct dasd_device *device)
 {
 	struct ccw_device *cdev;
-	dasd_devmap_t *devmap;
+	struct dasd_devmap *devmap;
 	int devno;
 
 	/* First remove device pointer from devmap. */
@@ -526,7 +519,7 @@
  * in dasd_delete_device.
  */
 void
-dasd_put_device_wake(dasd_device_t *device)
+dasd_put_device_wake(struct dasd_device *device)
 {
 	wake_up(&dasd_delete_wq);
 }
diff -urN linux-2.5.67/drivers/s390/block/dasd_diag.c linux-2.5.67-s390/drivers/s390/block/dasd_diag.c
--- linux-2.5.67/drivers/s390/block/dasd_diag.c	Mon Apr 14 19:11:53 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_diag.c	Mon Apr 14 19:11:53 2003
@@ -6,16 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.28 $
- *
- * History of changes
- * 07/13/00 Added fixup sections for diagnoses ans saved some registers
- * 07/14/00 fixed constraints in newly generated inline asm
- * 10/05/00 adapted to 'new' DASD driver
- *	    fixed return codes of dia250()
- *	    fixed partition handling and HDIO_GETGEO
- * 2002/01/04 Created 2.4-2.5 compatibility mode
- * 05/04/02 code restructuring.
+ * $Revision: 1.31 $
  */
 
 #include <linux/config.h>
@@ -44,17 +35,17 @@
 
 MODULE_LICENSE("GPL");
 
-typedef struct dasd_diag_private_t {
-	dasd_diag_characteristics_t rdc_data;
-	diag_rw_io_t iob;
-	diag_init_io_t iib;
+struct dasd_diag_private {
+	struct dasd_diag_characteristics rdc_data;
+	struct dasd_diag_rw_io iob;
+	struct dasd_diag_init_io iib;
 	unsigned int pt_block;
-} dasd_diag_private_t;
+};
 
-typedef struct dasd_diag_req_t {
+struct dasd_diag_req {
 	int block_count;
-	diag_bio_t bio[0];
-} dasd_diag_req_t;
+	struct dasd_diag_bio bio[0];
+};
 
 static __inline__ int
 dia250(void *iob, int cmd)
@@ -86,15 +77,15 @@
 }
 
 static __inline__ int
-mdsk_init_io(dasd_device_t * device, int blocksize, int offset, int size)
+mdsk_init_io(struct dasd_device * device, int blocksize, int offset, int size)
 {
-	dasd_diag_private_t *private;
-	diag_init_io_t *iib;
+	struct dasd_diag_private *private;
+	struct dasd_diag_init_io *iib;
 	int rc;
 
-	private = (dasd_diag_private_t *) device->private;
+	private = (struct dasd_diag_private *) device->private;
 	iib = &private->iib;
-	memset(iib, 0, sizeof (diag_init_io_t));
+	memset(iib, 0, sizeof (struct dasd_diag_init_io));
 
 	iib->dev_nr = _ccw_device_get_device_number(device->cdev);
 	iib->block_size = blocksize;
@@ -108,31 +99,31 @@
 }
 
 static __inline__ int
-mdsk_term_io(dasd_device_t * device)
+mdsk_term_io(struct dasd_device * device)
 {
-	dasd_diag_private_t *private;
-	diag_init_io_t *iib;
+	struct dasd_diag_private *private;
+	struct dasd_diag_init_io *iib;
 	int rc;
 
-	private = (dasd_diag_private_t *) device->private;
+	private = (struct dasd_diag_private *) device->private;
 	iib = &private->iib;
-	memset(iib, 0, sizeof (diag_init_io_t));
+	memset(iib, 0, sizeof (struct dasd_diag_init_io));
 	iib->dev_nr = _ccw_device_get_device_number(device->cdev);
 	rc = dia250(iib, TERM_BIO);
 	return rc & 3;
 }
 
 static int
-dasd_start_diag(dasd_ccw_req_t * cqr)
+dasd_start_diag(struct dasd_ccw_req * cqr)
 {
-	dasd_device_t *device;
-	dasd_diag_private_t *private;
-	dasd_diag_req_t *dreq;
+	struct dasd_device *device;
+	struct dasd_diag_private *private;
+	struct dasd_diag_req *dreq;
 	int rc;
 
 	device = cqr->device;
-	private = (dasd_diag_private_t *) device->private;
-	dreq = (dasd_diag_req_t *) cqr->data;
+	private = (struct dasd_diag_private *) device->private;
+	dreq = (struct dasd_diag_req *) cqr->data;
 
 	private->iob.dev_nr = _ccw_device_get_device_number(device->cdev);
 	private->iob.key = 0;
@@ -160,8 +151,8 @@
 static void
 dasd_ext_handler(struct pt_regs *regs, __u16 code)
 {
-	dasd_ccw_req_t *cqr, *next;
-	dasd_device_t *device;
+	struct dasd_ccw_req *cqr, *next;
+	struct dasd_device *device;
 	unsigned long long expires;
 	unsigned long flags;
 	char status;
@@ -186,11 +177,11 @@
 		irq_exit();
 		return;
 	}
-	cqr = (dasd_ccw_req_t *)(addr_t) ip;
-	device = (dasd_device_t *) cqr->device;
+	cqr = (struct dasd_ccw_req *)(addr_t) ip;
+	device = (struct dasd_device *) cqr->device;
 	if (strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
 		DEV_MESSAGE(KERN_WARNING, device,
-			    " magic number of dasd_ccw_req_t 0x%08X doesn't"
+			    " magic number of dasd_ccw_req 0x%08X doesn't"
 			    " match discipline 0x%08X",
 			    cqr->magic, *(int *) (&device->discipline->name));
 		irq_exit();
@@ -208,7 +199,7 @@
 		/* Start first request on queue if possible -> fast_io. */
 		if (!list_empty(&device->ccw_queue)) {
 			next = list_entry(device->ccw_queue.next,
-					  dasd_ccw_req_t, list);
+					  struct dasd_ccw_req, list);
 			if (next->status == DASD_CQR_QUEUED) {
 				if (dasd_start_diag(next) == 0)
 					expires = next->expires;
@@ -231,18 +222,18 @@
 }
 
 static int
-dasd_diag_check_device(dasd_device_t *device)
+dasd_diag_check_device(struct dasd_device *device)
 {
-	dasd_diag_private_t *private;
-	dasd_diag_characteristics_t *rdc_data;
-	diag_bio_t bio;
+	struct dasd_diag_private *private;
+	struct dasd_diag_characteristics *rdc_data;
+	struct dasd_diag_bio bio;
 	long *label;
 	int sb, bsize;
 	int rc;
 
-	private = (dasd_diag_private_t *) device->private;
+	private = (struct dasd_diag_private *) device->private;
 	if (private == NULL) {
-		private = kmalloc(sizeof(dasd_diag_private_t), GFP_KERNEL);
+		private = kmalloc(sizeof(struct dasd_diag_private),GFP_KERNEL);
 		if (private == NULL) {
 			MESSAGE(KERN_WARNING, "%s",
 				"memory allocation failed for private data");
@@ -253,7 +244,7 @@
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
 	rdc_data->dev_nr = _ccw_device_get_device_number(device->cdev);
-	rdc_data->rdc_len = sizeof (dasd_diag_characteristics_t);
+	rdc_data->rdc_len = sizeof (struct dasd_diag_characteristics);
 
 	rc = diag210((struct diag210 *) rdc_data);
 	if (rc)
@@ -289,11 +280,11 @@
 	}
 	for (bsize = 512; bsize <= PAGE_SIZE; bsize <<= 1) {
 		mdsk_init_io(device, bsize, 0, 64);
-		memset(&bio, 0, sizeof (diag_bio_t));
+		memset(&bio, 0, sizeof (struct dasd_diag_bio));
 		bio.type = MDSK_READ_REQ;
 		bio.block_number = private->pt_block + 1;
 		bio.buffer = __pa(label);
-		memset(&private->iob, 0, sizeof (diag_rw_io_t));
+		memset(&private->iob, 0, sizeof (struct dasd_diag_rw_io));
 		private->iob.dev_nr = rdc_data->dev_nr;
 		private->iob.key = 0;
 		private->iob.flags = 0;	/* do synchronous io */
@@ -324,7 +315,7 @@
 }
 
 static int
-dasd_diag_fill_geometry(dasd_device_t *device, struct hd_geometry *geo)
+dasd_diag_fill_geometry(struct dasd_device *device, struct hd_geometry *geo)
 {
 	if (dasd_check_blocksize(device->bp_block) != 0)
 		return -EINVAL;
@@ -335,29 +326,29 @@
 }
 
 static dasd_era_t
-dasd_diag_examine_error(dasd_ccw_req_t * cqr, struct irb * stat)
+dasd_diag_examine_error(struct dasd_ccw_req * cqr, struct irb * stat)
 {
 	return dasd_era_fatal;
 }
 
 static dasd_erp_fn_t
-dasd_diag_erp_action(dasd_ccw_req_t * cqr)
+dasd_diag_erp_action(struct dasd_ccw_req * cqr)
 {
 	return dasd_default_erp_action;
 }
 
 static dasd_erp_fn_t
-dasd_diag_erp_postaction(dasd_ccw_req_t * cqr)
+dasd_diag_erp_postaction(struct dasd_ccw_req * cqr)
 {
 	return dasd_default_erp_postaction;
 }
 
-static dasd_ccw_req_t *
-dasd_diag_build_cp(dasd_device_t * device, struct request *req)
+static struct dasd_ccw_req *
+dasd_diag_build_cp(struct dasd_device * device, struct request *req)
 {
-	dasd_ccw_req_t *cqr;
-	dasd_diag_req_t *dreq;
-	diag_bio_t *dbio;
+	struct dasd_ccw_req *cqr;
+	struct dasd_diag_req *dreq;
+	struct dasd_diag_bio *dbio;
 	struct bio *bio;
 	struct bio_vec *bv;
 	char *dst;
@@ -391,13 +382,14 @@
 	if (count != last_rec - first_rec + 1)
 		return ERR_PTR(-EINVAL);
 	/* Build the request */
-	datasize = sizeof(dasd_diag_req_t) + count*sizeof(diag_bio_t);
+	datasize = sizeof(struct dasd_diag_req) +
+		count*sizeof(struct dasd_diag_bio);
 	cqr = dasd_smalloc_request(dasd_diag_discipline.name, 0,
 				   datasize, device);
 	if (IS_ERR(cqr))
 		return cqr;
 	
-	dreq = (dasd_diag_req_t *) cqr->data;
+	dreq = (struct dasd_diag_req *) cqr->data;
 	dreq->block_count = count;
 	dbio = dreq->bio;
 	recid = first_rec;
@@ -405,7 +397,7 @@
 		bio_for_each_segment(bv, bio, i) {
 			dst = kmap(bv->bv_page) + bv->bv_offset;
 			for (off = 0; off < bv->bv_len; off += blksize) {
-				memset(dbio, 0, sizeof (diag_bio_t));
+				memset(dbio, 0, sizeof (struct dasd_diag_bio));
 				dbio->type = rw_cmd;
 				dbio->block_number = recid + 1;
 				dbio->buffer = __pa(dst);
@@ -423,24 +415,25 @@
 }
 
 static int
-dasd_diag_fill_info(dasd_device_t * device, dasd_information2_t * info)
+dasd_diag_fill_info(struct dasd_device * device,
+		    struct dasd_information2_t * info)
 {
-	dasd_diag_private_t *private;
+	struct dasd_diag_private *private;
 
-	private = (dasd_diag_private_t *) device->private;
+	private = (struct dasd_diag_private *) device->private;
 	info->label_block = private->pt_block;
 	info->FBA_layout = 1;
 	info->format = DASD_FORMAT_LDL;
-	info->characteristics_size = sizeof (dasd_diag_characteristics_t);
+	info->characteristics_size = sizeof (struct dasd_diag_characteristics);
 	memcpy(info->characteristics,
-	       &((dasd_diag_private_t *) device->private)->rdc_data,
-	       sizeof (dasd_diag_characteristics_t));
+	       &((struct dasd_diag_private *) device->private)->rdc_data,
+	       sizeof (struct dasd_diag_characteristics));
 	info->confdata_size = 0;
 	return 0;
 }
 
 static void
-dasd_diag_dump_sense(dasd_device_t *device, dasd_ccw_req_t * req,
+dasd_diag_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		     struct irb *stat)
 {
 	char *page;
@@ -463,15 +456,15 @@
  * max_blocks is dependent on the amount of storage that is available
  * in the static io buffer for each device. Currently each device has
  * 8192 bytes (=2 pages). dasd diag is only relevant for 31 bit.
- * The dasd_ccw_req_t has 96 bytes, the dasd_diag_req_t has 8 bytes and
- * the diag_bio_t for each block has 16 bytes. 
+ * The struct dasd_ccw_req has 96 bytes, the struct dasd_diag_req has
+ * 8 bytes and the struct dasd_diag_bio for each block has 16 bytes. 
  * That makes:
  * (8192 - 96 - 8) / 16 = 505.5 blocks at maximum.
  * We want to fit two into the available memory so that we can immediately
  * start the next request if one finishes off. That makes 252.75 blocks
  * for one request. Give a little safety and the result is 240.
  */
-dasd_discipline_t dasd_diag_discipline = {
+struct dasd_discipline dasd_diag_discipline = {
 	.owner = THIS_MODULE,
 	.name = "DIAG",
 	.ebcname = "DIAG",
diff -urN linux-2.5.67/drivers/s390/block/dasd_diag.h linux-2.5.67-s390/drivers/s390/block/dasd_diag.h
--- linux-2.5.67/drivers/s390/block/dasd_diag.h	Mon Apr  7 19:31:05 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_diag.h	Mon Apr 14 19:11:53 2003
@@ -6,10 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.4 $
- *
- * History of changes
- *
+ * $Revision: 1.6 $
  */
 
 #define MDSK_WRITE_REQ 0x01
@@ -22,7 +19,7 @@
 #define DEV_CLASS_FBA	0x01
 #define DEV_CLASS_ECKD	0x04
 
-typedef struct dasd_diag_characteristics_t {
+struct dasd_diag_characteristics {
 	u16 dev_nr;
 	u16 rdc_len;
 	u8 vdev_class;
@@ -33,22 +30,18 @@
 	u8 rdev_type;
 	u8 rdev_model;
 	u8 rdev_features;
-} __attribute__ ((packed, aligned(4)))
-
-    dasd_diag_characteristics_t;
+} __attribute__ ((packed, aligned(4)));
 
-typedef struct diag_bio_t {
+struct dasd_diag_bio {
 	u8 type;
 	u8 status;
 	u16 spare1;
 	u32 block_number;
 	u32 alet;
 	u32 buffer;
-} __attribute__ ((packed, aligned(8)))
+} __attribute__ ((packed, aligned(8)));
 
-    diag_bio_t;
-
-typedef struct diag_init_io_t {
+struct dasd_diag_init_io {
 	u16 dev_nr;
 	u16 spare1[11];
 	u32 block_size;
@@ -56,11 +49,9 @@
 	u32 start_block;
 	u32 end_block;
 	u32 spare2[6];
-} __attribute__ ((packed, aligned(8)))
-
-    diag_init_io_t;
+} __attribute__ ((packed, aligned(8)));
 
-typedef struct diag_rw_io_t {
+struct dasd_diag_rw_io {
 	u16 dev_nr;
 	u16 spare1[11];
 	u8 key;
@@ -71,7 +62,5 @@
 	u32 bio_list;
 	u32 interrupt_params;
 	u32 spare3[5];
-} __attribute__ ((packed, aligned(8)))
-
-    diag_rw_io_t;
+} __attribute__ ((packed, aligned(8)));
 

