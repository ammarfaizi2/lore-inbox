Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTBEXfl>; Wed, 5 Feb 2003 18:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTBEXfl>; Wed, 5 Feb 2003 18:35:41 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:15256 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S265169AbTBEXfh>;
	Wed, 5 Feb 2003 18:35:37 -0500
Date: Thu, 6 Feb 2003 00:45:11 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Samuel Flory <sflory@rackable.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre4aa1
Message-ID: <20030205234511.GA1563@werewolf.able.es>
References: <20030131014020.GA8395@dualathlon.random> <3E419A43.7070100@rackable.com> <20030205231627.GS19678@dualathlon.random> <3E419CB8.5090601@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3E419CB8.5090601@rackable.com>; from sflory@rackable.com on Thu, Feb 06, 2003 at 00:22:32 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.02.06 Samuel Flory wrote:
> Andrea Arcangeli wrote:
> 
> >On Wed, Feb 05, 2003 at 03:12:03PM -0800, Samuel Flory wrote:
> >  
> >
> >>Is the dac960 compile still broken?  Or did it break again?
> >>
> >>make[3]: Entering directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers/block'
> >>gcc -D__KERNEL__ -I/stuff/src/linux-2.4.21-pre4-aa1/include -Wall 
> >>-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> >>-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   
> >>-nostdinc -iwithprefix include -DKBUILD_BASENAME=DAC960  -DEXPORT_SYMTAB 
> >>-c DAC960.c
> >>DAC960.c: In function `DAC960_ProcessCompletedBuffer':
> >>DAC960.c:3029: warning: passing arg 1 of `blk_finished_io' makes pointer 
> >>from integer without a cast
> >>DAC960.c:3029: too few arguments to function `blk_finished_io'
> >>make[3]: *** [DAC960.o] Error 1
> >>make[3]: Leaving directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers/block'
> >>make[2]: *** [first_rule] Error 2
> >>make[2]: Leaving directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers/block'
> >>make[1]: *** [_subdir_block] Error 2
> >>make[1]: Leaving directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers'
> >>make: *** [_dir_drivers] Error 2
> >>    
> >>
> >
> >It was supposed to be fixed I need to re-check.. (I usually don't
> >compile it so I didn't notice sorry)
> >  
> >
> 

I still have this in -jam, grabbed from the list:

diff -ur linux-2.4.20_original/drivers/block/DAC960.c linux-2.4.20aa1/drivers/block/DAC960.c
--- linux-2.4.20_original/drivers/block/DAC960.c	Wed Dec  4 16:52:50 2002
+++ linux-2.4.20aa1/drivers/block/DAC960.c	Wed Dec  4 16:56:15 2002
@@ -19,8 +19,8 @@
 */
 
 
-#define DAC960_DriverVersion			"2.4.11"
-#define DAC960_DriverDate			"11 October 2001"
+#define DAC960_DriverVersion			"2.4.20"
+#define DAC960_DriverDate			"2003"
 
 
 #include <linux/version.h>
@@ -2975,8 +2975,9 @@
   Command->SegmentCount = Request->nr_segments;
   Command->BufferHeader = Request->bh;
   Command->RequestBuffer = Request->buffer;
+  Command->Request = Request;
   blkdev_dequeue_request(Request);
-  blkdev_release_request(Request);
+  /* blkdev_release_request(Request); */
   DAC960_QueueReadWriteCommand(Command);
   return true;
 }
@@ -3023,11 +3024,12 @@
   individual Buffer.
 */
 
-static inline void DAC960_ProcessCompletedBuffer(BufferHeader_T *BufferHeader,
+static inline void DAC960_ProcessCompletedBuffer(IO_Request_T *Req, BufferHeader_T *BufferHeader,
 						 boolean SuccessfulIO)
 {
-  blk_finished_io(BufferHeader->b_size >> 9);
+  blk_finished_io(Req, BufferHeader->b_size >> 9);
   BufferHeader->b_end_io(BufferHeader, SuccessfulIO);
+  
 }
 
 
@@ -3116,9 +3118,10 @@
 	    {
 	      BufferHeader_T *NextBufferHeader = BufferHeader->b_reqnext;
 	      BufferHeader->b_reqnext = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, true);
+	      DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, true);
 	      BufferHeader = NextBufferHeader;
 	    }
+  	  blkdev_release_request(Command->Request);
 	  if (Command->Completion != NULL)
 	    {
 	      complete(Command->Completion);
@@ -3161,7 +3164,7 @@
 	    {
 	      BufferHeader_T *NextBufferHeader = BufferHeader->b_reqnext;
 	      BufferHeader->b_reqnext = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, false);
+	      DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, false);
 	      BufferHeader = NextBufferHeader;
 	    }
 	  if (Command->Completion != NULL)
@@ -3169,6 +3172,7 @@
 	      complete(Command->Completion);
 	      Command->Completion = NULL;
 	    }
+  	  blkdev_release_request(Command->Request);
 	}
     }
   else if (CommandType == DAC960_ReadRetryCommand ||
@@ -3180,12 +3184,12 @@
 	Perform completion processing for this single buffer.
       */
       if (CommandStatus == DAC960_V1_NormalCompletion)
-	DAC960_ProcessCompletedBuffer(BufferHeader, true);
+	DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, true);
       else
 	{
 	  if (CommandStatus != DAC960_V1_LogicalDriveNonexistentOrOffline)
 	    DAC960_V1_ReadWriteError(Command);
-	  DAC960_ProcessCompletedBuffer(BufferHeader, false);
+	  DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, false);
 	}
       if (NextBufferHeader != NULL)
 	{
@@ -3203,6 +3207,7 @@
 	  DAC960_QueueCommand(Command);
 	  return;
 	}
+        blkdev_release_request(Command->Request);
     }
   else if (CommandType == DAC960_MonitoringCommand ||
 	   CommandOpcode == DAC960_V1_Enquiry ||
@@ -4222,9 +4227,10 @@
 	    {
 	      BufferHeader_T *NextBufferHeader = BufferHeader->b_reqnext;
 	      BufferHeader->b_reqnext = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, true);
+	      DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, true);
 	      BufferHeader = NextBufferHeader;
 	    }
+  	  blkdev_release_request(Command->Request);
 	  if (Command->Completion != NULL)
 	    {
 	      complete(Command->Completion);
@@ -4267,9 +4273,10 @@
 	    {
 	      BufferHeader_T *NextBufferHeader = BufferHeader->b_reqnext;
 	      BufferHeader->b_reqnext = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, false);
+	      DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, false);
 	      BufferHeader = NextBufferHeader;
 	    }
+  	  blkdev_release_request(Command->Request);
 	  if (Command->Completion != NULL)
 	    {
 	      complete(Command->Completion);
@@ -4286,12 +4293,12 @@
 	Perform completion processing for this single buffer.
       */
       if (CommandStatus == DAC960_V2_NormalCompletion)
-	DAC960_ProcessCompletedBuffer(BufferHeader, true);
+	DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, true);
       else
 	{
 	  if (Command->V2.RequestSense.SenseKey != DAC960_SenseKey_NotReady)
 	    DAC960_V2_ReadWriteError(Command);
-	  DAC960_ProcessCompletedBuffer(BufferHeader, false);
+	  DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, false);
 	}
       if (NextBufferHeader != NULL)
 	{
@@ -4319,6 +4326,7 @@
 	  DAC960_QueueCommand(Command);
 	  return;
 	}
+        blkdev_release_request(Command->Request);
     }
   else if (CommandType == DAC960_MonitoringCommand)
     {
diff -ur linux-2.4.20_original/drivers/block/DAC960.h linux-2.4.20aa1/drivers/block/DAC960.h
--- linux-2.4.20_original/drivers/block/DAC960.h	Wed Dec  4 16:52:50 2002
+++ linux-2.4.20aa1/drivers/block/DAC960.h	Wed Dec  4 16:53:13 2002
@@ -2282,6 +2282,7 @@
   unsigned int SegmentCount;
   BufferHeader_T *BufferHeader;
   void *RequestBuffer;
+  IO_Request_T *Request;
   union {
     struct {
       DAC960_V1_CommandMailbox_T CommandMailbox;
@@ -4265,12 +4266,4 @@
 static void DAC960_CreateProcEntries(void);
 static void DAC960_DestroyProcEntries(void);
 
-
-/*
-  Export the Kernel Mode IOCTL interface.
-*/
-
-EXPORT_SYMBOL(DAC960_KernelIOCTL);
-
-
 #endif /* DAC960_DriverVersion */

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))
