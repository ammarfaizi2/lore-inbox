Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbSKZQGS>; Tue, 26 Nov 2002 11:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266386AbSKZQGS>; Tue, 26 Nov 2002 11:06:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:62085 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266384AbSKZQGR>;
	Tue, 26 Nov 2002 11:06:17 -0500
Message-ID: <3DE39DA7.EA79AF83@digeo.com>
Date: Tue, 26 Nov 2002 08:13:27 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Manish Lachwani <manish@Zambeel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 SMP hangs ..
References: <233C89823A37714D95B1A891DE3BCE5202AB1975@xch-a.win.zambeel.com> <3DDC7746.200ACDE2@digeo.com> <20021126152238.GA4408@think.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Nov 2002 16:13:27.0957 (UTC) FILETIME=[C1273450:01C29566]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> 
> On Wed, Nov 20, 2002 at 10:03:50PM -0800, Andrew Morton wrote:
> > Manish Lachwani wrote:
> > >
> > > I am seeing system hangs with 2.4.17 SMP kernel when doing mke2fs accros 12
> > > drives in parallel. However, the hangs only occur when the I/O rate from
> > > vmstat is high:
> > >
> >
> > Quite possibly it has not hung.  You just need to wait half an
> > hour or so.
> >
> > The algorithm isn't very good.
> 
> [Catching up lkml mail after the IETF meeting....]
> 
> Try setting the environment variable "MKE2FS_SYNC" to a value such as
> 10.  This will cause mke2fs to force a sync after writing out every 10
> block groups worth of inode tables.

That will fix it.

> If this fixes the problem, then it means that the kernel isn't
> handling write throttling correctly, and the system is thrashing
> itself to death.

Nah, it's __block_fsync().  That function has to write buffers against
a particular device.  So it searches the global buffer LRU for 32 buffers
against the nominated device, drops the lock, writes the buffers, then
searches again.

So the search complexity is O(n*n/32).  Which means that when you have a
lot of dirty buffers against different devices on the queue the CPU cost
simply explodes.

One workaround is to use sync rather than fsync - because sync uses NODEV
and doesn't have to search past buffers from uninteresting devices. 
Another is to do what you've done.

Probably, just syncing the buffers at i_dirty_data_buffers would suffice.
That would fix it.
