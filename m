Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbVHPPGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbVHPPGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965268AbVHPPGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:06:19 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:7583 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965260AbVHPPGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:06:15 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc6] improve start/stop code for worker thread in cpqfcTS driver
Date: Tue, 16 Aug 2005 16:58:14 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508161113.45940@bilbo.math.uni-mannheim.de> <200508161114.39675@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508161114.39675@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161658.15546@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use pid of worker thread and struct completion for signaling end of worker 
thread (code more or less taken from drivers/net/8139too.c). For the moment 
the return code of the start/stop functions is ignored, this will change 
once the init/exit code is changed to use 2.6 driver model.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

diff -aup linux-2.6.13-rc6/drivers/scsi/cpqfcTSinit.c linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSinit.c
--- linux-2.6.13-rc6/drivers/scsi/cpqfcTSinit.c	2005-08-16 16:42:14.000000000 +0200
+++ linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSinit.c	2005-08-16 16:34:02.000000000 +0200
@@ -204,32 +204,35 @@ static void Cpqfc_initHBAdata(CPQFCHBA *
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
-
-  ENTER("launch_FC_worker_thread");
-
-  cpqfcHBAdata->notify_wt = &sem;
-
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
-
-  LEAVE("launch_FC_worker_thread");
-
+	DECLARE_MUTEX_LOCKED(sem);
+	
+	CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
+	
+	ENTER(__function__);
+	
+	cpqfcHBAdata->notify_wt = &sem;
+	
+	/* must unlock before kernel_thread(), for it may cause a reschedule. */
+	spin_unlock_irq(HostAdapter->host_lock);
+	cpqfcHBAdata->thr_pid = -1;
+	cpqfcHBAdata->time_to_die = 0;
+	cpqfcHBAdata->thr_pid = kernel_thread(cpqfcTSWorkerThread, HostAdapter, 0);
+	if (cpqfcHBAdata->thr_pid) {
+		printk(KERN_ERR DEV_NAME " can't start worker thread\n");
+		return cpqfcHBAdata->thr_pid;
+	} else {
+	/*
+		* Now wait for the kernel error thread to initialize itself
+	*/
+		down (&sem);
+		spin_lock_irq(HostAdapter->host_lock);
+		cpqfcHBAdata->notify_wt = NULL;
+	}
+	
+	LEAVE(__function__);
+	return 0;
 }
 
 
@@ -317,9 +320,8 @@ int cpqfcTS_detect(Scsi_Host_Template *S
       // each HBA on the PCI bus(ses)).
       cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
 
-      // make certain our data struct is clear
-      memset( cpqfcHBAdata, 0, sizeof( CPQFCHBA ) );
-
+      memset(cpqfcHBAdata, 0, sizeof(*cpqfcHBAdata));
+      init_completion(&cpqfcHBAdata->thr_exited);
 
       // initialize our HBA info
       cpqfcHBAdata->HBAnum = NumberOfAdapters;
@@ -712,6 +714,25 @@ int cpqfcTS_ioctl( struct scsi_device *S
   return result;
 }
 
+static int
+cpqfcTS_kill_worker(CPQFCHBA *hba)
+{
+	int ret = 0;
+
+	if(hba->thr_pid >= 0) {
+		hba->time_to_die = 1;
+		wmb();
+		ret = kill_proc(hba->thr_pid, SIGTERM, 1);
+		if (ret) {
+			printk(KERN_ERR DEV_NAME " unable to signal thread %i\n",
+				hba->thr_pid);
+		} else {
+			wait_for_completion(&hba->thr_exited);
+			hba->thr_pid = -1;
+		}
+	}
+	return ret;
+}
 
 /* "Release" the Host Bus Adapter...
    disable interrupts, stop the HBA, release the interrupt,
@@ -731,18 +752,7 @@ int cpqfcTS_release(struct Scsi_Host *Ho
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
+  cpqfcTS_kill_worker(cpqfcHBAdata);
 
   cpqfc_free_private_data_pool(cpqfcHBAdata);
   // free Linux resources
diff -aup linux-2.6.13-rc6/drivers/scsi/cpqfcTSstructs.h linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSstructs.h
--- linux-2.6.13-rc6/drivers/scsi/cpqfcTSstructs.h	2005-08-16 16:42:14.000000000 +0200
+++ linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSstructs.h	2005-08-16 16:28:53.000000000 +0200
@@ -829,7 +829,7 @@ int CpqTsReadWriteWWN(void*, int ReadWri
 int CpqTsReadWriteNVRAM(void*, void* data, int ReadWrite);
 
 void cpqfcTS_WorkTask( struct Scsi_Host *HostAdapter);
-void cpqfcTSWorkerThread( void *host);
+extern int cpqfcTSWorkerThread(void *host);
 
 int cpqfcTS_GetNVRAM_data( UCHAR *wwnbuf, UCHAR *buf );
 ULONG cpqfcTS_ReadNVRAM( void* GPIOin, void* GPIOout , USHORT count,
@@ -937,7 +937,10 @@ typedef struct 
                                   // logouts, FC protocol timeouts, etc.
   int fcStatsTime;  // Statistics delta reporting time
 
-  struct task_struct *worker_thread; // our kernel thread
+  pid_t thr_pid;	/* pid of worker thread */
+  struct completion thr_exited;	/* exit status of worker thread */
+  int time_to_die;	/* flag for worker thread to exit */
+
   int PortDiscDone;    // set by SendLogins(), cleared by LDn
   
   struct semaphore *TachFrozen;
diff -aup linux-2.6.13-rc6/drivers/scsi/cpqfcTSworker.c linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSworker.c
--- linux-2.6.13-rc6/drivers/scsi/cpqfcTSworker.c	2005-08-16 16:42:14.000000000 +0200
+++ linux-2.6.13-rc6-eike/drivers/scsi/cpqfcTSworker.c	2005-08-16 16:45:13.000000000 +0200
@@ -147,7 +147,7 @@ static void IssueReportLunsCommand( 
 
 // (see scsi_error.c comments on kernel task creation)
 
-void cpqfcTSWorkerThread( void *host)
+int cpqfcTSWorkerThread(void *host)
 {
   struct Scsi_Host *HostAdapter = (struct Scsi_Host*)host;
   CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata; 
@@ -169,10 +169,7 @@ void cpqfcTSWorkerThread( void *host)
   cpqfcHBAdata->fcQueReady = &fcQueReady;  // primary wait point
   cpqfcHBAdata->TYOBcomplete = &fcTYOBcomplete;
   cpqfcHBAdata->TachFrozen = &TachFrozen;
-    
- 
-  cpqfcHBAdata->worker_thread = current;
-  
+
   unlock_kernel();
 
   if( cpqfcHBAdata->notify_wt != NULL )
@@ -184,7 +181,9 @@ void cpqfcTSWorkerThread( void *host)
 
     down_interruptible( &fcQueReady);  // wait for something to do
 
-    if (signal_pending(current) )
+    if (signal_pending(current))
+		flush_signals(current);
+    if (cpqfcHBAdata->time_to_die)
       break;
     
     PCI_TRACE( 0x90)
@@ -225,12 +224,9 @@ void cpqfcTSWorkerThread( void *host)
     // Now, complete any Cmnd we Q'd up while BoardLock was held
 
     CompleteBoardLockCmnd( cpqfcHBAdata);
-  
-
   }
-  // hopefully, the signal was for our module exit...
-  if( cpqfcHBAdata->notify_wt != NULL )
-    up( cpqfcHBAdata->notify_wt); // yep, we're outta here
+
+	complete_and_exit(&cpqfcHBAdata->thr_exited, 0);
 }
 
 
