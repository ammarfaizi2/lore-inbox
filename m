Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSJCQrt>; Thu, 3 Oct 2002 12:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSJCQrt>; Thu, 3 Oct 2002 12:47:49 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:45708 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261362AbSJCQrq>; Thu, 3 Oct 2002 12:47:46 -0400
Date: Thu, 3 Oct 2002 12:53:04 -0400
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2)
Message-ID: <20021003165304.GA25718@ravel.coda.cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@cambridge.redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <torvalds@transmeta.com> <Pine.LNX.4.33.0210021730170.22980-100000@penguin.transmeta.com> <13691.1033635939@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13691.1033635939@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:05:39AM +0100, David Howells wrote:
> Linus Torvalds wrote:
> > On Wed, 2 Oct 2002, David Howells wrote:
> > >
> > > This patch adds an Andrew File System (AFS) driver to the
> > > kernel. Currently it only provides read-only, uncached, non-automounted
> > > and unsecured support.
> >
> > Are you sure this is the right way to go?
> 
> I think so. I think it makes sense for the AFS VFS-interface to go as directly
> as possible to the network without having to make context switches to get into
> userspace.

So you want to eventually link kerberos into the kernel to get the
security right?

> > As far as I can tell, this is a dead end, because we fundamentally cannot
> > do the local backing store from the kernel.
> 
> I disagree. I think we can (besides which OpenAFS does so), and that most of
> it is probably easier to do here than in userspace. For example:
> 
>  (*) Readpage
> 
>      The filesystem can either use a BIO to read directly into a new page if
>      the page is already in the cache, or it can read from across the network,
>      and then use a BIO to write the updated page into the cache. This should
>      avoid as much page-aliasing as possible.

Coda 'solves' the page-aliasing issues by passing the kernel the same
file descriptor as it is using itself to put the data into the container
(cache) file. You could do the same and tell the kernel what the
'expected size' is, it can then block or trigger further fetches when
that part of the file isn't available yet.

We don't need to do it at such a granualarity because of the
disconnected operation. It is more reliable as we can return a stale
copy when we lose the network halfway during the fetch.

>  (*) Writepage
> 
>      The filesystem can use a BIO to write a page into the cache, whilst
>      simultaneously dispatching it across the network. Alternatively, it can
>      write the page to the cache (fast) immediately and queue it up to be sent
>      across the network (slow) from the cache if memory pressure is high.

Hmm, a version of AFS that doesn't adhere to AFS semantics, interesting.
Are you going to emulate the same broken behaviour as transarc AFS on
O_RDWR? Basically when you open a file O_RDWR and write some data, and
anyone else 'commits' an update to the file before you close the
filehandle. Your client writes back the previously committed data, which
it has proactively fetched, but with the local metadata (i.e. i_size).
So you end up with something that closely resembles neither of the actual
versions that were written.

>  (*) Index searching
> 
>      The cache needs to keep an on disc index if the contents are to survive
>      rebooting. This can be searched more efficiently from within the kernel.
> 
>      I've written a scanning algorithm that can scan any file for fixed length
>      records in a manner that allows the disc blocks to be scanned in whatever
>      order they come off of the disc. This should make scanning the index
>      files faster, and may not actually be possible in userspace.

Can you say hack. Different underlying filesystems will lay out their
data differently, who says that ext3 with the dirindex hashes or
reiserfs, or foofs will not suddenly break your solution and still work
reliable (and faster) from userspace. When you can a file from userspace
the kernel will give you readahead, and with a well working elevator
any 'improvements' you obtain really should end up in the noise.

>  (*) On-disc file layout
> 
>      The on-disc file layout I'm using is the same as many other unix
>      filesystems (direct, indirect and double-indirect block pointers) and is
>      fairly simple. The biggest difference where I see a hole, I know I have
>      to fetch the page from the server, rather that just assuming there's an
>      implicit empty page there.

Intermezzo does the same thing, they even proposed a 'punch hole'
syscall to allow a userspace daemon to 'invalidate' parts of a file so
that the kernel will send the upcall to refetch the data from the server.

>      I'm fetching files a page at a time (on demand from the VM), though I may
>      extend this to get bunches of pages for efficiency reasons.

VM/VFS will handle appropriate readahead for you, you might just want to
join the separate requests into one bigger request.

>      moment it is closed. This has two definite disadvantages: you can't open
>      a file bigger than the remaining space in the cache, and the size of the
>      cache and the sizes of the files opened limits the number of files you
>      can have open.

And one definite advantage, you actually provide AFS session semantics.

> > Now, admittedly maybe the user-space deamon approach is crap, and what we
> > really want is to have some way to cache network stuff on the disk
> > directly from the kernel, ie just implement a real mapping/page-indexed
> > cachefs that people could mount and use together with different network
> > filesystems.
> 
> Hmmm... Interesting idea. There is the problem of working out which files
> belong to what source. The AFS filesystem has a three tier approach to
> identifying the source of a file: {cell,volume,vnode}, where any given volume
> can be on more than one server in a particular cell, and a vnode is the
> equivalent of an inode. I suppose NFS, say, could be handled similarly:
> {server,export,inode}, and SMB would probably be {server,share,filename}.

And my current development version of Coda has {cell,volume,vnode,unique}
(128 bits), which is the same size as a UUID which was designed to have
a very high probability of uniqueness. So if I ever consider adding
another 'ident', I'll just switch to identifying each object with a
UUID.

> The biggest hurdle here is the difference in potential record lengths:-/
> 
> 		CELL RECORD	CONSISTS OF
> 	AFS	64 + 16*4	name + 16 volume location servers
> 	NFS	4		IPv4 address
> 	SMB	?		server name (maybe just IP address)

How about IPv6?

> To have a heterogenous cache, the VLDB record and vnode index records could be
> extended to 2K or 4K in size, or maybe separate catalogues and indices could
> be maintained for different filesystem types, and a 0th tier could be a
> catalogue of different types held within this cache, complete with information
> as to the entry sizes of the tier 1, 2 and 3 catalogues.

Or you could use a hash or a userspace daemon that can map a fs-specific
handle to a local cache file.

Jan

