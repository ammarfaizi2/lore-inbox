Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbVKCRvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbVKCRvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbVKCRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:51:15 -0500
Received: from dvhart.com ([64.146.134.43]:28078 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030394AbVKCRvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:51:15 -0500
Date: Thu, 03 Nov 2005 09:51:16 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mel Gorman <mel@csn.ul.ie>, Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <311050000.1131040276@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu> <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu> <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu> <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost> <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]> <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]><1131032422.2839.8.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511030747450.27915@g5.osdl.org><Pine.LNX.4.58.0511031613560.3571@skynet>
 <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org><309420000.1131036740@[10.10.2.4]> <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Linus Torvalds <torvalds@osdl.org> wrote (on Thursday, November 03, 2005 09:19:35 -0800):

> 
> 
> On Thu, 3 Nov 2005, Martin J. Bligh wrote:
>> 
>> The problem is how these zones get resized. Can we hotplug memory between 
>> them, with some sparsemem like indirection layer?
> 
> I think you should be able to add them. You can remove them. But you can't 
> resize them.
> 
> And I suspect that by default, there should be zero of them. Ie you'd have 
> to set them up the same way you now set up a hugetlb area.

So ... if there are 0 by default, and I run for a while and dirty up
memory, how do I free any pages up to put into them? Not sure how that
works.

Going back to finding contig pages for a sec ... I don't disagree with
your assertion that order 1 is doable (however, we do need to make one
fix ...see below). It's > 1 that's a problem.

For amusement, let me put in some tritely oversimplified math. For the
sake of arguement, assume the free watermarks are 8MB or so. Let's assume
a clean 64-bit system with no zone issues, etc (ie all one zone). 4K pages.
I'm going to assume random distribution of free pages, which is 
oversimplified, but I'm trying to demonstrate a general premise, not get
accurate numbers.

8MB = 2048 pages.

On a 64MB system, we have 16384 pages, 2048 free. Very rougly speaking, for
each free page, chance of it's buddy being free is 2048/16384. So in 
grossly-oversimplified stats-land, if I can remember anything at all,
chance of finding one page with a free buddy is 1-(1-2048/16384)^2048, 
which is, for all intents and purposes ... 1.

1 GB. system, 262144 pages 1-(1-2048/16384)^2048 = 0.9999989

128GB system. 33554432 pages. 0.1175 probability

yes, yes, my math sucks and I'm a simpleton. The point is that as memory
gets bigger, the odds suck for getting contiguous pages. And would also
explain why you think there's no problem, and I do ;-) And bear in mind
that's just for order 1 allocs. For bigger stuff, it REALLY sucks - I'll
spare you more wild attempts at foully-approximated math.

Hmmm. If we keep 128MB free, that totally kills off the above calculation
I think I'll just tweak it so the limit is not so hard on really big 
systems. Will send you a patch. However ... larger allocs will still 
suck ... I guess I'd better gross you out with more incorrect math after
all ...

