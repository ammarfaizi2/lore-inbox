Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131484AbRCWW2q>; Fri, 23 Mar 2001 17:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRCWW21>; Fri, 23 Mar 2001 17:28:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52498 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131479AbRCWW2X>; Fri, 23 Mar 2001 17:28:23 -0500
Date: Fri, 23 Mar 2001 14:27:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Stephen C. Tweedie" <sct@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Ben LaHaise <bcrl@redhat.com>,
        Christoph Rohland <cr@sap.com>
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
In-Reply-To: <E14gZuj-0005YN-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0103231424230.766-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Alan Cox wrote:
> >
> > 	+       spin_lock (&info->lock);
> > 	+
> > 	+       /* The shmem_swp_entry() call may have blocked, and
> > 	+        * shmem_writepage may have been moving a page between the page
> > 	+        * cache and swap cache.  We need to recheck the page cache
> > 	+        * under the protection of the info->lock spinlock. */
> > 	+
> > 	+       page = find_lock_page(mapping, idx);
> >
> > Ehh.. Sleeping with the spin-lock held? Sounds like a truly bad idea.
>
> Umm find_lock_page doesnt sleep does it ?

Sure it does. Note the "lock" in find_lock_page(). It will lock the page,
which implies sleeping if somebody is accessing it at the same time.

If you don't want to sleep, you need to use one of the wrappers for
"__find_page_nolock()". Something like "find_get_page()", which only
"gets" the page.

The naming actually does make sense in this area.

		Linus

