Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWBVHU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWBVHU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 02:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWBVHU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 02:20:56 -0500
Received: from gold.veritas.com ([143.127.12.110]:12134 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932190AbWBVHUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 02:20:55 -0500
X-IronPort-AV: i="4.02,135,1139212800"; 
   d="scan'208"; a="55848581:sNHT31962472"
Date: Wed, 22 Feb 2006 07:21:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, ak@suse.de, holt@sgi.com, bcasavan@sgi.com, cr@sap.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: fix mount mpol nodelist parsing
In-Reply-To: <20060221183004.72ffa011.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0602220658390.6196@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602212341160.5390@goblin.wat.veritas.com>
 <20060221183004.72ffa011.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Feb 2006 07:20:55.0030 (UTC) FILETIME=[84D17960:01C63780]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > Move the mpol= parsing to shmem_parse_mpol under CONFIG_NUMA, reject
> >  all its options as invalid if not NUMA.
> 
> That's a bit irritating, really.  It means that userspace needs to be
> different for NUMA kernels (or more different, which is still bad).  Boot
> into a non-NUMA kernel and whoops, no tmpfs and quite possibly no boot.

Well spotted.

That was a choice that gave me pause between making it and sending the
patch.  But in the end I decided we might as well.  Repeating what I
wrote to Robin about it...

I did wonder for a while whether I'd been unhelpful to make mpol= fail
when not CONFIG_NUMA - tiresome for someone switching between NUMA and
non-NUMA kernels.  But this is an advanced option, not something for
everybody's /etc/fstab; and once I realized that all but the trivial
nodelist "0" would get rejected anyway if not CONFIG_NUMA, decided it
is best to placate the anti-bloaters with that CONFIG_NUMA after all.

> But last time I whined about this Albert had a list of fairly
> reasonable-sounding reasons why filesystems shouldn't silently accept
> not-understood options.
> 
> But in this case, we _do_ understand them.  We're just not going to do
> anything about them.
> 
> I just wonder if we're being as friendly as we possibly can be to admins
> and distro-makers.

I doubt the distro-makers will want to be putting "mpol=" options into
their tmpfs lines in /etc/fstab.  I hope the admins of such systems
that need it can cope.

But perhaps I should expand the mention of CONFIG_NUMA in tmpfs.txt,
to explain the issue, and suggest that "mpol=" be used in remounts
rather than automatic mounts on systems where it might be a problem.
I'll dream up some wording later.

> [ Vaguely suprised that tmpfs isn't using match_token()... ]

I did briefly consider that back in the days when I noticed a host of
fs filesystems got converted.  But didn't see any point in messing
with what was already working.  Haven't looked recently: would it
actually be a useful change to make?

Hugh
