Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030572AbWKOPbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbWKOPbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbWKOPbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:31:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11711 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030572AbWKOPbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:31:00 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1163599542.5691.84.camel@lade.trondhjem.org> 
References: <1163599542.5691.84.camel@lade.trondhjem.org>  <1162575034.5629.24.camel@lade.trondhjem.org> <1162561291.5635.64.camel@lade.trondhjem.org> <1162502667.6071.66.camel@lade.trondhjem.org> <1162496968.6071.38.camel@lade.trondhjem.org> <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> <32754.1162499917@redhat.com> <12984.1162549621@redhat.com> <22908.1162567413@redhat.com> <11957.1163532168@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 15:28:14 +0000
Message-ID: <25967.1163604494@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> No. All you should need is the result of the lookup().

Plus the mkdirs, etc., but I'll assume you implied those.

> The coherency data needs to be checked against an eventual existing
> CacheFiles entry during the call to read(), not before.

Or mmap().

But, yes, whilst that's true; the read() is almost certainly going to occur
very quickly after the open(), and so the likelyhood is that asynchronicity is
not going to matter.

> Umm...because the former is a model which actually fits your security
> requirements (i.e. one privileged daemon gets lookup()+open()+mkdir()...
> rights on the CacheFiles partition), whereas the latter is not (all
> tasks need lookup()+open()+mkdir().... privileges)?

The former model is much more complex than the latter, and also has perfomance
issues.

Besides, the latter model seems to work for me (as long as I'm allowed to
change the security ID a process is acting as).

> > If so, that'd be nfs_readpage_to_fscache() as called from
> > nfs_readpage_sync() or nfs_readpage_release().
> 
> nfs_readpage_release() is an rpciod context, _not_ a user thread
> context.

But it *is* process context...

I'm not sure what to do about that.  I could maintain a record of every page
being serviced by FS-Cache, but that could be an awful lot of pages, and so
consume an awful lot of memory.

I'm hesitant about allocating memory to hold a list of pages in that context as
it might fail.

> > However, that may do other disk accesses, I suppose, as it calls
> > prepare_write() and commit_write() on ext3.
> 
> Which would generally be forbidden under the rpciod context, BTW, since
> they imply calls to generic memory allocation (== nasty tricksy deadlock
> potential, since rpciod may be called upon to help write out NFS pages
> via shrink_page_list and friends).

I wish you'd mentioned that six months or more ago when I first waved these
patches in front of you.

> > vfs_mkdir() is synchronous.  vfs_create() is synchronous.  vfs_[sg]etxattr
> > is synchronous.  Lookup is synchronous.
> 
> All of them are synchronous as far as accessing the remote filesystem is
> concerned.

What has "accessing the remote filesystem" got to do with it?

> Why would the user process care if a privileged daemon has completed the
> shadow mkdir() or create() on the CacheFiles system or not?

Sigh.

The user process may not do a read() or an mmap() on a read-only file it has
just opened until we've found the data storage object in the cache associated
with that file, or it has created one.

However, several user processes may be accessing several different files on
serveral different mounts of maybe several different netfs's all at the same
time.  This could mean that on behalf of each of these processes, CacheFiles
has to create serveral directories and a file.

But it may only have one thread in which to do this, and so each "cache lookup"
will wind up being serialised around the synchronous ext3 operations that
create files and directories and set xattrs.  Consider:

	SERVICE	PROC A	PROC B	PROC C	PROC D
	=======	=======	=======	=======	=======
		open()	open()	open()	open()
	A:lookup()
	A:mkdir()
	A:setxattr()
	A:mkdir()
	A:setxattr()
	A:mkdir()
	A:setxattr()
	A:mkdir()
	A:setxattr()
	A:mkdir()
	A:setxattr()
	A:create()
	A:setxattr()
		read()
	B:lookup()
	B:mkdir()
	B:setxattr()
	B:mkdir()
	B:setxattr()
	B:mkdir()
	B:setxattr()
	B:mkdir()
	B:setxattr()
	B:mkdir()
	B:setxattr()
	B:create()
	B:setxattr()
			read()
	C:lookup()
	C:mkdir()
	C:setxattr()
	C:mkdir()
	C:setxattr()
	C:mkdir()
	C:setxattr()
	C:mkdir()
	C:setxattr()
	C:mkdir()
	C:setxattr()
	C:create()
	C:setxattr()
				read()
	D:lookup()
	D:mkdir()
	D:setxattr()
	D:mkdir()
	D:setxattr()
	D:mkdir()
	D:setxattr()
	D:mkdir()
	D:setxattr()
	D:mkdir()
	D:setxattr()
	D:create()
	D:setxattr()
					read()

Which is what you're suggesting.  Whereas what I have at the moment is this:

	PROC A		PROC B		PROC C		PROC D
	===============	===============	===============	===============	
	open()		open()		open()		open()
	A:lookup()	B:lookup()	C:lookup()	D:lookup()  
	A:mkdir()	B:mkdir()	C:mkdir()	D:mkdir()   
	A:setxattr()	B:setxattr()	C:setxattr()	D:setxattr()
	A:mkdir()	B:mkdir()	C:mkdir()	D:mkdir()   
	A:setxattr()	B:setxattr()	C:setxattr()	D:setxattr()
	A:mkdir()	B:mkdir()	C:mkdir()	D:mkdir()   
	A:setxattr()	B:setxattr()	C:setxattr()	D:setxattr()
	A:mkdir()	B:mkdir()	C:mkdir()	D:mkdir()   
	A:setxattr()	B:setxattr()	C:setxattr()	D:setxattr()
	A:mkdir()	B:mkdir()	C:mkdir()	D:mkdir()   
	A:setxattr()	B:setxattr()	C:setxattr()	D:setxattr()
	A:create()	B:create()	C:create()	D:create()  
	A:setxattr()	B:setxattr()	C:setxattr()	D:setxattr()
	read()		read()		read()		read()

Even if you replace the mkdir()'s and create()'s with lookup()'s and the
setxattr()'s with getxattr()'s, it doesn't make much difference: lookup() and
getxattr() are both reads and both synchronous.

> > Remember: in the common case, open(O_RDONLY) is going to be followed
> > quickly by a read().  I suppose there may be an intervening stat() and
> > malloc(), but even so...
> 
> Which is why lookup() + open() + read() needs to be fast in the case
> where you have a CacheFiles hit. It does not justify mkdir, create, etc
> being fast, nor does it justify the open() + read() part needing to be
> fast in the case of a CacheFiles miss.

My point is that if userspace does open() + read() with no or little
intervening stuff, then asynchronicity is irrelevant as the whole process is
rendered effectively synchronous because the first read() has to wait on
completion.

And once an inode has been assayed for cache presence, subsequent open() calls
don't need to go to the cache as the state is retained in memory until the
inode is discarded.

David
