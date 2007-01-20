Return-Path: <linux-kernel-owner+w=401wt.eu-S932734AbXATCEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbXATCEK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 21:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932807AbXATCEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 21:04:09 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:38375 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932734AbXATCEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 21:04:08 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xju4ny7YoL5ssNCTWOL6VMHxqghknDO1ybaSmRZA0kY2ymY3YRhcb8jeLtAqEkobidcjzjLK3GNA6QRLqZU0i7hsH7jwGMeqb946gYaI1kJoVM8tMsQBI9ZdYJWvP3Np+ZTivAkpF/qiLd9W4V7gDhCx+LC/uO/qb7jrcOxk2GA=
Message-ID: <6d6a94c50701191804m79c70afdo1e664a072f928b9e@mail.gmail.com>
Date: Sat, 20 Jan 2007 10:04:07 +0800
From: "Aubrey Li" <aubreylee@gmail.com>
To: "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robin Getz" <rgetz@blackfin.uclinux.org>,
       "Hennerich, Michael" <Michael.Hennerich@analog.com>
In-Reply-To: <45B112B6.9060806@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
	 <45B0DB45.4070004@linux.vnet.ibm.com>
	 <6d6a94c50701190805saa0c7bbgbc59d2251bed8537@mail.gmail.com>
	 <45B112B6.9060806@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/07, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
>
>
> Aubrey Li wrote:
> > On 1/19/07, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
> >>
> >> Hi Aubrey,
> >>
> >> The idea of creating separate flag for pagecache in page_alloc is
> >> interesting.  The good part is that you flag watermark low and the
> >> zone reclaimer will do the rest of the job.
> >>
> >> However when the zone reclaimer starts to reclaim pages, it will
> >> remove all cold pages and not specifically pagecache pages.  This
> >> may affect performance of applications.
> >>
> >> One possible solution to this reclaim is to use scan control fields
> >> and ask the shrink_page_list() and shrink_active_list() routines to
> >> target only pagecache pages.  Pagecache pages are not mapped and
> >> they are easy to find on the LRU list.
> >>
> >> Please review my patch at http://lkml.org/lkml/2007/01/17/96
> >>
> >
> > So you mean the existing reclaimer has the same issue, doesn't it?
>
> Well, the existing reclaimer will do the right job if the kernel
> really runs out of memory and need to recover pages for new
> allocations.  The pages to be removed will be the coldest page in
> the system.  However now with the introduction of pagecache limit,
> we are artificially creating a memory scarcity and forcing the
> reclaimer to throw away some pages while we actually have free
> usable RAM.  In this context the choice of pages picked by the
> present reclaimer may not be the best ones.
>
> If pagecache is overlimit, we expect old (cold) pagecache pages to
> be thrown out and reused for new file data.  We do not expect to
> drop a few text or data pages to make room for new pagecache.
>
Well, actually I think this probably not necessary. Because the
reclaimer has no way to predict the behavior of user mode processes,
how do you make sure the pagecache will not be access again in a short
time? So I think the present reclaimer is suitable. Limit pagecache
must affect performance of applications. The key is what do you want
to get?
In my case, I get more memory to allocate, less fragmentation, it can
solve my problem, :)

Now the problem in the idea of the patch is, when vfs cache limit is
hit, reclaimer doesn't reclaim all of the reclaimable pages, it just
give few out. So next time vfs pagecache request, it is quite possible
reclaimer is triggered again. That's the point in my mind affecting
the performance of the applications.

I'll continue to work on this issue to see if I can make a improvement.

-Aubrey
