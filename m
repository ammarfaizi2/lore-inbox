Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTJLPbf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 11:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263476AbTJLPbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 11:31:35 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:46060 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263475AbTJLPbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 11:31:33 -0400
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
References: <20031010122755.GC22908@ca-server1.us.oracle.com>
	<Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org>
	<20031010152710.GA28773@ca-server1.us.oracle.com>
	<20031010160144.GI28795@mail.shareable.org>
	<20031010163300.GC28773@ca-server1.us.oracle.com>
In-Reply-To: <20031010163300.GC28773@ca-server1.us.oracle.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 12 Oct 2003 11:31:31 -0400
Message-ID: <87ekxi4gmk.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> writes:

> On Fri, Oct 10, 2003 at 05:01:44PM +0100, Jamie Lokier wrote:
> > Why don't you _share_ the App's cache with the kernel's?  That's what
> > mmap() and remap_file_pages() are for.
> 
> 	Because you can't force flush/read.  You can't say "I need you
> to go to disk for this."  If you do, you're doing O_DIRECT through mmap
> (yes, I've pondered it) and you end up with perhaps the same races folks
> worry about.  Doesn't mean it can't be done.

There are other reasons databases want to control their own cache. The
application knows more about the usage and the future usage of the data than
the kernel does.

There's currently a thread on the Postgres mailing list about a problem with
an administrative job that needs to touch potentially all the blocks of a table.
The more frequently it's run the less work it has to do, so the recommendation
is to run it very frequently.

However on busy servers whenever it's run it causes lots of pain because the
kernel flushes all the cached data in favour of the data this job touches. And
worse, there's no way to indicate that the i/o it's doing is lower priority,
so i/o bound servers get hit dramatically. 

Postgres knows the fact that this job touched the data means nothing for the
regular functioning of the server, and it knows that the i/o it's doing is low
priority. It needs some way to indicate to the kernel that this job is low
priority not only for cpu resources but for cache resources and i/o resources
as well.

There are other cases. Oracle, for example, puts blocks it reads due to full
table scans at the end of its LRU list to avoid a similar effect on the cache.

Then there's the transaction log. The database needs to know when the
transaction log is written to disk. The blocks it writes there won't be useful
to cache unless the database crashed right there. And ideally it should bypass
any disk i/o reordering and write the data to the transaction log *first*. Raw
bandwidth is not as important as latency on writes to the transaction log.

The reason mmap is tempting is not because it's faster. It's because it
provides a nice clean abstract interface. The database could simply mmap the
entire database and then pretend it is an in-memory database. The code would
be much simpler and more complex algorithms would be easier to implement.

Unfortunately there are some problems with mmap. Currently it would be just as
complex to use as read/write because the address space is limited to only a
fraction of the database. On a 64 bit machine you might be able to mmap the
entire database and then use custom syscalls to indicate to the kernel which
pages to keep in cache and which to sync.

-- 
greg

