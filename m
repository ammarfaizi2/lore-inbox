Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWHQUGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWHQUGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWHQUGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:06:30 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:39389 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030237AbWHQUG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:06:29 -0400
Date: Thu, 17 Aug 2006 16:03:24 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [bug?] raid1 integrity checking is broken on 2.6.18-rc4
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Message-ID: <200608171605_MC3-1-C870-8190@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <17632.5294.559058.66914@cse.unsw.edu.au>

On Mon, 14 Aug 2006 16:14:06 +1000, Neil Brown wrote:

> > On 2.6.18-rc4 + the below patch:
> >         Drive activity light blinks once on one drive, then the
> >         array status prints (obviously no checking takes place.)
> > 
> 
> Thanks for the report.
> Easily duplicated, easily fixed.
> I'll make sure this patch gets into 2.6.18.
> 
> Thanks again,
> NeilBrown
> 

I just tried the patch and now it seems to be syncing the drives instead
of only checking them?  (At the very least the message is misleading.)

 # echo "check" >/sys/block/md0/md/sync_action
 # dmesg | tail -9
 md: syncing RAID array md0
 md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
 md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
 md: using 128k window, over a total of 104256 blocks.
 md: md0: sync done.
 RAID1 conf printout:
  --- wd:2 rd:2
  disk 0, wo:0, o:1, dev:hda9
  disk 1, wo:0, o:1, dev:sda5


> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
> --- .prev/drivers/md/raid1.c  2006-07-31 17:24:36.000000000 +1000
> +++ ./drivers/md/raid1.c      2006-08-14 15:52:48.000000000 +1000
> @@ -1644,15 +1644,16 @@ static sector_t sync_request(mddev_t *md
>               return 0;
>       }
>  
> -     /* before building a request, check if we can skip these blocks..
> -      * This call the bitmap_start_sync doesn't actually record anything
> -      */
>       if (mddev->bitmap == NULL &&
>           mddev->recovery_cp == MaxSector &&
> +         !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
>           conf->fullsync == 0) {
>               *skipped = 1;
>               return max_sector - sector_nr;
>       }
> +     /* before building a request, check if we can skip these blocks..
> +      * This call the bitmap_start_sync doesn't actually record anything
> +      */
>       if (!bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, 1) &&
>           !conf->fullsync && !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery)) {
>               /* We can skip this block, and probably several more */

-- 
Chuck
