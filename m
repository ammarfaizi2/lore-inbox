Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUCJNth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 08:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbUCJNth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 08:49:37 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4101
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262609AbUCJNtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 08:49:33 -0500
Date: Wed, 10 Mar 2004 14:50:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040310135012.GM30940@dualathlon.random>
References: <20040310080000.GA30940@dualathlon.random> <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 08:01:15AM -0500, Rik van Riel wrote:
> On Wed, 10 Mar 2004, Andrea Arcangeli wrote:
> > On Tue, Mar 09, 2004 at 06:56:50PM +0100, Andrea Arcangeli wrote:
> > > We've lot of room for improvements.
> > 
> > Rajesh has a smart idea on how to fix the complexity issue (for both
> > truncate and vm) and it involes a new non trivial data structure.
> >
> > I trust he will make it, but if there will be any trouble with his
> > approch for safety I'm currently planning on a simpler fallback solution
> > that I can manage without having to design a new tree data structure.
> > 
> > Sharing his "tree and sorting" idea, the fallback I propose is to simply
> > index the vmas in a rbtree too.
> 
> That simply results in looking up less VMAs for low file
> indexes, but still needing to check all of them for high
> file indexes.
> 
> You really want to sort on both the start and end offset
> of the VMA, as can be done with a kd-tree or kdb-tree.

yes. But the only single reason for me to even consider using the rbtree
was to avoid having to introduce another data structure and to feel very
safe in terms of risks of memory corruption in the short term ;). The
rbtree is extremely well exercised, that's the only reason I suggested
it. Rajesh is currently working on another data strucure that is
efficient at finding a "range" (not sure if it is what you're
suggesting, he called it a prio_tree, mix between hashes and raidx
trees), that's optimal, though in practice the rbtree would work too
(peraphs one could still work an exploit ;) but the the real life apps
would be definitely covered by the rbtree too (since all vma are of the
same size and they're all naturally aligned).
