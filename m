Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284460AbRLTLoR>; Thu, 20 Dec 2001 06:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284369AbRLTLoH>; Thu, 20 Dec 2001 06:44:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23321 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284251AbRLTLnz>; Thu, 20 Dec 2001 06:43:55 -0500
Date: Thu, 20 Dec 2001 12:27:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
Message-ID: <20011220122735.V1395@athlon.random>
In-Reply-To: <87bsgwi6zz.fsf@fadata.bg> <Pine.LNX.4.21.0112181757460.4821-100000@freak.distro.conectiva> <3C1FC254.525B9108@zip.com.au> <3C1FCB96.83E49ECB@zip.com.au> <3C204C4F.C989AD71@zip.com.au>, <3C204C4F.C989AD71@zip.com.au>; <20011219144213.A1395@athlon.random> <3C21963B.AD97D4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C21963B.AD97D4@zip.com.au>; from akpm@zip.com.au on Wed, Dec 19, 2001 at 11:41:47PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 11:41:47PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > > The thing I don't like about the Andrea+Momchil approach is that it
> > > exposes the risk of flooding the machine with dirty data.  A scheme
> > 
> > it doesn't, balance_dirty() has to work only  at the highlevel.
> > sync_page_buffers also is no problem, we'll try again later in those
> > GFP_NOIO allocations.
> 
> Not so.  The loop thread *copies* the data.  We must throttle it,
> otherwise the loop thread gobbles all memory and the box dies.  This
> is trivial to demonstrate.

loop thread can generate how many dirty bh it wants, as said it's the
higher layer that takes care of the write throttling, we don't need to
stop into the loop thread. While the loop thread writes the higher layer
will throttle. It's as simple as that.

Also the write throttling isn't about correctness. Once there are too
many dirty bh the VM will take care of flushing them. So whatever you
claim about balance_dirty() is the last of my worries, I just had
reports that the loop write performance are greatly improved with my
recent -aa async flushing changes.

> > furthmore you don't even address the writepage from loop thread on the
> > loop queue.
> 
> How can this deadlock?  The only path to those buffers is
> via the page, and the page is locked.

loop -> writepage -> get_block -> ll_rw_block -> read metadata and queue
the reads into the loop queue -> wait_on_buffer -> deadlock

In general the loop thread must never do ll_rw_block into unknown
buffers.

> > The final fix should be in rc2aa1 that I will release in a jiffy. It
> > takes care now of both the VM and balance_dirty().
> >
> > this is the incremental fix against rc1aa1:
> > 
> 
> No.  Your patch removes *all* loop thread throttling, it doesn't even start
> IO (thus removing the throttling which request starving would provide)
> and doesn't even wake up bdflush.
> 
> If you set nfract to 70%, nfract_sync to 80% and do a big write, the
> machine falls into a VM coma within 15 seconds.  The same happens
> with both my patches :-(
> 
> And it's not legitimate to say "don't do that".  If we can't survive
> those settings, we don't have a solution. We need to throttle writes
> *more*, not less.

we throttle, always, at every write submitted by the user. check
mark_buffer_dirty, and the pagecache write-side operations that calls
balance_dirty explicitly (blkdev on pagecache included of course). that
works fine in practice. The next balance_dirty() will throttle what the
loop written.

> 
> I'll keep poking at it.   If you have any more suggestions/patches,
> please toss them over...

I don't think other changes are needed, and it works fine in my systems
and all my 100mbyte email folders are on top of cryptoloop, so if I'm
writing this it means it works fine, I tried a cp /dev/zero into the
cryptoloop and it seems fine as well.

The other deadlock report I had may be yet another problem, I believe
the loop is just fine both in terms of balance_dirty() and VM.

If you really want to balance_dirty() at every loop write we can by
simply tracking which bh are on top of the loop thread, but I don't
think it's necessary. So it could be a combination of PF_NOIO and a BH_
bitflag that will trigger the balance_dirty(), same finegrined level
could be used by the vm as well, but again, I don't think it's needed,
the per-process PF_NOIO that avoids all the balance_dirty() and forbids
the loop thread to use I/O methods to release memory should be just
enough to have a stable system performing well.

Andrea
