Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132579AbRAIXzT>; Tue, 9 Jan 2001 18:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132415AbRAIXzJ>; Tue, 9 Jan 2001 18:55:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47373 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132117AbRAIXyy>; Tue, 9 Jan 2001 18:54:54 -0500
Date: Tue, 9 Jan 2001 15:54:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Benjamin C.R. LaHaise" <blah@kvack.org>
cc: Christoph Hellwig <hch@ns.caldera.de>, migo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.3.96.1010109175317.7868A-100000@kanga.kvack.org>
Message-ID: <Pine.LNX.4.10.10101091540130.2815-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Benjamin C.R. LaHaise wrote:

> On Tue, 9 Jan 2001, Linus Torvalds wrote:
> 
> > The _lower-level_ stuff (ie TCP and the drivers) want the "array of
> > tuples", and again, they do NOT want an array of pages, because if
> > somebody does two sendfile() calls that fit in one packet, it really needs
> > an array of tuples.
> 
> A kiobuf simply provides that tuple plus the completion callback.  Stick a
> bunch of them together and you've got a kiovec.  I don't see the advantage
> of moving to simpler primatives if they don't provide needed
> functionality.

Ehh.

Let's re-state your argument:

 "You could have used the existing, complex and cumbersome primitives that
  had the wrong semantics. I don't see the advantage of pointing out the
  fact that those primitives are badly designed for the problem at hand 
  and moving to simpler and better designed primitives that fit the
  problem well"

Would you agree that that is the essense of what you said? And if not,
then why not?

> Please tell me what you think the right interface is that provides a hook
> on io completion and is asynchronous.

Suggested fix to kiovec's: get rid of them. Immediately. Replace them with
kiobuf's that can handle scatter-gather pages. kiobuf's have 90% of that
support already.

Never EVER have a "struct page **" interface. It is never the valid thing
to do. You should have

	struct fragment {
		struct page *page;
		__u16 offset, length;
	}

and then have "struct fragment **" inside the kiobuf's instead. Rename
"nr_pages" as "nr_fragments", and get rid of the global offset/length, as
they don't make any sense. Voila - your kiobuf is suddenly a lot more
flexible.

Finally, don't embed the static KIO_STATIC_PAGES array in the kiobuf. The
caller knows when it makes sense, and when it doesn't. Don't embed that
knowledge in fundamental data structures.

In the meantime, I'm more than happy to make sure that the networking
infrastructure is sane. Which implies that the networking infrastructure
does NOT use kiovecs.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
