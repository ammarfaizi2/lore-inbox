Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSFQVN1>; Mon, 17 Jun 2002 17:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSFQVNW>; Mon, 17 Jun 2002 17:13:22 -0400
Received: from amdext2.amd.com ([163.181.251.1]:13745 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S317022AbSFQVNS>;
	Mon, 17 Jun 2002 17:13:18 -0400
From: richard.brunner@amd.com
X-Server-Uuid: 18a6aeba-11ae-11d5-983c-00508be33d6d
Message-ID: <39073472CFF4D111A5AB00805F9FE4B609BA6713@txexmta9.amd.com>
To: ebiederm@xmission.com, ak@suse.de
cc: andrea@suse.de, bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: RE: another new version of pageattr caching conflict fix for
 2.4
Date: Mon, 17 Jun 2002 16:13:11 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 11108F63495323-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to agree with Eric, that from an architectural perspective,
PAT was invented to address the coarse granularity of the MTRRs
in assigning memory cacheability types.

The power-of-2 sizes and alignments for MTRRs 
make them clumsy for page-based
or region-based assignment.

Running out of MTRRs was a real porblem before PAT. MTRRS are best used
to set the "default" for all of memory and then use PAT
to override it on a page-by-page basis as needed.

Using MTRRdef for the actual Aperture is generally ok, because
it is mapped above the top-of-DRAM.


-Rich ...
[richard.brunner@amd.com    --               ]
[Senior Member, Technical Staff, SW R&D @ AMD]

> -----Original Message-----
> From: ebiederm@xmission.com [mailto:ebiederm@xmission.com]
> Sent: Sunday, June 16, 2002 9:06 PM
> To: Andi Kleen
> Cc: Andrea Arcangeli; Benjamin LaHaise; linux-kernel@vger.kernel.org;
> Brunner, Richard; Langsdorf, Mark
> Subject: Re: another new version of pageattr caching conflict fix for
> 2.4
> 
> 
> Andi Kleen <ak@suse.de> writes:
> 
> > > > MTRRs work on physical, not virtual memory, so they 
> have no aliasing
> > > > issues.
> > > 
> > > Doesn't the AGP aperture cause a physical alias?  Leading 
> to strange
> > 
> > Yes. That's what this patch is all about.
> > 
> > > the same problems if the agp aperture was marked 
> write-back, and the
> > 
> > AGP aperture is uncacheable, not write-back.
> > 
> > > memory was marked uncacheable.  My gut impression is to 
> just make the
> > > agp aperture write-back cacheable, and then we don't have 
> to change
> > > the kernel page table at all.  Unfortunately I don't 
> expect the host
> > 
> > That would violate the AGP specification.
> > 
> > > bridge with the memory and agp controllers to like that mode,
> > > especially as there are physical aliasing issues.
> > 
> > exactly.
> 
> All of which is an AGP design bug, if you want performance you don't
> cripple your caches, but we have to live with it so no use tilting at
> windmills.
> 
> > > > Fixing the MTRRs is fine, but it is really outside the 
> scope of my patch.
> > > > Just changing the kernel map wouldn't be enough to fix 
> wrong MTRRs,
> > > > because it wouldn't cover highmem. 
> > > 
> > > My preferred fix is to use PAT, to override the buggy 
> mtrrs.  Which
> > > brings up the same aliasing issues.  Which makes it related but
> > > outside the scope of the problem.
> > 
> > I don't follow you here. IMHO it is much easier to fix the 
> MTRRs in the
> > MTRR driver for those rare buggy BIOS (if they exist - I've 
> never seen one)
> 
> I've heard of several and dealt with one.  The problem was 
> essentially they
> ran out of mtrrs, the edges of free memory were to rough.
> 
> > than to hack up all of memory management just to get the 
> right bits set.
> > I see no disadvantage of using the MTRRs and it is lot simpler than
> > PAT and pte bits.
> 
> There are not enough MTRRs.  And using the PAT bits to say memory is
> write-back can be a constant.  It just takes a little work to get in
> place.  Plus the weird assortment of consistency issues.
> 
> For most purposes PAT makes memory easier to deal with because you
> can be as fine grained as you like.  The difficulty is that you must
> have consistent attributes across all of your virtual mappings.  
> 
> The other case PAT should help is when a machine has multiple cards
> that can benefit from write-combining.  Currently running out of mtrrs
> is a problem.
> 
> Eric
> 

