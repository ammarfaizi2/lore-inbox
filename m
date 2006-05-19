Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWESIyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWESIyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 04:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWESIyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 04:54:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17061 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932177AbWESIyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 04:54:44 -0400
Date: Fri, 19 May 2006 18:54:11 +1000
From: David Chinner <dgc@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: David Chinner <dgc@sgi.com>, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, clameter@sgi.com
Subject: Re: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
Message-ID: <20060519085411.GU1390195@melbourne.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com> <20060517222543.600cb20a.akpm@osdl.org> <20060518054750.GN1390195@melbourne.sgi.com> <20060518174800.f13e2c86.pj@sgi.com> <20060519022144.GT1390195@melbourne.sgi.com> <20060518201207.87b6a244.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518201207.87b6a244.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 08:12:07PM -0700, Paul Jackson wrote:
> David wrote:
> > Basically, Case B falls back to case A when the cpuset is
> > full. So my question really is whether we need to attempt
> > to allocaate within the cpuset for GFP_ATOMIC because
> > most of the time the local node will be within the cpuset
> > anyway....
> > 
> > So that's what lead to me asking this - is there really a
> > noticable distinction between A and B, or is it just
> > cluttering up the code with needless complex logic?
> 
> Perhaps I'm missing something, but that's what I thought you were
> realized tVhat I thought I already recognized and responded to your
> question, with an answer sympathetic to your concerns, and a possible
> patch to address them.

Perhaps we both are :/

email:
	a communication medium where two people can agree
	with each other but be unaware of this fact.

;)

FWIW, I don't play with cpusets much; I mostly come across them when
a cpuset goes OOM and the I/O subsystem hangs somewhere in a
filesystem, block or driver layer and they are typically due to
problems with GFP_ATOMIC allocations. So my POV is probably
different to yours.

> David wrote:
> > Why not simply check this is __cpuset_zone_allowed() and return
> > true? We shouldn't put the burden of getting this right on the
> > callers when it is something internal to the cpuset workings....
> 
> The callers are already conscious of whether or not they can wait.
> For all of the callers of cpuset_zone_allowed() except __alloc_pages,
> they can very well wait, and such a check is noise.

5 of the 6 other callers use __GFP_HARDWALL so won't ever sleep.
Given that 4 of the 5 are in memory reclaim paths, that's probably
a good thing. To an outsider, this appears like __GFP_HARDWALL is
being used to ensure we don't sleep (i.e. GFP_ATOMIC semantics),
and this is one of the angles my reasoning comes from.

> In some programming contexts, I add redundancy for robustness, and
> in some contexts I minimize redundancy for lean and mean code.  The
> kernel tends to be the latter, especially on important code paths.  In

I often wish for better robustness while deep in the guts of
a crash dump from a machine that's gone OOM and hung.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
