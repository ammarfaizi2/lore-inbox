Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289159AbSBGNwL>; Thu, 7 Feb 2002 08:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSBGNwB>; Thu, 7 Feb 2002 08:52:01 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:23947 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289159AbSBGNvo>;
	Thu, 7 Feb 2002 08:51:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] __free_pages_ok oops
Date: Thu, 7 Feb 2002 14:55:37 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "David S. Miller" <davem@redhat.com>, <akpm@zip.com.au>, <bcrl@redhat.com>,
        Hugh Dickins <hugh@lrel.veritas.com>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Yp1W-0000al-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 02:27 pm, Rik van Riel wrote:
> On Thu, 7 Feb 2002, Hugh Dickins wrote:
> 
> > > if (PageLRU(page)) {
> > > 	if (in_interrupt()) {
> > > 		add_page_to_special_list(page);
> > > 		return;
> > > 	} else
> > > 		lru_cache_del(page);
> > > }
> >
> > If this were a common case where many pages end up, yes, we'd
> > need a separate special list; but it's a very rare case
> 
> Think of a web or ftp server doing nothing but sendfile()

But still, you're

> > I was proposing we revert to distinguishing page_cache_release
> > from put_page, page_cache_release doing the lru_cache_del; and
> > I'd like to add my in_interrupt() BUG() there for now, just as
> > a sanity check.  You are proposing that we keep the current,
> > post-Ben, structure of doing it in __free_pages_ok if possible.
> 
> So how exactly would pages be freed ?
> You still need to do the check of whether the page can
> be freed somewhere.

He suggested letting shrink_caches find it.  But since we already know the 
page is free there's no sense scanning for it, so on balance I think your
approach is better.  An atomic_put_page, used from any context that could end 
up in an interrupt, would be better yet, just because it imposes the extra 
check only on users that require it.  Otoh, I did note davem's objection 
above.

-- 
Daniel
