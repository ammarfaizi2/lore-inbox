Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSGDFVk>; Thu, 4 Jul 2002 01:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSGDFVj>; Thu, 4 Jul 2002 01:21:39 -0400
Received: from [24.114.147.133] ([24.114.147.133]:49030 "EHLO starship")
	by vger.kernel.org with ESMTP id <S317334AbSGDFVi>;
	Thu, 4 Jul 2002 01:21:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Craig Kulesa <ckulesa@as.arizona.edu>
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Date: Thu, 4 Jul 2002 07:19:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
       Dave Jones <davej@suse.de>, Daniel Phillips <phillips@bonn-fries.net>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rwhron@earthlink.net
References: <Pine.LNX.4.33.0206191322480.2638-100000@penguin.transmeta.com> <6660000.1024954471@flay>
In-Reply-To: <6660000.1024954471@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Pz1z-0000i1-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 June 2002 23:34, Martin J. Bligh wrote:
> ... as far as I can see, rmap triples the 
> memory requirement of PTEs through the PTE chain's doubly linked list 
> (an additional 8 bytes per entry) 

It's 8 bytes per pte_chain node all right, but it's a single linked
list, with each pte_chain node pointing at a pte and the next pte_chain
node.

> ... perhaps my calculations are wrong?

Yep.  You do not get one pte_chain node per pte, it's one per mapped
page, plus one for each additional sharer of the page.  With the
direct pointer optimization, where an unshared struct page points
directly at the pte (rumor has it Dave McCracken has done the patch)
then the pte_chain overhead goes away for all except shared pages.
Then with page table sharing, again the direct pointer optimization
is possible.  So the pte_chain overhead drops rapidly, and in any
case, is not proportional to the number of ptes.

For practical purposes, the memory overhead for rmap boils down to
one extra field in struct page, that is, it's proportional to the
number of physical pages, an overhead of less than .1%.  In heavy
sharing situations the pte_chain overhead will rise somewhat, but
this is precisely the type of load where reverse mapping is most
needed for efficient and predictable pageout processing, and page
table sharing should help here as well.

-- 
Daniel
