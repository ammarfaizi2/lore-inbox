Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTFHXEb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 19:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTFHXEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 19:04:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25083 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261312AbTFHXEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 19:04:16 -0400
Date: Mon, 9 Jun 2003 01:17:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.70-mm6: isp driver cleanups
Message-ID: <20030608231750.GL16164@fs.tum.de>
References: <20030607151440.6982d8c6.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607151440.6982d8c6.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 03:14:40PM -0700, Andrew Morton wrote:
>...
> linux-isp.patch
> 
> isp-update-1.patch
>...

isp_linux.h already states kernels < 2.4 are not supported. The patch 
below removes #ifdef'd code for kernels < 2.4.

diffstat output:

 isp_linux.c |   42 ----------
 isp_linux.h |  100 +-----------------------
 isp_pci.c   |  248 ------------------------------------------------------------
 3 files changed, 6 insertions(+), 384 deletions(-)

I've tested the compilation with 2.5.70-mm6.

cu
Adrian

--- linux-2.5.70-mm6/drivers/scsi/isp/isp_linux.h.old	2003-06-09 01:07:27.000000000 +0200
+++ linux-2.5.70-mm6/drivers/scsi/isp/isp_linux.h	2003-06-09 00:58:53.000000000 +0200
@@ -39,35 +39,13 @@
 #ifndef _ISP_LINUX_H
 #define _ISP_LINUX_H
 
-#ifndef	ISP_MODULE
-#define	__NO_VERSION__
-#endif
-#ifdef	LINUX_ISP_TARGET_MODE
-#define	EXPORT_SYMTAB
-#endif
-
 #include <linux/version.h>
-#ifndef	KERNEL_VERSION
-#define KERNEL_VERSION(v,p,s)		(((v)<<16)+(p<<8)+s)
-#endif
-#define	_KVC	KERNEL_VERSION
-
-#if LINUX_VERSION_CODE <= _KVC(2,2,0)
-#error	"Linux 2.0 and 2.1 kernels are not supported anymore"
-#endif
-#if LINUX_VERSION_CODE >= _KVC(2,3,0) && LINUX_VERSION_CODE < _KVC(2,4,0)
-#error	"Linux 2.3 kernels are not supported"
-#endif
 
-#ifndef	UNUSED_PARAMETER
-#define	UNUSED_PARAMETER(x)	(void) x
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
+#error	"Linux 2.3 and earlier kernels are not supported"
 #endif
 
 #include <linux/autoconf.h>
-#ifdef	CONFIG_SMP
-#define	__SMP__	1
-#endif
-
 
 /*
  * Be nice and get ourselves out of the way of other drivers.
@@ -103,12 +81,8 @@
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 #include <linux/smp.h>
 #include <linux/spinlock.h>
-#else
-#include <asm/spinlock.h>
-#endif
 #include <asm/system.h>
 #include <asm/byteorder.h>
 #include <linux/interrupt.h>
@@ -141,15 +115,15 @@
 #undef	__pa
 #define	__pa(x)	x
 #endif
-#if defined (__i386__) && LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+#if defined (__i386__)
 #undef	__pa
 #define	__pa(x)	x
 #endif
-#if defined (__sparc__) && LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+#if defined (__sparc__)
 #undef	__pa
 #define	__pa(x)	x
 #endif
-#if defined (__alpha__) && LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+#if defined (__alpha__)
 #undef	__pa
 #define	__pa(x)	x
 #endif
@@ -180,11 +154,6 @@
 #define	BYTE_ORDER	LITTLE_ENDIAN
 #endif
 
-#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-#define	DMA_ADDR_T		unsigned long
-#define	QLA_SG_C(sg)		sg->length
-#define	QLA_SG_A(sg)		virt_to_bus(sg->address)
-#else
 #define	DMA_ADDR_T		dma_addr_t
 #define	QLA_SG_C(sg)		sg_dma_len(sg)
 #define	QLA_SG_A(sg)		sg_dma_address(sg)
@@ -195,7 +164,6 @@
 #define	DMA_HTYPE_T		dma_addr_t
 #define	QLA_HANDLE(cmd)		(cmd)->SCp.dma_handle
 #endif
-#endif
 
 #define	HANDLE_LOOPSTATE_IN_OUTER_LAYERS	1
 #ifdef	min
@@ -398,20 +366,6 @@
 #define	ISP_IUNLK_SOFTC			ISP_UNLK_SOFTC
 #define	ISP_IGET_LK_SOFTC		ISP_LOCK_SOFTC
 #define	ISP_DROP_LK_SOFTC		ISP_UNLK_SOFTC
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-#define	ISP_LOCK_SCSI_DONE(isp)		{				\
-		unsigned long _flags;					\
-		spin_lock_irqsave(&io_request_lock, _flags);		\
-		isp->iflags = _flags;					\
-	}
-#define	ISP_UNLK_SCSI_DONE(isp)		{				\
-		unsigned long _flags = isp->iflags;			\
-		spin_unlock_irqrestore(&io_request_lock, _flags);	\
-	}
-#else
-#define	ISP_LOCK_SCSI_DONE(isp)		do { } while(0)
-#define	ISP_UNLK_SCSI_DONE(isp)		do { } while(0)
-#endif
 #define	ISP_LOCKU_SOFTC			ISP_ILOCK_SOFTC
 #define	ISP_UNLKU_SOFTC			ISP_IUNLK_SOFTC
 #define	ISP_TLOCK_INIT(isp)		spin_lock_init(&isp->isp_osinfo.tlock)
@@ -448,13 +402,8 @@
 
 #define	ISP2100_SCRLEN		0x800
 
-#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-#define	MEMZERO			_isp_memzero
-#define	MEMCPY			_isp_memcpy
-#else
 #define	MEMZERO(b, a)		memset(b, 0, a)
 #define	MEMCPY			memcpy
-#endif
 #define	SNPRINTF		isp_snprintf
 #define	USEC_DELAY		_isp_usec_delay
 #define	USEC_SLEEP(isp, x)						\
@@ -476,11 +425,7 @@
   ((u_int64_t) ((((u_int64_t)(x)->tv_sec) * 1000000 + (x)->tv_usec)))
 #define	NANOTIME_SUB		_isp_microtime_sub
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-#define	MAXISPREQUEST(isp)	256
-#else
 #define	MAXISPREQUEST(isp)	((IS_FC(isp) || IS_ULTRA2(isp))? 1024 : 256)
-#endif
 
 #if	defined(__i386__)
 #define	MEMORYBARRIER(isp, type, offset, size)	barrier()
@@ -739,10 +684,6 @@
 int isp_drain_reset(struct ispsoftc *, char *);
 int isp_drain(struct ispsoftc *, char *);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-static INLINE void _isp_memcpy(void *, void *, size_t);
-static INLINE void _isp_memzero(void *,  size_t);
-#endif
 static INLINE u_int64_t _isp_microtime_sub(struct timeval *, struct timeval *);
 static INLINE void _isp_usec_delay(unsigned int);
 static INLINE unsigned long _usec_to_jiffies(unsigned int);
@@ -816,37 +757,6 @@
 #define	_SBSWAP(a, b, c)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-static INLINE void
-_isp_memcpy(void *to, void *from, size_t amt)
-{
-	unsigned char *x = to; unsigned char *y = from;
-	while (amt-- != 0) *x++ = *y++;
-}
-
-static INLINE void
-_isp_memzero(void *to, size_t amt)
-{
-	unsigned char *x = to;
-	while (amt-- != 0) *x++ = 0;
-}
-
-static INLINE unsigned long IspOrder(int);
-static INLINE unsigned long
-IspOrder(int nelem)
-{
-    unsigned long order, rsize;
-
-    order = 0;
-    rsize = PAGE_SIZE;
-    while (rsize < (unsigned long) ISP_QUEUE_SIZE(nelem)) {
-	order++;
-	rsize <<= 1;
-    }
-    return (order);
-}
-#endif
-
 static INLINE u_int64_t
 _isp_microtime_sub(struct timeval *b, struct timeval *a)
 {
--- linux-2.5.70-mm6/drivers/scsi/isp/isp_linux.c.old	2003-06-09 00:41:58.000000000 +0200
+++ linux-2.5.70-mm6/drivers/scsi/isp/isp_linux.c	2003-06-09 01:05:32.000000000 +0200
@@ -91,11 +91,6 @@
 static int isp_en_dis_lun(struct ispsoftc *, int, int, int, int);
 #endif
 
-#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,3,27)
-struct proc_dir_entry proc_scsi_qlc = {
-    PROC_SCSI_QLOGICISP, 3, "isp", S_IFDIR | S_IRUGO | S_IXUGO, 2
-};
-#endif
 static const char *class3_roles[4] = {
     "None", "Target", "Initiator", "Target/Initiator"
 };
@@ -404,11 +399,7 @@
 isplinux_detect(Scsi_Host_Template *tmpt)
 {
     int rval;
-#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-    tmpt->proc_dir = &proc_scsi_qlc;
-#else
     tmpt->proc_name = "isp";
-#endif
 #if	LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
     spin_unlock_irq(&io_request_lock);
     rval = isplinux_pci_detect(tmpt);
@@ -511,9 +502,7 @@
 	scsi_add_timer(Cmnd, Cmnd->timeout_per_command, Cmnd->done);
 	isp_prt(isp, ISP_LOGDEBUG0, "giving up on target %d", XS_TGT(Cmnd));
 	ISP_UNLK_SOFTC(isp);
-	ISP_LOCK_SCSI_DONE(isp);
 	(*Cmnd->scsi_done)(Cmnd);
-	ISP_UNLK_SCSI_DONE(isp);
 	ISP_LOCK_SOFTC(isp);
 	return;
     }
@@ -650,9 +639,7 @@
 	 * Add back a timer else scsi_done drops this on the floor.
 	 */
 	scsi_add_timer(Cmnd, Cmnd->timeout_per_command, Cmnd->done);
-	ISP_LOCK_SCSI_DONE(isp);
 	(*Cmnd->scsi_done)(Cmnd);
-	ISP_UNLK_SCSI_DONE(isp);
     } while ((Cmnd = Ncmnd) != NULL);
     ISP_LOCK_SOFTC(isp);
 }
@@ -2466,7 +2453,6 @@
     }
     ISP_IUNLK_SOFTC(isp);
     if (Cmnd) {
-	ISP_LOCK_SCSI_DONE(isp);
         while (Cmnd) {
 	    Scsi_Cmnd *f = (Scsi_Cmnd *) Cmnd->host_scribble;
 	    Cmnd->host_scribble = NULL;
@@ -2479,7 +2465,6 @@
 	    (*Cmnd->scsi_done)(Cmnd);
 	    Cmnd = f;
 	}
-	ISP_UNLK_SCSI_DONE(isp);
     }
 }
 
@@ -2532,7 +2517,6 @@
     ISP_IUNLK_SOFTC(isp);
 #endif
     if (Cmnd) {
-	ISP_LOCK_SCSI_DONE(isp);
         while (Cmnd) {
 	    Scsi_Cmnd *f = (Scsi_Cmnd *) Cmnd->host_scribble;
 	    Cmnd->host_scribble = NULL;
@@ -2545,7 +2529,6 @@
 	    (*Cmnd->scsi_done)(Cmnd);
 	    Cmnd = f;
 	}
-	ISP_UNLK_SCSI_DONE(isp);
     }
     return IRQ_HANDLED;
 }
@@ -2839,11 +2822,7 @@
     }
     isp->isp_state = ISP_RUNSTATE;
 
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
     isp->isp_osinfo.host->can_queue = isp->isp_maxcmds;
-#else
-    isp->isp_osinfo.host->can_queue = min(255, isp->isp_maxcmds);
-#endif
     if (isp->isp_osinfo.host->can_queue == 0)
 	isp->isp_osinfo.host->can_queue = 1;
 
@@ -2947,12 +2926,6 @@
     return (0);
 }
 
-#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-#define	ISP_THREAD_CAN_EXIT	isp->isp_host->loaded_as_module
-#else
-#define	ISP_THREAD_CAN_EXIT	0
-#endif
-
 static int
 isp_task_thread(void *arg)
 {
@@ -2964,11 +2937,7 @@
 
 #if	LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
     /* XXX: Not really sure why the 2.5.X changes do this */
-    if (ISP_THREAD_CAN_EXIT) {
-	siginitsetinv(&current->blocked, sigmask(SIGHUP));
-    } else {
-	siginitsetinv(&current->blocked, 0);
-    }
+    siginitsetinv(&current->blocked, 0);
     lock_kernel();
     daemonize();
     sprintf(current->comm, "isp_thrd%d", isp->isp_unit);
@@ -2988,10 +2957,6 @@
     while (exit_thread == 0) {
 	isp_prt(isp, ISP_LOGDEBUG1, "isp_task_thread sleeping");
 	down_interruptible(&thread_sleep_semaphore);
-	if (ISP_THREAD_CAN_EXIT) {
-	    if (signal_pending(current))
-		break;
-	}
 	isp_prt(isp, ISP_LOGDEBUG1, "isp_task_thread running");
 
 	spin_lock_irqsave(&isp->isp_osinfo.tlock, flags);
@@ -3063,9 +3028,6 @@
 		ISP_UNLKU_SOFTC(isp);
 		break;
 	    case ISP_THREAD_EXIT:
-		if (ISP_THREAD_CAN_EXIT) {
-		    exit_thread = 1;
-		}
 		break;
 	   default:
 		break;
@@ -3146,10 +3108,8 @@
 MODULE_PARM(isp_default_frame_size, "i");
 MODULE_PARM(isp_default_exec_throttle, "i");
 #endif
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0) || defined(MODULE)
 Scsi_Host_Template driver_template = QLOGICISP;
 #include "scsi_module.c"
-#endif
 /*
  * mode: c
  * Local variables:
--- linux-2.5.70-mm6/drivers/scsi/isp/isp_pci.c.old	2003-06-09 00:59:34.000000000 +0200
+++ linux-2.5.70-mm6/drivers/scsi/isp/isp_pci.c	2003-06-09 01:02:38.000000000 +0200
@@ -63,13 +63,8 @@
 static int
 isp_pci_dmasetup(struct ispsoftc *, XS_T *, ispreq_t *, u_int16_t *, u_int16_t);
 
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static void isp_pci_dmateardown(struct ispsoftc *, XS_T *, u_int16_t);
 #define	IS_HIGH_ISP_ADDR(addr)	(addr >= (u_int64_t) 0x100000000)
-#else
-#define	isp_pci_dmateardown	NULL
-#define	IS_HIGH_ISP_ADDR(addr)	0
-#endif
 
 #if	ISP_DAC_SUPPORTED == 1
 #define	ISP_A64			1
@@ -544,7 +539,6 @@
 	pcs->port = 0;
     }
     kfree(isp->isp_xflist);
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
     pci_free_consistent(pcs->pci_dev, RQUEST_QUEUE_LEN(isp) * QENTRY_LEN,
 	isp->isp_rquest, isp->isp_rquest_dma);
     pci_free_consistent(pcs->pci_dev, RESULT_QUEUE_LEN(isp) * QENTRY_LEN,
@@ -553,13 +547,6 @@
 	pci_free_consistent(pcs->pci_dev, ISP2100_SCRLEN,
 	    FCPARAM(isp)->isp_scratch, FCPARAM(isp)->isp_scdma);
     }
-#else
-    RlsPages(isp->isp_rquest, IspOrder(RQUEST_QUEUE_LEN(isp)));
-    RlsPages(isp->isp_result, IspOrder(RESULT_QUEUE_LEN(isp)));
-    if (IS_FC(isp) && FCPARAM(isp)->isp_scratch) {
-	RlsPages(FCPARAM(isp)->isp_scratch, 1);
-    }
-#endif
 #if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,18) && \
     	LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
     if (--isp_nfound <= 0) {
@@ -594,7 +581,6 @@
     vid = isp_pci->pci_dev->vendor;
     did = isp_pci->pci_dev->device;
 
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
     io_base = pci_resource_start(isp_pci->pci_dev, 0);
     if (pci_resource_flags(isp_pci->pci_dev, 0) & PCI_BASE_ADDRESS_MEM_TYPE_64)
 	irq = 2;
@@ -609,17 +595,6 @@
 	isp_pci_mapmem &= ~(1 << isp->isp_unit);
 #endif
     }
-#else	/* LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0) */
-    io_base = isp_pci->pci_dev->base_address[0];
-    mem_base = isp_pci->pci_dev->base_address[1];
-    if (mem_base & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-#if	BITS_PER_LONG == 64
-	mem_base |= isp_pci->pci_dev->base_address[2] << 32;
-#else
-	isp_pci_mapmem &= ~(1 << isp->isp_unit);
-#endif
-    }
-#endif	/* LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0) */
     irq = isp_pci->pci_dev->irq;
 
     if (vid != PCI_VENDOR_ID_QLOGIC) {
@@ -675,13 +650,11 @@
 	return (1);
     }
 
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
     if (pci_enable_device(isp_pci->pci_dev)) {
 	printk("%s: fails to be PCI_ENABLEd\n", loc);
 	return (1);
     }
     (void) PRDW(isp_pci, PCI_COMMAND, &cmd);
-#endif
 
     if ((cmd & PCI_CMD_ISP) != pci_cmd_isp) {
 	if (isp_debug & ISP_LOGINFO)
@@ -1165,7 +1138,6 @@
 	MEMZERO(isp->isp_xflist, amt);
     }
     if (isp->isp_rquest == NULL) {
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	struct isp_pcisoftc *pcs = (struct isp_pcisoftc *) isp;
 	dma_addr_t busaddr;
 	isp->isp_rquest =
@@ -1176,17 +1148,6 @@
 	    return (1);
 	}
 	isp->isp_rquest_dma = busaddr;
-#else
-	isp->isp_rquest = (caddr_t) GetPages(IspOrder(RQUEST_QUEUE_LEN(isp)));
-	if (isp->isp_rquest == NULL) {
-	    isp_prt(isp, ISP_LOGERR, "unable to allocate request queue");
-	    return (1);
-	}
-	/*
-	 * Map the Request queue.
-	 */
-	isp->isp_rquest_dma = virt_to_bus(isp->isp_rquest);
-#endif
 	if (isp->isp_rquest_dma & 0x3f) {
 	    isp_prt(isp, ISP_LOGERR, "Request Queue not on 64 byte boundary");
 	    return (1);
@@ -1195,7 +1156,6 @@
     }
 
     if (isp->isp_result == NULL) {
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	struct isp_pcisoftc *pcs = (struct isp_pcisoftc *) isp;
 	dma_addr_t busaddr;
 	isp->isp_result =
@@ -1206,19 +1166,6 @@
 	    return (1);
 	}
 	isp->isp_result_dma = busaddr;
-#else
-	isp->isp_result = (caddr_t) GetPages(IspOrder(RESULT_QUEUE_LEN(isp)));
-	if (isp->isp_result == NULL) {
-	    isp_prt(isp, ISP_LOGERR, "unable to allocate result queue");
-	    free_pages((unsigned long)isp->isp_rquest,
-		IspOrder(RQUEST_QUEUE_LEN(isp)));
-	    return (1);
-	}
-	/*
-	 * Map the result queue.
-	 */
-	isp->isp_result_dma = virt_to_bus(isp->isp_result);
-#endif
 	if (isp->isp_rquest_dma & 0x3f) {
 	    isp_prt(isp, ISP_LOGERR, "Result Queue not on 64 byte boundary");
 	    return (1);
@@ -1229,7 +1176,6 @@
     if (IS_FC(isp)) {
 	fcparam *fcp = isp->isp_param;
 	if (fcp->isp_scratch == NULL) {
-#if	LINUX_VERSION_CODE > KERNEL_VERSION(2,3,92)
 	    struct isp_pcisoftc *pcs = (struct isp_pcisoftc *) isp;
 	    dma_addr_t busaddr;
 	    fcp->isp_scratch =
@@ -1239,17 +1185,6 @@
 		return (1);
 	    }
 	    fcp->isp_scdma = busaddr;
-#else
-	   /*
-	    * Just get a page....
-	    */
-	    fcp->isp_scratch = (void *) GetPages(1);
-	    if (fcp->isp_scratch == NULL) {
-		isp_prt(isp, ISP_LOGERR, "unable to allocate scratch space");
-		return (1);
-	    }
-	    fcp->isp_scdma = virt_to_bus((void *)fcp->isp_scratch);
-#endif
 	    MEMZERO(fcp->isp_scratch, ISP2100_SCRLEN);
 	    if (fcp->isp_scdma & 0x7) {
 		isp_prt(isp, ISP_LOGERR, "scratch space not 8 byte aligned");
@@ -1325,7 +1260,6 @@
 	sg++;
     }
     sg = tcmd->cd_data;
-#if	 LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
     {
 	struct isp_pcisoftc *pcs = (struct isp_pcisoftc *) isp;
 	int new_seg_cnt;
@@ -1342,7 +1276,6 @@
 	    return (CMD_COMPLETE);
 	}
     }
-#endif
     nctios = nseg / ISP_RQDSEG;
     if (nseg % ISP_RQDSEG) {
 	nctios++;
@@ -1402,11 +1335,7 @@
 		 * Unlike normal initiator commands, we don't do
 		 * any swizzling here.
 		 */
-#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-		cto->ct_dataseg[seg].ds_base = virt_to_bus(sg->address);
-#else
 		cto->ct_dataseg[seg].ds_base = (u_int32_t) sg_dma_address(sg);
-#endif
 		cto->ct_dataseg[seg].ds_count = (u_int32_t) sg->length;
 		cto->ct_xfrlen += sg->length;
 		sg++;
@@ -1586,7 +1515,6 @@
 	sg++;
     }
     sg = tcmd->cd_data;
-#if	 LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
     {
 	struct isp_pcisoftc *pcs = (struct isp_pcisoftc *) isp;
 	int new_seg_cnt;
@@ -1603,7 +1531,6 @@
 	    return (CMD_COMPLETE);
 	}
     }
-#endif
     nctios = nseg / ISP_RQDSEG_T2;
     if (nseg % ISP_RQDSEG_T2) {
 	nctios++;
@@ -1675,12 +1602,8 @@
 		 * Unlike normal initiator commands, we don't do
 		 * any swizzling here.
 		 */
-#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-		cto->rsp.m0.ct_dataseg[seg].ds_base = virt_to_bus(sg->address);
-#else
 		cto->rsp.m0.ct_dataseg[seg].ds_base =
 		    (u_int32_t) sg_dma_address(sg);
-#endif
 		cto->rsp.m0.ct_dataseg[seg].ds_count = (u_int32_t) sg->length;
 		cto->rsp.m0.ct_xfrlen += sg->length;
 		sg++;
@@ -1818,7 +1741,6 @@
 }
 #endif
 
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 #define	FOURG_SEG(x)	(((u64) (x)) & 0xffffffff00000000ULL)
 
 static int
@@ -2171,176 +2093,6 @@
     }
 }
 
-#else
-
-static int
-isp_pci_dmasetup(struct ispsoftc *isp, Scsi_Cmnd *Cmnd, ispreq_t *rq,
-    u_int16_t *nxi, u_int16_t optr)
-{
-    struct scatterlist *sg;
-    DMA_ADDR_T one_shot_addr;
-    unsigned int one_shot_length;
-    int segcnt, seg, ovseg, seglim;
-    void *h;
-    u_int16_t nxti;
-
-#ifdef	LINUX_ISP_TARGET_MODE
-    if (rq->req_header.rqs_entry_type == RQSTYPE_CTIO ||
-        rq->req_header.rqs_entry_type == RQSTYPE_CTIO2) {
-	int s;
-	if (IS_SCSI(isp))
-	    s = tdma_mk(isp, (tmd_cmd_t *)Cmnd, (ct_entry_t *)rq, nxi, optr);
-	else
-	    s = tdma_mkfc(isp, (tmd_cmd_t *)Cmnd, (ct2_entry_t *)rq, nxi, optr);
-	return (s);
-   }
-#endif
-
-    nxti = *nxi;
-    h = (void *) ISP_QUEUE_ENTRY(isp->isp_rquest, isp->isp_reqidx);
-
-    if (Cmnd->request_bufflen == 0) {
-	rq->req_seg_count = 1;
-	goto mbxsync;
-    }
-
-    if (IS_FC(isp)) {
-	if (rq->req_header.rqs_entry_type == RQSTYPE_T3RQS)
-	    seglim = ISP_RQDSEG_T3;
-	else
-	    seglim = ISP_RQDSEG_T2;
-	((ispreqt2_t *)rq)->req_totalcnt = Cmnd->request_bufflen;
-	/*
-	 * Linux doesn't make it easy to tell which direction
-	 * the data is expected to go, and you really need to
-	 * know this for FC. We'll have to assume that some
-	 * of these commands that might be used for writes
-	 * our outbounds and all else are inbound.
-	 */
-	switch (Cmnd->cmnd[0]) {
-	case FORMAT_UNIT:
-	case WRITE_6:
-	case MODE_SELECT:
-	case SEND_DIAGNOSTIC:
-	case WRITE_10:
-	case WRITE_BUFFER:
-	case WRITE_LONG:
-	case WRITE_SAME:
-	case MODE_SELECT_10:
-	case WRITE_12:
-	case WRITE_VERIFY_12:
-	case SEND_VOLUME_TAG:
-	    ((ispreqt2_t *)rq)->req_flags |= REQFLAG_DATA_OUT;
-	    break;
-	default:
-	    ((ispreqt2_t *)rq)->req_flags |= REQFLAG_DATA_IN;
-	}
-    } else {
-	if (Cmnd->cmd_len > 12)
-	    seglim = 0;
-	else
-	    seglim = ISP_RQDSEG;
-	rq->req_flags |=  REQFLAG_DATA_OUT | REQFLAG_DATA_IN;
-    }
-
-    one_shot_addr = (DMA_ADDR_T) 0;
-    one_shot_length = 0;
-    if ((segcnt = Cmnd->use_sg) == 0) {
-	segcnt = 1;
-	sg = NULL;
-	one_shot_length = Cmnd->request_bufflen;
-	one_shot_addr = virt_to_bus(Cmnd->request_buffer);
-    } else {
-	sg = (struct scatterlist *) Cmnd->request_buffer;
-    }
-    if (segcnt == 0) {
-	isp_prt(isp, ISP_LOGWARN, "unable to dma map request");
-	XS_SETERR(Cmnd, HBA_BOTCH);
-	return (CMD_EAGAIN);
-    }
-
-    for (seg = 0, rq->req_seg_count = 0;
-	 seg < segcnt && rq->req_seg_count < seglim;
-	 seg++, rq->req_seg_count++) {
-	DMA_ADDR_T addr;
-	unsigned int length;
-
-	if (sg) {
-		length = QLA_SG_C(sg);
-		addr = QLA_SG_A(sg);
-		sg++;
-	} else {
-		length = one_shot_length;
-		addr = one_shot_addr;
-	}
-
-	if (rq->req_header.rqs_entry_type == RQSTYPE_T2RQS) {
-	    ispreqt2_t *rq2 = (ispreqt2_t *)rq;
-	    rq2->req_dataseg[rq2->req_seg_count].ds_count = length;
-	    rq2->req_dataseg[rq2->req_seg_count].ds_base = addr;
-	} else {
-	    rq->req_dataseg[rq->req_seg_count].ds_count = length;
-	    rq->req_dataseg[rq->req_seg_count].ds_base = addr;
-	}
-	isp_prt(isp, ISP_LOGDEBUG1, "seg0[%d]%llx:%u from %p", seg,
-	    (long long)addr, length, sg? sg->address : Cmnd->request_buffer);
-    }
-
-    if (seg == segcnt) {
-	goto mbxsync;
-    }
-
-    do {
-	int lim;
-	u_int16_t curip;
-	ispcontreq_t local, *crq = &local, *qep;
-
-	curip = nxti;
-	qep = (ispcontreq_t *) ISP_QUEUE_ENTRY(isp->isp_rquest, curip);
-	nxti = ISP_NXT_QENTRY((curip), RQUEST_QUEUE_LEN(isp));
-	if (nxti == optr) {
-	    isp_prt(isp, ISP_LOGDEBUG0, "out of space for continuations");
-	    XS_SETERR(Cmnd, HBA_BOTCH);
-	    return (CMD_EAGAIN);
-	}
-	rq->req_header.rqs_entry_count++;
-	MEMZERO((void *)crq, sizeof (*crq));
-	crq->req_header.rqs_entry_count = 1;
-	if (rq->req_header.rqs_entry_type == RQSTYPE_T3RQS) {
-	    lim = ISP_CDSEG64;
-	    crq->req_header.rqs_entry_type = RQSTYPE_A64_CONT;
-	} else {
-	    lim = ISP_CDSEG;
-	    crq->req_header.rqs_entry_type = RQSTYPE_DATASEG;
-	}
-
-	for (ovseg = 0; seg < segcnt && ovseg < lim;
-	     rq->req_seg_count++, seg++, ovseg++, sg++) {
-	    if (sg->length == 0) {
-		panic("zero length s-g element at line %d", __LINE__);
-	    }
-	    crq->req_dataseg[ovseg].ds_count = QLA_SG_C(sg);
-	    crq->req_dataseg[ovseg].ds_base = QLA_SG_A(sg);
-	    isp_prt(isp, ISP_LOGDEBUG1, "seg%d[%d]%llx:%u from %p",
-		rq->req_header.rqs_entry_count-1, ovseg,
-	    	(unsigned long long) QLA_SG_A(sg), QLA_SG_C(sg), sg->address);
-	}
-	MEMORYBARRIER(isp, SYNC_REQUEST, curip, QENTRY_LEN);
-	isp_put_cont_req(isp, crq, qep);
-    } while (seg < segcnt);
-mbxsync:
-    if (rq->req_header.rqs_entry_type == RQSTYPE_T3RQS) {
-	isp_put_request_t3(isp, (ispreqt3_t *) rq, (ispreqt3_t *) h);
-    } else if (rq->req_header.rqs_entry_type == RQSTYPE_T2RQS) {
-	isp_put_request_t2(isp, (ispreqt2_t *) rq, (ispreqt2_t *) h);
-    } else {
-	isp_put_request(isp, (ispreq_t *) rq, (ispreq_t *) h);
-    }
-    *nxi = nxti;
-    return (CMD_QUEUED);
-}
-#endif
-
 static void
 isp_pci_reset1(struct ispsoftc *isp)
 {
