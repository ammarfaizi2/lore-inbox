Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbSKLLkH>; Tue, 12 Nov 2002 06:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbSKLLkH>; Tue, 12 Nov 2002 06:40:07 -0500
Received: from holomorphy.com ([66.224.33.161]:40634 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266537AbSKLLkC>;
	Tue, 12 Nov 2002 06:40:02 -0500
Date: Tue, 12 Nov 2002 03:44:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [RFC] devfs API
Message-ID: <20021112114416.GA22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
	Richard Gooch <rgooch@ras.ucalgary.ca>
References: <Pine.GSO.4.21.0211101348350.24061-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211101348350.24061-100000@steklov.math.psu.edu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> 	During the last couple of weeks I'd done a lot of digging in
> devfs-related code.  Results are interesting, and not in a good sense.
> 	1) a _lot_ of functions exported by devfs are never used.  At
> all.

Kill 'em.

On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> 	2) a bunch of functions is used only by SGI hwgraph "port".
> Moreover, a lot of codepaths in functions that *are* used outside of
> said port, is only exercised by hwgraph.  (More on that below)

Is that in-tree? If so, why? Hmm. IA64 arch code. I'd ask Mosberger for
a maintainer check for whether killing it outright would be acceptable
or something.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> 	3) gratitious arguments (read: all callers pass the same value).

Kill 'em.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> 	4) semantics of devfs_register() and devfs_unregister() is, er,
> suboptimal and leads to rather messy cleanup paths in drivers.  (More on that
> below).

This is the weird implicit rm -rf stuff?


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> 	5) instead of using dev_t, devfs insists on keeping and passing
> majors/minors separately, which makes both callers _and_ devfs itself
> messier than necessary.

Um, wait, ISTR a large exercise in insulating in-kernel API's from such
device numbers. I take this to mean devfs is not cooperating.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> 	6) devfs_entry is a nightmare.  It's a structure that contains
> union (by node type), one of the fields of said union is a structure
> that contains void *ops, flags, and a union of dev_t (stored as major/minor
> pair) and size_t.  The reason for that (and charming expressions like
> de->u.fcb.u.device.major) is an attempt to use one field for regular files,
> character devices and block devices.  The *only* thing really common to all of
> them is set of flags.

I'm having nightmares already.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> 	7) idea of "slave" entries (== unregistered when master is
> unregistered) hadn't worked out - it's easier to do explicit unregister
> in 3 or 4 places that use these animals.

Unused and/or unusable API feature == kill at will IMHO. Even in a
stable release and/or codefreeze.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> Overall, I would expect ~50% size reduction in devfs/base.c simply from
> dropping unused code.  The rest would be much easier to debug.
> Note that devfs is *seriously* burdened by hwgraph.  To the point where
> it would be better to give SGI folks a private copy (they want slightly
> different semantics anyway) and merge it with hcl.c and friends.  And
> drop the unused stuff from devfs proper.
> Situation when one obscure caller is responsible for ~30% of exported API
> and pretty much gets unrestrictred access to internals is Not Good(tm).
> Situation when ~40% of exported API is either not used at all or used only
> by devfs itself is also not pretty.

Excellent, especially if compiled codesize reduction also follows. I'm
still questioning what something that invasive is doing in arch code,
and why it's there at all if it should be core but does not meet core
code standards.

As far as removing unused crap goes, it's unused. Aside from things
getting smaller, faster, and cleaner, it's a nop. All good.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> Note that there's a large part of devfs that is never used by hwgraph
> code.  IOW, after such split *both* devfs and hwgraph copy would shrink
> a lot.  Shared part is actually rather small and both sides would be
> better off from clear separation - e.g. locking and refcounting mechanisms
> should be different, judging by the tricks hcl.c tries to pull off.

I haven't seen hcl.c and I'm afraid to look from hearing this. These
is, after all, the same vendor responsible for shub_mmr_t.h


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> Another problem is the semantics of devfs_register/devfs_unregister.
> rm -rf and install(1) do not match each other, even if they were
> suitable as primitives (which is a dubious idea, to start with).
> First of all, devfs_unregister(devfs_register(...)) is _not_ a no-op.
> It may leave you with a bunch of new directories that have to be removed
> later.  Moreover, you don't even know how many of them were there before
> devfs_register() and need to be removed.

That is too bogus for words. Reimplementing the mechanics there is a
pure bugfix IMHO.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> What's more, after devfs_register() we are allowed to create objects in
> the intermediate directories that might appear (we can call mkdir(2) in
> there, to start with).  However, devfs_unregister() wipes these out, which
> is arguably a wrong thing to do - they were not created by driver, so
> driver has no business to decide when they should be gone.

More bugs. Can of Raid == good.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> The following scheme would give saner behaviour (and deal with devfs_register()
> failing in the middle of the way, etc. more gracefully):
> 	* all entries get two new fields: integer R and boolen V.
> 	* VFS creation methods (mknod, symlink, etc.) set R on the new node
> to 0 and set V to true for that node and all its ancestors.  Refcount of
> new node is set to 1.
> 	* register creates nodes with V set to false and increment R on the
> object we had created and all its ancestors.  Refcount of created nodes is
> set to 1.  If we fail to create a node (out of memory) we undo all increments
> of R we had done so far.
> 	* VFS removal methods (unlink and rmdir) fail if R is positive or
> V is false.  Otherwise they set V to false.
> 	* unregister decrements R on the victim and all its ancestors.
> 	* node is detached from parent whenever (R == 0 && !V) becomes true.
> After that refcount of node is decremented.
> 	* node is freed when refcount reaches 0.
> 	* root is originally created with R set to 0 and V set to true.
> 	* places that currently grab/drop refcount still do that.

Okay, straightforward refcounting and (in)validation scheme.
Seal of approval thus far.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> That will guarantee that
> 	* once userland creates an object, only userland can remove it or
> any of its ancestors.
> 	* object can't be removed when kernel holds it or some of its
> descendents registered.
> 	* unregister(register(...)) is a no-op
> 	* register failing mid-way cleans up after itself
> 	* objects are always removed by those who had created them.
> 	* as long as driver unregisters all objects it had registered,
> it doesn't have to worry about intermediate directories, etc.

Okay, this means the bugs are fixed, which pretty much means that proper
(in)validation and refcounting is happening as above.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> The price of switching to that scheme is that we will need to switch
> drivers to explicit cleanups (i.e. instead of devfs_mk_dir "loop" +
> register <n> in that directory + remove "loop" upon the exit we would
> register loop/<n> when we initialize struct loop_device and unregister
> it when we clean struct loop_device - actually, that could be done as
> side effects of add_disk()/del_gendisk()).

I personally would balk at this amount of work, but it's the implication
of the handling scheme.


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> Transition to explicit cleanups can be done before any changes in devfs
> proper - the sequence is
> 	* add explicit devfs_unregister() (or devfs_find_and_unregister())
> where needed in drivers; everything keeps working.
> 	* add aforementioned fields to devfs_entry and modify devfs_register()
> and friends (see above).  No changes in drivers.
> 	* drop a shitload of devfs_mk_dir()/corresponding directory removals
> from drivers; everything still works.
> 	* shift most of remaining calls in block device drivers into
> add_disk()/del_gendisk(), etc.

I'm foggy on gendisk mechanics. Sounds like the gendisk bits handle the
disk-specific bits of devfs handling?


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> I'd estimate that sequence as about a week of work - devfs changes in it can
> be kept fairly local.  And IMNSHO it is needed, since it will make devfs
> users much cleaner.
> 	Aside of that, there is a bunch of obvious cleanups - e.g. the 6th
> argument of devfs_find_and_unregister() is (and should be) always 0; 3rd,
> 4th and 5th arguments are never looked at; the first one is NULL in almost
> all cases and getting 3 or 4 exceptions into that form is absolutely trivial.
> IOW, 4 arguments out of 6 are completely gratitious and reducing the thing
> to devfs_remove(pathname) is a matter of several one-liners.

Cheers to the kernel janitor extroardinaire. =)


On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> 	There's a lot of such cases, but they definitely fall into "obvious
> cleanups" category.  Really critical issues are getting sane model for
> register/unregister (doable in small steps and I'm ready to do the entire
> series) and separation of hwgraph - preferably giving it a filesystem of
> its own with the interface hwgraph wants.

This hwgraph stuff sounds very suspicious to me. A quick look makes me
relatively suspicious about what it's doing with devfs since it looks
like it's doing a lot more gyrations centered around its own private
structures than anything to do with devfs aside from twiddling the
occasional dentry or two.

And frankly, it looks bizarre especially considering it's attempting to
represent notions of topology not present in Linux at all.


Cheers,
Bill
