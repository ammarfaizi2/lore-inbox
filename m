Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbRAIMFb>; Tue, 9 Jan 2001 07:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRAIMFW>; Tue, 9 Jan 2001 07:05:22 -0500
Received: from chiara.elte.hu ([157.181.150.200]:5388 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129632AbRAIMFM>;
	Tue, 9 Jan 2001 07:05:12 -0500
Date: Tue, 9 Jan 2001 13:04:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Christoph Hellwig <hch@caldera.de>
Cc: "David S. Miller" <davem@redhat.com>, <riel@conectiva.com.br>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109122810.A3115@caldera.de>
Message-ID: <Pine.LNX.4.30.0101091241490.2424-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Christoph Hellwig wrote:

> Sure.  But sendfile is not one of the fundamental UNIX operations...

Neither were eg. kernel-based semaphores. So what? Unix wasnt perfect and
isnt perfect - but it was a (very) good starting point. If you are arguing
against the existence or importance of sendfile() you should re-think,
sendfile() is a unique (and important) interface because it enables moving
information between files (streams) without involving any interim
user-space memory buffer. No original Unix API did this AFAIK, so we
obviously had to add it. It's an important Linux API category.

> If there was no alternative to this I would probably have not said
> anything, but with the rw_kiovec file op just before the door I don't
> see any reason to add this _very_ specific file operation.

I do think that the kiovec code has to be rewritten substantially before
it can be used for networking zero-copy, so right now we do the least
damange if we do not increase the coverage of kiovec code.

> An alloc_kiovec before and an free_kiovec after the actual call and
> the memory overhaed of a kiobuf won't hurt so much that it stands
> against a clean interface, IMHO.

please study the networking portions of the zerocopy patch and you'll see
why this is not desirable. An alloc_kiovec()/free_kiovec() is exactly the
thing we cannot afford in a sendfile() operation. sendfile() is
lightweight, the setup times of kiovecs are not.

basically the current kiovec design does not deal with the realities of
high-speed, featherweight networking. DO NOT talk in hypotheticals. The
code is there, do it, measure it. You might not care about performance, we
do.

another, more theoretical issue is that i think the kernel should not be
littered with multi-page interfaces, we should keep the one "struct page *
at a time" interfaces. Eg. check out how the new zerocopy code generates
perfect MTU sized frames via the ->writepage() interface. No interim
container objects are necessary.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
