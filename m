Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261201AbREOSM1>; Tue, 15 May 2001 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261239AbREOSMR>; Tue, 15 May 2001 14:12:17 -0400
Received: from boreas.isi.edu ([128.9.160.161]:4496 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S261230AbREOSC5>;
	Tue, 15 May 2001 14:02:57 -0400
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events 
In-Reply-To: Your message of "Tue, 15 May 2001 00:49:58 MDT."
             <200105150649.f4F6nwD22946@vindaloo.ras.ucalgary.ca> 
Date: Tue, 15 May 2001 11:02:52 -0700
Message-ID: <1486.989949772@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And because your suspend/resume idea isn't really going to help me
>much. That's because my boot scripts have the notion of
>"personalities" (change the boot configuration by asking the user
>early on in the boot process). If I suspend after I've got XDM
>running, it's too late.

	Preface: As has been mentioned on this discussion thread, some
disk devices maintain a cache of their own, running on a small (by
today's standards) CPU.  These caches are probably sector oriented,
not block oriented, but are almost certainly not page oriented or
filesystem oriented.  Well, OK, some might have DOS filesystem
knowlege built-in, I suppose... yuck!

	Anyway, although there may be slight differences, they are
effectively block-orieted caches.  As long as they are write-through
(and/or there are cache flushing commands, etc), there are reasonably
coherent with the operating system's main cache, and they meet the
expectations of database programs, etc. that want stable storage.

	In terms of efficiency, there are questions about read-aheead,
write-behind, write-through with invalidation or write-through with
cache update -- the usual stuff.  I leave it as an exercise for the
reader to decide how to best tune their system, and merely assert that
it can be done.

	Imagine, as a mental exercise, that you move this
block-oriented cache out of the disk drive, and into the main CPU and
operating system, say roughly at the disk driver level.  We lose the
efficiency of having the small CPU do the block lookups, but a hashed
block lookup is rather cheap nowadays, wouldn't you say?  Ignoring
issues of, "What if the disk drive fails independently of the main
CPU, or vice versa?", the transplanted block cache should operate
pretty much as it did in the disk drive.

	In particular, it should continue to operate properly with the
main CPU's main page cache.

	Conclusion: a page cache can successfully run over a
appropriately designed block cache.  QED.

	What's the hitch?  It's the "appropriately designed"
constraint.  It is quite possible that the Linux block cache is not
designed (data strictures and code paths considered together) in a way
that allows it to mimic a simple disk drive's block cache.  I assume
that there's some impediment, or this discussion wouldn't have lasted
so long -- the idea of using the Linux block cache to model a disk
drive's block cache is pretty obvious, after all.

>So what I want is a solution that will keep the kernel clean (believe
>me, I really do want to keep it clean), but gives me a fast boot too.
>And I believe the solution is out there. We just haven't found it yet.

	Well, if you want a fast boot *on a single type of disk
drive*, and the existing Linux block cache doesn't work, you could
extend the driver for that hardware with an optional block cache,
independently of Linux' block cache, along with an appropriate
interface to populate it with boot-time blocks, and to flush it when
no longer needed.  That's not exactly clean, though, is it?

	You could extend the md (or LVM) drivers, or create a new
driver similar to one of them, that incorporates a simple block cache,
with appropriate mechanisms for populating and flushing it.  Clean?
er, no, rather muddy, in fact.

	You might want to lock down the pages that you've
prepopulated, rather than let them be discarded before they're needed.
This could be designed into a new block cache, but you might need to
play some accounting games to get it right with the existing block
cache.

	Finally, there's Linus' offer for a preread call, to
prepopulate the page cache.  By virtue of your knowlege of the
underlying implementation of the system, you could preload the file
system index pages into the block cache, and load the datd pages into
the page cache.  Clean!  Sewer-like!

						Craig Milo Rogers

