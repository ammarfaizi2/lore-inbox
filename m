Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbVHPK2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVHPK2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVHPK2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:28:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965196AbVHPK2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:28:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200508161153.59476.phillips@arcor.de> 
References: <200508161153.59476.phillips@arcor.de>  <200508130534.54155.phillips@arcor.de> <3521.1123757360@warthog.cambridge.redhat.com> <8985.1124111717@warthog.cambridge.redhat.com> 
To: Daniel Phillips <phillips@arcor.de>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, hugh@veritas.com
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Tue, 16 Aug 2005 11:28:08 +0100
Message-ID: <16339.1124188088@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Phillips <phillips@arcor.de> wrote:

> > I want to know when a page is going to be modified so that I
> > can predict the state of the cache as much as possible. I don't want
> > userspace processes corrupting the cache in unrecorded ways.
> 
> There are two cases:
> 
>   1) Metadata.  If anybody is doing racy writes to metadata pages, it is
>      your filesystem, and you have a bug.

I didn't say that I had a problem with metadata. I don't (or shouldn't). I
have done my best to implement filesystem integrity on CacheFS. CacheFiles is
harder to do this for because I have to work through another filesystem to
maintain consistency.

>   2) Data.  In Linux practice and Posix, racy writes to files have
>      undefined semantics, including the possibility that data may end up
>      interleaved on a disk block.

There are more cases than you are considering. This point can be split into
writing into the cache from a read from the netfs and writing into the cache
from a write to the netfs.

Don't forget that the cache isn't the data backing store (eg: NFS).

> You seem to be trying to define (2) as "corruption" and setting out to
> prevent it.  But it is not the responsibility of a filesystem to prevent
> this, it is the responsibility of the application.
> 
> Could you please explain why it is not ok to end up with a half-written page 
> in your cache, if the client was in fact halfway through writing it when it 
> crashed?

Because then the cache may hold something other than what the server displays,
and once the client computer is back on its feet after a crash it will then
read bad data from the cache.

Of course, the netfs can make the effort to write the half-written data back
to the server upon recovery, _if_ it can work out which that is, and _if_ the
server's idea of the current state hasn't advanced whilst the client was out
of commission (see AFS).

Basically, you've got four choices:

 (1) Prevention.

 (2) Cache invalidation.

 (3) Cache flush.

 (4) Pretend nothing happened.

I really hate the idea of (4) - we can end up with the cache and the server
having two totally different ideas on what the data ought to be because we
couldn't be bothered to fix it up. (3) is tricky as we have to work out what
is different. (2) is easiest - it _is_ a cache after all - but we don't want
to invalidate the _entire_ cache. (1) is relatively cheap in CacheFS.

With FS-Cache as I have implemented it, this is a choice made entirely by the
netfs. All FS-Cache/CacheFS does is wait to be given a page to write and then
tell you when it's written it, and allow you to arbitrarily mark inodes in
their auxilliary data. But that's it. Full stop. The netfs interface is
extremely simple - about as simple as I can make it (it has been revised
recently with this in mind).

Also, it could copy the data before writing, but that has two problems:

 (1) You have to have a page to copy the data into.

 (2) You have to copy the page.


Maintaining cache coherency really isn't fun. You've got a server with a bunch
of totally separate clients that may or may not know about one another and
each of these has a page cache and a local disk cache and a dcache.

David
