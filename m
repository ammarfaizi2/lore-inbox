Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRAIU41>; Tue, 9 Jan 2001 15:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAIU4I>; Tue, 9 Jan 2001 15:56:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6662 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129431AbRAIU4A>; Tue, 9 Jan 2001 15:56:00 -0500
Date: Tue, 9 Jan 2001 12:55:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: migo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101092036.VAA06353@ns.caldera.de>
Message-ID: <Pine.LNX.4.10.10101091252330.2331-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Christoph Hellwig wrote:
> 
> Also the tuple argument you gave earlier isn't right in this specific case:
> 
> when doing sendfile from pagecache to an fs, you have a bunch of pages,
> an offset in the first and a length that makes the data end before last
> page's end.

No.

Look at sendfile(). You do NOT have a "bunch" of pages.

Sendfile() is very much a page-at-a-time thing, and expects the actual IO
layers to do it's own scatter-gather. 

So sendfile() doesn't want any array at all: it only wants a single
page-offset-length tuple interface.

The _lower-level_ stuff (ie TCP and the drivers) want the "array of
tuples", and again, they do NOT want an array of pages, because if
somebody does two sendfile() calls that fit in one packet, it really needs
an array of tuples.

In short, the kiobuf interface is _always_ the wrong one.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
