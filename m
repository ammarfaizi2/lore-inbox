Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318481AbSGSJUF>; Fri, 19 Jul 2002 05:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318483AbSGSJUF>; Fri, 19 Jul 2002 05:20:05 -0400
Received: from ns.suse.de ([213.95.15.193]:21519 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318481AbSGSJUE>;
	Fri, 19 Jul 2002 05:20:04 -0400
Date: Fri, 19 Jul 2002 11:23:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
Message-ID: <20020719112305.A15517@oldwotan.suse.de>
References: <1026949132.20314.0.camel@joe2.pdx.osdl.net> <1026951041.2412.38.camel@IBM-C> <20020718103511.GG994@dualathlon.random> <1027037361.2424.73.camel@IBM-C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027037361.2424.73.camel@IBM-C>; from daniel@osdl.org on Thu, Jul 18, 2002 at 05:09:21PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 05:09:21PM -0700, Daniel McNeil wrote:
> On Thu, 2002-07-18 at 03:35, Andrea Arcangeli wrote:
> > On Wed, Jul 17, 2002 at 05:10:41PM -0700, Daniel McNeil wrote:
> > > We coded up something very similar creating a get_64bit() using the
> > > cmpxchg8 instruction and using the set_64bit() already there.
> > > 
> > > I created a patch to have cp_new_stat64() use get_64bit() and
> > > the changes to i_size to use set_64bit().  I tested this patch
> > > on an 8 proc machine running 2.4.18.  This did fix the race
> > > with extending the i_size past 4GB when another process is
> > > reading i_size (by doing a stat()).  Here are some process
> > 
> > Actually stat can confuse userspace but it's the last of all problems,
> > the real issue is expanding truncate or lseek+write behind the end of the
> > file that can generate metadata fs corruption with a parallel writepage.
> 
> fstat() was an easy way to test for incorrect reading of i_size,
> so I could test the cmpxchg8 code to read a 64-bit value.

yes that's probably the simpler way to reproduce it.

> > 
> > > times for running parallel fstat()s to the same file on an SMP
> > > 8-proc box:
> > > 
> > > Test program doing fstat() 500,000 times to a single file.
> > > 
> > > # of processes		times
> > > 1			0.17user 0.34system 0:00.51elapsed
> > > 2			0.40user 0.85system 0:00.62elapsed
> > > 3			0.45user 2.18system 0:00.88elapsed
> > > 4			0.74user 3.54system 0:01.08elapsed
> > > 5			0.68user 5.58system 0:01.33elapsed
> > > 6			0.97user 8.57system 0:01.82elapsed
> > > 7			1.14user 12.93system 0:02.10elapsed
> > > 8			1.20user 22.52system 0:02.98elapsed
> > > 
> > > As you can see the fstat()s do not scale well.  I think this is due
> > > to the cmpxchg8 instruction actually writing to the cache line
> > > even if the compare fails.  The software developers manual says:
> > 
> > fstat or any similar operation run in parallel on the same file
> > descriptor isn't going to scale very well anyways because of the fget
> > and atomic-inc/dec cacheline trashing.
> > 
> > If instead you were using different filedescriptors then if it doesn't
> > scale well that's the cmpxchg8. And of course we expect it not to scale
> > well with the fix applied, so it's all right in all cases.
> > 
> 
> This is with different file discriptors, so the bad scaling is from the
> cmpxchg8.  The same test on 2.4.18 without the patch was:
> 
> 8 processes		1.51user 2.53system 0:00.51elapsed
> 
> > > 
> > > "The destination operand is written back if the comparison fails;
> > > otherwise the source operand is written into the destination.  (The
> > > processor never produces a locked read without also producing a locked
> > > write.)"
> > > 
> > > We were not using a lock prefix, but it appears it is doing the write
> > 
> > that's a bug as far I can see, without the lock prefix it's not atomic,
> > so it should generate the same corruption even using cmpxchg, see also
> > the fix for set_64bit that I did separately even for the pagetable
> > walking. I wrote a fat comment with pointer to the page of the pdf that
> > states without the lock it's all but atomic.
> > 
> > > anyway.  That would explain the bad scaling.
> > 
> > of course, with the fix applied every time we read the inode without the
> > i_sem we will have to make a write that will render impossible to share
> > the cacheline in read only mode across the cpus and it will generate the
> > bouncing if the same inode is accessed at the same time by multiple
> > cpus. that'e expected :)
> 
> This cacheline bouncing is the thing I don't like.  It was not clear

I don't like it either of course, but I couldn't figure out a way to read 64bit
atomically without generating it.

> If a read lock is used to read i_size, then the rw semaphore would cause
> the same cache line bouncing as the cmpxchg8.

Of course, and certainly we cannot use an extremely write-slow lock like the
brlock that isn't even schedule aware (without even counting the unfariness
it introduces for writes), because it would be too slow and RCU as well isn't
feasible, unless we make the i_size a pointer to a long long (rather than a
long long), which would break again quite a lot of code.

I was suggesting the read-write recursive lock just as a viable solution that
would make the whole thing much cleaner and simpler. But it has the downside
to change the design of the locking and to break all i_sem users. I wouldn't
worry too much about the cacheline bouncing that the read-recursive rw sem
introduces, the most important paths are read/write that are going to beat on
the global (or per-inode) pagecache lock anyways. So a per-inode rw lock
shouldn't really be too bad compared to the per-inode radix tree lock or global
pagecachelock (just like the cmpxchg8 shouldn't be too bad either for the same
reason).

> 
> > BTW, while fixing 486/386 support, I will also add another optimization
> > that is to avoid the chmpxchg not only for 64bit archs, but also for UP
> > compilations, as said that's only an SMP race that cannot triger on UP
> > (all assuming there is no -preempt, but there **cannot** be any -preempt
> > in 2.4 anyways, but while forward porting the fix to 2.5 if -preempt is
> > enabled the kernel will have to use chmpxchg for reading i_size, really
> > with -preempt and UP compilation for reading and writing the i_size the
> > cmpxchg doesn't need to put the lock on the bus while it always needs
> > the lock on the bus for SMP compiles.
> > 
> > I will upload an update after I fixed 486/386 and I optimized away the
> > cmpxchg for UP compiles.
> > 
> > If you have suggestions that's welcome, thanks.
> 
> I'll let you know if I think of any.

I guess cmpxchg8b is the best way at least for 2.4.

Andrea
