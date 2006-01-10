Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWAJGsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWAJGsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWAJGsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:48:17 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:40010 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S1750818AbWAJGsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:48:17 -0500
Date: Tue, 10 Jan 2006 07:48:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-ID: <20060110064812.GB15897@opteron.random>
References: <20051213193735.GE3092@opteron.random> <20051213130227.2efac51e.akpm@osdl.org> <20051213211441.GH3092@opteron.random> <20051216135147.GV5270@opteron.random> <20060110062425.GA15897@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110062425.GA15897@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 07:24:25AM +0100, Andrea Arcangeli wrote:
> On Fri, Dec 16, 2005 at 02:51:47PM +0100, Andrea Arcangeli wrote:
> > There was a minor buglet in the previous patch an update is here:
> > 
> > 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.15-rc5/seqschedlock-2
> 
> JFYI: I got a few hours ago positive confirmation of the fix from the
> customer that was capable of reproducing this. I guess this is good
> enough for production use (it's at the very least certainly better than
> the previous code and it's guaranteed not to hurt the scalability of the
> fast path in smp, so it's the least intrusive fix I could imagine).
> 
> So we can start to think if we should using this new primitive I
> created, and if to replace the yield() with a proper waitqueue (and
> how). Or if to take the risk of hitting a bit of scalability in the
> nopage page faults of processes, by rewriting the fix with a
> find_lock_page in the do_no_page handler, that would avoid the need of
> my new locking primitive.

Another possible way to fix this is to put the page_count check back in
the invalidate_*_* under the tree_lock (exactly like the VM does in
shrink_caches and exactly like 2.4 does too!), and to stop removing
pages from pagecache if their page_count is > 1 (we would go back to
clear PG_uptodate). But then we'd have a problem once again with the
PG_utpodate bitflag being cleared by invalidate_*_* while do_no_page is
running, and in turn a mapped page could have PG_uptodate clear 8),
that's the invariant that lead us to start zapping the ptes and dropping
pagecache, so then we could stop zapping the ptes too like 2.4 and
allowing PG_uptodate to be clear (there's nothing fundamentally wrong
with that, as long as the buffers BH_uptodate are clear too).

Side note: in 2.6 invalidate_mapping_pages has been smp racy at least since
2.6.5, it basically broke when the page_count check was replaced with a
page_mapping check long ago. But it's probably so infrequent and the
race so tiny that it never happened there, but the first bugchecks in
the sles VM (those bugchecks unfortunately removed when
mainline-merging) started to trigger only very recently when we started
zapping ptes and dropping pages from invalidate_inode_pages2 like
mainline. Bug was invisible in invalidate_mapping_pages (apparently only
jffs2 uses invalidate_mapping_pages in a way that could oops, even nfs
uses invalidate_inode_pages2).
