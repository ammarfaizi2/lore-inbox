Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbTEPWLv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTEPWLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:11:51 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:23435 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S262676AbTEPWLr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:11:47 -0400
Date: Fri, 16 May 2003 15:24:36 -0700
From: Simon Kirby <sim@netnation.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Route cache performance under stress
Message-ID: <20030516222436.GA6620@netnation.com>
References: <8765pshpd4.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8765pshpd4.fsf@deneb.enyo.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 06:37:43PM +0200, Florian Weimer wrote:

> Please read the following paper:
> 
> <http://www.cs.rice.edu/~scrosby/tr/HashAttack.pdf>
> 
> Then look at the 2.4 route cache implementation.
> 
> Short summary: It is possible to freeze machines with 1 GB of RAM and
> more with a stream of 400 packets per second with carefully chosen
> source addresses.  Not good.

Finally, somebody else has noticed this problem!  Unfortunately, I didn't
see this message until now.

I have been seeing this problem for over a year, and have had the same
problems you have with DoS attacks saturating the CPUs on our routers.

We have two Athlon 1800MP boxes doing routing on our network, and the CPU
saturates under embarrassingly low traffic rates with random source IPs.
We've noticed this a few times with DoS attacks generated internally and
with remote DoS attacks.  I too have had to abuse the PREROUTING chain
(in the mangle table to avoid loading the nat table which would bring in
connection tracking -- grr...I hate the way this works in iptables),
particularly with the MSSQL worm that burst out to the 'net that one
Friday night several few months ago.  Adding a single match udp port,
DROP rule to PREROUTING chain made the load go back down to normal
levels.  The same rule in the INPUT/FORWARD chain had no affect on the
CPU utilization (still saturated).

> The route cache is a DoS bottleneck in general (that's why I started
> looking at it).  You have to apply rate-limits in the PREROUTING
> chain, otherwise a modest packet flood will push the machine off the
> network (even with truly random source addresses, not triggering hash
> collisions).  The route cache partially defeats the purpose of SYN
> cookies, too, because the kernel keeps (transient) state for spoofed
> connection attempts in the route cache.

The idea, I believe, was that the route cache was supposed to stay as a
mostly O(1) overhead and not fall over in any specific cases.  As you
say, however, we also have problems with truly random IPs killing large
boxes.  This same box is capable of routing more than one gigabit of tiny
(64 byte) packets when the source IP is not random (using Tigon3 cards).

Under normal operation, it looks like most load we are seeing is in fact
normal route lookups.  We run BGP peering, and so there is a lot of
routes in the table.  Alexey suggested adding another level of hashing to
the fn_hash_lookup function, but that didn't seem to help very much.  The
last time I was looking at this, I enabled profiling on one router to see
what functions were using the most CPU.  Here are the results (71 days
uptime):

	http://blue.netnation.com/sim/ref/readprofile.r1
	http://blue.netnation.com/sim/ref/readprofile.r1.call_sorted
	http://blue.netnation.com/sim/ref/readprofile.r1.time_sorted

The results of this profile are from mostly normal operation.

I will try playing more with this code and look at your patch and paper.

Thanks,

Simon-
