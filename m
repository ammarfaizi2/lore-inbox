Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUIBQ6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUIBQ6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268714AbUIBQ6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:58:44 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:64930 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S268704AbUIBQ6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:58:40 -0400
From: Einar Lueck <elueck@de.ibm.com>
Reply-To: lkml@einar-lueck.de
Organization: IBM Deutschland Entwicklung GmbH
To: Paul Jakma <paul@clubi.ie>
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Date: Thu, 2 Sep 2004 18:58:38 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409011441.10154.elueck@de.ibm.com> <Pine.LNX.4.61.0409011852380.2441@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0409011852380.2441@fogarty.jakma.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021858.38338.elueck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apologize: I fear I have not specified the setups we address 
precisely enough: I think it helps to imagine the following scenario:
1. SERVER1 mounts some NFS stuff exported by SERVER2.
2. SERVER1 has two NICs.
3. The souce IP address of the related packets is the IP address 
of the NIC the kernel identifies for the outbound route, or the IP 
address specified via a static route (ip route .... src SVIPA)
4. In case no static routes are allowed and iptables NAT is no 
option, the relevant packets thus have the IP of a NIC.
5. In case the corresponding NIC dies, we have a serious problem.

On Donnerstag, 2. September 2004 18:22 Paul Jakma wrote:
> On Wed, 1 Sep 2004, Einar Lueck wrote:
> 
> > The following small patch (applies to BK head) addresses issues relevant for transparent NIC failover (especially in case of NFS). It allows to configure on a per device basis via sysctl an IP address (Source Virtual IP Address - Source VIPA) that is set as IP source address for all connections for which no bind has been applied. ?To allow for NIC failover one then just needs:
> 
> > 1. A dummy-Device set up with the Source VIPA
> 
> Why cant you use loopback as the placeholder interface for the VIPA 
> IP?

This is works of course, too. But it does not solve the problem described 
above. But, maybe I misunderstood you. Please correct me, if I am wrong.

> 
> > 2. Outbound routes via both/all redundant NICs for the relevant 
> > packets (more precisely: dynamic routing with for example ZEBRA)
> 
> # telnet localhost zebra
> ...
> host# en
> host(config)# in lo
> host(config-if)# ip address <desired address>/32
> host(config-if)# end
> host# wri fi
> 
> hey presto, "virtual IP" which you can redistribute connected in 
> ospfd/ripd whatever and publish in DNS.

I think this is the same as the first point.

> 
> > The reason for the development of this patch is that the 
> > alternatives we thought of have serious limitations for the 
> > intended usage scenarios:
> 
> > 1. A User space tool intercepting connects and issuing binds 
> > (configuration on a per application basis) (refer to: 
> > http://oss.software.ibm.com/linux390/useful_add-ons_vipa.shtml) 
> > This approach does not allow for NFS failover which we consider to 
> > be a very important use case because NFS works in kernel.
> 
> What problems did you ahve?

NFS works in kernel. Therefore we could not intercept the corresponding
"connect" calls. As a result, the problem scenario described above could 
not be solved.

> 
> TCP responses to requests that come in addressed to the virtual IP 
> will automatically have source of that virtual IP. For UDP too if app 
> binds to the virtual IP or uses IP_HDRINCL. Not sure about kernel UDP 
> though, but I bet linux-nfs list would be amienable to any changes 
> needed for knfsd to work nicely with virtual/loopback IPs.

You are right, but the packets do not come in, they go out, as I tried to 
illustrate above. Anyway, in the other case you are completely right.

> 
> > 4. NIC bonding
> 
> > There is a strong dependence on the switches' timeout for the 
> > IP/MAC pair. In addition to that, as far as we know not all NICs 
> > support bonding with failover.
> 
> How does bonding come into it?

Bonding offers a failover facility. For more details, please refer to:
Documentation/networking/bonding.txt in the kernel tree.

Regards
Einar
