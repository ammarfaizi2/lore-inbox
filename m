Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264495AbTCXWtB>; Mon, 24 Mar 2003 17:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264496AbTCXWtB>; Mon, 24 Mar 2003 17:49:01 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:30142 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264494AbTCXWsz> convert rfc822-to-8bit;
	Mon, 24 Mar 2003 17:48:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: dougg@torque.net
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Date: Mon, 24 Mar 2003 14:54:03 -0800
User-Agent: KMail/1.4.1
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Jens Axboe <axboe@suse.de>
References: <200303211056.04060.pbadari@us.ibm.com> <200303241332.56996.pbadari@us.ibm.com> <3E7F853B.1020603@torque.net>
In-Reply-To: <3E7F853B.1020603@torque.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303241454.03744.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 March 2003 02:22 pm, Douglas Gilbert wrote:
> Badari Pulavarty wrote:
> > On Saturday 22 March 2003 04:05 am, Andrew Morton wrote:
> >>OK, thanks.  So with 48 disks you've lost five megabytes to
> >> blkdev_requests and deadline_drq objects.  With 4000 disks, you're
> >> toast.  That's enough request structures to put 200 gigabytes of memory
> >> under I/O ;)
> >>
> >>We need to make the request structures dymanically allocated for other
> >>reasons (which I cannot immediately remember) but it didn't happen.  I
> >>guess we have some motivation now.
> >
> > Here is the list of slab caches which consumed more than 1 MB
> > in the process of inserting 4000 disks.
> >
> > #insmod scsi_debug.ko add_host=4 num_devs=1000
> >
> > deadline_drq    before:1280 after:1025420 diff:1024140 size:64
> > incr:65544960 blkdev_requests  before:1280 after:1025400 diff:1024120
> > size:156 incr:159762720
> >
> > * deadline_drq, blkdev_requests consumed almost 80 MB. We need to fix
> > this.
> >
> > inode_cache     before:700 after:140770 diff:140070 size:364
> > incr:50985480 dentry_cache    before:4977 after:145061 diff:140084
> > size:172 incr:24094448
> >
> > * inode cache increased by 50 MB, dentry cache 24 MB.
> > It looks like we cached 140,000 inodes. I wonder why ?
> >
>  > <snip/>
>
> Badari,
> What number do you get from
>   # cd /sys; du -a | wc
> when you have 4000 disks?

[root@elm3b78 sysfs]# du -a | wc -l
 140735

Okay. That explains the inodes.

>
> Also scsi_debug should use only 8 MB (default) for
> simulated storage shared between all pseudo disks
> (i.e. not 8 MB per simulated host).

Hmm. When I did
insmod scsi_debug.o add_host=1 num_devs=4000
it used 8MB. 

But when I did
insmod scsi_debug.o add_host=4 num_devs=1000
it used 32 MB. So I assumed it is per host.

Before:
size-8192              8      8   8192    8    8    2 :    8    4 :      9      
12    10    2    0    0   37 :      3     12      7      0
After:
size-8192           4010   4010   8192 4010 4010    2 :    8    4 :   4010    
4014  4012    2    0    0   37 :   4006   4014   4011      0

Thanks,
Badari



