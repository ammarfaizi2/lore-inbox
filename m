Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSLMDbp>; Thu, 12 Dec 2002 22:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbSLMDbo>; Thu, 12 Dec 2002 22:31:44 -0500
Received: from mail.zmailer.org ([62.240.94.4]:40147 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S261205AbSLMDbk>;
	Thu, 12 Dec 2002 22:31:40 -0500
Date: Fri, 13 Dec 2002 05:39:28 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andreani Stefano <stefano.andreani.ap@h3g.it>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
Message-ID: <20021213033928.GK32122@mea-ext.zmailer.org>
References: <047ACC5B9A00D741927A4A32E7D01B73D66178@RMEXC01.h3g.it> <1039727809.22174.38.camel@irongate.swansea.linux.org.uk> <3DF94565.2C582DE2@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF94565.2C582DE2@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Dec 12, 2002 at 06:26:45PM -0800, Nivedita Singhvi wrote:
> Alan Cox wrote:
> > The default is too short ?
> 
> Short?? :). On the contrary...
> 
> here's what it would roughly look like:
> 
> assuming HZ = 100 (2.4)
> 
> tcp_retries2 = 15 (default) /* The # of retransmits */
> 
> TCP_RTO_MAX = 120*HZ = 120 seconds = 120000ms
> TCP_RTO_MAX2 = 6*HZ = 6 seconds = 6000 ms /* modified value */
> 
> TCP_RTO_MIN = HZ/5 = 200ms
> 
> Assuming you are on a local lan, your round trip
> times are going to be much less than 200 ms, and
> so using the TCP_RTO_MIN of 200ms ("The algorithm 
> ensures that the rto cant go below that").

  The RTO steps in only when there is a need to RETRANSMIT.
  For that reason, it makes no sense to place its start
  any shorter.

> At each retransmit, TCP backs off exponentially:
> 
> Retransmission #	Default rto (ms)	With TCP_RTO_MAX(2) (ms)
> 1			200			200
...
> 14			120000			6000
> 15			120000			6000
> 
> Total time = 		804.6 seconds		66.2 seconds
> 			13.4 minutes
> 		
> So the minimum total time to time out a tcp connection 
> (barring application close) would be ~13 minutes in the
> default case and 66 seconds with a modified TCP_RTO_MAX
> of 6*HZ.

  You can have this by doing carefull non-blocking socket
  coding, and protocol traffic monitoring along with
  protocol level keepalive ping-pong packets to have
  something flying around  (like NJE ping-pong, not
  that every IBM person knows what that is/was..)

> I can see the argument for lowering both, the TCP_RTO_MAX
> and the TCP_RTO_MIN default values.

  I don't.

> I just did a bunch of testing over satellite, and round trip
> times were of the order of 850ms ~ 4000ms.  
> 
> The max retransmission timeout of 120 seconds is two orders of
> magnitude larger than really the slowest round trip times 
> probably experienced on this planet..(Are we trying to make this
> work to the moon and back? Surely NASA has its own code??)

  We try not to kill overloaded network routers while they
  are trying to compensate some line breakage and doing
  large-scale network topology re-routing.

> Particularly since we also retransmit 15 times, cant we conclude
> "Its dead, Jim" earlier??

  No.  I have had LAN spanning-tree flaps taking 60 seconds
  (actually a bit over 30 seconds), and years ago Linux's
  TCP code timed out in that.  It was most annoying to
  use some remote system thru such a network...

> 200ms is for the minimum retransmission timeout is roughly a
> thousand times, if not more, the round trip time on a 
> fast lan. Since the algorithm is adaptive (a function of the
> measured round trip times), what would be the negative
> repercussions of lowering this? 

  When things _fail_ in the lan, what would be sensible value ?
  How long will such abnormality last ?

  In overload, resending quickly won't help a bit, just raise
  the backoff (and prolong overload.)

  Loosing a packet sometimes, and that way needing to retransmit
  is the gray area I can't define quickly.  If it is rare, it
  really does not matter.  If it happens often, there could be
  so serious trouble that having quicker retransmit will only
  aggreviate the trouble more.

> It may not be a good idea to make either tunable, but what about
> the default init rto value, TCP_TIMEOUT_INIT, since that would allow a 
> starting point of something close to a suitable value? 
> 
> The problem with all of the above is that the TCP engine is
> global and undifferentiated, and tuning for at least these parameters
> is the same regardless of the interface or route or environment..

  You are looking for "STP" perhaps ?
  It has a feature of waking all streams retransmits, in between 
  particular machines, when at least one STP frame travels in between
  the hosts.

  I can't find it now from my RFC collection.  Odd at that..
  Neither as a draft.  has it been abandoned ?

> Yes, we should and want to meet the standards for the internet, and
> behave in a network friendly fashion. But all networks != internet.
> 
> I'm thinking for eg of a dedicated fast gigabit or better connection 
> between a tier 2 webserver and a backend database, for example, that 
> has every need of performance and few of standards compliance..
> 
> It would be wonderful if we could tune TCP on a per-interface or a 
> per-route basis (everything public, for a start, considered the 
> internet, and non-routable networks (10, etc), could be configured 
> suitably for its environment. (TCP over private LAN - rfc?). Trusting
> users would be a big issue..
> 
> Any thoughts? How stupid is this? Old hat?? 

  More and more of STP ..

> thanks,
> Nivedita

/Matti Aarnio
