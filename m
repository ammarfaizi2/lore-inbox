Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130457AbRBHSA1>; Thu, 8 Feb 2001 13:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130472AbRBHSAR>; Thu, 8 Feb 2001 13:00:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15876 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130457AbRBHSAG>; Thu, 8 Feb 2001 13:00:06 -0500
Date: Thu, 8 Feb 2001 09:59:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Ben LaHaise <bcrl@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <3A82A8FA.CB9B2F29@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10102080952550.6741-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Feb 2001, Martin Dalecki wrote:
> > 
> > But you'll have a bitch of a time trying to merge multiple
> > threads/processes reading from the same area on disk at roughly the same
> > time. Your higher levels won't even _know_ that there is merging to be
> > done until the IO requests hit the wall in waiting for the disk.
> 
> Merging is a hardware tighted optimization, so it should happen, there we you
> really have full "knowlendge" and controll of the hardware -> namely the
> device driver. 

Or, in many cases, the device itself. There are valid reasons for not
doing merging in the driver, but they all tend to boil down to "even lower
layers can do a better job of it". They basically _never_ boil down to
"upper layers already did it for us".

That said, there tend to be advantages to doing "appropriate" clustering
at each level. Upper layers can (and do) use read-ahead to help the lower
levels. The write-out can (and currently does not) try to sort the
requests for better elevator behaviour.

The driver level can (and does) further cluster the requests - even if the
low-level device does a perfect job of orderign and merging on its own
it's usually advantageous to have fewer (and bigger) commands in-flight in
order to have fewer completion interrupts and less command traffic on the
bus.

So it's obviously not entirely black-and-white. Upper layers can help, but
it's a mistake to think that they should "do the work".

(Note: a lot of people seem to think that "layering" means that the
complexity is in upper layers, and that lower layers should be simple and
"stupid". This is not true. A well-balanced layering would have all layers
doing potentially equally complex things - but the complexity should be
_independent_. Complex interactions are bad. But it's also bad to thin
kthat lower levels shouldn't be allowed to optimize because they should be
"simple".).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
