Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319519AbSIGVJX>; Sat, 7 Sep 2002 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319520AbSIGVJX>; Sat, 7 Sep 2002 17:09:23 -0400
Received: from gate.in-addr.de ([212.8.193.158]:46346 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S319519AbSIGVJV>;
	Sat, 7 Sep 2002 17:09:21 -0400
Date: Sat, 7 Sep 2002 23:14:53 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
Message-ID: <20020907211452.GA24476@marowsky-bree.de>
References: <20020907164631.GA17696@marowsky-bree.de> <200209071959.g87JxKN17732@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209071959.g87JxKN17732@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-07T21:59:20,
   "Peter T. Breuer" <ptb@it.uc3m.es> said:

> > Yes, use a distributed filesystem. There are _many_ out there; GFS, OCFS,
> > OpenGFS, Compaq has one as part of their SSI, Inter-Mezzo (sort of), Lustre,
> > PvFS etc.
> Eh, I thought I saw this - didn't I reply?

No, you didn't.

> > Noone appreciates reinventing the wheel another time, especially if - for
> > simplification - it starts out as a square.
> But what I suggest is finding a simple way to turn an existing FS into a 
> distributed one. I.e. NOT reinventing the wheel. All those other people
> are reinventing a wheel, for some reason :-).

Well, actually they aren't exactly. The hard part in a "distributed
filesystem" isn't the filesystem itself; while it is very necessary of course.
The locking, synchronization and cluster infrastructure is where the real
difficulty tends to arise.

Yes, it can be argued whether it is in fact easier to create a filesystem from
scratch with clustering in mind (so it is "optimised" for being able to do
fine-grained locking etc), or whether proping a generic clustering layer on
top of existing ones.

The guesstimate of those involved in the past have seemed to suggest that the
first is the case. And I also tend to think this to be the case, but I've been
wrong.

That would - indeed - be very helpful research to do. I would start by
comparing the places where those specialized fs's actually are doing cluster
related stuff and checking whether it can be abstracted, generalized and
improved. In any case, trying to pick apart OpenGFS for example will provide
you more insight into the problem area that a discussion on l-k.

If you want to look into "turn a local fs into a cluster fs", SGI has a
"clustered XFS"; however I'm not too sure how public that extension is. The
hooks might however be in the common XFS core though.

Now, going on with the gedankenexperiment, given a distributed lock manager
(IBM open-sourced one of theirs, though it is not currently perfectly working
;), the locking primitives in the filesystems could "simply" be changed from
local-node SMP spinlocks to cluster-wide locks.

That _should_ to a large degree take care of the locking.

What remains is the invalidation of cache pages; I would expect similar
problems must have arised in NC-NUMA style systems, so looking there should
provide hints.

> > You fail to give a convincing reason why that must be made to work with
> > "all" conventional filesystems, especially given the constraints this
> > implies.
> Because that's the simplest thing to do.

Why? I disagree.

You will have to modify existing file systems quite a bit to work
_efficiently_ in a cluster environment; not even the on-disk layout is
guaranteed to stay consistent as soon as you add per-node journals etc. The
real complexity is in the distributed nature, in particular the recovery (see
below).

"Simplest thing to do" might be to take your funding and give it to the
OpenGFS group or have someone fix the Oracle Cluster FS.

> > In particular, they make them useless for the requirements you seem to
> > have. A petabyte filesystem without journaling? A petabyte filesystem with
> > a single write lock? Gimme a break.
> Journalling? Well, now you mention it, that would seem to be nice.

"Nice" ? ;-) You gotta be kidding. If you don't have journaling, distributed
recovery becomes near impossible - at least I don't have a good idea on how to
do it if you don't know what the node had been working on prior to its
failure.

If "take down the entire filesystem on all nodes, run fsck" is your answer to
that, I will start laughing in your face. Because then your requirements are
kind of from outer space and will certainly not reflect a large part of the
user base.

> > Please, do the research and tell us what features you desire to have which
> > are currently missing, and why implementing them essentially from scratch
> > is
> No features.

So they implement what you need, but you don't like them because theres just
so few of them to chose from? Interesting.

> Just take any FS that corrently works, and see if you can distribute it.
> Get rid of all fancy features along the way.  The projects involved are
> huge, and they need to minimize risk, and maximize flexibility. This is
> CERN, by the way.

Well, you are taking quite a risk trying to run a
not-aimed-at-distributed-environments fs and trying to make it distributed by
force. I _believe_ that you are missing where the real trouble lurks.

You maximize flexibility for mediocre solutions; little caching, no journaling
etc.

What does this supposed "flexibility" buy you? Is there any real value in it
or is it a "because!" ?

> You mean "what's wrong with X"? Well, it won't be mainstream, for a start,
> and that's surely enough.

I have pulled these two sentences out because I don't get them. What "X" are
you referring to?

> of some kind. I need to explore as much as I can and get as much as I
> can back without "doing it first", because I need the insight you can
> offer.

The insight I can offer you is look at OpenGFS, see and understand what it
does, why and how. The try to come up with a generic approach on how to put
this on top of a generic filesystem, without making it useless.

Then I shall be amazed.

> There is no difficulty with that - there are no distributed locks. All locks
> are held on the server of the disk (I decided not to be complicated to
> begine with as a matter of principle early in life ;-).

Maybe you and I have a different idea of "distributed fs". I thought you had a
central pool of disks.

You want there to be local disks at each server, and other nodes can read
locally and have it appear as a big, single filesystem? You'll still have to
deal with node failure though.

Interesting. 

One might consider to peel apart meta-data (which always goes through the
"home" node) and data (which goes directly to disk via the SAN); if necessary,
the reply to the meta-data request to the home node could tell the node where
to write/read. This smells a lot like cXFS and co with a central metadata
server.

> > recovery. ("Transaction processing" is an exceptionally good book on that
> > I believe)
> Thanks but I don't feel like rolling it out and rolling it back!

Please explain how you'll recover anywhere close to "fast" or even
"acceptable" without transactions. Even if you don't have to fsck the petabyte
filesystem completely, do a benchmark on how long e2fsck takes on, oh, 50gb
only.

> Thanks for the input. I don't know what I was supposed to take away
> from it though!

I apologize and am sorry if you didn't notice.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

