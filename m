Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274198AbSITBSp>; Thu, 19 Sep 2002 21:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274596AbSITBSp>; Thu, 19 Sep 2002 21:18:45 -0400
Received: from ns.suse.de ([213.95.15.193]:58123 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S274198AbSITBSo>;
	Thu, 19 Sep 2002 21:18:44 -0400
Date: Fri, 20 Sep 2002 03:23:46 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@suse.de>, Hirokazu Takahashi <taka@valinux.co.jp>,
       alan@lxorguk.ukuu.org.uk, davem@redhat.com, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Message-ID: <20020920032346.A22949@wotan.suse.de>
References: <3D89176B.40FFD09B@digeo.com.suse.lists.linux.kernel> <20020919.221513.28808421.taka@valinux.co.jp.suse.lists.linux.kernel> <3D8A36A5.846D806@digeo.com.suse.lists.linux.kernel> <p73lm5xtqyv.fsf@oldwotan.suse.de> <3D8A754E.5BA2E28D@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8A754E.5BA2E28D@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 06:09:34PM -0700, Andrew Morton wrote:
> > Very interesting IMHO would be to find a heuristic to switch between
> > a write combining copy and a cache hot copy. Write combining is good
> > for blasting huge amounts of data quickly without killing your caches.
> > Cache hot is good for everything else.
> 
> I expect that caching userspace and not pagecache would be
> a reasonable choice.

Normally yes, but not always. e.g. for squid you don't really want to 
cache user space.

But I guess it would be a reasonable heuristic. Or at least worth a try :-)

> 
> > But it'll need hints from the higher level code. e.g. read and write
> > could turn on write combining for bigger writes (let's say >8K)
> > I discovered that just unconditionally turning it on for all copies
> > is not good because it forces data out of cache. But I still have hope
> > that it helps for selected copies.
> 
> Well if it's a really big read then bypassing the CPU cache on
> the userspace-side buffer would make sense.
> 
> Can you control the cachability of the memory reads as well?

SSE2 has hints for that (prefetchnti and even prefetcht0,1 etc. for different
cache hierarchies), but it's not completely clear on how much
the CPUs follow these. 

For writing it's much more obvious and usually documented even.

> 
> What restrictions are there on these instructions?  Would
> they force us to bear the cost of the aligment problem?

They should be aligned, otherwise it makes no sense. When you assume it's
more likely that one target or destination are unaligned then you can easily
align either target or destination. Trick is to chose the right one,
it varies on the call site.
(these are for big copies so a small alignment function is lost in the noise)

x86-64 copy_*_user currently aligns the destination, but hardcoding that
is a bit dumb and I'm not completely happy with it.


-Andi
