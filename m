Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267323AbTA0WuS>; Mon, 27 Jan 2003 17:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267327AbTA0WuS>; Mon, 27 Jan 2003 17:50:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11937 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267323AbTA0WuQ>;
	Mon, 27 Jan 2003 17:50:16 -0500
Subject: Re: ext2 FS corruption with 2.5.59.
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, green@namesys.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hch@lst.de,
       jack@suse.cz, mason@suse.com
In-Reply-To: <20030125211003.082cb92c.akpm@digeo.com>
References: <20030123153832.A860@namesys.com>
	 <20030124023213.63d93156.akpm@digeo.com> <20030124153929.A894@namesys.com>
	 <20030124225320.5d387993.akpm@digeo.com>
	 <20030125153607.A10590@namesys.com>
	 <20030125190410.7c91e640.akpm@digeo.com>
	 <20030126032815.GA780@holomorphy.com>
	 <20030125194648.6c417699.akpm@digeo.com>
	 <20030126041426.GB780@holomorphy.com>
	 <20030125211003.082cb92c.akpm@digeo.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1043708361.10153.151.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 27 Jan 2003 14:59:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-25 at 21:10, Andrew Morton wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >
> > William Lee Irwin III <wli@holomorphy.com> wrote:
> > >> Ticket locks need atomic fetch and increment. These don't look right.
> > 

Atomic fetch/increment is not necessary since it is assumed that
only a single writer is doing the increment at a time, either with a
lock or a semaphore.  The fr_write_lock primitive incorporates the
spinlock and the sequence number. 

> > On Sat, Jan 25, 2003 at 07:46:48PM -0800, Andrew Morton wrote:
> > > Well look at the reader side:
> > > loff_t i_size_read(struct inode *inode)
> > > {
> > > 	unsigned seq;
> > > 	loff_t ret;
> > > 
> > > 	do {
> > > 		seq = fr_write_begin(&inode->i_frlock);
> > > 		ret = inode->i_size;
> > > 	} while (seq != fr_write_end(&inode->i_frlock);
> > > 	return ret;
> > > }
> 
> argh.  That should have been:
> 
> > > 		seq = fr_read_begin(&inode->i_frlock);
> > > 		ret = inode->i_size;
> > > 	} while (seq != fr_read_end(&inode->i_frlock);
> > > 	return ret;
> > > }
> 
> of course.
> 
> > This doesn't look particularly reassuring either. We have:
> > 
> > 	(1) increment ->pre_sequence
> > 	(2) wmb()
> > 	(3) get inode->i_size
> > 	(4) wmb() 
> > 	(5) increment ->post_sequence
> > 	(6) wmb()
> > 
> > Supposing the overall scheme is sound, one of the wmb()'s is unnecessary;

Each wmb() has a purpose. (2) is to make sure the first increment
happens before the update. (4) makes sure the update happens before the
second increment.  

The last wmb is unnecessary. Also on many architectures, the wmb()
disappears since writes are never reordered.

> Could be.
> 
> > I'd have to go through some kind of state transition fiasco to be sure
> > this actually recovers from the races where two readers fetch the same
> > value of ->pre_sequence or ->post_sequence and store the same
> > incremented value to convince myself this is right.
> 
> readers do not modify the lock - they simply observe.

correct

> The fr_write_begin/fr_write_end pair assumes that there is only a single
> writer possible.  In the case of i_size, that exclusion is provided by i_sem.
>  i_size is always modified under i_sem.
> 
> > I'll assume you've
> > either done so yourself or are relying on someone else's verification.
> 
> More the latter ;)
> 
> > Restarting the read like this is highly unusual; if retrying the
> > critical section is in fact the basis of this locking algorithm then
> > it's not a true ticket lock.
> 
> Retrying the read is the basis of the locking algorithm.
> 
> The frlock stuff needs more work for non-SMP bloat avoidance, but it's simple
> and seems sensible.

An updated version is coming out to day.  It still needs to have sequence numbers
and barriers even on non-SMP to deal with interrupts.


