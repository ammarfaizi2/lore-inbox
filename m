Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVD1Ipj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVD1Ipj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVD1Imm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:42:42 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:6448 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S261969AbVD1Ii4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:38:56 -0400
Date: Thu, 28 Apr 2005 01:38:08 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: David Addison <addy@quadrics.com>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
Message-ID: <20050428083808.GA23849@hexapodia.org>
References: <426E62ED.5090803@quadrics.com> <426E751A.2020507@ens-lyon.org> <426F5E33.8000906@quadrics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426F5E33.8000906@quadrics.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 10:41:07AM +0100, David Addison wrote:
> Brice Goglin wrote:
> >I worked on a similar patch to help updating a registration cache on
> >Myrinet. I came to the problem of deciding between registering ioproc
> >to the entire address space (1) or only to some VMA (2).
> >You're doing (1), I tried (2).
>
> We have always taken approach (1) as it seems to be the simplest
> method and offers the model where the whole user process space can be
> made available for RDMA operations.

I agree that this is a nice patch for exploring the design space (and
frankly, for maintaining outside the kernel tree).  I'd like to see
something like this merged.  As it stands, the patch is a decent
standalone implementation of (1).

I would personally strongly prefer that whatever is merged be low-impact
and so obviously good that it would not need to be a CONFIG_ option.
(Or rather, it should be a CONFIG_ option, but one which is forced to
yes if !CONFIG_EMBEDDED.)

And of course, it needs to be general-purpose enough to satisfy all the
significant constituencies:
1. Myrinet/Quadrics (proprietary interconnects for HPC/etc)
2. Infiniband (slightly more general-purpose interconnect standard for
               etc/HPC)
3. RDMA TCP
and I would add
4. people who want to add a commodity card to a general-purpose server
   and be able to take advantage of direct-to-userspace transfers
   without breaking the general-purposeness of their server.

I think that given a reliable framework for DMA-to-userspace, other
users will pop up.  OpenGL (DRI) is one obvious example; I think there
are others.

With those (fairly lofty) goals in mind, I think the verdict is not good
for ioproc-2.6.12-rc3.patch.

It's got some style-ish issues that would have to be worked out before
it could be merged.  (#ifdef in code, for one.)

It's adding a linked-list walk to a bunch of places in mm/, which is (or
at least, seems to me) pretty unacceptable (even if it's just one
cacheline miss) in the fast paths.

Did you understand Andi's suggestion about NUMA policies?  (I'm not
smart enough to follow it.)  Can we share code between this and the NUMA
stuff?

> static over the life of the job and hence most of the costs are taken
> as the pages are created during job startup and initialisation.

Yeah, I'm pretty skeptical about claims that "It's too much work to keep
track of all that" regarding per-proc versus per-vma, and also regarding
explicit-lock-from-commlib versus dynamic-pinning.  For the people who
care (HPC), pin/unpin events are very rare (zero during normal runtime),
so the overhead is unimportant.  It's more important to provide reliable
operation with minimal impact to standard mm semantics.

> However, I still prefer model (1) as it allows both implementations and
> appears to be much simpler in terms of the linux kernel changes required.

I agree that (1) looks easier to implement when you're doing it outside
the kernel (and tracking).  However, if you're aiming for integration
we should figure out what the right answer is.  It feels like that's
per-vma, but I freely admit I don't have any code to back that up.

> Thanks for your comments,

Thank you for stepping up to be our archery target. :)

> diff -ruN linux-2.6.12-rc3.orig/include/linux/ioproc.h linux-2.6.12-rc3.ioproc/include/linux/ioproc.h

Could you add -p to your diff invocation, please...

This patch is *exactly* what I'd want if I were looking for an obvious,
easy-to-maintain externally-maintained patch to add this capability.
(Would that I could say that for all the HPC kernel patches I've been
subjected to.)

But I think we can do better.

At least I would like to see Andi (or another NUMA mm god) and you (or
another RDMA expert) hash over the possiblity of sharing code.

-andy
