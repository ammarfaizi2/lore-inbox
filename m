Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <218720-220>; Wed, 31 Mar 1999 09:30:00 -0500
Received: by vger.rutgers.edu id <217492-220>; Wed, 31 Mar 1999 09:27:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:45268 "EHLO math.psu.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <219086-221>; Wed, 31 Mar 1999 09:26:21 -0500
Date: Wed, 31 Mar 1999 09:34:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mats Lofkvist <mal@algonet.se>
Cc: Trevor Johnson <trevor@jpj.net>, linux-kernel@vger.rutgers.edu
Subject: Re: softupdates and ext2
In-Reply-To: <y2qiubh4zq3.fsf@kairos.algonet.se>
Message-ID: <Pine.SOL.3.95.990331090448.163G-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On 31 Mar 1999, Mats Lofkvist wrote:

> Trevor Johnson <trevor@jpj.net> writes:
> 
> > > I made some benchs and it seems rather fast (about 5 to 10% slower than
> > > the async mount, which is what Linux does).
> > 
> > It does that by default, but (for ext2 at least) you can mount with the
> > "sync" option to have at least the metadata written synchronously.  It is
> > much slower than the asynchronous way, but I would do it if the unclean
> > shutdowns couldn't be prevented.
> 
> The reason the "sync" option is so slow is because it makes _all_ writes
> synchronous. The default of sync metadata / async userdata used by most
> Unixen is not noticeably slower than async except for large metadata
> operations like removing large directory trees.

S-U != sync metadata. It's much more interesting beast. Very few metadata
writes are sync there. It's not about forcing something to disk
immediately. Look: in effect we have two filesystems - one on the disk
(what you'll be left with if the power will go off immediately) and
another being the on-disk + in-core changes. It's true for any scheme.
Work of buffer cache being exactly to bring the on-disk fs in sync with
in-core. S-U considers each change you are requesting as a separate
patch and takes care of applying them in non-conflicting order. I.e.
instead of blind forcing blocks from in-core filesystem on disk
(equivalent of taking old source tree and replacing random files in it
with their versions from newer one - sure, if you'll have time to finish
the process you'll sync them, but if you'll be stopped in the middle
you'll get a royal pain in the ass to fix) it (A) tries to commit
non-conflicting changes first (i.e. ones that do not depend on the changes
not yet committed) and (B) if it has to commit the block with pending
dependencies it makes a copy, *unrolls* changes with pending deps. on it
and commits the rest. I.e. exactly what you would do applying a big
furball of patches - if some file is affected by several patches and you
can't push it into the stable tree since some of those patches depend on
the files you didn't commit yet you unroll those patches and submit the
rest. Dependency is considered resolved when the bottom half reports that
block had hit the disk. I.e. you still have a queue and it can be
reordered, etc. Just that you have some limitations wrt when you can push
the block into the queue. Once it is there everything works as in async
case. Yes, some blocks have to be written several times due to unrolls.
Pretty few, according to benchmarks. And indeed for some changes you know
that you'll never have to unroll them - e.g. if they don't have any
pending dependencies. For them you don't have to remember the previous
state. That's it - it's the same safety as full-sync (metadata sync with
data async is *not* safe), but almost the same freedom in filling the
queue as for full-async (for full-sync you have *1* block in a queue at
any moment). It needs an assistance from the filesystem (data on
dependencies), but the main changes are in buffer-cache layer. And it's
not the same as journaling.
	ObLicensingProblems: Kirk had chosen the license that has some
complications for derived commercial works. Some licensing fanatics
tried to raise the hell around it. Yup, BSD folks also have their share of
PC wank^Wfighters. It seems to be over now. Anyway, Kirk's license applies
to his code (surprise, surprise), not to the concept. And his code can't
be tossed into the Linux VFS anyway - it assumes *really* different
environment. So it's a non-issue.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
