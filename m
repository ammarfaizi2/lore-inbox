Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVAZIwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVAZIwq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVAZIwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:52:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50060 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262396AbVAZIwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:52:42 -0500
Date: Wed, 26 Jan 2005 09:52:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050126085229.GE2751@suse.de>
References: <20050123023248.263daca9.akpm@osdl.org> <1106528219.867.22.camel@boxen> <20050124204659.GB19242@suse.de> <20050124125649.35f3dafd.akpm@osdl.org> <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org> <20050126080152.GA2751@suse.de> <20050126001113.30933eef.akpm@osdl.org> <20050126084005.GB2751@suse.de> <20050126004419.26aab4a5.akpm@osdl.org> <20050126084743.GD2751@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126084743.GD2751@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26 2005, Jens Axboe wrote:
> On Wed, Jan 26 2005, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > On Wed, Jan 26 2005, Andrew Morton wrote:
> > > > Jens Axboe <axboe@suse.de> wrote:
> > > > >
> > > > > But the 2.6.11-rcX vm is still very
> > > > >  screwy, to get something close to nice and smooth behaviour I have to
> > > > >  run a fillmem every now and then to reclaim used memory.
> > > > 
> > > > Can you provide more details?
> > > 
> > > Hmm not really, I just seem to have a very large piece of
> > > non-cache/buffer memory that seems reluctant to shrink on light memory
> > > pressure.
> > 
> > If it's not pagecache then what is it? slab?
> 
> Must be, if it's reclaimable.
> 
> > > This makes the box feel sluggish, if I force reclaim by
> > > running fillmem and swapping on/off again, it feels much better.
> > 
> > before-n-after /proc/meminfo would be interesting.
> > 
> > If you actually meant that is _is_ sticky pagecache then perhaps the recent
> > mark_page_accessed() changes in filemap.c, although I'd be surprised.
> 
> I don't think it's sticky page cache, it seems to shrink just fine. This
> is my current situtation:
> 
> axboe@wiggum:/home/axboe $ free
>              total       used       free     shared    buffers cached
> Mem:       1024992    1015288       9704          0      76680 328148
> -/+ buffers/cache:     610460     414532
> Swap:            0          0          0
> 
> axboe@wiggum:/home/axboe $ cat /proc/meminfo 
> MemTotal:      1024992 kB
> MemFree:          9768 kB
> Buffers:         76664 kB
> Cached:         328024 kB
> SwapCached:          0 kB
> Active:         534956 kB
> Inactive:       224060 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:      1024992 kB
> LowFree:          9768 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:            1400 kB
> Writeback:           0 kB
> Mapped:         464232 kB
> Slab:           225864 kB
> CommitLimit:    512496 kB
> Committed_AS:   773844 kB
> PageTables:       8004 kB
> VmallocTotal: 34359738367 kB
> VmallocUsed:       644 kB
> VmallocChunk: 34359737167 kB
> HugePages_Total:     0
> HugePages_Free:      0
> Hugepagesize:     2048 kB

The (by far) two largest slab consumers are:

dentry_cache      140940 183060    216   18    1 : tunables  120   60
0 : slabdata  10170  10170      0

and

ext3_inode_cache  185494 194265    776    5    1 : tunables   54   27
0 : slabdata  38853  38853      0

there are about ~40k buffer_head entries as well.

-- 
Jens Axboe

