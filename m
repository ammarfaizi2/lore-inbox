Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292087AbSBYScw>; Mon, 25 Feb 2002 13:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292092AbSBYScm>; Mon, 25 Feb 2002 13:32:42 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4104 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S292087AbSBYScg>; Mon, 25 Feb 2002 13:32:36 -0500
Date: Mon, 25 Feb 2002 13:32:26 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Gerd Knorr <kraxel@bytesex.org>,
        Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020225133226.B11675@redhat.com>
In-Reply-To: <20020214141028.M7940@athlon.random> <Pine.LNX.4.33.0202140824200.12749-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202140824200.12749-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Feb 14, 2002 at 08:27:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 08:27:36AM -0800, Linus Torvalds wrote:
> I'd really really hate to have the IO make pages go away from irq context
> in 2.5.x too. I think async IO should always be started and cleaned up in
> a user context - there simply isn't any reason not to (the notion of doing
> an exit() or execve() with IO still pending to now-dead-memory is rather
> horrible in itself).

I disagree: requiring aio to execute completion in user context means 
that we can no longer have quick completion directly from an interrupt 
handler to a busy server executing in userland.

That said, it is possible to do the same partial completion as is done 
with file descriptors from interrupt context for pages, but it'll be 
*really* gross.  Freeing pages should be possible from any context IMO.

> > I think the foundamental design mistake that leads to __free_pages to
> > fail from irq, is that we allow an anonymous page to reach count 0 and to be
> > still in the LRU (the count == 0 check in shrink_cache is the other side
> > of the hack too). That's the real BUG, that breaks subtly the freelist
> > semantics
> 
> Agreed. We should NEVER free the pages from the irq.

Uhm, what about the network stack?

		-ben
