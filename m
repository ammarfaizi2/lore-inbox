Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130217AbRAQWSE>; Wed, 17 Jan 2001 17:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbRAQWRy>; Wed, 17 Jan 2001 17:17:54 -0500
Received: from palrel1.hp.com ([156.153.255.242]:7947 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129771AbRAQWRj>;
	Wed, 17 Jan 2001 17:17:39 -0500
Message-ID: <3A661A00.E3344A18@cup.hp.com>
Date: Wed, 17 Jan 2001 14:17:36 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.10.10101171259470.10031-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 17 Jan 2001, Rick Jones wrote:
> >
> > > The fact that I understand _why_ it is done that way doesn't mean that I
> > > don't think it's a hack. It doesn't allow you to sendfile multiple files
> > > etc without having nagle boundaries, and the header/trailer stuff really
> > > isn't a generic solution.
> >
> > Hmm, I would think that nagle would only come into play if those files
> > were each less than MSS and there were no intervening application level
> > reply/request messages for each.
> 
> It's not the file itself - it's the headers and trailers.

OK, the sum of the header/trailer/file when one calls an HP-UX-style
sendfile(). All that does is make it more likely that one will have
sends larger than the MSS.

>  - the packet boundary between the header and the file you're sending.
> 
>     Normally, if you do a separate data "send()" for the header before
>     actually using sendfile(), the header would be sent out as one packet,
>     while the actual file contents would then get coalesced into MSS-sized
>     packets.
> 
>     This is why people originally did writev() and sendmsg() - to allow
>     people to do scatter-gather without having multiple packets on the
>     wire, and letting the OS choose the best packet boundaries, of course.

I prefer to describe it as "presenting logically associated data to the
transport at one time" but that's just wordsmithing.

> So the Linux approach (and, obviously, in my opinion the only right
> approach) is basically to
> 
>  (a) make sure that system call latency is low enough that there really
>      aren't any major reasons to avoid system calls. They're just function
>      calls - they may be a bit heavier than most functions, of course, but
>      people shouldn't need to avoid them like the plague like on some
>      systems.

i'm not quite sure how it plays here, but someone once told me that the
most efficient procedure call was the one that was never made :)

> and
> 
>  (b) TCP_CORK.
> 
> Now, TCP_CORK is basically me telling David Miller that I refuse to play
> games to have good packet size distribution, and that I wanted a way for
> the application to just tell the OS: I want big packets, please wait until
> you get enough data from me that you can make big packets.
> 
> Basically, TCP_CORK is a kind of "anti-nagle" flag. It's the reverse of
> "no-nagle". So you'd "cork" the TCP connection when you know you are going
> to do bulk transfers, and when you're done with the bulk transfer you just
> "uncork" it. At which point the normal rules take effect (ie normally
> "send out any partial packets if you have no packets in flight").

How "bulk" is a bulk transfer in your thinking? By the time the transfer
gets above something like 100*MSS I would think that the first small
packet would become epsilon. 

How does CORKing interact with ACK generation? In particular how it
might interact with (or rather possibly induce) standalone ACKs?

> This is a _much_ better interface than having to play games with
> scatter-gather lists etc. You could basically just do
> 
>         int optval = 1;
> 
>         setsockopt(sk, SOL_TCP, TCP_CORK, &optval, sizeof(int));
>         write(sk, ..);
>         write(sk, ..);
>         write(sk, ..);
>         sendfile(sk, ..);
>         write(..)
>         printf(...);
>         ...any kind of output..
> 
>         optval = 0;
>         setsockopt(sk, SOL_TCP, TCP_CORK, &optval, sizeof(int));
> 
> and notice how you don't need to worry about _how_ you output the data any
> more. It will automatically generate the best packet sizes - waiting for
> disk if necessary etc.
> 
> With TCP_CORK, you can obviously and trivially emulate the HP-UX behaviour
> if you want to. But you can just do _soo_ much more.
> 
> Imagine, for example, keep-alive http connections. Where you might be
> doing multiple sendfile()'s of small files over the same connection, one
> after the other. With Linux and TCP_CORK, what you can basically do is to
> just cork the connection at the beginning, and then let is stay corked for
> as long as you don't have any outstanding requests - ie you uncork only
> when you don't have anything pending any more.

so after i present each reply, i'm checking to see if there is another
request and if there is not i have to uncork to get the residual data to
flow.

> (The reason you want to uncork at all, is to obviously let the partial
> packets out when you don't know if you'll write anything more in the near
> future. Uncorking is important too.
> 
> Basically, TCP_CORK is useful whenever the server knows the patterns of
> its bulk transfers. Which is just about 100% of the time with any kind of
> file serving.

But does the server know the arrival pattern (well time distribution) of
requests? It seems that one depends on a client being helpful about
getting requests to the server in groups otherwise one is corking and
uncorking the connection. If they are strung-out, the server would be in
this loop of 

0) check for request
1) read request
2) dribble part of the reply
3) dribble more of the reply
4) check another request? no, uncork, go to 0 yes, go to 1

Seems that with CORK, one has to be sure to uncork when the sum of the
send is not an integral multiple of the MSS, but with the other
behaviour, any send > MSS will have no delay, even its fractional part. 

certainly, i see by your examples how cork can make life easier on the
developer - they can putc() the reply if they want. for a persistent
http connection, there would be the cork and uncork each time, for a
pipelined connection, it is basically a race - how does the client
present requests to the connection, what are the speeds of that
connection relative to the speed of the server getting replies into the
socket that sort of thing.

rick jones

btw, to help further show my ignorance :) have pipelined requests
started being used by browsers above and beyond persistent connections? 

-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
