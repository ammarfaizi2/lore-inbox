Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262665AbREOHNn>; Tue, 15 May 2001 03:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbREOHNd>; Tue, 15 May 2001 03:13:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16644 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262662AbREOHNY>; Tue, 15 May 2001 03:13:24 -0400
Date: Tue, 15 May 2001 00:13:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <200105150649.f4F6nwD22946@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0105142357220.23955-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Richard Gooch wrote:
> > 
> > What happens if you create a buffer cache entry? Does that
> > invalidate the page cache one? Or do you just allow invalidates one
> > way, and not the other? And why=
> 
> I just figured on one way invalidates, because that seems cheap and
> easy and has some benefits. Invalidating the other way is costly, so
> don't bother, even if there were some benefits.

Ahh..

Well, excuse me while I puke all over your shoes.

Why don't you go hack the NT kernel, or something like that? I have some
taste, and part of that is having this silly notion of "Things should make
sense".

We should not create crap code just because we _can_. Sure, it's easy to
write the code you suggest. Do you really want a system like that? A
system where you have rules that make no sense, except "it was easy to
invlidate one way, so let's do that, and never mind that it makes no
logical sense at all?".

> > Ehh.. And then you'll be unhappy _again_, when we early in 2.5.x
> > start using the page cache for block device accesses. Which we
> > _have_ to do if we want to be able to mmap block devices. Which we
> > _do_ want to do (hint: DVD's etc).
> 
> So what happens if I dd from the block device and also from a file on
> the mounted FS, where that file overlaps the bnums I dd'ed? Do we get
> two copies in the page cache? One for the block device access, and one
> for the file access?

Yup. And never the two shall meet.

Why should they? Why would you ever do something like that, or care about
the fact? Why would you design a system around a perversity, slowing down
(and uglifying) the sane and common case?

> And because your suspend/resume idea isn't really going to help me
> much. That's because my boot scripts have the notion of
> "personalities" (change the boot configuration by asking the user
> early on in the boot process). If I suspend after I've got XDM
> running, it's too late.

Note that I never said "suspend". I said _resume_. You would create the
resume-image once, and you'd create it not at shutdown time, but at the
point you want to resume from.

You don't want to ever suspend the dang thing - just shut it down, and
reboot it quickly by resuming from the snapshot. So you just create a
simple resume snapshot. Which is easy to do, with the exact same tools
that you've been talking about all the time.

What you do is:
 - trace what pages get loaded off the disk
 - create a snapshot of the contents of those pages
 - archive it all up (may I suggest compressing it at the same time?)
 - the "resume" function is just a "uncompress and populate the virtual
   caches with the contents" action.

Note that the "uncompress and populate" doesn't actually have to use the
_real_ disk contents of the file. A byte is a byte is a byte, and it
doesn't actually need to come from the actual filesystem the system
_thinks_ it comes from. Once it is loaded into memory, it's just a
value. You'e "primed" your caches, so when you actually run the bootup
scripts, you'll have some random hit-rate (say, 98%), and improve the
bootup immensely that way.

Another way of saying this: Imagine that you "tar" up and compress the
files you need for booting. You then uncompress and untar the archive, but
instead of untar'ing onto a filesystem, you _just_ populate the caches. 

This is how some CPU's bootstrap themselves: they fill their icache from a
serial rom (at least some alpha chips did this). Never mind that they
didn't actually get that initial state from the _real_ backing store (RAM,
or in the hypothetical "resume" case, the filesystem off disk). There's no
way to tell, if your cached copies have the same data as the data on
disk. Never mind that the data _got_ there a strange way.

(And yes, your "cache priming" had better prime the cache with the same
stuff that _is_ on the real filesystem, otherwise you'd obviously get
strange behaviour with the caches not actually matching what the
filesystem contents are. But that's simple to do, and it's easy enough to
boot up in safe mode without a cache priming stage).

One of the advantages of "resuming" (or "priming the cache", or whatever
you want to call it) is that you're free to lay out the resume/cache image
any way you want on disk, as it has nothing to do with the actual
filesystem - except for the fact of sharing some of the same data. Which
means that you can really read it in efficiently.

		Linus

