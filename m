Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSJYCI6>; Thu, 24 Oct 2002 22:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261165AbSJYCIw>; Thu, 24 Oct 2002 22:08:52 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:14986 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261307AbSJYCHY>; Thu, 24 Oct 2002 22:07:24 -0400
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15800.43384.476639.318443@sofia.bsd2.kbnes.nec.co.jp>
Date: Fri, 25 Oct 2002 11:16:24 +0900
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Forward port of aic7xxx driver to 2.5.44 [3/3]
In-Reply-To: <15800.43219.216824.411355@sofia.bsd2.kbnes.nec.co.jp>
References: <15800.43219.216824.411355@sofia.bsd2.kbnes.nec.co.jp>
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== drivers/scsi/aic7xxx/aic7xxx_inline.h 1.4 vs edited =====
--- 1.4/drivers/scsi/aic7xxx/aic7xxx_inline.h	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_inline.h	Thu Oct 24 14:49:05 2002
@@ -37,9 +37,9 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_inline.h#31 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_inline.h#35 $
  *
- * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx_inline.h,v 1.8 2000/11/12 05:19:46 gibbs Exp $
+ * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx_inline.h,v 1.2.2.11 2002/04/29 19:36:31 gibbs Exp $
  */
 
 #ifndef _AIC7XXX_INLINE_H_
@@ -231,7 +231,8 @@
 
 /*********************** Miscelaneous Support Functions ***********************/
 
-static __inline void	ahc_update_residual(struct scb *scb);
+static __inline void	ahc_update_residual(struct ahc_softc *ahc,
+					    struct scb *scb);
 static __inline struct ahc_initiator_tinfo *
 			ahc_fetch_transinfo(struct ahc_softc *ahc,
 					    char channel, u_int our_id,
@@ -255,13 +256,13 @@
  * for this SCB/transaction.
  */
 static __inline void
-ahc_update_residual(struct scb *scb)
+ahc_update_residual(struct ahc_softc *ahc, struct scb *scb)
 {
 	uint32_t sgptr;
 
 	sgptr = ahc_le32toh(scb->hscb->sgptr);
 	if ((sgptr & SG_RESID_VALID) != 0)
-		ahc_calc_residual(scb);
+		ahc_calc_residual(ahc, scb);
 }
 
 /*
@@ -357,8 +358,8 @@
 	memcpy(q_hscb, scb->hscb, sizeof(*scb->hscb));
 	if ((scb->flags & SCB_CDB32_PTR) != 0) {
 		q_hscb->shared_data.cdb_ptr =
-		    ahc_hscb_busaddr(ahc, q_hscb->tag)
-		  + offsetof(struct hardware_scb, cdb32);	
+		    ahc_htole32(ahc_hscb_busaddr(ahc, q_hscb->tag)
+			      + offsetof(struct hardware_scb, cdb32));
 	}
 	q_hscb->tag = saved_tag;
 	q_hscb->next = scb->hscb->tag;
@@ -471,7 +472,8 @@
 	if (ahc->qoutfifo[ahc->qoutfifonext] != SCB_LIST_NULL)
 		retval |= AHC_RUN_QOUTFIFO;
 #ifdef AHC_TARGET_MODE
-	if ((ahc->flags & AHC_TARGETROLE) != 0) {
+	if ((ahc->flags & AHC_TARGETROLE) != 0
+	 && (ahc->flags & AHC_TQINFIFO_BLOCKED) == 0) {
 		ahc_dmamap_sync(ahc, ahc->shared_data_dmat,
 				ahc->shared_data_dmamap,
 				ahc_targetcmd_offset(ahc, ahc->tqinfifofnext),
@@ -517,10 +519,7 @@
 		 * and asserted the interrupt again.
 		 */
 		ahc_flush_device_writes(ahc);
-#ifdef AHC_TARGET_MODE
-		if ((ahc->flags & AHC_INITIATORROLE) != 0)
-#endif
-			ahc_run_qoutfifo(ahc);
+		ahc_run_qoutfifo(ahc);
 #ifdef AHC_TARGET_MODE
 		if ((ahc->flags & AHC_TARGETROLE) != 0)
 			ahc_run_tqinfifo(ahc, /*paused*/FALSE);
===== drivers/scsi/aic7xxx/aic7xxx_linux_pci.c 1.9 vs edited =====
--- 1.9/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	Tue Feb  5 16:55:20 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	Thu Oct 24 18:24:01 2002
@@ -36,7 +36,7 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c#27 $
+ * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c#32 $
  */
 
 #include "aic7xxx_osm.h"
@@ -71,6 +71,7 @@
 	},
 	{ 0 }
 };
+
 MODULE_DEVICE_TABLE(pci, ahc_linux_pci_id_table);
 
 struct pci_driver aic7xxx_pci_driver = {
@@ -84,20 +85,24 @@
 ahc_linux_pci_dev_remove(struct pci_dev *pdev)
 {
 	struct ahc_softc *ahc;
-	struct ahc_softc *list_ahc;
+	u_long l;
 
 	/*
 	 * We should be able to just perform
 	 * the free directly, but check our
 	 * list for extra sanity.
 	 */
-	ahc = pci_get_drvdata(pdev);
-	TAILQ_FOREACH(list_ahc, &ahc_tailq, links) {
-		if (list_ahc == ahc) {
-			ahc_free(ahc);
-			break;
-		}
+	ahc_list_lock(&l);
+	ahc = ahc_find_softc(pci_get_drvdata(pdev));
+	if (ahc != NULL) {
+		u_long s;
+
+		ahc_lock(ahc, &s);
+		ahc_intr_enable(ahc, FALSE);
+		ahc_unlock(ahc, &s);
+		ahc_free(ahc);
 	}
+	ahc_list_unlock(&l);
 }
 #endif /* !LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0) */
 
@@ -171,7 +176,6 @@
 	}
 #endif
 	ahc->dev_softc = pci;
-	ahc->platform_data->irq = pdev->irq;
 	error = ahc_pci_config(ahc, entry);
 	if (error != 0) {
 		ahc_free(ahc);
@@ -224,7 +228,7 @@
 	*base = ahc_pci_read_config(ahc->dev_softc, PCIR_MAPS, 4);
 	*base &= PCI_BASE_ADDRESS_IO_MASK;
 #endif
-	if (base == 0)
+	if (*base == 0)
 		return (ENOMEM);
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
 	if (check_region(*base, 256) != 0)
@@ -268,9 +272,12 @@
 #endif
 		if (error == 0) {
 			*maddr = ioremap_nocache(base_page, base_offset + 256);
-			if (*maddr == NULL)
+			if (*maddr == NULL) {
 				error = ENOMEM;
-			else
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+				release_mem_region(start, 0x1000);
+#endif
+			} else
 				*maddr += base_offset;
 		}
 	} else
@@ -286,11 +293,9 @@
 	u_long	 base;
 	uint8_t	*maddr;
 	int	 error;
-	int	 io_error;
 
 	/*
-	 * We always reserve both our register spaces to avoid
-	 * other devices claiming them.
+	 * If its allowed, we prefer memory mapped access.
 	 */
 	command = ahc_pci_read_config(ahc->dev_softc, PCIR_COMMAND, 4);
 	command &= ~(PCIM_CMD_PORTEN|PCIM_CMD_MEMEN);
@@ -316,39 +321,42 @@
 			       ahc_get_pci_bus(ahc->dev_softc),
 			       ahc_get_pci_slot(ahc->dev_softc),
 			       ahc_get_pci_function(ahc->dev_softc));
+			iounmap((void *)((u_long)maddr & PAGE_MASK));
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+			release_mem_region(ahc->platform_data->mem_busaddr,
+					   0x1000);
+#endif
+			ahc->bsh.maddr = NULL;
 			maddr = NULL;
 		} else
 			command |= PCIM_CMD_MEMEN;
 	} else {
 		printf("aic7xxx: PCI%d:%d:%d MEM region 0x%lx "
-		       "unavailable. Cannot map device.\n",
+		       "unavailable. Cannot memory map device.\n",
 		       ahc_get_pci_bus(ahc->dev_softc),
 		       ahc_get_pci_slot(ahc->dev_softc),
 		       ahc_get_pci_function(ahc->dev_softc),
 		       base);
 	}
-#endif
+#endif /* MMAPIO */
 
 	/*
-	 * We always prefer memory mapped access.  Only
-	 * complain about our ioport conflicting with
-	 * another device if we are going to use it.
+	 * We always prefer memory mapped access.
 	 */
-	io_error = ahc_linux_pci_reserve_io_region(ahc, &base);
 	if (maddr == NULL) {
-		error = io_error;
-		if (error != 0) {
+
+		error = ahc_linux_pci_reserve_io_region(ahc, &base);
+		if (error == 0) {
+			ahc->tag = BUS_SPACE_PIO;
+			ahc->bsh.ioport = base;
+			command |= PCIM_CMD_PORTEN;
+		} else {
 			printf("aic7xxx: PCI%d:%d:%d IO region 0x%lx[0..255] "
 			       "unavailable. Cannot map device.\n",
 			       ahc_get_pci_bus(ahc->dev_softc),
 			       ahc_get_pci_slot(ahc->dev_softc),
 			       ahc_get_pci_function(ahc->dev_softc),
 			       base);
-			base = 0;
-		} else {
-			ahc->tag = BUS_SPACE_PIO;
-			ahc->bsh.ioport = base;
-			command |= PCIM_CMD_PORTEN;
 		}
 	}
 	ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND, command, 4);
@@ -360,9 +368,10 @@
 {
 	int error;
 
-	ahc->platform_data->irq = ahc->dev_softc->irq;
-	error = request_irq(ahc->platform_data->irq, ahc_linux_isr,
+	error = request_irq(ahc->dev_softc->irq, ahc_linux_isr,
 			    SA_SHIRQ, "aic7xxx", ahc);
+	if (error == 0)
+		ahc->platform_data->irq = ahc->dev_softc->irq;
 	
 	return (-error);
 }
===== drivers/scsi/aic7xxx/aic7xxx_linux_host.h 1.8 vs edited =====
--- 1.8/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Thu Oct 17 07:51:48 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Thu Oct 24 19:26:19 2002
@@ -36,7 +36,7 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h#5 $
+ * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h#9 $
  */
 
 #ifndef _AIC7XXX_LINUX_HOST_H_
@@ -81,12 +81,12 @@
 	reset: NULL,						\
 	slave_attach: ahc_linux_slave_attach,			\
 	bios_param: AIC7XXX_BIOSPARAM,				\
-	can_queue: 253,		/* max simultaneous cmds      */\
-	this_id: -1,		/* scsi id of host adapter    */\
-	sg_tablesize: 0,	/* max scatter-gather cmds    */\
-	cmd_per_lun: 2,		/* cmds per lun		      */\
-	present: 0,		/* number of 7xxx's present   */\
-	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
+	can_queue: AHC_MAX_QUEUE,/* max simultaneous cmds     */\
+	this_id: -1,		 /* scsi id of host adapter   */\
+	sg_tablesize: AHC_NSEG,	 /* max scatter-gather cmds   */\
+	cmd_per_lun: 2,		 /* cmds per lun	      */\
+	present: 0,		 /* number of 7xxx's present  */\
+	unchecked_isa_dma: 0,	 /* no memory DMA restrictions*/\
 	use_clustering: ENABLE_CLUSTERING,			\
 	highmem_io: 1						\
 }
===== drivers/scsi/aic7xxx/aic7xxx_osm.h 1.9 vs edited =====
--- 1.9/drivers/scsi/aic7xxx/aic7xxx_osm.h	Wed Feb  6 00:23:42 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_osm.h	Thu Oct 24 19:36:07 2002
@@ -18,7 +18,7 @@
  * along with this program; see the file COPYING.  If not, write to
  * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
  * 
- * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_linux.h#72 $
+ * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_osm.h#82 $
  *
  * Copyright (c) 2000-2001 Adaptec Inc.
  * All rights reserved.
@@ -55,7 +55,7 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_linux.h#72 $
+ * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_osm.h#82 $
  *
  */
 #ifndef _AIC7XXX_LINUX_H_
@@ -66,9 +66,11 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
-#include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/version.h>
+#ifndef AHC_MODVERSION_FILE
+#define __NO_VERSION__
+#endif
 #include <linux/module.h>
 #include <asm/byteorder.h>
 
@@ -77,7 +79,11 @@
 #endif
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+#include <linux/interrupt.h> /* For tasklet support. */
 #include <linux/config.h>
+#include <linux/slab.h>
+#else
+#include <linux/malloc.h>
 #endif
 
 /* Core SCSI definitions */
@@ -403,7 +409,7 @@
 #include <linux/smp.h>
 #endif
 
-#define AIC7XXX_DRIVER_VERSION  "6.2.4"
+#define AIC7XXX_DRIVER_VERSION  "6.2.8"
 
 /**************************** Front End Queues ********************************/
 /*
@@ -462,7 +468,7 @@
 	 * The number of transactions currently
 	 * queued to the device.
 	 */
-	int		active;
+	int			active;
 
 	/*
 	 * The currently allowed number of 
@@ -472,18 +478,18 @@
 	 * mode where the device may have more
 	 * than one outstanding active transaction.
 	 */
-	int		openings;
+	int			openings;
 
 	/*
 	 * A positive count indicates that this
 	 * device's queue is halted.
 	 */
-	u_int		qfrozen;
+	u_int			qfrozen;
 	
 	/*
 	 * Cumulative command counter.
 	 */
-	u_long		commands_issued;
+	u_long			commands_issued;
 
 	/*
 	 * The number of tagged transactions when
@@ -491,21 +497,26 @@
 	 * that have been successfully received by
 	 * this device since the last QUEUE FULL.
 	 */
-	u_int		tag_success_count;
+	u_int			tag_success_count;
 #define AHC_TAG_SUCCESS_INTERVAL 50
 
-	ahc_dev_flags	flags;
+	ahc_dev_flags		flags;
+
+	/*
+	 * Per device timer.
+	 */
+	struct timer_list	timer;
 
 	/*
 	 * The high limit for the tags variable.
 	 */
-	u_int		maxtags;
+	u_int			maxtags;
 
 	/*
 	 * The computed number of tags outstanding
 	 * at the time of the last QUEUE FULL event.
 	 */
-	u_int		tags_on_last_queuefull;
+	u_int			tags_on_last_queuefull;
 
 	/*
 	 * How many times we have seen a queue full
@@ -513,7 +524,7 @@
 	 * to stop our adaptive queue depth algorithm
 	 * on devices with a fixed number of tags.
 	 */
-	u_int		last_queuefull_same_count;
+	u_int			last_queuefull_same_count;
 #define AHC_LOCK_TAGS_COUNT 50
 
 	/*
@@ -525,11 +536,11 @@
 	 * if the AHC_DEV_PERIODIC_OTAG flag is set
 	 * on this device.
 	 */
-	u_int		commands_since_idle_or_otag;
+	u_int			commands_since_idle_or_otag;
 #define AHC_OTAG_THRESH	500
 
-	int		lun;
-	struct		ahc_linux_target *target;
+	int			lun;
+	struct			ahc_linux_target *target;
 };
 
 struct ahc_linux_target {
@@ -538,6 +549,7 @@
 	int	target;
 	int	refcount;
 	struct	ahc_transinfo last_tinfo;
+	struct	ahc_softc *ahc;
 };
 
 /********************* Definitions Required by the Core ***********************/
@@ -554,6 +566,7 @@
  */
 struct scb_platform_data {
 	struct ahc_linux_device	*dev;
+	bus_addr_t		 buf_busaddr;
 	uint32_t		 xfer_len;
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
 	uint32_t		 resid;		/* Transfer residual */
@@ -575,10 +588,14 @@
 	TAILQ_HEAD(, ahc_linux_device) device_runq;
 	struct ahc_completeq	 completeq;
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+	struct tasklet_struct	 runq_tasklet;
+#endif
 	u_int			 qfrozen;
 	struct timer_list	 reset_timer;
 	struct semaphore	 eh_sem;
 	struct Scsi_Host        *host;		/* pointer to scsi host */
+#define AHC_LINUX_NOIRQ	((uint32_t)~0)
 	uint32_t		 irq;		/* IRQ for this adapter */
 	uint32_t		 bios_address;
 	uint32_t		 mem_busaddr;	/* Mem Base Addr */
@@ -709,6 +726,12 @@
 static __inline void ahc_done_lock(struct ahc_softc *, unsigned long *flags);
 static __inline void ahc_done_unlock(struct ahc_softc *, unsigned long *flags);
 
+/* Lock held during ahc_list manipulation and ahc softc frees */
+extern spinlock_t ahc_list_spinlock;
+static __inline void ahc_list_lockinit(void);
+static __inline void ahc_list_lock(unsigned long *flags);
+static __inline void ahc_list_unlock(unsigned long *flags);
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,93)
 static __inline void
 ahc_lockinit(struct ahc_softc *ahc)
@@ -752,6 +775,25 @@
 	spin_unlock_irqrestore(host->host_lock, *flags);
 }
 
+static __inline void
+ahc_list_lockinit()
+{
+	spin_lock_init(&ahc_list_spinlock);
+}
+
+static __inline void
+ahc_list_lock(unsigned long *flags)
+{
+	*flags = 0;
+	spin_lock_irqsave(&ahc_list_spinlock, *flags);
+}
+
+static __inline void
+ahc_list_unlock(unsigned long *flags)
+{
+	spin_unlock_irqrestore(&ahc_list_spinlock, *flags);
+}
+
 #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0) */
 
 ahc_lockinit(struct ahc_softc *ahc)
@@ -772,6 +814,7 @@
 	restore_flags(*flags);
 }
 
+static __inline void
 ahc_done_lockinit(struct ahc_softc *ahc)
 {
 }
@@ -790,6 +833,25 @@
 ahc_done_unlock(struct ahc_softc *ahc, unsigned long *flags)
 {
 }
+
+static __inline void
+ahc_list_lockinit()
+{
+}
+
+static __inline void
+ahc_list_lock(unsigned long *flags)
+{
+	*flags = 0;
+	save_flags(*flags);
+	cli();
+}
+
+static __inline void
+ahc_list_unlock(unsigned long *flags)
+{
+	restore_flags(*flags);
+}
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0) */
 
 /******************************* PCI Definitions ******************************/
@@ -844,7 +906,8 @@
 			    ahc_power_state new_state);
 /**************************** VL/EISA Routines ********************************/
 int			 aic7770_linux_probe(Scsi_Host_Template *);
-int			 aic7770_map_registers(struct ahc_softc *ahc);
+int			 aic7770_map_registers(struct ahc_softc *ahc,
+					       u_int port);
 int			 aic7770_map_int(struct ahc_softc *ahc, u_int irq);
 
 /******************************* PCI Routines *********************************/
===== drivers/scsi/aic7xxx/aic7xxx_linux.c 1.22 vs edited =====
--- 1.22/drivers/scsi/aic7xxx/aic7xxx_linux.c	Wed Oct 16 02:00:05 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_linux.c	Thu Oct 24 19:47:33 2002
@@ -1,7 +1,7 @@
 /*
  * Adaptec AIC7xxx device driver for Linux.
  *
- * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_linux.c#79 $
+ * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c#103 $
  *
  * Copyright (c) 1994 John Aycock
  *   The University of Calgary Department of Computer Science.
@@ -119,6 +119,12 @@
  *
  */
 
+/*
+ * This is the only file where module.h should
+ * embed module global version info.
+ */
+#define AHC_MODVERSION_FILE
+
 #include "aic7xxx_osm.h"
 #include "aic7xxx_inline.h"
 
@@ -129,9 +135,16 @@
 #include "../sd.h"		/* For geometry detection */
 
 #include <linux/mm.h>		/* For fetching system memory size */
-#include <linux/blk.h>
+#include <linux/blk.h>		/* For block_size() */
 #include <scsi/scsicam.h>
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0)
+/*
+ * Lock protecting manipulation of the ahc softc list.
+ */
+spinlock_t ahc_list_spinlock;
+#endif
+
 /*
  * To generate the correct addresses for the controller to issue
  * on the bus.  Originally added for DEC Alpha support.
@@ -349,7 +362,14 @@
  * os compiled with PCI support disabled, then setting this to non-0
  * would result in never finding any devices :)
  */
-int aic7xxx_no_probe;
+#ifndef CONFIG_AIC7XXX_PROBE_EISA_VL
+#define CONFIG_AIC7XXX_PROBE_EISA_VL n
+#endif
+#if CONFIG_AIC7XXX_PROBE_EISA_VL == n
+static int aic7xxx_no_probe = 1;
+#else
+static int aic7xxx_no_probe;
+#endif
 
 /*
  * aic7xxx_detect() has been run, so register all device arrivals
@@ -428,9 +448,12 @@
 static void ahc_linux_sem_timeout(u_long arg);
 static void ahc_linux_freeze_sim_queue(struct ahc_softc *ahc);
 static void ahc_linux_release_sim_queue(u_long arg);
+static void ahc_linux_dev_timed_unfreeze(u_long arg);
 static int  ahc_linux_queue_recovery_cmd(Scsi_Cmnd *cmd, scb_flag flag);
 static void ahc_linux_initialize_scsi_bus(struct ahc_softc *ahc);
 static int  ahc_linux_slave_attach(Scsi_Device *device);
+static u_int ahc_linux_user_tagdepth(struct ahc_softc *ahc,
+				     struct ahc_devinfo *devinfo);
 static void ahc_linux_device_queue_depth(struct ahc_softc *ahc,
 					 Scsi_Device *device);
 static struct ahc_linux_target*	ahc_linux_alloc_target(struct ahc_softc*,
@@ -446,6 +469,7 @@
 				       struct ahc_linux_device*);
 static void ahc_linux_setup_tag_info(char *p, char *end, char *s);
 static int ahc_linux_next_unit(void);
+static void ahc_runq_tasklet(unsigned long data);
 static int ahc_linux_halt(struct notifier_block *nb, u_long event, void *buf);
 
 static __inline struct ahc_linux_device*
@@ -457,6 +481,9 @@
 						  struct ahc_cmd *acmd);
 static __inline void ahc_linux_check_device_queue(struct ahc_softc *ahc,
 						  struct ahc_linux_device *dev);
+static __inline struct ahc_linux_device *
+		     ahc_linux_next_device_to_run(struct ahc_softc *ahc);
+static __inline void ahc_linux_run_device_queues(struct ahc_softc *ahc);
 static __inline void ahc_linux_sniff_command(struct ahc_softc*, Scsi_Cmnd*,
 					     struct scb*);
 static __inline void ahc_linux_unmap_scb(struct ahc_softc*, struct scb*);
@@ -566,14 +593,22 @@
 	ahc_linux_run_device_queue(ahc, dev);
 }
 
+static __inline struct ahc_linux_device *
+ahc_linux_next_device_to_run(struct ahc_softc *ahc)
+{
+	
+	if ((ahc->flags & AHC_RESOURCE_SHORTAGE) != 0
+	 || ahc->platform_data->qfrozen != 0)
+		return (NULL);
+	return (TAILQ_FIRST(&ahc->platform_data->device_runq));
+}
+
 static __inline void
 ahc_linux_run_device_queues(struct ahc_softc *ahc)
 {
 	struct ahc_linux_device *dev;
 
-	while ((ahc->flags & AHC_RESOURCE_SHORTAGE) == 0
-	    && ahc->platform_data->qfrozen == 0
-	    && (dev = TAILQ_FIRST(&ahc->platform_data->device_runq)) != NULL) {
+	while ((dev = ahc_linux_next_device_to_run(ahc)) != NULL) {
 		TAILQ_REMOVE(&ahc->platform_data->device_runq, dev, links);
 		dev->flags &= ~AHC_DEV_ON_RUN_LIST;
 		ahc_linux_check_device_queue(ahc, dev);
@@ -607,13 +642,8 @@
 		pci_unmap_sg(ahc->dev_softc, sg, cmd->use_sg,
 			     scsi_to_pci_dma_dir(cmd->sc_data_direction));
 	} else if (cmd->request_bufflen != 0) {
-		u_int32_t high_addr;
-
-		high_addr = ahc_le32toh(scb->sg_list[0].len)
-			  & AHC_SG_HIGH_ADDR_MASK;
 		pci_unmap_single(ahc->dev_softc,
-				 ahc_le32toh(scb->sg_list[0].addr)
-			        | (((dma_addr_t)high_addr) << 8),
+				 scb->platform_data->buf_busaddr,
 				 cmd->request_bufflen,
 				 scsi_to_pci_dma_dir(cmd->sc_data_direction));
 	}
@@ -661,6 +691,29 @@
 	return (consumed);
 }
 
+/**************************** Tasklet Handler *********************************/
+
+static void
+ahc_runq_tasklet(unsigned long data)
+{
+	struct ahc_softc* ahc;
+	struct ahc_linux_device *dev;
+	u_long flags;
+
+	ahc = (struct ahc_softc *)data;
+	ahc_lock(ahc, &flags);
+	while ((dev = ahc_linux_next_device_to_run(ahc)) != NULL) {
+	
+		TAILQ_REMOVE(&ahc->platform_data->device_runq, dev, links);
+		dev->flags &= ~AHC_DEV_ON_RUN_LIST;
+		ahc_linux_check_device_queue(ahc, dev);
+		/* Yeild to our interrupt handler */
+		ahc_unlock(ahc, &flags);
+		ahc_lock(ahc, &flags);
+	}
+	ahc_unlock(ahc, &flags);
+}
+
 /************************ Shutdown/halt/reboot hook ***************************/
 #include <linux/notifier.h>
 #include <linux/reboot.h>
@@ -739,20 +792,23 @@
 	 * address).  For this reason, we have to reset
 	 * our dma mask when doing allocations.
 	 */
-	if(ahc->dev_softc)
+	if (ahc->dev_softc != NULL) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,3)
 		pci_set_dma_mask(ahc->dev_softc, 0xFFFFFFFF);
 #else
 		ahc->dev_softc->dma_mask = 0xFFFFFFFF;
 #endif
+	}
 	*vaddr = pci_alloc_consistent(ahc->dev_softc,
 				      dmat->maxsize, &map->bus_addr);
-	if (ahc->dev_softc)
+	if (ahc->dev_softc != NULL) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,3)
-		pci_set_dma_mask(ahc->dev_softc, ahc->platform_data->hw_dma_mask);
+		pci_set_dma_mask(ahc->dev_softc,
+				 ahc->platform_data->hw_dma_mask);
 #else
 		ahc->dev_softc->dma_mask = ahc->platform_data->hw_dma_mask;
 #endif
+	}
 #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) */
 	/*
 	 * At least in 2.2.14, malloc is a slab allocator so all
@@ -1038,7 +1094,6 @@
 			break;
 		}
 	}
-	register_reboot_notifier(&ahc_linux_notifier);
 	return 1;
 }
 
@@ -1087,7 +1142,21 @@
 #else
 	template->proc_dir = &proc_scsi_aic7xxx;
 #endif
-	template->sg_tablesize = AHC_NSEG;
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,7)
+	/*
+	 * We can only map 16MB per-SG
+	 * so create a sector limit of
+	 * "16MB" in 2K sectors.
+	 */
+	template->max_sectors = 8192;
+#endif
+
+	/*
+	 * Initialize our softc list lock prior to
+	 * probing for any adapters.
+	 */
+	ahc_list_lockinit();
 
 #ifdef CONFIG_PCI
 	ahc_linux_pci_probe(template);
@@ -1100,6 +1169,7 @@
 	 * Register with the SCSI layer all
 	 * controllers we've found.
 	 */
+	//ahc_lock(ahc);
 	found = 0;
 	TAILQ_FOREACH(ahc, &ahc_tailq, links) {
 
@@ -1271,6 +1341,7 @@
 	memset(ahc->platform_data, 0, sizeof(struct ahc_platform_data));
 	TAILQ_INIT(&ahc->platform_data->completeq);
 	TAILQ_INIT(&ahc->platform_data->device_runq);
+	ahc->platform_data->irq = AHC_LINUX_NOIRQ;
 	ahc->platform_data->hw_dma_mask = 0xFFFFFFFF;
 	/*
 	 * ahc_lockinit done by scsi_register, as we don't own that lock
@@ -1281,8 +1352,14 @@
 #else
 	ahc->platform_data->eh_sem = MUTEX_LOCKED;
 #endif
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+	tasklet_init(&ahc->platform_data->runq_tasklet, ahc_runq_tasklet,
+		     (unsigned long)ahc);
+#endif
 	ahc->seltime = (aic7xxx_seltime & 0x3) << 4;
 	ahc->seltime_b = (aic7xxx_seltime & 0x3) << 4;
+	if (TAILQ_EMPTY(&ahc_tailq))
+		register_reboot_notifier(&ahc_linux_notifier);
 	return (0);
 }
 
@@ -1290,9 +1367,12 @@
 ahc_platform_free(struct ahc_softc *ahc)
 {
 	if (ahc->platform_data != NULL) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+		tasklet_kill(&ahc->platform_data->runq_tasklet);
+#endif
 		if (ahc->platform_data->host != NULL)
 			scsi_unregister(ahc->platform_data->host);
-		if (ahc->platform_data->irq)
+		if (ahc->platform_data->irq != AHC_LINUX_NOIRQ)
 			free_irq(ahc->platform_data->irq, ahc);
 		if (ahc->tag == BUS_SPACE_PIO
 		 && ahc->bsh.ioport != 0)
@@ -1316,6 +1396,14 @@
 #endif
 		free(ahc->platform_data, M_DEVBUF);
 	}
+	if (TAILQ_EMPTY(&ahc_tailq)) {
+		unregister_reboot_notifier(&ahc_linux_notifier);
+#ifdef CONFIG_PCI
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+		pci_unregister_driver(&aic7xxx_pci_driver);
+#endif
+#endif
+	}
 }
 
 void
@@ -1351,14 +1439,16 @@
 
 	dev->flags &= ~(AHC_DEV_Q_BASIC|AHC_DEV_Q_TAGGED|AHC_DEV_PERIODIC_OTAG);
 	if (now_queuing) {
+		u_int usertags;
 
+		usertags = ahc_linux_user_tagdepth(ahc, devinfo);
 		if (!was_queuing) {
 			/*
 			 * Start out agressively and allow our
 			 * dynamic queue depth algorithm to take
 			 * care of the rest.
 			 */
-			dev->maxtags = AHC_MAX_QUEUE;
+			dev->maxtags = usertags;
 			dev->openings = dev->maxtags - dev->active;
 		}
 		if (alg == AHC_QUEUE_TAGGED) {
@@ -1368,7 +1458,7 @@
 		} else
 			dev->flags |= AHC_DEV_Q_BASIC;
 	} else {
-		/* We can only have one opening */
+		/* We can only have one opening. */
 		dev->maxtags = 0;
 		dev->openings =  1 - dev->active;
 	}
@@ -1408,12 +1498,14 @@
 		clun = lun;
 		maxlun = clun + 1;
 	} else {
-		maxlun = 16;
+		maxlun = AHC_NUM_LUNS;
 	}
 
 	count = 0;
 	for (; chan < maxchan; chan++) {
+
 		for (; targ < maxtarg; targ++) {
+
 			for (; clun < maxlun; clun++) {
 				struct ahc_linux_device *dev;
 				struct ahc_busyq *busyq;
@@ -1460,30 +1552,16 @@
 	return 0;
 }
 
-/*
- * Determines the queue depth for a given device.
- */
-static void
-ahc_linux_device_queue_depth(struct ahc_softc *ahc, Scsi_Device * device)
+static u_int
+ahc_linux_user_tagdepth(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 {
-	struct	ahc_devinfo devinfo;
-	struct	ahc_initiator_tinfo *targ_info;
-	struct	ahc_tmode_tstate *tstate;
-	uint8_t tags;
-
-	ahc_compile_devinfo(&devinfo,
-			    device->channel == 0 ? ahc->our_id : ahc->our_id_b,
-			    device->id, device->lun,
-			    device->channel == 0 ? 'A' : 'B',
-			    ROLE_INITIATOR);
-	targ_info = ahc_fetch_transinfo(ahc, devinfo.channel,
-					devinfo.our_scsiid,
-					devinfo.target, &tstate);
+	static int warned_user;
+	u_int tags;
 
 	tags = 0;
-	if (device->tagged_supported != 0
-	 && (ahc->user_discenable & devinfo.target_mask) != 0) {
-		if (ahc->unit >= NUM_ELEMENTS(aic7xxx_tag_info)) {
+	if ((ahc->user_discenable & devinfo->target_mask) != 0) {
+		if (warned_user == 0
+		 && ahc->unit >= NUM_ELEMENTS(aic7xxx_tag_info)) {
 
 			printf("aic7xxx: WARNING, insufficient "
 			       "tag_info instances for installed "
@@ -1492,22 +1570,42 @@
 			       "aic7xxx_tag_info array in the "
 			       "aic7xxx.c source file.\n");
 			tags = AHC_MAX_QUEUE;
+			warned_user++;
 		} else {
 			adapter_tag_info_t *tag_info;
 
 			tag_info = &aic7xxx_tag_info[ahc->unit];
-			tags = tag_info->tag_commands[devinfo.target_offset];
+			tags = tag_info->tag_commands[devinfo->target_offset];
 			if (tags > AHC_MAX_QUEUE)
 				tags = AHC_MAX_QUEUE;
 		}
 	}
-	if (tags != 0) {
+	return (tags);
+}
+
+/*
+ * Determines the queue depth for a given device.
+ */
+static void
+ahc_linux_device_queue_depth(struct ahc_softc *ahc, Scsi_Device * device)
+{
+	struct	ahc_devinfo devinfo;
+	u_int	tags;
+
+	ahc_compile_devinfo(&devinfo,
+			    device->channel == 0 ? ahc->our_id : ahc->our_id_b,
+			    device->id, device->lun,
+			    device->channel == 0 ? 'A' : 'B',
+			    ROLE_INITIATOR);
+	tags = ahc_linux_user_tagdepth(ahc, &devinfo);
+	if (tags != 0
+	 && device->tagged_supported != 0) {
+
 		scsi_adjust_queue_depth(device, MSG_ORDERED_TAG, tags);
-		/* device->queue_depth = tags; */
 		ahc_set_tags(ahc, &devinfo, AHC_QUEUE_TAGGED);
 		printf("scsi%d:%c:%d:%d: Tagged Queuing enabled.  Depth %d\n",
-	       	       ahc->platform_data->host->host_no, device->channel + 'A',
-		       device->id, device->lun, tags);
+	       	       ahc->platform_data->host->host_no, devinfo.channel,
+		       devinfo.target, devinfo.lun, tags);
 	} else {
 		/*
 		 * We allow the OS to queue 2 untagged transactions to
@@ -1639,6 +1737,7 @@
 		scb->platform_data->xfer_len = 0;
 		ahc_set_residual(scb, 0);
 		ahc_set_sense_residual(scb, 0);
+		scb->sg_count = 0;
 		if (cmd->use_sg != 0) {
 			struct	ahc_dma_seg *sg;
 			struct	scatterlist *cur_seg;
@@ -1655,8 +1754,7 @@
 			 * The sg_count may be larger than nseg if
 			 * a transfer crosses a 32bit page.
 			 */ 
-			scb->sg_count = 0;
-			while(cur_seg < end_seg) {
+			while (cur_seg < end_seg) {
 				bus_addr_t addr;
 				bus_size_t len;
 				int consumed;
@@ -1694,6 +1792,7 @@
 			       cmd->request_bufflen,
 			       scsi_to_pci_dma_dir(cmd->sc_data_direction));
 			scb->sg_count = 0;
+			scb->platform_data->buf_busaddr = addr;
 			scb->sg_count = ahc_linux_map_seg(ahc, scb,
 							  sg, addr,
 							  cmd->request_bufflen);
@@ -1755,9 +1854,10 @@
 void
 ahc_linux_isr(int irq, void *dev_id, struct pt_regs * regs)
 {
-	struct ahc_softc *ahc;
-	struct ahc_cmd *acmd;
-	u_long flags;
+	struct	ahc_softc *ahc;
+	struct	ahc_cmd *acmd;
+	u_long	flags;
+	struct	ahc_linux_device *next_dev;
 
 	ahc = (struct ahc_softc *) dev_id;
 	if (!ahc->platform_data->host) {
@@ -1766,16 +1866,17 @@
 	}
 	ahc_lock(ahc, &flags); 
 	ahc_intr(ahc);
-	/*
-	 * It would be nice to run the device queues from a
-	 * bottom half handler, but as there is no way to
-	 * dynamically register one, we'll have to postpone
-	 * that until we get integrated into the kernel.
-	 */
-	ahc_linux_run_device_queues(ahc);
 	acmd = TAILQ_FIRST(&ahc->platform_data->completeq);
 	TAILQ_INIT(&ahc->platform_data->completeq);
+	next_dev = ahc_linux_next_device_to_run(ahc);
 	ahc_unlock(ahc, &flags);
+	if (next_dev) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+		tasklet_schedule(&ahc->platform_data->runq_tasklet);
+#else
+		ahc_runq_tasklet((unsigned long)ahc);
+#endif
+	}
 	if (acmd != NULL)
 		ahc_linux_run_complete_queue(ahc, acmd);
 }
@@ -1803,6 +1904,7 @@
 	memset(targ, 0, sizeof(*targ));
 	targ->channel = channel;
 	targ->target = target;
+	targ->ahc = ahc;
 	target_offset = target;
 	if (channel != 0)
 		target_offset += 8;
@@ -1832,6 +1934,7 @@
 	if (dev == NULL)
 		return (NULL);
 	memset(dev, 0, sizeof(*dev));
+	init_timer(&dev->timer);
 	TAILQ_INIT(&dev->busyq);
 	dev->flags = AHC_DEV_UNCONFIGURED;
 	dev->lun = lun;
@@ -1860,6 +1963,7 @@
 {
 	struct ahc_linux_target *targ;
 
+	del_timer(&dev->timer);
 	targ = dev->target;
 	targ->devices[dev->lun] = NULL;
 	free(dev, M_DEVBUF);
@@ -1938,8 +2042,9 @@
 		if (channel == 'B')
 			target_offset += 8;
 		targ = ahc->platform_data->targets[target_offset];
-		if (targ != NULL
-		 && tinfo->curr.period == targ->last_tinfo.period
+		if (targ == NULL)
+			break;
+		if (tinfo->curr.period == targ->last_tinfo.period
 		 && tinfo->curr.width == targ->last_tinfo.width
 		 && tinfo->curr.offset == targ->last_tinfo.offset
 		 && tinfo->curr.ppr_options == targ->last_tinfo.ppr_options)
@@ -2160,14 +2265,27 @@
 		/* FALLTHROUGH */
 	}
 	case SCSI_STATUS_BUSY:
+	{
 		/*
-		 * XXX Set a timer and handle ourselves????
-		 * For now we pray that the mid-layer does something
-		 * sane for devices that are busy.
+		 * Set a short timer to defer sending commands for
+		 * a bit since Linux will not delay in this case.
 		 */
-		ahc_set_scsi_status(scb, SCSI_STATUS_BUSY);
+		if ((dev->flags & AHC_DEV_TIMER_ACTIVE) != 0) {
+			printf("%s:%c:%d: Device Timer still active during "
+			       "busy processing\n", ahc_name(ahc),
+				dev->target->channel, dev->target->target);
+			break;
+		}
+		dev->flags |= AHC_DEV_TIMER_ACTIVE;
+		dev->qfrozen++;
+		init_timer(&dev->timer);
+		dev->timer.data = (u_long)dev;
+		dev->timer.expires = jiffies + (HZ/2);
+		dev->timer.function = ahc_linux_dev_timed_unfreeze;
+		add_timer(&dev->timer);
 		break;
 	}
+	}
 }
 
 static void
@@ -2179,7 +2297,10 @@
 		struct	ahc_devinfo devinfo;
 		struct	scsi_inquiry *inq;
 		struct	scsi_inquiry_data *sid;
-		struct	ahc_initiator_tinfo *targ_info;
+		struct	ahc_initiator_tinfo *tinfo;
+		struct	ahc_transinfo *user;
+		struct	ahc_transinfo *goal;
+		struct	ahc_transinfo *curr;
 		struct	ahc_tmode_tstate *tstate;
 		struct	ahc_syncrate *syncrate;
 		struct	ahc_linux_device *dev;
@@ -2239,27 +2360,28 @@
 				    cmd->target, cmd->lun,
 				    SCSIID_CHANNEL(ahc, scsiid),
 				    ROLE_INITIATOR);
-		targ_info = ahc_fetch_transinfo(ahc, devinfo.channel,
-						devinfo.our_scsiid,
-						devinfo.target, &tstate);
-		width = targ_info->user.width;
-		period = targ_info->user.period;
-		offset = targ_info->user.offset;
-		ppr_options = targ_info->user.ppr_options;
+		tinfo = ahc_fetch_transinfo(ahc, devinfo.channel,
+					    devinfo.our_scsiid,
+					    devinfo.target, &tstate);
+		user = &tinfo->user;
+		goal = &tinfo->goal;
+		curr = &tinfo->curr;
+		width = user->width;
+		period = user->period;
+		offset = user->offset;
+		ppr_options = user->ppr_options;
 		minlen = offsetof(struct scsi_inquiry_data, version) + 1;
 		if (transferred_len >= minlen) {
-			targ_info->curr.protocol_version = SID_ANSI_REV(sid);
+			curr->protocol_version = SID_ANSI_REV(sid);
 
 			/*
 			 * Only attempt SPI3 once we've verified that
 			 * the device claims to support SPI3 features.
 			 */
-			if (targ_info->curr.protocol_version < SCSI_REV_2)
-				targ_info->curr.transport_version =
-				    SID_ANSI_REV(sid);
+			if (curr->protocol_version < SCSI_REV_2)
+				curr->transport_version = SID_ANSI_REV(sid);
 			else
-				targ_info->curr.transport_version =
-				     SCSI_REV_2;
+				curr->transport_version = SCSI_REV_2;
 		}
 
 		minlen = offsetof(struct scsi_inquiry_data, flags) + 1;
@@ -2279,23 +2401,26 @@
 		minlen = offsetof(struct scsi_inquiry_data, spi3data) + 1;
 		/*
 		 * This is a kludge to deal with inquiry requests that
-		 * are not large enough for us to pull the spi3 bits.
+		 * are not large enough for us to pull the spi3/4 bits.
 		 * In this case, we assume that a device that tells us
 		 * they can provide inquiry data that spans the SPI3
 		 * bits and says its SCSI3 can handle a PPR request.
 		 * If the inquiry request has sufficient buffer space to
-		 * cover these bits, we check them to see if any ppr options
-		 * are available.
+		 * cover SPI3 bits, we honor them regardless of reported
+		 * SCSI REV.  We also allow any device that has had its
+		 * goal ppr_options set to allow DT speeds to keep that
+		 * option if a short inquiry occurs that would fail the
+		 * normal tests outlined above.
 		 */
 		if ((sid->additional_length + 4) >= minlen) {
-			if (transferred_len >= minlen
-			 && (sid->spi3data & SID_SPI_CLOCK_DT) == 0)
+			if (transferred_len >= minlen) {
+				 if ((sid->spi3data & SID_SPI_CLOCK_DT) == 0)
+					ppr_options = 0;
+			} else if ((goal->ppr_options & MSG_EXT_PPR_DT_REQ)== 0)
 				ppr_options = 0;
 
-			if (targ_info->curr.protocol_version > SCSI_REV_2)
-				targ_info->curr.transport_version = 3;
-			else
-				ppr_options = 0;
+			if (curr->protocol_version > SCSI_REV_2)
+				curr->transport_version = 3;
 		} else {
 			ppr_options = 0;
 		}
@@ -2363,7 +2488,6 @@
 		ahc->platform_data->qfrozen--;
 	if (ahc->platform_data->qfrozen == 0) {
 		unblock_reqs = 1;
-		ahc_linux_run_device_queues(ahc);
 	}
 	ahc_unlock(ahc, &s);
 	/*
@@ -2372,8 +2496,33 @@
 	 * a bottom half handler to run the queues
 	 * so we can unblock with our own lock held.
 	 */
-	if (unblock_reqs)
+	if (unblock_reqs) {
 		scsi_unblock_requests(ahc->platform_data->host);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+		tasklet_schedule(&ahc->platform_data->runq_tasklet);
+#else
+		ahc_runq_tasklet((unsigned long)ahc);
+#endif
+	}
+}
+
+static void
+ahc_linux_dev_timed_unfreeze(u_long arg)
+{
+	struct ahc_linux_device *dev;
+	struct ahc_softc *ahc;
+	u_long s;
+
+	dev = (struct ahc_linux_device *)arg;
+	ahc = dev->target->ahc;
+	ahc_lock(ahc, &s);
+	dev->flags &= ~AHC_DEV_TIMER_ACTIVE;
+	if (dev->qfrozen > 0)
+		dev->qfrozen--;
+	if (dev->qfrozen == 0
+	 && (dev->flags & AHC_DEV_ON_RUN_LIST) == 0)
+		ahc_linux_run_device_queue(ahc, dev);
+	ahc_unlock(ahc, &s);
 }
 
 static int
@@ -2446,6 +2595,16 @@
 		}
 	}
 
+	if ((dev->flags & (AHC_DEV_Q_BASIC|AHC_DEV_Q_TAGGED)) == 0
+	 && ahc_search_untagged_queues(ahc, cmd, cmd->target,
+				       cmd->channel + 'A', cmd->lun,
+				       CAM_REQ_ABORTED, SEARCH_COMPLETE) != 0) {
+		printf("%s:%d:%d:%d: Command found on untagged queue\n",
+		       ahc_name(ahc), cmd->channel, cmd->target, cmd->lun);
+		retval = SUCCESS;
+		goto done;
+	}
+
 	/*
 	 * See if we can find a matching cmd in the pending list.
 	 */
@@ -2459,7 +2618,7 @@
 		/* Any SCB for this device will do for a target reset */
 		LIST_FOREACH(pending_scb, &ahc->pending_scbs, pending_links) {
 		  	if (ahc_match_scb(ahc, pending_scb, cmd->target,
-					  cmd->channel, CAM_LUN_WILDCARD,
+					  cmd->channel + 'A', CAM_LUN_WILDCARD,
 					  SCB_LIST_NULL, ROLE_INITIATOR) == 0)
 				break;
 		}
@@ -2481,18 +2640,23 @@
 
 	/*
 	 * Ensure that the card doesn't do anything
-	 * behind our back.  Also make sure that we
+	 * behind our back and that no selections have occurred
+	 * that have not been serviced.  Also make sure that we
 	 * didn't "just" miss an interrupt that would
 	 * affect this cmd.
 	 */
 	ahc->flags |= AHC_ALL_INTERRUPTS;
 	do {
+		if (paused)
+			ahc_unpause(ahc);
 		ahc_intr(ahc);
 		ahc_pause(ahc);
+		paused = TRUE;
+		ahc_outb(ahc, SCSISEQ, ahc_inb(ahc, SCSISEQ) & ~ENSELO);
 		ahc_clear_critical_section(ahc);
-	} while (ahc_inb(ahc, INTSTAT) & INT_PEND);
+	} while ((ahc_inb(ahc, INTSTAT) & INT_PEND) != 0
+	      || (ahc_inb(ahc, SSTAT0) & (SELDO|SELINGO)));
 	ahc->flags &= ~AHC_ALL_INTERRUPTS;
-	paused = TRUE;
 
 	ahc_dump_card_state(ahc);
 
@@ -2521,6 +2685,18 @@
 		disconnected = FALSE;
 	}
 
+	if (disconnected && (ahc_inb(ahc, SEQ_FLAGS) & IDENTIFY_SEEN) != 0) {
+		struct scb *bus_scb;
+
+		bus_scb = ahc_lookup_scb(ahc, ahc_inb(ahc, SCB_TAG));
+		if (bus_scb == pending_scb)
+			disconnected = FALSE;
+		else if (flag != SCB_ABORT
+		      && ahc_inb(ahc, SAVED_SCSIID) == pending_scb->hscb->scsiid
+		      && ahc_inb(ahc, SAVED_LUN) == pending_scb->hscb->lun)
+			disconnected = FALSE;
+	}
+
 	/*
 	 * At this point, pending_scb is the scb associated with the
 	 * passed in command.  That command is currently active on the
@@ -2648,12 +2824,12 @@
 		}
 		ahc_lock(ahc, &s);
 	}
-	ahc_linux_run_device_queues(ahc);
 	acmd = TAILQ_FIRST(&ahc->platform_data->completeq);
 	TAILQ_INIT(&ahc->platform_data->completeq);
 	ahc_unlock(ahc, &s);
 	if (acmd != NULL)
 		ahc_linux_run_complete_queue(ahc, acmd);
+	ahc_runq_tasklet((unsigned long)ahc);
 	ahc_lock(ahc, &s);
 	return (retval);
 }
@@ -2767,20 +2943,27 @@
 ahc_linux_release(struct Scsi_Host * host)
 {
 	struct ahc_softc *ahc;
+	u_long l;
 
+	ahc_list_lock(&l);
 	if (host != NULL) {
 
-		ahc = *(struct ahc_softc **)host->hostdata;
-		ahc_free(ahc);
-	}
-	if (TAILQ_EMPTY(&ahc_tailq)) {
-		unregister_reboot_notifier(&ahc_linux_notifier);
-#ifdef CONFIG_PCI
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-		pci_unregister_driver(&aic7xxx_pci_driver);
-#endif
-#endif
+		/*
+		 * We should be able to just perform
+		 * the free directly, but check our
+		 * list for extra sanity.
+		 */
+		ahc = ahc_find_softc(*(struct ahc_softc **)host->hostdata);
+		if (ahc != NULL) {
+			u_long s;
+
+			ahc_lock(ahc, &s);
+			ahc_intr_enable(ahc, FALSE);
+			ahc_unlock(ahc, &s);
+			ahc_free(ahc);
+		}
 	}
+	ahc_list_unlock(&l);
 	return (0);
 }
 
@@ -2798,7 +2981,9 @@
 	maxchannel = (ahc->features & AHC_TWIN) ? 1 : 0;
 	maxtarget = (ahc->features & AHC_WIDE) ? 15 : 7;
 	for (channel = 0; channel <= maxchannel; channel++) {
+
 		for (target = 0; target <=maxtarget; target++) {
+
 			for (lun = 0; lun < AHC_NUM_LUNS; lun++) {
 				struct ahc_cmd *acmd;
 
@@ -2812,7 +2997,7 @@
 				i = 0;
 				TAILQ_FOREACH(acmd, &dev->busyq,
 					      acmd_links.tqe) {
-					if (i++ > 256)
+					if (i++ > AHC_SCB_MAX)
 						break;
 				}
 				printf("%d waiting\n", i);

