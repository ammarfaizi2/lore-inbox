Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283006AbRLIFMz>; Sun, 9 Dec 2001 00:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283010AbRLIFMq>; Sun, 9 Dec 2001 00:12:46 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:53980 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S283006AbRLIFMe>; Sun, 9 Dec 2001 00:12:34 -0500
Date: Sat, 8 Dec 2001 21:12:32 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: lnz@dandelion.com, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Patch(?): linux-2.5.1-pre7/drivers/block/DAC960.c compilation fixes
Message-ID: <20011208211232.A7241@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch makes linux-2.5.1-pre7/drivers/block/DAC960.c
compile.  I'm not confident in my understanding of the new "bio" system,
so it would be helpful if someone more knowledgeable about bio could
check it.  The changes are:

	1. Delete references the nonexistant MaxSectorsPerRequest field.
	   The code already sets RequestQueue->max_sectors.

	2. Replace the undefined bio_size(BufferHead) with BufferHead->bi_size
	   (in many places, which is why the diff is big).

	3. Add a missing parameter in one place, changing
		BufferHeader->bi_end_io(BufferHeader)
	   to
		BufferHeader->bi_end_io(BufferHeader, bio_sectors(BufferHeader))


	#3 is the one that I have the most doubts about.

	Anyhow, with this patch and the one that I posted for
drivers/block/xd.c, all of the x86-compatible drivers in
linux-2.5.1-pre7/drivers/block/ seem to compile (as modules, except for
rd.c, which is compiled in).

	Alas, there are about 90 other files outside of drivers/block/
that do not compile.  I will probably try to fix some of those next.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="DAC960.diff"

--- linux-2.5.1-pre7/drivers/block/DAC960.c	Fri Dec  7 19:37:41 2001
+++ linux/drivers/block/DAC960.c	Sat Dec  8 20:52:40 2001
@@ -1931,7 +1931,6 @@
 {
   int MajorNumber = DAC960_MAJOR + Controller->ControllerNumber;
   RequestQueue_T *RequestQueue;
-  int MinorNumber;
   /*
     Register the Block Device Major Number for this DAC960 Controller.
   */
@@ -1956,9 +1955,6 @@
     Initialize the Disk Partitions array, Partition Sizes array, Block Sizes
     array, and Max Sectors per Request array.
   */
-  for (MinorNumber = 0; MinorNumber < DAC960_MinorCount; MinorNumber++)
-    Controller->MaxSectorsPerRequest[MinorNumber] =
-      Controller->MaxBlocksPerCommand;
   Controller->GenericDiskInfo.part = Controller->DiskPartitions;
   Controller->GenericDiskInfo.sizes = Controller->PartitionSizes;
   blksize_size[MajorNumber] = Controller->BlockSizes;
@@ -2744,17 +2740,17 @@
 	  if (bio_data(BufferHeader) == LastDataEndPointer)
 	    {
 	      ScatterGatherList[SegmentNumber-1].SegmentByteCount +=
-		bio_size(BufferHeader);
-	      LastDataEndPointer += bio_size(BufferHeader);
+		BufferHeader->bi_size;
+	      LastDataEndPointer += BufferHeader->bi_size;
 	    }
 	  else
 	    {
 	      ScatterGatherList[SegmentNumber].SegmentDataPointer =
 		Virtual_to_Bus32(bio_data(BufferHeader));
 	      ScatterGatherList[SegmentNumber].SegmentByteCount =
-		bio_size(BufferHeader);
+		BufferHeader->bi_size;
 	      LastDataEndPointer = bio_data(BufferHeader) +
-		bio_size(BufferHeader);
+		BufferHeader->bi_size;
 	      if (SegmentNumber++ > Controller->DriverScatterGatherLimit)
 		panic("DAC960: Scatter/Gather Segment Overflow\n");
 	    }
@@ -2835,17 +2831,17 @@
 	  if (bio_data(BufferHeader) == LastDataEndPointer)
 	    {
 	      ScatterGatherList[SegmentNumber-1].SegmentByteCount +=
-		bio_size(BufferHeader);
-	      LastDataEndPointer += bio_size(BufferHeader);
+		BufferHeader->bi_size;
+	      LastDataEndPointer += BufferHeader->bi_size;
 	    }
 	  else
 	    {
 	      ScatterGatherList[SegmentNumber].SegmentDataPointer =
 		Virtual_to_Bus64(bio_data(BufferHeader));
 	      ScatterGatherList[SegmentNumber].SegmentByteCount =
-		bio_size(BufferHeader);
+		BufferHeader->bi_size;
 	      LastDataEndPointer = bio_data(BufferHeader) +
-		bio_size(BufferHeader);
+		BufferHeader->bi_size;
 	      if (SegmentNumber++ > Controller->DriverScatterGatherLimit)
 		panic("DAC960: Scatter/Gather Segment Overflow\n");
 	    }
@@ -2947,7 +2943,7 @@
   if (SuccessfulIO)
     set_bit(BIO_UPTODATE, &BufferHeader->bi_flags);
   blk_finished_io(bio_sectors(BufferHeader));
-  BufferHeader->bi_end_io(BufferHeader);
+  BufferHeader->bi_end_io(BufferHeader, bio_sectors(BufferHeader));
 }
 
 
@@ -3063,7 +3059,7 @@
 	      Command->CommandType = DAC960_WriteRetryCommand;
 	      CommandMailbox->Type5.CommandOpcode = DAC960_V1_Write;
 	    }
-	  Command->BlockCount = bio_size(BufferHeader) >> DAC960_BlockSizeBits;
+	  Command->BlockCount = BufferHeader->bi_size >> DAC960_BlockSizeBits;
 	  CommandMailbox->Type5.LD.TransferLength = Command->BlockCount;
 	  CommandMailbox->Type5.BusAddress =
 	    Virtual_to_Bus32(bio_data(BufferHeader));
@@ -3112,9 +3108,9 @@
 	  DAC960_V1_CommandMailbox_T *CommandMailbox =
 	    &Command->V1.CommandMailbox;
 	  Command->BlockNumber +=
-	    bio_size(BufferHeader) >> DAC960_BlockSizeBits;
+	    BufferHeader->bi_size >> DAC960_BlockSizeBits;
 	  Command->BlockCount =
-	    bio_size(NextBufferHeader) >> DAC960_BlockSizeBits;
+	    NextBufferHeader->bi_size >> DAC960_BlockSizeBits;
 	  Command->BufferHeader = NextBufferHeader;
 	  CommandMailbox->Type5.LD.TransferLength = Command->BlockCount;
 	  CommandMailbox->Type5.LogicalBlockAddress = Command->BlockNumber;
@@ -4160,7 +4156,7 @@
 	  if (CommandType == DAC960_ReadCommand)
 	    Command->CommandType = DAC960_ReadRetryCommand;
 	  else Command->CommandType = DAC960_WriteRetryCommand;
-	  Command->BlockCount = bio_size(BufferHeader) >> DAC960_BlockSizeBits;
+	  Command->BlockCount = BufferHeader->bi_size >> DAC960_BlockSizeBits;
 	  CommandMailbox->SCSI_10.CommandControlBits
 				 .AdditionalScatterGatherListMemory = false;
 	  CommandMailbox->SCSI_10.DataTransferSize =
@@ -4216,9 +4212,9 @@
       if (NextBufferHeader != NULL)
 	{
 	  Command->BlockNumber +=
-	    bio_size(BufferHeader) >> DAC960_BlockSizeBits;
+	    BufferHeader->bi_size >> DAC960_BlockSizeBits;
 	  Command->BlockCount =
-	    bio_size(NextBufferHeader) >> DAC960_BlockSizeBits;
+	    NextBufferHeader->bi_size >> DAC960_BlockSizeBits;
 	  Command->BufferHeader = NextBufferHeader;
 	  CommandMailbox->SCSI_10.DataTransferSize =
 	    Command->BlockCount << DAC960_BlockSizeBits;

--mYCpIKhGyMATD0i+--
