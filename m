Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUBUAly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbUBUAjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:39:35 -0500
Received: from mail.shareable.org ([81.29.64.88]:11393 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261454AbUBUAin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:38:43 -0500
Date: Sat, 21 Feb 2004 00:38:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040221003831.GB10928@mail.shareable.org>
References: <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220173307.GF8994@mail.shareable.org> <Pine.LNX.4.58.0402201017370.2533@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402201017370.2533@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > How about this: we clean up dnotify, so it can be used for
> > user<->kernel dcache coherency
> 
> No can do.
> 
> There is no _way_ dnotify can do a race-free update, exactly because any 
> user-level state is fundamentally irrelevant because it isn't tested under 
> the directory semaphore.
> 
> See? You can have a user-level cache, but the flag and the notification 
> absolutely has to be under the inode semaphore (and thus in kernel space) 
> if you want to avoid all races with unrelated processes.

Eh?  The flag and notification operations are set and tested
under the inode semaphore, when fcntl() is called.

The userspace cache is a slave to the kernel's cache, and I think it
is _fully_ coherent with the kernel.

Every read of the userspace cache is guaranteed to reflect the
contents of the kernel cache, atomically with respect to other
operations by unrelated processes.  Also, operations on the directory
that depend on case-insensitive matching (create, link, rename etc.)
are also atomic with respect to unrelated processes.

The atomic read nature of the userspace cache comes from a loop.
It's very similar to the sequence lock in <linux/seqlock.h>:

    cache_lookup_names(names...) {
        while (fcntl(dirfd, F_NOTIFY, flags) != 0) {
            userspace_name_list = read_directory(dirfd);
        }
        return case_insensitive_lookup(userspace_name_list, names...);
    }

Atomic operations on the directory come from a higher level loop,
using Ingo's O_CLEAN idea:

    atomic_create(name, flags, mode) {
        do {
            ci_name = cache_lookup_names(name);
            if (ci_name && (flags & O_EXCL)) { return -EEXIST; }
            if (!ci_name && !(flags & O_CREAT)) { return -ENOENT; }
            fd = clean_open (name, flags, mode);
        } while (fd == -ENOENT || fd == -ENOTCLEAN);
        return fd;
    }

    atomic_stat(name, st) {
        do {
            ci_name = cache_lookup_names(name);
            if (!ci_name) { return -ENOENT; }
            result = stat (ci_name, st);
        } while (result == -ENOENT);
        return result;
    }

    /* This unlinks just one entry if there are multiple case-equivalent
       ones. If you want to remove _all_ case-equivalent entries, you'll
       need clean_unlink. */
    atomic_unlink(name) {
        do {
            ci_name = cache_lookup_names(name);
            if (!ci_name) { return -ENOENT; }
            result = unlink (ci_name);
        } while (result == -ENOENT);
        return result;
    }

    atomic_rename(old, new) {
        do {
            (ci_old, ci_new) = cache_lookup_names(old, new);
            if (!ci_old) { return -ENOENT; }
            result = clean_rename(ci_old, ci_new ? ci_new : new);
        } while (result == -ENOTCLEAN || result == -ENOENT);
    }

    atomic_link(from, to) {
        do {
            (ci_from, ci_to) = cache_lookup_names(from, to);
            if (!ci_from) { return -ENOENT; }
            if (ci_to) { return -EEXIST; }
            result = clean_link(ci_from, to);
        } while (result == -ENOTCLEAN || result == -ENOENT);
    }

(symlink, mkdir and rmdir are similar to link, create and unlink).

The operations clean_open, clean_mkdir, clean_rename, clean_link,
clean_symlink and clean_mknod are either new system calls, or use the
standard system calls with the fchdir() method I described.

Even path walking is atomic: Samba will do a path walk using a
case-insensitive lookup on each path component.  That means every
directory that is involved will be cached in Samba and have a "clean bit".

It doesn't matter whether Samba prefers to fchdir() each step (in
which case it'll get the atomicity that it would get doing that with
normal kernel case-sensitive lookups), or not and pass the whole path
to the clean_*() operation.  In the latter case, the clean_*()
operation will test all the clean bits involved in the target path
lookup, and return -ENOTCLEAN if any aren't set, thus providing the
normal atomicity guarantees.

Ingo's concern that a directory opened by Samba's cache might be moved
is not a problem: if that happens, it'll clear the clean bit of at
least one directory in the target path.

You gave an example before:

> On the other hand, even with a nice dnotify infrastructure, you
> simply _cannot_ get absolute atomicity guarantees. Because by the
> time you actually execute the "mv" operation, another process may
> create a new file with the "same" name (ie different name, but
> comparing the same ignoring case) on another CPU. By the time you
> get the dnotify, it's too late, and the move will have happened, and
> undoing the operation (and hiding it from the client) may well be
> impossible - possibly because another process creating a file with
> the old name.

The example is flawed: the attempted rename _is_ atomic.  Either
another process succeeds on another CPU, in which case _our_ attempt
to "mv" returns -ENOTCLEAN and we will start again by refreshing our
cache, or we beat the other process to it.

This works because the clean bit checking is done by the kernel, under
the directory/inode semaphores.

It's atomic w.r.t. both other POSIX processes _and_ other processes
with their own userspace caches.

> But then it should be documented as such. It's not coherent, it's only 
> "almost coherent".

It's entirely possible I'm being dense, but I think both Ingo's
proposal, and mine which is based on it but using dnotify both provide
_fully_ coherent userspace cache, and _atomic_ operations.

They do it by looping (like a spinlock or seqlock) rather than
sleeping until ready (like a semaphore), but that is ok as long as
there isn't excessive competition between Samba and other processes
modifying the same directory.

(If the excessive competition proves to be a performance problem, then
we can adapt F_SETLEASE to resolve that too.  But I don't think it is
necessary).

-- Jamie
