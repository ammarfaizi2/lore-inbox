Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262675AbREVRTp>; Tue, 22 May 2001 13:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262678AbREVRTi>; Tue, 22 May 2001 13:19:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:24082 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262675AbREVRTa>; Tue, 22 May 2001 13:19:30 -0400
Date: Tue, 22 May 2001 10:19:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: add page argument to copy/clear_user_page
In-Reply-To: <15112.22465.860419.234933@tango.paulus.ozlabs.org>
Message-ID: <Pine.LNX.4.21.0105221012530.19531-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 May 2001, Paul Mackerras wrote:
> 
> As for the `to' argument, yes it is redundant since it is just kmap(page).

And why not let "clear_page()" just do that itself?

The only place that doesn't already do "kmap(page)" is basically
get_zeroed_page(), and the only reason it doesn't do that is because the
whole function is fundamentally not able to handle high memory pages (it
returns a fixed address, not the "struct page *".

But that function is also likely to not care about the extra five cycles
or so of having to do the kmap() by making clear_page() (and copy_page())
always use "struct page *" and do kmap() internally. Because most people
who care about performance are already using other functions (in fact, the
functions that _can_ allocate high memory).

And I hate redundancy, and having different functions for the same thing.

> But copy/clear_user_page isn't the interface that gets called from the
> MM stuff, copy/clear_user_highpage is, defined in include/linux/highmem.h.
> These are two of a whole series of functions which all do kmap, do
> something, kunmap.

The thing is, copy/clear_page shouldn't exist at all (or rather, the
"highpage" versions should be renamed to the non-highpage names, because
the non-highmem case simply isn't interesting any more).

The highmem special casing used to make sense back when highmem was a rare
special case. These days, we should just get rid of the distinction as
much as possible,

		Linus

