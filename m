Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbSJDRaz>; Fri, 4 Oct 2002 13:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSJDRay>; Fri, 4 Oct 2002 13:30:54 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:34704 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S262788AbSJDRav>; Fri, 4 Oct 2002 13:30:51 -0400
Date: Fri, 4 Oct 2002 13:36:24 -0400
To: David Howells <dhowells@cambridge.redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2)
Message-ID: <20021004173624.GA14499@ravel.coda.cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@cambridge.redhat.com>,
	linux-kernel@vger.kernel.org
References: <jaharkes@cs.cmu.edu> <20021004160708.GA14737@ravel.coda.cs.cmu.edu> <27504.1033750596@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27504.1033750596@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 05:56:36PM +0100, David Howells wrote:
> > For AFS you don't have to care, it's semantics without locking are that
> > the 'last writer to close it's fd' wins.
> 
> Is that a requirement for AFS? I'm looking at trying to pass writes to the
> server as soon as possible.

Last time I checked, yes. Callbacks should be sent only when the file is
closed.

> > There is a network latency that comes into play here. If you want last
> > writer wins you should not zap dirty data.
> 
> I have to zap pages that some other client has modified. The server has told
> me to invalidate it, and so I need to reread it from the server.
>
> This is probably only going to be a problem with shared-writable mappings, and
> the problem is due to AFS, not how I do my caching.

But local modification are per definition more up-to-date because you
haven't closed the file yet. It is very much a problem of how you do
your caching. I'm trying to tell you AFS has a well defined consistency
model called session semantics. That directly influenzes every decision
you make wrt. to caching and everything I've seen up until now shows me
that you're simply implementing an NFS client that happens to speak to
AFS servers.

> > Ehh, access permissions should already be checked when the file is
> > opened. NFS is dealing with the same problems here.
> 
> AFS fileservers don't have a concept of an open file. Every time you do a
> fetch or a store (be for it data or metadata) you get a short-term "lease" on
> the file that the server breaks if some other client modifies it.

Actually AFS is most definitely a stateful filesystem and as such has
the concept of an open file.

Just google for "AFS NFS stateful stateless" and you get literally
hundreds of handouts and lecture notes from distributes systems classes
that describe exactly these differences. UNIX/session semantics,
stateless/stateful, etc.

> Furthermore, every operation a client issues is checked at the RxRPC
> level. This way a client can have several users holding a file open in the
> local VFS and just label the operations sent to the server with tokens
> representing the users doing the access.
> 
> How does Coda do it? Does it get "open" the file on the server with a
> particular set of credentials for each user that wants to use it?

Yes. If the user hasn't opened the file before, we have to check the
permissions with the server. So every user that opens the same file will
generate an "open" rpc to the server.

> > >      How does Coda deal with this security problem?
> > 
> > What problem?
> 
> For instance: you have one file in your cache, several people write to it, but
> one of the people in the middle had permission taken away as far as the server
> is concerned.

First of all, typical write-write sharing is extremely low, otherwise
Coda wouldn't have even worked with it's optimistic replication and
caching. Second of all permission changes are even rarer.

So on the off chance that a write-write shared file on happens to be
affected by a permission change.

- We either succeed in writing the file when the person who lost access
  closed before the last writer who still had access. Big deal, he had
  access when he opened the file, and it is next to impossible to tell
  wheter his close arrived before or after the permission was taken away
  except when every operation is somehow given an absolute linear
  ordering in time. Generally too expensive on a distributed system
  with clients that may come and go as they please.

- Or the person who lost access is the last one to close the file and
  trigger the writeback. In this case the servers will deny the write
  operation and the client will declare a conflict on that object and
  switch to disconnected mode. Someone who has write permission can
  repair the conflict.

> Also, when writing the file back, if several people have changed it, whose
> credentials do you present to the server as having made the change?
>
> > If you don't have write permission you can't write to the file. If you do
> > have write permissions you can write. When the last writer closes it's
> > filehandle the data is sent to the server with his permissions.

Like I said in the section you quoted yourself, the last writer who
closes the file.

> > Updates dirty the pages, so they end up in swap, but we log the same update
> > in a logfile (journal), when the log fills up, the changes written directly
> > to the underlying file.
> 
> So you keep everything in triplicate whilst running? (or at least duplicate
> plus a frequently emptied journal).

Actually, for any unmodified data there is only one copy. Once it is
modified there are two (the dirty page and the logged change), why would
there be a third, I don't care about the copy in the backing file...

It has the advantage that even if you pull the powercord, we can still
recover the last consistent set of metadata and from that validate both
the data in the cache files, and revalidate everything against the
servers, which we already need for the disconnected operation.

Jan
