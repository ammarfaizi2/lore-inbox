Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269119AbRHIRxH>; Thu, 9 Aug 2001 13:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270481AbRHIRw5>; Thu, 9 Aug 2001 13:52:57 -0400
Received: from imladris.infradead.org ([194.205.184.45]:62988 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269119AbRHIRwj>;
	Thu, 9 Aug 2001 13:52:39 -0400
Date: Thu, 9 Aug 2001 18:52:47 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts on tmpfs and swapfs
In-Reply-To: <3B724B25.9E703497@idb.hist.no>
Message-ID: <Pine.LNX.4.33.0108091836450.22374-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge.

 >> I have to admit that tmpfs is new to me, but I would assume it's
 >> a filing system for temporary files, that works along the lines
 >> of a ramdisk?

I've had this assumption corrected - apparently, despite its name,
tmpfs is an extension of shmfs and basically manages SHARED MEMORY,
not TEMPORARY FILES as I had assumed.

 >> If so, I would see the following issues with this idea:
 >>
 >>  1. If the idea is to keep temporary files off the hard disk,
 >>     it makes no sense to use swap for them, so any limit on
 >>     the size of tmpfs would need to be limited to the size
 >>     of physical ram.

 > The idea is that short-lived temp-files will live in the cache
 > only, and never hit the disk as they usually are deleted
 > quickly.

Depending what you mean by "short lived", the kernel already does
this. Files that are opened, used, closed and deleted before the VFS
gets round to writing them to disk never get written out anyway.

 > This saves disk bandwith, so it can be put to better use. Why
 > write to disk something we don't want to store for long, we
 > particularly don't want to store across reboots.

Perhaps because we don't have enough RAM to store the file anyway, so
it has to be stored on disk somewhere?

 > (Many unix installation deletes everything in /tmp on reboot as
 > a cleanup step.)

Apart from the cleanup step, this can be an important security step.

 > So this fs is simplified, it don't need to consider things like
 > efficient disk layout and fragmentation.

Neither does the swapfs I mentioned, simply because (as a side effect
of being in swap) entries CAN'T live across reboots - no special
actions needed.

 > Still, RAM only isn't enough, because:

 > 1. Some apps may write a really big temp file, or at least way
 >    too big for your machine. This used to be a common use for
 >    temp files - store data sets that might be too big for
 >    memory. Not necessary now that swapping exists, but old apps
 >    live on.

 > 2. There may be many simultaneous files.

 > 3. /tmp may not fill memory compeltely, but you happen to need
 >    space for other things too, like caching ordinary files,
 >    and program memory allocations.

 > So, files in tmpfs may get swapped out, but only if that is
 > necessary due to memory shortage.

 >>  2. If the idea is to ensure that temporary files are deleted
 >>     as soon as they are finished with, it makes no sense to
 >>     use physical ram for them, and this effectively becomes
 >>     what I would refer to as swapfs - a filing system where
 >>     the objects within it are stored in swap until such time
 >>     as the last reference is freed, and are then auto-deleted,
 >>     possibly with a short delay to allow for programs run one
 >>     after the other where the first creates a file that is
 >>     read by the second.

 > Storing a file in swap only isn't that useful - then you have to
 > read it each time it is referenced. That doesn't optimize disk
 > usage by doing away with it.

That's not what we're talking about here. What we have here is a file
that exists in memory and swap, but not on other file systems. The
normal swap in/out mechanisms will free memory as and when needed, and
the file will vanish either on reboot (no special action required), or
when it's been closed and the swap space it occupies is needed for
something else.

 > tmpfs use swap only if it have to.

tmpfs apparently has nothing to do with temporary files, so the points
considered above are irrelevant as far as it is concerned.

 >>  3. If the idea is to do both of the above at the same time,
 >>     any limit on the size of tmpfs would need to be linked to
 >>     the amount of swap present, and the link would need to be
 >>     such that it was not possible to release swap if doing so
 >>     would leave tmpfs over-committed. I can see serious bugs
 >>     with this idea in a hotplug environment.

 > Limiting is necessary, as filling memory *completely* will
 > invoke the OOM killer. Users can generally put whatever they
 > want in /tmp, and we don't want an easy way for them to invoke
 > the OOM killer. Perhaps the tmpfs usage should count towards the
 > user limit for memory. Limiting it to some size is easier
 > though.

Any limits would HAVE to be linked to the current amount of swap
space, and in such a way that reducing swap (by unmounting one or more
swap areas) did not break that limit. That's the headache here.

Best wishes from Riley.

