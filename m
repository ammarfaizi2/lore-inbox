Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284140AbRLFQmb>; Thu, 6 Dec 2001 11:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284139AbRLFQmN>; Thu, 6 Dec 2001 11:42:13 -0500
Received: from web12304.mail.yahoo.com ([216.136.173.102]:8197 "HELO
	web12304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S284140AbRLFQmI>; Thu, 6 Dec 2001 11:42:08 -0500
Message-ID: <20011206164206.58598.qmail@web12304.mail.yahoo.com>
Date: Thu, 6 Dec 2001 08:42:06 -0800 (PST)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: [PATCH] cpqfc driver for 2.5.1-pre5 tree
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks, 

Here is a patch for the cpqfc driver to make it compile and run in the 2.5.1-pre5
tree.  I feel obligated to mention that I did see messages along the lines
of "running *really* low on DMA buffers" coming from scsi_merge.c, but
Jens told me not to worry about that, so here's the patch.  

It gets rid of the io_request_lock dependency, and silences a few
annoying printks that the driver has been spewing on startup.

-- steve

diff -urN linux-2.5.1-pre4/drivers/scsi/cpqfc.Readme
linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfc.Readme
--- linux-2.5.1-pre4/drivers/scsi/cpqfc.Readme	Thu Oct 25 14:53:50 2001
+++ linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfc.Readme	Fri Nov 30 22:26:00 2001
@@ -7,6 +7,11 @@
 SEST size 512 Exchanges (simultaneous I/Os) limited by module kmalloc() 
 	max of 128k bytes contiguous.
 
+Ver 2.5.0  Nov 29, 2001
+   * eliminated io_request_lock.  This change makes the driver specific
+     to the 2.5.x kernels.
+   * silenced excessively noisy printks.
+
 Ver 2.1.1  Oct 18, 2001
    * reinitialize Cmnd->SCp.sent_command (used to identify commands as
      passthrus) on calling scsi_done, since the scsi mid layer does not
diff -urN linux-2.5.1-pre4/drivers/scsi/cpqfcTScontrol.c
linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfcTScontrol.c
--- linux-2.5.1-pre4/drivers/scsi/cpqfcTScontrol.c	Thu Oct 25 14:53:50 2001
+++ linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfcTScontrol.c	Fri Nov 30 22:19:39 2001
@@ -97,11 +97,11 @@
   fcChip->Exchanges = NULL;
   cpqfcHBAdata->fcLQ = NULL;
   
-  printk("Allocating %u for %u Exchanges ", 
-	  (ULONG)sizeof(FC_EXCHANGES), TACH_MAX_XID);
+  /* printk("Allocating %u for %u Exchanges ", 
+	  (ULONG)sizeof(FC_EXCHANGES), TACH_MAX_XID); */
   fcChip->Exchanges = pci_alloc_consistent(cpqfcHBAdata->PciDev, 
 			sizeof(FC_EXCHANGES), &fcChip->exch_dma_handle);
-  printk("@ %p\n", fcChip->Exchanges);
+  /* printk("@ %p\n", fcChip->Exchanges); */
 
   if( fcChip->Exchanges == NULL ) // fatal error!!
   {
@@ -112,10 +112,10 @@
   memset( fcChip->Exchanges, 0, sizeof( FC_EXCHANGES));  
 
 
-  printk("Allocating %u for LinkQ ", (ULONG)sizeof(FC_LINK_QUE));
+  /* printk("Allocating %u for LinkQ ", (ULONG)sizeof(FC_LINK_QUE)); */
   cpqfcHBAdata->fcLQ = pci_alloc_consistent(cpqfcHBAdata->PciDev,
 				 sizeof( FC_LINK_QUE), &cpqfcHBAdata->fcLQ_dma_handle);
-  printk("@ %p (%u elements)\n", cpqfcHBAdata->fcLQ, FC_LINKQ_DEPTH);
+  /* printk("@ %p (%u elements)\n", cpqfcHBAdata->fcLQ, FC_LINKQ_DEPTH); */
   memset( cpqfcHBAdata->fcLQ, 0, sizeof( FC_LINK_QUE));
 
   if( cpqfcHBAdata->fcLQ == NULL ) // fatal error!!
@@ -222,8 +222,8 @@
   // power-of-2 boundary
   // LIVE DANGEROUSLY!  Assume the boundary for SEST mem will
   // be on physical page (e.g. 4k) boundary.
-  printk("Allocating %u for TachSEST for %u Exchanges\n", 
-		 (ULONG)sizeof(TachSEST), TACH_SEST_LEN);
+  /* printk("Allocating %u for TachSEST for %u Exchanges\n", 
+		 (ULONG)sizeof(TachSEST), TACH_SEST_LEN); */
   fcChip->SEST = fcMemManager( cpqfcHBAdata->PciDev,
 		  &cpqfcHBAdata->dynamic_mem[0],
 		  sizeof(TachSEST),  4, 0L, &SESTdma );
@@ -289,7 +289,7 @@
 
   // set the Host's pointer for Tachyon to access
 
-  printk("  cpqfcTS: writing IMQ BASE %Xh  ", fcChip->IMQ->base );
+  /* printk("  cpqfcTS: writing IMQ BASE %Xh  ", fcChip->IMQ->base ); */
   writel( fcChip->IMQ->base, 
     (fcChip->Registers.ReMapMemBase + IMQ_BASE));
 
@@ -315,9 +315,9 @@
     return -1;  // failed
   }
 #endif
-//#if DBG
+#if DBG
   printk("  PI %Xh\n", (ULONG)ulAddr );
-//#endif
+#endif
   writel( (ULONG)ulAddr, 
     (fcChip->Registers.ReMapMemBase + IMQ_PRODUCER_INDEX));
 
@@ -337,9 +337,9 @@
   writel( fcChip->SEST->base,
     (fcChip->Registers.ReMapMemBase + TL_MEM_SEST_BASE));
 
-  printk("  cpqfcTS: SEST %p(virt): Wrote base %Xh @ %p\n",
+  /* printk("  cpqfcTS: SEST %p(virt): Wrote base %Xh @ %p\n",
     fcChip->SEST, fcChip->SEST->base, 
-    fcChip->Registers.ReMapMemBase + TL_MEM_SEST_BASE);
+    fcChip->Registers.ReMapMemBase + TL_MEM_SEST_BASE); */
 
   writel( fcChip->SEST->length,
     (fcChip->Registers.ReMapMemBase + TL_MEM_SEST_LENGTH));
@@ -1723,7 +1723,7 @@
 	UCHAR Minor = (UCHAR)(RevId & 0x3);
 	UCHAR Major = (UCHAR)((RevId & 0x1C) >>2);
   
-        printk("  HBA Tachyon RevId %d.%d\n", Major, Minor);
+        /* printk("  HBA Tachyon RevId %d.%d\n", Major, Minor); */
   	if( (Major == 1) && (Minor == 2) )
         {
 	  sprintf( cpqfcHBAdata->fcChip.Name, STACHLITE66_TS12);
diff -urN linux-2.5.1-pre4/drivers/scsi/cpqfcTSinit.c
linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfcTSinit.c
--- linux-2.5.1-pre4/drivers/scsi/cpqfcTSinit.c	Thu Oct 25 14:53:50 2001
+++ linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfcTSinit.c	Fri Nov 30 22:11:47 2001
@@ -188,7 +188,7 @@
   DEBUG_PCI(printk("    IOBaseU = %x\n", 
     cpqfcHBAdata->fcChip.Registers.IOBaseU));
   
-  printk(" ioremap'd Membase: %p\n", cpqfcHBAdata->fcChip.Registers.ReMapMemBase);
+  /* printk(" ioremap'd Membase: %p\n", cpqfcHBAdata->fcChip.Registers.ReMapMemBase); */
   
   DEBUG_PCI(printk("    SFQconsumerIndex.address = %p\n", 
     cpqfcHBAdata->fcChip.Registers.SFQconsumerIndex.address));
@@ -242,7 +242,7 @@
   cpqfcHBAdata->notify_wt = &sem;
 
   /* must unlock before kernel_thread(), for it may cause a reschedule. */
-  spin_unlock_irq(&io_request_lock);
+  spin_unlock_irq(&HostAdapter->host_lock);
   kernel_thread((int (*)(void *))cpqfcTSWorkerThread, 
                           (void *) HostAdapter, 0);
   /*
@@ -250,7 +250,7 @@
 
    */
   down (&sem);
-  spin_lock_irq(&io_request_lock);
+  spin_lock_irq(&HostAdapter->host_lock);
   cpqfcHBAdata->notify_wt = NULL;
 
   LEAVE("launch_FC_worker_thread");
@@ -312,8 +312,8 @@
       }
 
       // NOTE: (kernel 2.2.12-32) limits allocation to 128k bytes...
-      printk(" scsi_register allocating %d bytes for FC HBA\n",
-		      (ULONG)sizeof(CPQFCHBA));
+      /* printk(" scsi_register allocating %d bytes for FC HBA\n",
+		      (ULONG)sizeof(CPQFCHBA)); */
 
       HostAdapter = scsi_register( ScsiHostTemplate, sizeof( CPQFCHBA ) );
       
@@ -403,9 +403,11 @@
       DEBUG_PCI(printk("  Requesting 255 I/O addresses @ %x\n",
         cpqfcHBAdata->fcChip.Registers.IOBaseU ));
 
-      
+     
+ 
       // start our kernel worker thread
 
+      spin_lock_irq(&HostAdapter->host_lock);
       launch_FCworker_thread(HostAdapter);
 
 
@@ -445,15 +447,16 @@
 	
 	unsigned long stop_time;
 
-        spin_unlock_irq(&io_request_lock);
+        spin_unlock_irq(&HostAdapter->host_lock);
 	stop_time = jiffies + 4*HZ;
         while ( time_before(jiffies, stop_time) ) 
 	  	schedule();  // (our worker task needs to run)
 
-	spin_lock_irq(&io_request_lock);
       }
       
+      spin_lock_irq(&HostAdapter->host_lock);
       NumberOfAdapters++; 
+      spin_unlock_irq(&HostAdapter->host_lock);
     } // end of while()
   }
 
@@ -1593,9 +1596,9 @@
   int retval;
   Scsi_Device *SDpnt = Cmnd->device;
   // printk("   ENTERING cpqfcTS_eh_device_reset() \n");
-  spin_unlock_irq(&io_request_lock);
+  spin_unlock_irq(&Cmnd->host->host_lock);
   retval = cpqfcTS_TargetDeviceReset( SDpnt, 0);
-  spin_lock_irq(&io_request_lock);
+  spin_lock_irq(&Cmnd->host->host_lock);
   return retval;
 }
 
@@ -1650,8 +1653,7 @@
   UCHAR IntPending;
   
   ENTER("intr_handler");
-
-  spin_lock_irqsave( &io_request_lock, flags);
+  spin_lock_irqsave( &HostAdapter->host_lock, flags);
   // is this our INT?
   IntPending = readb( cpqfcHBA->fcChip.Registers.INTPEND.address);
 
@@ -1700,7 +1702,7 @@
       }
     }      
   }
-  spin_unlock_irqrestore( &io_request_lock, flags);
+  spin_unlock_irqrestore( &HostAdapter->host_lock, flags);
   LEAVE("intr_handler");
 }
 
diff -urN linux-2.5.1-pre4/drivers/scsi/cpqfcTSstructs.h
linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfcTSstructs.h
--- linux-2.5.1-pre4/drivers/scsi/cpqfcTSstructs.h	Thu Oct 25 14:53:50 2001
+++ linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfcTSstructs.h	Fri Nov 30 20:42:28 2001
@@ -32,8 +32,8 @@
 #define CPQFCTS_DRIVER_VER(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
 // don't forget to also change MODULE_DESCRIPTION in cpqfcTSinit.c
 #define VER_MAJOR 2
-#define VER_MINOR 1
-#define VER_SUBMINOR 1
+#define VER_MINOR 5
+#define VER_SUBMINOR 0
 
 // Macros for kernel (esp. SMP) tracing using a PCI analyzer
 // (e.g. x86).
diff -urN linux-2.5.1-pre4/drivers/scsi/cpqfcTSworker.c
linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfcTSworker.c
--- linux-2.5.1-pre4/drivers/scsi/cpqfcTSworker.c	Thu Oct 25 14:53:50 2001
+++ linux-2.5.1-pre4-cpqfc_2.5.0/drivers/scsi/cpqfcTSworker.c	Fri Nov 30 21:52:28 2001
@@ -227,7 +227,7 @@
     PCI_TRACE( 0x90)
     // first, take the IO lock so the SCSI upper layers can't call
     // into our _quecommand function (this also disables INTs)
-    spin_lock_irqsave( &io_request_lock, flags); // STOP _que function
+    spin_lock_irqsave( &HostAdapter->host_lock, flags); // STOP _que function
     PCI_TRACE( 0x90)
          
     CPQ_SPINLOCK_HBA( cpqfcHBAdata)
@@ -241,7 +241,7 @@
     PCI_TRACE( 0x90)
 
     // release the IO lock (and re-enable interrupts)
-    spin_unlock_irqrestore( &io_request_lock, flags);
+    spin_unlock_irqrestore( &HostAdapter->host_lock, flags);
 
     // disable OUR HBA interrupt (keep them off as much as possible
     // during error recovery)
@@ -3077,7 +3077,8 @@
   if( cpqfcHBAdata->BoardLock) // Worker Task Running?
     goto Skip;
 
-  spin_lock_irqsave( &io_request_lock, flags); // STOP _que function
+  // STOP _que function
+  spin_lock_irqsave( &cpqfcHBAdata->HostAdapter->host_lock, flags); 
 
   PCI_TRACE( 0xA8)
 
@@ -3085,7 +3086,7 @@
   cpqfcHBAdata->BoardLock = &BoardLock; // stop Linux SCSI command queuing
   
   // release the IO lock (and re-enable interrupts)
-  spin_unlock_irqrestore( &io_request_lock, flags);
+  spin_unlock_irqrestore( &cpqfcHBAdata->HostAdapter->host_lock, flags);
   
   // Ensure no contention from  _quecommand or Worker process 
   CPQ_SPINLOCK_HBA( cpqfcHBAdata)



__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
