Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136275AbRASVVZ>; Fri, 19 Jan 2001 16:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136586AbRASVVG>; Fri, 19 Jan 2001 16:21:06 -0500
Received: from palrel3.hp.com ([156.153.255.226]:51206 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S136275AbRASVVB>;
	Fri, 19 Jan 2001 16:21:01 -0500
Message-ID: <3A68AFBB.5750B564@cup.hp.com>
Date: Fri, 19 Jan 2001 13:20:59 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <200101192003.XAA25191@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Look: http-1.1, asynchronous one, the first request is sent, but not acked.
> Time to send the second one, but it is blocked by Nagle. If there is no
> third request, the pipe stalls. Seems, this situation will be usual,
> when http-1.1 will start to be used by clients, because of dependencies
> between replys (references) frequently move it to http-1.0 synchronous
> mode, but with some data in flight. See?

The stall takes place if and only if the web server takes longer than
the standalone ACK timer to generate the first bytes of reply. Once the
first bytes of the reply hit the client, the client's second request
will flow.

If the web server takes longer than the standalone ACK timer to generate
the first bytes of the reply, there is no particular value in the second
request having arrived anyway - it will simply sit queued in the
server's stack rather than the client's stack. You could argue that the
server could start serving the second request, but it still has to hold
the reply and keep it queued until the first reply is complete, and I
suspect there is little value in working for that much parallelism here.
Better to have as much queuing in your most distributed resource - the
clients.

Further, even ignoring the issue of standalone acks, is there really
much value in the second request flowing to the server before the first
byte of the reply has hit? I would think that the parallelism in the
server is going to be among all the different sources of request, not
fromwithin a given source of requests. 

Also, if the browser is indeed going to do pipelined requests, and
getting the requests to the server as very quickly as possible was
indeed required because the requests could be started in parallel (just
how likely that is I have no idea) i would have thought that it would
(could) want go through the page, gather-up all the URLs from the given
server, and then dump all those requests into the connection at once
(modulo various folks dislike of sendmsg and writev  :). We are in this
instance at least talking about purpose coded software anyhow and not a
random CGI dribbler. In that sense, the "logically associated data" are
all the server's URL's from that page. Yes, this paragraph is in slight
contradiction with my statement above about keeping things queued in the
client :)

rick jones
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
