Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUBUBoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUBUBoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:44:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:14721 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261475AbUBUBoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:44:08 -0500
Date: Sat, 21 Feb 2004 01:44:01 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040221014401.GD10928@mail.shareable.org>
References: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu> <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org> <20040220184822.GA23460@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220184822.GA23460@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > > there's another class of problems: is it an issue that directory renames
> > > that move this directory (higher up in the directory hierarchy of this
> > > directory) do not invalidate the cache? In that case there's no dnotify
> > > event either.
> > 
> > This is one of the reasons why I worry about user-space caching. It's
> > just damn hard to get right.
> 
> this particular problem could be solved by walking down to the root
> dentry for every sys_manage_dir_cache() lookup and check that each
> dentry is still cache-valid. This involves some overhead, but it's still
> faster than doing the same from userspace. (ie. validating each previous
> path component at lookup time.)

All that's required is that Samba has a dcache entry for each path
component.  In Samba's case, every path component from the share root
is case-insensitive, so that'll always be true.  For the path from the
filesystem root to the share root, Samba can either keep a dcache
entry for each of those components (just single entries; readdir isn't
required), or it can do fstat() on each request.  The former is
faster.

When you do an O_CLEAN operation, that'll check the clean bits of
every component during the kernel side path walk, so that validates
Samba's dcache for the whole path.

Samba doesn't need to call sys_mark_dir_clean(), or my preferred
dnotify equivalent, for each step in its userspace dcache walk.  It's
fine to just do the kernel O_CLEAN operation after verifying that
every path component is in Samba's dcache, without validating each
component.

That means Samba does the path walk in userspace, but with no system
calls, and then it calls the O_CLEAN operation.

(In other words, all those atomic_open, atomic_rename etc. operations
in my previous mail are fine, but they can be optimised much better).

Example of Samba code:

    atomic_open(name, flags, mode) {
        ci_name = soft_cache_lookup(name, found);
        if (found) {
            fd = clean_open (ci_name ? ci_name : name, flags, mode);
	    if (fd != -ENOTCLEAN)
                return fd;
        }
        do {
            ci_name = hard_cache_lookup(name);
            if (ci_name && (flags & O_EXCL)) { return -EEXIST; }
            if (!ci_name && !(flags & O_CREAT)) { return -ENOENT; }
            fd = clean_open (ci_name ? ci_name : name, flags, mode);
        } while (fd == -ENOTCLEAN);
        return fd;
    }

Remember, if Samba's dcache has an entry, whether positive or
negative, one of these is true:

    - the dcache entry matches what the clean_*() operation will
      find in the kernel; or
    - the clean_*() operation will return -ENOTCLEAN

(If you use the slightly fancier method of a dcache that doesn't care
about deletions, using dnotify with DN_CREATE|DN_RENAME only (not
DN_DELETE), then -ENOENT can be returned instead).

> Since this doesnt change the dcache it ought to be doable via the
> rcu-read path and would thus still have pretty good SMP
> properties. [except when traversing mountpoints :-( ].

Mount changes need to count as changes anyway.  I'd like DN_MOUNT
added, if DN_MODIFY doesn't already get sent for mount changes.

> What if there are two instances of fileservers both using the
> same fileset and also trying to do caching this way?

I'm fairly sure the scheme described in my long mail (the one with the
atomic_open etc. explanation) works just fine with different
fileservers accessing the same tree.

> perhaps using a simple 64-bit generation counter would be better.

I think that isn't needed.

> Samba would get a new syscall to get the sum of each generation
> counter down to the root dentry - a total validation of the
> pathname.

You can't just sum per-directory counters along the path, because the
path may be rearranged by renaming directories, and different path
components could easily sum to the same generation value.

So that's going to have to be a careful strong hash of (a) the
generation counters of individual directories, (b) _plus_ the path
sequence e.g. as inode numbers, (c) _plus_ something to handle mount
changes.

> If the counter matches with that in the userspace cache entry then
> no need to re-create the cache. Such generation counters would be
> usable for multiple file servers as well. Hm?

I don't think it is worth it, for Samba.  It's quite complicated to
get a number which detects all feasible changes, and I don't think it
offers Samba any efficiency gain over the single "clean bit".

(It's an interesting idea in general though).

> i believe Samba already has what is in essence a duplication of the
> dcache. We could enable it to be fairly coherent, for Samba to be able
> to have an authorative 'does this file exist' answer without any
> excessive readdir()s.

I'm pretty sure it can too - and in a way that's useful for many
applications not just Samba.  (I've hardly touched the surface of
what's possible using the very simple O_CLEAN technique).

-- Jamie
