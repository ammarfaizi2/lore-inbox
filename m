Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSGEGuG>; Fri, 5 Jul 2002 02:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSGEGuF>; Fri, 5 Jul 2002 02:50:05 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55049
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315456AbSGEGuE>; Fri, 5 Jul 2002 02:50:04 -0400
Date: Thu, 4 Jul 2002 23:51:02 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
       sullivan@austin.ibm.com
Subject: Re: [BUG-2.5.24-BK] DriverFS panics on boot!
In-Reply-To: <20020705063401.GI1007@suse.de>
Message-ID: <Pine.LNX.4.10.10207042343400.23359-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002, Jens Axboe wrote:

> On Thu, Jul 04 2002, Andre Hedrick wrote:
> > 	1) 8K writes and 64K (or larger) reads.
> 
> I've heard this before, but noone seems to have tested it yet. You know,
> this is a couple of lines of change in ll_rw_blk.c and blkdev.h to
> support this. Any reason you haven't done that, benched, and submitted
> something to that effect? I'll even walk you through the 2.5 changes
> needed to do this:


[root@localhost mnt2]# bonnie -s 256
Bonnie 1.2: File './Bonnie.1557', size: 268435456, volumes: 1
Writing with putc()...         done:  21846 kB/s  98.0 %CPU
Rewriting...                   done:  11099 kB/s   3.1 %CPU
Writing intelligently...       done:  58316 kB/s  14.0 %CPU
Reading with getc()...         done:  14346 kB/s  64.6 %CPU
Reading intelligently...       done:  18026 kB/s   2.0 %CPU
Seeker 1...Seeker 3...Seeker 2...start 'em...done...done...done...
              ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
localh 1* 256 21846 98.0 58316 14.0 11099  3.1 14346 64.6 18026  2.0  939.3  1.4

Yeah "bonnie" is a mickey mouse benchmark.

[root@localhost mnt2]# bonnie -s 1024
Bonnie 1.2: File './Bonnie.1598', size: 1073741824, volumes: 1
Writing with putc()...         done:  20760 kB/s  97.8 %CPU
Rewriting...                   done:  11462 kB/s   3.2 %CPU
Writing intelligently...       done:  31044 kB/s   7.6 %CPU
Reading with getc()...         done:  15006 kB/s  69.2 %CPU
Reading intelligently...       done:  15993 kB/s   1.6 %CPU
Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
              ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
localh 1*1024 20760 97.8 31044  7.6 11462  3.2 15006 69.2 15993  1.6  159.4  0.5


Using the hardware to help us and by working with it it, once can
basically boost the write and slash the cpu usage.

> blkdev.h:
> 	unsigned short max_sectors;
> 
> change to
> 
> 	unsigned short max_sectors[2];
> 
> ll_rw_blk.c:
> 	ll_back_merge_fn()
> 	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
> 
> change to
> 
> 	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors[rq_data_dir[req]) {
> 
> Ditto for ll_front_merge_fn() and ll_merge_requests_fn(). The line in
> attempt_merge() can be killed.
> 
> 	generic_make_request()
> 	BUG_ON(bio_sectors(bio) > q->max_sectors);
> 
> change to
> 
> 	BUG_ON(bio_sectors(bio) > q->max_sectors[bio_data_dir(bio)];
> 
> And do the trivial thing to blk_queue_max_sectors() as well. Now all you
> need to do is change ide-probe.c to set the values you want.
> 
> > 	2) ONE maybe TWO passes on elevator operations.
> 
> Explain.

On writes restrict which are small the ordering is almost instant.
Specifically ONE maybe TWO passes will sort.

Reads may need more as we optimize best on big reads.


> > Since this is falling on deaf ears in general, oh well.
> 
> How so?

*BLINK*

It has been generally been ignored so I am glad to see a change, thanks!

I do not do 2.5, remember I go booted and backstabbed.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

