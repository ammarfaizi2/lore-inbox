Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270942AbRH1V2i>; Tue, 28 Aug 2001 17:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271032AbRH1V23>; Tue, 28 Aug 2001 17:28:29 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:60378 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S270942AbRH1V2N>;
	Tue, 28 Aug 2001 17:28:13 -0400
Date: Tue, 28 Aug 2001 14:28:29 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Multicast
Message-ID: <20010828142829.F8147@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <87009604743AD411B1F600508BA0F95994CA6A@XOVER.dedham.mindspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87009604743AD411B1F600508BA0F95994CA6A@XOVER.dedham.mindspeed.com>; from mark.clayton@netplane.com on Tue, Aug 28, 2001 at 04:12:23PM -0400
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 04:12:23PM -0400, Clayton, Mark wrote:
> 
> I think this is what I recall doing: 	
> 
> socket(AF_INET, SOCK_DGRAM, 0);
> 
> setsockopt(SO_REUSEADDR)
> 
> if ((remote_addr & 0xF0000000) == 0xE0000000) then saddr.sin_addr.s_addr 
> is INADDR_ANY otherwise use local_addr.  Port is local_port
> bind(saddr);
> 
> ipMreq.imr_multiaddr.s_addr = htonl(multicast_addr);
> ipMreq.imr_address.s_addr   = htonl(local_addr);
> ipMreq.imr_ifindex          = if_index (from /sbin/ipmaddr)
> setsockopt(IP_ADD_MEMBERSHIP, ipMreq
> 
> /* mcast sends */
> ifAddr.s_addr = htonl(local_addr) 
> setsockopt(IP_MULTICAST_IF, ifAddr);
> 
> setsockopt(SIOCGIFNAME, if_index);
> 
> setsockopt(SO_BINDTODEVICE)
> 
> Also, I think that for SOCK_RAW there needs to be a second
> socket just for reading.  But I don't recall the details.
> 
> If this helps, feel free to post the details to the list
> in a summary.  Please remove references to me though.
> 
> Thanks,
> Mark


	I did my little investigation and looked int he kernel for
answers.

	I was already looking at SO_BINDTODEVICE. This is very
powerful, unfortunately, it's reserved for ROOT. Maybe running my
program as root is not the brightest idea.
	Also, one might wonder why IP_MULTICAST_IF doesn't set
sk->bound_dev_if itself, which would be logical (it only checks that
the interface is the same as sk->bound_dev_if but seem to forget to
set it in .../net/ipv4/sockglue.c).

	Anyway, doing this definitely fix the problem :
------------------------------------------
socket(AF_INET, SOCK_DGRAM, 0);
setsockopt(SO_BINDTODEVICE, ONE_INTERFACE);
bind(sock, INADDR_ANY, MY_PORT);
setsockopt(IP_ADD_MEMBERSHIP, INADDR_ALLHOSTS_GROUP, ONE_INTERFACE);
setsockopt(IP_MULTICAST_IF, ONE_INTERFACE);
------------------------------------------
	Works as advertised : you can have one and only one socket per
interface.

	Now, let's have a bit of fun... If you do :
------------------------------------------
socket(AF_INET, SOCK_DGRAM, 0);
bind(sock, INADDR_ANY, MY_PORT);
setsockopt(SO_BINDTODEVICE, ONE_INTERFACE);
setsockopt(IP_ADD_MEMBERSHIP, INADDR_ALLHOSTS_GROUP, ONE_INTERFACE);
setsockopt(IP_MULTICAST_IF, ONE_INTERFACE);
------------------------------------------
	In that case, the kernel let you open more than one socket per
interface (two, there...). I don't know if its intended, but it works
fine ;-)

	And you can also do this :
------------------------------------------
socket(AF_INET, SOCK_DGRAM, 0);
bind(sock, INADDR_ANY, MY_PORT);
setsockopt(IP_ADD_MEMBERSHIP, INADDR_ALLHOSTS_GROUP, ONE_INTERFACE);
setsockopt(IP_MULTICAST_IF, ONE_INTERFACE);
setsockopt(SO_BINDTODEVICE, ANOTHER_INTERFACE);
------------------------------------------
	This will send packet on ANOTHER_INTERFACE, but the source
address of those packet will be the one of ONE_INTERFACE.

	And if you look in .../net/core/sock.c, you will realise that
these two calls are handled very differently :
------------------------------------------
setsockopt(SO_BINDTODEVICE, "", 0);
setsockopt(SO_BINDTODEVICE, "", IFNAMSIZ);
------------------------------------------
	Which mean the man page need to be fixed ;-)

	Anyway, I don't really want to rely on SO_BINDTODEVICE,
because it needs ROOT capability.


	Now, you suggestions to use SO_REUSEADDR is spot on. It works
as any user. I get a little bit more than I bargained for (I want only
one socket per interface), but that's ok...
	In other words, this works :
------------------------------------------
socket(AF_INET, SOCK_DGRAM, 0);
setsockopt(SO_REUSEADDR, 1);
bind(sock, INADDR_ANY, MY_PORT);
setsockopt(IP_ADD_MEMBERSHIP, INADDR_ALLHOSTS_GROUP, ONE_INTERFACE);
setsockopt(IP_MULTICAST_IF, ONE_INTERFACE);
------------------------------------------
	With one little caveat : such socket seems to receive
multicast comming from all interfaces. In other words, it seem that
IP_MULTICAST_IF only act on the outgoing path.
	In other words, IP_MULTICAST_IF doesn't do much... At least,
much less that what you would believe it to do...

	Also, using both SO_BINDTODEVICE and SO_REUSEADDR may be
overkill...

	That's it...

	Jean
