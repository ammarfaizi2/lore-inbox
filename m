Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSHZVsi>; Mon, 26 Aug 2002 17:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317977AbSHZVsi>; Mon, 26 Aug 2002 17:48:38 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:31207 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S318075AbSHZVsg>; Mon, 26 Aug 2002 17:48:36 -0400
Date: Mon, 26 Aug 2002 17:51:23 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Kelsey Hudson <khudson@compendium.us>
Cc: Bernd Eckenfels <ecki@lina.inka.de>,
       Thunder from the hill <thunder@lightweight.ods.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
Message-ID: <20020826215123.GA22750@alcove.wittsend.com>
Mail-Followup-To: Kelsey Hudson <khudson@compendium.us>,
	Bernd Eckenfels <ecki@lina.inka.de>,
	Thunder from the hill <thunder@lightweight.ods.org>,
	linux-kernel@vger.kernel.org
References: <20020821220313.GA25141@lina.inka.de> <Pine.LNX.4.44.0208261149170.6621-100000@betelgeuse.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208261149170.6621-100000@betelgeuse.compendium-tech.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 11:55:29AM -0700, Kelsey Hudson wrote:
> On Thu, 22 Aug 2002, Bernd Eckenfels wrote:

> > On Wed, Aug 21, 2002 at 03:44:41PM -0600, Thunder from the hill wrote:
> > > I'm getting through with bind9 pretty well, actually.

> > ip6.int? nibbles? reverse byte? ip6.arpa? A6? AAAA? 

> It looks like nibble format and quad-A records are the de-facto standard. 
> I'd expect them to become a finalized standard here shortly. BIND supports 
> all these, however...

	Yes, and no.

	Yes, quad-A and reversed nibbles.  Seems that A6 is rapidly
becoming deprecated (formally deprecated by the IETF, IIRC).  Only thing
is that the 6bone is using .ip6.int for reverse lookup zones and the final
ietf decision fell to go with .ip6.arpa for reverse lookups.  :-(  Most
of the RIRs are now supporting both reverse lookup zones but, if you are
trying to work on the 6Bone, as I am, you are in trouble with the ip6.int
zone since the resolver libraries (at least on RedHat and a couple of
other related distros) are only checking ip6.arpa and not checking ip6.int.
Currently 6bone (3ffe::/16) is broken for ip6.arpa while the production
allocations (2001::/16) are functional for ip6.arpa and the resolver
libraries are only supporting ip6.arpa and not ip6.int.  Therefore,
6Bone is broken for reverse lookups in current distros.

	A STUPID side effect of the ip6.int / ip6.arpa brokeness is
that the "getaddrinfo" call returns the ipv6 address string of the
host in the "ai_canonname" structure element rather than the host name.
Which then makes for some BOGUS hacks (string search for multiple ':' in
"ai_canonname" and replace with hostname if present) if one wants to resolve
an ipv6 host name and display the cannonical name (if the reverse lookup
fails, I would expect to get the host name back, not its address - others
may disagree with me on that point).  I'm fighting with this little
"problem" for the fetchmail ip6 code now.  It's going to result in a
BUTT UGLY hack, but I'm stuck with it.  Personally, I think that code
is broken along with the ip6.int / ip6.arpa dicotomy.  I really don't
think that a canonical name should depend critically on having a reachable
reverse lookup in place.  Think of the mayhem that would take place if
that were true in ipv4 space.  :-/

	My only other annoynance right now is the default ip6 route on my
ipv6 router (RedHat 7.3).  It's not working (or doesn't seem to be)!  I
have a 6bone allocation from Freenet6 (3ffe:b80:c84::/48) with about a
half a dozen SLA subnets and several routers.  If I assign a default route
(::/0) on the main router back down my Freenet6 tunnel, weird things happen.
If I ping the other end of the tunnel from the gateway, my other leaf
systems can access the rest of the ip6 internet (6Bone and production).
If I stop pinging the other end of the tunnel from the gateway, access
fails a minute or two later with an error saying the target network
(whatever I'm trying to reach) can not be reached and the error is being
reported back from the lo interface on the gateway, even though the
actual default route still shows up in the routing table under
"ip -6 route ls".  This also happens on my subnet routers back to my
main gateway as well.

	If, OTOH, I set up a "half default route" of ::/1 (upper bit of
the 128 bit address is zero, which covered both 3ffe::/16 and 2001::/16
and doesn't trip over site local or link locals) on the router it works
perfect!  (Yes, I also have to set up routes on the subnet routers for
the site locals, fce0::/16, to get routed between the subnets as well
when I do this).  So I have to define my ip6 default routes on my ipv6
routers to actually be ::/1 instead of ::/0 to get them to work reliably.
This has been noticed and mentioned by others on the 6bone and freenet6
lists.  Seems to be peculiar to Linux.

	The default routers on the leaf workstations (autoconfigured from
router advertisements) seem to work fine though.  It's just the linux
systems which are being used as ipv6 routers with manually configured
interfaces and running radvd to advertise themselves that seem to get
screwed up.

	Jump ball question for anyone in the know...

	Where do all the strange ipv6 routes like the following come from?

] unreachable 2002:a00::/24 dev lo  metric 1024  error -101 mtu 16436 advmss 16376unreachable 2002:7f00::/24 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
] unreachable 2002:a9fe::/32 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
] unreachable 2002:ac10::/28 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
] unreachable 2002:c0a8::/32 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
] unreachable 2002:e000::/19 dev lo  metric 1024  error -101 mtu 16436 advmss 16376

	(There are piles more)

	These show up on all my systems when I configure the ipv6 interface
but they are not in any configuration files I've been able to find, yet.
Anyone know what they are there for?  Are they hard coded in some
code somewhere?

	Here is what I have for default routes on one of my leaf nodes:

] default via fe80::280:c8ff:feca:6c8e dev eth0  proto kernel  metric 1024  expires 23sec mtu 1500 advmss 1440
] unreachable default dev lo  metric -1  error -101

	Ok...  That first one is the CORRECT one.  I believe that it's that
second one that is causing all the problems on the routers but I don't
know where it is coming from.  Obviously a ::/1 dev * route will override
that ::/0 dev lo route so I understand why the half default route fixes the
problem, even if it is a half ass hack (pun intended).

>  Kelsey Hudson                                       khudson@compendium.us
>  Software Engineer/UNIX Systems Administrator
>  Compendium Technologies, Inc                               (619) 725-0771
> ---------------------------------------------------------------------------

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
