Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135575AbREHWy7>; Tue, 8 May 2001 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135589AbREHWyt>; Tue, 8 May 2001 18:54:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3076 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135575AbREHWyd>; Tue, 8 May 2001 18:54:33 -0400
Date: Tue, 8 May 2001 18:16:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105072038280.8237-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105081813160.9717-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 May 2001, Linus Torvalds wrote:

> 
> On Mon, 7 May 2001, Marcelo Tosatti wrote:
> > 
> > So what about moving the check for a dead swap cache page from
> > swap_writepage() to page_launder() (+ PageSwapCache() check) just before
> > the "if (!launder_loop)" ? 
> > 
> > Yes, its ugly special casing. Any other suggestion ? 
> 
> My most favourite approach by far is to just remove the magic for
> different writepage's altogether, and just unconditionally do a
> writepage. But passing in enough information so that the writepage can
> come to the right decision.
> 
> So take the old code, and remove the code that does
> 
> 	if (!launder_loop) {
> 		.. move to head ..
> 		continue;
> 	}
> 	writepage(page);
> 
> and instead make it do something like
> 
> 	if (writepage(page, launderloop)) {
> 		.. not able to write, move to head ..
> 		continue;
> 	}
> 
> where "launderloop" is passed in to the writepage function as a priority.

There are two issues which I missed yesterday: we have to get a reference
on the page, mark it clean, drop the locks and then call writepage(). If
the writepage() fails, we'll have to set_page_dirty(page).

I guess this is too much overhead for the common case, don't you? 

