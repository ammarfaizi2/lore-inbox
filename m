Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280743AbRKSVt7>; Mon, 19 Nov 2001 16:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280744AbRKSVtu>; Mon, 19 Nov 2001 16:49:50 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:29703 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280743AbRKSVte>; Mon, 19 Nov 2001 16:49:34 -0500
Date: Mon, 19 Nov 2001 19:49:19 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Simon Kirby <sim@netnation.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33.0111191325040.8600-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0111191945060.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Linus Torvalds wrote:
> On Mon, 19 Nov 2001, Marcelo Tosatti wrote:
> >
> > We ended up talking about the possibility of a reschedule (IRQ) happening
> > before after the "spin_unlock(pagecache_lock)" but before the
> > "lru_cache_add()".
>
> So?
>
> The worst that happens is that the page is not on the LRU list, which
> just means that it won't be free'd until we add it (which we will do
> when the lru_cache_add() resumes..

I wonder if the following scenario is possible:

CPU 0				CPU 1

add_to_page_cache()		truncate_list_pages()

spin_lock(&pagecache_lock);
__add_to_page_cache()
spin_unlock(&pagecache_lock);

==> network irq
    ...				remove_inode_page()
    ...
==> softirqs			__free_pages_ok()
    ...
    ...
	*** page now on free list ***

lru_cache_add(page);

	*** BOOM ***


regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

