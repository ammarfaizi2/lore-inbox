Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbSJDN5A>; Fri, 4 Oct 2002 09:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSJDN5A>; Fri, 4 Oct 2002 09:57:00 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:48014 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261765AbSJDN44>; Fri, 4 Oct 2002 09:56:56 -0400
Date: Fri, 4 Oct 2002 10:02:29 -0400
To: David Howells <dhowells@cambridge.redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2)
Message-ID: <20021004140229.GA11066@ravel.coda.cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@cambridge.redhat.com>,
	linux-kernel@vger.kernel.org
References: <jaharkes@cs.cmu.edu> <20021003165304.GA25718@ravel.coda.cs.cmu.edu> <15381.1033681790@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15381.1033681790@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:49:50PM +0100, David Howells wrote:
> Do I take it you were (partially) responsible for Coda development? I have to
> admit I don't know much about Coda.

Yeah, you could say I'm pretty much responsible of where we're going
with Coda nowadays. Don't know whether that's a good thing, because I
can be a bit stubborn on some things sometimes ;)
> 
> > So you want to eventually link kerberos into the kernel to get the
> > security right?
> 
> That's unnecessary judging by OpenAFS. AFAICT, only the ticket needs to be
> cached in the kernel (this is obtained by means of a userspace program), and
> then the ticket is passed through the security challenge/response mechanism
> provided by RxRPC.

The challenge response then might the same as Coda's, a modified
needham-schroeder handshake based on a shared secret which in your case
is obtained through kerberos. But I thought Kerberos was better
integrated in AFS and they actually were even using krb encryption for
the rxrpc packets (i.e. how are packets kept secure after the handshake)

> Besides, I get the impression that NFSv4 may require some level of kerberos
> support in the kernel.

If not kerberos, at least some for of encryption. IP/Sec would need the
same things.

> > Coda 'solves' the page-aliasing issues by passing the kernel the same file
> > descriptor as it is using itself to put the data into the container (cache)
> > file. You could do the same and tell the kernel what the 'expected size' is,
> > it can then block or trigger further fetches when that part of the file
> > isn't available yet.
> 
> I presume Coda uses a 1:1 mapping between Coda files and cache files stored
> under a local filesystem (such as EXT3). If so, how do you detect holes in the
> file, given that the underlying fs doesn't permit you to differentiate between
> a hole and a block of zeros.

We don't. Coda has the all or nothing fetch. When we get an open upcall
and the file isn't cached we get the whole file, and return the
filehandle we just used to fetch the file, that way even when pages
haven't been flushed to disk yet, the kernel will see the same data. All
reads and writes are wrapped in such a way that readpage and writepage
directly access the cache file, when an mmap is active the Coda inode
isn't even touched anymore.

> > We don't need to do it at such a granualarity because of the disconnected
> > operation. It is more reliable as we can return a stale copy when we lose
> > the network halfway during the fetch.
> 
> OTOH, if you have a copy that you know is now out of date, then one could
> argue that you shouldn't let the user/application see it, as they/it are then
> basing anything they do on known "bad" data.

Correct, but it is part of the Coda semantics, while disconnected from
the network/servers you are given the last cached version of a file. 

> Should I also take it that Coda keeps the old file around until it has
> fetched a revised copy? If so, then surely you can't update a file
> unless your cache can find room for the entire revised copy.

Actually, throwing out the old copy is still done, but I consider that a
bug. And from numerous reports I've seen, others consider it a bug as
well. That is mainly because people who use Coda actively at some point
start to expect Coda's semantic model and know that when they open a
file that is cached they should get something, even when the wire is
pulled (or the server dies).

> another consequence of this is that the practical maximum file size
> you can deal with is half the size of your cache.

Pretty much, but we need that extra space for the disconnected writes
anyways, that way we can always roll back to a consistent version.

> > Hmm, a version of AFS that doesn't adhere to AFS semantics, interesting.
> > Are you going to emulate the same broken behaviour as transarc AFS on
> > O_RDWR?

Ok, traditional AFS semantics is 'session semantics'. Very strict,
whenever you read from a file, everything is consistent wrt. the time
you opened the file. Whatever you write isn't committed on the server
until you close the file. This model has great advantages such as
minimizing network traffic, giving lock free read/write consistency.

The problems with the model are, you might be looking at stale data, or
you might overwrite someone elses changed (last writer wins). To avoid
the first you would need to reopen the file regularily, to avoid the
second you need to lock files.

However, once AFS became commercial, there was a lot of pressure from
new users to provide something more similar to UNIX semantics. So
whenever a callback was received from the servers, and the file was
open for reading, the client would pull in the latest version. That way
processes (shared databases?) didn't need to do close/open to see new
updates. (oops, lost the read consistency)

Now people started throwing big databases in the filesystem, and the
cache issues became important. So they introduced 'chunked access',
dirty chunks are still written when the file is closed, but also when
the cache is full (oops, lost write consistency).

When a file is open for both reading and writing you get effects like
the one I described above. With a full cache on the writing side you can
imagine even more interesting interactions, where we end up with a file
that contains alternating 64KB blocks of both files. So the nice
combination of these two subtle changes made the AFS3 file system in my
opinion unreliable and unusable, ofcourse all of this can be avoided by
locking the file, but in that case the original semantics were probably
already more than sufficient.

> What I'm intending to do is have the write VFS method attempt to write the new
> data direct to the server and to the cache simultaneously where possible. If
> the volume is not available for some reason, I have a number of choices:

You don't have the choices if you are trying to implement an AFS
compatible filesystem.

>  (3) Store the write in the cache and try and sync up with the volume when it
>      becomes available again.

That would be sufficient. But you _really_ need to block during the
final close operation when you have to make sure the data is on the
server before returning.

>  (4) "Diff" the page in the pagecache against a copy stored in the cache and
>      try to send the changes to the server.

As far as I know this is impossible without changing the existing AFS
servers.

> I don't need a hole punching syscall or ioctl. Apart from the fact that the
> filesystem is already in the kernel and doesn't require a syscall, the cache
> filesystem has to discard an entire file as a whole when it notices or is told
> of a change.

Doesn't AFS3 give callbacks when it updates a chunk of the file? I guess
it still has retained at least that part of the original semantics, send
callbacks when the file is closed (and the data is 'officially'
committed). It is still up in the air what clients see that read the
file between the chunked writes and the actual file close.

> > And one definite advantage, you actually provide AFS session semantics.
> 
> According to the AFS-3 Architectural Overview, "AFS does _not_ provide for
> completely disconnected operation of file system clients" [their emphasis].

Disconnected operation has never been 'AFS semantics'. That's a Coda thing.

> > And my current development version of Coda has {cell,volume,vnode,unique}
> > (128 bits), which is the same size as a UUID which was designed to have a
> > very high probability of uniqueness. So if I ever consider adding another
> > 'ident', I'll just switch to identifying each object with a UUID.
> 
> Does this mean that every Coda cell is issued with a 4-byte ID number?
> Or does there need to be an additional index in the cache?

A Coda cell is simply a FQDN, whenever the userspace cachemanager
accesses a new cell it a locally unique ID, which will exist as long as
there are objects from that cell in the cache.

> You still have to store a hash somewhere, and if it's stored in a userspace
> daemon's VM, then it'll probably end up being swapped out to disc,

Why would it probably be swapped out to disc? If you're really worried
about that you could mlock the memory. And if you think that is too
expensive, it is still better to mlock memory in userspace that to
allocate that same memory in kernel space.

>                                                                    and it may
> have to be regenerated from indices every time the daemon is restarted (or
> else your cache has to be started afresh.

Yeah, that's why Coda is using a recoverable VM, basically a mmapped
file with an log where modifications are recorded so that we can
replay/rollback uncommitted operations when we're restarting.

Jan

