Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWAVMdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWAVMdp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 07:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWAVMdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 07:33:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:9663 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964773AbWAVMdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 07:33:44 -0500
Date: Sun, 22 Jan 2006 06:33:35 -0600
From: Robin Holt <holt@sgi.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060122123335.GB26683@lnx-holt.americas.sgi.com>
References: <200601212108.41269.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601212108.41269.a1426z@gawab.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 09:08:41PM +0300, Al Boldi wrote:
> A long time ago, when i was a kid, I had dream. It went like this:
> 
> I am waking up in the twenty-first century and start my computer.
> After completing the boot sequence, I start top to find that my memory is 
> equal to total disk-capacity.  What's more, there is no more swap.
> Apps are executed inplace, as if already loaded.
> Physical RAM is used to cache slower storage RAM, much the same as the CPU 
> cache RAM caches slower physical RAM.
> 
> When I woke up, I was really looking forward for the new century.
> 
> Sadly, the current way of dealing with memory can at best only be described 
> as schizophrenic.  Again the reason being, that we are still running in the 
> last-century mode.
> 
> Wouldn't it be nice to take advantage of todays 64bit archs and TB drives, 
> and run a more modern way of life w/o this memory/storage split personality?
> 
> All comments, other than "dream on", are most welcome!

Unfortunately, with Linux/Unix you are only going to get a "dream on".
Look at IBM's AS/400 with OS/400.  It does that sort of thing.  I am
sure there are others.

How do you handle a hot-plug device that is being brought online for
something like a backup?  Assume it would the be removed when the backup
is complete.  In your dream world, anon-pages could be written to the
device.  As the backup proceeds and the disk fills, would those pages
be migrated to a different backing store, any processes which wrote
to the device killed, or would the backup be forced to abort/move to a
different device?  When the administrator then goes to remove the volume,
do they need to wait for all those pages to be migrated to a different
backing store?

Now assume a flash device gets added to the system.  Would we allow
paging to happen to that device?  If so, how does the administrator or
user control the added wear-and-tear on the device?

Now consider a system that has 8K drives (don't laugh, I know of one
system with more).  How do we keep track of the pages on those devices?
Right now, there is enough information in the space of a pte (64 bits
on ia64, not sure about other archs) to locate that page on the device.
For your proposal to work, we need a better way to track pages when they
are on backing store.  It would need to be nearly unlimited in number
of devices and device offset.

On one large machine I know of, the MTBF for at least one of the drives
in the system is around 3 hours.  With your proposal, would we reboot
every time some part of disk fails to be available or would we need
to keep track of where those pages are and kill all user processes on
that device?  Imagine the amount of kernel memory required to track all
those pages of anonymous memory.  You would end up with a situation where
adding a disk to the system would force you to consume some substatial
portion of kernel memory.  Would we allow kernel pages to be migrated to
backing store as well?  If so, how would we handle a failure of backing
devices with kernel pages.  Would users accept that the longest one of
their jobs can run without being terminated is around 3 hours?

Your simple world introduces a level of complexity to the kernel which
is nearly unmanageable.  Basically, you are asking the system to intuit
your desires.  The swap device/file scheme allows an administrator to
control some aspects of their system while giving the kernel developer
a reasonable number of variables to work with.  That, at least to me,
does not sound schizophrenic, but rather very reasonable.

Sorry for raining on your parade,
Robin Holt
