Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264282AbRFGB37>; Wed, 6 Jun 2001 21:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264283AbRFGB3s>; Wed, 6 Jun 2001 21:29:48 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:15243 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S264282AbRFGB3k>; Wed, 6 Jun 2001 21:29:40 -0400
Date: Wed, 6 Jun 2001 21:29:24 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Christian Borntrdger <linux-kernel@borntraeger.net>,
        Derek Glidden <dglidden@illusionary.com>
Subject: Re: Requirement: swap = RAM x 2.5 ??
Message-ID: <20010606212923.A14060@cs.cmu.edu>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Christian Borntrdger <linux-kernel@borntraeger.net>,
	Derek Glidden <dglidden@illusionary.com>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <991815578.30689.1.camel@nomade> <20010606095431.C15199@dev.sportingbet.com> <0106061316300A.00553@starship> <200106061528.f56FSKa14465@vindaloo.ras.ucalgary.ca> <000701c0ee9f$515fd6a0$3303a8c0@einstein> <3B1E52FC.C17C921F@mandrakesoft.com> <m1snhd5u2s.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1snhd5u2s.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.18i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 12:42:03PM -0600, Eric W. Biederman wrote:
> Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> > I'm sorry but this is a regression, plain and simple.
> > 
> > Previous versons of Linux have worked great on diskless workstations
> > with NO swap.
> > 
> > Swap is "extra space to be used if we have it" and nothing else.
> 
> Given the slow speed of disks to use them efficiently when you are using
> swap some additional rules apply.
> 
> In the worse case when swapping is being used you get:
> Virtual Memory = RAM + (swap - RAM).
> 
> That cannot be improved.  You can increase your likely hood that that
> case won't come up, but that is a different matter entirely.  

I believe you are taking the right approach to the problem, which is not
to complain about that we need 2*RAM, but to try and figure out _why_ we
need 2*RAM.

As far as I can make out, any pages that at one time got swapped out,
will remain in swap. It is even there when there are no more references
to the page, but will be reclaimed lazily (i.e. when we need to swap
something new out).

I'm assuming the reason we need SWAP > RAM is because once swap is filled
only the subset of VM users that occupy this space are candidates for
further swapping. I'm assuming this probably has a significant impact on
long-running processes that have more chance of being pushed into swap
at some point.

The advantage of this is that when we need to remove a clean page that
is already in swap we can simply discard the copy in ram, paying only a
swap-in penalty. Dirty pages will have to be re-written, but we don't
need to find a place to put them, swap is already reserved. If we wanted
reclaim swap pages that were swapped into ram, we need to find a place
to swap to, swap the page out, and eventually swap it back in. Obviously
a lot more expensive.

However, we must have pushed the page into swap because it was not
'pageable'. i.e. it got dirtied, and there is no underlying file to
write it back to, shm, private mmap, or dirty heap. So there is infact a
high likelyhood that the page will not be clean when we have to swap it
out again.

Now if we would reclaim not just dead swap pages, but also pages that
have been swapped in but are dirtied, the 'additional cost' only
involves finding a place to swap to. The nice thing is that with fewer
used swap pages as a result of agressive reclaiming of swapped but in
the mean time swapped back in and dirtied pages it should become a lot
easier to find a free spot (until we are really overcommitted).

I don't know how feasable it is to tell from a given swap page, whether
there is a dirtied copy present in ram, but we could drop the swap
reference when the copy in ram is modified, turning the swap page into a
dead page and letting the regular reclamation pick it up.

Jan

