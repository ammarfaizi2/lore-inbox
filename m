Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136373AbRD2VRO>; Sun, 29 Apr 2001 17:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136374AbRD2VRG>; Sun, 29 Apr 2001 17:17:06 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:63751 "HELO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S136373AbRD2VQy> convert rfc822-to-8bit; Sun, 29 Apr 2001 17:16:54 -0400
From: jg@pa.dec.com (Jim Gettys)
Date: Sun, 29 Apr 2001 14:16:43 -0700 (PDT)
Message-Id: <200104292116.f3TLGhu07016@pachyderm.pa.dec.com>
X-Mailer: Pachyderm (client pachyderm.pa-x.dec.com, user jg)
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org>
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "put the time into a magic location in shared memory" goes back, as
far as I know, to Bob Scheifler or myself for the X Window System, sometime
around 1984 or 1985: we put it into a page of shared memory where we used
a circular buffer scheme to put input events (keyboard/mice), so that
we could avoid the read system call overhead to get these events (and
more importantly, check between each request if there was input to
process).  I don't think we ever claimed it was novel, just that we did
it that way (I'd have to ask Bob if he had heard of that before we did
it).  We put it into the same piece of memory we put the circular event
buffer, avoiding both the get-time-of day calls, but also the much more
expensive reads that would have been required (we put the events into a
circular buffer, with the kernel only updating one value, and user space
updating the other value defining the circular buffer).

In X, it is important for interactivity to get input events and send them
to clients ASAP: just note the effect of Keith Packard's recent implementation
of "silken mouse", where signals are used to deliver events to the X server.
This finally has made mouse tracking (done in user space on Linux; generally
done by kernel drivers on most UNIX boxes) what we were getting on 1 mip machines
under load (Keith has also done more than this with his new internal X
scheduler, which prevents clients from monopolizing the X server anywhere
like the old implementation).

This shared memory technique is very powerful to allow a client application to know if
it needs to do a system call, and is very useful for high performance servers
(like X), where a system call is way too expensive.

I've certainly mentioned this technique in the past in the Web community
(but HTTP servers are processing requests about 1/100-1/1000 the rate of
an X server, which gets into the millions of requests/second on current machines.

So if you want to get user space to really go fast, sometimes you resort
to such trickery....  I think the technique has real value: the interesting
question is should there be general kernel facilities to make this easy
(we did it via ugly hacks on VAX and MIPS boxes) for kernel facilities
to provide.

"X is an exercise in avoiding system calls".  I think I said this around
1984-1985.  
				- Jim

--
Jim Gettys
Technology and Corporate Development
Compaq Computer Corporation
jg@pa.dec.com

