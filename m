Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266673AbRGTHVJ>; Fri, 20 Jul 2001 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266684AbRGTHVB>; Fri, 20 Jul 2001 03:21:01 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:32269 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S266673AbRGTHUv>; Fri, 20 Jul 2001 03:20:51 -0400
Date: Fri, 20 Jul 2001 09:22:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, linux-scsi@vger.kernel.org,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
Message-ID: <20010720092202.A9525@suse.de>
In-Reply-To: <Pine.LNX.4.33.0107192208070.14141-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107192208070.14141-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19 2001, Linus Torvalds wrote:
> 
> I'm getting ready to do a 2.4.7, but one of the fixes in 2.4.7 is a nasty
> SMP race that was found and made it clear that using an old trick of
> having a semaphore on the stack and doing "down()" on it to wait for some
> event (that would do the "up()") was a really bad idea.

Attached are two patches -- one that should fix DAC960 for this new
completion scheme, and one that corrects the corrected comment in
blkdev.h :-)

-- 
Jens Axboe


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=DAC960-completion-1

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

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=blkdev-1

--- linux/include/linux/blkdev.h~	Fri Jul 20 09:20:02 2001
+++ linux/include/linux/blkdev.h	Fri Jul 20 09:20:14 2001
@@ -14,9 +14,7 @@
 
 /*
  * Ok, this is an expanded form so that we can use the same
- * request for paging requests when that is implemented. In
- * paging, 'bh' is NULL, and the completion is used to wait
- * for the IO to be ready.
+ * request for paging requests.
  */
 struct request {
 	struct list_head queue;

--4Ckj6UjgE2iN1+kY--
