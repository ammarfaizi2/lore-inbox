Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277114AbRJMRNj>; Sat, 13 Oct 2001 13:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277370AbRJMRNa>; Sat, 13 Oct 2001 13:13:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3851 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277114AbRJMRNR>; Sat, 13 Oct 2001 13:13:17 -0400
Date: Sat, 13 Oct 2001 10:13:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <20011013165332.A20499@kushida.jlokier.co.uk>
Message-ID: <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Oct 2001, Jamie Lokier wrote:
>
> I can think of an efficiency-related use for MAP_COPY, and it has
> nothing to do with shared libraries:
>
>  - An editor using mmap() to read a file.

No, you're thinking the wrong way.

Trust me, MAP_COPY really _is_ stupid, and the Hurd is a piece of crap.

People who think MAP_COPY is a good idea are people who cannot think about
the implications of it, and cannot think about the alternatives.

In particular, you claim that you could use "mmap()" for "read()", and
speed up the application that way. Ok, fair enough.

Now, somebody who _isn't_ stupid (and that, of course, is me), immediately
goes "well, _duh_, why don't you speed up read() instead?".

The fact is, all the problems that "MAP_COPY" has just go away if you
instead of thinking about a mmap(), you think about doing a "read()" and
just marking the pages PAGE_COPY if they are exclusive.

In short: MAP_COPY is braindamaged, because it doesn't have enough
information at the right level to do a reasonable job of it. What people
want to use it for is really to emulate "read()" efficiently using mmap,
and _nothing_ else. That is the only reason for it ever existing, and the
fact is, that clearly shows just how _stupid_ the whole thing is.

You migth as well just do a read() in the first place.

Your arguments are
 - read() implies a memcpy()
 - read() dirties pages and causes more memory pressure

but you don't actually _question_ those arguments.

I will tell you that doing a read() that _acts_ like the MAP_COPY you so
want is a LOT easier than doing MAP_COPY in the first place.

Why?

 - a read() call doesn't have any "history" - it doesn't leave (bogus)
   VM data around like MAP_COPY does. MAP_COPY says "I want these pages to
   have the contents they did _when_I_did_the_mapping_", which is a
   temporal shift that just doesn't make sense in any sane VM model, and
   which inherently implies versioning.

 - a read() can fairly easily just do the optimization

	(a) if we're reading a large area
	(b) if the offset and the destination are page-aligned
	(c) if the page is exclusive (ie no existing other owners)
		then
	just do the page move instead of the copy, and mark the page as
	PAGE_COPY

   Every other use of the page that can change it (ie a shared writable
   mapping, or a "write()" call) will now check the PAGE_COPY bit on the
   _page_, and just say "ok, I'll allocate a new page, and atomically
   switch the ones, and leave the old page untouched and remove it from
   the page cache"

   (And the swap-out logic has to turn a PAGE_COPY page into a swap-cache
   page - this is the real downside, because it implies that we will have
   to write it out to swap if we're low on memory, unlike a real mmap)

Notice? Same as MAP_COPY, but without any global state.

And notice how this is actually conceptually much closer to what you
actually _want_ to use MAP_COPY for.

Could we implement MAP_COPY as such a read()? Yes, sure. But that's just
confusing the issue - why call it a mmap() at all, when it isn't. The day
when Hurd is so common that we want to emulate its braindamages is not
going to be in my life-time, I suspect.

		Linus

