Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132050AbRARQuk>; Thu, 18 Jan 2001 11:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132150AbRARQuU>; Thu, 18 Jan 2001 11:50:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12806 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132050AbRARQuN>; Thu, 18 Jan 2001 11:50:13 -0500
Date: Thu, 18 Jan 2001 08:49:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Rick Jones <raj@cup.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101181411530.823-100000@elte.hu>
Message-ID: <Pine.LNX.4.10.10101180826370.18072-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jan 2001, Ingo Molnar wrote:
>
> [ BSD's TCP_NOPUSH ] 
>
> this is what MSG_MORE does.Basically i added MSG_MORE for the purpose of
> getting perfect TUX packet boundaries (and was ignorant enough to not know
> about BSD's NOPUSH), without an additional system-call overhead, and
> without the persistency of TCP_CORK. Alexey and David agreed, and actually
> implemented it correctly :-)

MSG_MORE is very different from TCP_NOPUSH, which is very different from
TCP_CORK.

First off, the interfaces are very different. MSG_MORE is a "this write
will be followed by more writes", and only works on programs that know
that they are writing to a socket.

That has its advantages: it's a very local thing, and doesn't need any
state. However, the fact is that you _need_ the persistency of a socket
option if you want to take advantage of external programs etc getting good
behaviour without having to know that they are talking to a socket. 

Remember the UNIX philosophy: everything is a file. MSG_MORE completely
breaks that, because the only way to use it is with send[msg](). It's
absolutely unusable with something like a traditional UNIX "anonymous"
application that doesn't know or care that it's writing to the network.

So while MSG_MORE has uses, it's absolutely and utterly wrong to say that
it is equivalent to either TCP_NOPUSH or TCP_CORK.

Now, I'll agree that TCP_NOPUSH actually has the same _logic_ as MSG_MORE:
you can basically say that the two are more or less equivalent by a source
transformation (ie send(MSG_MORE) => "set TCP_NOPUSH + send() + clear
TCP_NOPUSH". Both of them are really fairly "local", but TCP_NOPUSH has a
_notion_ of persistency that is entirely lacking in MSG_MORE.

In contrast, TCP_CORK has an interface much like TCP_NOPUSH, along with
the notion of persistency. The difference between those two is that
TCP_CORK really took the notion of persistency to the end, and made
uncorking actually say "Ok, no more packets". You can't do that with
TCP_NOPUSH: with TCP_NOPUSH you basically have to know what your last
write is, and clear the bit _before_ that write if you want to avoid bad
latencies (alternatively, you can just close the socket, which works
equally well, and was probably the designed interface for the thing. That
has the disadvantage of, well, closing the socket - so it doesn't work if
you don't _know_ whether you'd write more or not).

So the three are absolutely not equivalent. I personally think that
TCP_NOPUSH is always the wrong thing - it has the persistency without the
ability to shut it off gracefully after the fact. In contrast, both
MSG_MORE and TCP_CORK have well-defined behaviour but they have very
different uses.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
