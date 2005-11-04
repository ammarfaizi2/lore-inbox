Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030576AbVKDDWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbVKDDWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbVKDDWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:22:35 -0500
Received: from mail.dvmed.net ([216.237.124.58]:11445 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030576AbVKDDWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:22:34 -0500
Message-ID: <436AD3F6.2050501@pobox.com>
Date: Thu, 03 Nov 2005 22:22:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [BLOCK] Unify the seperate read/write io stat fields into arrays
References: <200511021704.jA2H4X4u027306@hera.kernel.org>
In-Reply-To: <200511021704.jA2H4X4u027306@hera.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> tree fe4ce823e638ded151edcb142f28a240860f0d33
> parent d72d904a5367ad4ca3f2c9a2ce8c3a68f0b28bf0
> author Jens Axboe <axboe@suse.de> Tue, 01 Nov 2005 09:26:16 +0100
> committer Jens Axboe <axboe@suse.de> Tue, 01 Nov 2005 09:26:16 +0100
> 
> [BLOCK] Unify the seperate read/write io stat fields into arrays
> 
> Instead of having ->read_sectors and ->write_sectors, combine the two
> into ->sectors[2] and similar for the other fields. This saves a branch
> several places in the io path, since we don't have to care for what the
> actual io direction is. On my x86-64 box, that's 200 bytes less text in
> just the core (not counting the various drivers).
> 
> Signed-off-by: Jens Axboe <axboe@suse.de>
> 
>  drivers/block/genhd.c     |   29 ++++++++++++++---------------
>  drivers/block/ll_rw_blk.c |   40 ++++++++++++----------------------------
>  drivers/md/linear.c       |   10 +++-------
>  drivers/md/md.c           |    4 ++--
>  drivers/md/multipath.c    |   10 +++-------
>  drivers/md/raid0.c        |   10 +++-------
>  drivers/md/raid1.c        |   12 ++++--------
>  drivers/md/raid10.c       |   12 ++++--------
>  drivers/md/raid5.c        |   10 +++-------
>  drivers/md/raid6main.c    |   12 ++++--------
>  fs/partitions/check.c     |    7 ++++---
>  include/linux/genhd.h     |   10 +++++-----
>  12 files changed, 61 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/block/genhd.c b/drivers/block/genhd.c
> index 486ce1f..54aec4a 100644
> --- a/drivers/block/genhd.c
> +++ b/drivers/block/genhd.c
> @@ -391,13 +391,12 @@ static ssize_t disk_stats_read(struct ge
>  		"%8u %8u %8llu %8u "
>  		"%8u %8u %8u"
>  		"\n",
> -		disk_stat_read(disk, reads), disk_stat_read(disk, read_merges),
> -		(unsigned long long)disk_stat_read(disk, read_sectors),
> -		jiffies_to_msecs(disk_stat_read(disk, read_ticks)),
> -		disk_stat_read(disk, writes), 
> -		disk_stat_read(disk, write_merges),
> -		(unsigned long long)disk_stat_read(disk, write_sectors),
> -		jiffies_to_msecs(disk_stat_read(disk, write_ticks)),
> +		disk_stat_read(disk, ios[0]), disk_stat_read(disk, merges[0]),
> +		(unsigned long long)disk_stat_read(disk, sectors[0]),
> +		jiffies_to_msecs(disk_stat_read(disk, ticks[0])),
> +		disk_stat_read(disk, ios[1]), disk_stat_read(disk, merges[1]),
> +		(unsigned long long)disk_stat_read(disk, sectors[1]),
> +		jiffies_to_msecs(disk_stat_read(disk, ticks[1])),
>  		disk->in_flight,
>  		jiffies_to_msecs(disk_stat_read(disk, io_ticks)),
>  		jiffies_to_msecs(disk_stat_read(disk, time_in_queue)));
> @@ -583,12 +582,12 @@ static int diskstats_show(struct seq_fil
>  	preempt_enable();
>  	seq_printf(s, "%4d %4d %s %u %u %llu %u %u %u %llu %u %u %u %u\n",
>  		gp->major, n + gp->first_minor, disk_name(gp, n, buf),
> -		disk_stat_read(gp, reads), disk_stat_read(gp, read_merges),
> -		(unsigned long long)disk_stat_read(gp, read_sectors),
> -		jiffies_to_msecs(disk_stat_read(gp, read_ticks)),
> -		disk_stat_read(gp, writes), disk_stat_read(gp, write_merges),
> -		(unsigned long long)disk_stat_read(gp, write_sectors),
> -		jiffies_to_msecs(disk_stat_read(gp, write_ticks)),
> +		disk_stat_read(gp, ios[0]), disk_stat_read(gp, merges[0]),
> +		(unsigned long long)disk_stat_read(gp, sectors[0]),
> +		jiffies_to_msecs(disk_stat_read(gp, ticks[0])),
> +		disk_stat_read(gp, ios[1]), disk_stat_read(gp, merges[1]),
> +		(unsigned long long)disk_stat_read(gp, sectors[1]),
> +		jiffies_to_msecs(disk_stat_read(gp, ticks[1])),
>  		gp->in_flight,
>  		jiffies_to_msecs(disk_stat_read(gp, io_ticks)),
>  		jiffies_to_msecs(disk_stat_read(gp, time_in_queue)));

While the overall patch is OK, the use of magic numbers makes the code 
less readable.  fsck if I know whether "[0]" represents read or write.

Please use named constants rather than [0] and [1].

	Jeff


