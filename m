Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSH0QEf>; Tue, 27 Aug 2002 12:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSH0QEe>; Tue, 27 Aug 2002 12:04:34 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:1414 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S316500AbSH0QEX>; Tue, 27 Aug 2002 12:04:23 -0400
Date: Tue, 27 Aug 2002 12:07:22 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
Message-ID: <20020827160722.GA13412@alcove.wittsend.com>
Mail-Followup-To: Bernd Eckenfels <ecki@lina.inka.de>,
	linux-kernel@vger.kernel.org
References: <20020821220313.GA25141@lina.inka.de> <Pine.LNX.4.44.0208261149170.6621-100000@betelgeuse.compendium-tech.com> <20020826215123.GA22750@alcove.wittsend.com> <20020826234804.GA13520@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020826234804.GA13520@lina.inka.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 01:48:04AM +0200, Bernd Eckenfels wrote:
> On Mon, Aug 26, 2002 at 05:51:23PM -0400, Michael H. Warfield wrote:
> > 	My only other annoynance right now is the default ip6 route on my
> > ipv6 router (RedHat 7.3).  It's not working (or doesn't seem to be)!  I
> > have a 6bone allocation from Freenet6 (3ffe:b80:c84::/48) with about a
> > half a dozen SLA subnets and several routers.  If I assign a default route
> > (::/0) on the main router back down my Freenet6 tunnel, weird things happen.

> the linux kernel does ignore the ::/0 route if it is in forwarding not, I
                                                                     ^^^
                                                                    mode?
> guess this is since it is asumed, that the user knows what he is doing and
> does not want to do that. You can use 2000::/2 instead.

	It's ignoring something because it's assuming the user knows
what he's doing and not wanting it to do that?  Does not compute.  I
installed the route.  If I know what I'm doing, why would I want it to
ignore the route that I installed?  I think I prefer to have it do what
I tell it to and not what it thinks I want it to do.

	Is that a typo where you wrote 2000::/2?  Isn't 2000::/2 the same
as ::/2 (the upper two bits are zero)?  Both would be equivalent and both
would cover both the 6bone (3ffe::/16) and production (2001::/16) TLAs.
Did you mean 2000::/3 (first two bits zero, next bit 1)?  That would
also cover both the 6bone and production allocations under a slightly
tighter mask.  The /2 would cover :: through 3fff: but the /3
would cover 2000: through 3fff:.  Any reaon why we should care about
the ::/3 band (:: through 1fff:)?

> > This has been noticed and mentioned by others on the 6bone and freenet6
> > lists.  Seems to be peculiar to Linux.

> it is by intention, yes.

	It's confusing.  It introduces unexpected behavior (behavior
dependent on other influences) and is, AFAIK, inconsistent with other
implimentations (Solaris, BSD, Windows, etc...).

> > 	The default routers on the leaf workstations (autoconfigured from
> > router advertisements) seem to work fine though.

> yes it deoeds on the ipforward setting.

	Cool...  At least I understand why it's doing this and what it
depends on.  If that's the way it works, this needs to be documented
in bright glowing radioactive letters so it can't be missed.

> BTW: i am working a bit on net-tools and ipv6, like:

> calista:~# netstat -tl
> Active Internet connections (only servers)
> Proto Recv-Q Send-Q Local Address           Foreign Address         State
> tcp        0      0 *:1024                  *:*                     LISTEN
> tcp        0      0 *:5269                  *:*                     LISTEN
> ...
> tcp        0      0 calista.inka.de:domain  *:*                     LISTEN
> tcp6       0      0 *:auth                  *:*                     LISTEN
> tcp6       0      0 *:ssh                   *:*                     LISTEN
> tcp6       0      0 *:smtp                  *:*                     LISTEN


> i am not yet sure about the wildcard address and the port separator, but I
> like the tcp6 :)

	Does that imply ipv6 only or does that include ipv4 on those
tcp6 listens?  I assume that the "tcp" lines are v4 only.  If that's
true then the tcp6 lines should be the v6 only listens.  If that's
true, what do you get if it's listening on both (bind is very weird
here with some strange warnings)?  Would you get two entries?  One
for tcp and one for tcp6?

	I'm not sure I like the tcp6, since it's not tcp that's
changed, just the ip layer underneath it.  I assume you would also
have udp6 as well?

> ifconfig may get a more BSDish look, also:
> 
> # ./ifconfig
> eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500  metric 1
>         inet 10.0.0.3  netmask 255.255.255.0  broadcast 10.0.0.255
>         inet6 3ffe:400:4f0:ffff::3  prefixlen 112  scopeid 0x0<global>
>         inet6 fe80::2e0:7dff:fe92:1f0b  prefixlen 10  scopeid 0x20<link>
>         ether 00:e0:7d:92:1f:0b  txqueuelen 100  (Ethernet)
>         RX packets 2581434  bytes 1632512018 (1.5 GiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 2031678  bytes 1202569629 (1.1 GiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>         device interrupt 9  base 0x9000

	Hmmm...  Just be careful not to break too many scripts.  Freenet6
has a template script with their tsp package that, I think, tries to do
some parsing on that stuff.  That script is also broken due to the
default route sillyness, and I'm going to let them know to change their
route add from ::/0 to a route add for something between ::/1 and 2000::/3
(season to taste) to get the default routes working properly.

> Greetings
> Bernd

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
