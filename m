Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSIJS7u>; Tue, 10 Sep 2002 14:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSIJS7u>; Tue, 10 Sep 2002 14:59:50 -0400
Received: from citi.umich.edu ([141.211.92.141]:41079 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S318022AbSIJS7m>;
	Tue, 10 Sep 2002 14:59:42 -0400
Date: Tue, 10 Sep 2002 15:04:28 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <E17oneD-0007Dk-00@starship>
Message-ID: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Daniel Phillips wrote:

> On Tuesday 10 September 2002 17:09, Chuck Lever wrote:
> > i can answer the question "when does the NFS client purge a file's cached
> > data?"
> >
> > there are four major categories:
> >
> > a.  directory changes require any cached readdir results be purged.
>
> That is, the client changes the directory itself?  I suppose an NFS
> server is incapable of reporting directory changes caused by other
> clients, because of being stateless.

when a client itself changes a directory, it must purge it's own readdir
cache.  this is because the server is really in control of the contents,
which are treated as more or less opaque by the client.  the next time any
application on the client wants to read the directory, the client will go
back to the server to get the updated contents.

the NFS server doesn't report changes, the client must infer them from
changes in a file's size and mtime.  such changes are detected this way
for directories as well as files.  Trond may have added some code recently
that also "flushes" the dentry cache for a directory when such a change is
detected for a directory.

> > c.  when a file is locked or unlocked via lockf/fcntl, all pending writes
> >     are pushed back to the server and any cached data in the page cache is
> >     purged before the lock/unlock call returns.
>
> Do you mean, the client locks/unlocks the file, or some other client?

when a client locks or unlocks a file, it flushes pending writes and
purges its read cache.

> I'm trying to fit this into my model of how the server must work.  It
> must be that the locked/unlocked state is recorded at the server, in
> the underlying file, and that the server reports the locked/unlocked
> state of the file to every client via attr results.

no, lock management is handled by an entirely separate protocol.  the
server maintains lock state separately from the actual files, as i
understand it.

> So now, why purge at *both* lock and unlock time?

this is a little long.

clients use what's called "close-to-open" cache consistency to try to
maintain a single-system image of the file.  this means when a file is
opened, the client checks with the server to get the latest version of the
file data and metadata (or simply to verify that the client can continue
using whatever it has cached).  when a file is closed, the client always
flushes any pending writes to the file back to the server.

in this way, when client A closes a file and subsequently client B opens
the same file, client B will see all changes made by client A before it
closed the file.  note that while A still has the file open, B may not see
all changes made by A, unless an application on A explicitly flushes the
file.  this is a compromise between tight cache coherency and good
performance.

when locking or unlocking a file, the idea is to make sure that other
clients can see all changes to the file that were made while it was
locked.  locking and unlocking provide tighter cache coherency than simple
everyday close-to-open because that's why applications go to the trouble
of locking a file -- they expect to share the contents of the file with
other applications on other clients.

when a file is locked, the client wants to be certain it has the latest
version of the file for an application to play with.  the cache is purged
to cause the client to read any recent changes from the server.  when a
file is unlocked, the client wants to share its changes with other clients
so it flushes all pending writes before allowing the unlocking application
to proceed.

> > i don't want to speculate too much without Trond around to keep me honest.
> > however, i think what we want here is behavior that is closer to category
> > c., with as few negative performance implications as possible.
>
> Actually, this is really, really useful and gives me lots pointers I
> can follow for more details.

i'm very happy to be able to include more brains in the dialog!

> > i think one way to accomplish this is to create two separate revalidation
> > functions -- one that can be used by synchronous code in the NFS client
> > that uses the 100% bug killer, and one that can be used from async RPC
> > tasks that simply marks that a purge is necessary, and next time through
> > the sync one, the purge actually occurs.
>
> That would certainly be easy from the VM side, then we could simply
> use a derivative of vmtruncate that leaves the file size alone, as
> Andrew suggested.

the idea is that only the NFS client would have to worry about getting
this right, and would invoke the proper VM hammer when it is safe to do
so.  that way, NFS-specific weirdness can be kept in fs/nfs/*.c, and not
ooze into the VM layer.

> > the only outstanding issue then is how to handle pages that are dirtied
> > via mmap'd files, since they are touched without going through the NFS
> > client.

[ ... various ideas snipped ... ]

> You want to know about the dirty pages only so you can send them
> to the server, correct?  Not because the client needs to purge
> anything.

i'm thinking only at the level of what behavior we want, not how to
implement it, simply because i'm not familiar enough with how it works
today.  i've researched how this behaves (more or less) on a reference
implementation of an NFS client by asking someone who worked on the
Solaris client.

the thinking is that if applications running on two separate clients have
a file mmap'd, the application designers already know well enough that
dirtying the same regions of the file on separate clients will have
nondeterministic results.  thus the only good reason that two or more
clients would mmap the same file and dirty some pages would be to modify
different regions of the file, or there is some application-level
serialization scheme in place to keep writes to the file in a
deterministic order.

thus, when a client "revalidates" an mmap'd file and discovers that the
file was changed on the server by another client, the reference
implementation says "go ahead and flush all the writes you know about,
then purge the read cache."

so the only problem is finding the dirty pages so that the client can
schedule the writes.  i think this needs to happen after a server change
is detected but before the client schedules any new I/O against the file.

today, dirty mmap'd pages are passed to the NFS client via the writepage
address space operation.  what more needs to be done here?  is there a
mechanism today to tell the VM layer to "call writepage for all dirty
mmap'd pages?"

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

