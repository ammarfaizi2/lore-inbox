Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUB1Jrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 04:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUB1Jrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 04:47:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4555 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261775AbUB1Jri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 04:47:38 -0500
Date: Sat, 28 Feb 2004 10:47:33 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Kurt Garloff <kurt@garloff.de>, ching@tekram.com.tw
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] tmscsim: remove kernel kenel 2.2 #ifdef's
Message-ID: <20040228094732.GL5499@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes #ifdefs for kernel 2.0 and 2.2 from the tmscsim 
driver.

diffstat output:
 drivers/scsi/scsiiom.c |    2 -
 drivers/scsi/tmscsim.c |   61 ++---------------------------------------
 2 files changed, 3 insertions(+), 60 deletions(-)


cu
Adrian

--- linux-2.6.3-mm4/drivers/scsi/tmscsim.c.old	2004-02-28 09:56:44.000000000 +0100
+++ linux-2.6.3-mm4/drivers/scsi/tmscsim.c	2004-02-28 09:58:52.000000000 +0100
@@ -260,16 +260,10 @@
  * undef  : traditional save_flags; cli; restore_flags;
  */
 
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
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,99) && defined(MODULE)
+#ifdef MODULE
 static struct pci_device_id tmscsim_pci_tbl[] = {
 	{
 		.vendor		= PCI_VENDOR_ID_AMD,
@@ -374,18 +368,14 @@
 /* Startup values, to be overriden on the commandline */
 int tmscsim[] = {-2, -2, -2, -2, -2, -2};
 
-# if defined(MODULE) && LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,30)
 MODULE_PARM(tmscsim, "1-6i");
 MODULE_PARM_DESC(tmscsim, "Host SCSI ID, Speed (0=10MHz), Device Flags, Adapter Flags, Max Tags (log2(tags)-1), DelayReset (s)");
-# endif
 
-#if defined(MODULE) && LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,30)
 MODULE_AUTHOR("C.L. Huang / Kurt Garloff");
 MODULE_DESCRIPTION("SCSI host adapter driver for Tekram DC390 and other AMD53C974A based PCI SCSI adapters");
 MODULE_LICENSE("GPL");
 
 MODULE_SUPPORTED_DEVICE("sd,sr,sg,st");
-#endif
 
 static PVOID dc390_phase0[]={
        dc390_DataOut_0,
@@ -448,13 +438,6 @@
 UCHAR  dc390_clock_period1[] = {4, 5, 6, 7, 8, 10, 13, 20};
 UCHAR  dc390_clock_speed[] = {100,80,67,57,50, 40, 31, 20};
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,30)
-struct proc_dir_entry	DC390_proc_scsi_tmscsim ={
-       PROC_SCSI_DC390T, 7 ,"tmscsim",
-       S_IFDIR | S_IRUGO | S_IXUGO, 2
-       };
-#endif
-
 /***********************************************************************
  * Functions for access to DC390 EEPROM
  * and some to emulate it
@@ -549,7 +532,6 @@
 /* Override defaults on cmdline:
  * tmscsim: AdaptID, MaxSpeed (Index), DevMode (Bitmapped), AdaptMode (Bitmapped)
  */
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,13)
 int __init dc390_setup (char *str)
 {	
 	int ints[8];
@@ -570,23 +552,6 @@
 __setup("tmscsim=", dc390_setup);
 #endif
 
-#else
-void __init dc390_setup (char *str, int *ints)
-{
-	int i, im;
-	im = ints[0];
-	if (im > 6)
-	{
-		printk (KERN_NOTICE "DC390: ignore extra params!\n");
-		im = 6;
-	}
-	for (i = 0; i < im; i++)
-		tmscsim[i] = ints[i+1];
-	/* dc390_checkparams (); */
-}
-#endif
-
-
 
 static void __init dc390_EEpromOutDI( PDEVDECL, PUCHAR regval, UCHAR Carry )
 {
@@ -891,16 +856,6 @@
 	dc390_Going_append (pDCB, pSRB);
 }
 
-/* 2.0 timer compatibility */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,30)
- static inline int timer_pending(struct timer_list * timer)
- {
-	return timer->prev != NULL;
- }
- #define time_after(a,b)         ((long)(b) - (long)(a) < 0)
- #define time_before(a,b)        time_after(b,a)
-#endif
-
 void DC390_waiting_timed_out (unsigned long ptr);
 /* Sets the timer to wake us up */
 static void dc390_waiting_timer (PACB pACB, unsigned long to)
@@ -1939,11 +1894,7 @@
     psh->io_port = io_port;
     psh->n_io_port = 0x80;
     psh->irq = Irq;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,50)
     psh->base = io_port;
-#else
-    psh->base = (char*)io_port;
-#endif	
     psh->unique_id = io_port;
     psh->dma_channel = -1;
     psh->last_reset = jiffies;
@@ -2229,10 +2180,8 @@
     if ( PCI_PRESENT )
 	while (PCI_FIND_DEVICE (PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD53C974))
 	{
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,30)
 	    if (pci_enable_device (pdev))
 		continue;
-#endif
 	    PCI_GET_IO_AND_IRQ;
 	    DEBUG0(printk(KERN_INFO "DC390(%i): IO_PORT=%04x,IRQ=%x\n", dc390_adapterCnt, (UINT) io_port, irq));
 
@@ -2247,11 +2196,7 @@
 	printk (KERN_ERR "DC390: No PCI BIOS found!\n");
    
     if (dc390_adapterCnt)
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,30)
 	psht->proc_name = "tmscsim";
-#else
-	psht->proc_dir = &DC390_proc_scsi_tmscsim;
-#endif
     printk(KERN_INFO "DC390: %i adapters found\n", dc390_adapterCnt);
     return( dc390_adapterCnt );
 }
--- linux-2.6.3-mm4/drivers/scsi/scsiiom.c.old	2004-02-28 09:59:47.000000000 +0100
+++ linux-2.6.3-mm4/drivers/scsi/scsiiom.c	2004-02-28 09:59:56.000000000 +0100
@@ -1619,9 +1619,7 @@
 	  pACB->scan_devices = 0;
      };
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,30)
     pcmd->resid = pcmd->request_bufflen - pSRB->TotalXferredLen;
-#endif
 
     if (!DCB_removed) dc390_Going_remove (pDCB, pSRB);
     /* Add to free list */
