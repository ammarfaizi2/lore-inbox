Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264159AbUDBUfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264166AbUDBUfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:35:20 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18585
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264159AbUDBUfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:35:13 -0500
Date: Fri, 2 Apr 2004 22:35:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402203514.GR21341@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040402104334.A871@infradead.org> <20040402164634.GF21341@dualathlon.random> <20040402195927.A6659@infradead.org> <20040402192941.GP21341@dualathlon.random> <20040402205410.A7194@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402205410.A7194@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 08:54:10PM +0100, Christoph Hellwig wrote:
> On Fri, Apr 02, 2004 at 09:29:41PM +0200, Andrea Arcangeli wrote:
> > page->private indicates:
> > 
> > >>> (0xc0772380L-0xc07721ffL)/32
> > 12L
> > 
> > that's the 12th page in the array.
> > 
> > can you check in the asm (you should look at address c0048c7c) if it's
> > the first bug that triggers?
> > 
> > 	if (page[1].index != order)
> > 		bad_page(__FUNCTION__, page);
> 
> No, it's the second one (and yes, I get lots of theses backtraces, unless
> I counted wrongly 19 this time)

how can that be the second one? (I deduced it was the first one because
it cannot be the second one and the offset didn't look at the very end
of the function). This is the second one:

		if (!PageCompound(p))
			bad_page(__FUNCTION__, p);

but bad_page shows p->flags == 0x00080008 and 1<<PG_compound ==
0x80000.

So PG_compound is definitely set for "p" and it can't be the second one
triggering.

Can you double check? Maybe we should double check the asm. Something
sounds fundamentally wrong in the asm, sounds like a miscompilation,
which compiler are you using?
