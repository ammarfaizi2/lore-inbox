Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTEaKoY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 06:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTEaKoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 06:44:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33930 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264271AbTEaKoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 06:44:19 -0400
Date: Sat, 31 May 2003 12:57:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
Message-ID: <20030531105742.GC9561@suse.de>
References: <3ED86687.6000805@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED86687.6000805@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31 2003, Douglas Gilbert wrote:
> Jens Axboe wrote:
> > On Fri, May 30 2003, Markus Plail wrote:
> > > On Fri, 30 May 2003, Markus Plail wrote:
> > >
> > > > The patch makes readcd work just fine here :-) Many thanks!
> > >
> > > Just realized that C2 scans don't yet work.
> >
> > Updated patch, please give that a shot. These sense_len wasn't
> > being set correctly.
> 
> Jens,
> At the end of this post is an incremental patch on
> top of your most recent one.

(Douglas, please don't sent seperate identical mails in private and to
the lists, it's silly having to reply twice to the same mail).

> Here are some timing and CPU utilization numbers on the
> combined patches. Reading
> 1 GB data from the beginning of a Fujitsu MAM3184MP SCSI
> disk whose streaming speed for outer zones is about
> 57 MB/sec (according to Storage Review). Each atomic read
> is 64 KB (and "of=." is sg_dd shorthand for "of=/dev/null").
> 
> Here is a normal read (i.e. treating /dev/sda as a normal file):
>  $ /usr/bin/time sg_dd if=/dev/sda of=. bs=512 time=1 count=2M
>  time to transfer data was 17.821534 secs, 57.46 MB/sec
>  0.00user 4.37system 0:17.82elapsed 24%CPU
> 
> The transfer time is a little fast due to cache hits. The
> 24% CPU utilization is the price paid for those cache hits.
> 
> Next using O_DIRECT:
>  $ /usr/bin/time sg_dd if=/dev/sda of=. bs=512 time=1 count=2M
>      odir=1
>  time to transfer data was 18.003662 secs, 56.88 MB/sec
>  0.00user 0.52system 0:18.00elapsed 2%CPU
> 
> The time to transfer is about right and the CPU utilization is
> down to 2% (0.52 seconds).
> 
> Next using the block layer SG_IO command:
>  $ /usr/bin/time sg_dd if=/dev/sda of=. bs=512 time=1 count=2M
>      blk_sgio=1
>  time to transfer data was 18.780551 secs, 54.52 MB/sec
>  0.00user 6.40system 0:18.78elapsed 34%CPU
> 
> The throughput is worse and the CPU utilization is now
> worse than a normal file.
>
> Setting the "dio=1" flag in sg_dd page aligns its buffers
> which causes bio_map_user() to succeed (in
> drivers/block/scsi_ioctl.c:sg_io()). In other words it turns
> on direct I/O:
>  $ /usr/bin/time sg_dd if=/dev/sda of=. bs=512 time=1 count=2M
>      blk_sgio=1 dio=1
>  time to transfer data was 17.899802 secs, 57.21 MB/sec
>  0.00user 0.31system 0:17.90elapsed 1%CPU

This looks fine, a performance critical app should align the buffers to
get zero copy operation.

> So this result is comparable with O_DIRECT on the normal
> file. CPU utilization is down to 1% (0.31 seonds).

A smidgen faster, it seems.

> With the latest changes from Jens (mainly dropping the
> artificial 64 KB per operation limit) the maximum
> element size in the block layer SG_IO is:
>   - 128 KB when direct I/O is not used (i.e. the user
>     space buffer does not meet bio_map_user()'s
>     requirements). This seems to be the largest buffer
>     kmalloc() will allow (in my tests)

Correct.

>   - (sg_tablesize * page_size) when direct I/O is used.
>     My test was with the sym53c8xx_2 driver in which
>     sg_tablesize==96 so my largest element size was 384 KB

Or ->max_sectors << 9, whichever is smallest. Really, the limits are in
the queue. Don't confuse SCSI with block.

> Incremental patch (on top of Jens's 2nd patch in this
> thread) changelog:
>   - change version number (effectively to 3.7.29) so
>     apps can distinguish if the want (current sg driver
>     version is 3.5.29). The main thing that app do is
>     check the version >= 3.0.0 as that implies the
>     SG_IO ioctl is there.

Agree

>   - reject requests for mmap()-ed I/O with a "not
>     supported error"

Agree

>   - if direct I/O is requested, send back via info
>     field whether it was done (or fell back to indirect
>     I/O). This is what happens in the sg driver.

Agree

>   - ultra-paranoid buffer zeroing (in padding at end)

Pointless, we wont be copying that data back. So it's a waste of cycles.

-- 
Jens Axboe

