Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268152AbRGWIjp>; Mon, 23 Jul 2001 04:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268151AbRGWIjg>; Mon, 23 Jul 2001 04:39:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49931 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S268149AbRGWIjX>;
	Mon, 23 Jul 2001 04:39:23 -0400
Date: Mon, 23 Jul 2001 10:39:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling kernel 2.4.7 with gcc 2.96
Message-ID: <20010723103918.M3969@suse.de>
In-Reply-To: <01072218512400.13385@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <01072218512400.13385@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 22 2001, Peter Klotz wrote:
> DAC960.c: In function `DAC960_ProcessRequest':
> DAC960.c:2771: structure has no member named `sem'

Attached patch should work

-- 
Jens Axboe


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=DAC960-completion-1

--- linux/drivers/block/DAC960.c~	Fri Jul 20 09:18:43 2001
+++ linux/drivers/block/DAC960.c	Fri Jul 20 09:18:44 2001
@@ -40,6 +40,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/pci.h>
+#include <linux/completion.h>
 #include <asm/io.h>
 #include <asm/segment.h>
 #include <asm/uaccess.h>
@@ -484,14 +485,14 @@
 static void DAC960_ExecuteCommand(DAC960_Command_T *Command)
 {
   DAC960_Controller_T *Controller = Command->Controller;
-  DECLARE_MUTEX_LOCKED(Semaphore);
+  DECLARE_COMPLETION(Wait);
   unsigned long ProcessorFlags;
-  Command->Semaphore = &Semaphore;
+  Command->Waiting = &Wait;
   DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
   DAC960_QueueCommand(Command);
   DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
   if (in_interrupt()) return;
-  down(&Semaphore);
+  wait_for_completion(&Wait);
 }
 
 
@@ -1316,7 +1317,7 @@
 						 *Controller)
 {
   DAC960_V1_DCDB_T DCDBs[DAC960_V1_MaxChannels], *DCDB;
-  Semaphore_T Semaphores[DAC960_V1_MaxChannels], *Semaphore;
+  Completion_T Wait[DAC960_V1_MaxChannels], *wait;
   unsigned long ProcessorFlags;
   int Channel, TargetID;
   for (TargetID = 0; TargetID < Controller->Targets; TargetID++)
@@ -1327,12 +1328,12 @@
 	  DAC960_SCSI_Inquiry_T *InquiryStandardData =
 	    &Controller->V1.InquiryStandardData[Channel][TargetID];
 	  InquiryStandardData->PeripheralDeviceType = 0x1F;
-	  Semaphore = &Semaphores[Channel];
-	  init_MUTEX_LOCKED(Semaphore);
+	  wait = &Wait[Channel];
+	  init_completion(wait);
 	  DCDB = &DCDBs[Channel];
 	  DAC960_V1_ClearCommand(Command);
 	  Command->CommandType = DAC960_ImmediateCommand;
-	  Command->Semaphore = Semaphore;
+	  Command->Waiting = wait;
 	  Command->V1.CommandMailbox.Type3.CommandOpcode = DAC960_V1_DCDB;
 	  Command->V1.CommandMailbox.Type3.BusAddress = Virtual_to_Bus32(DCDB);
 	  DCDB->Channel = Channel;
@@ -1363,11 +1364,11 @@
 	  DAC960_SCSI_Inquiry_UnitSerialNumber_T *InquiryUnitSerialNumber =
 	    &Controller->V1.InquiryUnitSerialNumber[Channel][TargetID];
 	  InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;
-	  Semaphore = &Semaphores[Channel];
-	  down(Semaphore);
+	  wait = &Wait[Channel];
+	  wait_for_completion(wait);
 	  if (Command->V1.CommandStatus != DAC960_V1_NormalCompletion)
 	    continue;
-	  Command->Semaphore = Semaphore;
+	  Command->Waiting = wait;
 	  DCDB = &DCDBs[Channel];
 	  DCDB->TransferLength = sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T);
 	  DCDB->BusAddress = Virtual_to_Bus32(InquiryUnitSerialNumber);
@@ -1381,7 +1382,7 @@
 	  DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
 	  DAC960_QueueCommand(Command);
 	  DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
-	  down(Semaphore);
+	  wait_for_completion(wait);
 	}
     }
   return true;
@@ -2768,7 +2769,7 @@
   if (Request->cmd == READ)
     Command->CommandType = DAC960_ReadCommand;
   else Command->CommandType = DAC960_WriteCommand;
-  Command->Semaphore = Request->sem;
+  Command->Waiting = Request->waiting;
   Command->LogicalDriveNumber = DAC960_LogicalDriveNumber(Request->rq_dev);
   Command->BlockNumber =
     Request->sector
@@ -2924,10 +2925,10 @@
 	  /*
 	    Wake up requestor for swap file paging requests.
 	  */
-	  if (Command->Semaphore != NULL)
+	  if (Command->Waiting)
 	    {
-	      up(Command->Semaphore);
-	      Command->Semaphore = NULL;
+	      complete(Command->Waiting);
+	      Command->Waiting = NULL;
 	    }
 	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
 	}
@@ -2969,13 +2970,10 @@
 	      DAC960_ProcessCompletedBuffer(BufferHeader, false);
 	      BufferHeader = NextBufferHeader;
 	    }
-	  /*
-	    Wake up requestor for swap file paging requests.
-	  */
-	  if (Command->Semaphore != NULL)
+	  if (Command->Waiting)
 	    {
-	      up(Command->Semaphore);
-	      Command->Semaphore = NULL;
+	      complete(Command->Waiting);
+	      Command->Waiting = NULL;
 	    }
 	}
     }
@@ -3589,8 +3587,8 @@
     }
   if (CommandType == DAC960_ImmediateCommand)
     {
-      up(Command->Semaphore);
-      Command->Semaphore = NULL;
+      complete(Command->Waiting);
+      Command->Waiting = NULL;
       return;
     }
   if (CommandType == DAC960_QueuedCommand)
@@ -3931,13 +3929,10 @@
 	      DAC960_ProcessCompletedBuffer(BufferHeader, true);
 	      BufferHeader = NextBufferHeader;
 	    }
-	  /*
-	    Wake up requestor for swap file paging requests.
-	  */
-	  if (Command->Semaphore != NULL)
+	  if (Command->Waiting)
 	    {
-	      up(Command->Semaphore);
-	      Command->Semaphore = NULL;
+	      complete(Command->Waiting);
+	      Command->Waiting = NULL;
 	    }
 	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
 	}
@@ -3979,13 +3974,10 @@
 	      DAC960_ProcessCompletedBuffer(BufferHeader, false);
 	      BufferHeader = NextBufferHeader;
 	    }
-	  /*
-	    Wake up requestor for swap file paging requests.
-	  */
-	  if (Command->Semaphore != NULL)
+	  if (Command->Waiting)
 	    {
-	      up(Command->Semaphore);
-	      Command->Semaphore = NULL;
+	      complete(Command->Waiting);
+	      Command->Waiting = NULL;
 	    }
 	}
     }
@@ -4539,8 +4531,8 @@
     }
   if (CommandType == DAC960_ImmediateCommand)
     {
-      up(Command->Semaphore);
-      Command->Semaphore = NULL;
+      complete(Command->Waiting);
+      Command->Waiting = NULL;
       return;
     }
   if (CommandType == DAC960_QueuedCommand)
--- linux/drivers/block/DAC960.h~	Fri Jul 20 09:14:39 2001
+++ linux/drivers/block/DAC960.h	Fri Jul 20 09:14:48 2001
@@ -2153,7 +2153,7 @@
 typedef struct pt_regs Registers_T;
 typedef struct request IO_Request_T;
 typedef request_queue_t RequestQueue_T;
-typedef struct semaphore Semaphore_T;
+typedef struct completion Completion_T;
 typedef struct super_block SuperBlock_T;
 typedef struct timer_list Timer_T;
 typedef wait_queue_head_t WaitQueue_T;
@@ -2220,7 +2220,7 @@
   DAC960_CommandType_T CommandType;
   struct DAC960_Controller *Controller;
   struct DAC960_Command *Next;
-  Semaphore_T *Semaphore;
+  Completion_T *Waiting;
   unsigned int LogicalDriveNumber;
   unsigned int BlockNumber;
   unsigned int BlockCount;

--7JfCtLOvnd9MIVvH--
