Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272851AbTHPL4W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272858AbTHPL4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:56:22 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49110
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272851AbTHPL4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:56:20 -0400
Date: Sat, 16 Aug 2003 13:56:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030816115627.GE7862@dualathlon.random>
References: <200307231521.15897.rathamahata@php4.ru> <200307251510.59062.rathamahata@php4.ru> <20030725190220.GD2659@x30.random> <200308032112.00185.rathamahata@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308032112.00185.rathamahata@php4.ru>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 09:12:00PM +0400, Sergey S. Kostyliov wrote:
> Hello Andrea,
> 
> On Friday 25 July 2003 23:02, Andrea Arcangeli wrote:
> > Hi Sergey,
> >
> > On Fri, Jul 25, 2003 at 03:10:59PM +0400, Sergey S. Kostyliov wrote:
> > > I doubt it depends on bigpages because they
> > > are not used in my setup. But I can live with that. Rule: do not run
> > > `swapoff -a` under load doesn't sound as impossible in my case (if this
> > > is the only way to trigger this problem).
> >
> > can you reproduce it with 2.4.21rc8aa1? If not, then likely it's a
> > 2.5/2.6 bug that went in 2.4 during the backport. I spoke with Hugh an
> > hour ago about this, he will soon look into this too.
> 
> Sorry for late responce. I wasn't able to reproduce neither oops nor
> lockup with 2.4.21rc8aa1.

ok good. I'm betting it's the shm backport that destabilized something.
I had no time to look further into it during vacations ;), but the first
suspect thing I mentioned to Hugh during OLS was this:

static void shmem_removepage(struct page *page)
{
	if (!PageLaunder(page))
		shmem_free_blocks(page->mapping->host, 1);
}

It's not exactly obvious how the accounting should change in function of
the Launder bit. I mean, a writepage can happen even w/o the launder
bitflag set (if it's not invoked by the vm) and I don't see how a msync
or a vm pressure writepage trigger should be different in terms of
accounting of the blocks in an inode.

Overall I need a bit more of time on Monday to digest the whole backport
to be sure of what's going on and if the above is right after all.

Andrea
