Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266705AbSKHBqn>; Thu, 7 Nov 2002 20:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266707AbSKHBqn>; Thu, 7 Nov 2002 20:46:43 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:19186 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S266705AbSKHBqm>;
	Thu, 7 Nov 2002 20:46:42 -0500
Date: Thu, 7 Nov 2002 20:53:16 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: MdkDev <mdkdev@starman.ee>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord success report
Message-ID: <20021108015316.GA1041@www.kroptech.com>
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee> <20021107180709.GB18866@www.kroptech.com> <32894.62.65.205.175.1036692849.squirrel@webmail.starman.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32894.62.65.205.175.1036692849.squirrel@webmail.starman.ee>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 08:14:09PM +0200, MdkDev wrote:
> 
> > Thanks, this is good information. Was the destination for the 'dd' and
> > the source CD image on the same drive? What filesystem were you using?
> 
> Yes, destination for the dd and the source for the CD image was on the
> same drive. I'm using ext3 filesystem.
>
> > I notice you used a 4x writer...I'll try lowering my write speed to 4x
> > and see if that makes a difference. I'll also see if I can rig up an
> > IDE disk instead of SCSI.
> 
> The burner is capable of writing 16x (CDR) or 10x (CDRW) but the speed was
> 4x in this case because of the media. I'll try and repeat the test using
> max speed.

I've done some more testing and narrowed the problem down a little. I
switched to an IDE drive to rule out SCSI and found that the problem is
still with me: a parallel `dd` to the image source drive still kills burn.

Then I lowered the write speed from 12x down to 4x to match yours...and
then the problem went away. A look at `vmstat 1` shows that the heavy
write load causes the read throughput to drop to about 768 KB/sec.
That's far too slow for 12x but is just about right for 4x. Makes sense,
then that a 4x burn survives.

It's easy to duplicate without involving cdrecord at all. Just do...

dd if=/dev/hda1 of=/dev/null bs=1M

...in parallel with...

dd if=/dev/zero of=/mnt/foo bs=1M

When you kick in the write load, the read throughput drops to < 1
MB/sec. `vmstat 1` output below shows the transition...

--Adam

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 2  0  0   4272 112684  20356  36856    0    0     0    16 1016    72  5  0 95
 0  1  1   4272 108476  23676  36856    0    0  3320     0 1067   224 13  4 83
 1  0  1   4272  96656  35580  36856    0    0 11904     0 1192   474 30 39 30
 0  1  0   4272  84836  47356  36856    0    0 11776     0 1192   463 30 42 27
 0  1  1   4272  72956  59268  36856    0    0 11904    40 1313  1139 44 38 18
 0  1  0   4272  61076  71044  36856    0    0 11776     0 1200   478 29 43 29
 0  1  0   4272  49256  82828  36856    0    0 11784     0 1199   522 39 37 24
 0  1  0   4272  37196  94732  36856    0    0 11904     0 1199   497 35 38 26
 0  1  0   4272  25256 106508  36856    0    0 11776     0 1199   512 32 43 24
 1  2  3   4692   2468  75604  90132    0  420  9608 10888 1189   721 19 75  6
 0  2  3   4692   3540  46932 117580    0    0   808 10428 1093   287 30 70  0
 0  2  3   4692   3448  42916 121624    0    0  1024  8824 1099   266 65 35  0
 0  2  3   4692   3200  35152 129692    0    0  1024  6512 1088   294 55 45  0
 0  2  4   4692   1564  24640 141696    0    0   768  7688 1091   277 44 56  0
 1  1  2   4692   3492  19044 145484    0    0  1024  5956 1084   285 69 31  0
 0  2  3   4692   3492  12020 152448    0    0   768  7192 1085   298 55 45  0
 0  2  3   4692   3432  12444 152056    0    0   676  6852 1086   266 55 45  0
 0  2  3   4692   3612  12196 152288    0    0   768  5724 1083   287 55 45  0
 0  2  3   4692   3552  12580 151900    0    0   768  7756 1088   272 65 35  0
 2  2  3   4692   3492  12840 152048    0    0  1024  5032 1195   691 66 34  0
 0  2  3   4692   3792  13304 151212    0    0   772  7452 1191   586 60 40  0

