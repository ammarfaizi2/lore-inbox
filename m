Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSIEHWJ>; Thu, 5 Sep 2002 03:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSIEHWJ>; Thu, 5 Sep 2002 03:22:09 -0400
Received: from dsl-213-023-038-092.arcor-ip.net ([213.23.38.92]:45989 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317194AbSIEHWI>;
	Thu, 5 Sep 2002 03:22:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: Race in shrink_cache
Date: Thu, 5 Sep 2002 09:28:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17mooe-00064m-00@starship> <E17mqFV-00065Y-00@starship> <3D7702BE.85A5D11D@zip.com.au>
In-Reply-To: <3D7702BE.85A5D11D@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mr4K-000660-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 09:07, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > ...
> > /*
> >  * We must not allow an anon page
> >  * with no buffers to be visible on
> >  * the LRU, so we unlock the page after
> >  * taking the lru lock
> >  */
> > 
> > That is, what's scary about an anon page without buffers?
> 
> ooop.  That's an akpm comment.  umm, err..
> 
> It solves this BUG:
> 
> http://www.cs.helsinki.fi/linux/linux-kernel/2001-37/0594.html
> 
> Around the 2.4.10 timeframe, Andrea started putting anon pages
> on the LRU.  Then he backed that out, then put it in again.  I
> think this comment dates from the time when anon pages were
> not on the LRU.  So there's a little window there where the
> page is unlocked, we've just dropped its swapdev buffers, the page is
> on the LRU and pagemap_lru_lock is not held.
> 
> So another CPU came in, found the page on the LRU, saw that it had
> no ->mapping and no ->buffers and went BUG.
> 
> The fix was to take pagemap_lru_lock before unlocking the page.
> 
> The comment is stale.

With the atomic_dec_and_lock strategy, the page would be freed immediately on 
the buffers being released, and with the lru=1 strategy it doesn't matter 
in terms of correctness whether the page ends up on the lru or not, so I was 
inclined not to worry about this anyway, still, when you a dire-looking 
comment like that...

You said something about your lru locking strategy in 2.5.33-mm2.  I have not
reverse engineered it yet, would you care to wax poetic?

-- 
Daniel
