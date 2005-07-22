Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVGVEsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVGVEsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 00:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVGVEsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 00:48:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262009AbVGVEr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 00:47:59 -0400
Date: Fri, 22 Jul 2005 14:47:10 +1000
From: Andrew Morton <akpm@osdl.org>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fastboot, diskstat
Message-Id: <20050722144710.47e0cbd6.akpm@osdl.org>
In-Reply-To: <20050722034135.GA21201@outpost.ds9a.nl>
References: <20050722034135.GA21201@outpost.ds9a.nl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <bert.hubert@netherlabs.nl> wrote:
>
> Hi Andrew,
> 
> I'm currently at OLS and presented http://ds9a.nl/diskstat yesterday, which
> also references your ancient 'fboot' program.
> 
> I've also done experiments along those lines, and will be doing more of them
> soon. 
> 
> You mention it was a waste of time, do you recall if that meant:
> 
> 1) that the total time for prefetching + actual boot was only 10% shorter,
> but that the actual booting did not (significantly) touch the disk?
> 
> 2) that on actual boot there would still be a lot of i/o
> 
> ?

eep, this was early 2001, on 2.4.whatever.

I recall trying various preloading schemes - try loading the metadata
first, then the pagecache, pagecache first then metadata, one and not the
other, etc.

Yeah, 10-15% benefit was obtainable but on a little old laptop the amount
of discontiguous I/O was still quite tremendous.

I also recall hacking the initscripts so they were _all_ launched
asynchronously.  A few things broke because of dependency problems of
course, but that improved things quite noticeably.  I think quite a few of
the scripts and daemons and things have explicit sleeps, and parallelising
all of those helped.

> 
> Regarding 1), in my own experiments I failed to convince the kernel to
> actually cache the pages I touched, I wonder if some sequential-read
> detection kicked in, the one that prevents entire cd's being cached.

It depends how you touch the page.  Remember that there is no unified
pagecache in 2.6.  The pagecache for /dev/hda1 is separate from the
pagecache for /etc/passwd.  If one tries to preload /etc/passwd by reading
from /dev/hda1 then that won't be effective.  So any userspace preloading
scheme would have to open both /dev/hda1 and /etc/passwd and it would then
read from both fds in some intermingled manner based on disk block address.

Although I'd suggest that it'd be easier to just get the kernel to do it:
set the disk queue size to something enormous (4096 requests?), open 100
files, launch posix_fadvise() against them all (or against sections of
them) then close the files again.  Rely upon that large disk queue to
perform all the sorting.  Maybe.

> For my next attempt I'll try to actually lock the pages into memory.

It shouldn't be needed.  If at the end of preload there's still a decent
amount of free memory, you know that the kernel hasn't gone and thrown
anything away yet.  Any machine with 256MB or more of RAM should be able to
fit all the boot-time stuff into RAM fairly comfortably.

> Also, regarding the directory entries, are they accessed via the buffer
> cache?

yes.  For ext3 you can preload both inodes and directory entries via
read()s from /dev/hda1.  For ext2, directory entries each have their own
pagecache and should be preloaded via read(open(/name/of/directory)).

> Iow, would reading blocks which can't be mapped to files directly via
> /dev/hda be useful?

If the blocks are directories or inodes then you _must_ preload them via
/dev/hda1's pagecache.  (/dev/hda1's pagecache is the storage for
/dev/hda1's buffercache - they're the same thing).

So a scheme which would work for 2.6.x would be:

a) Boot the machine

b) Walk /dev/hda1's pagecache, record which pages are present.

c) For all files which are in dcache, walk their pagecache, work out
   which pages are present.

  (nb: it might be possible to do most of the above from userspace: mmap
   the file and use mincore() to find out if the page is in pagecache).

The above data is enough for performing a crude preload:

a) Boot the machine

b) Boost the disk queue size, set the VFS readahead to zero, open
   /dev/hda1 and all the regular files, hose reads at the disk via
   fadvise().  Restore VFS readahead and queue size, continue with boot.


More sophisticated preload would involve bmap()ping the various regular
files so the reads can be issued in LBA-sorted order.  But this could be of
marginal additional benefit.


And I suspect that the whole thing will be of marginal benefit.  Although
things might be better now that files are laid out with the Orlov allocator
(make sure that the distro was installed with a 2.6 kernel!  The file
layout will be quite different if the installer used a 2.4 ext3).

Of course the next step is to rewrite files so that they are more
favourably laid out on disk.  Tricky.  Or dump all pagecache to some temp
file in a nice linear slurp and preload that, copying it all to the
appropriate per-inode pagecaches and taking care of files which have been
modified.  Trickier ;)

