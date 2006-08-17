Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWHQKfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWHQKfD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 06:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWHQKfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 06:35:02 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10413 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932469AbWHQKfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 06:35:01 -0400
From: Andi Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
Date: Thu, 17 Aug 2006 13:42:38 +0200
User-Agent: KMail/1.9.1
Cc: Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@muc.de>,
       mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Chinner <dgc@sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com> <44E3FC4F.2090506@colorfullife.com>
In-Reply-To: <44E3FC4F.2090506@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608171342.39308.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 07:19, Manfred Spraul wrote:
> Christoph Lameter wrote:
> >On Wed, 16 Aug 2006, Andi Kleen wrote:
> >>>2. use fls to calculate array position.
> >>
> >>I'm not sure that's a good idea. I always had my doubts that power of
> >> twos are a good size distribution. I remember the original slab paper
> >> from Bonwick also discouraged them. With fls you would hard code it.
> >
> >The original paper from Bonwick is pretty dated now. There are some
> >interesting ideas in there and we have mostly followed them. But it is an
> >academic paper after all.
>
> It's not just an academic paper, it's implemented in Solaris. Check the
> opensolaris sources.

If you watch some allocation size traces then it's not clear power of two
is really a good fit.

>
> > So not all ideas may be relevant in practice.
> >Support for non power of two sizes could lead to general slabs that do not
> >exactly fit into one page.
>
> That's a good thing.
> I'm not sure that the current approach with
> virt_to_page()/vmalloc_to_page() is the right thing(tm): Both functions
> are slow.
> If you have non-power-of-two caches, you could store the control data at
> (addr&(~PAGE_SIZE)) - the lookup would be much faster. I wrote a patch a
> few weeks ago, it's attached.

For networking it might be useful. For it the allocator is quite performance
critical and the common case for large objects is 1.5k+sizeof(skb_shared_info)
MTU sized packets. This would need a new

At some point I had a hack to hint to the slab allocator about MTU
sizes of network interfaces, but I dropped it because it didn't seem 
useful without anything else to store in a page (2K objects vs 1.5k
objects still only fit two per page)

But if you have metadata you could use it. Drawback even more
complexity because you have another special case?
-Andi
