Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSFQEQY>; Mon, 17 Jun 2002 00:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSFQEQX>; Mon, 17 Jun 2002 00:16:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9064 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316684AbSFQEQW>; Mon, 17 Jun 2002 00:16:22 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
       linux-kernel@vger.kernel.org, Richard Brunner <richard.brunner@amd.com>,
       mark.langsdorf@amd.com
Subject: Re: another new version of pageattr caching conflict fix for 2.4
References: <20020614062754.A11232@wotan.suse.de>
	<20020614112849.A22888@redhat.com>
	<20020614181328.A18643@wotan.suse.de>
	<20020614173133.GH2314@inspiron.paqnet.com>
	<20020614200537.A5418@wotan.suse.de>
	<m17kkzv8lq.fsf@frodo.biederman.org>
	<20020616184801.A15227@wotan.suse.de>
	<m13cvnun7o.fsf@frodo.biederman.org>
	<20020616204305.A32022@wotan.suse.de>
	<m1y9dft2t8.fsf@frodo.biederman.org>
	<20020617013732.A14867@wotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Jun 2002 22:06:22 -0600
In-Reply-To: <20020617013732.A14867@wotan.suse.de>
Message-ID: <m1u1o2tupt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> > > MTRRs work on physical, not virtual memory, so they have no aliasing
> > > issues.
> > 
> > Doesn't the AGP aperture cause a physical alias?  Leading to strange
> 
> Yes. That's what this patch is all about.
> 
> > the same problems if the agp aperture was marked write-back, and the
> 
> AGP aperture is uncacheable, not write-back.
> 
> > memory was marked uncacheable.  My gut impression is to just make the
> > agp aperture write-back cacheable, and then we don't have to change
> > the kernel page table at all.  Unfortunately I don't expect the host
> 
> That would violate the AGP specification.
> 
> > bridge with the memory and agp controllers to like that mode,
> > especially as there are physical aliasing issues.
> 
> exactly.

All of which is an AGP design bug, if you want performance you don't
cripple your caches, but we have to live with it so no use tilting at
windmills.

> > > Fixing the MTRRs is fine, but it is really outside the scope of my patch.
> > > Just changing the kernel map wouldn't be enough to fix wrong MTRRs,
> > > because it wouldn't cover highmem. 
> > 
> > My preferred fix is to use PAT, to override the buggy mtrrs.  Which
> > brings up the same aliasing issues.  Which makes it related but
> > outside the scope of the problem.
> 
> I don't follow you here. IMHO it is much easier to fix the MTRRs in the
> MTRR driver for those rare buggy BIOS (if they exist - I've never seen one)

I've heard of several and dealt with one.  The problem was essentially they
ran out of mtrrs, the edges of free memory were to rough.

> than to hack up all of memory management just to get the right bits set.
> I see no disadvantage of using the MTRRs and it is lot simpler than
> PAT and pte bits.

There are not enough MTRRs.  And using the PAT bits to say memory is
write-back can be a constant.  It just takes a little work to get in
place.  Plus the weird assortment of consistency issues.

For most purposes PAT makes memory easier to deal with because you
can be as fine grained as you like.  The difficulty is that you must
have consistent attributes across all of your virtual mappings.  

The other case PAT should help is when a machine has multiple cards
that can benefit from write-combining.  Currently running out of mtrrs
is a problem.

Eric
