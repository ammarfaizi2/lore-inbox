Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSKJWNI>; Sun, 10 Nov 2002 17:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265203AbSKJWNI>; Sun, 10 Nov 2002 17:13:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:26604 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265201AbSKJWNG>;
	Sun, 10 Nov 2002 17:13:06 -0500
Date: Sun, 10 Nov 2002 17:19:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: [RFC] devfs API
Message-ID: <Pine.GSO.4.21.0211101348350.24061-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	During the last couple of weeks I'd done a lot of digging in
devfs-related code.  Results are interesting, and not in a good sense.

	1) a _lot_ of functions exported by devfs are never used.  At
all.
	2) a bunch of functions is used only by SGI hwgraph "port".
Moreover, a lot of codepaths in functions that *are* used outside of
said port, is only exercised by hwgraph.  (More on that below)
	3) gratitious arguments (read: all callers pass the same value).
	4) semantics of devfs_register() and devfs_unregister() is, er,
suboptimal and leads to rather messy cleanup paths in drivers.  (More on that
below).
	5) instead of using dev_t, devfs insists on keeping and passing
majors/minors separately, which makes both callers _and_ devfs itself
messier than necessary.
	6) devfs_entry is a nightmare.  It's a structure that contains
union (by node type), one of the fields of said union is a structure
that contains void *ops, flags, and a union of dev_t (stored as major/minor
pair) and size_t.  The reason for that (and charming expressions like
de->u.fcb.u.device.major) is an attempt to use one field for regular files,
character devices and block devices.  The *only* thing really common to all of
them is set of flags.
	7) idea of "slave" entries (== unregistered when master is
unregistered) hadn't worked out - it's easier to do explicit unregister
in 3 or 4 places that use these animals.

Overall, I would expect ~50% size reduction in devfs/base.c simply from
dropping unused code.  The rest would be much easier to debug.

Note that devfs is *seriously* burdened by hwgraph.  To the point where
it would be better to give SGI folks a private copy (they want slightly
different semantics anyway) and merge it with hcl.c and friends.  And
drop the unused stuff from devfs proper.

Situation when one obscure caller is responsible for ~30% of exported API
and pretty much gets unrestrictred access to internals is Not Good(tm).
Situation when ~40% of exported API is either not used at all or used only
by devfs itself is also not pretty.

Note that there's a large part of devfs that is never used by hwgraph
code.  IOW, after such split *both* devfs and hwgraph copy would shrink
a lot.  Shared part is actually rather small and both sides would be
better off from clear separation - e.g. locking and refcounting mechanisms
should be different, judging by the tricks hcl.c tries to pull off.

Another problem is the semantics of devfs_register/devfs_unregister.
rm -rf and install(1) do not match each other, even if they were
suitable as primitives (which is a dubious idea, to start with).

First of all, devfs_unregister(devfs_register(...)) is _not_ a no-op.
It may leave you with a bunch of new directories that have to be removed
later.  Moreover, you don't even know how many of them were there before
devfs_register() and need to be removed.

What's more, after devfs_register() we are allowed to create objects in
the intermediate directories that might appear (we can call mkdir(2) in
there, to start with).  However, devfs_unregister() wipes these out, which
is arguably a wrong thing to do - they were not created by driver, so
driver has no business to decide when they should be gone.

The following scheme would give saner behaviour (and deal with devfs_register()
failing in the middle of the way, etc. more gracefully):
	* all entries get two new fields: integer R and boolen V.
	* VFS creation methods (mknod, symlink, etc.) set R on the new node
to 0 and set V to true for that node and all its ancestors.  Refcount of
new node is set to 1.
	* register creates nodes with V set to false and increment R on the
object we had created and all its ancestors.  Refcount of created nodes is
set to 1.  If we fail to create a node (out of memory) we undo all increments
of R we had done so far.
	* VFS removal methods (unlink and rmdir) fail if R is positive or
V is false.  Otherwise they set V to false.
	* unregister decrements R on the victim and all its ancestors.
	* node is detached from parent whenever (R == 0 && !V) becomes true.
After that refcount of node is decremented.
	* node is freed when refcount reaches 0.
	* root is originally created with R set to 0 and V set to true.
	* places that currently grab/drop refcount still do that.

That will guarantee that
	* once userland creates an object, only userland can remove it or
any of its ancestors.
	* object can't be removed when kernel holds it or some of its
descendents registered.
	* unregister(register(...)) is a no-op
	* register failing mid-way cleans up after itself
	* objects are always removed by those who had created them.
	* as long as driver unregisters all objects it had registered,
it doesn't have to worry about intermediate directories, etc.

The price of switching to that scheme is that we will need to switch
drivers to explicit cleanups (i.e. instead of devfs_mk_dir "loop" +
register <n> in that directory + remove "loop" upon the exit we would
register loop/<n> when we initialize struct loop_device and unregister
it when we clean struct loop_device - actually, that could be done as
side effects of add_disk()/del_gendisk()).

Transition to explicit cleanups can be done before any changes in devfs
proper - the sequence is
	* add explicit devfs_unregister() (or devfs_find_and_unregister())
where needed in drivers; everything keeps working.
	* add aforementioned fields to devfs_entry and modify devfs_register()
and friends (see above).  No changes in drivers.
	* drop a shitload of devfs_mk_dir()/corresponding directory removals
from drivers; everything still works.
	* shift most of remaining calls in block device drivers into
add_disk()/del_gendisk(), etc.

I'd estimate that sequence as about a week of work - devfs changes in it can
be kept fairly local.  And IMNSHO it is needed, since it will make devfs
users much cleaner.

	Aside of that, there is a bunch of obvious cleanups - e.g. the 6th
argument of devfs_find_and_unregister() is (and should be) always 0; 3rd,
4th and 5th arguments are never looked at; the first one is NULL in almost
all cases and getting 3 or 4 exceptions into that form is absolutely trivial.
IOW, 4 arguments out of 6 are completely gratitious and reducing the thing
to devfs_remove(pathname) is a matter of several one-liners.

	There's a lot of such cases, but they definitely fall into "obvious
cleanups" category.  Really critical issues are getting sane model for
register/unregister (doable in small steps and I'm ready to do the entire
series) and separation of hwgraph - preferably giving it a filesystem of
its own with the interface hwgraph wants.

