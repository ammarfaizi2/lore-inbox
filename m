Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSE0TwA>; Mon, 27 May 2002 15:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSE0Tv7>; Mon, 27 May 2002 15:51:59 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:3091 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316750AbSE0Tv6>;
	Mon, 27 May 2002 15:51:58 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205271951.g4RJpjQ14540@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <200205271304.OAA06906@gw.chygwyn.com> from Steven Whitehouse at
 "May 27, 2002 02:04:48 pm"
To: Steve Whitehouse <Steve@ChyGwyn.com>
Date: Mon, 27 May 2002 21:51:45 +0200 (MET DST)
Cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven Whitehouse wrote:"
> > That is again what I do do in ENBD.
> > 
> Ok. Then I think nbd will shortly start to look more like enbd then :-)

I did send linus a kernel patch for ENBD aimed at 2.5.7. The same patch
works fine in 2.5.12. It's in the distribution package, which should be
easy to find on freshmeat, if anyone is interested.

ENBD has many more "features" than kernel NBD. For one thing, it does
remote ioctls.

> > You end up with some latency, and that's all.
> > 
> Yes, and with the new scheduling code that Ingo wrote recently, that
> should be even less than it used to be I guess.

I was very enthusiastic about the new per-device io locks, but I
haven't noticed much practical benefit. OTOH I'm not doing heavy
testing under 2.5. I intend to live.

> > People are doing large studies of performance over ENBD over
> > various media, with various kernels. I should be able to tell you more
> > one day soon! At the moment I don't see any obvious way-to-go
> > indicators in the results.
> > 
> That sounds very interesting. I'm certainly keen to see the results when
> they are available.

At the moment they show large effects from the VMS on the server side.
It seems that writing to the server drives the server side into a
regime where the disk i/o and the network compete, and they start
pulsing on-off at periods of about 7s. The people at heidelberg
are getting very good studies out.  The older VMS does not seem 
to have this effect, possibly because it uses predictive control
(using the rate of use of buffers as a dataum)?

> > I'm not sure that I see the difficulty. Yes, to answer that question,
> > ENBD does use non-blocking sockets, and does run select on them to
> > detect what happens. But that's more or less just so it can detect
> > errors. I don't think there'd be any significant harm accruing from
> > using blocking sockets.
> > 
> I should have really explained that a bit more. I was thinking about another
> bug which I fixed in nbd before which was related to the network buffer
> queue sizes and certain workloads. It was possible to get into a state

That sounds interesting.

> where both client and server were waiting for each other to process
> requests (and hence reduce the outstanding queue length) before they
> would continue.

I have long suspected that if the socket were to wait for fragments
to build up into a packet size, then it could deadlock. So I try 
and use "write at once". But it looks to me as though there are
probably some very subtle deadlock opportunities left.

> If you use blocking sockets in a loop along the lines of:
> 
>  while(1) {
> 	if (request_waiting)
> 		write_a_request(); /* may block until whole request sent */

I think that's the important bit .. you want to send as send can, bit
by bit.

> 	if (receive_queue_size >= sizeof(an nbd header))
> 		read_a_request(); /* may block until whole request read */

Yes, I also am worried about something here, though I'm not sure quite
what. This kind of deadlock is in theory cured by ENBD's "async mode",
which is a mode in which it acks the kernel before receiving an ack
from the net. It's for situations where you trust the net completely.

There's no point in running a separate receive thread here, because the other
side won't reply until it's got everything we sent.

> 	if (nothing_is_happening)
> 		wait_for_something_to_happen();
>  }
> 
> then I think the same problem applies (assuming that the server uses a similar
> loop to the client and that the relative speeds of the client and server are
> such that it allows getting in such a state).

It's not completely clear what the deadlock is over. Buffers, I suppose?
We need buffers to send, but can't free any before receiving.

> After reading the run_task_queue() source, I agree that we shouldn't block
> in the request function. I'm not completely convinced that its not ok under
> any circumstances - it might be fine when we know it will only be for a
> very short period, but it does seem that there is one reason that we must
> never block in the request function which is to wait for memory.

Somebody like Jens Axboe should be able to say for certain.


Peter
