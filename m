Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbUKJCsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbUKJCsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 21:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUKJCsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 21:48:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:18669 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262004AbUKJCmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 21:42:06 -0500
Date: Tue, 9 Nov 2004 20:41:38 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       "Adam J. Richter" <adam@yggdrasil.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <Pine.LNX.4.44.0411091824070.5130-100000@localhost.localdomain>
Message-ID: <Pine.SGI.4.58.0411092020550.101942@kzerza.americas.sgi.com>
References: <Pine.LNX.4.44.0411091824070.5130-100000@localhost.localdomain>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Argh.  I fatfingered my mail client and deleted my response rather
than send it this morning.  Sorry for the delay.

On Tue, 9 Nov 2004, Hugh Dickins wrote:

> Doesn't quite play right with what was my "NULL sbinfo" convention.

Howso?  I thought it played quite nicely with it.  We've been using
NULL sbinfo as an indicator that an inode is from tmpfs rather than
from SysV or /dev/zero.  Or at least that's the way my brain was
wrapped around it.

> Given this mpol patch of yours, and Adam's devfs patch, it's becoming
> clear that my "NULL sbinfo" was unhelpful, making life harder for both
> of you to add things into the tmpfs superblock - unchanged since 2.4.0,
> as soon as I mess with it, people come up with valid new uses for it.

I haven't seen that other patch, but in this case I didn't see a problem.
The NULL sbinfo scheme worked perfectly for me, with very little hassle.

> Not to say that your patch or Adam's will go further (I've no objection
> to the way Adam is using tmpfs, but no opinion on the future of devfs),
> but they're two hints that I should rework that to get out of people's
> way.  I'll do a patch for that, then another something like yours on
> top, for you to go back and check.

Is this something imminent, or on the "someday" queue?  Just asking
because I'd like to avoid doing additional work that might get thrown
away soon.

> I think the option should be "mpol=interleave" rather than just
> "interleave", who knows what baroque mpols we might want to support
> there in future?

Makes sense to me.  I'll be happy to do it, pending your answer to
my preceding question.

> I'm irritated to realize that we can't change the default for SysV
> shared memory or /dev/zero this way, because that mount is internal.

Well, the only thing preventing this is that I stuck the flag into
sbinfo, since it's an filesystem-wide setting.  I don't see any reason
we couldn't add a new flag in the inode info flag field instead.  I
think there would also be some work to set pvma.vm_end more precisely
(in mpol_shared_policy_init()) in the SysV case.

> At one time (August) you were worried about MPOL_INTERLEAVE
> overloading node 0 on small files - is that still a worry?
> Perhaps you skirt that issue in recommending this option
> for use with giant files.

Yeah, there's still a bit of concern about that, but it's dwarfed
in comparison.  Taking care of that would be relatively easy,
adding something like the inode number (or other inode-constant
"randomness") in as a offset to pvma.vm_pgoff in shmem_alloc_page()
(or maybe a bit higher up the call-chain, I'd have to look closer).

> There are quite a lot of mpol patches flying around, aren't there?

Yep.  SGI solved some of these problems for our own 2.4.x kernel
distributions, but now we want to get things settled out in the
mainline kernel.  So far I think we're hitting distinct chunks
of code.

> >From Ray Bryant and from Steve Longerbeam.  Would this tmpfs patch
> make (adaptable) sense if we went either or both of those ways - or
> have they been knocked on the head?  I don't mean in the details
> (I think one of them does away with the pseudo-vma stuff - great!),
> but in basic design - would your mount option mesh together well
> with them, or would it be adding a further layer of confusion?

I see what you mean.  I believe Ray's work is addressing the buffer
cache in general.  I'll try to touch base with him again soon (I
admit to losing track of what he's been doing).

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
