Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbSLMCYL>; Thu, 12 Dec 2002 21:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSLMCYK>; Thu, 12 Dec 2002 21:24:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:61681 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264984AbSLMCYH>; Thu, 12 Dec 2002 21:24:07 -0500
Message-ID: <3DF94565.2C582DE2@us.ibm.com>
Date: Thu, 12 Dec 2002 18:26:45 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andreani Stefano <stefano.andreani.ap@h3g.it>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
References: <047ACC5B9A00D741927A4A32E7D01B73D66178@RMEXC01.h3g.it> <1039727809.22174.38.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Thu, 2002-12-12 at 20:18, Andreani Stefano wrote:
> > Never say never ;-)
> > I need to change it now as a temporary workaround for a 
> > problem in the UMTS core network of my company. But I think 
> > there could be thousands of situations where a fine tuning 
> > of this TCP parameter could be useful.
> >
> The default is too short ?

Short?? :). On the contrary...

[I apologize for the length of this note, it became a river ]

here's what it would roughly look like:

assuming HZ = 100 (2.4)

tcp_retries2 = 15 (default) /* The # of retransmits */

TCP_RTO_MAX = 120*HZ = 120 seconds = 120000ms
TCP_RTO_MAX2 = 6*HZ = 6 seconds = 6000 ms /* modified value */

TCP_RTO_MIN = HZ/5 = 200ms

Assuming you are on a local lan, your round trip
times are going to be much less than 200 ms, and
so using the TCP_RTO_MIN of 200ms ("The algorithm 
ensures that the rto cant go below that").

At each retransmit, TCP backs off exponentially:

Retransmission #	Default rto (ms)	With TCP_RTO_MAX(2) (ms)
1			200			200
2			400			400
3			800			800
4			1600			1600
5			3200			3200
6			6400			6000
7			12800			6000
8			25600			6000
9			51200			6000
10			102400			6000 
11			120000			6000
12			120000			6000
13			120000			6000
14			120000			6000
15			120000			6000

Total time = 		804.6 seconds		66.2 seconds
			13.4 minutes
		
So the minimum total time to time out a tcp connection 
(barring application close) would be ~13 minutes in the
default case and 66 seconds with a modified TCP_RTO_MAX
of 6*HZ.

I can see the argument for lowering both, the TCP_RTO_MAX
and the TCP_RTO_MIN default values.

I just did a bunch of testing over satellite, and round trip
times were of the order of 850ms ~ 4000ms.  

The max retransmission timeout of 120 seconds is two orders of
magnitude larger than really the slowest round trip times 
probably experienced on this planet..(Are we trying to make this
work to the moon and back? Surely NASA has its own code??)

Particularly since we also retransmit 15 times, cant we conclude
"Its dead, Jim" earlier??

200ms is for the minimum retransmission timeout is roughly a
thousand times, if not more, the round trip time on a 
fast lan. Since the algorithm is adaptive (a function of the
measured round trip times), what would be the negative
repercussions of lowering this? 

It may not be a good idea to make either tunable, but what about
the default init rto value, TCP_TIMEOUT_INIT, since that would allow a 
starting point of something close to a suitable value? 

The problem with all of the above is that the TCP engine is
global and undifferentiated, and tuning for at least these parameters
is the same regardless of the interface or route or environment..

Yes, we should and want to meet the standards for the internet, and
behave in a network friendly fashion. But all networks != internet.

I'm thinking for eg of a dedicated fast gigabit or better connection 
between a tier 2 webserver and a backend database, for example, that 
has every need of performance and few of standards compliance..

It would be wonderful if we could tune TCP on a per-interface or a 
per-route basis (everything public, for a start, considered the 
internet, and non-routable networks (10, etc), could be configured 
suitably for its environment. (TCP over private LAN - rfc?). Trusting
users would be a big issue..

Any thoughts? How stupid is this? Old hat?? 

thanks,
Nivedita
