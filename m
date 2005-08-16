Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVHPRIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVHPRIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVHPRIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:08:06 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:42929 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030259AbVHPRIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:08:01 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc6] improve start/stop code for worker thread in cpqfcTS driver, take 3
Date: Tue, 16 Aug 2005 19:09:18 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>,
       Bolke de Bruin <bdbruin@aub.nl>, Christoph Hellwig <hch@infradead.org>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508161658.15546@bilbo.math.uni-mannheim.de> <200508161820.57817@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508161820.57817@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161909.20196@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improve start/stop code for HBA worker thread. For the moment the return code 
of the start/stop functions is ignored, this will change once the init/exit 
code is changed to use 2.6 driver model.

Version 2: remove that lock_kernel() stuff missed in the first version
Version 3: use kthread API (pointed out by Christoph Hellwig)

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

diff -aup linux-2.6.13-rc6/drivers/scsi/cpqfcTSinit.c linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSinit.c
--- linux-2.6.13-rc6/drivers/scsi/cpqfcTSinit.c	2005-08-16 16:42:14.000000000 +0200
+++ linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSinit.c	2005-08-16 18:59:26.000000000 +0200
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>  // request_region() prototype
 #include <linux/completion.h>
+#include <linux/kthread.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>   // ioctl related
@@ -204,32 +205,26 @@ static void Cpqfc_initHBAdata(CPQFCHBA *
       }
 }
 
-
-/* (borrowed from linux/drivers/scsi/hosts.c) */
-static void launch_FCworker_thread(struct Scsi_Host *HostAdapter)
+static int launch_FCworker_thread(struct Scsi_Host *HostAdapter)
 {
-  DECLARE_MUTEX_LOCKED(sem);
-
-  CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
+	CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
 
-  ENTER("launch_FC_worker_thread");
+	ENTER(__function__);
 
-  cpqfcHBAdata->notify_wt = &sem;
+	spin_unlock_irq(HostAdapter->host_lock);
 
-  /* must unlock before kernel_thread(), for it may cause a reschedule. */
-  spin_unlock_irq(HostAdapter->host_lock);
-  kernel_thread((int (*)(void *))cpqfcTSWorkerThread,
-                          (void *) HostAdapter, 0);
-  /*
-   * Now wait for the kernel error thread to initialize itself
-
-   */
-  down (&sem);
-  spin_lock_irq(HostAdapter->host_lock);
-  cpqfcHBAdata->notify_wt = NULL;
+	cpqfcHBAdata->worker_thread = kthread_run(cpqfcTSWorkerThread,
+			HostAdapter,
+			"cpqfcTS_wt_%d", HostAdapter->host_no);
+	if (IS_ERR(cpqfcHBAdata->worker_thread)) {
+		printk(KERN_ERR DEV_NAME " can't start worker thread\n");
+		return PTR_ERR(cpqfcHBAdata->worker_thread);
+	}
 
-  LEAVE("launch_FC_worker_thread");
+	spin_lock_irq(HostAdapter->host_lock);
 
+	LEAVE(__function__);
+	return 0;
 }
 
 
@@ -317,9 +312,7 @@ int cpqfcTS_detect(Scsi_Host_Template *S
       // each HBA on the PCI bus(ses)).
       cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
 
-      // make certain our data struct is clear
-      memset( cpqfcHBAdata, 0, sizeof( CPQFCHBA ) );
-
+      memset(cpqfcHBAdata, 0, sizeof(*cpqfcHBAdata));
 
       // initialize our HBA info
       cpqfcHBAdata->HBAnum = NumberOfAdapters;
@@ -731,18 +724,7 @@ int cpqfcTS_release(struct Scsi_Host *Ho
   DEBUG_PCI( printk(" disable hardware, destroy queues, free mem\n"));
   cpqfcHBAdata->fcChip.ResetTachyon( cpqfcHBAdata, CLEAR_FCPORTS);
 
-  // kill kernel thread
-  if( cpqfcHBAdata->worker_thread ) // (only if exists)
-  {
-    DECLARE_MUTEX_LOCKED(sem);  // synchronize thread kill
-
-    cpqfcHBAdata->notify_wt = &sem;
-    DEBUG_PCI( printk(" killing kernel thread\n"));
-    send_sig( SIGKILL, cpqfcHBAdata->worker_thread, 1);
-    down( &sem);
-    cpqfcHBAdata->notify_wt = NULL;
-
-  }
+  kthread_stop(cpqfcHBAdata->worker_thread);
 
   cpqfc_free_private_data_pool(cpqfcHBAdata);
   // free Linux resources
diff -aup linux-2.6.13-rc6/drivers/scsi/cpqfcTSstructs.h linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSstructs.h
--- linux-2.6.13-rc6/drivers/scsi/cpqfcTSstructs.h	2005-08-16 16:42:14.000000000 +0200
+++ linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSstructs.h	2005-08-16 19:01:42.000000000 +0200
@@ -829,7 +829,7 @@ int CpqTsReadWriteWWN(void*, int ReadWri
 int CpqTsReadWriteNVRAM(void*, void* data, int ReadWrite);
 
 void cpqfcTS_WorkTask( struct Scsi_Host *HostAdapter);
-void cpqfcTSWorkerThread( void *host);
+extern int cpqfcTSWorkerThread(void *host);
 
 int cpqfcTS_GetNVRAM_data( UCHAR *wwnbuf, UCHAR *buf );
 ULONG cpqfcTS_ReadNVRAM( void* GPIOin, void* GPIOout , USHORT count,
diff -aup linux-2.6.13-rc6/drivers/scsi/cpqfcTSworker.c linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSworker.c
--- linux-2.6.13-rc6/drivers/scsi/cpqfcTSworker.c	2005-08-16 16:42:14.000000000 +0200
+++ linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSworker.c	2005-08-16 19:05:42.000000000 +0200
@@ -31,8 +31,7 @@
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
-
-#define SHUTDOWN_SIGS	(sigmask(SIGKILL)|sigmask(SIGINT)|sigmask(SIGTERM))
+#include <linux/kthread.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
@@ -145,9 +144,8 @@ static void IssueReportLunsCommand( 
               CPQFCHBA* cpqfcHBAdata, 
 	      TachFCHDR_GCMND* fchs);
 
-// (see scsi_error.c comments on kernel task creation)
-
-void cpqfcTSWorkerThread( void *host)
+int
+cpqfcTSWorkerThread(void *host)
 {
   struct Scsi_Host *HostAdapter = (struct Scsi_Host*)host;
   CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata; 
@@ -159,24 +157,11 @@ void cpqfcTSWorkerThread( void *host)
   DECLARE_MUTEX_LOCKED(TachFrozen);  
   DECLARE_MUTEX_LOCKED(BoardLock);  
 
-  ENTER("WorkerThread");
-
-  lock_kernel();
-  daemonize("cpqfcTS_wt_%d", HostAdapter->host_no);
-  siginitsetinv(&current->blocked, SHUTDOWN_SIGS);
-
+  ENTER(__function__);
 
   cpqfcHBAdata->fcQueReady = &fcQueReady;  // primary wait point
   cpqfcHBAdata->TYOBcomplete = &fcTYOBcomplete;
   cpqfcHBAdata->TachFrozen = &TachFrozen;
-    
- 
-  cpqfcHBAdata->worker_thread = current;
-  
-  unlock_kernel();
-
-  if( cpqfcHBAdata->notify_wt != NULL )
-    up( cpqfcHBAdata->notify_wt); // OK to continue
 
   while(1)
   {
@@ -184,9 +169,11 @@ void cpqfcTSWorkerThread( void *host)
 
     down_interruptible( &fcQueReady);  // wait for something to do
 
-    if (signal_pending(current) )
-      break;
-    
+    if (signal_pending(current))
+		flush_signals(current);
+    if (kthread_should_stop())
+		return 0;
+
     PCI_TRACE( 0x90)
     // first, take the IO lock so the SCSI upper layers can't call
     // into our _quecommand function (this also disables INTs)
@@ -225,15 +212,9 @@ void cpqfcTSWorkerThread( void *host)
     // Now, complete any Cmnd we Q'd up while BoardLock was held
 
     CompleteBoardLockCmnd( cpqfcHBAdata);
-  
-
   }
-  // hopefully, the signal was for our module exit...
-  if( cpqfcHBAdata->notify_wt != NULL )
-    up( cpqfcHBAdata->notify_wt); // yep, we're outta here
 }
 
-
 // Freeze Tachyon routine.
 // If Tachyon is already frozen, return FALSE
 // If Tachyon is not frozen, call freeze function, return TRUE
