Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263594AbSITV1p>; Fri, 20 Sep 2002 17:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263599AbSITV1p>; Fri, 20 Sep 2002 17:27:45 -0400
Received: from dsl-213-023-039-089.arcor-ip.net ([213.23.39.89]:52637 "EHLO
	starship") by vger.kernel.org with ESMTP id <S263594AbSITV1n>;
	Fri, 20 Sep 2002 17:27:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Olien <dmo@osdl.org>
Subject: Re: [2.5] DAC960
Date: Fri, 20 Sep 2002 23:32:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
References: <E17odbY-000BHv-00@f1.mail.ru> <E17s6nH-0000xq-00@starship> <20020919150958.A27837@acpi.pdx.osdl.net>
In-Reply-To: <20020919150958.A27837@acpi.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17sVOQ-0001H8-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here's the trivial patch you need, on top of your last-posted patch, to fix 
up the one failed hunk and make it work in 2.5.37.

I cleaned up a few stylistic things to bring them in line with 
penguin-classic style, things like never writing "== true" in logical 
expressions and having line breaks in the right places.  Very minor.

Obviously, a lot more trivial cleanup is still needed, especially spelling.  
The code is pretty easy to read, though, including your code.

Daniel

--- 2.5.37.clean/drivers/block/DAC960.c	2002-09-20 23:08:09.000000000 +0200
+++ 2.5.37/drivers/block/DAC960.c	2002-09-20 23:19:47.000000000 +0200
@@ -3007,16 +3007,48 @@
   individual Buffer.
 */
 
-static inline void DAC960_ProcessCompletedBuffer(BufferHeader_T *BufferHeader,
-						 boolean SuccessfulIO)
+static inline void DAC960_ProcessCompletedRequest(DAC960_Command_T *Command,
+	boolean SuccessfulIO)
 {
-  bio_endio(BufferHeader, BufferHeader->bi_size, SuccessfulIO ? 0 : -EIO);
-  blk_finished_io(bio_sectors(BufferHeader));
+	DAC960_CommandType_T CommandType = Command->CommandType;
+	IO_Request_T *Request = Command->Request;
+	int DmaDirection, UpToDate;
+
+	UpToDate = 0;
+	if (SuccessfulIO)
+		UpToDate = 1;
+
+	/*
+	 * We could save DmaDirection in the command structure
+	 * and just reuse that information here.
+	 */
+	if (CommandType == DAC960_ReadCommand || CommandType == DAC960_ReadRetryCommand)
+		DmaDirection = PCI_DMA_FROMDEVICE;
+	else
+		DmaDirection = PCI_DMA_TODEVICE;
+
+	pci_unmap_sg(Command->PciDevice, Command->V1.ScatterList,
+		Command->SegmentCount, DmaDirection);
+
+	/*
+	 * BlockCount is redundant with nr_sectors in the request
+	 * structure.  Consider eliminating BlockCount from the
+	 * command structure now that Command includes a pointer to
+	 * the request.
+	 */
+	while (end_that_request_first(Request, UpToDate, Command->BlockCount))
+		;
+	end_that_request_last(Request);
+
+	if (Command->Completion) {
+		complete(Command->Completion);
+		Command->Completion = NULL;
+	}
 }
 
 static inline int DAC960_PartitionByCommand(DAC960_Command_T *Command)
 {
-	return DAC960_PartitionNumber(to_kdev_t(Command->BufferHeader->bi_bdev->bd_dev)); 
+	return DAC960_PartitionNumber(Command->Request->rq_dev);
 }
 
 /*
