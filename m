Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUACTNe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUACTNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:13:33 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:12673 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263742AbUACTNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:13:04 -0500
Date: Sat, 3 Jan 2004 20:14:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Jens Axboe <axboe@suse.de>, packet-writing <packet-writing@suse.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
Message-ID: <20040103191414.GE1080@elf.ucw.cz>
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I thought some people here might find this amusing. After I
> > > > quick-formatted a CD-RW with cdrwtool today I then did the
> > > > following:
> > > > 
> > > > mke2fs -b 2048 /dev/pktcdvd0
> > > > 
> > > > It appears to work OK and I'm compiling a kernel on it as I type
> > > > this. pktcdvd can't handle this properly unless the '-b 2048' is
> > > > given for a pretty obvious reason. df tells me that the capacity of
> > > > a disc formatted like this is 530MB so there is a few MB lost
> > > > compared to UDF. I'm pretty sure this is a follish thing to do so
> > > > would anyone care to give me some technical reasons why? :)
> > > 
> > > Yes, I have tested this too. It works in 2.4 but not in 2.5. In 2.5
> > > sr.c complains about unaligned transfers when I try to mount the
> > > filesystem. 2.4 has code (sr_scatter_pad) to handle unaligned
> > > transfers, but that code was removed in 2.5, and I havn't yet
> > > investigated how it is supposed to work without that code.
> > 
> > There's supposed to be a reblocking player in the middle, ala loop. This
> > doesn't really work well for pktcdvd of course, so I'd suggest writing a
> > helper for reading and writing sub-block size units.
> 
> I finally decided to investigate why this didn't work in the 2.5/2.6 code.
> (My tests were made with the 2.6.1-rc1 code and the latest packet patch.)
> There are two problems. The first is that the packet writing code forgot
> to set the hardsect size. This is fixed by the following patch.
> 
> --- linux/drivers/block/pktcdvd.c.old	2004-01-02 00:23:57.000000000 +0100
> +++ linux/drivers/block/pktcdvd.c	2004-01-02 00:24:01.000000000 +0100
> @@ -2164,6 +2164,7 @@
>  	request_queue_t *q = disks[pkt_get_minor(pd)]->queue;
>  
>  	blk_queue_make_request(q, pkt_make_request);
> +	blk_queue_hardsect_size(q, CD_FRAMESIZE);
>  	blk_queue_max_sectors(q, PACKET_MAX_SECTORS);
>  	blk_queue_merge_bvec(q, pkt_merge_bvec);
>  	q->queuedata = pd;
> 

Where do I get this file? It does not appear to be in 2.6.0.

[I have few partly-bad cd-rws, and putting ext2 on them would be
"cool" :-)]

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
