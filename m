Return-Path: <linux-kernel-owner+w=401wt.eu-S932881AbXATDIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbXATDIm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 22:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbXATDIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 22:08:42 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:60666 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932881AbXATDIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 22:08:41 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JT0U2M94AY6SCq2ryFL1ehyMDQVYBW/rsvUkBFgGSnz74+EDLOJPyNf4pHVx4zW8RngDzS+jSUZToC/3Xv+8rB3ioZIu3UGxq3cdDnymNP0vg9Y6qsCP4F7Y0tI9HKQrE5j3W8PSO50EtkHdx3mjVNT9ePVwctT76v5AhvLXiuA=
Message-ID: <6d6a94c50701191908i63fe7eebi9a97a4afb94f5df4@mail.gmail.com>
Date: Sat, 20 Jan 2007 11:08:40 +0800
From: "Aubrey Li" <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
Cc: "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robin Getz" <rgetz@blackfin.uclinux.org>,
       "Hennerich, Michael" <Michael.Hennerich@analog.com>
In-Reply-To: <45B17D6D.2030004@yahoo.com.au>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Aubrey Li wrote:
> > On 1/20/07, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
>
> >> If pagecache is overlimit, we expect old (cold) pagecache pages to
> >> be thrown out and reused for new file data.  We do not expect to
> >> drop a few text or data pages to make room for new pagecache.
> >>
> > Well, actually I think this probably not necessary. Because the
> > reclaimer has no way to predict the behavior of user mode processes,
> > how do you make sure the pagecache will not be access again in a short
>
> It is not about predicting behaviour, it is about directing the reclaim
> effort at the actual resource that is under pressure.
>
> Even given a pagecache limiting patch which does the proper accounting
> to keep pagecache pages under a % limit (unlike yours), kicking off an
> undirected reclaim could (in theory) reclaim all slab and anonymous
> memory pages before bringing pagecache under the limit. So I think
> you need to be a bit more thorough than just assuming everything will
> be OK. Page reclaim behaviour is pretty strange and complex.

So what's the right way to limit pagecache?

>
> Secondly, your patch isn't actually very good. It unconditionally
> shrinks memory to below the given % mark each time a pagecache alloc
> occurs, regardless of how much pagecache is in the system. Effectively
> that seems to just reduce the amount of memory available to the system.

It doesn't reduce the amount of memory available to the system. It
just reduce the amount of memory available to the page cache. So that
page cache is limited and the reserved memory can be allocated by the
application.

>
> Luckily, there are actually good, robust solutions for your higher
> order allocation problem. Do higher order allocations at boot time,
> modifiy userspace applications, or set up otherwise-unused, or easily
> reclaimable reserve pools for higher order allocations. I don't
> understand why you are so resistant to all of these approaches?
>

I think we have explained the reason too much. We are working on
no-mmu arch and provide a platform running linux to our customer. They
are doing very good things like mplayer, asterisk, ip camera, etc on
our platform, some applications was migrated from mmu arch. I think
that means in some cases no-mmu arch is somewhat better than mmu arch.
So we are taking effort to make the migration smooth or make no-mmu
linux stronger.
It's no way to let our customer modify their applications, we also
unwilling to do it. And we have not an existing mechanism to set up a
pools for the complex applications. So I'm trying to do some coding
hack in the kernel to satisfy these kinds of requirement.

And as you see, the patch seems to solve the problems on my side. But
I'm not sure it's the right way to limit vfs cache, So I'm asking for
comments and suggestions and help, I'm not asking to clobber the
kernel.

-Aubrey
