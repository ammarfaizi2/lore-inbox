Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318319AbSHKTiL>; Sun, 11 Aug 2002 15:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318334AbSHKTiL>; Sun, 11 Aug 2002 15:38:11 -0400
Received: from dsl-213-023-020-163.arcor-ip.net ([213.23.20.163]:52384 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318319AbSHKTiK>;
	Sun, 11 Aug 2002 15:38:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Date: Sun, 11 Aug 2002 21:43:21 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208111155460.9930-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208111155460.9930-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dycT-0001hv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 August 2002 21:00, Linus Torvalds wrote:
> On Sun, 11 Aug 2002, Daniel Phillips wrote:
> 
> > On Sunday 11 August 2002 00:42, Linus Torvalds wrote:
> > > For example, what do you do when somebody has a COW-page mapped into it's
> > > VM space and you want to start paging stuff out?
> > 
> > Clearly it requires a CoW break and swapping out that page won't free any 
> > memory directly, but it will in turn allow the cache page to be dropped.
> 
> Well, that's the point. Is it really "clearly"?
> 
> One alternative is to just instead remove it from the page cache, and add 
> it to the swap cache directly (and unmapping it). In fact, I _think_ that 
> is the right thing to do (yes, it only works if the page count is 2 (one 
> for page cache, one for the VM mapping), but that's very different from 
> breaking the COW and generating two separate pages.

Far clearer ;-)

With reverse mapping it works for any page count.

> The "move directly to swap cache" is nice in that it doesn't add any new
> pages. But it's nasty in that it steals pages from the file cache, so that
> it basically turns a potentially sharable cache into a private cache that
> nobody else will see.

But you got it right the first time: we're evicting the page because it's
inactive and we want the memory for something else.  We don't need to give
that page more second chances, it already had its share of chances before
it got this far in the eviction process.  If the file page gets reloaded
before the swap-out completes it just means we chose the victim poorly
in the first place, or we're unlucky.  The latter is supposed to be the
exception, not the rule.

> See? You actually _do_ have choices on what to do.

Yes, in this case, the correct thing and the dumb thing.

-- 
Daniel
