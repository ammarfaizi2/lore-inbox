Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVKBJdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVKBJdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVKBJdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:33:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:8852 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964893AbVKBJdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:33:08 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
In-Reply-To: <436880B8.1050207@yahoo.com.au>
References: <4366C559.5090504@yahoo.com.au>
	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>
	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>
	 <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu>
	 <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu>
	 <1130858580.14475.98.camel@localhost> <20051102084946.GA3930@elte.hu>
	 <436880B8.1050207@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 10:32:49 +0100
Message-Id: <1130923969.15627.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 20:02 +1100, Nick Piggin wrote:
> I agree. Especially considering that all this memory hotplug usage for
> hypervisors etc. is a relatively new thing with few of our userbase
> actually using it. I think a simple zones solution is the right way to
> go for now.

I agree enough on concept that I think we can go implement at least a
demonstration of how easy it is to perform.

There are a couple of implementation details that will require some
changes to the current zone model, however.  Perhaps you have some
suggestions on those.

In which zone do we place hot-added RAM?  I don't think answer can
simply be the HOTPLUGGABLE zone.  If you start with sufficiently small
of a machine, you'll degrade into the same horrible HIGHMEM behavior
that a 64GB ia32 machine has today, despite your architecture.  Think of
a machine that starts out with a size of 256MB and grows to 1TB.

So, if you have to add to NORMAL/DMA on the fly, how do you handle a
case where the new NORMAL/DMA ram is physically above
HIGHMEM/HOTPLUGGABLE?  Is there any other course than to make a zone
required to be able to span other zones, and be noncontiguous?  Would
that represent too much of a change to the current model?

>From where do we perform reclaim when we run out of a particular zone?
Getting reclaim rates of the HIGHMEM and NORMAL zones balanced has been
hard, and I worry that we never got it quite.  Introducing yet another
zone makes this harder.

Should we allow allocations for NORMAL to fall back into HOTPLUGGABLE in
any case?

-- Dave

