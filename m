Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316416AbSEOPrR>; Wed, 15 May 2002 11:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316421AbSEOPrQ>; Wed, 15 May 2002 11:47:16 -0400
Received: from air-2.osdl.org ([65.201.151.6]:19078 "EHLO
	wookie-laptop.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S316416AbSEOPrP>; Wed, 15 May 2002 11:47:15 -0400
Subject: Re: InfiniBand BOF @ LSM - topics of interest
From: "Timothy D. Witham" <wookie@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tony.P.Lee@nokia.com, lmb@suse.de, woody@co.intel.com,
        linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
In-Reply-To: <E177mBK-0000gT-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 May 2002 08:45:36 -0700
Message-Id: <1021477536.2372.117.camel@wookie-laptop.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-14 at 16:58, Alan Cox wrote:
> > I like to see user application such as VNC, SAMBA build directly
> > on top of IB API.  I have couple of IB cards that can 
> > send 10k 32KBytes message (320MB of data) every ~1 second over 
> > 1x link with only <7% CPU usage (single CPU xeon 700MHz).  
> > I was very impressed.  
> > 
> > Go thru the socket layer API would just slow thing down.
> 
> Thats an assumption that is actually historically not a very good one to
> make. There are fundamental things that most of the "no network layer"
> people tend to forget
> 
> 1.	Van Jacobson saturated 10Mbit ethernet with a Sun 3/50
> 2.	SGI saturated HIPPI with MIPS processors that are at best comparable
> 	to the lowest end wince PDAs
> 3.	Having no network layer in almost every case is tied to the belief
> 	that bandwidth is infinite and you need to congestion control
> 
 First I want to say that the average person using the system the
socket interface with the underlying network stack is the best
way to go. IMHO
 
But if the issue isn't throughput and if the application requires
some items to have low latency.  The size of the network stack can
have an adverse effect on the overall performance of the system.  A
good example is in a Distributed Lock Manager (DLM).  In this case
the round trip including the software stack limits the number of
locks per second that can occur. 

  So if we can fit everything that we need into a 64 byte IB packet
for the imaginary application that would take 256 nsec to transmit
to the other system. (2.5 Gb/sec link) If you assume zero turn around
time you get 512 nsec as the lowest lock request/grant time possible
which puts you in the range of doing a little under 980,000
lock/unlock operations per second on a single lock and of course when
you add the software to actually process the packet the number of
lock/unlock operations per second will always be below that in the real 
world.  When you compare this to a modern processors ability to
do lock/unlocks this is really a small number of lock/unlock 
operations per second. 

So the ability to scarf that packet into the application and respond
is the hard issue to solve in scalability.

Tim

> In a network congestion based collapse is spectacularly bad. Some of the
> internet old hands can probably tell you the horror stories of the period
> the whole internet backbone basically did that until they got their research
> right. Nagle's tinygram congestion avoidance work took Ford's network usage
> down by I believe the paper quoted 90%.
> 
> The socket API is very efficient. TCP is extremely efficient in the service
> it provides. IB can support large messages, which massively ups the throughput.
> 
> Let me ask you a much more important question 
> 
> Can you send achieve 90% efficiency on a 90% utilized fabric with multiple
> nodes and multiple hops ? If you can't then you are not talking about a 
> network you are talking about a benchmark.
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

