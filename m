Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbTAZEF3>; Sat, 25 Jan 2003 23:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbTAZEF3>; Sat, 25 Jan 2003 23:05:29 -0500
Received: from holomorphy.com ([66.224.33.161]:28832 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266675AbTAZEF2>;
	Sat, 25 Jan 2003 23:05:28 -0500
Date: Sat, 25 Jan 2003 20:14:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: green@namesys.com, linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz,
       mason@suse.com, shemminger@osdl.org
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030126041426.GB780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, green@namesys.com,
	linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz,
	mason@suse.com, shemminger@osdl.org
References: <20030123153832.A860@namesys.com> <20030124023213.63d93156.akpm@digeo.com> <20030124153929.A894@namesys.com> <20030124225320.5d387993.akpm@digeo.com> <20030125153607.A10590@namesys.com> <20030125190410.7c91e640.akpm@digeo.com> <20030126032815.GA780@holomorphy.com> <20030125194648.6c417699.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030125194648.6c417699.akpm@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Ticket locks need atomic fetch and increment. These don't look right.

On Sat, Jan 25, 2003 at 07:46:48PM -0800, Andrew Morton wrote:
> Well look at the reader side:
> loff_t i_size_read(struct inode *inode)
> {
> 	unsigned seq;
> 	loff_t ret;
> 
> 	do {
> 		seq = fr_write_begin(&inode->i_frlock);
> 		ret = inode->i_size;
> 	} while (seq != fr_write_end(&inode->i_frlock);
> 	return ret;
> }

This doesn't look particularly reassuring either. We have:

	(1) increment ->pre_sequence
	(2) wmb()
	(3) get inode->i_size
	(4) wmb() 
	(5) increment ->post_sequence
	(6) wmb()

Supposing the overall scheme is sound, one of the wmb()'s is unnecessary;
in theory rmb() is all that's needed before (5) to catch writes.

I'd have to go through some kind of state transition fiasco to be sure
this actually recovers from the races where two readers fetch the same
value of ->pre_sequence or ->post_sequence and store the same
incremented value to convince myself this is right. I'll assume you've
either done so yourself or are relying on someone else's verification.

Restarting the read like this is highly unusual; if retrying the
critical section is in fact the basis of this locking algorithm then
it's not a true ticket lock.


On Sat, Jan 25, 2003 at 07:46:48PM -0800, Andrew Morton wrote:
> One change which is needed here is to disable preemption in fr_write_begin();
> otherwise an frlock could be in the pre!=post state for hundreds of
> milliseconds while the writer gets preempted.  Other CPUs would just spin for
> the duration.
> The same would happen if the writer takes an interrupt while pre!=post, but
> that's the same for all spinlocks...

Yes, this is a standard requirement for all non-sleeping locks. There
was only enough code in the post to "be sure" that the fetch and
increment bits were missing; I assumed that otherwise they'd be wrapped.


-- wli
