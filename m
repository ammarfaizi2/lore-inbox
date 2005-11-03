Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbVKCSoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbVKCSoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbVKCSoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:44:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62087 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030423AbVKCSon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:44:43 -0500
Date: Thu, 3 Nov 2005 10:44:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Arjan van de Ven <arjan@infradead.org>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <312300000.1131041824@[10.10.2.4]>
Message-ID: <Pine.LNX.4.64.0511031029090.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>
 <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu>
 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
 <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]>
 <1131032422.2839.8.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
 <Pine.LNX.4.58.0511031613560.3571@skynet>  <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
 <309420000.1131036740@[10.10.2.4]>  <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
 <311050000.1131040276@[10.10.2.4]> <1131040786.2839.18.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org> <312300000.1131041824@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Nov 2005, Martin J. Bligh wrote:
> > 
> > These days we have things like per-cpu lists in front of the buddy 
> > allocator that will make fragmentation somewhat higher, but it's still 
> > absolutely true that the page allocation layout is _not_ random.
> 
> OK, well I'll quit torturing you with incorrect math if you'll concede
> that the situation gets much much worse as memory sizes get larger ;-)

I don't remember the specifics (I did the stats several years ago), but if 
I recall correctly, the low-order allocations actually got _better_ with 
more memory, assuming you kept a fixed percentage of memory free. So you 
actually needed _less_ memory free (in percentages) to get low-order 
allocations reliably.

But the higher orders didn't much matter. Basically, it gets exponentially 
more difficult to keep higher-order allocations, and it doesn't help one 
whit if there's a linear improvement from having more memory available or 
something like that.

So it doesn't get _harder_ with lots of memory, but

 - you need to keep the "minimum free" watermarks growing at the same rate 
   the memory sizes grow (and on x86, I don't think we do: at least at 
   some point, the HIGHMEM zone had a much lower low-water-mark because it 
   made the balancing behaviour much nicer. But I didn't check that).

 - with lots of memory, you tend to want to get higher-order pages, and 
   that gets harder much much faster than your memory size grows. So 
   _effectively_, the kinds of allocations you care about are much harder 
   to get.

If you look at get_free_pages(), you will note that we actyally 
_guarantee_ memory allocations up to order-3:

	...
        if (!(gfp_mask & __GFP_NORETRY)) {
                if ((order <= 3) || (gfp_mask & __GFP_REPEAT))
                        do_retry = 1;
	...

and nobody has ever even noticed. In other words, low-order allocations 
really _are_ dependable. It's just that the kinds of orders you want for 
memory hotplug or hugetlb (ie not orders <=3, but >=10) are not, and never 
will be.

(Btw, my statistics did depend on that fact that the _usage_ was an even 
higher exponential, ie you had many many more order-0 allocations than you 
had order-1). You can always run out of order-n (n != 0) pages if you just 
allocate enough of them. The buddy thing works well statistically, but it 
obviously can't do wonders).

			Linus
