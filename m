Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280356AbRJaRnc>; Wed, 31 Oct 2001 12:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280355AbRJaRnX>; Wed, 31 Oct 2001 12:43:23 -0500
Received: from ns.ithnet.com ([217.64.64.10]:32518 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S280350AbRJaRnE>;
	Wed, 31 Oct 2001 12:43:04 -0500
Date: Wed, 31 Oct 2001 18:42:56 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: torvalds@transmeta.com, lenstra@tiscalinet.it,
        linux-kernel@vger.kernel.org
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
Message-Id: <20011031184256.6e541e43.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33L.0110311403440.2963-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33.0110310744070.32330-100000@penguin.transmeta.com>
	<Pine.LNX.4.33L.0110311403440.2963-100000@imladris.surriel.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001 14:04:45 -0200 (BRST) Rik van Riel <riel@conectiva.com.br>
wrote:

> On Wed, 31 Oct 2001, Linus Torvalds wrote:
> 
> > I could probably argue that the machine really _is_ out of memory at this
> > point: no swap, and it obviously has to work very hard to free any pages.
> > Read the "out_of_memory()" code (which is _really_ simple), with the
> > realization that it only gets called when "try_to_free_pages()" fails and
> > I think you'll agree.
> 
> Absolutely agreed, an earlier out_of_memory() is probably a good
> thing for most systems.   The only "but" is that Lorenzo's test
> program runs fine with other kernels, but you could argue that
> it's a corner case anyway...

I took a deep look into this code and wonder how this benchmark manages to get
killed. If I read that right this would imply that shrink_cache has run a
hundred times through the _complete_ inactive_list finding no free-able pages,
with one exception that I read across:

        int max_mapped = nr_pages*10;
...
page_mapped:
                        if (--max_mapped >= 0)
                                continue;

                        /*
                         * Alert! We've found too many mapped pages on the
                         * inactive list, so we start swapping out now!
                         */
                        spin_unlock(&pagemap_lru_lock);
                        swap_out(priority, gfp_mask, classzone);
                        return nr_pages;

Is it possible, that this does a too early exit from shrink_cache?
I don't know how much mem Lorenzo has, but running only once through several
hundred MB of inactive list is a notable time in my system, running a hundred
times through could be far more than 70 s. But if there's no complete run, you
cannot state to really be oom.
Does it make sense to stop shrink_cache when having detected 4k * 32 * 10 =
1280 k of mapped mem on the inactive list of possibly several hundred MB in
size?

Regards,
Stephan

