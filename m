Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291142AbSBGNRJ>; Thu, 7 Feb 2002 08:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291143AbSBGNQ7>; Thu, 7 Feb 2002 08:16:59 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:7867 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291142AbSBGNQq>; Thu, 7 Feb 2002 08:16:46 -0500
Date: Thu, 7 Feb 2002 13:19:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au, bcrl@redhat.com,
        Hugh Dickins <hugh@lrel.veritas.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.33L.0202071043351.17850-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.21.0202071303330.1117-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Rik van Riel wrote:
> 
> The mechanism to do what I described above should of course be
> in __free_pages_ok().
> 
> if (PageLRU(page)) {
> 	if (in_interrupt()) {
> 		add_page_to_special_list(page);
> 		return;
> 	} else
> 		lru_cache_del(page);
> }

If this were a common case where many pages end up, yes, we'd
need a separate special list; but it's a very rare case, so I
think it's more appropriate to let shrink_cache do it when it
eventually reaches them on the inactive_list.

I was proposing we revert to distinguishing page_cache_release
from put_page, page_cache_release doing the lru_cache_del; and
I'd like to add my in_interrupt() BUG() there for now, just as
a sanity check.  You are proposing that we keep the current,
post-Ben, structure of doing it in __free_pages_ok if possible.

I think I prefer mine, in_interrupt() as a sanity check which
could be removed when we feel safer, to yours where it's
deciding the behaviour of __free_pages_ok.  Any strong feelings?

Hugh

