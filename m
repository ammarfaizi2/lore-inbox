Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267511AbRGMRdz>; Fri, 13 Jul 2001 13:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbRGMRdp>; Fri, 13 Jul 2001 13:33:45 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:22592 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267511AbRGMRde>; Fri, 13 Jul 2001 13:33:34 -0400
Date: Fri, 13 Jul 2001 18:33:12 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Steve Lord <lord@sgi.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Mike Black <mblack@csihq.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
Message-ID: <20010713183312.I13419@redhat.com>
In-Reply-To: <sct@redhat.com> <200107131727.f6DHRXp08659@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107131727.f6DHRXp08659@jen.americas.sgi.com>; from lord@sgi.com on Fri, Jul 13, 2001 at 12:27:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 13, 2001 at 12:27:33PM -0500, Steve Lord wrote:

> We seem to have managed to keep XFS going without the memory reservation
> scheme - and the way we do I/O on metadata right now means there is always
> a memory allocation in that path. At the moment the only thing I can kill
> the system with is make -j bzImage it eventually grinds to a halt with
> the swapper waiting for a request slot in the block layer but the system
> is in such a mess that I have not been able to diagnose it further than
> that.

That I can certainly reproduce.  Cerberus is also capable of
reproducing a stall after a few hours.  I'm usually seeing
create_buffers() as the place where the kswapd itself is deadlocked,
though.  

It does need a _really_ high load to trigger this, though.  A 200
client dbench won't do it --- there are too many IOs slowing each
process up.  However, Cerberus, which produces a high VM load in
parallel with the IO stress, seems pretty good at triggering the
problem.

It also does seem worse on highmem machines, almost certainly because
of zone imbalance problems: Marcelo has just started looking more
closely at that as a result of the fine-grained VM monitoring patch
(which showed clearly just how imbalanced the VM can get when you have
a highmem zone).

> A lot of careful use of GFP flags on memory allocation was necessary to
> get to this point, the GFP_NOIO and GFP_NOFS finally made this deadlock
> clean.

Yep, with GFP_NOFS I don't see any fs deadlocks, but I'm still seeing
the swapper blocked inside create_buffers (not within ext3 at all).
That's not good.

Cheers,
 Stephen
