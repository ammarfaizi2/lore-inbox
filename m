Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbSKHCDt>; Thu, 7 Nov 2002 21:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266713AbSKHCDs>; Thu, 7 Nov 2002 21:03:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:57338 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266712AbSKHCDo>;
	Thu, 7 Nov 2002 21:03:44 -0500
Message-ID: <3DCB1D09.EE25507D@digeo.com>
Date: Thu, 07 Nov 2002 18:10:17 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: MdkDev <mdkdev@starman.ee>, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord success report
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee> <20021107180709.GB18866@www.kroptech.com> <32894.62.65.205.175.1036692849.squirrel@webmail.starman.ee> <20021108015316.GA1041@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2002 02:10:18.0155 (UTC) FILETIME=[FBD887B0:01C286CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> 
> ..
> dd if=/dev/hda1 of=/dev/null bs=1M
> 
> ...in parallel with...
> 
> dd if=/dev/zero of=/mnt/foo bs=1M
> 
> When you kick in the write load, the read throughput drops to < 1
> MB/sec. `vmstat 1` output below shows the transition...
> 
> --Adam
> 
>    procs                      memory      swap          io     system      cpu
>  r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
>  2  0  0   4272 112684  20356  36856    0    0     0    16 1016    72  5  0 95
>  0  1  1   4272 108476  23676  36856    0    0  3320     0 1067   224 13  4 83
>  1  0  1   4272  96656  35580  36856    0    0 11904     0 1192   474 30 39 30
>  0  1  0   4272  84836  47356  36856    0    0 11776     0 1192   463 30 42 27
>  0  1  1   4272  72956  59268  36856    0    0 11904    40 1313  1139 44 38 18
>  0  1  0   4272  61076  71044  36856    0    0 11776     0 1200   478 29 43 29
>  0  1  0   4272  49256  82828  36856    0    0 11784     0 1199   522 39 37 24
>  0  1  0   4272  37196  94732  36856    0    0 11904     0 1199   497 35 38 26
>  0  1  0   4272  25256 106508  36856    0    0 11776     0 1199   512 32 43 24
>  1  2  3   4692   2468  75604  90132    0  420  9608 10888 1189   721 19 75  6
>  0  2  3   4692   3540  46932 117580    0    0   808 10428 1093   287 30 70  0
>  0  2  3   4692   3448  42916 121624    0    0  1024  8824 1099   266 65 35  0
>  0  2  3   4692   3200  35152 129692    0    0  1024  6512 1088   294 55 45  0
>  0  2  4   4692   1564  24640 141696    0    0   768  7688 1091   277 44 56  0
>  1  1  2   4692   3492  19044 145484    0    0  1024  5956 1084   285 69 31  0

Your bandwidth there fell from 12 megs/sec to around 8.  That is
reasonable, I think.  It's just that the read-vs-write balance is
wrong for you.

Try changing drivers/block/deadline-iosched.c:fifo_batch to 16.

And the application isn't performing enough caching, perhaps.

The VM could be fairly easily changed to defer writeback if there is
read activity happening on the same spindle.  Been thinking about
that (and its relative, early flush) a bit.  But that write has
to go to disk sometime.
