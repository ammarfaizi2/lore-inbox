Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132514AbRDDWwe>; Wed, 4 Apr 2001 18:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132516AbRDDWwZ>; Wed, 4 Apr 2001 18:52:25 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:65271 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132514AbRDDWwO>; Wed, 4 Apr 2001 18:52:14 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104042250.f34MoHB10446@webber.adilger.int>
Subject: Re: [PATCH] Revised memory-management stuff (was: OOM killer)
In-Reply-To: <Pine.LNX.4.21.0104041256150.6489-200000@cr215808-b.poco1.bc.wave.home.com>
 from Jonathan Morton at "Apr 4, 2001 01:41:54 pm"
To: Jonathan Morton <chromi@cyberspace.org>
Date: Wed, 4 Apr 2001 16:50:17 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathon Morton writes:
> MAJOR: OOM killer now only activates when truly out of memory, ie. when
> buffer and cache memory has already been eaten down to the bone.

Good.

> MEDIUM: IOW, if the allocating process is already 4x the size of the
> remaining free memory, reservation of more memory (by fork(), malloc()
> or related calls) will fail.

I'm not sure I follow this one.  Granted it punishes larger programs,
but is this really good?  If I read it correctly, it essentially means
that it is impossible for a single process to use > 80% of the VM.  For
some types of applications (e.g. Oracle and such) which are implemented
as a number of separate processes this is _probably_ OK (it would fail
if the first process does all of the allocation before forking), but what
about monolithic apps which want to use the whole VM space (e.g. the
numerical methods program that was mentioned at the start of the OOM thread)?

It also totally breaks applications which malloc huge amounts of memory
but only sparsely use this memory (again mostly scientific apps do this).
I guess it also depends on whether 4x is for memory "allocated" or for
memory "used".  It should probably be directly tied to vm-overcommit flag.

In most cases this will probably work OK (reserve part of VM for other
processes), but why introduce a new VM parameter that needs to be tuned?
I agree it is better to return NULL from malloc() rather than invoking
OOM, but I think the "4x" heuristic needs to be looked at more closely
or changed.  It may also cause problems if your box is at the edge of
OOM and malloc fails for bash (or other "small" program) because the
amount of remaining VM is very small (so 4x "small" is still not enough
for bash to run, and root to fix the system).

> MEDIUM: The OOM killer algorithm has been reworked to be a little more
> intelligent by default, and also now allows the sysadmin to specify PIDs
> and/or process names which should be left untouched.  Simply echo a
> space-delimited list of PIDs and/or process names into

If you allow process names into the picture, it opens an easy DOS attack.
A memory hog simply runs under one of the "protected" names and is
immune from being killed, but causes every other process on the box to
die.  I'm pretty sure this idea was suggested and previously shot down
at least once.

It should be easy enough to write a user tool (script even) which outputs
all PIDs of process X, and limits this list to the current (or specified)
UID.  The OOM-unkillable trait would be stored as a per-process flag, rather
than a list to be checked against.  Not only does this make for faster
checking (O(1) vs. O(n)), but it also means that we don't have stale
OOM-unkillable entries in the list.  The non-OOM trait would be inherited
across fork() (but cleared on set*uid(), or maybe it should be a capability)
so that processes (e.g. httpd) which spawn/kill helper tasks do not have
to keep updating a list.  This also prevents the situation where PID X is
protected from OOM, but is stopped and later another process takes its PID.


All in all, I think having such a huge patch basically guarantees it will
not make it into the kernel.  IMHO, it is better to split this into at
least 3 or 4 patches so that it is manageable to see what is being changed
for each part.

Cheers, Andreas

PS - I don't think the dentry/inode slab caches are currently shrunk even
     under VM pressure - there was a thread on this recently about these
     caches filling up the memory on a 1GB machine.  However, there was
     also a patch to fix for this posted to this list recently.

PPS - can you try and keep comments within 80 columns?
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
