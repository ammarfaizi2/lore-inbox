Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTCJRMV>; Mon, 10 Mar 2003 12:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbTCJRMU>; Mon, 10 Mar 2003 12:12:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1445 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261368AbTCJRMM>;
	Mon, 10 Mar 2003 12:12:12 -0500
Subject: Re: [PATCH 2.5.64 2/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030310131611.GA14627@dualathlon.random>
References: <1047082543.2636.98.camel@ibm-c.pdx.osdl.net>
	 <20030307163001.43805e11.akpm@digeo.com>
	 <1047086790.2634.105.camel@ibm-c.pdx.osdl.net>
	 <20030308042555.GA31650@delft.aura.cs.cmu.edu>
	 <20030307203340.5e025ef0.akpm@digeo.com>
	 <20030310131611.GA14627@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1047316961.2633.124.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 10 Mar 2003 09:22:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 05:16, Andrea Arcangeli wrote:
> On Fri, Mar 07, 2003 at 08:33:40PM -0800, Andrew Morton wrote:
> > Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> > >
> > > On Fri, Mar 07, 2003 at 05:26:31PM -0800, Daniel McNeil wrote:
> > > > On Fri, 2003-03-07 at 16:30, Andrew Morton wrote:
> > > > > Daniel McNeil <daniel@osdl.org> wrote:
> > > > > > This adds i_seqcnt to inode structure and then uses i_size_read() and
> > > > > > i_size_write() to provide atomic access to i_size.
> > > > > 
> > > > > Ho hum.  Everybody absolutely hates this, but I guess we should do it :(
> > > 
> > > I am really curious whether this patch is really all that useful, has
> > > anyone ever noticed enough lock contention on inode semaphore caused by
> > > accessing i_size? Whenever i_size changes it needs to be locked down
> > > either way because mappings have to be extended or truncated.
> > 
> > The problem is not lock contention.  The problem is that the read() paths are
> > performing nonatomic reads of a 64-bit value.  If a writer is updating i_size
> > at the same time the reader can see grossly incorrect values.
> > 
> > It's such a remote problem that nobody really has the heart to do anything
> > about it.  But it's there...
> 
> well really this is fixed in my tree and in some distribution kernels
> for half an year, it's true only the major fs are been taken care of,
> but definitely somebody had the heart to do something about it 8)
> 
> > > A quick grep shows that there are 619 references to ->i_size in the
> > > various filesystem subdirs.
> > 
> > Most of these are not inode->i_size.  Yes, there are i_size references in
> > filesystems, but not many.  And the infrastructure is there to mop those up.
> > 
> > If we choose to.  I'm still not sure I want to do this :(
> 
> There is no other way, some cpu can't even do it atomically (hence the
> need of the sequence number approch).
> 
> Also note that the atomicity isn't needed everywhere, for example if you
> read i_size in the write paths you don't need to use i_size_read, but
> you can read with inode->i_size as usual, which is faster and in turn
> recommended.
> 
> I described the locking rules here:
> 
> 	http://groups.google.com/groups?q=i_size_read&hl=en&lr=&ie=UTF-8&selm=20020717225504.GA994%40dualathlon.random&rnum=2
> 
> 	  The rules are: 1) i_size_write must be used for all i_size
> 	  updates (at least when there can be potential parallel readers
> 	  outside the i_sem), 2) i_size_read must be used for all lockless
> 	  reads when an i_size change can happen from under us.
> 	  
> Andrea

I agree with Andrea and think we should fix this.  The sequence number
approach works for all architectures without much overhead.  i_size_read
does not pollute the cache.  I chose not to port the cmpxchg8/get64_bit
part of Andrea's patch from 2.4, since it is more complicated and
cmpxchg8 does write the cache line.

I did test the changes using a simple program that forks 2 processes
on a 2-proc machine. One does stat64() and the other does
truncate(4GB-1) / truncate(4G) in a large loop.  Without the patch,
the stat does rarely get an i_size of 0 or 8GB-1.  With the patch,
the stat() always sees a correct i_size. I typically had to loop
for 5 million stat()s before I would see the problem.


-- 
Daniel McNeil <daniel@osdl.org>

