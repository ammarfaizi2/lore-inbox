Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132719AbRDQPWA>; Tue, 17 Apr 2001 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132717AbRDQPVu>; Tue, 17 Apr 2001 11:21:50 -0400
Received: from mailhost3.lanl.gov ([128.165.3.9]:18738 "EHLO
	mailhost3.lanl.gov") by vger.kernel.org with ESMTP
	id <S132710AbRDQPVj>; Tue, 17 Apr 2001 11:21:39 -0400
Message-ID: <3ADC5F81.2B13CE5D@lanl.gov>
Date: Tue, 17 Apr 2001 09:21:37 -0600
From: Eric Weigle <ehw@lanl.gov>
Organization: CCS-1 RADIANT team
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, es-ES, ex-MX, fr-FR, fr-CA
MIME-Version: 1.0
To: Sampsa Ranta <sampsa@netsonic.fi>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Broken ARP (was Re: ARP responses broken!)
In-Reply-To: <Pine.LNX.4.33.0104171649480.21178-100000@nalle.netsonic.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I was ignorant of the arp filter functionality in 2.2. I found an old
(probably painfully out-of-date) posting the patch Andi Kleen was referring to
in the archive, but I've not used it.
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.2/1198.html

> I tought this for a while and this does not help load sharing neighter or
> fault tolerance. Causes problem with router environment. I use different
> cards to load the problem by assigning different addresses to these and by
> pointing these addresses with routes so I use the IP to mark a device.
> 
> Only case where this would help with "fault tolerance" is if I
> assign address to other device that is not marked as up, it would still
> be possible to see the address via other device, and this goes way off.

Indeed, the default behavior does cause problems in a router environment, but
this only happens when multiple nics are on the same subnet; in a 'true' router
each nic would be on a separate subnet. Regardless, I personally use FreeBSD
when I need a router (Horrors! ;)

What I meant by load sharing was implicit sharing rather than explicit sharing;
when an ARP request comes the reply the host gets may have the MAC address of
NICs other than the one explicitly bound to the given IP-- thus different hosts
will semi-randomly get different MAC addresses and thus send to different NICs;
this implicit sharing completely hoses explicit load sharing.

And as for fault tolerance, here's what happened to me, as I mentioned in
another message: We have a 8-node cluster with 2 nics, a eepro and a gig-e
acenic in each node. A while back the acenic driver had some problems and would
silently fail after a while; the arp reponse behavior allowed the cluster to
remain 'up' long enough to finish the jobs we assigned to it (although
performance sucked since all traffic went over the eepros). After we were done,
we could ifdown/ifup the interfaces and all was good. Again, this is a sort of
'implicit' fault tolerance, rather than a more explicit form where the card goes
down, we get some sort of notification, and it fails over to the other card
explicitly.

> The code I used to do the trick at my network was as simple as this,
> in function arp_rcv, the problem is ip_dev_find that does know if there
> are other devices with same IP address.
Well, Yes, but that's not really the issue. The problem is 'what is the proper
*default* behavior of the Linux ARP subsystem'... this code changes it, which is
probably more of a political than technical decision. Where you (and I) see
'broken' others see 'feature' :/

-Eric

--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
