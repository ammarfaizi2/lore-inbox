Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUBZNmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBZNmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:42:52 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:54975 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262727AbUBZNmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:42:47 -0500
Date: Thu, 26 Feb 2004 11:23:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 - large inode_cache
In-Reply-To: <20040226130344.GP29776@unthought.net>
Message-ID: <Pine.LNX.4.58L.0402261109190.5003@logos.cnet>
References: <20040226013313.GN29776@unthought.net> <20040226111912.GB4554@core.home>
 <Pine.LNX.4.58L.0402261004310.5003@logos.cnet> <20040226130344.GP29776@unthought.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Jakob Oestergaard wrote:

> On Thu, Feb 26, 2004 at 10:08:23AM -0300, Marcelo Tosatti wrote:
> ...
> > >
> > > free output is this:
> > >              total       used       free     shared    buffers  cached
> > > Mem:        515980     506464       9516          0    2272      19204
> > > -/+ buffers/cache:     484988      30992
> > > Swap:      1951856       7992    1943864
> >
> > This should be normal behaviour -- the i/d caches grew because of file
> > system activitity. This memory will be reclaimed in case theres pressure.
>
> But how is "pressure" defined?
>
> Will a heap of busy knfsd processes doing reads or writes exert
> pressure?   Or is it only local userspace that can pressurize the VM (by
> either anonymously backed memory or file I/O).

Any allocator will cause VM pressure.

> This server happily serves large home directories over NFS, at really
> poor speeds.  It will happily serve tens or hundreds of gigabytes, read
> and write, over the course of a day, and *still* only cache about 100MB
> NFS to/from the server is slow. It's common to see 10 knfsd processes in
> D state while vmstat tells me the array works with about 4-6MB/sec
> sustained throughput (where hdparm -t would give me more than 70MB/sec
> on the md device).
>
> The files read and written are commonly in the 20-60 MB range, so it's
> not just because I'm loading the server with small seeks. Many files are
> read multiple times within a few minutes, so the cache usage of 100MB is
> completely bogus the way that I see it - but maybe there's just
> something I don't know about the caching?   :)

It sounds the cache could grow larger for better performance, indeed.

> > Is the behaviour different from previous 2.4 or 2.6 kernels?
>
> I never investigated the slabinfo on earlier 2.4. But the performance on
> this server has been "under expectations" for as long as I can remember.
> So, from the performance experience on this server I would say that
> 2.4.25 is not any worse than older kernels.
>
> Since this is a production system I have been reluctant to jump on the
> 2.6 wagon - but my other experiences with 2.6.X have been good, so I'm
> probably going to soften up and give it a try in a not too distant
> future.
>
> However, if this dcache/icache problem is well known and is (or at least
> should be) solved in 2.6, then I can do the test this weekend.
>
> Any enlightenment or suggestions are greatly appreciated :)

What you can try is to increase the VM tunable vm_vfs_scan_ratio. This is
the proportion of VFS unused d/i caches that will try to be in one VM
freeing pass. The default is 6. Try 4 or 3.

/proc/sys/vm/vm_vfs_scan_ratio

You can also play with

/proc/sys/vm/vm_cache_scan_ratio (which is the percentage of cache which
will be scanned in one go).

