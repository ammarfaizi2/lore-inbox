Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSLMEjg>; Thu, 12 Dec 2002 23:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSLMEjg>; Thu, 12 Dec 2002 23:39:36 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59879 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261349AbSLMEjT>;
	Thu, 12 Dec 2002 23:39:19 -0500
Message-ID: <3DF965E4.95DEA1F9@us.ibm.com>
Date: Thu, 12 Dec 2002 20:45:24 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andreani Stefano <stefano.andreani.ap@h3g.it>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
References: <047ACC5B9A00D741927A4A32E7D01B73D66178@RMEXC01.h3g.it> <1039727809.22174.38.camel@irongate.swansea.linux.org.uk> <3DF94565.2C582DE2@us.ibm.com> <20021213033928.GK32122@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:

> > Assuming you are on a local lan, your round trip
> > times are going to be much less than 200 ms, and
> > so using the TCP_RTO_MIN of 200ms ("The algorithm
> > ensures that the rto cant go below that").
> 
>   The RTO steps in only when there is a need to RETRANSMIT.
>   For that reason, it makes no sense to place its start
>   any shorter.

Not sure I understood your point clearly here - that things
are going to be broken, so dont kick it off too early?

For the most part, dropped packets are recovered by fast 
retransmit getting triggered. So when the retransmission 
timer goes off, I'd agree things are in all likelihood 
messed up. BUT..the default TCP_TIMEOUT_INIT = 300ms, which
is what the timeout calculation engine is fed to begin
with. After that, the actual measured round trip times
smooth out and help make the retransmit timeout accurate.

TCP_RTO_MIN is the lower bound for the rto. On fast
lans, though, if measured round trip times are say .01ms, 
and our MIN is 200ms, thats a thousand times the value - which 
means that we are reacting to events  too far back in time
on the fast lan scale.  If there was congestion
way back then, does that reflect conditions now?? 


> > So the minimum total time to time out a tcp connection
> > (barring application close) would be ~13 minutes in the
> > default case and 66 seconds with a modified TCP_RTO_MAX
> > of 6*HZ.
> 
>   You can have this by doing carefull non-blocking socket
>   coding, and protocol traffic monitoring along with
>   protocol level keepalive ping-pong packets to have
>   something flying around  (like NJE ping-pong, not
>   that every IBM person knows what that is/was..)

Er, this IBMer is unfortunately rather underinformed on that
subject ;) I'll look it up, but I can guestimate what you are 
referring to..True, but for the most part, getting every 
application to be performant and knowledgeable about 
network conditions and program accordingly is hard :). And 
if by protocol level you mean transport level, then we're back to 
altering the protocol. Wouldnt pingpongs just add to the
traffic under all conditions (I admit this is a rather lame point :)).

>   We try not to kill overloaded network routers while they
>   are trying to compensate some line breakage and doing
>   large-scale network topology re-routing.

Good point! :). I have little experience with Internet router traffic
snarls, and am certainly not arguing for a major alteration to
TCP exponential backoff :). See below..(the environment I was
thinking of..)

> > Particularly since we also retransmit 15 times, cant we conclude
> > "Its dead, Jim" earlier??
> 
>   No.  I have had LAN spanning-tree flaps taking 60 seconds
>   (actually a bit over 30 seconds), and years ago Linux's
>   TCP code timed out in that.  It was most annoying to
>   use some remote system thru such a network...

Urgh. Bletch. OK. But minor nit here - how often does that 
happen? Whats the right thing to do in that situation?
Which situation should we optimize our settings for?
I accept, though, that we need that kind of time frame..

>   When things _fail_ in the lan, what would be sensible value ?
>   How long will such abnormality last ?

Hmm, good questions, but ones I'm going to handwave at :).

One, my assumption that the ratio of the (say) ave expected
round trip times to the rto value should be around the same -
i.e why not be as conservative/aggressive as the normal default:

our default init rto is 300, so currently we're going to timeout
on anything thats a 100ms over the min of 200. that is far
less conservative than setting an rto of 200 when your round
trip time is a thousand or 10,000 times less..does that make sense?
 
The other assumption that I'm operating under is that when
things fail talking to a directly attached host - its because
that host has died (even if its only the app or the NIC, whatever).
i.e. the situation is that your connection is going to break,
except you are going to futilely retransmit 15 times and
wait an interminably long time before you do..hence the 
advantage of learning whats happening quickly..
 
>   In overload, resending quickly won't help a bit, just raise
>   the backoff (and prolong overload.)

See above..

>   Loosing a packet sometimes, and that way needing to retransmit
>   is the gray area I can't define quickly.  If it is rare, it
>   really does not matter.  If it happens often, there could be
>   so serious trouble that having quicker retransmit will only
>   aggreviate the trouble more.

Thats true..

>   You are looking for "STP" perhaps ?
>   It has a feature of waking all streams retransmits, in between
>   particular machines, when at least one STP frame travels in between
>   the hosts.
> 
>   I can't find it now from my RFC collection.  Odd at that..
>   Neither as a draft.  has it been abandoned ?

Learn something new every day :). Thanks for the ptr. I'll
look it up..

> > It would be wonderful if we could tune TCP on a per-interface or a
> > per-route basis (everything public, for a start, considered the
> > internet, and non-routable networks (10, etc), could be configured
> > suitably for its environment. (TCP over private LAN - rfc?). Trusting
> > users would be a big issue..
> >
> > Any thoughts? How stupid is this? Old hat??
> 
>   More and more of STP ..

thanks,
Nivedita
