Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132117AbRCYQyu>; Sun, 25 Mar 2001 11:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132122AbRCYQyl>; Sun, 25 Mar 2001 11:54:41 -0500
Received: from zeus.kernel.org ([209.10.41.242]:47828 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132117AbRCYQy0>;
	Sun, 25 Mar 2001 11:54:26 -0500
Date: Sun, 25 Mar 2001 17:50:52 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ben LaHaise <bcrl@redhat.com>, Christoph Rohland <cr@sap.com>
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
Message-ID: <20010325175052.B18649@redhat.com>
In-Reply-To: <20010325001338.C11686@redhat.com> <Pine.LNX.4.21.0103242203290.1863-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103242203290.1863-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, Mar 24, 2001 at 10:05:18PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 24, 2001 at 10:05:18PM -0300, Rik van Riel wrote:
> On Sun, 25 Mar 2001, Stephen C. Tweedie wrote:
> 
> > Rik, do you think it is really necessary to take the page lock and
> > release it inside lookup_swap_cache?  I may be overlooking something,
> > but I can't see the benefit of it ---
> 
> I don't think we need to do this, except to protect us from
> using a page which isn't up-to-date yet and locked because
> of disk IO.

But it doesn't --- page_launder can try to lock the page after it
checks the refcount, without taking any locks which protect us against
running lookup_swap_cache in parallel.  If we get our reference after
page_launder checks the count, we can find the page getting locked out
from underneath our feet.

> Reclaim_page() takes the pagecache_lock before trying to
> free anything, so there's no reason to lock against that.

Exactly.  We're not in danger of _losing_ the page, because
reclaim_page is locked more aggressively than page_launder.  We still
risk having the page locked against us after lookup_swap_cache does
its own UnlockPage.

So, if lookup_swap_cache doesn't actually ensure that the page is
unlocked, are there any callers which implicitly rely on
lookup_swap_cache() doing a wait_on_page?

--Stephen
