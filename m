Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbREMQZV>; Sun, 13 May 2001 12:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbREMQZL>; Sun, 13 May 2001 12:25:11 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:27407 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261368AbREMQZD>;
	Sun, 13 May 2001 12:25:03 -0400
Date: Sun, 13 May 2001 13:24:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.3.96.1010508142408.569A-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0105131322190.5468-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, Mikulas Patocka wrote:

> > +		if (!dead_swap_page &&
> > +		    (PageTestandClearReferenced(page) || page->age > 0 ||
> > +		     (!page->buffers && page_count(page) > 1) ||
> > +		     page_ramdisk(page))) {
> 		^^^^^^^^^^^^^^^^^^^^^^
> >  			del_page_from_inactive_dirty_list(page);
> >  			add_page_to_active_list(page);
> >  			continue;
> 
> #define page_ramdisk(page) \
>         (page->buffers && (MAJOR(page->buffers->b_dev) == RAMDISK_MAJOR))
> 
> Are you sure that no one will release buffers under your hands?

Two things can happen:

1) the page gets ramdisk buffers _after_ we look at it first,
   in this case the page isn't freeable and will be moved to
   the active list on the next page_launder() loop

2) the page loses its ramdisk buffers after we look at it,
   now the page is freeable, but we won't see it again until
   it is moved from the active list to the inactive_dirty
   list again

Any side effects harmful enough to warrant complicating this
test ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

