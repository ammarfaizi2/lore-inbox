Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbUC2EEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUC2EEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:04:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4745 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262597AbUC2EEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:04:04 -0500
Message-ID: <40679FE3.3080007@pobox.com>
Date: Sun, 28 Mar 2004 23:02:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random>
In-Reply-To: <20040329005502.GG3039@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Sun, Mar 28, 2004 at 01:59:51PM -0500, Jeff Garzik wrote:
> 
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>>On Sunday 28 of March 2004 20:30, Jens Axboe wrote:
>>>
>>>>Making something user tunable is usually not the best idea, if you can
>>>>deduct these things automagically instead. So whether this is the best
>>>>idea, depends on which way you want to go.
>>>
>>>
>>>I think it's the best idea for now, long-term we are better with automagic.
>>
>>
>>Mostly agreed:
>>
>>Like I mentioned in the last message, the IO scheduler and the VM should 
> 
> 
> this is not an I/O scheduler or VM issue.

This involves the interaction of three:  blkdev layer, IO scheduler, and VM.

VM:  initiates most of the writeback, and is often the main initiator of 
large requests.  The VM thresholds also serve to keep request size 
manageable.  See e.g.
http://marc.theaimsgroup.com/?l=linux-kernel&m=108043321326801&w=2

IO scheduler:  the place to make the decision about whether the request 
latency is meeting expectations, etc.  It should be straightforward to 
use a windowing algorithm to slowly increase the request size until (a) 
latency limits are reached, (b) hardware limits are reached, or (c) VM 
thresholds are reached.

Ultimately there must be some -global- management of I/O, otherwise VM 
cannot survive, e.g. 128k requests on 1000 disks :)


> the max size of a request is something that should be set internally to
> the blkdev layer (at a lower level than the I/O scheduler or the VM
> layer).

Yes, I agree.

My point is there are two maximums:

1) the hardware limit
2) the limit that "makes sense", e.g. 512k or 1M for most

The driver should only care about #1, and should be "told" #2.

A very, very, very minimal implementation could be this:

--- 1.138/include/linux/blkdev.h        Fri Mar 12 04:33:07 2004
+++ edited/include/linux/blkdev.h       Sun Mar 28 22:44:15 2004
@@ -607,6 +607,24 @@

  extern void drive_stat_acct(struct request *, int, int);

+#define BLK_DISK_MAX_SECTORS   2048
+#define BLK_FLOPPY_MAX_SECTORS 64


Hardcoding such a maximum in the driver is inflexible and IMO incorrect.


> If one day things will change and the harddisk will require 32M large
> DMA transactions to keep up with the speed of the disk, the thing should
> be still solved during disk discovery inside the blkdev layer. The

32M is probably too large, but 1M is probably too small for:
a RAID array with 33 disks, that presents itself as a single SATA disk.
solid-state storage:  battery-backed RAM.

These things like bigger requests, and were designed to solve a lot of 
the latency problems in hardware.


> "automagic" suggestions discussed by Jamie and Jens should be just
> benchmarks internal to the blkdev layer, trying to read contigously
> first with 1M then 2M then 4M etc..  until the speed difference goes
> below 1% or whatever similar "autotune" algorithm.

Yes, agreed.

My main goal is to -not- worry about this in the low-level driver.   If 
you and Jens think 1M requests are maximum for disks, then put that in 
the _blkdev_ layer not my driver :)

Long term, I would like to see something like

--- 1.138/include/linux/blkdev.h        Fri Mar 12 04:33:07 2004
+++ edited/include/linux/blkdev.h       Sun Mar 28 23:01:42 2004
@@ -337,7 +337,8 @@
          */
         unsigned long           nr_requests;    /* Max # of requests */

-       unsigned short          max_sectors;
+       unsigned short          max_sectors;    /* blk layer-chosen */
+       unsigned short          max_hw_sectors; /* hardware limit */
         unsigned short          max_phys_segments;
         unsigned short          max_hw_segments;


