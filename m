Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVBJTFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVBJTFd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVBJTFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:05:33 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:354
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261327AbVBJTFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:05:25 -0500
Date: Thu, 10 Feb 2005 20:05:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
Message-ID: <20050210190521.GN18573@opteron.random>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp> <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com> <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 04:26:26PM +0000, Hugh Dickins wrote:
> Seems it was okay after all, I got confused by an unrelated issue.
> Here's what I had in mind, what do you think?  Does it indeed help
> with your problem?  I'm copying Andrea because it was he who devised
> that fix to the get_user_pages issue, and also (I think, longer ago)
> can_share_swap_page itself.
> 
> This does rely on us moving 1 from mapcount to swapcount or back only
> while page is locked - there are places (e.g. exit) where mapcount
> comes down without page being locked, but that's not an issue: we just
> have to be sure that once we have mapcount, it can't go up while reading
> swapcount (I've probably changed more than is strictly necessary, but
> this seemed clearest to me).
> 
> I've left out how we ensure swapoff makes progress on a page with high
> mapcount, haven't quite made my mind out about that: it's less of an
> issue now there's an activate_page in unuse_pte, plus it's not an
> issue which will much bother anyone but me, can wait until after.
> 
> That PageAnon check in do_wp_page: seems worthwhile to avoid locking
> and unlocking the page if it's a file page, leaves can_share_swap_page
> simpler (a PageReserved is never PageAnon).  But the patch is against
> 2.6.11-rc3-mm1, so I appear to be breaking the intention of
> do_wp_page_mk_pte_writable ("on a shared-writable page"),
> believe that's already broken but need to study it more.

The reason pinned pages cannot be unmapped is that if they're being
unmapped while a rawio read is in progress, a cow on some shared
swapcache under I/O could happen.

If a try_to_unmap + COW over a shared swapcache happens during a rawio
read, then the rawio reads will get lost generating data corruption.

I had not much time to check the patch yet, but it's quite complex and
could you explain again how do you prevent a cow to happen while the
rawio is in flight if you don't pin the pte? The PG_locked bitflag
cannot matter at all because the rawio read won't lock the page. What
you have to prevent is the pte to be zeroed out, it must be kept
writeable during the whole I/O. I don't see how you can allow unmapping
without running into COWs later on.

This is the only thing I care to understand really, since it's the only
case that the pte pinning was fixing.

Overall I see nothing wrong in preventing memory removal while rawio is
in flight. rawio cannot be in flight forever (ptrace and core dump as
well should complete eventually). Why can't you simply drop pages from
the freelist one by one until all of them are removed from the freelist?
