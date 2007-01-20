Return-Path: <linux-kernel-owner+w=401wt.eu-S932795AbXATE0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbXATE0P (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 23:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbXATE0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 23:26:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:22064 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795AbXATE0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 23:26:14 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CnIYuNC6TWC5vWfbXSZOQFko6m3hM6Bv3Urs0JUgW3I2dwddHXFpYUzOzeFnfA50/pKP5Erw0Ic/zZmVsG0NwQve42lvLkiKvYarlA3/nDNxxceWIBB0M0u2Woxy41R6STCHuStmnkD3RfozKt7vLyYCSEQ5zDrvhhsY2/CkGMk=
Message-ID: <6d6a94c50701192026q4aad8954s2d2aaa6b66ab1fd0@mail.gmail.com>
Date: Sat, 20 Jan 2007 12:26:13 +0800
From: "Aubrey Li" <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
Cc: "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robin Getz" <rgetz@blackfin.uclinux.org>,
       "Hennerich, Michael" <Michael.Hennerich@analog.com>
In-Reply-To: <45B19483.6010300@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
	 <45B0DB45.4070004@linux.vnet.ibm.com>
	 <6d6a94c50701190805saa0c7bbgbc59d2251bed8537@mail.gmail.com>
	 <45B112B6.9060806@linux.vnet.ibm.com>
	 <6d6a94c50701191804m79c70afdo1e664a072f928b9e@mail.gmail.com>
	 <45B17D6D.2030004@yahoo.com.au>
	 <6d6a94c50701191908i63fe7eebi9a97a4afb94f5df4@mail.gmail.com>
	 <45B19483.6010300@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Aubrey Li wrote:
>
> > So what's the right way to limit pagecache?
>
> Probably something a lot more complicated... if you can say there
> is a "right way".
>
> >> Secondly, your patch isn't actually very good. It unconditionally
> >> shrinks memory to below the given % mark each time a pagecache alloc
> >> occurs, regardless of how much pagecache is in the system. Effectively
> >> that seems to just reduce the amount of memory available to the system.
> >
> >
> > It doesn't reduce the amount of memory available to the system. It
> > just reduce the amount of memory available to the page cache. So that
> > page cache is limited and the reserved memory can be allocated by the
> > application.
>
> But the patch doesn't do that, as I explained.

I'm not sure you read the correct patch. Let me explain the logic again.

assume:
min = 123pages
pagecache_reserved = 200 pages

if( alloc_flags & ALLOC_PAGECACHE)
        watermark = min + pagecache_reserved ( 323 pages)
else
        watermark = min ( 123 pages)

So if request pagecache, when free pages < 323 pages, reclaim is triggered.
But at this time if request memory not pagecache, reclaim will be
triggered when free pages < 123 as the present reclaimer does.

I verified it on my side, why do you think it doesn't work properly?

>
> >> Luckily, there are actually good, robust solutions for your higher
> >> order allocation problem. Do higher order allocations at boot time,
> >> modifiy userspace applications, or set up otherwise-unused, or easily
> >> reclaimable reserve pools for higher order allocations. I don't
> >> understand why you are so resistant to all of these approaches?
> >>
> >
> > I think we have explained the reason too much. We are working on
> > no-mmu arch and provide a platform running linux to our customer. They
> > are doing very good things like mplayer, asterisk, ip camera, etc on
> > our platform, some applications was migrated from mmu arch. I think
> > that means in some cases no-mmu arch is somewhat better than mmu arch.
> > So we are taking effort to make the migration smooth or make no-mmu
> > linux stronger.
> > It's no way to let our customer modify their applications, we also
> > unwilling to do it. And we have not an existing mechanism to set up a
> > pools for the complex applications. So I'm trying to do some coding
> > hack in the kernel to satisfy these kinds of requirement.
>
> Oh, maybe you misunderstand the reserve pools idea: that is an entirely
> kernel based solution where you can preallocate a large, contiguous
> pool of memory at boot time which you can use to satisfy your nommu
> higher order anonymous memory allocations.
>
> This is something that will not get fragmented by pagecache, nor will
> it get fragmented by any other page allocation, slab allocation. Tt is
> a pretty good solution provided that you size the pool correctly for
> your application's needs.
>

So if application malloc(1M), how does kernel know to allocate
reserved pool not from buddy system? I didn't see any special code
about this. Is there any doc or example?

-Aubrey
