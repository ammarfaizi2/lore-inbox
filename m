Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSGIQ5l>; Tue, 9 Jul 2002 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSGIQ5k>; Tue, 9 Jul 2002 12:57:40 -0400
Received: from ds217-115-141-141.dedicated.hosteurope.de ([217.115.141.141]:27397
	"EHLO ds217-115-141-141.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id <S316605AbSGIQ5h>; Tue, 9 Jul 2002 12:57:37 -0400
Date: Tue, 9 Jul 2002 19:00:19 +0200
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: Thunder from the hill <thunder@ngforever.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Bill Davidsen <davidsen@tmr.com>, Andries Brouwer <aebr@win.tue.nl>,
       Adrian Bunk <bunk@fs.tum.de>, Jochen Suckfuell <jo-lkml@suckfuell.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Disk IO statistics still buggy
Message-ID: <20020709190019.A19394@ds217-115-141-141.dedicated.hosteurope.de>
References: <20020706074824.GA24771@win.tue.nl> <Pine.LNX.4.44.0207060740020.10105-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207060740020.10105-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Sat, Jul 06, 2002 at 07:42:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Jul 06, 2002 at 07:42:42AM -0600, Thunder from the hill wrote:
> On Sat, Jul 06, 2002 at 12:15:47AM -0400, Bill Davidsen wrote:
> > > Marcelos' BK repository (that will become 2.4.19-rc2) includes a patch to
> > > remove these statistics completely from /proc/partitions...
> > 
> > Is this the new Linux way of life? Removing modules is hard, GET RID OF
> > THE FEATURE! Stats in /proc/partitions are not always correct, GET RID OF
> > THE FEATURE!
> 
> You misunderstood. It was nothing incorrect about the stats in 
> /proc/partitions, it was just moved because it just didn't belong into 
> /proc/partitions.

And it hasn't been removed either. Only the output has been removed; the
data is still collected. Meanwhile I found the bug that leads to wrong
ios_in_flight values on SCSI systems:

The accounting was done on a copy of the request _after_ the request has
been dequeued and the irq_request_lock released. I fixed this by taking
this lock again while calling the accounting function (see the patch
below).

** This patch is relevant regardless where the statistics will finally
be printed. **

One issue is still left: on my non-SCSI machine, the ios_in_flight value
is at -1 when although requests are running. It doesn't get any more
wrong than that it seems, and I'm not sure where that happened. Maybe
something went wrong when initializing this value at boot time? I have a
workaround that corrects negative ios_in_flight values to zero each time
/proc/partitions is read. After further testing I will post it to the
list.

Bye
Jochen Suckfüll

-- 
Jochen Suckfuell  ---  http://www.suckfuell.net/jochen/  ---

--- linux/drivers/scsi/scsi_lib.c Mon Jul  8 16:15:27 2002
+++ linux_work/drivers/scsi/scsi_lib.c Tue Jul  9 17:56:39 2002
@@ -426,7 +426,9 @@
   if (req->waiting != NULL) {
    complete(req->waiting);
   }
+  spin_lock_irq(&io_request_lock);
   req_finished_io(req);
+  spin_unlock_irq(&io_request_lock);
   add_blkdev_randomness(MAJOR(req->rq_dev));
 
         SDpnt = SCpnt->device;


