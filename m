Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310642AbSCMODe>; Wed, 13 Mar 2002 09:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310609AbSCMODY>; Wed, 13 Mar 2002 09:03:24 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28445 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310640AbSCMODO>; Wed, 13 Mar 2002 09:03:14 -0500
Date: Wed, 13 Mar 2002 15:03:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, wli@holomorphy.com,
        wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020313150345.L17552@dualathlon.random>
In-Reply-To: <20020313115713.E1703@dualathlon.random> <Pine.LNX.4.44L.0203131050440.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203131050440.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 10:51:26AM -0300, Rik van Riel wrote:
> On Wed, 13 Mar 2002, Andrea Arcangeli wrote:
> > On Wed, Mar 13, 2002 at 08:30:55AM +0100, Andrea Arcangeli wrote:
> > >  {
> > >  	clear_bit(BH_Wait_IO, &bh->b_state);
> > >  	clear_bit(BH_Lock, &bh->b_state);
> > > +	clear_bit(BH_Launder, &bh->b_state);
> > >  	smp_mb__after_clear_bit();
> > >  	if (waitqueue_active(&bh->b_wait))
> >
> > actually, while refining the patch and integrating it, I audited it some
> > more carefully and the above was wrong,
> 
> It's complex.

The SMP kernel is complex, preempt+SMP is even more complex. If you find
a design solution more simple or/and more efficient to be able to
identify which locked buffers are just been submitted for I/O let me
know ASAP, I can't think for a better/simpler one and the locking rules
IMHO here are very simple, nothing remotely comparable to other parts of
the kernel. Infact I think it is the simplicity of this fix that renders
is so obviously right and why Andrew as well could reply to me this
morning with an agreement that that is the right fix.

It is as simple as:

	when a locked buffer is visible to the I/O layer BH_Launder is set

This means before unlocking we must clear BH_Launder, mb() on alpha and
then clear BH_Lock, so no reader can see BH_Launder set on an unlocked
buffer and then risk to deadlock.

I think it is very simple and clean. If you want to know something way
more complex than that just ask or alternatively grep for:

	grep preempt 2.5.7-pre1/kernel/sched.c 

Andrea
