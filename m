Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131725AbRAITPq>; Tue, 9 Jan 2001 14:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131708AbRAITP3>; Tue, 9 Jan 2001 14:15:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54801 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131687AbRAITPX>; Tue, 9 Jan 2001 14:15:23 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Date: 9 Jan 2001 11:14:54 -0800
Organization: Transmeta Corporation
Message-ID: <93fnve$250$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva> <20010109113145.A28758@caldera.de> <200101091031.CAA01242@pizda.ninka.net> <20010109122810.A3115@caldera.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010109122810.A3115@caldera.de>,
Christoph Hellwig  <hch@caldera.de> wrote:
>
>You get that multiple page call with kiobufs for free...

No, you don't.

kiobufs are crap. Face it. They do NOT allow proper multi-page scatter
gather, regardless of what the kiobuf PR department has said.

I've complained about it before, and nobody listened. Davids zero-copy
network code had the same bug. I complained about it to David, and David
took about a day to understand my arguments, and fixed it.

It's more likely that the zero-copy network code will be used in real
life than kiobufs will ever be.  The kiobufs are damn ugly by
comparison, and the fact that the kiobuf people don't even seem to
realize the problems makes me just more convinced that it's not worth
even arguing about.

What is the problem with kiobuf's? Simple: they have a "offset" and a
"length", and an array of pages.  What that completely and utterly
misses is that if you have an array of pages, you should have an array
of "offset" and "length" too.  As it is, kiobuf's cannot be used for
things like readv() and writev(). 

Yes, to work around this limitation, there's the notion of "kiovec", an
array of kiobuf's.  Never mind the fact that if kiobuf's had been
properly designed in the first place, you wouldn't need kiovec's at all. 
And kiovec's are too damn heavy to use for something like the networking
zero-copy, with all the double indirection etc. 

I told David that he can fix the network zero-copy code two ways: either
he makes it _truly_ scatter-gather (an array of not just pages, but of
proper page-offset-length tuples), or he makes it just a single area and
lets the low-level TCP/whatever code build up multiple segments
internally.  Either of which are good designs.

It so happens that none of the users actually wanted multi-page
scatter-gather, and the only thing that really wanted to do the sg was
the networking layer when it created a single packet out of multiple
areas, so the zero-copy stuff uses the simpler non-array interface. 

And kiobufs can rot in hell for their design mistakes.  Maybe somebody
will listen some day and fix them up, and in the meantime they can look
at the networking code for an example of how to do it. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
