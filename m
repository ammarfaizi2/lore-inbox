Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSJDQBn>; Fri, 4 Oct 2002 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSJDQBn>; Fri, 4 Oct 2002 12:01:43 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:54927 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261574AbSJDQBh>; Fri, 4 Oct 2002 12:01:37 -0400
Date: Fri, 4 Oct 2002 12:07:08 -0400
To: David Howells <dhowells@cambridge.redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2)
Message-ID: <20021004160708.GA14737@ravel.coda.cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@cambridge.redhat.com>,
	linux-kernel@vger.kernel.org
References: <jaharkes@cs.cmu.edu> <20021004140229.GA11066@ravel.coda.cs.cmu.edu> <27276.1033745672@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27276.1033745672@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 04:34:32PM +0100, David Howells wrote:
> > We don't. Coda has the all or nothing fetch. When we get an open upcall and
> > the file isn't cached we get the whole file, and return the filehandle we
> > just used to fetch the file, that way even when pages haven't been flushed
> > to disk yet, the kernel will see the same data. All reads and writes are
> > wrapped in such a way that readpage and writepage directly access the cache
> > file, when an mmap is active the Coda inode isn't even touched anymore.
> 
> So, say you've got a really big file in your cache. Someone changes a single
> byte in it. You can work out that the file has changed by one of a number of
> means. How do you avoid having to throw the entire file back to the server?

Coda actually writes the whole file back. Someone was working on an
rsync based method, but I haven't heard anything for a while. It is
actually mostly databases that update single bytes in large files.
Anything like a text editor will move the original file to a backup copy
and write a new version anyways. Compilers tend to throw away the old
object files and create a new file, etc.

> > Pretty much, but we need that extra space for the disconnected writes
> > anyways, that way we can always roll back to a consistent version.
> 
> How do you sync up with the server on reconnection? This is similar to the
> problem you pointed out that I have to solve - how to deal with the file on
> the server being changed by another client whilst I'm also trying to write to
> it.

We automatically resolve directory conflict, file conflicts are 'punted'
to userspace. There is a manual repair tool, where a user can pick the
version that he believes is the most appropriate, or he can substitute a
replacement or merged copy.

There is also a framework for application specific resolvers, these can
try to automatically merge f.i. calendar files, or email boxes, or
remove/recompile object files when there is a conflict, etc.

For AFS you don't have to care, it's semantics without locking are that
the 'last writer to close it's fd' wins.

> Whatever model you choose, you have to accept some compromises.

I thought you were implementing AFS, how can you choose your model?

> The model I'm thinking of is as follows:
...
>  (*) All data cached by a client for a particular file is zapped if I get a
>      callback from the server and/or the data version number of that file
>      appears to have changed.

How about dirty data, that was locally modified? There is a network
latency that comes into play here. If you want last writer wins you
should not zap dirty data.

>  (*) In O_SYNC mode, data is written back to the server as promptly as
>      possible within the write() call (maybe through the auspices of
>      prepare_write and commit_write).

So other clients will read inconsistent data if they don't have that
chunk cached. And if the server generates callbacks on the write of a
chunk, all clients see the update?

>  (*) In non-O_SYNC mode, I would like the data to be written back through the
>      page cache's writepage() routine(s). By setting the dirty bits on pages,
>      the write will be scheduled by the VM at some point. This would permit
>      better write coelescing locally. However, security becomes a problem,
>      since I have to say to the server which user I'm doing a store as, and if
>      the data is coelesced from writes done as several different users, then
>      there could be a problem if the store is rejected.

Ehh, access permissions should already be checked when the file is
opened. NFS is dealing with the same problems here.

>      How does Coda deal with this security problem?

What problem? If you don't have write permission you can't write to the
file. If you do have write permissions you can write. When the last
writer closes it's filehandle the data is sent to the server with his
permissions.

Now if the ACL is changed on the servers before the close so that this
last writer loses write access we get a 'conflict' that is punted to
userspace, similar to the case when writing to an already updated file.

> > Why would it probably be swapped out to disc? If you're really worried about
> > that you could mlock the memory. And if you think that is too expensive, it
> > is still better to mlock memory in userspace that to allocate that same
> > memory in kernel space.
> 
> I'm storing mine on disc as do normal disc-based FS's. That means it can be a
> lot bigger. Besides, you don't really want to mlock memory or store it in the
> kernel - that would be a big chunk of memory permanently committed and
> unavailable for other uses.

So I store it in VM on the disk and you store it in your private FS on
disk. Looks like the same thing to me, except I get to enjoy the
benefits of the page/swapcache keeping the data in memory when it is
frequently used without having to do anything smart.

> > Yeah, that's why Coda is using a recoverable VM, basically a mmapped
> > file with an log where modifications are recorded so that we can
> > replay/rollback uncommitted operations when we're restarting.
> 
> What's "VM" in this context?

Virtual Memory. A private mmap of a file. Updates dirty the pages, so
they end up in swap, but we log the same update in a logfile (journal),
when the log fills up, the changes written directly to the underlying
file. Optionally, when we know that the swap copy and the file copy of
the page are identical, the page is remapped to reduce swap usage. That
is where we store all the metadata and the Coda file -> cache file
mappings so that they can survive a reboot or system crash.

Jan

