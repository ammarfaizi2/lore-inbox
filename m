Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265611AbRFWDsA>; Fri, 22 Jun 2001 23:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbRFWDru>; Fri, 22 Jun 2001 23:47:50 -0400
Received: from www.wen-online.de ([212.223.88.39]:20754 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S265611AbRFWDrc>;
	Fri, 22 Jun 2001 23:47:32 -0400
Date: Sat, 23 Jun 2001 05:46:52 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Tom Vier <tmv5@home.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac17
In-Reply-To: <20010622184040.A765@zero>
Message-ID: <Pine.LNX.4.33.0106230451560.493-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001, Tom Vier wrote:

> On Fri, Jun 22, 2001 at 09:06:42AM +0200, Mike Galbraith wrote:
> > It's not actually swapping unless you see IO (si/so).  It's allocating
> > swap space, but won't send pages out to disk unless there's demand. One
>
> if it's pre-allocation, why does it show up as "used"? "reserved" would be a
> better fit.

(Marcelo answered)

> > benefit of this early allocation is that idle pages will be identified
> > prior to demand, and will be moved out of the way sooner.  Watch as
>
> how long can swap allocation possibly take? certainly no where near as long
> as a write to disk takes. my box has a half gig of ram, pre-allocation is a
> waste of cpu. i never hit swap.

It's not that allocation takes long, it's the fact that no private pages
were previously _in_ the aging pool.  You see the pages which were added
to the active page list for aging.  Pages are aged down, and put on the
inactive_dirty list.  If demand exists, they are moved to the clean list
and eventually reclaimed. If the page is touched at any time prior to
being reclaimed, it stays is ram and is reactivated.  Those which stay
inactive are very good candidates for reclamation.

You say pre-allocation is a waste of cpu.. how much cpu can you waste
if you repeatedly eat and replentish your public cached data before you
even think of shrinking netscape?  How expensive can it be to have multiple
tasks waiting for a page to be read from disk vs one task waiting for
a private page?

So you never hit swap, so what, your swap isn't hitting disk.  If you
have enough ram that you know for a fact that your cache won't be
mangled by rss bloat, turn swap off.  If that's the case, in fact you
have too much ram :)  For those where page replacement is a probability
and for those who actually use the ram they have, aging private pages
also vs only aging public pages until _crunch_ time makes good sense.

	-Mike

