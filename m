Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319067AbSH2CCD>; Wed, 28 Aug 2002 22:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319068AbSH2CCD>; Wed, 28 Aug 2002 22:02:03 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:45733 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S319067AbSH2CCB>; Wed, 28 Aug 2002 22:02:01 -0400
Date: Wed, 28 Aug 2002 22:05:01 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
Message-ID: <20020829020501.GA21384@alcove.wittsend.com>
Mail-Followup-To: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>,
	linux-kernel@vger.kernel.org
References: <20020827160722.GA13412@alcove.wittsend.com> <E17k8H8-0003Le-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17k8H8-0003Le-00@sites.inka.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 09:14:46PM +0200, Bernd Eckenfels wrote:
> In article <20020827160722.GA13412@alcove.wittsend.com> you wrote:
> >        It's ignoring something because it's assuming the user knows
> > what he's doing and not wanting it to do that?  Does not compute.  

> well, it was not my idea, and i dont think I fully understand all that Scope
> stuff in IPv6, but I wanted to say:

> The kernel is asuming, that a gateway (ie forward=1) is administrated by a
> experienced admin, who knows how to set up all those special V6 prefixes,
> but wants to defend internet from admins who do not know.

> for a single hoomed host a default route does no harm, compared to a gateway
> with wrong site or lionk local scope prefix routes.

	Actually, I realized some time ago that this sillyness over
the ::/0 default route may have been a kludge to deal with limiting
the routing range of the site locals and link locals.  Obviously, you
can enforce limiting link locals to the local subnet by not providing
routes for them through any routers and limit site locals by not providing
routes for them through any border routers.  The way you described it
this time merely confirmed my long standing suspicion in that regard.
I'm not sure I wouldn't prefer to have that safety check burried deeper,
though, incase some loser DOES define a router for f000::/4 out
somewhere.  Leaving site-local and link-local policies to the whims
of the routing tables and statics routes may work but just seems like
the whole 10-net deal all over again.

	This all does raise another question, though.  Why don't link local
addresses work...  Link local scoped addresses should be valid and work
between hosts on the same "link" or subnet (colision zone, flat network,
whatever you want to call it).

	Observe when I "ping6" the same host on the global, site local,
and link local addresses.  I'm pinging my system "wittsend" from my
system "alcove" which are both on the same subnet or link...

	First the global scope address:

] [root@alcove mhw]# ping6 -c 2 3ffe:b80:c84:8200:280:c8ff:fecf:bf06
] PING 3ffe:b80:c84:8200:280:c8ff:fecf:bf06(3ffe:b80:c84:8200:280:c8ff:fecf:bf06) from 3ffe:b80:c84:8200:2a0:24ff:feda:d2f3 : 56 data bytes
] 64 bytes from 3ffe:b80:c84:8200:280:c8ff:fecf:bf06: icmp_seq=1 ttl=64 time=0.406 ms
] 64 bytes from 3ffe:b80:c84:8200:280:c8ff:fecf:bf06: icmp_seq=2 ttl=64 time=0.367 ms
] 
] --- 3ffe:b80:c84:8200:280:c8ff:fecf:bf06 ping statistics ---
] 2 packets transmitted, 2 received, 0% loss, time 1012ms
] rtt min/avg/max/mdev = 0.367/0.386/0.406/0.027 ms

	Now the site local scope address:

] [root@alcove mhw]# ping6 -c 2 fec0::8200:280:c8ff:fecf:bf06
] PING fec0::8200:280:c8ff:fecf:bf06(fec0::8200:280:c8ff:fecf:bf06) from fec0::8200:2a0:24ff:feda:d2f3 : 56 data bytes
] 64 bytes from fec0::8200:280:c8ff:fecf:bf06: icmp_seq=1 ttl=64 time=0.812 ms
] 64 bytes from fec0::8200:280:c8ff:fecf:bf06: icmp_seq=2 ttl=64 time=0.401 ms
] 
] --- fec0::8200:280:c8ff:fecf:bf06 ping statistics ---
] 2 packets transmitted, 2 received, 0% loss, time 1009ms
] rtt min/avg/max/mdev = 0.401/0.606/0.812/0.206 ms

	Now the link local scope address:

] [root@alcove mhw]# ping6 -c 2 fe80::8200:280:c8ff:fecf:bf06
] connect: Invalid argument

	Opps...

	Ok...  So why did I get "Invalid arguement" on the link local
address?  Here is what is on the other system, "wittsend", interface...

] [mhw@wittsend mhw]$ /sbin/ifconfig eth1
] eth1      Link encap:Ethernet  HWaddr 00:80:C8:CF:BF:06  
]           inet addr:130.205.0.3  Bcast:130.205.0.255  Mask:255.255.255.0
]           inet6 addr: fec0::8200:280:c8ff:fecf:bf06/64 Scope:Site
]           inet6 addr: fe80::280:c8ff:fecf:bf06/10 Scope:Link
]           inet6 addr: 3ffe:b80:c84:8200:280:c8ff:fecf:bf06/64 Scope:Global
]           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
]           RX packets:164532 errors:1 dropped:0 overruns:0 frame:0
]           TX packets:24261 errors:3 dropped:0 overruns:0 carrier:3
]           collisions:6352 txqueuelen:100 
]           RX bytes:20567703 (19.6 Mb)  TX bytes:14418737 (13.7 Mb)
]           Interrupt:9 Base address:0xa000 

	Should that third ping6 (the link local) worked just as well
as the first two?  I noticed that the link local mask is /10 unlike
the other two which are /64.  Since router advertisements and
solicitation is all mandated to work through the link locals, the
addresses themselves must be working correctly.  Are they merely not
being allowed up to the application space level?

> > Did you mean 2000::/3 (first two bits zero, next bit 1)?  That would
> > also cover both the 6bone and production allocations under a slightly
> > tighter mask.  The /2 would cover :: through 3fff: but the /3
> > would cover 2000: through 3fff:.  Any reaon why we should care about
> > the ::/3 band (:: through 1fff:)?

> yes, because it does not maks the link and site local prefix starting with
> FE and FF (like fe80::/10)

	Yeah, I understood that...  We only want to route addresses with
the upper bit zero.  I was just wondering about the /2 vs /3 and the 2000::
you had specified.

> >        Does that imply ipv6 only or does that include ipv4 on those
> > tcp6 listens? 

> well, depends on the kernel we are talking about. I plan to have tcp,tcp46
> and tcp6 (of course udp and icmp, too) entries, like BSD has.

> >        I'm not sure I like the tcp6, since it's not tcp that's
> > changed, just the ip layer underneath it.  I assume you would also
> > have udp6 as well?

> yes

> >        Hmmm...  Just be careful not to break too many scripts.  Freenet6
> > has a template script with their tsp package that, I think, tries to do
> > some parsing on that stuff.  That script is also broken due to the
> > default route sillyness, and I'm going to let them know to change their
> > route add from ::/0 to a route add for something between ::/1 and 2000::/3
> > (season to taste) to get the default routes working properly.

> tspc works fine for me, but you are right breaking scripts is a bit ugly.
> Well on the other hand, it wil lalso unbreak some bsd scripts :)

	:->

	tspc works fine for me, too, other than the broken add route for
::/0 when I'm requesting a /48.  :->  I just want to make sure I keep
it that way.  >;->=>

> Greetings
> Bernd

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
