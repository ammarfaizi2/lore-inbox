Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUDOWdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDOWdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:33:22 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63692
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261326AbUDOWdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:33:18 -0400
Date: Fri, 16 Apr 2004 00:33:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <20040415223322.GL2150@dualathlon.random>
References: <Pine.LNX.4.44.0404151122190.6954-100000@localhost.localdomain> <41380000.1082043649@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41380000.1082043649@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 08:40:50AM -0700, Martin J. Bligh wrote:
> >> FYI, even without prio-tree, I get a 12% boost from converting i_shared_sem
> >> into a spinlock. I'll try doing the same on top of prio-tree next.
> > 
> > Good news, though not a surprise.
> > 
> > Any ideas how we might handle latency from vmtruncate (and
> > try_to_unmap) if using prio_tree with i_shared_lock spinlock?
> 
> I've been thinking about that. My rough plan is to go wild, naked and lockless.
> If we arrange things in the correct order, new entries onto the list would
> pick up the truncated image of the file (so they'd be OK). Entries removed
> from the list don't matter anyway. We just need to make sure that everything
> that was on the list when we start does get truncated.

entries removed must be freed with RCU, and that means vmas freed with
rcu that means mm and pgd freed with rcu and the whole vm will collapse
on you when you attempt that. I mean it's going all the way up to the
whole MM, not just the shared list of vmas.
