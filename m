Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279446AbRJWOMw>; Tue, 23 Oct 2001 10:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279447AbRJWOMm>; Tue, 23 Oct 2001 10:12:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53443 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S279446AbRJWOM2>;
	Tue, 23 Oct 2001 10:12:28 -0400
Importance: Normal
Subject: Re: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
To: Jens Axboe <axboe@suse.de>
Cc: Martin Frey <frey@scs.ch>, "'Reto Baettig'" <baettig@scs.ch>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF98236159.2E4369EA-ON85256AEE.004D5B64@pok.ibm.com>
From: "Shailabh Nagar" <nagar@us.ibm.com>
Date: Tue, 23 Oct 2001 10:12:47 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/23/2001 10:12:48 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>On Tue, Oct 23 2001, Martin Frey wrote:
>> >I haven't seen the SGI rawio patch, but I'm assuming it used kiobufs to
>> >pass a single unit of 1 meg down at the time. Yes currently we do incur
>> >significant overhead compared to that approach.
>> >
>> Yes, it used kiobufs to get a gatherlist, setup a gather DMA out
>> of that list and submitted it to the SCSI layer. Depending on
>> the controller 1 MB could be transfered with 0 memcopies, 1 DMA,
>> 1 interrupt. 200 MB/s with 10% CPU load was really impressive.
>
>Let me repeat that the only difference between the kiobuf and the
>current approach is the overhead incurred on multiple __make_request
>calls. Given the current short queues, this isn't as bad as it used to
>be. Of course it isn't free, though.

The patch below attempts to address exactly that - reducing the number of
submit_bh/__make_request() calls made for raw I/O. The basic idea is to do
a major
part of the I/O in page sized blocks.

Comments on the idea ?


diff -Naur linux-2.4.10-v/drivers/char/raw.c
linux-2.4.10-rawvar/drivers/char/raw.c
--- linux-2.4.10-v/drivers/char/raw.c    Sat Sep 22 23:35:43 2001
+++ linux-2.4.10-rawvar/drivers/char/raw.c    Wed Oct 17 16:31:43 2001
@@ -283,6 +283,9 @@

     int       sector_size, sector_bits, sector_mask;
     int       max_sectors;
+
+    int             cursector_size, cursector_bits;
+    loff_t          startpg,endpg ;

     /*
      * First, a few checks on device size limits
@@ -304,8 +307,8 @@
     }

     dev = to_kdev_t(raw_devices[minor].binding->bd_dev);
-    sector_size = raw_devices[minor].sector_size;
-    sector_bits = raw_devices[minor].sector_bits;
+    sector_size = cursector_size = raw_devices[minor].sector_size;
+    sector_bits = cursector_bits = raw_devices[minor].sector_bits;
     sector_mask = sector_size- 1;
     max_sectors = KIO_MAX_SECTORS >> (sector_bits - 9);

@@ -325,6 +328,23 @@
     if ((*offp >> sector_bits) >= limit)
          goto out_free;

+    /* Using multiple I/O granularities
+       Divide <size> into <initial> <pagealigned> <final>
+       <initial> and <final> are done at sector_size granularity
+       <pagealigned> is done at PAGE_SIZE granularity
+       startpg, endpg define the boundaries of <pagealigned>.
+       They also serve as flags on whether PAGE_SIZE I/O is
+       done at all (its unnecessary if <size> is sufficiently small)
+    */
+
+    startpg = (*offp + (loff_t)(PAGE_SIZE - 1)) & (loff_t)PAGE_MASK ;
+    endpg = (*offp + (loff_t) size) & (loff_t)PAGE_MASK ;
+
+    if ((startpg == endpg) || (sector_size == PAGE_SIZE))
+         /* PAGE_SIZE I/O either unnecessary or being done anyway */
+         /* impossible values make startpg,endpg act as flags     */
+         startpg = endpg = ~(loff_t)0 ;
+
     /*
      * Split the IO into KIO_MAX_SECTORS chunks, mapping and
      * unmapping the single kiobuf as we go to perform each chunk of
@@ -332,9 +352,23 @@
      */

     transferred = 0;
-    blocknr = *offp >> sector_bits;
     while (size > 0) {
-         blocks = size >> sector_bits;
+
+         if (*offp  == startpg) {
+              cursector_size = PAGE_SIZE ;
+              cursector_bits = PAGE_SHIFT ;
+         }
+         else if (*offp == endpg) {
+              cursector_size = sector_size ;
+              cursector_bits = sector_bits ;
+         }
+
+         blocknr = *offp >> cursector_bits ;
+         max_sectors = KIO_MAX_SECTORS << (cursector_bits - 9) ;
+         if (limit != INT_MAX)
+              limit = (((loff_t) blk_size[MAJOR(dev)][MINOR(dev)]) <<
BLOCK_SIZE_BITS) >> cursector_bits ;
+
+         blocks = size >> cursector_bits;
          if (blocks > max_sectors)
               blocks = max_sectors;
          if (blocks > limit - blocknr)
@@ -342,7 +376,7 @@
          if (!blocks)
               break;

-         iosize = blocks << sector_bits;
+         iosize = blocks << cursector_bits;

          err = map_user_kiobuf(rw, iobuf, (unsigned long) buf, iosize);
          if (err)
@@ -351,7 +385,7 @@
          for (i=0; i < blocks; i++)
               iobuf->blocks[i] = blocknr++;

-         err = brw_kiovec(rw, 1, &iobuf, dev, iobuf->blocks, sector_size);
+         err = brw_kiovec(rw, 1, &iobuf, dev, iobuf->blocks,
cursector_size);

          if (rw == READ && err > 0)
               mark_dirty_kiobuf(iobuf, err);
@@ -360,6 +394,7 @@
               transferred += err;
               size -= err;
               buf += err;
+              *offp += err ;
          }

          unmap_kiobuf(iobuf);
@@ -369,7 +404,6 @@
     }

     if (transferred) {
-         *offp += transferred;
          err = transferred;
     }



