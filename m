Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130748AbRAQWyA>; Wed, 17 Jan 2001 17:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130844AbRAQWxv>; Wed, 17 Jan 2001 17:53:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27403 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130748AbRAQWxn>; Wed, 17 Jan 2001 17:53:43 -0500
Date: Wed, 17 Jan 2001 14:53:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rick Jones <raj@cup.hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <3A661A00.E3344A18@cup.hp.com>
Message-ID: <Pine.LNX.4.10.10101171428520.10628-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jan 2001, Rick Jones wrote:
> > 
> >  (a) make sure that system call latency is low enough that there really
> >      aren't any major reasons to avoid system calls. They're just function
> >      calls - they may be a bit heavier than most functions, of course, but
> >      people shouldn't need to avoid them like the plague like on some
> >      systems.
> 
> i'm not quite sure how it plays here, but someone once told me that the
> most efficient procedure call was the one that was never made :)

Absolutely.

But I'm also a firm believer in "simplicity makes performance". 

My personal problem (and maybe it really is just me) with sendmgs() and
writev() kind of scatter-gather interfaces is that I think they are hard
and non-intuitive to use. They work beautifully if you design with them in
mind, and your data really is fundamentally already laid out in memory.

But they tend to be a bit too complicated if you have to do things like
"sprintf()" to generate part of the data first, and if you don't know
where you'll get your data before it is generated etc. For example, the
whole writev()/sendfile() kind of approach just _totally_ breaks down when
you have things like CGI involved.

Basically, I think the scatter-gather interfaces are too inflexible: they
are designed for one thing, and one thing only, and it's hard to use them
for anything else. And being hard to use means that people will do
non-obvious things, or just ignore them. Both of which will be bad for
performance in the long run. If you try to be clever, the program gets
harder to maintain, and because of that you can't do the good kinds of
re-organizations that might improve it.

The true power of TCP_CORK is when you really start thinking about what it
means that you can do _any_ output. Suddenly, you can have perl CGI stuff,
that uses stdio or something even more primitive that doesn't do buffering
at all - and it will automatically look ok on the wire.

> How "bulk" is a bulk transfer in your thinking? By the time the transfer
> gets above something like 100*MSS I would think that the first small
> packet would become epsilon. 

Actually, I don't really mean "bulk" as in "big", but more as in
"noninteractive". The biggest advantage of things like TCP_CORK is exactly
for small files or smallish CGI output, where it makes a difference
whether you sent out 4 big packets or 5 half-sized packets.

> How does CORKing interact with ACK generation? In particular how it
> might interact with (or rather possibly induce) standalone ACKs?

If anything, it should reduce ACK's too, simply because it reduces the
number of packets. But with most people doing delayed ACKs for every 2 MSS
of data (or whatever the RFC's specify), this is probably not really much
of an issue.

> so after i present each reply, i'm checking to see if there is another
> request and if there is not i have to uncork to get the residual data to
> flow.

Another way of thinking about it - you just know when the connection is
idle, and you uncork.

But note that you don't _have_ to be clever, if you don't want to. You can
just uncork after each transfer, and you'll still do no worse than if you
never corked at all. And you'll have all the advantages of being able to
not worry about how your CGI scripts etc work together.

> But does the server know the arrival pattern (well time distribution) of
> requests? It seems that one depends on a client being helpful about
> getting requests to the server in groups otherwise one is corking and
> uncorking the connection.

Oh, best performance definitely depends on the client interleaving the
requests. What else is new?

TCP_CORK is not going to suddenly make your application never have to
think about performance ever again ay more. That's obvious. It is nothing
but a tool in your tool-chest. It's a tool with a very simple interface,
and it's rather generic. Which is why it's so powerful. But it's not a
panacea.

I'm claiming that with TCP_CORK, it's fairly obvious how to write a server
that _can_ take advantage of a pipelined client. 

In contrast, with a writev/sg-sendfile kind of interface it would be much
more painful. You'd have to explicitly buffer up your replies all the
time, which creates much more interesting (read: bug-prone) memory
management issues, AND makes it a real bitch to handle things like
external CGI stuff etc.

But no, let's not claim that TCP_CORK solves the problem of world hunger..

(I also had one person point out that BSD's have the notion of TCP_NOPUSH,
which does almost what TCP_CORK does under Linux, except it doesn't seem
to have the notion of uncorking - you can turn NOPUSH off, but apparently
it doesn't affect queued packets. This makes it even less clear why they
have the ugly sendfile)

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
