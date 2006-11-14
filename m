Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966285AbWKNTZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966285AbWKNTZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966293AbWKNTZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:25:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966285AbWKNTZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:25:31 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162575034.5629.24.camel@lade.trondhjem.org> 
References: <1162575034.5629.24.camel@lade.trondhjem.org>  <1162561291.5635.64.camel@lade.trondhjem.org> <1162502667.6071.66.camel@lade.trondhjem.org> <1162496968.6071.38.camel@lade.trondhjem.org> <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> <32754.1162499917@redhat.com> <12984.1162549621@redhat.com> <22908.1162567413@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 14 Nov 2006 19:22:48 +0000
Message-ID: <11957.1163532168@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > Avoiding context switches aren't the main problem; avoiding serialisation
> > is.
> 
> Why? It is a backing cache. The only case where serialisation ought to
> bother you is the case where the client has to invalidate the cache due
> to a server-side update of the file.

Cache invalidation is not so much of a problem as at that point we know exactly
where whatever it is that we're invalidating is, and if it's a big object we
just move it somewhere for the userspace daemon to splat.

The serialisation problem is that if we put cache lookup in its own thread,
then in effect every open[*] of an NFS file, AFS file, whatever, will be
serialised.

It almost certainly wouldn't matter if what we did was to asynchronously look
up the cache cookie for a file.  In the common case, an open(O_RDONLY) syscall
is followed almost immediately by a read(), so there's not much to be gained
from asynchronising things as the cache cookie has to be available by the time
we come to process the read, but we can't get the cache cookie before
completing the server checks made by open, as we need the coherency data before
attempting to acquire a cookie.

The serialisation would stem from having to do several synchronous filesystem
ops for each cache lookup, but only having one thread in which to do them.
Okay, I could have several worker threads, but why?  Each process attempting to
access the cache provides me with a suitable worker thread, and then I can have
as many as there are tasks on the system.

[*] Note that for NFS I've now incorporated a patch from Steve Dickson to
acquire file cookies on the NFS open() file op, rather than during iget because
NFS readdir calls iget.

> Once the RPC calls have been launched, the process returns to the VM
> layer and just waits for the next page to be unlocked. It never returns
> to the filesystem layer. So where are you using the process context to
> write out the cached data?

What do you mean by "write out the cached data"?  Do you mean write the data to
the cache?

If so, that'd be nfs_readpage_to_fscache() as called from nfs_readpage_sync()
or nfs_readpage_release().

That calls fscache_write_page() which calls cachefiles_write_page() which calls
generic_file_buffered_write_one_kernel_page().

That last copies the data into the pagecache attached to an ext3 inode to be
written out (hopefully) asynchronously.

However, that may do other disk accesses, I suppose, as it calls
prepare_write() and commit_write() on ext3.

I could try and make it asynchronous, but that means more overhead in other
ways:-(  I presume this will then sometimes be running in rpciod context?

> The cookie lookups need to be synchronous, but why would the file
> creation need to be synchronous? Creating the cachefs file and waiting
> on that to complete etc are all utterly useless activities as far as
> satisfying the user request for data goes. Just start the process of
> creating a backing file, and then get on with the actual syscall.

vfs_mkdir() is synchronous.  vfs_create() is synchronous.  vfs_[sg]etxattr is
synchronous.  Lookup is synchronous.

Yes, I could make them all asynchronous, but it'd be a lot more work, and
mostly unnecessary, and I'd probably have to fight down lots of objections.


Remember: in the common case, open(O_RDONLY) is going to be followed quickly by
a read().  I suppose there may be an intervening stat() and malloc(), but even
so...

David
