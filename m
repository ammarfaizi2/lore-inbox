Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRBGBl1>; Tue, 6 Feb 2001 20:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129751AbRBGBlR>; Tue, 6 Feb 2001 20:41:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57352 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129290AbRBGBlA>; Tue, 6 Feb 2001 20:41:00 -0500
Date: Tue, 6 Feb 2001 17:40:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207012710.N1167@redhat.com>
Message-ID: <Pine.LNX.4.10.10102061729470.2193-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
> > 
> > The fact is, if you have problems like the above, then you don't
> > understand the interfaces. And it sounds like you designed kiobuf support
> > around the wrong set of interfaces.
> 
> They used the only interfaces available at the time...

Ehh.. "generic_make_request()" goes back a _loong_ time. It used to be
called just "make_request()", but all my points still stand.

It's even exported to modules. As far as I know, the raid code has always
used this interface exactly because raid needed to feed back the remapped
stuff and get around the blocksizing in ll_rw_block().

This really isn't anything new. I _know_ it's there in 2.2.x, and I
would not be surprised if it was there even in 2.0.x.

> > If you want to get at the _sector_ level, then you do
> ...
> > which doesn't look all that complicated to me. What's the problem?
> 
> Doesn't this break nastily as soon as the IO hits an LVM or soft raid
> device?  I don't think we are safe if we create a larger-sized
> buffer_head which spans a raid stripe: the raid mapping is only
> applied once per buffer_head.

Absolutely. This is exactly what I mean by saying that low-level drivers
may not actually be able to handle new cases that they've never been asked
to do before - they just never saw anything like a 64kB request before or
something that crossed its own alignment.

But the _higher_ levels are there. And there's absolutely nothing in the
design that is a real problem. But there's no question that you might need
to fix up more than one or two low-level drivers.

(The only drivers I know better are the IDE ones, and as far as I can tell
they'd have no trouble at all with any of this. Most other normal drivers
are likely to be in this same situation. But because I've not had a reason
to test, I certainly won't guarantee even that).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
