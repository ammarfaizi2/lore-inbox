Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030803AbWKOSUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030803AbWKOSUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030805AbWKOSUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:20:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62380 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030803AbWKOSUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:20:23 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1163608871.5691.159.camel@lade.trondhjem.org> 
References: <1163608871.5691.159.camel@lade.trondhjem.org>  <1163599542.5691.84.camel@lade.trondhjem.org> <1162575034.5629.24.camel@lade.trondhjem.org> <1162561291.5635.64.camel@lade.trondhjem.org> <1162502667.6071.66.camel@lade.trondhjem.org> <1162496968.6071.38.camel@lade.trondhjem.org> <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> <32754.1162499917@redhat.com> <12984.1162549621@redhat.com> <22908.1162567413@redhat.com> <11957.1163532168@redhat.com> <25967.1163604494@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 18:17:38 +0000
Message-ID: <1708.1163614658@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > > No. All you should need is the result of the lookup().
> > 
> > Plus the mkdirs, etc., but I'll assume you implied those.
> 
> No! The success or failure of the NFS operation does _not_ depend on
> CacheFiles success or failure.

I have not said that it does, and in fact I've made sure that it does not.

> As far as I'm concerned, the mkdirs etc actually _want_ to be farmed out to
> some background daemon so that they have no effect on NFS performance. See
> below.

In effect they will.  Yes, ideally everything would be done in the background
on a cache miss, but it's not as simple as you make it out to be.

Your assertion is that I should deal with the security issue by doing
everything in an auxiliary thread - but that means doing the lookups there too.

> In the event of a mkdir() or create(), asynchronicity _does_ make a
> difference, because there is no cached file to read.

But it does make a difference, because the file has to exist before the first
readpages, unless you want to special-case the first readpages - in which case
it has to exist before the second readpages because the second readpage or
readpages might require re-reading of pages the first readpages obtained (the
VM may have discarded them on memory pressure).

> > I'm hesitant about allocating memory to hold a list of pages in that
> > context as it might fail.

Though I might be able to make use of the spent nfs_page struct.

> All that you want to _try_ to ensure is that the page gets written out
> before the memory shrinker kicks it out of the page cache. There is
> absolutely no need to do this synchronously. There is not even a need to
> guarantee that all read pages will hit fscache.

Hah!  I've already got bug reports because it appears that not all pages are
hitting the cache.

Generally, I would agree though.  I would say that unless there is a lot of
memory pressume, all pages should wind up in the cache.  If there is memory
pressure, then it may be okay to abort the writes to the cache.  This might
have to be tunable.

> Again, this is something that a background daemon could happily do for
> you.

Again, generally I'd agree, though I'm not sure one thread is sufficient.
Perhaps one per CPU.  With CacheFiles as it stands at the moment, that thread
is going to spend a lot of time copying data between pages, and so recycling of
the pagecache is going to be affected.

Unless you can suggest a way of reducing the queue of pages waiting on writing
to the cache under memory pressure (mainly how to work out that there is memory
pressure).

> > > All of them are synchronous as far as accessing the remote filesystem is
> > > concerned.
> > 
> > What has "accessing the remote filesystem" got to do with it?
> > 
> > > Why would the user process care if a privileged daemon has completed the
> > > shadow mkdir() or create() on the CacheFiles system or not?
> 
> It doesn't, and that is my point. If the fscache backing store doesn't
> have the file, then the user process wants to talk to the remote server
> ASAP. It doesn't want to waste its time creating CacheFiles.

Erm... I think you're arguing with your own question there.

Note that NFS has to talk to the server *first*.  We want to know the coherency
details at the time we look the file up, so that if it exists, we can decide
whether we want to keep it or not.

Furthermore, we need the data storage file available to store pages in as we
read them.  We can farm everything out to other threads, but the total
processing time is increased, and it requires more resources and more
complexity.

> > The user process may not do a read() or an mmap() on a read-only file it
> > has just opened until we've found the data storage object in the cache
> > associated with that file, or it has created one.
> 
> 'or it has created one' is a completely artificial bottleneck that _you_
> are imposing.

Not really.  Unless readpages() special-cases the first invocation on an inode
we know we didn't previously have in the case, this bottleneck stands.  The
second and subsequent readpages() invocations and any readpage() invocation
must assume that there may be pages in the cache already.


Yes, I agree that it'd be very nice to be completely asynchronous with respect
to the cache, but it makes various things much more complex and more resource
intensive as we have to (a) farm things off to other threads, and (b) keep
track of a whole load of extra things.

> > Which is what you're suggesting.  Whereas what I have at the moment is this:
> 
> No. Why the hell should read() have to wait on what it knows to be an
> empty file? As soon as that lookup() is done you can figure out that the
> data is not cached, and that the read() needs to go talk to the NFS
> server.

In your world, lookup() must also be farmed off to that other thread.

> There is no reason whatsoever to wait for 50 synchronous mkdir()s and
> setxattr()s to complete. Those operations can and should be farmed out
> to a background process to take care of.
> The ideal model looks like
> 
> 
>         PROC A          PROC B          PROC C          PROC D
>         =============== =============== =============== =============== 
>         open()          open()          open()          open()
>         A:lookup()      B:lookup()      C:lookup()      D:lookup()
>         read()          read()          read()          read()

Nope.  You aren't permitted to do that.  You've defined your security model as
being context-switch based, so you have to do your lookups in the service
thread.  Assuming you're going to get a hit on all your lookups, what you end
up with is:

	SERVICE	PROC A	PROC B	PROC C	PROC D
	=======	=======	=======	=======	=======
		open()	open()	open()	open()
	A:lookup()
	A:getxattr()
	A:lookup()
	A:getxattr()
	A:lookup()
	A:getxattr()
	A:lookup()
	A:getxattr()
	A:lookup()
	A:getxattr()
	A:open()
		read()
	B:lookup()
	B:getxattr()
	B:lookup()
	B:getxattr()
	B:lookup()
	B:getxattr()
	B:lookup()
	B:getxattr()
	B:lookup()
	B:getxattr()
	B:open()
			read()
	C:lookup()
	C:getxattr()
	C:lookup()
	C:getxattr()
	C:lookup()
	C:getxattr()
	C:lookup()
	C:getxattr()
	C:lookup()
	C:getxattr()
	C:open()
				read()
	D:lookup()
	D:getxattr()
	D:lookup()
	D:getxattr()
	D:lookup()
	D:getxattr()
	D:lookup()
	D:getxattr()
	D:lookup()
	D:getxattr()
	D:open()
					read()

Remember: lookup() and getxattr() are, by there very nature, synchronous, and
so you end up with serialisation.

David
