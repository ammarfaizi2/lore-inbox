Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTJJSUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbTJJSUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:20:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41116
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262018AbTJJST5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:19:57 -0400
Date: Fri, 10 Oct 2003 20:20:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010182021.GF16013@velociraptor.random>
References: <20031010122755.GC22908@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org> <20031010152710.GA28773@ca-server1.us.oracle.com> <20031010160144.GI28795@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010160144.GI28795@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 05:01:44PM +0100, Jamie Lokier wrote:
> Joel Becker wrote:
> > 	Where I work doesn't change the need for O_DIRECT.  If your Big
> > App has it's own cache, why copy the cache in the kernel?  That just
> > wastes RAM.
> 
> Why don't you _share_ the App's cache with the kernel's?  That's what
> mmap() and remap_file_pages() are for.

I covered this some time ago in the remap_file_pages threads with Wil.

remap_file_pages requires pte modifications and tlb flushes.

O_DIRECT only walk the pagetables, no pte mangling, no tlb flushes, the
TLB is preserved fully.

thinking only 64bit in the above of course, 32bit is different but still
mmap+remap_file_pages can't beat O_DIRECT if you dedicate your machine
for the database task.

> >  If your app is sharing data, whether physical disk, logical
> > disk, or via some network filesystem or storage device, you must
> > absolutely guarantee that reads and writes hit the storage, not the
> > kernel cache which has no idea whether another node wrote an update or
> > needs a cache flush.
> 
> That's tough to guarantee at the platter level regardless of O_DIRECT,
> but otherwise: you have fdatasync() and msync().
> 
> > If Linux came up with a better, cleaner method, Oracle might change.
> 
> Take a look at remap_file_pages() and write a note here to say if it
> fits the bill.  I thought remap_file_pages() was added for Oracle, but
> perhaps it was for a more modern database ;)

no way, it has the disavantages I mentioned above, it would be a bad
idea to use remap_file_pages on any 64bit system out there.

we know remap_file_pages has a chance to improve the /dev/shm mappings
from 32bit systems, but that has nothing to do with the long run 64bit
machines, remap_file_pages is mostly a 32bit hack for ia32 with PAE.

About the in-memory databases, that's really the big iron
non-mass-market, not the other way around. only the big irons have
enough money to buy that much ram, you sure can't compare the price of
the ram with the price of disk, or at least not yet in this market AFIK.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
