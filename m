Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268538AbUIBQWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268538AbUIBQWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268568AbUIBQWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:22:16 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:4740 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S268538AbUIBQWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:22:13 -0400
Date: Thu, 2 Sep 2004 17:22:01 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: lkml@einar-lueck.de
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
In-Reply-To: <200409011441.10154.elueck@de.ibm.com>
Message-ID: <Pine.LNX.4.61.0409011852380.2441@fogarty.jakma.org>
References: <200409011441.10154.elueck@de.ibm.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004, Einar Lueck wrote:

> The following small patch (applies to BK head) addresses issues relevant for transparent NIC failover (especially in case of NFS). It allows to configure on a per device basis via sysctl an IP address (Source Virtual IP Address - Source VIPA) that is set as IP source address for all connections for which no bind has been applied. ?To allow for NIC failover one then just needs:

> 1. A dummy-Device set up with the Source VIPA

Why cant you use loopback as the placeholder interface for the VIPA 
IP?

> 2. Outbound routes via both/all redundant NICs for the relevant 
> packets (more precisely: dynamic routing with for example ZEBRA)

# telnet localhost zebra
...
host# en
host(config)# in lo
host(config-if)# ip address <desired address>/32
host(config-if)# end
host# wri fi

hey presto, "virtual IP" which you can redistribute connected in 
ospfd/ripd whatever and publish in DNS.

> The reason for the development of this patch is that the 
> alternatives we thought of have serious limitations for the 
> intended usage scenarios:

> 1. A User space tool intercepting connects and issuing binds 
> (configuration on a per application basis) (refer to: 
> http://oss.software.ibm.com/linux390/useful_add-ons_vipa.shtml) 
> This approach does not allow for NFS failover which we consider to 
> be a very important use case because NFS works in kernel.

What problems did you ahve?

> 2. ip route xxx.xxx.xxx.xxx/xx src SourceVIPA OSPF, etc. do not 
> support automatic setup of and discovery of desired source 
> addresses.

ip route add default via <gateway> src <virtual ip>

Having zebra be able to apply route-maps to routes and set src would 
be useful too.

But why do you need this even? See below about replies. Just publish 
the virtual IP in DNS, not the interface addresses.

> As a consequence one would have to configure static routes for all 
> use cases which is not desirable in complex routing scenarios and 
> especially in presence of dynamic routing. 3. netfilter ((S)NAT) 
> NAT takes place after routing is applied and an IP address (e.g. IP 
> of the output NIC) has been set for a packet. Consequently, 
> returned packets are routed to the original IP address. As a result 
> no failover is possible.

TCP responses to requests that come in addressed to the virtual IP 
will automatically have source of that virtual IP. For UDP too if app 
binds to the virtual IP or uses IP_HDRINCL. Not sure about kernel UDP 
though, but I bet linux-nfs list would be amienable to any changes 
needed for knfsd to work nicely with virtual/loopback IPs.

> 4. NIC bonding

> There is a strong dependence on the switches' timeout for the 
> IP/MAC pair. In addition to that, as far as we know not all NICs 
> support bonding with failover.

How does bonding come into it?

> I hope I described the overall use case comprehensible enough to 
> clarify why we consider this patch as very useful and important.
>
> Einar Lueck

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
<<<<< EVACUATION ROUTE <<<<<
