Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSHGWQR>; Wed, 7 Aug 2002 18:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHGWQR>; Wed, 7 Aug 2002 18:16:17 -0400
Received: from dsl-213-023-022-051.arcor-ip.net ([213.23.22.51]:53420 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313628AbSHGWQQ>;
	Wed, 7 Aug 2002 18:16:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] Rmap speedup
Date: Thu, 8 Aug 2002 00:21:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <wli@holomorphy.com>
References: <Pine.LNX.4.44L.0208071753190.23404-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0208071753190.23404-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17cZBB-000503-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 August 2002 22:54, Rik van Riel wrote:
> On Wed, 7 Aug 2002, Daniel Phillips wrote:
> 
> > > It may be a net loss for high sharing levels.  Dunno.
> >
> > High sharing levels are exactly where the swap-in problem is going to
> > rear its ugly head.
> 
> If the swap-in problem exists.
> 
> I can see it being triggered artificially because we still
> unmap too many pages in the pageout path, but if we fix
> shrink_cache() to not unmap the whole inactive list when
> we're under continuous memory pressure but only the end of
> the list where we're actually reclaiming pages, maybe then
> many of the minor page faults we're seeing under such
> loads will just disappear.

Mmap a shared, anonymous region half the size of physical ram, fork a
hundred children, and let them start randomly writing in it.  Now
put the children to sleep and start another process that pushes the
children into swap.  Even when the active process goes away and the
children wake up, that is the last you'll ever see of your swap
(until the children die) because the chance that all 100 children
will happen to fault in any given page is miniscule.

Contrived?  Sure, but you can bet somebody has a real load that acts
just like this.  And *any* anonymous sharing is going to degrade the
effective size of your swap, the only variable is how much.

> Not to mention the superfluous IO being scheduled today.

Yes, well at this point we're suppose to demonstrate how much better
rmap does on that, are we not.

-- 
Daniel
