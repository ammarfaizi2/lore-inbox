Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263589AbUD2GfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUD2GfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUD2GfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:35:00 -0400
Received: from holomorphy.com ([207.189.100.168]:130 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263589AbUD2Gd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:33:28 -0400
Date: Wed, 28 Apr 2004 23:32:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Russell King <rmk@arm.linux.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 18 i_mmap_nonlinear
Message-ID: <20040429063256.GH737@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Rajesh Venkatasubramanian <vrajesh@umich.edu>,
	Russell King <rmk@arm.linux.org.uk>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org
References: <20040428234448.GB737@holomorphy.com> <Pine.LNX.4.44.0404290621470.3719-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404290621470.3719-100000@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, William Lee Irwin III wrote:
>> I believe the flush_dcache_page() implementations touching
>> ->i_mmap_shared care about this distinction.

On Thu, Apr 29, 2004 at 07:10:59AM +0100, Hugh Dickins wrote:
> That's right, arm and parisc do handle them differently: currently
> arm ignores i_mmap (and I think rmk was wondering a few months ago
> whether that's actually correct, given that MAP_SHARED mappings
> which can never become writable go in there - and that surprise is
> itself a very good reason for combining them), and parisc... ah,
> what it does in Linus' tree at present is about the same for both,
> but there are some changes on the way.
> The differences are not going to be enough to deserve two separate
> prio_tree_roots in every struct address_space, we can check vm_flags
> for any differences if necessary.

It seemed these two actually wanted a precise recovery of virtual
addresses and the like for flush_dcache_page() like they would have
had with pte_chains, but never got around to using it.


On Thu, Apr 29, 2004 at 07:10:59AM +0100, Hugh Dickins wrote:
> Something else I should have commented on, in that patch comment or
> the next: although we now have the separate i_mmap_nonlinear list,
> no attempt to search it for nonlinear pages in flush_dcache_page.
> It looks like parisc has no sys_remap_file_pages syscall anyway,
> and arm only flushes current active_mm, so should be okay so long
> as people don't mix linear and nonlinear maps of same pages (hmm,
> and don't map same page twice in a nonlinear: more likely) in same
> mm: anyway, I think any problems there have to be a "Don't do that",
> searching page tables in flush_dcache_page would be too too painful.

Maybe it's worth #ifdef'ing out core remap_file_pages() support for
those arches if all it can do is harm to them wrt. cache coherency
issues. ARM probably wouldn't mind conserving the code it otherwise
wouldn't use.


-- wli
