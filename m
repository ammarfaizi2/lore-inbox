Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbRADQfP>; Thu, 4 Jan 2001 11:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRADQfF>; Thu, 4 Jan 2001 11:35:05 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:41714 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129455AbRADQe7>; Thu, 4 Jan 2001 11:34:59 -0500
Date: Thu, 4 Jan 2001 14:34:48 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: try_to_swap_out() return value problem?
In-Reply-To: <Pine.LNX.4.10.10101040820180.15597-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101041429130.1188-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Linus Torvalds wrote:
> On Thu, 4 Jan 2001, Rik van Riel wrote:
> > On Wed, 3 Jan 2001, Linus Torvalds wrote:
> > > On Thu, 4 Jan 2001, Marcelo Tosatti wrote:
> > 
> > > I agree that the return value of swap_out() is fairly meaningless. It's
> > > been fairly meaningless for a long time now, and it's entirely possible
> > > that the "while (swap_out())" loop should be just something like
> > > 
> > > 	/* Scan the VM space, try to clean up the page tables a bit */
> > > 	for (i = 0 ; i <= nr_threads >> priority; i++)
> > > 		swap_out(gfp_mask);
> > 
> > The problem with this is that it means that page aging of
> > the mapped active pages is no longer balanced against the
> > aging of the unmapped active pages.
> 
> Is there any reason to not just remove the lines
> 
>         if (!onlist)
>                 /* The page is still mapped, so it can't be freeable... */
>                 age_page_down_ageonly(page);
> 
>         /*
>          * If the page is in active use by us, or if the page
>          * is in active use by others, don't unmap it or
>          * (worse) start unneeded IO.
>          */
>         if (page->age > 0)
>                 goto out_failed;
> 
> from vmscan?
> 
> They look like a complete hack, although an understandable one
> from the time when the virtual memory scan used to actually do
> IO as well.
>
> These days, if you think of the VM scanning as just a "shrink
> the page tables" operation, the down-aging doesn't make much
> sense. That will happen once the page has been moved to the
> lists, no?

Hmmmm, I'm not sure ...

I can't quite put my finger on it, but my gut feeling
says that removing this lines could unbalance the page
aging and/or cause other nasties.

Then again, in theory the current VM should already be
unbalanced and we haven't felt any bad effects yet ;)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
