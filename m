Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbTAZFA6>; Sun, 26 Jan 2003 00:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbTAZFA6>; Sun, 26 Jan 2003 00:00:58 -0500
Received: from packet.digeo.com ([12.110.80.53]:31876 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266688AbTAZFA5>;
	Sun, 26 Jan 2003 00:00:57 -0500
Date: Sat, 25 Jan 2003 21:10:03 -0800
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: green@namesys.com, linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz,
       mason@suse.com, shemminger@osdl.org
Subject: Re: ext2 FS corruption with 2.5.59.
Message-Id: <20030125211003.082cb92c.akpm@digeo.com>
In-Reply-To: <20030126041426.GB780@holomorphy.com>
References: <20030123153832.A860@namesys.com>
	<20030124023213.63d93156.akpm@digeo.com>
	<20030124153929.A894@namesys.com>
	<20030124225320.5d387993.akpm@digeo.com>
	<20030125153607.A10590@namesys.com>
	<20030125190410.7c91e640.akpm@digeo.com>
	<20030126032815.GA780@holomorphy.com>
	<20030125194648.6c417699.akpm@digeo.com>
	<20030126041426.GB780@holomorphy.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2003 05:10:04.0868 (UTC) FILETIME=[2FDC9040:01C2C4F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >> Ticket locks need atomic fetch and increment. These don't look right.
> 
> On Sat, Jan 25, 2003 at 07:46:48PM -0800, Andrew Morton wrote:
> > Well look at the reader side:
> > loff_t i_size_read(struct inode *inode)
> > {
> > 	unsigned seq;
> > 	loff_t ret;
> > 
> > 	do {
> > 		seq = fr_write_begin(&inode->i_frlock);
> > 		ret = inode->i_size;
> > 	} while (seq != fr_write_end(&inode->i_frlock);
> > 	return ret;
> > }

argh.  That should have been:

> > 		seq = fr_read_begin(&inode->i_frlock);
> > 		ret = inode->i_size;
> > 	} while (seq != fr_read_end(&inode->i_frlock);
> > 	return ret;
> > }

of course.

> This doesn't look particularly reassuring either. We have:
> 
> 	(1) increment ->pre_sequence
> 	(2) wmb()
> 	(3) get inode->i_size
> 	(4) wmb() 
> 	(5) increment ->post_sequence
> 	(6) wmb()
> 
> Supposing the overall scheme is sound, one of the wmb()'s is unnecessary;

Could be.

> I'd have to go through some kind of state transition fiasco to be sure
> this actually recovers from the races where two readers fetch the same
> value of ->pre_sequence or ->post_sequence and store the same
> incremented value to convince myself this is right.

readers do not modify the lock - they simply observe.

The fr_write_begin/fr_write_end pair assumes that there is only a single
writer possible.  In the case of i_size, that exclusion is provided by i_sem.
 i_size is always modified under i_sem.

> I'll assume you've
> either done so yourself or are relying on someone else's verification.

More the latter ;)

> Restarting the read like this is highly unusual; if retrying the
> critical section is in fact the basis of this locking algorithm then
> it's not a true ticket lock.

Retrying the read is the basis of the locking algorithm.

The frlock stuff needs more work for non-SMP bloat avoidance, but it's simple
and seems sensible.
