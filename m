Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUDACCB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 21:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUDACCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 21:02:01 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58573
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262063AbUDACB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 21:01:27 -0500
Date: Thu, 1 Apr 2004 04:01:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040401020126.GW2143@dualathlon.random>
References: <20040331150718.GC2143@dualathlon.random> <Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain> <20040331172851.GJ2143@dualathlon.random> <20040401004528.GU2143@dualathlon.random> <20040331172216.4df40fb3.akpm@osdl.org> <20040401012625.GV2143@dualathlon.random> <20040331175113.27fd1d0e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331175113.27fd1d0e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 05:51:13PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >  > Doing a __GFP_FS allocation while holding lock_page() is worrisome.  It's
> >  > OK if that page is private, but how do we know that the caller didn't pass
> >  > us some page which is on the LRU?
> > 
> >  it _has_ to be private if it's using rw_swap_page_sync. How can a page
> >  be in a lru if we're going to execute add_to_page_cache on it? That
> >  would be pretty broken in the first place.
> 
> An anonymous user page meets these requirements.  A did say "anal", but
> rw_swap_page_sync() is a general-purpose library function and we shouldn't
> be making assumptions about the type of page which the caller happens to be
> feeding us.

that is a specialized backdoor to do I/O on _private_ pages, it's not a
general-purpose library function for doing anonymous pages
swapin/swapout, infact the only user is swap susped and we'd better
forbid swap suspend to pass anonymous pages through that interface and
be sure that nobody will ever attempt anything like that.

that interface is useful only to reach the swap device, for doing I/O on
private pages outside the VM, in the old days that was used to
read/write the swap header (again on a private page), swap suspend is
using it for similar reasons on _private_ pages.

the idea of allowing people to do I/O on anonymous pages using that
interface sounds broken to me. Your code sounds overkill complicated
for allowing something that we definitely must forbid.
