Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130843AbRARRdG>; Thu, 18 Jan 2001 12:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbRARRc5>; Thu, 18 Jan 2001 12:32:57 -0500
Received: from chiara.elte.hu ([157.181.150.200]:20243 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130843AbRARRct>;
	Thu, 18 Jan 2001 12:32:49 -0500
Date: Thu, 18 Jan 2001 18:32:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rick Jones <raj@cup.hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.10.10101180826370.18072-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101181825200.7211-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jan 2001, Linus Torvalds wrote:

> Remember the UNIX philosophy: everything is a file. MSG_MORE
> completely breaks that, because the only way to use it is with
> send[msg](). It's absolutely unusable with something like a
> traditional UNIX "anonymous" application that doesn't know or care
> that it's writing to the network.

yep you are right - i only thought in terms of applications that know that
they are dealing with a network.

> In contrast, TCP_CORK has an interface much like TCP_NOPUSH, along
> with the notion of persistency. The difference between those two is
> that TCP_CORK really took the notion of persistency to the end, and
> made uncorking actually say "Ok, no more packets". You can't do that
> with TCP_NOPUSH: with TCP_NOPUSH you basically have to know what your
> last write is, and clear the bit _before_ that write if you want to
> avoid bad latencies (alternatively, you can just close the socket,
> which works equally well, and was probably the designed interface for
> the thing. That has the disadvantage of, well, closing the socket - so
> it doesn't work if you don't _know_ whether you'd write more or not).

i believe BSD's TCP_NOPUSH should add those 3 lines that are needed to
flush pending packets, this is what we do too - we do a
tcp_push_pending_frames() if the socket option TCP_CORK is cleared.

> So the three are absolutely not equivalent. I personally think that
> TCP_NOPUSH is always the wrong thing - it has the persistency without
> the ability to shut it off gracefully after the fact. In contrast,
> both MSG_MORE and TCP_CORK have well-defined behaviour but they have
> very different uses.

yep - i agree now. In terms of network-aware applications, i found
MSG_MORE to be both cheaper and less bug-prone - but for uncooperative (or
simply too generic) applications which are output-ing to simple files
there is no way to control buffering, only some persistent mechanizm.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
