Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132576AbRAQVWy>; Wed, 17 Jan 2001 16:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRAQVWp>; Wed, 17 Jan 2001 16:22:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:33287 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132576AbRAQVW0> convert rfc822-to-8bit; Wed, 17 Jan 2001 16:22:26 -0500
Date: Wed, 17 Jan 2001 13:22:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rick Jones <raj@cup.hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <3A65FA77.9E1C1117@cup.hp.com>
Message-ID: <Pine.LNX.4.10.10101171259470.10031-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id NAA22890
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jan 2001, Rick Jones wrote:
>
> > The fact that I understand _why_ it is done that way doesn't mean that I
> > don't think it's a hack. It doesn't allow you to sendfile multiple files
> > etc without having nagle boundaries, and the header/trailer stuff really
> > isn't a generic solution.
> 
> Hmm, I would think that nagle would only come into play if those files
> were each less than MSS and there were no intervening application level
> reply/request messages for each.

It's not the file itself - it's the headers and trailers.

The reason you want to have headers and trailers in your sendfile() is
two-fold:

 - if you have high system call latency, it can make a difference.

   This one simply isn't an issue with Linux. System calls are cheap, and
   I'd rather optimize them further than make them uglier. 

 - the packet boundary between the header and the file you're sending.

    Normally, if you do a separate data "send()" for the header before
    actually using sendfile(), the header would be sent out as one packet,
    while the actual file contents would then get coalesced into MSS-sized
    packets.

    This is why people originally did writev() and sendmsg() - to allow
    people to do scatter-gather without having multiple packets on the
    wire, and letting the OS choose the best packet boundaries, of course.

So the Linux approach (and, obviously, in my opinion the only right
approach) is basically to 

 (a) make sure that system call latency is low enough that there really
     aren't any major reasons to avoid system calls. They're just function
     calls - they may be a bit heavier than most functions, of course, but
     people shouldn't need to avoid them like the plague like on some
     systems.

and

 (b) TCP_CORK. 

Now, TCP_CORK is basically me telling David Miller that I refuse to play
games to have good packet size distribution, and that I wanted a way for
the application to just tell the OS: I want big packets, please wait until
you get enough data from me that you can make big packets.

Basically, TCP_CORK is a kind of "anti-nagle" flag. It's the reverse of
"no-nagle". So you'd "cork" the TCP connection when you know you are going
to do bulk transfers, and when you're done with the bulk transfer you just
"uncork" it. At which point the normal rules take effect (ie normally
"send out any partial packets if you have no packets in flight").

This is a _much_ better interface than having to play games with
scatter-gather lists etc. You could basically just do

	int optval = 1;

	setsockopt(sk, SOL_TCP, TCP_CORK, &optval, sizeof(int));
	write(sk, ..);
	write(sk, ..);
	write(sk, ..);
	sendfile(sk, ..);
	write(..)
	printf(...);
	...any kind of output..

	optval = 0;
	setsockopt(sk, SOL_TCP, TCP_CORK, &optval, sizeof(int));

and notice how you don't need to worry about _how_ you output the data any
more. It will automatically generate the best packet sizes - waiting for
disk if necessary etc.

With TCP_CORK, you can obviously and trivially emulate the HP-UX behaviour
if you want to. But you can just do _soo_ much more.

Imagine, for example, keep-alive http connections. Where you might be
doing multiple sendfile()'s of small files over the same connection, one
after the other. With Linux and TCP_CORK, what you can basically do is to
just cork the connection at the beginning, and then let is stay corked for
as long as you don't have any outstanding requests - ie you uncork only
when you don't have anything pending any more.

(The reason you want to uncork at all, is to obviously let the partial
packets out when you don't know if you'll write anything more in the near
future. Uncorking is important too.

Basically, TCP_CORK is useful whenever the server knows the patterns of
its bulk transfers. Which is just about 100% of the time with any kind of
file serving.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
