Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbRADSBi>; Thu, 4 Jan 2001 13:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbRADSBS>; Thu, 4 Jan 2001 13:01:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40716 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129557AbRADSAs>; Thu, 4 Jan 2001 13:00:48 -0500
Date: Thu, 4 Jan 2001 10:00:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Christoph Rohland <cr@sap.com>, Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
In-Reply-To: <6740000.978629925@tiny>
Message-ID: <Pine.LNX.4.10.10101040958310.15597-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Chris Mason wrote:
>
> The page dirty bit is not reset.
> the page is never unlocked.
> 
> So how about something like this in filemap_fdatasync

I'd rather just change the rule that "writepage()" will clear the dirty
bit itself and always unlock (and "1" just to inform the upper layers that
the page cannot be thrown away).

> And then, in filemap_fdatawait:
> 
> list_del(&page->list) ;
> if (PageDirty(page))
>     list_add(&page->list, &mapping->dirty_pages) ;
> else
>     list_add(&page->list, &mapping->clean_pages) ;

Can't be done. The thing depends on the fact that it always depletes the
dirty list. The whole fdatasync() logic hinges on the fact that it will
always move pages "down" - otherwise it will never complete.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
