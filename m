Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbTBUC4o>; Thu, 20 Feb 2003 21:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbTBUC4n>; Thu, 20 Feb 2003 21:56:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:2997 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267072AbTBUC4m>;
	Thu, 20 Feb 2003 21:56:42 -0500
Date: Thu, 20 Feb 2003 19:08:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Performance of partial object-based rmap
Message-Id: <20030220190819.531e119d.akpm@digeo.com>
In-Reply-To: <278890000.1045791857@flay>
References: <7490000.1045715152@[10.10.2.4]>
	<278890000.1045791857@flay>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 03:06:41.0998 (UTC) FILETIME=[4225BEE0:01C2D956]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> ...
> Did some space consumption comparisons on make -j 256:
> 
> before:
> 	24116 pte_chain objects in slab cache
> after:
> 	716 pte_chain objects in slab cache
> 
> The vast majority of anonymous pages (for which we're using the non
> object based method) are singletons, and hence use pte_direct ...
> hence the massive space reduction.
> 

OK.  And that'll help the fork+exit CPU overhead too.

Let's talk about this a bit.

The problem remains that this design means that we need to walk all the vma's
which are attached to a page's address_space in an attempt to unmap that
page.

Whereas with the existing pte_chain walk, we only need to visit those pte's
which are still mapping the page.

So with 1000 processes, each holding 1000 vma's against the same file, we
need to visit 1,000,000 vma's to unmap one page.  If that unmap attempt is
unsuccessful, we *still* need to walk 1,000,000 vma's next time we try to
unmap it.

Whereas with pte-based rmap, we do not need to walk over already-unmapped
pte's.

So it is easy to see how there is at least a theoretical collapse in search
complexity here.  Which affects all platforms.  And, of course there is a
demonstrated space consumption collapse with the existing code which affects
big ia32 machines.

It is not clear how realistic the search complexity problem really is - the
2.4 virtual scan has basically the same problem and there is not a lot of
evidence of people hurting from it.  In fact we see more hurt from full rmap
than from the 1000x1000 thing.

The search complexity _may_ affect less exotic things than databases.  Many
processes mapping libc, say.  But in that case the number of VMA's is very
small - if this was a realistic problem then 2.4 would be in real strife.

Dave's patch is simple enough to merit serious consideration.

<scratches head>

I think the guiding principle here is that we should not optimise for the
uncommon case (as rmap is doing), and we should not allow the uncommon case
to be utterly terrible (as Dave's patch can do).

It would be overly optimistic to assume that hugetlb pages will save us here.

Any bright ideas?


