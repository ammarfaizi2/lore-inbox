Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTEUVnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 17:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTEUVnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 17:43:25 -0400
Received: from mail.casabyte.com ([209.63.254.226]:7950 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S262373AbTEUVnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 17:43:19 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <root@chaos.analogic.com>
Cc: "Helge Hafting" <helgehaf@aitel.hist.no>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
Date: Wed, 21 May 2003 14:56:12 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGGEHPCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.53.0305210940160.3520@chaos>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/Heavy Sigh

You insist on missing the simplest of points and then dressing your response
as cannon.

Simple point 1:

We have public interfaces within the kernel.  These interfaces include all
of the various whatever_ops structures (e.g. struct file_ops) and are
characterized by a list of pointers-to-functions, each with a "well known"
behavior.

Simple point 2:

We occasionally see changes to the afore mentioned, and required  "well
known" behaviors, in the form of a change of responsibility for locking.
Not counting the move from the "big kernel lock" to all that came after,
whenever a definition of a routine changes from "called holding some_lock"
"no longer called with some_lock held" a whole lot of code gets stirred up.
(not the key point though...)

Simple Point 3: (The real point)

In the existing system, it is impossible to aggregate the existing code
calls under an umbrella call, if that umbrella needs the same lock as the
constituent calls.

Lets say I have a file system with a perfectly implemented unlink and a
perfectly implemented rename.  Both of these routines need to exist exactly
as they are.  Both of these routines need to lock the vfs dentry subsystem
(look it up.)

(slightly contrived example follows)

But now lets say that I am building a virtualization layer for, say, an
network file system, or a caching file system, or a logical volume
concatenator or something.  It doesn't really matter why exactly, but lets
say that to implement some semantic requirement of the existing network file
system I need to implement a "destructive rename", that must be atomic.  The
"natural solution" is to implement something that looks like

destructive_rename(...)
{
  lock_dircache
  underlying_ops->unlink(target_name)
  underlying_ops->rename(source_name, target_name)
  unlock_dircache
}

But that natural synthesis of primitives wont work because both the unlink
and the rename on the underlying file system are implemented with the
absolutely correct lock_dircache they need internally.  This "natural code"
will self-deadlock.

You assert that this can only happen if someone "did bad" in some form or
another.  You are wrong.  Your simple-minded view of locking is, well,
simple minded.  In the stated example, for instance, there is no way to meet
the requirements without manhandling the members pointed to by
underlying_ops, violating the requirements of the outer layer, or hard
coding the theoretical upper-layer so that it only works with a particular
underlying file system.  None of these are less-than-brain-dead options.

But, you say, no such problem sets exist...

Here is a problem statement that is virtually unimplementable in the current
Linux kernel because of the simple-minded locking model.

Create a meta file-system that takes two existing (backing) file system
devices (or existing mounted directories) and aggregates them such that:

(Ladies, and Gentlemen, The "deltafs" file system...)

1) It doesn't matter what types of file systems are used as the backing file
systems.
2) The aggregate file system is fully read-write
3) The base (first existing) file system is read-only
4) The front (second existing) file system is read-write
5) All operations are available on the aggregate file system (unlink,
rename, open for write, open for append, chown, set access time, etc.)
6) The aggregate file system engine will transcribe all the modified files
from the base to the front file system if the file is modified.
7) The aggregate file system will (probably using a reserved file name and a
journaling structure encoded therein) maintain a white-out list to hide
unlinked and renamed files.
8) After unmount, the front file system should be a minimal delta of the
base file system
9) Remounting the same combination of file systems should consistently
result in the same, consistent file system image.
10) (you get the point... 8-)

Now, the natural, and only rational implementation, would be to build a
module with a "Y" shape.  The two short legs being the backing file systems
and the long leg being the presentation side that links under "real" mount
point.  You'd probably need a kernel thread too.  Regardless of the
secondary concerns, the aggregate file system will need to... wait for it...
aggregate.

For instance, when you search the dircache for a file, the dircache routines
for the aggregate file system will need to call into the dircache routines
of the backing file systems, and not necessarily in a symmetric way.  There
are "interesting" permutations.  A simple lookup within the aggregate system
will have to (typically) do three things: Look for the file on the front
component, or then check for the file in the white-out list, or then check
for the file on the read-only base file system.

Another interesting aggregate operation would be the various incarnations of
open (and subsequent use).  If I open, or god forbid, map a file for
reading, and then someone else opens it for writing, I can't have just
passed out the inode from the base file system out because the write access
will not ever be reflected in the reading/mapping of the open-for-read case.

You can still almost do this as it exists today, but if you go and allow the
backing elements to be bound directories (a la mount --bind) instead of pure
devices everything flies right out the window.  (The difference being the
shared visibility of the underlying dentry stuff to "third parties.")

You could get close to a good aggregate file system if you just don't lock
anything at the aggregate levels and then hope concurrent accesses don't
fall into some k-hole while complex operations (e.g. rename) are in for a
competitor.  THAT, however, is really bad design.

So answer one question: in the case of say "mount -t deltafs -o
front=/dev/ram/0,back=/dev/hda3 aggregate /opt" where /dev/ram/0 is a ext2
file system, and /dev/hda3 is a riserfs, who was the "stupid programmer"
that caused the self deadlock?  The guy who wrote ext2?  The guy who wrote
riserfs?  The guy who wrote deltafs?  (probably the latter in your mind.)
Would the guy who wrote deltafs have been "smart" if he didn't lock things
and just hoped for the best?  Would he have been smart to take the locks,
but then drop them quickly around the calls to his constituent file systems
and again hoe for the best?

Simply put, the fault lies in defining a public interface
(dentry_operations, and file_ops) that can and will self-deadlock if used in
aggregate operations and lo-and-behold if the used in "public" operations
were reentrant then the problem would be solved for everyone.  Period.

There are other examples of highly desirable aggregate or reentrant access
requirements that will come up.  Do date they haven't really because they
are flat out impossible to do more than fake up, but as hot-pluggable
devices and loopback based techniques come to the fore, the dependency list
starts to become unbounded.

The point you doubly miss is that I am not suggesting "all locks must be
reentrant" as some alternate pronouncement from on high, as a new truth to
replace the old in some quasi-religious coup.  Many of the (spin)locks
should be just as they are.  The per-cpu locks are an example.  The paging
system locks are another.  The should-be-self-exclusive locks are
characterized by a particular "privacy".

The counter-truth is that any lock that should/could/might be held by code
immediately on either side of a public interface should use recursive
locking.  These are primarily locks with a direct relationship to the
various _operations structures.  That is dentry_operations, file_ops, etc.
may each have one or more resources that naturally relate to them, said
resources are usually obvious because they are documented as locks that will
be taken before call, might be taken before call, should be taken during
phase X of what the call is supposed to do, or "must never be taken".  These
locks should be recursive.

That way, when you want to have your file system on your (conditionally?)
(partially?) encrypted block device which is dependent on your removable USB
dongle key, the authors for each of the components don't have to go and
crack open proven code.  (e.g. the block device is encrypted [a la CCS, but
not stupid] and is only accessible if the dongle key is inserted.  Should
that arrangement require the provider to also provide a mega-patch to ext3?
I think not.)

Sure, all your super-simple examples support super-simple locking.  The
interesting problems in the real world occasionally demand something more
than simple-minded-ness.

All of your counter examples and complaints boil down to variations on one,
very simple and straight forward case:

> 		relay()
>                 {
>                    mem = obtain_all_memory()
>                    lock_all_resources();
>                    execute_procedure(mem);
>                    unlock_all_resources();
>                    free(mem);
>                 }
>
> Since the only path to execute_procedure() is through this
> relay code, there cannot be any failures to unlock the device
> in certain execution paths or memory leaks, etc. Everything
> necessary to execute that common procedure atomically is
> set up ahead of time and torn down after it returns.

The logical outcome of your proposals is that there would (at any given
level of abstraction) be some outer ring of relay functions that wrap the
"real implementations" of all that lies within.  It would have to be an
outer ring so that, for my previous example, direct uses of ext3 and deltafs
would hit the locks but the internal uses where deltafs would call ext3
directly would call the routines behind the locks.  Such a ring could only
be implemented by doubling the width of the public interface so that it had
the ring-surface calls and the intra-ring calls (like read_op and
read_by_peer_op).  Yech.

So who is in charge of making sure that everything on both sides of any
possible combination of, say, dentry_operations is going to be re-dressed
with these relay functions?

Nobody, because that is naive and unworkable for aggregate code, you would
only be guessing who might want to aggregate what combinations of things.
It is a bad case of "magic happens here" and while such magic can be made in
the specific cases, making that magic happen in the general case is the road
back to the "BIG KERNEL LOCK".

Rob.

