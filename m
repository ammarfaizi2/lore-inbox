Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbSKKSGo>; Mon, 11 Nov 2002 13:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSKKSGo>; Mon, 11 Nov 2002 13:06:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:15582 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266888AbSKKSGl>;
	Mon, 11 Nov 2002 13:06:41 -0500
Message-ID: <3DCFF341.CF26C583@digeo.com>
Date: Mon, 11 Nov 2002 10:13:21 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: kernel BUG at kernel/timer.c:333!
References: <aqj8bf$ff2$1@ncc1701.cistron.net> <3DCD5917.FEEA7C5D@digeo.com> <20021110153236.A18563@cistron.nl> <3DCE93CF.79AF516C@digeo.com> <20021111115756.A12243@cistron.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 18:13:21.0561 (UTC) FILETIME=[04ADD090:01C289AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> 
> According to Andrew Morton:
> > Miquel van Smoorenburg wrote:
> > >
> > > I've booted 2.5.46bk5 on the machine, and it has been running for over
> > > 2 hours with extra heavy diskio. That reliably crashed the machine
> > > in about 45 minutes with 2.4.45 and 2.5.46, machine is still up now.
> >
> > OK, thanks.
> 
> It survived the night and is still up. Looks like it runs slightly
> faster than 2.4.20-X.

Good, thanks.

> ..
> > mmapping a blockdev is a pretty dopey thing to do, btw.  It doesn't
> > allow the use of highmem, the IO uses tiny BIOs (in fact I think
> > it uses 512-byte or 1k blocksize too) and there are buffer_heads
> > all over the place.  You'll get better results from mmapping a
> > regular file.
> 
> It's just that the news server uses its own 'filesystem'. It does
> normal read/write i/o on it, but the allocation bitmap at the
> beginning of the 'file' is mmap()ed. Using a regular file means
> creating a 160 GB file, the triple indirect blocks will probably
> kill performance.

hm, OK.  mmapping just a little bit in that manner isn't so bad I
guess.  But the general read() and write() implementation for blockdevs
is not as efficient as that for, say, ext2 files.

Probably I could turn on the direct-to-bio stuff for blockdevs if there is
no filesystem mounted.  But with the regular open of /dev/hda1 there's no
way to prevent that.

The really scary problem is if some smarty tries to modify a blockdev
with MAP_SHARED while there's a live filesystem mounted.  Even if they
modify "safe" parts of the filesystem, this will wreck the fs if it has
blocksize < pagesize.  I'm not aware of a robust way of preventing this.
 
> I guess that means I have to resurrect rawfs, then (a filesystem
> I wrote for 2.2 that shows partitions as fixed-size files). But
> that seems so .. unnecessary.
> 

What you're doing now should be OK.
