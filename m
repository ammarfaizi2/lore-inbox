Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUFWXHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUFWXHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUFWXHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:07:34 -0400
Received: from holomorphy.com ([207.189.100.168]:3462 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262065AbUFWXHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:07:32 -0400
Date: Wed, 23 Jun 2004 16:07:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040623230730.GJ1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com> <20040623151659.70333c6d.akpm@osdl.org> <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623153758.40e3a865.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 03:37:58PM -0700, Andrew Morton wrote:
> What about zone->all_unreclaimable?

It's unclear which zones must be checked for this to be of use. In
general, suppose one determines all possible zones from which a given
allocation may be satisfied (this still assumes out_of_memory() is
passed a gfp_mask, and then discovers ->all_unreclaimable. It is still
not possible to determine whether nr_swap_pages is relevant.

Now suppose the check for nr_swap_pages > 0 is removed in tandem with
the passing of the gfp_mask to out_of_memory() and checking
->all_unreclaimable. This will then risk triggering OOM falsely for
unpinned pagecache allocations in the presence of high scan rates,
though it may yet be safe.

There are larger semantic questions also. For instance, the runs that
deadlocked were with non-overcommit enabled (that is, I left the sysctl
/proc/sys/vm/overcommit_memory == 0 after boot). The intention was to
provide best effort unfailability to userspace allocations by detecting
insufficient resources up-front and returning MAP_FAILED from mmap() and
so on. There is a current hole in this, which is that pinned kernel
memory allocations aren't subtracted from the pool of memory considered
to be available to userspace. This would add the additional caveat that
pure userspace memory allocations may result in OOM kills where they
didn't before, as without checking __GFP_WIRED, it's not possible to
determine whether nr_swap_pages > 0 is relevant, where it would suffice
for pure userspace allocations with non-overcommit.

__GFP_WIRED is faithful to the current timeout-based semantics and
so minimizes the risk associated with discarding the nr_swap_pages > 0
check. I'm willing to entertain deeper semantic changes such as the
above removal of nr_swap_pages > 0 in tandem with passing the gfp_mask
to out_of_memory() and checking for ->all_unreclaimable for all the
members of the gfp_mask's zonelist if you still want them given all this.

It also occurs to me that it's possible to detect overcommitment via a
combination of kernel and user allocations by means of summing the
per_cpu nr_wired counters along with vm_committed_memory, so there may
yet be methods of strengthening strict non-overcommit semantics.


-- wli
