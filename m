Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287872AbSBIA3d>; Fri, 8 Feb 2002 19:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291894AbSBIA2G>; Fri, 8 Feb 2002 19:28:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30992 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291900AbSBIA0x>; Fri, 8 Feb 2002 19:26:53 -0500
Date: Fri, 8 Feb 2002 16:25:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>
Subject: Re: patch: aio + bio for raw io
In-Reply-To: <20020208190117.A12959@redhat.com>
Message-ID: <Pine.LNX.4.33.0202081611490.11791-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Feb 2002, Benjamin LaHaise wrote:
>
> Yup.  What we need is an interface for getting the max size of an io --

No. There is no such thing.

There is no "max size". There are various different limits, and "size" is
usually the last one on the list. The limitations are things like "I can
have at most N consecutive segments" or "crossing a 64kB border is fine,
but implies a new segment" or "a single segment is limited to X bytes, and
the _sum_ of all segments are limited to Y bytes" or..

And it can depend on the _address_ of the thing you're writing. If the
address is above a bounce limit, the bouncing code ends up having to copy
it to accessible memory, so you can have a device that can do a 4MB
request in one go if it's directly accessible, but if it is not in the low
XXX bits, then it gets split into chunks and copied down, at which point
you may only be able to do N chunks at a time.

And no, I didn't make any of these examples up.

A "max size" does not work. It needs to be a lot more complex than that.
For block devices, you need the whole "struct request_queue" to describe
the default cases, and even then there are function pointers to let
individual drivers limits of their own _outside_ those cases.

So it basically needs to be a "grow_bio()" function that does the choice,
not a size limitation.

(And then most devices will just use one of a few standard "grow()"
functions, of course - you need the flexibility, but at the same time
there is a lot of common cases).

		Linus

