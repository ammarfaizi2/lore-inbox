Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132794AbRASDDW>; Thu, 18 Jan 2001 22:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135909AbRASDDO>; Thu, 18 Jan 2001 22:03:14 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:12810 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S132794AbRASDDD>; Thu, 18 Jan 2001 22:03:03 -0500
Date: Thu, 18 Jan 2001 19:03:02 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Rick Jones <raj@cup.hp.com>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.30.0101181853110.16292-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

btw -- i'd like to point out something which some folks are aware of
already.

pipelining was only part of the answer to fixing HTTP/1.0 network
performance problems.  the real answer is a multiplexing protocol such as
WebMUX <http://www.w3.org/Protocols/MUX/>.  a MUX protocol is more general
than pipelining and keep-alive.

consider a typical web page with a half-dozen embedded images.  while a
single pipelined HTTP/1.1 connection may have the fastest latency to
loading the final byte of the page + images (see the pipelining paper i
referenced below); it doesn't have the best "useable latency".

"useable latency" is intentionally in quotes because it is a subjective
issue of interface design -- a page which loads the critical images early,
such as the first few passes of navigation images is more "useable" than a
page which loads such navigation tools late.  this is the reason
netscape/ie open 4 or more TCP connections to request images in parallel.

incidentally HTML is lacking a UI hint to tell the browser which images
have the highest priority.  (i believe the pipelining paper talks about
this, so there may be proposals for fixing this already.)

at any rate, with a MUX protocol you can get the benefits of pipelining
with the benefits of opening 4 TCP sessions at once.

WebMUX will probably be where we see more benefit of TCP_CORK/MSG_MORE
than we presently do from pipelining.  but we're talking years still...
HTTP/ng hasn't been finalised (because they're being pretty ambitious);
and nobody has decided to just forge forward and layer HTTP/1.1 on top of
WebMUX yet.  (the subversive in me wants to see WebMUX patches for apache,
squid, and mozilla ;)

-dean

On Thu, 18 Jan 2001, dean gaudet wrote:

> On Wed, 17 Jan 2001, Rick Jones wrote:
>
> > > actually the problem isn't nagle...  nagle needs to be turned off for
> > > efficient servers anyhow.
> >
> > i'm not sure I follow that. could you expand on that a bit?
>
> the problem which caused us to disable nagle in apache is documented in
> this paper <http://www.isi.edu/~johnh/PAPERS/Heidemann97a.html>.  mind you
> i should personally revisit the paper after all these years so that i can
> reconsider its implications in the context of pipelining and webmux.
>
> > on the topic of pipelining - do the pipelined requests tend to be send
> > or arrive together?
>
> i'm pretty sure the actual use of pipelining is pretty disappointing.
> the work i did in apache preceded the widespread use of HTTP/1.1 and we
> believed it was important to do the "most efficient thing" right out the
> door -- so as to encourage the use of pipelining by proxies in particular.
> the w3c folks, henrik frystyk nielsen in particular, provided most of the
> documentation for this.  their paper is a good read:
> <http://www.w3.org/Protocols/HTTP/Performance/Pipeline.html>
>
> > > (the heuristic i use in apache to decide if i need to flush responses in a
> > > pipeline is to look if there are any more requests to read first, and if
> > > there are none then i flush before blocking waiting for new requests.)
> >
> > how often to you find yourself flushing the little bits anyhow?
>
> i'm not aware yet of any study in the field.  and i'm out of touch enough
> with the clients that i don't know if new netscape or IE have finally
> begun to use pipelining (they hadn't as of 1998).
>
> -dean
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
