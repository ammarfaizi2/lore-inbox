Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUDHRwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUDHRwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:52:13 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9137
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262100AbUDHRwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:52:01 -0400
Date: Thu, 8 Apr 2004 19:51:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040408175158.GK31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain> <1081435237.1885.144.camel@mulgrave> <20040408151415.GB31667@dualathlon.random> <1081438124.2105.207.camel@mulgrave> <20040408153412.GD31667@dualathlon.random> <1081439244.2165.236.camel@mulgrave> <20040408161610.GF31667@dualathlon.random> <1081441791.2105.295.camel@mulgrave> <20040408171017.GJ31667@dualathlon.random> <1081446226.2105.402.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081446226.2105.402.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 12:43:45PM -0500, James Bottomley wrote:
> On Thu, 2004-04-08 at 12:10, Andrea Arcangeli wrote:
> > I said above per-arch abstraction, a per-arch abstraction isn't an irq
> > safe spinlock, we cannot add an irq safe spinlock there, it'd be too bad
> > for all the common archs that don't need to walk those lists (actually
> > trees in my -aa tree) from irq context.
> 
> I think we agree on the abstraction thing.  I was more wondering what
> you thought was so costly about an irq safe spinlock as opposed to an
> ordinary one?  Is there something adding to this cost I don't know
> about?  i.e. should we be thinking about something like RCU or phased
> tree approach to walking the mapping lists?

that path can take as long as timeslice to run, not taking interrupts
for a whole scheduler timeslice is pretty bad.

Note that the data structure will become a tree soon, but a prio-tree,
walking it with RCU lockless sounds very tricky to me, but it may be
doable. For the short term I doubt you want the RCU prio-tree, I guess
you want to stabilze the kernel first with the irq safe spinlock, then
you can try to hack on the prio-tree to read it in a lockless fascion.
If you can make the reading lockless we can giveup the abstraction too,
since we can make all archs walk with lockless, but warning, freeing
vmas in rcu callbacks means freeing mm in rcu callbacks, that then means
freeing pgd in rcu callbacks, the whole mm layer will collapse on you as
soon as you try to read that tree without any locking, only the inode
will be still there as far as you've a reference on the page (and as far
as you don't use nonlinear :-/ ).
