Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIQkr>; Tue, 9 Jan 2001 11:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAIQkh>; Tue, 9 Jan 2001 11:40:37 -0500
Received: from chiara.elte.hu ([157.181.150.200]:20748 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129226AbRAIQk2>;
	Tue, 9 Jan 2001 11:40:28 -0500
Date: Tue, 9 Jan 2001 17:40:06 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Benjamin C.R. LaHaise" <blah@kvack.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, <riel@conectiva.com.br>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.3.96.1010109103229.5051A-100000@kanga.kvack.org>
Message-ID: <Pine.LNX.4.30.0101091720030.4491-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Benjamin C.R. LaHaise wrote:

> Do the math again: for transmitting a single page in a kiobuf only 64
> bytes needs to be initialized.  If map_array is moved to the end of
> the structure, that's all contiguous data and is a single cacheline.

but you are comparing apples to oranges: an iobuf to a fragment-array. A
fragment-array is equivalent to an array of iobufs. In typical (eg. HTTP)
output we have mixed sendfile() and sendmsg() based output, so we have an
array of (page, offset, size) memory-areas, not a (initial_offset, page[])
array like kiobufs. The closest thing would be an array of kiobufs (where
each kiobuf would use a single page only).

this is why i ment that *right now* kiobufs are not suited for networking,
at least the way we do it. Maybe if kiobufs had the same kind of internal
structure as sk_frag (ie. array of (page,offset,size) triples, not array
of pages), that would work out better.

> What you're completely ignoring is that sendpages is lacking a huge
> amount of functionality that is *needed*. I can't implement clean
> async io on top of sendpages -- it'll require keeping 1 task around
> per outstanding io, which is exactly the bottleneck we're trying to
> work around.

Please take a look at next release of TUX. Probably the last missing piece
was that i added O_NONBLOCK to generic_file_read() && sendfile(), so not
fully cached requests can be offloaded to IO threads.

Otherwise the current lowlevel filesystem infrastructure is not suited for
implementing "process-less async IO "- and kiovecs wont be able to help
that either. Unless we implement async, IRQ-driven bmap(), we'll always
need some sort of process context to set up IO.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
