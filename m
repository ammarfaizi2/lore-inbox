Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVDDDfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVDDDfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 23:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVDDDee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 23:34:34 -0400
Received: from ozlabs.org ([203.10.76.45]:29115 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261987AbVDDDeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 23:34:15 -0400
Date: Mon, 4 Apr 2005 13:25:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm5 1/3] perfctr: ppc64 arch hooks
Message-ID: <20050404032519.GB29805@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
	linuxppc64-dev@ozlabs.org, anton@samba.org,
	linux-kernel@vger.kernel.org
References: <200503312207.j2VM7YUI011924@alkaid.it.uu.se> <20050331151129.279b0618.akpm@osdl.org> <20050331234940.GA21676@localhost.localdomain> <20050331173302.3ec64e59.akpm@osdl.org> <16973.17085.561804.567539@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16973.17085.561804.567539@alkaid.it.uu.se>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 02:46:53PM +0200, Mikael Pettersson wrote:
> Andrew Morton writes:
>  > David Gibson <david@gibson.dropbear.id.au> wrote:
>  > >
>  > > On Thu, Mar 31, 2005 at 03:11:29PM -0800, Andrew Morton wrote:
>  > > > Mikael Pettersson <mikpe@csd.uu.se> wrote:
>  > > > >
>  > > > > Here's a 3-part patch kit which adds a ppc64 driver to perfctr,
>  > > > > written by David Gibson <david@gibson.dropbear.id.au>.
>  > > > 
>  > > > Well that seems like progress.  Where do we feel that we stand wrt
>  > > > preparedness for merging all this up?
>  > > 
>  > > I'm still uneasy about it.  There were sufficient changes made getting
>  > > this one ready to go that I'm not confident there aren't more
>  > > important things to be found.
>  > 
>  > That's a bit open-ended.  How do we determine whether more things will be
>  > needed?  How do we know when we're done?
> 
> I have two planned changes that will be done RSN:
> - On x86/x86-64, user-space uses the mmap()ed state's TSC start
>   value as a way to detect if a user-space sampling operation
>   (which needs to be "virtually atomic") was preempted by the kernel.
>   On ppc{32,64} we've used the TB for the same thing up to now,
>   but that doesn't quite work because the TB is about a magnitude
>   or two too slow. So the plan is to change ppc to store a
>   software generation counter in the mmap()ed state, and change
>   the ppc user-space to check that one instead.

If we're going to do it for ppc, we might as well do it for all
platforms.  That gets us one step closer to eliminating cstatus from
the user visible stuff, too, which I think should be done.

> - Move <asm-$arch/perfctr.h> common stuff to <asm-generic/perfctr.h>.
> 
> In addition, there is one unresolved issue:
> - A counter's value is represented by a 64-bit software sum,
>   a 32-bit start value containing the HW counter's value at the
>   start of the current time slice, and the current HW counter's value
>   (now). The actual value is computed as sum + (now - start).
>   This is reflected in the mmap()ed state, which contains a variable-
>   length { u32 map; u32 start; u64 sum; } pmc[] array.
>   This layout is very cache-efficient on current 32 and 64-bit CPUs,
>   but there is a _possible_ concern that it won't do on 10+ GHz CPUs.
>   So the question is, should we change it to use 64-bit start values
>   already now (and take more cache misses), or should that wait a few
>   years until it becomes a necessity (causing ABI change issues)?

Is there any way we could rearrange the user visible stuff to not
include the 'map' field?  After all userspace set up the counters, so
it ought to know what the mapping is already...

That would mean we could fit in a 64-bit start value without having to
mess around to get good alignment.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
