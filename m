Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSGVBz5>; Sun, 21 Jul 2002 21:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSGVBz5>; Sun, 21 Jul 2002 21:55:57 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:3443 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S315483AbSGVBzw>; Sun, 21 Jul 2002 21:55:52 -0400
Date: Sun, 21 Jul 2002 19:58:49 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: "David S. Miller" <davem@redhat.com>, "C.L. Huang" <ching@tekram.com.tw>,
       Kurt Garloff <garloff@suse.de>
Subject: Tekram DC390 DMA allocation fixes
Message-ID: <Pine.LNX.4.44.0207211943020.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

drivers/scsi/scsiiom.c is seriously DMA broken, for sure. But now I'm a 
bit confused. In the scatterlist, we removed the "address" field, but now 
we have a "dma_address" field. I don't know if this was meant to be a 
replacement.

Now there is that suggestion that we allocate DMAable memory via the PCI 
DMA pool functions. I'm still rather confused which way to go for the 
address field. We have

pSRB->SGBusAddr = virt_to_bus(psgl->address);

Should we do

psgl->dma_address = pci_pool_alloc(pool, SLAB_KERNEL, &pSRB->SGBusAddr);

here, or which ordering is correct? Also, where to store the PCI pool? 
Allocate it the moment we find the device (where I placed the 
pci_set_dma_mask()), and store it in the host controller?

Current work (breaks, of course):

diff -Nur linux-2.5.26/drivers/scsi/scsiiom.c thunder-2.5/drivers/scsi/scsiiom.c
--- linux-2.5.26/drivers/scsi/scsiiom.c	Tue Jul 16 17:49:24 2002
+++ thunder-2.5/drivers/scsi/scsiiom.c	Sun Jul 21 16:28:28 2002
@@ -245,11 +245,11 @@
     DEBUG1(printk (KERN_DEBUG "sstatus=%02x,", sstatus);)
 
 #if DMA_INT
-    DC390_LOCK_IO;
+    DC390_LOCK_IO(pACB->pScsiHost);
     DC390_LOCK_ACB;
     dstatus = dc390_dma_intr (pACB);
     DC390_UNLOCK_ACB;
-    DC390_UNLOCK_IO;
+    DC390_UNLOCK_IO(pACB->pScsiHost);
 
     DEBUG1(printk (KERN_DEBUG "dstatus=%02x,", dstatus);)
     if (! (dstatus & SCSI_INTERRUPT))
@@ -264,7 +264,7 @@
     //DC390_write32 (DMA_ScsiBusCtrl, EN_INT_ON_PCI_ABORT);
 #endif
 
-    DC390_LOCK_IO;
+    DC390_LOCK_IO(pACB->pScsiHost);
     DC390_LOCK_ACB;
     //DC390_UNLOCK_DRV_NI; /* Allow _other_ CPUs to process IRQ (useful for shared IRQs) */
 
@@ -340,7 +340,7 @@
  unlock:
     //DC390_LOCK_DRV_NI;
     DC390_UNLOCK_ACB;
-    DC390_UNLOCK_IO;
+    DC390_UNLOCK_IO(pACB->pScsiHost);
     //DC390_UNLOCK_DRV; /* Restore initial flags */
 }
 
@@ -381,7 +381,7 @@
 		pSRB->pSegmentList++;
 		psgl = pSRB->pSegmentList;
 
-		pSRB->SGBusAddr = virt_to_bus( psgl->address );
+		pSRB->SGBusAddr = virt_to_bus( psgl->dma_address );
 		pSRB->SGToBeXferLen = (ULONG) psgl->length;
 	    }
 	    else
@@ -404,7 +404,10 @@
     {
 	    DC390_write8 (DMA_Cmd, WRITE_DIRECTION+DMA_IDLE_CMD); /* | DMA_INT */
 	    DC390_write8 (ScsiCmd, CLEAR_FIFO_CMD);
-    }	    
+    }
+
+out:
+    return;
 }
 
 void
@@ -445,7 +448,7 @@
 		pSRB->pSegmentList++;
 		psgl = pSRB->pSegmentList;
 
-		pSRB->SGBusAddr = virt_to_bus( psgl->address );
+		pSRB->SGBusAddr = virt_to_bus( psgl->dma_address );
 		pSRB->SGToBeXferLen = (ULONG) psgl->length;
 	    }
 	    else
@@ -744,7 +747,7 @@
 	      pSRB->pSegmentList++;
 	      psgl = pSRB->pSegmentList;
 	      
-	      pSRB->SGBusAddr = virt_to_bus( psgl->address );
+	      pSRB->SGBusAddr = virt_to_bus( psgl->dma_address );
 	      pSRB->SGToBeXferLen = (ULONG) psgl->length;
 	    }
 	  else
@@ -758,10 +761,10 @@
     {
 	pSRB->SGcount = 1;
 	pSRB->pSegmentList = (PSGL) &pSRB->Segmentx;
-	pSRB->Segmentx.address = (PUCHAR) pSRB->pcmd->request_buffer + pSRB->Saved_Ptr;
+	pSRB->Segmentx.dma_address = (dma_addr_t) pSRB->pcmd->request_buffer + pSRB->Saved_Ptr;
 	pSRB->Segmentx.length = pSRB->pcmd->request_bufflen - pSRB->Saved_Ptr;
 	printk (KERN_INFO "DC390: Pointer restored. Total %li, Bus %p\n",
-		pSRB->Saved_Ptr, pSRB->Segmentx.address);
+		pSRB->Saved_Ptr, pSRB->Segmentx.dma_address);
     }
      else
        {
@@ -895,7 +898,7 @@
 	if( !pSRB->SGToBeXferLen )
 	{
 	    psgl = pSRB->pSegmentList;
-	    pSRB->SGBusAddr = virt_to_bus( psgl->address );
+	    pSRB->SGBusAddr = virt_to_bus( psgl->dma_address );
 	    pSRB->SGToBeXferLen = (ULONG) psgl->length;
 	    DEBUG1(printk (KERN_DEBUG " DC390: Next SG segment.");)
 	}
@@ -1370,7 +1373,7 @@
     status = pSRB->TargetStatus;
     ptr = (PSCSI_INQDATA) (pcmd->request_buffer);
     if( pcmd->use_sg )
-	ptr = (PSCSI_INQDATA) (((PSGL) ptr)->address);
+	ptr = (PSCSI_INQDATA) (((PSGL) ptr)->dma_address);
 	
     DEBUG0(printk (" SRBdone (%02x,%08x), SRB %p, pid %li\n", status, pcmd->result,\
 		pSRB, pcmd->pid);)
@@ -1445,7 +1448,7 @@
 	    else if( pcmd->request_buffer )
 	    {
 		pSRB->pSegmentList = (PSGL) &pSRB->Segmentx;
-		pSRB->Segmentx.address = (PUCHAR) pcmd->request_buffer;
+		pSRB->Segmentx.dma_address = (dma_addr_t) pcmd->request_buffer;
 		pSRB->Segmentx.length = pcmd->request_bufflen;
 	    }
 	    if( dc390_StartSCSI( pACB, pDCB, pSRB ) ) {
@@ -1520,7 +1523,7 @@
 		else if( pcmd->request_buffer )
 		{
 		    pSRB->pSegmentList = (PSGL) &pSRB->Segmentx;
-		    pSRB->Segmentx.address = (PUCHAR) pcmd->request_buffer;
+		    pSRB->Segmentx.dma_address = (dma_addr_t) pcmd->request_buffer;
 		    pSRB->Segmentx.length = pcmd->request_bufflen;
 		}
 		if( dc390_StartSCSI( pACB, pDCB, pSRB ) ) {
@@ -1761,7 +1764,7 @@
 
     pcmd = pSRB->pcmd;
 
-    pSRB->Segmentx.address = (PUCHAR) &(pcmd->sense_buffer);
+    pSRB->Segmentx.dma_address = (dma_addr_t) &(pcmd->sense_buffer);
     pSRB->Segmentx.length = sizeof(pcmd->sense_buffer);
     pSRB->pSegmentList = &pSRB->Segmentx;
     pSRB->SGcount = 1;
diff -Nur linux-2.5.26/drivers/scsi/tmscsim.c thunder-2.5/drivers/scsi/tmscsim.c
--- linux-2.5.26/drivers/scsi/tmscsim.c	Tue Jul 16 17:49:34 2002
+++ thunder-2.5/drivers/scsi/tmscsim.c	Sun Jul 21 17:16:25 2002
@@ -246,34 +246,12 @@
  * just causes a minor performance degradation for setting the locks.
  */
 
-/* spinlock things
- * level 3: lock on both adapter specific locks and (global) io_request_lock
- * level 2: lock on adapter specific locks only
- * level 1: rely on the locking of the mid level code (io_request_lock)
- * undef  : traditional save_flags; cli; restore_flags;
- */
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,30)
-# include <linux/init.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,30)
-# include <linux/spinlock.h>
-#else
-# include <asm/spinlock.h>
-#endif
-#endif
+#include <linux/init.h>
+#include <linux/spinlock.h>
 
+#define USE_SPINLOCKS 1
+#define NEW_PCI 1
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,93) 
-# define USE_SPINLOCKS 1
-# define NEW_PCI 1
-#else
-# undef NEW_PCI
-# if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,30)
-#  define USE_SPINLOCKS 2
-# endif
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,99)
 static struct pci_device_id tmscsim_pci_tbl[] __initdata = {
 	{
 		vendor: PCI_VENDOR_ID_AMD,
@@ -284,145 +262,40 @@
 	{ }		/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, tmscsim_pci_tbl);
-#endif
 	
-#ifdef USE_SPINLOCKS
-
-# if USE_SPINLOCKS == 3 /* both */
-
-#  if defined (CONFIG_SMP)
-#   define DC390_LOCKA_INIT { spinlock_t __unlocked = SPIN_LOCK_UNLOCKED; pACB->lock = __unlocked; };
-#  else
-#   define DC390_LOCKA_INIT
-#  endif
-   spinlock_t dc390_drvlock = SPIN_LOCK_UNLOCKED;
-
-#  define DC390_AFLAGS unsigned long aflags;
-#  define DC390_IFLAGS unsigned long iflags;
-#  define DC390_DFLAGS unsigned long dflags; 
-
-#  define DC390_LOCK_IO spin_lock_irqsave (((struct Scsi_Host *)dev)->host_lock, iflags)
-#  define DC390_UNLOCK_IO spin_unlock_irqrestore (((struct Scsi_Host *)dev)->host_lock, iflags)
-
-#  define DC390_LOCK_DRV spin_lock_irqsave (&dc390_drvlock, dflags)
-#  define DC390_UNLOCK_DRV spin_unlock_irqrestore (&dc390_drvlock, dflags)
-#  define DC390_LOCK_DRV_NI spin_lock (&dc390_drvlock)
-#  define DC390_UNLOCK_DRV_NI spin_unlock (&dc390_drvlock)
-
-#  define DC390_LOCK_ACB spin_lock_irqsave (&(pACB->lock), aflags)
-#  define DC390_UNLOCK_ACB spin_unlock_irqrestore (&(pACB->lock), aflags)
-#  define DC390_LOCK_ACB_NI spin_lock (&(pACB->lock))
-#  define DC390_UNLOCK_ACB_NI spin_unlock (&(pACB->lock))
-//#  define DC390_LOCKA_INIT spin_lock_init (&(pACB->lock))
-
-# else
-
-#  if USE_SPINLOCKS == 2 /* adapter specific locks */
-
-#   if defined (CONFIG_SMP)
-#    define DC390_LOCKA_INIT { spinlock_t __unlocked = SPIN_LOCK_UNLOCKED; pACB->lock = __unlocked; };
-#   else
-#    define DC390_LOCKA_INIT
-#   endif
-    spinlock_t dc390_drvlock = SPIN_LOCK_UNLOCKED;
-#   define DC390_AFLAGS unsigned long aflags;
-#   define DC390_IFLAGS 
-#  define DC390_DFLAGS unsigned long dflags; 
-#   define DC390_LOCK_IO(dev) /* spin_lock_irqsave (&io_request_lock, iflags) */
-#   define DC390_UNLOCK_IO(dev) /* spin_unlock_irqrestore (&io_request_lock, iflags) */
-#   define DC390_LOCK_DRV spin_lock_irqsave (&dc390_drvlock, dflags)
-#   define DC390_UNLOCK_DRV spin_unlock_irqrestore (&dc390_drvlock, dflags)
-#   define DC390_LOCK_DRV_NI spin_lock (&dc390_drvlock)
-#   define DC390_UNLOCK_DRV_NI spin_unlock (&dc390_drvlock)
-#   define DC390_LOCK_ACB spin_lock_irqsave (&(pACB->lock), aflags)
-#   define DC390_UNLOCK_ACB spin_unlock_irqrestore (&(pACB->lock), aflags)
-#   define DC390_LOCK_ACB_NI spin_lock (&(pACB->lock))
-#   define DC390_UNLOCK_ACB_NI spin_unlock (&(pACB->lock))
-//#   define DC390_LOCKA_INIT spin_lock_init (&(pACB->lock))
-
-#  else /* USE_SPINLOCKS == 1: global lock io_request_lock */
-
-#   define DC390_AFLAGS 
-#   define DC390_IFLAGS unsigned long iflags;
-#   define DC390_DFLAGS unsigned long dflags; 
+#define DC390_AFLAGS 
+#define DC390_IFLAGS unsigned long iflags;
+#define DC390_DFLAGS unsigned long dflags; 
     spinlock_t dc390_drvlock = SPIN_LOCK_UNLOCKED;
-#   define DC390_LOCK_IO(dev) spin_lock_irqsave (((struct Scsi_Host *)dev)->host_lock, iflags)
-#   define DC390_UNLOCK_IO(dev) spin_unlock_irqrestore (((struct Scsi_Host *)dev)->host_lock, iflags)
-#   define DC390_LOCK_DRV spin_lock_irqsave (&dc390_drvlock, dflags)
-#   define DC390_UNLOCK_DRV spin_unlock_irqrestore (&dc390_drvlock, dflags)
-#   define DC390_LOCK_DRV_NI spin_lock (&dc390_drvlock)
-#   define DC390_UNLOCK_DRV_NI spin_unlock (&dc390_drvlock)
-#   define DC390_LOCK_ACB /* DC390_LOCK_IO */
-#   define DC390_UNLOCK_ACB /* DC390_UNLOCK_IO */
-#   define DC390_LOCK_ACB_NI /* spin_lock (&(pACB->lock)) */
-#   define DC390_UNLOCK_ACB_NI /* spin_unlock (&(pACB->lock)) */
-#   define DC390_LOCKA_INIT /* DC390_LOCKA_INIT */
-
-#  endif /* 2 */
-# endif /* 3 */
-
-#else /* USE_SPINLOCKS undefined */
-
-# define DC390_AFLAGS unsigned long aflags;
-# define DC390_IFLAGS unsigned long iflags;
-# define DC390_DFLAGS unsigned long dflags; 
-# define DC390_LOCK_IO save_flags (iflags); cli ()
-# define DC390_UNLOCK_IO restore_flags (iflags)
-# define DC390_LOCK_DRV save_flags (dflags); cli ()
-# define DC390_UNLOCK_DRV restore_flags (dflags)
-# define DC390_LOCK_DRV_NI
-# define DC390_UNLOCK_DRV_NI
-# define DC390_LOCK_ACB save_flags (aflags); cli ()
-# define DC390_UNLOCK_ACB restore_flags (aflags)
-# define DC390_LOCK_ACB_NI
-# define DC390_UNLOCK_ACB_NI
-# define DC390_LOCKA_INIT
-#endif /* def */
-
+#define DC390_LOCK_IO(dev) spin_lock_irqsave (((struct Scsi_Host *)dev)->host_lock, iflags)
+#define DC390_UNLOCK_IO(dev) spin_unlock_irqrestore (((struct Scsi_Host *)dev)->host_lock, iflags)
+#define DC390_LOCK_DRV spin_lock_irqsave (&dc390_drvlock, dflags)
+#define DC390_UNLOCK_DRV spin_unlock_irqrestore (&dc390_drvlock, dflags)
+#define DC390_LOCK_DRV_NI spin_lock (&dc390_drvlock)
+#define DC390_UNLOCK_DRV_NI spin_unlock (&dc390_drvlock)
+#define DC390_LOCK_ACB /* DC390_LOCK_IO */
+#define DC390_UNLOCK_ACB /* DC390_UNLOCK_IO */
+#define DC390_LOCK_ACB_NI spin_lock (&(pACB->lock))
+#define DC390_UNLOCK_ACB_NI spin_unlock (&(pACB->lock))
+#define DC390_LOCKA_INIT /* DC390_LOCKA_INIT */
 
 /* These macros are used for uniform access to 2.0.x and 2.1.x PCI config space*/
 
-#ifdef NEW_PCI
-# define PDEV pdev
-# define PDEVDECL struct pci_dev *pdev
-# define PDEVDECL0 struct pci_dev *pdev = NULL
-# define PDEVDECL1 struct pci_dev *pdev
-# define PDEVSET pACB->pdev=pdev
-# define PDEVSET1 pdev=pACB->pdev
-# define PCI_WRITE_CONFIG_BYTE(pd, rv, bv) pci_write_config_byte (pd, rv, bv)
-# define PCI_READ_CONFIG_BYTE(pd, rv, bv) pci_read_config_byte (pd, rv, bv)
-# define PCI_WRITE_CONFIG_WORD(pd, rv, bv) pci_write_config_word (pd, rv, bv)
-# define PCI_READ_CONFIG_WORD(pd, rv, bv) pci_read_config_word (pd, rv, bv)
-# define PCI_BUS_DEV pdev->bus->number, pdev->devfn
-# define PCI_PRESENT pci_present ()
-# define PCI_SET_MASTER pci_set_master (pdev)
-# define PCI_FIND_DEVICE(vend, id) (pdev = pci_find_device (vend, id, pdev))
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,10)
-# define PCI_GET_IO_AND_IRQ io_port = pci_resource_start (pdev, 0); irq = pdev->irq
-#else
-# define PCI_GET_IO_AND_IRQ io_port = pdev->base_address[0] & PCI_BASE_ADDRESS_IO_MASK; irq = pdev->irq
-#endif
-#else
-# include <linux/bios32.h>
-# define PDEV pbus, pdevfn
-# define PDEVDECL UCHAR pbus, UCHAR pdevfn
-# define PDEVDECL0 UCHAR pbus = 0; UCHAR pdevfn = 0; USHORT pci_index = 0; int error
-# define PDEVDECL1 UCHAR pbus; UCHAR pdevfn /*; USHORT pci_index */
-# define PDEVSET pACB->pbus=pbus; pACB->pdevfn=pdevfn /*; pACB->pci_index=pci_index */
-# define PDEVSET1 pbus=pACB->pbus; pdevfn=pACB->pdevfn /*; pci_index=pACB->pci_index */
-# define PCI_WRITE_CONFIG_BYTE(pd, rv, bv) pcibios_write_config_byte (pd, rv, bv)
-# define PCI_READ_CONFIG_BYTE(pd, rv, bv) pcibios_read_config_byte (pd, rv, bv)
-# define PCI_WRITE_CONFIG_WORD(pd, rv, bv) pcibios_write_config_word (pd, rv, bv)
-# define PCI_READ_CONFIG_WORD(pd, rv, bv) pcibios_read_config_word (pd, rv, bv)
-# define PCI_BUS_DEV pbus, pdevfn
-# define PCI_PRESENT pcibios_present ()
-# define PCI_SET_MASTER dc390_set_master (pbus, pdevfn)
-# define PCI_FIND_DEVICE(vend, id) (!pcibios_find_device (vend, id, pci_index++, &pbus, &pdevfn))
-# define PCI_GET_IO_AND_IRQ error = pcibios_read_config_dword (pbus, pdevfn, PCI_BASE_ADDRESS_0, &io_port);	\
- error |= pcibios_read_config_byte (pbus, pdevfn, PCI_INTERRUPT_LINE, &irq);	\
- io_port &= 0xfffe;	\
- if (error) { printk (KERN_ERR "DC390_detect: Error reading PCI config registers!\n"); continue; }
-#endif 
+#define PDEV pdev
+#define PDEVDECL struct pci_dev *pdev
+#define PDEVDECL0 struct pci_dev *pdev = NULL
+#define PDEVDECL1 struct pci_dev *pdev
+#define PDEVSET pACB->pdev=pdev
+#define PDEVSET1 pdev=pACB->pdev
+#define PCI_WRITE_CONFIG_BYTE(pd, rv, bv) pci_write_config_byte (pd, rv, bv)
+#define PCI_READ_CONFIG_BYTE(pd, rv, bv) pci_read_config_byte (pd, rv, bv)
+#define PCI_WRITE_CONFIG_WORD(pd, rv, bv) pci_write_config_word (pd, rv, bv)
+#define PCI_READ_CONFIG_WORD(pd, rv, bv) pci_read_config_word (pd, rv, bv)
+#define PCI_BUS_DEV pdev->bus->number, pdev->devfn
+#define PCI_PRESENT pci_present ()
+#define PCI_SET_MASTER pci_set_master (pdev)
+#define PCI_FIND_DEVICE(vend, id) (pdev = pci_find_device (vend, id, pdev))
+#define PCI_GET_IO_AND_IRQ io_port = pci_resource_start (pdev, 0); irq = pdev->irq
 
 #include "tmscsim.h"
 
@@ -1071,11 +944,11 @@
 	DC390_IFLAGS
 	DC390_AFLAGS
 	DEBUG0(printk ("DC390: Debug: Waiting queue woken up by timer!\n");)
-	DC390_LOCK_IO(pACB.pScsiHost);
+	DC390_LOCK_IO(pACB->pScsiHost);
 	DC390_LOCK_ACB;
 	dc390_Waiting_process (pACB);
 	DC390_UNLOCK_ACB;
-	DC390_UNLOCK_IO(pACB.pScsiHost);
+	DC390_UNLOCK_IO(pACB->pScsiHost);
 }
 
 /***********************************************************************
@@ -1087,7 +960,7 @@
 
 static void dc390_SendSRB( PACB pACB, PSRB pSRB )
 {
-    PDCB   pDCB;
+    PDCB pDCB;
 
     pDCB = pSRB->pSRBDCB;
     if( (pDCB->MaxCommand <= pDCB->GoingSRBCnt) || (pACB->pActiveDCB) ||
@@ -1143,7 +1016,7 @@
     {
 	pSRB->SGcount = 1;
 	pSRB->pSegmentList = (PSGL) &pSRB->Segmentx;
-	pSRB->Segmentx.address = (PUCHAR) pcmd->request_buffer;
+	pSRB->Segmentx.dma_address = (dma_addr_t) pcmd->request_buffer;
 	pSRB->Segmentx.length = pcmd->request_bufflen;
     }
     else
@@ -2086,6 +1959,12 @@
     int    i;
     
     pACB = (PACB) psh->hostdata;
+
+    if (pci_set_dma_mask (psh->pci_dev, 0xffffffff))
+      {
+	printk(KERN_WARN "DC390: no suitable DMA available. Aborting.\n");
+	return( -1 );
+      }
     
     if (check_region (io_port, psh->n_io_port))
 	{
@@ -2398,7 +2277,7 @@
    cmd->scsi_done = dc390_inquiry_done;
    cmd->timeout_per_command = HZ;
 
-   cmd->request.rq_status = RQ_SCSI_BUSY;
+   cmd->request->rq_status = RQ_SCSI_BUSY;
 
    pDCB->SyncMode &= ~SYNC_NEGO_DONE;
    printk (KERN_INFO "DC390: Queue INQUIRY command to dev ID %02x LUN %02x\n",
@@ -2448,7 +2327,7 @@
    cmd->scsi_done = dc390_sendstart_done;
    cmd->timeout_per_command = 5*HZ;
 
-   cmd->request.rq_status = RQ_SCSI_BUSY;
+   cmd->request->rq_status = RQ_SCSI_BUSY;
 
    pDCB->SyncMode &= ~SYNC_NEGO_DONE;
    printk (KERN_INFO "DC390: Queue SEND_START command to dev ID %02x LUN %02x\n",
@@ -2494,7 +2373,7 @@
 #define YESNO(buffer, pos, var, bmask)			\
 if (dc390_yesno (&buffer, &pos, &var, bmask)) goto einv;	\
 else dc390_updateDCB (pACB, pDCB);		\
-if (!p) goto ok
+if (!pos) goto ok
 
 static int dc390_search (char** buffer, char** pos, char** p0, char* var, char* txt, int max, int scale, char* ign)
 {
@@ -2525,8 +2404,8 @@
 if (dc390_search (&buffer, &pos, &p0, &var, txt, max, scale, "")) goto einv2; 		\
 else if (!p1) goto ok2
 
-#define SEARCH3(buffer, pos, &p0, var, txt, max, scale, ign)				\
-if (dc390_search (&buffer, &pos, p0, &var, txt, max, scale, ign)) goto einv2;		\
+#define SEARCH3(buffer, pos, p0, var, txt, max, scale, ign)				\
+if (dc390_search (&buffer, &pos, &p0, &var, txt, max, scale, ign)) goto einv2;		\
 else if (!p1) goto ok2
 
 
@@ -2555,7 +2434,7 @@
   DC390_AFLAGS 
   pos[length] = 0;
 
-  DC390_LOCK_IO(pACB.pScsiHost);
+  DC390_LOCK_IO(pACB->pScsiHost);
   DC390_LOCK_ACB;
   /* UPPERCASE */ 
   /* Don't use kernel toupper, because of 2.0.x bug: ctmp unexported */
@@ -2630,9 +2509,9 @@
 	  pDCB->NegoPeriod = dum >> 2;
 	  if (pDCB->NegoPeriod != olddevmode) needs_inquiry++;
 	  if (!pos) goto ok;
-	  if (memcmp (pos, "NS", 2) == 0) pos = strsep (*pos, " \t\n:=,;.");
+	  if (memcmp (pos, "NS", 2) == 0) pos = strsep (&pos, " \t\n:=,;.");
 	}
-      else pos = strsep (*pos, " \t\n:=,;.");
+      else pos = strsep (&pos, " \t\n:=,;.");
       if (!*pos) goto ok;
       
       /* Sync Speed in MHz */
@@ -2650,13 +2529,13 @@
 		for (; p0-pos > 1; p0--) dum /= 10;
 		pDCB->NegoPeriod = (100000/(100*dumold + dum)) >> 2;
 		if (pDCB->NegoPeriod < 19) pDCB->NegoPeriod = 19;
-		pos = strsep (*pos, " \t\n:=,;");
+		pos = strsep (&pos, " \t\n:=,;");
 		if (!*pos) goto ok;
 	     };
-	  if (*pos == 'M') pos = strsep (*pos, " \t\n:=,;");
+	  if (*pos == 'M') pos = strsep (&pos, " \t\n:=,;");
 	  if (pDCB->NegoPeriod != olddevmode) needs_inquiry++;
 	}
-      else pos = strsep (*pos, " \t\n:=,;");
+      else pos = strsep (&pos, " \t\n:=,;");
       /* dc390_updateDCB (pACB, pDCB); */
       if (!*pos) goto ok;
 
@@ -2668,7 +2547,7 @@
 	  pDCB->SyncOffset = dum;
 	  if (pDCB->SyncOffset > olddevmode) needs_inquiry++;
 	}
-      else pos = strsep (*pos, " \t\n:=,;");
+      else pos = strsep (&pos, " \t\n:=,;");
       if (!*pos) goto ok;
       dc390_updateDCB (pACB, pDCB);
 
@@ -2681,7 +2560,7 @@
 		pDCB->MaxCommand = dum;
 	  else printk (KERN_INFO "DC390: Can't set MaxCmd larger than one without Tag Queueing!\n");
 	}
-      else pos = strsep (*pos, " \t\n:=,;");
+      else pos = strsep (&pos, " \t\n:=,;");
 
     }
   else
@@ -2719,14 +2598,14 @@
   DC390_UNLOCK_ACB;
   if (needs_inquiry) 
      { dc390_updateDCB (pACB, pDCB); dc390_inquiry (pACB, pDCB); };
-  DC390_UNLOCK_IO(pACB.pScsiHost);
+  DC390_UNLOCK_IO(pACB->pScsiHost);
   return (length);
 
  einv2:
   pos = p0;
  einv:
   DC390_UNLOCK_ACB;
-  DC390_UNLOCK_IO(pACB.pScsiHost);
+  DC390_UNLOCK_IO(pACB->pScsiHost);
   printk (KERN_WARNING "DC390: parse error near \"%s\"\n", (pos? pos: "NULL"));
   return (-EINVAL);
    
@@ -2736,7 +2615,7 @@
 	printk (KERN_WARNING "DC390: Driver reset requested!\n");
 	DC390_UNLOCK_ACB;
 	DC390_reset (&cmd, 0);
-	DC390_UNLOCK_IO(pACB.pScsiHost);
+	DC390_UNLOCK_IO(pACB->pScsiHost);
      };
   return (length);
 
@@ -2744,13 +2623,13 @@
      {
 	dc390_dumpinfo (pACB, 0, 0);
 	DC390_UNLOCK_ACB;
-	DC390_UNLOCK_IO(pACB.pScsiHost);       
+	DC390_UNLOCK_IO(pACB->pScsiHost);       
      }
   return (length);
 	
  inquiry:
      {
-	pos = strsep (*pos, " \t\n.:;="); if (!*pos) goto einv;
+	pos = strsep (&pos, " \t\n.:;="); if (!*pos) goto einv;
 	dev = simple_strtoul (pos, &p0, 10);
 	if (dev >= pACB->DCBCnt) goto einv_dev;
 	for (dum = 0; dum < dev; dum++) pDCB = pDCB->pNextDCB;
@@ -2758,13 +2637,13 @@
 		dev, pDCB->TargetID, pDCB->TargetLUN);
 	DC390_UNLOCK_ACB;
 	dc390_inquiry (pACB, pDCB);
-	DC390_UNLOCK_IO(pACB.pScsiHost);
+	DC390_UNLOCK_IO(pACB->pScsiHost);
      };
    return (length);
 
  remove:
      {
-	pos = strsep (*pos, " \t\n.:;="); if (!*pos) goto einv;
+	pos = strsep (&pos, " \t\n.:;="); if (!*pos) goto einv;
 	dev = simple_strtoul (pos, &p0, 10);
 	if (dev >= pACB->DCBCnt) goto einv_dev;
 	for (dum = 0; dum < dev; dum++) pDCB = pDCB->pNextDCB;
@@ -2773,14 +2652,14 @@
 	/* TO DO: We should make sure no pending commands are left */
 	dc390_remove_dev (pACB, pDCB);
 	DC390_UNLOCK_ACB;
-	DC390_UNLOCK_IO(pACB.pScsiHost);
+	DC390_UNLOCK_IO(pACB->pScsiHost);
      };
    return (length);
 
  add:
      {
 	int id, lun;
-	pos = strsep (*pos, " \t\n.:;=");
+	pos = strsep (&pos, " \t\n.:;=");
 	if (*pos) { SCANF (buffer, pos, p0, id, 0, 7); } else goto einv;
 	if (*pos) { SCANF (buffer, pos, p0, lun, 0, 7); } else goto einv;
 	pDCB = dc390_findDCB (pACB, id, lun);
@@ -2788,14 +2667,14 @@
 	dc390_initDCB (pACB, &pDCB, id, lun);
 	DC390_UNLOCK_ACB;
 	dc390_inquiry (pACB, pDCB);
-	DC390_UNLOCK_IO(pACB.pScsiHost);
+	DC390_UNLOCK_IO(pACB->pScsiHost);
      };
    return (length);
 
  start:
      {
 	int id, lun;
-	pos = strsep (*pos, " \t\n.:;=");
+	pos = strsep (&pos, " \t\n.:;=");
 	if (*pos) { SCANF (buffer, pos, p0, id, 0, 7); } else goto einv;
 	if (*pos) { SCANF (buffer, pos, p0, lun, 0, 7); } else goto einv;
 	pDCB = dc390_findDCB (pACB, id, lun);
@@ -2804,7 +2683,7 @@
 	DC390_UNLOCK_ACB;
 	dc390_sendstart (pACB, pDCB);
 	dc390_inquiry (pACB, pDCB);
-	DC390_UNLOCK_IO(pACB.pScsiHost);
+	DC390_UNLOCK_IO(pACB->pScsiHost);
      };
    return (length);
 
@@ -2812,7 +2691,7 @@
    printk (KERN_WARNING "DC390: Ignore cmnd to illegal Dev(Idx) %i. Valid range: 0 - %i.\n", 
 	   dev, pACB->DCBCnt - 1);
    DC390_UNLOCK_ACB;
-   DC390_UNLOCK_IO(pACB.pScsiHost);
+   DC390_UNLOCK_IO(pACB->pScsiHost);
    return (-EINVAL);
 	     
 	     

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

