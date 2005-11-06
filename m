Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVKFP4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVKFP4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 10:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVKFP4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 10:56:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932119AbVKFP4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 10:56:15 -0500
Date: Sun, 6 Nov 2005 07:55:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: Ingo Molnar <mingo@elte.hu>, andy@thermo.lanl.gov, mbligh@mbligh.org,
       akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mel@csn.ul.ie, nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <20051105233408.3037a6fe.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0511060746170.3316@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov>
 <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051103221037.33ae0f53.pj@sgi.com>
 <20051104063820.GA19505@elte.hu> <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
 <20051104155317.GA7281@elte.hu> <20051105233408.3037a6fe.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Nov 2005, Paul Jackson wrote:
> 
> It seems to me this is making it harder than it should be.  You're
> trying to create a zone that is 100% cleanable, whereas the HPC folks
> only desire 99.8% cleanable.

Well, 99.8% is pretty borderline.

> Unlike the hot(un)plug folks, the HPC folks don't mind a few pages of
> Linus's unmoveable kmalloc memory in their way.  They rather expect
> that some modest percentage of each node will have some 'kernel stuff'
> on it that refuses to move.

The thing is, if 99.8% of memory is cleanable, the 0.2% is still enough to 
make pretty much _every_ hugepage in the system pinned down.

Besides, right now, it's not 99.8% anyway. Not even close. It's more like 
60%, and then horribly horribly ugly hacks that try to do something about 
the remaining 40% and usually fail (the hacks might get it closer to 99%, 
but they are fragile, expensive, and ugly as hell).

It used to be that HIGHMEM pages were always cleanable on x86, but even 
that isn't true any more, since now at least pipe buffers can be there 
too.

I agree that HPC people are usually a bit less up-tight about things than 
database people tend to be, and many of them won't care at all, but if you 
want hugetlb, you'll need big areas.

Side note: the exact size of hugetlb is obviously architecture-specific, 
and the size matters a lot. On x86, for example, hugetlb pages are either 
2MB or 4MB in size (and apparently 2GB may be coming). I assume that's 
where you got the 99.8% from (4kB out of 2M).

Other platforms have more flexibility, but sometimes want bigger areas 
still. 

		Linus
