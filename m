Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbTH3QL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 12:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTH3QL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 12:11:27 -0400
Received: from [213.39.233.138] ([213.39.233.138]:23016 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261904AbTH3QKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 12:10:42 -0400
Date: Sat, 30 Aug 2003 18:10:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030830161029.GA4632@wohnheim.fh-wedel.de>
References: <20030830012949.GA23789@work.bitmover.com> <20030830150311.GB23789@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030830150311.GB23789@work.bitmover.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 August 2003 08:03:11 -0700, Larry McVoy wrote:
> 
> Many people have sent me mail saying that we should be using traffic
> shaping to fix this problem.  We are using it and we can't seem to make
> it work.  Our theory is that we have a network like
> 
>  ----- [ ISP ] ====== internet ======== [ ISP ] ----
> 
> wherein "-" means our skinny T1 or DSL and "=" means some fat internet 
> connection on the backbone.  
> 
> We can shape all we want on our ends but if the internet is blasting us
> then our skinny pipe gets full and our shaping doesn't work.  We really
> need to have the ISP do the shaping so they can squelch the traffic 
> before it gets to our pipe.
> 
> If there is someone out there who (a) is running VOIP over the public net
> to a pile of different end points (T1 on both ends tends to work, T1 to DSL
> or cable modem tends to get harder) and (b) has figured out traffic shaping
> that works I'd love to know about it.  

By principle, you can only control your side of the wire.  Unless your
ISP does some decent shaping for you or allows you to place a machine
at the other end to do it, you are at the internets mercy.  If people
with enough bandwidth want to DOS you, they can.

For well behaved traffic you have some limited control over the
incoming traffic through your responses, so QoS should work in theory,
but setting it up is still very close to black magic.

> But just saying QoS/wondershaper doesn't help much (though the thought is
> appreciated), we've tried that already.

Wondershaper was magically configured once and works for everyone that
has similar needs like the original magician.  Plus, this magician had
a simple task, as the sending side is the bottleneck and that is the
side he has control over.  So unless you have a regular DSL line...

What you really need might not even exist in the kernel yet.  The last
couple of times I've tried setting it up and read the code, things
were just not adequate.

---<deeper technical stuff follows>---

In order to control incoming traffic, it is easiest to look at tcp.
udp can work similarly, but it doesn't have to.  To throttle the
stream of tcp packets, you could simply through away the acks and the
sending side will reduce it's speed.  So you have to measure one
stream and control a related but different one.  Maybe this is
possible, not sure.

Second, you usually don't want to through away the acks, as packets
would be retransmitted then.  This reduces the effective bandwidth and
limited bandwidth was the problem in the first place.  So we have to
delay them enough to slow things down, but not beyond the timeout.

Third, there is the problem transition from continuous streams to
discrete packets, when bandwidth is low.  It doesn't take a huge
amount of large packets to create enough latency for your sad VOIP.

And fourth, the possibility of resonance frequency.  If measurement
and/or shaping intervals are too long and match nicely to the travel
time to one of your peers, you are back at point three.

Overall, it is possible to do some decent traffic shaping, but it is
far from being simple.  And it might even be completely impossible, at
least in your case, with the code that is in the kernel today, be it
Linux or some BSD.

Jörn

PS: If anyone can prove how stupid I am and how simple QoS is, please
do!  Seriously!

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
