Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131888AbRCYATH>; Sat, 24 Mar 2001 19:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131897AbRCYAS4>; Sat, 24 Mar 2001 19:18:56 -0500
Received: from zeus.kernel.org ([209.10.41.242]:6627 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131888AbRCYASl>;
	Sat, 24 Mar 2001 19:18:41 -0500
Date: Sun, 25 Mar 2001 00:13:38 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>, Rik van Riel <riel@nl.linux.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ben LaHaise <bcrl@redhat.com>, Christoph Rohland <cr@sap.com>
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
Message-ID: <20010325001338.C11686@redhat.com>
In-Reply-To: <20010323011331.J7756@redhat.com> <Pine.LNX.4.31.0103231157200.766-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.31.0103231157200.766-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 23, 2001 at 11:58:50AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 23, 2001 at 11:58:50AM -0800, Linus Torvalds wrote:

> Ehh.. Sleeping with the spin-lock held? Sounds like a truly bad idea.

Uggh --- the shmem code already does, see:

shmem_truncate->shmem_truncate_part->shmem_free_swp->
lookup_swap_cache->find_lock_page

It looks messy: lookup_swap_cache seems to be abusing the page lock
gratuitously, but there are probably callers of it which rely on the
assumption that it performs an implicit wait_on_page().

Rik, do you think it is really necessary to take the page lock and
release it inside lookup_swap_cache?  I may be overlooking something,
but I can't see the benefit of it --- we can still race against
page_launder, so the page may still get locked behind our backs after
we get the reference from lookup_swap_cache (page_launder explicitly
avoids taking the pagecache hash spinlock which might avoid this
particular race).

--Stephen
